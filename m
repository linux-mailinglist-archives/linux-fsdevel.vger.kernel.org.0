Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542851FD67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfEPBq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:29 -0400
Received: from fieldses.org ([173.255.197.46]:33124 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfEPBWZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:25 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 91DDEBCE; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 12/12] nfsd: allow forced expiration of NFSv4 clients
Date:   Wed, 15 May 2019 21:20:19 -0400
Message-Id: <1557969619-17157-15-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

NFSv4 clients are automatically expired and all their locks removed if
they don't contact the server for a certain amount of time (the lease
period, 90 seconds by default).

There can still be situations where that's not enough, so allow
userspace to force expiry by writing "expire\n" to the new
nfsd/client/#/ctl file.

(The generic "ctl" name is because I expect we may want to allow other
operations on clients in the future.)

The write will not return until the client is expired and all of its
locks and other state removed.

The fault injection code also provides a way of expiring clients, but it
fails if there are any in-progress RPC's referencing the client.  Also,
its method of selecting a client to expire is a little more
primitive--it uses an IP address, which can't always uniquely specify an
NFSv4 client.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 91 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e36c6e64e448..5ef27e9cbed3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -99,6 +99,13 @@ enum nfsd4_st_mutex_lock_subclass {
  */
 static DECLARE_WAIT_QUEUE_HEAD(close_wq);
 
+/*
+ * A waitqueue where a writer to clients/#/ctl destroying a client can
+ * wait for cl_rpc_users to drop to 0 and then for the client to be
+ * unhashed.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(expiry_wq);
+
 static struct kmem_cache *client_slab;
 static struct kmem_cache *openowner_slab;
 static struct kmem_cache *lockowner_slab;
@@ -174,6 +181,8 @@ static void put_client_renew_locked(struct nfs4_client *clp)
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
+	else
+		wake_up_all(&expiry_wq);
 }
 
 static void put_client_renew(struct nfs4_client *clp)
@@ -184,6 +193,8 @@ static void put_client_renew(struct nfs4_client *clp)
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
+	else
+		wake_up_all(&expiry_wq);
 	spin_unlock(&nn->client_lock);
 }
 
@@ -1900,8 +1911,11 @@ free_client(struct nfs4_client *clp)
 		free_session(ses);
 	}
 	rpc_destroy_wait_queue(&clp->cl_cb_waitq);
-	if (clp->cl_nfsd_dentry)
+	if (clp->cl_nfsd_dentry) {
 		nfsd_client_rmdir(clp->cl_nfsd_dentry);
+		clp->cl_nfsd_dentry = NULL;
+		wake_up_all(&expiry_wq);
+	}
 	drop_client(clp);
 }
 
@@ -1996,6 +2010,7 @@ __destroy_client(struct nfs4_client *clp)
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	free_client(clp);
+	wake_up_all(&expiry_wq);
 }
 
 static void
@@ -2195,6 +2210,15 @@ find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
 	return s;
 }
 
+static struct nfs4_client *get_nfsdfs_clp(struct inode *inode)
+{
+	struct nfsdfs_client *nc;
+	nc = get_nfsdfs_client(inode);
+	if (!nc)
+		return NULL;
+	return container_of(nc, struct nfs4_client, cl_nfsdfs);
+}
+
 static void seq_escape_quotable_mem(struct seq_file *m, char *data, int len)
 {
 	/* List taken from kstrdup_quotable: */
@@ -2211,14 +2235,12 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct nfsdfs_client *nc;
 	struct nfs4_client *clp;
 	u64 clid;
 
-	nc = get_nfsdfs_client(inode);
-	if (!nc)
+	clp = get_nfsdfs_clp(inode);
+	if (!clp)
 		return -ENXIO;
-	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: %llx\n", clid);
 	seq_printf(m, "address: %pISpc\n", (struct sockaddr *)&clp->cl_addr);
@@ -2429,15 +2451,13 @@ static struct seq_operations states_seq_ops = {
 
 static int client_states_open(struct inode *inode, struct file *file)
 {
-	struct nfsdfs_client *nc;
 	struct seq_file *s;
 	struct nfs4_client *clp;
 	int ret;
 
-	nc = get_nfsdfs_client(inode);
-	if (!nc)
+	clp = get_nfsdfs_clp(inode);
+	if (!clp)
 		return -ENXIO;
-	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 
 	ret = seq_open(file, &states_seq_ops);
 	if (ret)
@@ -2464,9 +2484,62 @@ static const struct file_operations client_states_fops = {
 	.release	= client_opens_release,
 };
 
+/*
+ * Normally we refuse to destroy clients that are in use, but here the
+ * administrator is telling us to just do it.  We also want to wait
+ * so the caller has a guarantee that the client's locks are gone by
+ * the time the write returns:
+ */
+void force_expire_client(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	bool already_expired;
+
+	spin_lock(&clp->cl_lock);
+	clp->cl_time = 0;
+	spin_unlock(&clp->cl_lock);
+
+	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
+	spin_lock(&nn->client_lock);
+	already_expired = list_empty(&clp->cl_lru);
+	if (!already_expired)
+		unhash_client_locked(clp);
+	spin_unlock(&nn->client_lock);
+
+	if (!already_expired)
+		expire_client(clp);
+	else
+		wait_event(expiry_wq, clp->cl_nfsd_dentry == NULL);
+}
+
+static ssize_t client_ctl_write(struct file *file, const char __user *buf,
+				   size_t size, loff_t *pos)
+{
+	char *data;
+	struct nfs4_client *clp;
+
+	data = simple_transaction_get(file, buf, size);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	if (size != 7 || 0 != memcmp(data, "expire\n", 7))
+		return -EINVAL;
+	clp = get_nfsdfs_clp(file_inode(file));
+	if (!clp)
+		return -ENXIO;
+	force_expire_client(clp);
+	drop_client(clp);
+	return 7;
+}
+
+static const struct file_operations client_ctl_fops = {
+	.write		= client_ctl_write,
+	.release	= simple_transaction_release,
+};
+
 static const struct tree_descr client_files[] = {
 	[0] = {"info", &client_info_fops, S_IRUSR},
 	[1] = {"states", &client_states_fops, S_IRUSR},
+	[2] = {"ctl", &client_ctl_fops, S_IRUSR|S_IWUSR},
 	[3] = {""},
 };
 
-- 
2.21.0

