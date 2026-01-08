Return-Path: <linux-fsdevel+bounces-72694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E345FD0079A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B26302517B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3961D5ADE;
	Thu,  8 Jan 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1CvOHNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CE32C8B;
	Thu,  8 Jan 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832822; cv=none; b=fWigMnjKZKVWJ7LaVCocZKQEnl8Sli7s0Hj2urnJHdC3X+yOo1nKTZo8BMyapWeZeF2bZaNJhNWa8P0SX+Drw8KTewnEuU0f1WYIvuxSYmv/Jn8X4aletjKefWazlrHNfPulEqNg4YkGdO3bk/9Q2e+JmhS+x9dG9jdhDQV6NSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832822; c=relaxed/simple;
	bh=QUiJI4hlyz9uDfK1TM2Dt6VRw3/bpRLO6BWo10GWE8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ1tlaPGswXvG2NeKONPaNJ55+CQYhQh6UZ1RJ683n0ER8Fy7nun/DpHIFdgHfhuKehe5U3WsXFYopewwfEZF/TI0wmaucS3zAKoy6+/ZwEIir9bnby/hqQwT9ulvOT1eIp+f7u7alzyR5WXK87rDjqSFJslmnklj8e0qiWP+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1CvOHNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC14C19421;
	Thu,  8 Jan 2026 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832822;
	bh=QUiJI4hlyz9uDfK1TM2Dt6VRw3/bpRLO6BWo10GWE8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1CvOHNVAyLx7VLtbIUC4q0JlBGZB28ey2w++fUGpty14P2nQ4RIAltz9Vsl3HH09
	 OWONg/0wB5xjEBE9n3S1Q3zifR0vvaxP6aNyLAi0eAboHBjZOktZyNpyk1EY+e4BbX
	 nw3z9PChpgvZQoIgNYTEH/z/8h3iQ910l+9VGCD0kreYzFMxtZA+CCIR37qJnd3/pI
	 lFPzD0yv82e9AoAWGr3MAM9FKWhQogdmrondSP2qK6UqAVLy2JP/bs6XoqbxIJp64P
	 YGqxyJ2z2sYWnJBl3XbqNnW/BmfdwjzH0hVnb/+Wkn2s7HqMwY/Zj2vIiPbfuWaigA
	 8Xfjl3sy32CNg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 1/6] nfsd: cancel async COPY operations when admin revokes filesystem state
Date: Wed,  7 Jan 2026 19:40:11 -0500
Message-ID: <20260108004016.3907158-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004016.3907158-1-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Async COPY operations hold copy stateids that represent NFSv4 state.
Thus, when the NFS server administrator revokes all NFSv4 state for
a filesystem via the unlock_fs interface, ongoing async COPY
operations referencing that filesystem must also be canceled.

Each cancelled copy triggers a CB_OFFLOAD callback carrying the
NFS4ERR_ADMIN_REVOKED status to notify the client that the server
terminated the operation.

The static drop_client() function is renamed to nfsd4_put_client()
and exported. The function must be exported because both the new
nfsd4_cancel_copy_by_sb() and the CB_OFFLOAD release callback in
nfs4proc.c need to release client references.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 124 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c |  20 ++++---
 fs/nfsd/nfsctl.c    |   1 +
 fs/nfsd/state.h     |   2 +
 fs/nfsd/xdr4.h      |   1 +
 5 files changed, 130 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2b805fc51262..e7ec87b6c331 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1427,14 +1427,26 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 	kfree(copy);
 }
 
+static void release_copy_files(struct nfsd4_copy *copy);
+
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
 	trace_nfsd_copy_async_cancel(copy);
 	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
 		kthread_stop(copy->copy_task);
-		copy->nfserr = nfs_ok;
+		if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
+			copy->nfserr = nfs_ok;
 		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	}
+
+	/*
+	 * The copy was removed from async_copies before this function
+	 * was called, so the reaper cannot clean it up. Release files
+	 * here regardless of who won the STOPPED race. If the thread
+	 * set STOPPED, it has finished using the files. If STOPPED
+	 * was set here, kthread_stop() waited for the thread to exit.
+	 */
+	release_copy_files(copy);
 	nfs4_put_copy(copy);
 }
 
@@ -1462,6 +1474,72 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
 	while ((copy = nfsd4_unhash_copy(clp)) != NULL)
 		nfsd4_stop_copy(copy);
 }
+
+static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
+			     const struct super_block *sb)
+{
+	if (copy->nf_src &&
+	    file_inode(copy->nf_src->nf_file)->i_sb == sb)
+		return true;
+	if (copy->nf_dst &&
+	    file_inode(copy->nf_dst->nf_file)->i_sb == sb)
+		return true;
+	return false;
+}
+
+/**
+ * nfsd4_cancel_copy_by_sb - cancel async copy operations on @sb
+ * @net: net namespace containing the copy operations
+ * @sb: targeted superblock
+ */
+void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfsd4_copy *copy, *tmp;
+	struct nfs4_client *clp;
+	unsigned int idhashval;
+	LIST_HEAD(to_cancel);
+
+	spin_lock(&nn->client_lock);
+	for (idhashval = 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
+		struct list_head *head = &nn->conf_id_hashtbl[idhashval];
+
+		list_for_each_entry(clp, head, cl_idhash) {
+			spin_lock(&clp->async_lock);
+			list_for_each_entry_safe(copy, tmp,
+						 &clp->async_copies, copies) {
+				if (nfsd4_copy_on_sb(copy, sb)) {
+					refcount_inc(&copy->refcount);
+					/*
+					 * Hold a reference on the client while
+					 * nfsd4_stop_copy() runs. Unlike
+					 * nfsd4_unhash_copy(), cp_clp is not
+					 * NULLed here because nfsd4_send_cb_offload()
+					 * needs a valid client to send CB_OFFLOAD.
+					 * That function takes its own reference to
+					 * survive callback flight.
+					 */
+					kref_get(&clp->cl_nfsdfs.cl_ref);
+					copy->nfserr = nfserr_admin_revoked;
+					set_bit(NFSD4_COPY_F_CB_ERROR,
+						&copy->cp_flags);
+					list_move(&copy->copies, &to_cancel);
+				}
+			}
+			spin_unlock(&clp->async_lock);
+		}
+	}
+	spin_unlock(&nn->client_lock);
+
+	list_for_each_entry_safe(copy, tmp, &to_cancel, copies) {
+		struct nfs4_client *clp = copy->cp_clp;
+
+		list_del_init(&copy->copies);
+		nfsd4_stop_copy(copy);
+		nfsd4_put_client(clp);
+	}
+}
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 
 extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
@@ -1751,6 +1829,7 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
 
 	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
+	nfsd4_put_client(cb->cb_clp);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -1870,10 +1949,14 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 
 static void release_copy_files(struct nfsd4_copy *copy)
 {
-	if (copy->nf_src)
+	if (copy->nf_src) {
 		nfsd_file_put(copy->nf_src);
-	if (copy->nf_dst)
+		copy->nf_src = NULL;
+	}
+	if (copy->nf_dst) {
 		nfsd_file_put(copy->nf_dst);
+		copy->nf_dst = NULL;
+	}
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
@@ -1892,18 +1975,34 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 {
 	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
+	struct nfs4_client *clp = copy->cp_clp;
+
+	/*
+	 * cp_clp is NULL when called via nfsd4_shutdown_copy() during
+	 * client destruction. Skip the callback; the client is gone.
+	 */
+	if (!clp) {
+		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
+		return;
+	}
 
 	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
 	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
 	cbo->co_nfserr = copy->nfserr;
 	cbo->co_retries = 5;
 
-	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
+	/*
+	 * Hold a reference on the client while the callback is in flight.
+	 * Released in nfsd4_cb_offload_release().
+	 */
+	kref_get(&clp->cl_nfsdfs.cl_ref);
+
+	nfsd4_init_cb(&cbo->co_cb, clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	nfsd41_cb_referring_call(&cbo->co_cb, &cbo->co_referring_sessionid,
 				 cbo->co_referring_slotid,
 				 cbo->co_referring_seqno);
-	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
+	trace_nfsd_cb_offload(clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, copy->nfserr);
 	nfsd4_try_run_cb(&cbo->co_cb);
 }
@@ -1918,6 +2017,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
+	__be32 nfserr = nfs_ok;
 
 	trace_nfsd_copy_async(copy);
 	if (nfsd4_ssc_is_inter(copy)) {
@@ -1928,23 +2028,25 @@ static int nfsd4_do_async_copy(void *data)
 		if (IS_ERR(filp)) {
 			switch (PTR_ERR(filp)) {
 			case -EBADF:
-				copy->nfserr = nfserr_wrong_type;
+				nfserr = nfserr_wrong_type;
 				break;
 			default:
-				copy->nfserr = nfserr_offload_denied;
+				nfserr = nfserr_offload_denied;
 			}
 			/* ss_mnt will be unmounted by the laundromat */
 			goto do_callback;
 		}
-		copy->nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
-					     false);
+		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
+				       false);
 		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
 	} else {
-		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
-					     copy->nf_dst->nf_file, false);
+		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+				       copy->nf_dst->nf_file, false);
 	}
 
 do_callback:
+	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
+		copy->nfserr = nfserr;
 	/* The kthread exits forthwith. Ensure that a subsequent
 	 * OFFLOAD_CANCEL won't try to kill it again. */
 	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4fc94f2de7ba..1efab85c647d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2416,7 +2416,13 @@ static void __free_client(struct kref *k)
 	kmem_cache_free(client_slab, clp);
 }
 
-static void drop_client(struct nfs4_client *clp)
+/**
+ * nfsd4_put_client - release a reference on an nfs4_client
+ * @clp: the client to be released
+ *
+ * When the last reference is released, the client is freed.
+ */
+void nfsd4_put_client(struct nfs4_client *clp)
 {
 	kref_put(&clp->cl_nfsdfs.cl_ref, __free_client);
 }
@@ -2438,7 +2444,7 @@ free_client(struct nfs4_client *clp)
 		clp->cl_nfsd_dentry = NULL;
 		wake_up_all(&expiry_wq);
 	}
-	drop_client(clp);
+	nfsd4_put_client(clp);
 }
 
 /* must be called under the client_lock */
@@ -2839,7 +2845,7 @@ static int client_info_show(struct seq_file *m, void *v)
 	spin_unlock(&clp->cl_lock);
 	seq_puts(m, "\n");
 
-	drop_client(clp);
+	nfsd4_put_client(clp);
 
 	return 0;
 }
@@ -3105,7 +3111,7 @@ static int client_states_open(struct inode *inode, struct file *file)
 
 	ret = seq_open(file, &states_seq_ops);
 	if (ret) {
-		drop_client(clp);
+		nfsd4_put_client(clp);
 		return ret;
 	}
 	s = file->private_data;
@@ -3119,7 +3125,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 	struct nfs4_client *clp = m->private;
 
 	/* XXX: alternatively, we could get/drop in seq start/stop */
-	drop_client(clp);
+	nfsd4_put_client(clp);
 	return seq_release(inode, file);
 }
 
@@ -3175,7 +3181,7 @@ static ssize_t client_ctl_write(struct file *file, const char __user *buf,
 	if (!clp)
 		return -ENXIO;
 	force_expire_client(clp);
-	drop_client(clp);
+	nfsd4_put_client(clp);
 	return 7;
 }
 
@@ -3210,7 +3216,7 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 
-	drop_client(clp);
+	nfsd4_put_client(clp);
 }
 
 static int
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 64da7e731fe7..30caefb2522f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -288,6 +288,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 2.  Is that directory a mount point, or
 	 * 3.  Is that directory the root of an exported file system?
 	 */
+	nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 037f4ccd2e87..e415b8200fff 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -825,6 +825,8 @@ static inline void nfsd4_try_run_cb(struct nfsd4_callback *cb)
 
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
+void nfsd4_put_client(struct nfs4_client *clp);
+void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..1be2814b5288 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -732,6 +732,7 @@ struct nfsd4_copy {
 #define NFSD4_COPY_F_COMMITTED		(3)
 #define NFSD4_COPY_F_COMPLETED		(4)
 #define NFSD4_COPY_F_OFFLOAD_DONE	(5)
+#define NFSD4_COPY_F_CB_ERROR		(6)
 
 	/* response */
 	__be32			nfserr;
-- 
2.52.0


