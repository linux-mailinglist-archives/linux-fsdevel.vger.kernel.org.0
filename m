Return-Path: <linux-fsdevel+bounces-26222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF8956342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF58281006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA752171CD;
	Mon, 19 Aug 2024 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hDlaTwey";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="18Mig2UD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hDlaTwey";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="18Mig2UD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9315383C;
	Mon, 19 Aug 2024 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045804; cv=none; b=JVz6t1xF0mVfZmnpCEYEnY2O+wXdCF8Aj2Q+HlpsT159BKnzx+mwlXkApTcuklaUj4t3l9qLUncSlBLX8R+MbwDXyqgl1xgZFIwIPTzRskb0+nV4yQLbxQe+agRiwIZgAeuvMO+2T+icIVpt5Q1q83TTcF8gJkfNywM59gPSRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045804; c=relaxed/simple;
	bh=xrbFUF51S+MrPaCw7lMxZX2lCSXj+R5y+nkfINGm7gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZstIwEDYbjfLANi4q3chQKOK0EQP8I9fyDiai/tUqPodYi3DeXb3gzVvMvwiecDDnSOLQZd4x2pp9F6fiT2Mqy4ATdnfDQ8SnwuSh3bDGXSxZSMZPd6gmrTWVCua/uCrkedE+YBc18gkgPRC5q1XN1ctTtjLNq5lR/NQR1FIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hDlaTwey; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=18Mig2UD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hDlaTwey; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=18Mig2UD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 346C11FE49;
	Mon, 19 Aug 2024 05:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRt2PmODsqvf8Z9NOMqSzyATeFymLf719Q2fX8QZMYU=;
	b=hDlaTweyJFYiGQPqG/jBk+OskFZ0oQbSwMVBgJHRI287H0GhAURCT9NqcZWEig/4bbef+5
	RWMRpRLM3A09QEzLkok6gx8mqSCYx1p/ltaMIbKZeQwk0nXvtB/SfxW7nlPj8EdP1SfmIg
	pGbubOmTij2FTl7GPyIJhX9gLcP0nsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRt2PmODsqvf8Z9NOMqSzyATeFymLf719Q2fX8QZMYU=;
	b=18Mig2UDzaTSDxBpbW8PWxbCZyvB/7a5GTJFjZMWLEd4SWG7mNLS0kv483Vjr2K5+eHSkG
	lHGg+D2vhF/ST2AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hDlaTwey;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=18Mig2UD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRt2PmODsqvf8Z9NOMqSzyATeFymLf719Q2fX8QZMYU=;
	b=hDlaTweyJFYiGQPqG/jBk+OskFZ0oQbSwMVBgJHRI287H0GhAURCT9NqcZWEig/4bbef+5
	RWMRpRLM3A09QEzLkok6gx8mqSCYx1p/ltaMIbKZeQwk0nXvtB/SfxW7nlPj8EdP1SfmIg
	pGbubOmTij2FTl7GPyIJhX9gLcP0nsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRt2PmODsqvf8Z9NOMqSzyATeFymLf719Q2fX8QZMYU=;
	b=18Mig2UDzaTSDxBpbW8PWxbCZyvB/7a5GTJFjZMWLEd4SWG7mNLS0kv483Vjr2K5+eHSkG
	lHGg+D2vhF/ST2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A2CF1397F;
	Mon, 19 Aug 2024 05:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IH9pBObZwmbYYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:36:38 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
Date: Mon, 19 Aug 2024 15:20:36 +1000
Message-ID: <20240819053605.11706-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 346C11FE49
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.01

There is a common pattern of atomic_dec_and_test() being followed by
wake_up_var().

So provide atomic_dec_and_wake_up_var() to do both.

A future patch will change the default barrier used by wake_up_var().
Doing this first will reduce the size of that patch.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/dma-buf/st-dma-fence-chain.c          | 3 +--
 drivers/gpu/drm/display/drm_dp_aux_dev.c      | 6 ++----
 drivers/gpu/drm/i915/selftests/i915_request.c | 7 +------
 drivers/media/platform/qcom/venus/hfi.c       | 3 +--
 fs/afs/cell.c                                 | 3 +--
 fs/afs/internal.h                             | 3 +--
 fs/afs/rxrpc.c                                | 4 +---
 fs/btrfs/block-group.c                        | 6 ++----
 fs/netfs/objects.c                            | 3 +--
 fs/nfs/pagelist.c                             | 3 +--
 fs/nfs/write.c                                | 6 +-----
 fs/nfsd/nfs4callback.c                        | 4 +---
 fs/reiserfs/journal.c                         | 3 +--
 include/linux/wait_bit.h                      | 8 ++++++++
 mm/shmem.c                                    | 3 +--
 net/rxrpc/call_accept.c                       | 3 +--
 net/rxrpc/call_object.c                       | 3 +--
 net/rxrpc/conn_object.c                       | 3 +--
 net/sunrpc/xprt.c                             | 3 +--
 19 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index ed4b323886e4..36466ae588e8 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -434,8 +434,7 @@ static int __find_race(void *arg)
 		cond_resched();
 	}
 
-	if (atomic_dec_and_test(&data->children))
-		wake_up_var(&data->children);
+	atomic_dec_and_wake_up_var(&data->children);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 29555b9f03c8..bb03f1dff840 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -180,8 +180,7 @@ static ssize_t auxdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		res = pos - iocb->ki_pos;
 	iocb->ki_pos = pos;
 
-	if (atomic_dec_and_test(&aux_dev->usecount))
-		wake_up_var(&aux_dev->usecount);
+	atomic_dec_and_wake_up_var(&aux_dev->usecount);
 
 	return res;
 }
@@ -223,8 +222,7 @@ static ssize_t auxdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		res = pos - iocb->ki_pos;
 	iocb->ki_pos = pos;
 
-	if (atomic_dec_and_test(&aux_dev->usecount))
-		wake_up_var(&aux_dev->usecount);
+	atomic_dec_and_wake_up_var(&aux_dev->usecount);
 
 	return res;
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index acae30a04a94..8a45f79f10a0 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -1530,12 +1530,7 @@ static void __live_parallel_engineN(struct kthread_work *work)
 
 static bool wake_all(struct drm_i915_private *i915)
 {
-	if (atomic_dec_and_test(&i915->selftest.counter)) {
-		wake_up_var(&i915->selftest.counter);
-		return true;
-	}
-
-	return false;
+	return atomic_dec_and_wakeup_var(&i915->selftest.counter);
 }
 
 static int wait_for_all(struct drm_i915_private *i915)
diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index e00aedb41d16..4c75b827a341 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -255,8 +255,7 @@ void hfi_session_destroy(struct venus_inst *inst)
 
 	mutex_lock(&core->lock);
 	list_del_init(&inst->list);
-	if (atomic_dec_and_test(&core->insts_count))
-		wake_up_var(&core->insts_count);
+	atomic_dec_and_wake_up_var(&core->insts_count);
 	mutex_unlock(&core->lock);
 }
 EXPORT_SYMBOL_GPL(hfi_session_destroy);
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index caa09875f520..422bcc26becc 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -25,8 +25,7 @@ static void afs_manage_cell_work(struct work_struct *);
 
 static void afs_dec_cells_outstanding(struct afs_net *net)
 {
-	if (atomic_dec_and_test(&net->cells_outstanding))
-		wake_up_var(&net->cells_outstanding);
+	atomic_dec_and_wake_up_var(&net->cells_outstanding);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72..d19db6c00cae 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1484,8 +1484,7 @@ static inline void afs_inc_servers_outstanding(struct afs_net *net)
 
 static inline void afs_dec_servers_outstanding(struct afs_net *net)
 {
-	if (atomic_dec_and_test(&net->servers_outstanding))
-		wake_up_var(&net->servers_outstanding);
+	atomic_dec_and_wake_up_var(&net->servers_outstanding);
 }
 
 static inline bool afs_is_probing_server(struct afs_server *server)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c453428f3c8b..36e61b20f937 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -195,9 +195,7 @@ void afs_put_call(struct afs_call *call)
 			       __builtin_return_address(0));
 		kfree(call);
 
-		o = atomic_dec_return(&net->nr_outstanding_calls);
-		if (o == 0)
-			wake_up_var(&net->nr_outstanding_calls);
+		atomic_dec_and_wake_up_var(&net->nr_outstanding_calls);
 	}
 }
 
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2e49d978f504..d26e176fa531 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -352,8 +352,7 @@ struct btrfs_block_group *btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info,
  */
 void btrfs_dec_nocow_writers(struct btrfs_block_group *bg)
 {
-	if (atomic_dec_and_test(&bg->nocow_writers))
-		wake_up_var(&bg->nocow_writers);
+	atomic_dec_and_wake_up_var(&bg->nocow_writers);
 
 	/* For the lookup done by a previous call to btrfs_inc_nocow_writers(). */
 	btrfs_put_block_group(bg);
@@ -371,8 +370,7 @@ void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
 
 	bg = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(bg);
-	if (atomic_dec_and_test(&bg->reservations))
-		wake_up_var(&bg->reservations);
+	atomic_dec_and_wake_up_var(&bg->reservations);
 	btrfs_put_block_group(bg);
 }
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a642727479..39e3ab3d0042 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -145,8 +145,7 @@ static void netfs_free_request(struct work_struct *work)
 		kvfree(rreq->direct_bv);
 	}
 
-	if (atomic_dec_and_test(&ictx->io_count))
-		wake_up_var(&ictx->io_count);
+	atomic_dec_and_wake_up_var(&ictx->io_count);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 04124f226665..8ae767578cd9 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -559,8 +559,7 @@ static void nfs_clear_request(struct nfs_page *req)
 		req->wb_page = NULL;
 	}
 	if (l_ctx != NULL) {
-		if (atomic_dec_and_test(&l_ctx->io_count)) {
-			wake_up_var(&l_ctx->io_count);
+		if (atomic_dec_and_wake_up_var(&l_ctx->io_count)) {
 			ctx = l_ctx->open_context;
 			if (test_bit(NFS_CONTEXT_UNLOCK, &ctx->flags))
 				rpc_wake_up(&NFS_SERVER(d_inode(ctx->dentry))->uoc_rpcwaitq);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d074d0ceb4f0..7d9d6ba5c71c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1646,11 +1646,7 @@ void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
-	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
-		wake_up_var(&cinfo->rpcs_out);
-		return true;
-	}
-	return false;
+	return atomic_dec_and_wake_up_var(&cinfo->rpcs_out);
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d756f443fc44..cef65be34525 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -993,9 +993,7 @@ static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 
 static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
 {
-
-	if (atomic_dec_and_test(&clp->cl_cb_inflight))
-		wake_up_var(&clp->cl_cb_inflight);
+	atomic_dec_and_wake_up_var(&clp->cl_cb_inflight);
 }
 
 static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e477ee0ff35d..f3da240e486b 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1059,8 +1059,7 @@ static int flush_commit_list(struct super_block *s,
 			put_bh(tbh) ;
 		}
 	}
-	if (atomic_dec_and_test(&journal->j_async_throttle))
-		wake_up_var(&journal->j_async_throttle);
+	atomic_dec_and_wake_up_var(&journal->j_async_throttle);
 
 	for (i = 0; i < (jl->j_len + 1); i++) {
 		bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) +
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..178ed8bed91c 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -335,4 +335,12 @@ static inline void clear_and_wake_up_bit(int bit, void *word)
 	wake_up_bit(word, bit);
 }
 
+static inline bool atomic_dec_and_wake_up_var(atomic_t *var)
+{
+	if (!atomic_dec_and_test(var))
+		return false;
+	wake_up_var(var);
+	return true;
+}
+
 #endif /* _LINUX_WAIT_BIT_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..414c69d7596f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1421,8 +1421,7 @@ int shmem_unuse(unsigned int type)
 		next = list_next_entry(info, swaplist);
 		if (!info->swapped)
 			list_del_init(&info->swaplist);
-		if (atomic_dec_and_test(&info->stop_eviction))
-			wake_up_var(&info->stop_eviction);
+		atomic_dec_and_wake_up_var(&info->stop_eviction);
 		if (error)
 			break;
 	}
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 0f5a1d77b890..ece4137bb464 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -209,8 +209,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 		list_del(&conn->proc_link);
 		write_unlock(&rxnet->conn_lock);
 		kfree(conn);
-		if (atomic_dec_and_test(&rxnet->nr_conns))
-			wake_up_var(&rxnet->nr_conns);
+		atomic_dec_and_wake_up_var(&rxnet->nr_conns);
 		tail = (tail + 1) & (size - 1);
 	}
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index f9e983a12c14..b25f6ed4bcc0 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -661,8 +661,7 @@ static void rxrpc_rcu_free_call(struct rcu_head *rcu)
 	struct rxrpc_net *rxnet = READ_ONCE(call->rxnet);
 
 	kmem_cache_free(rxrpc_call_jar, call);
-	if (atomic_dec_and_test(&rxnet->nr_calls))
-		wake_up_var(&rxnet->nr_calls);
+	atomic_dec_and_wake_up_var(&rxnet->nr_calls);
 }
 
 /*
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 1539d315afe7..738663251188 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -294,8 +294,7 @@ static void rxrpc_rcu_free_connection(struct rcu_head *rcu)
 			 rxrpc_conn_free);
 	kfree(conn);
 
-	if (atomic_dec_and_test(&rxnet->nr_conns))
-		wake_up_var(&rxnet->nr_conns);
+	atomic_dec_and_wake_up_var(&rxnet->nr_conns);
 }
 
 /*
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda526..1a801a08671f 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1113,8 +1113,7 @@ void xprt_unpin_rqst(struct rpc_rqst *req)
 		atomic_dec(&req->rq_pin);
 		return;
 	}
-	if (atomic_dec_and_test(&req->rq_pin))
-		wake_up_var(&req->rq_pin);
+	atomic_dec_and_wake_up_var(&req->rq_pin);
 }
 EXPORT_SYMBOL_GPL(xprt_unpin_rqst);
 
-- 
2.44.0


