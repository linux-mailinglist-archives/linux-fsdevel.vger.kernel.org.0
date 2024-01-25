Return-Path: <linux-fsdevel+bounces-8907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BDC83BFF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BD01C2309C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A867721;
	Thu, 25 Jan 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO9cz4tL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3266B53;
	Thu, 25 Jan 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179529; cv=none; b=VeDuiPA8+ZSOqD0D6+/OIW8iPazDzIQGZE88wj4QYmFiAdwznAk2iWjeOGuRhuzC5MdPVC4kbTuY9dG3KC02z66m9d26bkJuadd/eL1FyZwofmt7m3CvetrVVv0VtLrMzY5KqetKir923RPo1VvmSiuSW3P9MNEL8lss9+WytAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179529; c=relaxed/simple;
	bh=0xa8xij1oOf6EtAnJcFyUxW59toeifDvUZANw82BwKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4EXHQi9iSSwVUdXIeKcnsOhpQq1YpT9kBDapzhnJoMzmp5XdJuoy99Ngy6h/LtfVCzxsEHoaFWEiPAUwaSOk0M5x0xBgO03Z51tf/y/22XZPytDmCyz/hcVTBZ79K5QECwTza2sYKelEzAEH7F0FsKA83rqnIBRKw+fUPpQtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO9cz4tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE830C43394;
	Thu, 25 Jan 2024 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179529;
	bh=0xa8xij1oOf6EtAnJcFyUxW59toeifDvUZANw82BwKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SO9cz4tLgvq4TUm3pcRdIiDKPO2+tD0/wCz00r9ADD2UXyr6p4imxFeDVKecjAs1R
	 rW8KxTcIMll++pb7IAXd7HqV7vaS2NuRNWZMfmgk9SpWjTtNrhhR7xKZXE5EuZx7vw
	 0ZNzBPlTSVii1R2jkGFZ7aGWXgUuuNwt9NpiC4jtyxYS17bf1ppLm7bDfN8/VjCwMw
	 j2JUqkZK3z8srCRdYN1KUQ2BBizKeDlgKWhkc9LhU0n+TPPPsEi9hBhUeraFHpUY7i
	 3TzTTBX9hIIk556uuTj4PGvMGzO6FQTDAwFB50uxBcC8GUB5GM0ZQLHdt01ut7r/8n
	 k5qL76fWA1tgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:16 -0500
Subject: [PATCH v2 35/41] nfs: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-35-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14552; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0xa8xij1oOf6EtAnJcFyUxW59toeifDvUZANw82BwKs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+STvq1VTg7j4mMr4X2GTKmWbT5eX8YyGWx
 U7KSBPwPKSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FWo7EACEuZwavcgFbHJVKVW50u65lqv3or0v+4BHHV85M0N1MeWwXW/GSYO+TrBj+hhg62Rbw8b
 965AWiBQbgQFXtmibV+9IbBLWW5gcL87TZEhwD7Smjcn935vFPaeKoF9nKKyBTjWMoW26rUmq7b
 zkXPbLEq1i6EI+lRINdfyXOtRrv9eJQnZD3G4Ww37TZNDKwa750XJozxcJ4wgy/u+1CJd/kyVBV
 Iyys/myUJv9A1FwEaBw4L9fQ/okEH/70B3GTiAXT5ySesfyr8cHFpPGEAAY/tgLknl2RluFbKIg
 emnk2941/QfIZ2RyhR7grwuksgi3I1mAO09b+ME51UsDPUS3iMVjK2aMMu/26s4pU2Md6c7FhxN
 aMS7TeoE7hxWKulL/WuEXRWWex780I1KGAUESB56epPy0nSr6sE5K6rjfornXpjI//MiB++rHNo
 38q0/cltxL2u0nX8jlmX6RhqRJU7NadPpl7+fFq2P+ctCUfZSZEcVY++UXxYSX3aL74cc1NjHZ7
 G+V3nY4IqvEkoCHpK3TIbOA7UeQKu+shcltnNVhz3qwuRwEar20sjvs+v3hWRlV57A5RNahP/SM
 5gMlUWoX2bYEp+rlygs3Y8hBx+dXrduWkPWtY5HCVLyrClk4vfVK8RwRFGEp9igLueexLtxyUyZ
 Ivm8x98LwED0kqw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  4 ++--
 fs/nfs/file.c       | 23 +++++++++++------------
 fs/nfs/nfs3proc.c   |  2 +-
 fs/nfs/nfs4_fs.h    |  1 -
 fs/nfs/nfs4proc.c   | 35 +++++++++++++++++++----------------
 fs/nfs/nfs4state.c  |  6 +++---
 fs/nfs/nfs4trace.h  |  4 ++--
 fs/nfs/nfs4xdr.c    |  8 ++++----
 fs/nfs/write.c      |  9 ++++-----
 9 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fa1a14def45c..c308db36e932 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -156,8 +156,8 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	list = &flctx->flc_posix;
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+	list_for_each_entry(fl, list, fl_core.flc_list) {
+		if (nfs_file_open_context(fl->fl_core.flc_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = nfs4_lock_delegation_recall(fl, state, stateid);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 3c9a8ad91540..fb3cd614e36e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -31,7 +31,6 @@
 #include <linux/swap.h>
 
 #include <linux/uaccess.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "delegation.h"
@@ -721,15 +720,15 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 {
 	struct inode *inode = filp->f_mapping->host;
 	int status = 0;
-	unsigned int saved_type = fl->fl_type;
+	unsigned int saved_type = fl->fl_core.flc_type;
 
 	/* Try local locking first */
 	posix_test_lock(filp, fl);
-	if (fl->fl_type != F_UNLCK) {
+	if (fl->fl_core.flc_type != F_UNLCK) {
 		/* found a conflict */
 		goto out;
 	}
-	fl->fl_type = saved_type;
+	fl->fl_core.flc_type = saved_type;
 
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		goto out_noconflict;
@@ -741,7 +740,7 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 out:
 	return status;
 out_noconflict:
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.flc_type = F_UNLCK;
 	goto out;
 }
 
@@ -766,7 +765,7 @@ do_unlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 		 * 	If we're signalled while cleaning up locks on process exit, we
 		 * 	still need to complete the unlock.
 		 */
-		if (status < 0 && !(fl->fl_flags & FL_CLOSE))
+		if (status < 0 && !(fl->fl_core.flc_flags & FL_CLOSE))
 			return status;
 	}
 
@@ -833,12 +832,12 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: lock(%pD2, t=%x, fl=%x, r=%lld:%lld)\n",
-			filp, fl->fl_type, fl->fl_flags,
+			filp, fl->fl_core.flc_type, fl->fl_core.flc_flags,
 			(long long)fl->fl_start, (long long)fl->fl_end);
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
-	if (fl->fl_flags & FL_RECLAIM)
+	if (fl->fl_core.flc_flags & FL_RECLAIM)
 		return -ENOGRACE;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FCNTL)
@@ -852,7 +851,7 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	if (IS_GETLK(cmd))
 		ret = do_getlk(filp, cmd, fl, is_local);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.flc_type == F_UNLCK)
 		ret = do_unlk(filp, cmd, fl, is_local);
 	else
 		ret = do_setlk(filp, cmd, fl, is_local);
@@ -870,16 +869,16 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: flock(%pD2, t=%x, fl=%x)\n",
-			filp, fl->fl_type, fl->fl_flags);
+			filp, fl->fl_core.flc_type, fl->fl_core.flc_flags);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FLOCK)
 		is_local = 1;
 
 	/* We're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.flc_type == F_UNLCK)
 		return do_unlk(filp, cmd, fl, is_local);
 	return do_setlk(filp, cmd, fl, is_local);
 }
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2de66e4e8280..650ec250d7e5 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -963,7 +963,7 @@ nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
 	struct nfs_open_context *ctx = nfs_file_open_context(filp);
 	int status;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->fl_core.flc_flags & FL_CLOSE) {
 		l_ctx = nfs_get_lock_context(ctx);
 		if (IS_ERR(l_ctx))
 			l_ctx = NULL;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 752224a48f1c..581698f1b7b2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -23,7 +23,6 @@
 #define NFS4_MAX_LOOP_ON_RECOVER (10)
 
 #include <linux/seqlock.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 struct idmap;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5dd936a403f9..bdf9fa468982 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6800,7 +6800,7 @@ static int _nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	switch (status) {
 		case 0:
-			request->fl_type = F_UNLCK;
+			request->fl_core.flc_type = F_UNLCK;
 			break;
 		case -NFS4ERR_DENIED:
 			status = 0;
@@ -7018,8 +7018,8 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 	/* Ensure this is an unlock - when canceling a lock, the
 	 * canceled lock is passed in, and it won't be an unlock.
 	 */
-	fl->fl_type = F_UNLCK;
-	if (fl->fl_flags & FL_CLOSE)
+	fl->fl_core.flc_type = F_UNLCK;
+	if (fl->fl_core.flc_flags & FL_CLOSE)
 		set_bit(NFS_CONTEXT_UNLOCK, &ctx->flags);
 
 	data = nfs4_alloc_unlockdata(fl, ctx, lsp, seqid);
@@ -7045,11 +7045,11 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char saved_flags = request->fl_flags;
+	unsigned char saved_flags = request->fl_core.flc_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
-	request->fl_flags |= FL_EXISTS;
+	request->fl_core.flc_flags |= FL_EXISTS;
 	/* Exclude nfs_delegation_claim_locks() */
 	mutex_lock(&sp->so_delegreturn_mutex);
 	/* Exclude nfs4_reclaim_open_stateid() - note nesting! */
@@ -7073,14 +7073,16 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = -ENOMEM;
 	if (IS_ERR(seqid))
 		goto out;
-	task = nfs4_do_unlck(request, nfs_file_open_context(request->fl_file), lsp, seqid);
+	task = nfs4_do_unlck(request,
+			     nfs_file_open_context(request->fl_core.flc_file),
+			     lsp, seqid);
 	status = PTR_ERR(task);
 	if (IS_ERR(task))
 		goto out;
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = saved_flags;
+	request->fl_core.flc_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7191,7 +7193,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
 				data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
-			data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
+			data->fl.fl_core.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
 			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
 				goto out_restart;
 		}
@@ -7292,7 +7294,8 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
+	data = nfs4_alloc_lockdata(fl,
+				   nfs_file_open_context(fl->fl_core.flc_file),
 				   fl->fl_u.nfs4_fl.owner, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -7398,10 +7401,10 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char flags = request->fl_flags;
+	unsigned char flags = request->fl_core.flc_flags;
 	int status;
 
-	request->fl_flags |= FL_ACCESS;
+	request->fl_core.flc_flags |= FL_ACCESS;
 	status = locks_lock_inode_wait(state->inode, request);
 	if (status < 0)
 		goto out;
@@ -7410,7 +7413,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = flags & ~FL_SLEEP;
+		request->fl_core.flc_flags = flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7420,7 +7423,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = flags;
+	request->fl_core.flc_flags = flags;
 	return status;
 }
 
@@ -7562,7 +7565,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (!(IS_SETLK(cmd) || IS_SETLKW(cmd)))
 		return -EINVAL;
 
-	if (request->fl_type == F_UNLCK) {
+	if (request->fl_core.flc_type == F_UNLCK) {
 		if (state != NULL)
 			return nfs4_proc_unlck(state, cmd, request);
 		return 0;
@@ -7571,7 +7574,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (state == NULL)
 		return -ENOLCK;
 
-	if ((request->fl_flags & FL_POSIX) &&
+	if ((request->fl_core.flc_flags & FL_POSIX) &&
 	    !test_bit(NFS_STATE_POSIX_LOCKS, &state->flags))
 		return -ENOLCK;
 
@@ -7579,7 +7582,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	 * Don't rely on the VFS having checked the file open mode,
 	 * since it won't do this for flock() locks.
 	 */
-	switch (request->fl_type) {
+	switch (request->fl_core.flc_type) {
 	case F_RDLCK:
 		if (!(filp->f_mode & FMODE_READ))
 			return -EBADF;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 471caf06fa7b..dfa844ff76b8 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -980,7 +980,7 @@ int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl)
 
 	if (fl->fl_ops != NULL)
 		return 0;
-	lsp = nfs4_get_lock_state(state, fl->fl_owner);
+	lsp = nfs4_get_lock_state(state, fl->fl_core.flc_owner);
 	if (lsp == NULL)
 		return -ENOMEM;
 	fl->fl_u.nfs4_fl.owner = lsp;
@@ -1529,8 +1529,8 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+	list_for_each_entry(fl, list, fl_core.flc_list) {
+		if (nfs_file_open_context(fl->fl_core.flc_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = ops->recover_lock(state, fl);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d27919d7241d..8cdafca2bb7f 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -699,7 +699,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->fl_core.flc_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
@@ -771,7 +771,7 @@ TRACE_EVENT(nfs4_set_lock,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->fl_core.flc_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69406e60f391..5ff343cd4813 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1305,7 +1305,7 @@ static void encode_link(struct xdr_stream *xdr, const struct qstr *name, struct
 
 static inline int nfs4_lock_type(struct file_lock *fl, int block)
 {
-	if (fl->fl_type == F_RDLCK)
+	if (fl->fl_core.flc_type == F_RDLCK)
 		return block ? NFS4_READW_LT : NFS4_READ_LT;
 	return block ? NFS4_WRITEW_LT : NFS4_WRITE_LT;
 }
@@ -5052,10 +5052,10 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 		fl->fl_end = fl->fl_start + (loff_t)length - 1;
 		if (length == ~(uint64_t)0)
 			fl->fl_end = OFFSET_MAX;
-		fl->fl_type = F_WRLCK;
+		fl->fl_core.flc_type = F_WRLCK;
 		if (type & 1)
-			fl->fl_type = F_RDLCK;
-		fl->fl_pid = 0;
+			fl->fl_core.flc_type = F_RDLCK;
+		fl->fl_core.flc_pid = 0;
 	}
 	p = xdr_decode_hyper(p, &clientid); /* read 8 bytes */
 	namelen = be32_to_cpup(p); /* read 4 bytes */  /* have read all 32 bytes now */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ed837a3675cf..627700e03371 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -25,7 +25,6 @@
 #include <linux/freezer.h>
 #include <linux/wait.h>
 #include <linux/iversion.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include <linux/uaccess.h>
@@ -1302,7 +1301,7 @@ static bool
 is_whole_file_wrlock(struct file_lock *fl)
 {
 	return fl->fl_start == 0 && fl->fl_end == OFFSET_MAX &&
-			fl->fl_type == F_WRLCK;
+			fl->fl_core.flc_type == F_WRLCK;
 }
 
 /* If we know the page is up to date, and we're not using byte range locks (or
@@ -1336,13 +1335,13 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	spin_lock(&flctx->flc_lock);
 	if (!list_empty(&flctx->flc_posix)) {
 		fl = list_first_entry(&flctx->flc_posix, struct file_lock,
-					fl_list);
+					fl_core.flc_list);
 		if (is_whole_file_wrlock(fl))
 			ret = 1;
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
-					fl_list);
-		if (fl->fl_type == F_WRLCK)
+					fl_core.flc_list);
+		if (fl->fl_core.flc_type == F_WRLCK)
 			ret = 1;
 	}
 	spin_unlock(&flctx->flc_lock);

-- 
2.43.0


