Return-Path: <linux-fsdevel+bounces-50354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09906ACB0FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9663A3B10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E523C8D3;
	Mon,  2 Jun 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqZglaU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBD23C51A;
	Mon,  2 Jun 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872993; cv=none; b=ofpM07Eno1GlTqMh7NXVgT59TbyQxn3C8T7nZ7MWa3H6YG3VqjkJ1sIUSm5QByfVWbS3wB4H81sKCPqFQyvypDRQHRoYJe1MQzzwWs9r3GRWVciaNzD6Az+C0zJo3RV2OzzuS4SHaK2lL3io3yRw52chkxbOAepEanzQikuIx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872993; c=relaxed/simple;
	bh=RR9zI2aKCWvdTRzyv49hk1nm82KMFUT0MxbaFrGaC7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuHXXZ0OsDZyKPS/+7n67YT2Zg9QWRRjNqNNi12ejkR4F6tQe6c3h56GFrs4XXUZZ9c7tdfMfXLSxzhv8Ve2p1uMKijV5FTU6t12gE0NtI0Ecbzj8F0HVfwEWPDKUaeCufVDH8R8bPqyLckc9+Gj9X3jILmMM9rw3LC1nZ6s4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqZglaU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D067C4CEEB;
	Mon,  2 Jun 2025 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872993;
	bh=RR9zI2aKCWvdTRzyv49hk1nm82KMFUT0MxbaFrGaC7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uqZglaU7i+pa7/ltiNi0iAW7f7L88LLztwn/SJN/TPTMhS0fxQzUofnOkZZ921Vdy
	 FYNEW29oIDIQonZux3bhtHb+usPJqAaZDEcGc16Rn/hl3JVpN0vyN3503MbUj4wwWe
	 hHsSfNl8knRbYy5AKGF0jLemA9ApCCfRveypXxwFWnQWdbTYGmiqHz1Jx/jBIPkhm3
	 yYjkCOhGsYCEDFvtnYVRylajTo0PUAYqAIl+Bw6txajgVgWQET5zITThvbarqVR7w4
	 M7LgIWHKT3aql31SkVe0dNOC6RI0VGXuIdUHDAj8bkA45SjtKS+u8MRNwfLvGp855s
	 nM339wKIrnPfw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:07 -0400
Subject: [PATCH RFC v2 24/28] nfsd: add notification handlers for dir
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-24-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13567; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RR9zI2aKCWvdTRzyv49hk1nm82KMFUT0MxbaFrGaC7s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7qcPCqcsBPSmvzCGaFGjXtQ3U0Kf+qcgXnu
 87smOOmAnOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6gAKCRAADmhBGVaC
 FdhqEACFCXjVn02rVy92FGCGl/1gBFVLCUeZTzVkA6cnfV6N9X4JUXXXQp+u/YmbjuXiG7tXnhE
 jme2L7KFkyhXNJb8LvIziG201uuf2C4JR+b3tEtt5BtpIE9/cdkdTxX46isCssyD2ZL+pzxeySb
 /Akted2YjPggnbh7sFL7WSdZ8SN6W5lUMi1aUBQA14/pxuRu4A/jMEZPIF8wSKnZCU5OaV46H1n
 MvWFdESVu+H9gv1MT7l86KlxOA+WTGEWfvXg9Farzg/+hUKe7J5iM5Jomn+3j0cgYHa7Kc+XtyC
 m2YVVbgzskAaOaZ+olwDQRpmWIfdxLQPIzOS/8OsHQx0ksaWgBVMeNTlqYlQNbo+4uSn8NKlkPp
 QPQtogWMpimES5mjs1RyupcWPFhndPgubMdU7YoCdq4fVVdVYabqYPiNSqw5rVHaBZ9hFpk2+2l
 jT9SnFcx3w12Yp8vZgHcECuB1/qis6mL3xK/Q+oLlxWt1iSf8HJGyakKRPstcKAObD5kIS0VY7Z
 xD+OpDSJyGi/qG2YY3tTDD6NG/3ehLqkaUgvlo6xhzHp13KZ05gAPXU9Q0NSNRv4wYr+hRh1kE6
 dnz9GmbbfPJ7K7RPLDZ7ezZXpCpp7T7DmJnntBBn2quTOqaGJRt7cKurorUz85ekum8ZLBSpali
 83RmLB5cw4aAWAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the necessary parts to accept a fsnotify callback for directory
change event and create a CB_NOTIFY request for it. When a dir nfsd_file
is created set a handle_event callback to handle the notification. Use
that to marshal the event into the notifylist4 buffer, and kick off the
callback workqueue job to handle the send.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c    |  51 +++++++++++++----
 fs/nfsd/nfs4callback.c |  19 +++++--
 fs/nfsd/nfs4state.c    | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |   2 +
 4 files changed, 207 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3468883146afc080d2b4862e6002b2c6ff7315b9..6cd4cfa0b46bf33c4134987a12e42c8455fc4879 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -72,6 +72,7 @@ static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
+static struct fsnotify_group		*nfsd_dir_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
@@ -147,7 +148,7 @@ static void
 nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 {
 	if (refcount_dec_and_test(&nfm->nfm_ref)) {
-		fsnotify_destroy_mark(&nfm->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_destroy_mark(&nfm->nfm_mark, nfm->nfm_mark.group);
 		fsnotify_put_mark(&nfm->nfm_mark);
 	}
 }
@@ -155,35 +156,37 @@ nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 static struct nfsd_file_mark *
 nfsd_file_mark_find_or_create(struct inode *inode)
 {
-	int			err;
-	struct fsnotify_mark	*mark;
 	struct nfsd_file_mark	*nfm = NULL, *new;
+	struct fsnotify_group	*group;
+	struct fsnotify_mark	*mark;
+	int			err;
+
+	group = S_ISDIR(inode->i_mode) ? nfsd_dir_fsnotify_group : nfsd_file_fsnotify_group;
 
 	do {
-		fsnotify_group_lock(nfsd_file_fsnotify_group);
-		mark = fsnotify_find_inode_mark(inode,
-						nfsd_file_fsnotify_group);
+		fsnotify_group_lock(group);
+		mark = fsnotify_find_inode_mark(inode, group);
 		if (mark) {
 			nfm = nfsd_file_mark_get(container_of(mark,
 						 struct nfsd_file_mark,
 						 nfm_mark));
-			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+			fsnotify_group_unlock(group);
 			if (nfm) {
 				fsnotify_put_mark(mark);
 				break;
 			}
 			/* Avoid soft lockup race with nfsd_file_mark_put() */
-			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
+			fsnotify_destroy_mark(mark, group);
 			fsnotify_put_mark(mark);
 		} else {
-			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+			fsnotify_group_unlock(group);
 		}
 
 		/* allocate a new nfm */
 		new = kmem_cache_alloc(nfsd_file_mark_slab, GFP_KERNEL);
 		if (!new)
 			return NULL;
-		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_init_mark(&new->nfm_mark, group);
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
 		refcount_set(&new->nfm_ref, 1);
 
@@ -758,12 +761,25 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 	return 0;
 }
 
+static int
+nfsd_dir_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
+			       const void *data, int data_type, struct inode *dir,
+			       const struct qstr *name, u32 cookie,
+			       struct fsnotify_iter_info *iter_info)
+{
+	return nfsd_handle_dir_event(mask, dir, data, data_type, name);
+}
 
 static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
 	.handle_inode_event = nfsd_file_fsnotify_handle_event,
 	.free_mark = nfsd_file_mark_free,
 };
 
+static const struct fsnotify_ops nfsd_dir_fsnotify_ops = {
+	.handle_event = nfsd_dir_fsnotify_handle_event,
+	.free_mark = nfsd_file_mark_free,
+};
+
 int
 nfsd_file_cache_init(void)
 {
@@ -815,8 +831,7 @@ nfsd_file_cache_init(void)
 		goto out_shrinker;
 	}
 
-	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							0);
+	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops, 0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
@@ -825,11 +840,23 @@ nfsd_file_cache_init(void)
 		goto out_notifier;
 	}
 
+	nfsd_dir_fsnotify_group = fsnotify_alloc_group(&nfsd_dir_fsnotify_ops, 0);
+	if (IS_ERR(nfsd_dir_fsnotify_group)) {
+		pr_err("nfsd: unable to create fsnotify group: %ld\n",
+			PTR_ERR(nfsd_dir_fsnotify_group));
+		ret = PTR_ERR(nfsd_dir_fsnotify_group);
+		nfsd_dir_fsnotify_group = NULL;
+		goto out_notify_group;
+	}
+
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
 	if (ret)
 		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
+out_notify_group:
+	fsnotify_put_group(nfsd_file_fsnotify_group);
+	nfsd_file_fsnotify_group = NULL;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index fe7b20b94d76efd309e27c1a3ef359e7101dac80..69cea84eceabe15b4e1e1aa31db601ad763b00ac 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -870,21 +870,30 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
 				   const void *data)
 {
 	const struct nfsd4_callback *cb = data;
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 	struct nfs4_cb_compound_hdr hdr = {
 		.ident = 0,
 		.minorversion = cb->cb_clp->cl_minorversion,
 	};
-	struct CB_NOTIFY4args args = { };
+	struct CB_NOTIFY4args args;
+	__be32 *p;
 
 	WARN_ON_ONCE(hdr.minorversion == 0);
 
 	encode_cb_compound4args(xdr, &hdr);
 	encode_cb_sequence4args(xdr, cb, &hdr);
 
-	/*
-	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
-	 * buffer, and zero it.
-	 */
+	p = xdr_reserve_space(xdr, 4);
+	*p = cpu_to_be32(OP_CB_NOTIFY);
+
+	args.cna_stateid.seqid = dp->dl_stid.sc_stateid.si_generation;
+	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
+	       ARRAY_SIZE(args.cna_stateid.other));
+	args.cna_fh.len = dp->dl_stid.sc_file->fi_fhandle.fh_size;
+	args.cna_fh.data = dp->dl_stid.sc_file->fi_fhandle.fh_raw;
+	args.cna_changes.count = ncn->ncn_send->nns_idx;
+	args.cna_changes.element = ncn->ncn_send->nns_ent;
 	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
 
 	hdr.nops++;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5860d44fea0a4f854d65c87bcacb8eea19ce82e4..35b9e35f8b507cc9b3924fead3037433cd8f9371 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 #include "trace.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
@@ -3309,15 +3310,83 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
+static bool
+nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn =
+			container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp =
+			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct inode *inode = file_inode(nf->nf_file);
+	struct file_lock_context *flc = locks_inode_context(inode);
+	struct nfsd4_notify_spool *spool;
+
+	if (WARN_ON_ONCE(!flc))
+		return false;
+
+	if (WARN_ON_ONCE(ncn->ncn_send))
+		return false;
+
+	spool = alloc_notify_spool();
+	if (!spool) {
+		nfsd4_run_cb(&dp->dl_recall);
+		return false;
+	}
+
+	spin_lock(&flc->flc_lock);
+	ncn->ncn_send = ncn->ncn_gather;
+	ncn->ncn_gather = spool;
+	spin_unlock(&flc->flc_lock);
+	return true;
+}
+
+/* Returns true if more notifications are waiting to be sent */
+static bool
+nfsd4_cb_notify_release_send_spool(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct inode *inode = file_inode(nf->nf_file);
+	struct file_lock_context *flc = locks_inode_context(inode);
+	struct nfsd4_notify_spool *spool;
+	bool more;
+
+	spin_lock(&flc->flc_lock);
+	spool = ncn->ncn_send;
+	ncn->ncn_send = NULL;
+	more = ncn->ncn_gather && ncn->ncn_gather->nns_idx;
+	spin_unlock(&flc->flc_lock);
+
+	free_notify_spool(spool);
+	return more;
+}
+
 static int
 nfsd4_cb_notify_done(struct nfsd4_callback *cb,
 				struct rpc_task *task)
 {
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		rpc_delay(task, 2 * HZ);
 		return 0;
+	case 0:
+		/* If successful, release the send spool and maybe requeue the cb */
+		if (nfsd4_cb_notify_release_send_spool(cb)) {
+			refcount_inc(&dp->dl_stid.sc_count);
+			nfsd4_run_cb(cb);
+		}
+		return 1;
 	default:
+		/* For any other hard error, recall the deleg */
+		nfsd4_run_cb(&dp->dl_recall);
+		nfsd4_cb_notify_release_send_spool(cb);
 		return 1;
 	}
 }
@@ -3331,6 +3400,8 @@ nfsd4_cb_notify_release(struct nfsd4_callback *cb)
 			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 
 	nfs4_put_stid(&dp->dl_stid);
+	if (nfsd4_cb_notify_release_send_spool(cb))
+		nfsd4_run_cb(cb);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
@@ -3346,6 +3417,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 };
 
 static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.prepare	= nfsd4_cb_notify_prepare,
 	.done		= nfsd4_cb_notify_done,
 	.release	= nfsd4_cb_notify_release,
 	.opcode		= OP_CB_NOTIFY,
@@ -9534,3 +9606,83 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	put_deleg_file(fp);
 	return ERR_PTR(status);
 }
+
+static void
+nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn)
+{
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags))
+		return;
+
+	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count))
+		clear_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags);
+	else
+		nfsd4_run_cb(&ncn->ncn_cb);
+}
+
+int
+nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
+		      int data_type, const struct qstr *name)
+{
+	struct file_lock_context *ctx;
+	struct file_lock_core *flc;
+
+	ctx = locks_inode_context(dir);
+	if (!ctx || list_empty(&ctx->flc_lease))
+		return 0;
+
+	/*
+	 * FIXME: Do getattr against @inode, and then generate an fattr4. Use that as the
+	 * ne_attrs in the notify_entry4's.
+	 */
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		struct file_lease *fl = container_of(flc, struct file_lease, c);
+		struct nfs4_delegation *dp = flc->flc_owner;
+		struct nfsd4_cb_notify *ncn = &dp->dl_cb_notify;
+		struct nfsd4_notify_spool *nns = ncn->ncn_gather;
+		struct xdr_stream *stream = &nns->nns_stream;
+		static uint32_t zerobm;
+
+		if (fl->fl_lmops != &nfsd_dir_lease_mng_ops)
+			continue;
+
+		/* If no buffer or slots are available, give up and break the deleg */
+		if (!nns || nns->nns_idx >= NFSD4_NOTIFY_SPOOL_SZ) {
+			nfsd_break_deleg_cb(fl);
+			continue;
+		}
+
+		if (mask & FS_DELETE) {
+			static uint32_t notify_remove_bitmap = BIT(NOTIFY4_REMOVE_ENTRY);
+			struct notify4 *ent = &nns->nns_ent[nns->nns_idx];
+			struct notify_remove4 nr = { };
+			u8 *p = (u8 *)(stream->p);
+
+			if (!(flc->flc_flags & FL_IGN_DIR_DELETE))
+				continue;
+
+			nr.nrm_old_entry.ne_file.len = name->len;
+			nr.nrm_old_entry.ne_file.data = (char *)name->name;
+			nr.nrm_old_entry.ne_attrs.attrmask.count = 1;
+			nr.nrm_old_entry.ne_attrs.attrmask.element = &zerobm;
+			if (!xdrgen_encode_notify_remove4(stream, &nr)) {
+				pr_warn("nfsd: unable to marshal notify_remove4 to xdr stream\n");
+				continue;
+			}
+
+			/* grab a notify4 in the buffer and set it up */
+			ent->notify_mask.count = 1;
+			ent->notify_mask.element = &notify_remove_bitmap;
+			ent->notify_vals.len = (u8 *)stream->p - p;
+			ent->notify_vals.data = p;
+			++nns->nns_idx;
+		}
+
+		if (nns->nns_idx)
+			nfsd4_run_cb_notify(ncn);
+	}
+	spin_unlock(&ctx->flc_lock);
+	return 0;
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 98f87fa724ee242f3a855faa205223b0e09a16ed..345fa6325fde0435f811050625457a0d3cc29f3b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -845,6 +845,8 @@ bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
+int nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
+			  int data_type, const struct qstr *name);
 
 void put_nfs4_file(struct nfs4_file *fi);
 extern void nfs4_put_cpntf_state(struct nfsd_net *nn,

-- 
2.49.0


