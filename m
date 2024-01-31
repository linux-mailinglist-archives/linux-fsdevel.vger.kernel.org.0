Return-Path: <linux-fsdevel+bounces-9741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F3844BED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB80428A3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AE481AF;
	Wed, 31 Jan 2024 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE76qaga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE747F6B;
	Wed, 31 Jan 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742180; cv=none; b=sC4V+whWz5skrGuLSaID3PmNRevrEnRngFeUz0/h6VmFjDJrKYJX8fFu9U0SKxEiY7qg3RwB/RAhffx5Yi08CF/vABGWW88wyRIy9/fiencEhvhLarOOD7Qrinvro6Ej1oLR4Yz04hprtvLxxf1oFRkPqcHp9dlFPcG2h6HTmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742180; c=relaxed/simple;
	bh=A09znMhAcTVzp0oLEfbR8PwSTSuDGz4/+HYgiw1Q4kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peQgybqJrbrgELXHL2MX51K0ywSy5rNCFN6CtDsumpAQ+ent0sxLYJOIb7htzF1+MNOfiWfwVOuie6c8bbo2TcslRPwazczN8EmQINmOenYzgJ9klg604vZXQPE0ED1vsXoCB5d25vT+hoZ1zyOiAsncvk/FLB/Sk6h+VPYfTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE76qaga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D080C43390;
	Wed, 31 Jan 2024 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742180;
	bh=A09znMhAcTVzp0oLEfbR8PwSTSuDGz4/+HYgiw1Q4kA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nE76qagauF0yXLXHNcv471C5mtwncIUcd77289C75xZPtARUcvfRrLkPO0LlJ/3e9
	 LT20DvQUawuLm2RItkyI4m9QfqCUgRJbSW8ZzL5YPcZvoXPnADHggKPUYr4y4VD8zj
	 qZT7oeDMaAUAi2I/Mo8rDFwaUD9YLRxAUlEMm0b2MgaGe1cxPBHrXT5apvCjdB8DOE
	 /0Cs2n3ll3Nd9jQ4Sq91JEfoWAJ5Do6z14K+k7s4XkA9DrQqD+1gk0eatPOmG8Prp0
	 MJJ8vxMTg8RZqMRznOEmvNq51+tKSESyPS1bZTN0ahdItQozUFYA8C3c0iMzIosyIx
	 pB/54u/5NXjvw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:52 -0500
Subject: [PATCH v3 11/47] nfs: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-11-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8152; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A09znMhAcTVzp0oLEfbR8PwSTSuDGz4/+HYgiw1Q4kA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvnDHR0bW2131Eqhkxv9Dv7mgOGfDhGfGQi
 rJXskCzz5iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FQH8D/9iJ+N6+SMmIPP01z1XoqfCYr7ZAdHGinP/2ULHPHf8ZjR1SQCcxFfD8eE1aRxbMrmRfRp
 DovJSyTIny261gIi7NgzS8ytowFNjFgn/jzebv5d8L5mNPxi59EIyDbG9TKRFKwYoHTKu7t6+nP
 0hx7ZwAFxKy1EiRzE9ykGz7/boM0GzIjpPtrgbiWuduR9EqoohVlFtA33Wjf3UaWo+/0/O5LDSb
 PZH3CDrNZB0EOiTx33n7/dBtjxV8+wOy5yAGhCm0lPxGMH47Gb51tmNhmcZbi8vuWXrIJ/AXwzr
 BTbjXtttmGs5ZsKqR9h/hf1Ipjpzrc0I1VuiitR4yNJ8d+rqfzrZHrWWCH6uwAHQx2nTLpGnYZJ
 ui0BUr+mYDYOYC2znLtBKQvThbS/WgQtnvRc9DCcHIz37IrKqmYi1lDA9HBiX3EUMj26e1FTVyh
 0Axkogdu8fSwULZmiSYIdhP0NEDO/ynHWR+0gq9H/C6fZO3jSq1Al0RjIe/0ermH7zrgaw9bIwP
 f2FbPa/KCjsA1UdE43v/FvoRr7vRzMxUG0y3xRkhRt/8av0n0LQDrZAf8gXSn4RYtJ5I6L6/vzZ
 yEfDCIsT2Ec+96lDyyiS3JxWLFAYFIQHTgF8xnXsp/Y3Egif3g7ZRVNUQkAM/GzV9MtbCa9SoIk
 SQmxzknVG/MNOHg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions. Also, in later
patches we're going to introduce some temporary macros with names that
clash with the variable name in nfs4_proc_unlck. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  2 +-
 fs/nfs/file.c       |  4 ++--
 fs/nfs/nfs4proc.c   | 12 ++++++------
 fs/nfs/nfs4state.c  | 18 +++++++++---------
 fs/nfs/nfs4xdr.c    |  2 +-
 fs/nfs/write.c      |  4 ++--
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fa1a14def45c..ca6985001466 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -156,7 +156,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	list = &flctx->flc_posix;
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	for_each_file_lock(fl, list) {
 		if (nfs_file_open_context(fl->fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8577ccf621f5..1a7a76d6055b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -851,7 +851,7 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	if (IS_GETLK(cmd))
 		ret = do_getlk(filp, cmd, fl, is_local);
-	else if (fl->fl_type == F_UNLCK)
+	else if (lock_is_unlock(fl))
 		ret = do_unlk(filp, cmd, fl, is_local);
 	else
 		ret = do_setlk(filp, cmd, fl, is_local);
@@ -878,7 +878,7 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 		is_local = 1;
 
 	/* We're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (lock_is_unlock(fl))
 		return do_unlk(filp, cmd, fl, is_local);
 	return do_setlk(filp, cmd, fl, is_local);
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..df54fcd0fa08 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7045,7 +7045,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char saved_flags = request->fl_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
@@ -7080,7 +7080,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7398,7 +7398,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char flags = request->fl_flags;
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
@@ -7410,7 +7410,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = fl_flags & ~FL_SLEEP;
+		request->fl_flags = flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7420,7 +7420,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = flags;
 	return status;
 }
 
@@ -7562,7 +7562,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (!(IS_SETLK(cmd) || IS_SETLKW(cmd)))
 		return -EINVAL;
 
-	if (request->fl_type == F_UNLCK) {
+	if (lock_is_unlock(request)) {
 		if (state != NULL)
 			return nfs4_proc_unlck(state, cmd, request);
 		return 0;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a5d911a7edc..16b57735e26a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -847,15 +847,15 @@ void nfs4_close_sync(struct nfs4_state *state, fmode_t fmode)
  */
 static struct nfs4_lock_state *
 __nfs4_find_lock_state(struct nfs4_state *state,
-		       fl_owner_t fl_owner, fl_owner_t fl_owner2)
+		       fl_owner_t owner, fl_owner_t owner2)
 {
 	struct nfs4_lock_state *pos, *ret = NULL;
 	list_for_each_entry(pos, &state->lock_states, ls_locks) {
-		if (pos->ls_owner == fl_owner) {
+		if (pos->ls_owner == owner) {
 			ret = pos;
 			break;
 		}
-		if (pos->ls_owner == fl_owner2)
+		if (pos->ls_owner == owner2)
 			ret = pos;
 	}
 	if (ret)
@@ -868,7 +868,7 @@ __nfs4_find_lock_state(struct nfs4_state *state,
  * exists, return an uninitialized one.
  *
  */
-static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t fl_owner)
+static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t owner)
 {
 	struct nfs4_lock_state *lsp;
 	struct nfs_server *server = state->owner->so_server;
@@ -879,7 +879,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 	nfs4_init_seqid_counter(&lsp->ls_seqid);
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state = state;
-	lsp->ls_owner = fl_owner;
+	lsp->ls_owner = owner;
 	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
 	if (lsp->ls_seqid.owner_id < 0)
 		goto out_free;
@@ -993,7 +993,7 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 		const struct nfs_lock_context *l_ctx)
 {
 	struct nfs4_lock_state *lsp;
-	fl_owner_t fl_owner, fl_flock_owner;
+	fl_owner_t owner, fl_flock_owner;
 	int ret = -ENOENT;
 
 	if (l_ctx == NULL)
@@ -1002,11 +1002,11 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 	if (test_bit(LK_STATE_IN_USE, &state->flags) == 0)
 		goto out;
 
-	fl_owner = l_ctx->lockowner;
+	owner = l_ctx->lockowner;
 	fl_flock_owner = l_ctx->open_context->flock_owner;
 
 	spin_lock(&state->state_lock);
-	lsp = __nfs4_find_lock_state(state, fl_owner, fl_flock_owner);
+	lsp = __nfs4_find_lock_state(state, owner, fl_flock_owner);
 	if (lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags))
 		ret = -EIO;
 	else if (lsp != NULL && test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0) {
@@ -1529,7 +1529,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	for_each_file_lock(fl, list) {
 		if (nfs_file_open_context(fl->fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69406e60f391..6e309db5afe4 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1305,7 +1305,7 @@ static void encode_link(struct xdr_stream *xdr, const struct qstr *name, struct
 
 static inline int nfs4_lock_type(struct file_lock *fl, int block)
 {
-	if (fl->fl_type == F_RDLCK)
+	if (lock_is_read(fl))
 		return block ? NFS4_READW_LT : NFS4_READ_LT;
 	return block ? NFS4_WRITEW_LT : NFS4_WRITE_LT;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..d16f2b9d1765 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1301,7 +1301,7 @@ static bool
 is_whole_file_wrlock(struct file_lock *fl)
 {
 	return fl->fl_start == 0 && fl->fl_end == OFFSET_MAX &&
-			fl->fl_type == F_WRLCK;
+			lock_is_write(fl);
 }
 
 /* If we know the page is up to date, and we're not using byte range locks (or
@@ -1341,7 +1341,7 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
 					fl_list);
-		if (fl->fl_type == F_WRLCK)
+		if (lock_is_write(fl))
 			ret = 1;
 	}
 	spin_unlock(&flctx->flc_lock);

-- 
2.43.0


