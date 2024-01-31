Return-Path: <linux-fsdevel+bounces-9771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1D844C83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B776E29CC39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665DB14AD29;
	Wed, 31 Jan 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOh6aJ69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B14A0BE;
	Wed, 31 Jan 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742299; cv=none; b=YV0nAXrgQxgIQq0H2ofCeGzB65wrQs9nv8RM9EdISh7GdZPh+q3szFUQ2e7hZNmcZlKrEl39XJhuKfzS+p+9bOy4MaKVqOtTjrXmQpKvk1jrU8sC6EC/R2EFr5x4sa0z/Nx+D3YKnR/jB6eYjPGz0mSKctR583x7eu3H/k+7Okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742299; c=relaxed/simple;
	bh=9RCebd38P+8Es8cmjl3RvgO2QHoUDVRrYNbrLjIgX10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sN9I+GZ64/S0/m4I1ui4CjiwSusqMMVeRbhPYO2FWJHOqN1VCqv/hveGrVe0eOJOwUmFacpM6Iru3Czg0pEFx7QkuXmgIqi3fs9zMBabQ2HauaJ+ufHY9PFpHBT/ID22hyw08lnMU9cXziAg5IcbFjdEV0F6S+Ftul66Z0/W8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOh6aJ69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66301C43601;
	Wed, 31 Jan 2024 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742299;
	bh=9RCebd38P+8Es8cmjl3RvgO2QHoUDVRrYNbrLjIgX10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EOh6aJ69jvMgLYA6088c4owAZ0QP3wdxxVhH7lU9LkZryO5jH74ijcMdnUBG2TxVb
	 5G0hFlYfbMSLqDOpuWj+kXwxmohQvbHiDf7Qi0THH/PPduKV2h2h44y6T9K1a0U2RS
	 /9jD6j1WLMCT9b+1A3nL/pzZNf1Q3w8NduCI7qG6Sj8U5LwgKEOyxXp04rhIWdvp/m
	 Zh8K3cI9TvcMRkHq+pvXI8V5JEfD9PGgTYATEpch18RTMU7AVAB3rHfB1E2iWEzcd5
	 0DA4tgrCJKdmzH+VkeFUYs3VxHgYqCZtOxQr9ZADai0zISKfm/ND+6yfWYsm+8GEzY
	 oJomkOq54CjdQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:22 -0500
Subject: [PATCH v3 41/47] nfs: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-41-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12477; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9RCebd38P+8Es8cmjl3RvgO2QHoUDVRrYNbrLjIgX10=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzLWTAr4wtkrDrQiLE2t4BgvuoTIdcA29gj
 6HF75TgsViJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FZHOEADWeu+4u3JGvyVPbN3x19pWZtE4XF6xJOwj+Tkrfe3NQqmMu0e/oapCsXoxPRaywn1PvvK
 pSPjX8Zqvjl8lh0U9BcWTrdml/fmr52zWm7pOpKCqpt9KL6BaIsJz8zJMYW/OHYVrJx+vfwAU5L
 1Y1CVGMJD72ezK9AWBVHAcw3nUWYWu65DUo3B5jjE8LECHr0F9mbLE/2MD8GcatFi5dkqY8XWmI
 6zQK4KkOOWSe9O2+t0fTiYsBR6jat5S/nu8hJh+atejbW4Hku01XskJJ2d0iBRX4tjuvK3kwcJY
 13zve2GzHWHQLLtq6/tdwDoEfL6S3yimu34soxTIF+y1fzn++K1QUjKUdIVN4I2CU+xwjQ+VmsV
 EDDEkp155EG59POoutBB+6z/xREjYbCIcuFKEQePZ0O2u0ZmMgsMayBl5K5GGq25BTaey+X5C8b
 AjeHmANEjANW+y5hM8DLvEKqPDwvG4qUgWXBr8c0rHF35V2/8VyD2yIyzb28+zr+ucJPnpdEDFv
 OwxpE4cg+T0cJBANuOb7LKqMYLQHbJCbLUcGwQO94CbIDo/OUqwXWzKE6eap/R+ousrJeGsvZZa
 mlxj5Eg6CyItD+3balH3ZL/gx8kIvhxyY8h51ZemZmoR18YFi/cPSCVpU8IKgIYp6Tz7CYEWGQC
 1q2wXhFko3pchFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  2 +-
 fs/nfs/file.c       | 19 +++++++++----------
 fs/nfs/nfs3proc.c   |  2 +-
 fs/nfs/nfs4_fs.h    |  1 -
 fs/nfs/nfs4proc.c   | 33 ++++++++++++++++++---------------
 fs/nfs/nfs4state.c  |  4 ++--
 fs/nfs/nfs4trace.h  |  4 ++--
 fs/nfs/nfs4xdr.c    |  6 +++---
 fs/nfs/write.c      |  5 ++---
 9 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ca6985001466..d4a42ce0c7e3 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -157,7 +157,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	spin_lock(&flctx->flc_lock);
 restart:
 	for_each_file_lock(fl, list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+		if (nfs_file_open_context(fl->c.flc_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = nfs4_lock_delegation_recall(fl, state, stateid);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0b6691e64d27..407c6e15afe2 100644
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
+	unsigned int saved_type = fl->c.flc_type;
 
 	/* Try local locking first */
 	posix_test_lock(filp, fl);
-	if (fl->fl_type != F_UNLCK) {
+	if (fl->c.flc_type != F_UNLCK) {
 		/* found a conflict */
 		goto out;
 	}
-	fl->fl_type = saved_type;
+	fl->c.flc_type = saved_type;
 
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		goto out_noconflict;
@@ -741,7 +740,7 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 out:
 	return status;
 out_noconflict:
-	fl->fl_type = F_UNLCK;
+	fl->c.flc_type = F_UNLCK;
 	goto out;
 }
 
@@ -766,7 +765,7 @@ do_unlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 		 * 	If we're signalled while cleaning up locks on process exit, we
 		 * 	still need to complete the unlock.
 		 */
-		if (status < 0 && !(fl->fl_flags & FL_CLOSE))
+		if (status < 0 && !(fl->c.flc_flags & FL_CLOSE))
 			return status;
 	}
 
@@ -833,12 +832,12 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: lock(%pD2, t=%x, fl=%x, r=%lld:%lld)\n",
-			filp, fl->fl_type, fl->fl_flags,
+			filp, fl->c.flc_type, fl->c.flc_flags,
 			(long long)fl->fl_start, (long long)fl->fl_end);
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
-	if (fl->fl_flags & FL_RECLAIM)
+	if (fl->c.flc_flags & FL_RECLAIM)
 		return -ENOGRACE;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FCNTL)
@@ -870,9 +869,9 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: flock(%pD2, t=%x, fl=%x)\n",
-			filp, fl->fl_type, fl->fl_flags);
+			filp, fl->c.flc_type, fl->c.flc_flags);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FLOCK)
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2de66e4e8280..cbbe3f0193b8 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -963,7 +963,7 @@ nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
 	struct nfs_open_context *ctx = nfs_file_open_context(filp);
 	int status;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->c.flc_flags & FL_CLOSE) {
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
index df54fcd0fa08..91dddcd79004 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6800,7 +6800,7 @@ static int _nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	switch (status) {
 		case 0:
-			request->fl_type = F_UNLCK;
+			request->c.flc_type = F_UNLCK;
 			break;
 		case -NFS4ERR_DENIED:
 			status = 0;
@@ -7018,8 +7018,8 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 	/* Ensure this is an unlock - when canceling a lock, the
 	 * canceled lock is passed in, and it won't be an unlock.
 	 */
-	fl->fl_type = F_UNLCK;
-	if (fl->fl_flags & FL_CLOSE)
+	fl->c.flc_type = F_UNLCK;
+	if (fl->c.flc_flags & FL_CLOSE)
 		set_bit(NFS_CONTEXT_UNLOCK, &ctx->flags);
 
 	data = nfs4_alloc_unlockdata(fl, ctx, lsp, seqid);
@@ -7045,11 +7045,11 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char saved_flags = request->fl_flags;
+	unsigned char saved_flags = request->c.flc_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
-	request->fl_flags |= FL_EXISTS;
+	request->c.flc_flags |= FL_EXISTS;
 	/* Exclude nfs_delegation_claim_locks() */
 	mutex_lock(&sp->so_delegreturn_mutex);
 	/* Exclude nfs4_reclaim_open_stateid() - note nesting! */
@@ -7073,14 +7073,16 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = -ENOMEM;
 	if (IS_ERR(seqid))
 		goto out;
-	task = nfs4_do_unlck(request, nfs_file_open_context(request->fl_file), lsp, seqid);
+	task = nfs4_do_unlck(request,
+			     nfs_file_open_context(request->c.flc_file),
+			     lsp, seqid);
 	status = PTR_ERR(task);
 	if (IS_ERR(task))
 		goto out;
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = saved_flags;
+	request->c.flc_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7191,7 +7193,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
 				data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
-			data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
+			data->fl.c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
 			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
 				goto out_restart;
 		}
@@ -7292,7 +7294,8 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
+	data = nfs4_alloc_lockdata(fl,
+				   nfs_file_open_context(fl->c.flc_file),
 				   fl->fl_u.nfs4_fl.owner, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -7398,10 +7401,10 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char flags = request->fl_flags;
+	unsigned char flags = request->c.flc_flags;
 	int status;
 
-	request->fl_flags |= FL_ACCESS;
+	request->c.flc_flags |= FL_ACCESS;
 	status = locks_lock_inode_wait(state->inode, request);
 	if (status < 0)
 		goto out;
@@ -7410,7 +7413,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = flags & ~FL_SLEEP;
+		request->c.flc_flags = flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7420,7 +7423,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = flags;
+	request->c.flc_flags = flags;
 	return status;
 }
 
@@ -7571,7 +7574,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (state == NULL)
 		return -ENOLCK;
 
-	if ((request->fl_flags & FL_POSIX) &&
+	if ((request->c.flc_flags & FL_POSIX) &&
 	    !test_bit(NFS_STATE_POSIX_LOCKS, &state->flags))
 		return -ENOLCK;
 
@@ -7579,7 +7582,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	 * Don't rely on the VFS having checked the file open mode,
 	 * since it won't do this for flock() locks.
 	 */
-	switch (request->fl_type) {
+	switch (request->c.flc_type) {
 	case F_RDLCK:
 		if (!(filp->f_mode & FMODE_READ))
 			return -EBADF;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 16b57735e26a..8cfabdbda336 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -980,7 +980,7 @@ int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl)
 
 	if (fl->fl_ops != NULL)
 		return 0;
-	lsp = nfs4_get_lock_state(state, fl->fl_owner);
+	lsp = nfs4_get_lock_state(state, fl->c.flc_owner);
 	if (lsp == NULL)
 		return -ENOMEM;
 	fl->fl_u.nfs4_fl.owner = lsp;
@@ -1530,7 +1530,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	spin_lock(&flctx->flc_lock);
 restart:
 	for_each_file_lock(fl, list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+		if (nfs_file_open_context(fl->c.flc_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = ops->recover_lock(state, fl);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d27919d7241d..fd7cb15b08b2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -699,7 +699,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->c.flc_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
@@ -771,7 +771,7 @@ TRACE_EVENT(nfs4_set_lock,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->c.flc_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 6e309db5afe4..1416099dfcd1 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5052,10 +5052,10 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 		fl->fl_end = fl->fl_start + (loff_t)length - 1;
 		if (length == ~(uint64_t)0)
 			fl->fl_end = OFFSET_MAX;
-		fl->fl_type = F_WRLCK;
+		fl->c.flc_type = F_WRLCK;
 		if (type & 1)
-			fl->fl_type = F_RDLCK;
-		fl->fl_pid = 0;
+			fl->c.flc_type = F_RDLCK;
+		fl->c.flc_pid = 0;
 	}
 	p = xdr_decode_hyper(p, &clientid); /* read 8 bytes */
 	namelen = be32_to_cpup(p); /* read 4 bytes */  /* have read all 32 bytes now */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 13f2e10167ac..84bb85264572 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -25,7 +25,6 @@
 #include <linux/freezer.h>
 #include <linux/wait.h>
 #include <linux/iversion.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include <linux/uaccess.h>
@@ -1336,12 +1335,12 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	spin_lock(&flctx->flc_lock);
 	if (!list_empty(&flctx->flc_posix)) {
 		fl = list_first_entry(&flctx->flc_posix, struct file_lock,
-					fl_list);
+					c.flc_list);
 		if (is_whole_file_wrlock(fl))
 			ret = 1;
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
-					fl_list);
+					c.flc_list);
 		if (lock_is_write(fl))
 			ret = 1;
 	}

-- 
2.43.0


