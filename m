Return-Path: <linux-fsdevel+bounces-8876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580483BF49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E211F2738B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67347F43;
	Thu, 25 Jan 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/x7+F75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629445C0E;
	Thu, 25 Jan 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179410; cv=none; b=IEQLJIuDBXLAbgHu0ynt7DAB1SC9/S4k9UgaJX2+Fr0nNR8bZJZnc9IMre3D5oVhlTX4VmCTaZKPQl62E04qzdO+OUyGjv0QfVjIfZEtH9k13m9h/Efqv7jiw7vkSXsC0WlRJANQ4Is4itF9uUhvONeW/XyuVm5jer6Joi98VnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179410; c=relaxed/simple;
	bh=/aGGER+GMEO8eWov6bTjUSIOjn2NGEHzheeD4QCJRlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3oSjrddmZUJn04orRvDgkLIc2ggpLafejVcZwf9BzGWsRLpvcgBxSR5BJWa2ql63GLvfBBrMZO5wpdIdDsoQBN+nyHhyXPAzWBl6Fp+2dRtmOjiwKmAsN21SkALl8ax2P0VoaT1+Uak5tmC35kj+J9ddVeMz6mlfo+dLEEk89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/x7+F75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93AFC43330;
	Thu, 25 Jan 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179410;
	bh=/aGGER+GMEO8eWov6bTjUSIOjn2NGEHzheeD4QCJRlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z/x7+F75frqr1HskUOX1iSsGtFsu18IICx1li/Ml6+hwnX+OnOJuRqrtRR0m7uEGW
	 FGjrtOSSTgH93OMz7mbMmGkIR7DjjziQz1RXI1+zf+Mk8SdPZc+fe9LyYVzCDQr0wf
	 RvdbfaPr5PHcxn/SrtmxSrGc8Q2SM64MWjeVKxi694oE4DDVabklS0uGAb9lV+gW+R
	 YWqdHOPD21DJFlmjiQr5qOFoPG+QkFVl1Aprqfl4njfO9bBvYanQBiUEUCdZSUQ3R+
	 KzopgzRONHzJFC+vewKADMxxVLWtMT8v/mQjO8Hoa+uiFx56PEQGGFATgOa9bMqtxh
	 vzyh8mhDwJlQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:45 -0500
Subject: [PATCH v2 04/41] nfs: rename fl_flags variable in nfs4_proc_unlck
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-4-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4748; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/aGGER+GMEO8eWov6bTjUSIOjn2NGEHzheeD4QCJRlw=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGWyOzqi7ZMXzgrKm/N+lZLoocUW4eO/WqZnPLzpRS2Zz2rf1
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJlsjs6AAoJEAAOaEEZVoIV48oP/iXj
 1O6BrMq4wC8YpWfdssDHR6/P2eubiLQ8EifjuKKGad9TuXe1gp4E/9x3iJwDUDyHbVVNPATxKVB
 yZmbxHIATN82k2ill85pZc+v4yl4Hz9mOLUBoyrnCo0+5tJDnY+7s+SnweJZCB064oVNGPUhPz4
 4Xl7YaipjnItFAW4z8k7nHBTgnUjP9GTjOgzg/bMK8NuUV6Odvrki270Zf+KbJU/1Xlr4F/UcFd
 6633uKGY+trZFWiJtRhtQtoJeCcHUuwwEvhGsD8pdX8H0bUYPS/+cBwFqJlra4XxdyQ9J9+EsAz
 dJe9V/RQXBlo93F+Vbhkr2SToUi5VB59Cc4hPzQZmp+3+LQjHPpuEsCB77sHFix6zhNoDd2WKyw
 EmDGJK8i4fYmJ085hj2j1Ou9gPW3vS7IoSKkSsYfUSZ3EcXAHsxpxJjqAzmNi3jNlVbKdnBIrOv
 XKnaGeoKxU0t80t1zLsdXmYlTERUidgZTJrPSjkvWjPk4lzS7REa3Bmi0ZZ2qpjLYuWCwCN77Qd
 K5P+XWRw8N92gWyHihFwj62Gc/qKHkTp3QZNFASl4G5XiAyBJ+nmlte1jY/lTQ7Ijvnzm0tWEnc
 ZXoxDYQpmypYUqKtlKG4Gmd1mR3KqVdeuhNJtxn1Rig9Ll8aoWcGWUZPfSgkGNdkQE5AWUyI5w4
 8PYPQ
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some temporary macros with
names that clash with the variable name here. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c  | 10 +++++-----
 fs/nfs/nfs4state.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..5dd936a403f9 100644
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
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a5d911a7edc..471caf06fa7b 100644
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

-- 
2.43.0


