Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9868A1FD5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEPBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:33118 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8652849E0; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 09/12] nfsd4: add file to display list of client's opens
Date:   Wed, 15 May 2019 21:20:16 -0400
Message-Id: <1557969619-17157-12-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Add a nfsd/clients/#/opens file to list some information about all the
opens held by the given client, including open modes, device numbers,
inode numbers, and open owners.

Open owners are totally opaque but seem to sometimes have some useful
ascii strings included, so passing through printable ascii characters
and escaping the rest seems useful while still being machine-readable.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 149 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 876c035d2a91..4025b3c692fd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -685,7 +685,8 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&cl->cl_lock);
-	new_id = idr_alloc_cyclic(&cl->cl_stateids, stid, 0, 0, GFP_NOWAIT);
+	/* Reserving 0 for start of file in nfsdfs "states" file: */
+	new_id = idr_alloc_cyclic(&cl->cl_stateids, stid, 1, 0, GFP_NOWAIT);
 	spin_unlock(&cl->cl_lock);
 	idr_preload_end();
 	if (new_id < 0)
@@ -2241,9 +2242,153 @@ static const struct file_operations client_info_fops = {
 	.release	= single_release,
 };
 
+static void *states_start(struct seq_file *s, loff_t *pos)
+	__acquires(&clp->cl_lock)
+{
+	struct nfs4_client *clp = s->private;
+	unsigned long id = *pos;
+	void *ret;
+
+	spin_lock(&clp->cl_lock);
+	ret = idr_get_next_ul(&clp->cl_stateids, &id);
+	*pos = id;
+	return ret;
+}
+
+static void *states_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct nfs4_client *clp = s->private;
+	unsigned long id = *pos;
+	void *ret;
+
+	id = *pos;
+	id++;
+	ret = idr_get_next_ul(&clp->cl_stateids, &id);
+	*pos = id;
+	return ret;
+}
+
+static void states_stop(struct seq_file *s, void *v)
+	__releases(&clp->cl_lock)
+{
+	struct nfs4_client *clp = s->private;
+
+	spin_unlock(&clp->cl_lock);
+}
+
+static void nfs4_show_superblock(struct seq_file *s, struct file *f)
+{
+	struct inode *inode = file_inode(f);
+
+	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
+					MAJOR(inode->i_sb->s_dev),
+					 MINOR(inode->i_sb->s_dev),
+					 inode->i_ino);
+}
+
+static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
+{
+	seq_printf(s, "owner: ");
+	seq_quote_mem(s, oo->so_owner.data, oo->so_owner.len);
+}
+
+static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
+{
+	struct nfs4_ol_stateid *ols;
+	struct nfs4_file *nf;
+	struct file *file;
+	struct nfs4_stateowner *oo;
+	unsigned int access, deny;
+
+	if (st->sc_type != NFS4_OPEN_STID && st->sc_type != NFS4_LOCK_STID)
+		return 0; /* XXX: or SEQ_SKIP? */
+	ols = openlockstateid(st);
+	oo = ols->st_stateowner;
+	nf = st->sc_file;
+	file = find_any_file(nf);
+
+	seq_printf(s, "- 0x%16phN: { type: open, ", &st->sc_stateid);
+
+	access = bmap_to_share_mode(ols->st_access_bmap);
+	deny   = bmap_to_share_mode(ols->st_deny_bmap);
+
+	seq_printf(s, "access: \%s\%s, ",
+		access & NFS4_SHARE_ACCESS_READ ? "r" : "-",
+		access & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
+	seq_printf(s, "deny: \%s\%s, ",
+		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
+		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
+
+	nfs4_show_superblock(s, file);
+	seq_printf(s, ", ");
+	nfs4_show_owner(s, oo);
+	seq_printf(s, " }\n");
+
+	fput(file);
+
+	return 0;
+}
+
+static int states_show(struct seq_file *s, void *v)
+{
+	struct nfs4_stid *st = v;
+
+	switch (st->sc_type) {
+	case NFS4_OPEN_STID:
+		return nfs4_show_open(s, st);
+	default:
+		return 0; /* XXX: or SEQ_SKIP? */
+	}
+}
+
+static struct seq_operations states_seq_ops = {
+	.start = states_start,
+	.next = states_next,
+	.stop = states_stop,
+	.show = states_show
+};
+
+static int client_states_open(struct inode *inode, struct file *file)
+{
+	struct nfsdfs_client *nc;
+	struct seq_file *s;
+	struct nfs4_client *clp;
+	int ret;
+
+	nc = get_nfsdfs_client(inode);
+	if (!nc)
+		return -ENXIO;
+	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
+
+	ret = seq_open(file, &states_seq_ops);
+	if (ret)
+		return ret;
+	s = file->private_data;
+	s->private = clp;
+	return 0;
+}
+
+static int client_opens_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct nfs4_client *clp = m->private;
+
+	/* XXX: alternatively, we could get/drop in seq start/stop */
+	drop_client(clp);
+	return 0;
+}
+
+static const struct file_operations client_states_fops = {
+	.open		= client_states_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= client_opens_release,
+};
+
 static const struct tree_descr client_files[] = {
 	[0] = {"info", &client_info_fops, S_IRUSR},
-	[1] = {""},
+	[1] = {"states", &client_states_fops, S_IRUSR},
+	[3] = {""},
 };
 
 static struct nfs4_client *create_client(struct xdr_netobj name,
-- 
2.21.0

