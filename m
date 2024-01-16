Return-Path: <linux-fsdevel+bounces-8099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54682F732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF07283FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2177657;
	Tue, 16 Jan 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXwWGUVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E577638;
	Tue, 16 Jan 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434423; cv=none; b=TR1HtH3PwLzj38MVjqgxN3cgiXkVCV9kUG77sn5KWwU80mzhHmqvdjeGc+dfbOamS7aKgLrFzqK8cIHxQ5/nry0tMrHuaAEJjjSJR1EybxomhaNjYEtcOm+75Gf/u+pOnui0QHQYtMO25ZH70h1hKN78FdtLPU/RJ8IqGMc4RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434423; c=relaxed/simple;
	bh=sNgqF4g3YkfoRNDeTqn9koZ5jWcSEtfwfxCLcnzjt9A=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=s3W7ml2DPsq7DzTlAU29nKhtJM2ivx1pAjphLLZXV28cs+3+beHzamdH34AkLGxlZgNlkWpmWn882DWxe2dLRUglo3wSrD2nwQpJyKMOPQNWauJxL5GxY9iVydLYFsTMXxdYjKKwEFW8Bw4WNL0tR3zCUMCWDZqmGmdJb2UM1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXwWGUVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114B1C43142;
	Tue, 16 Jan 2024 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434422;
	bh=sNgqF4g3YkfoRNDeTqn9koZ5jWcSEtfwfxCLcnzjt9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UXwWGUVNLOyImBi0FwLHW/af8BuSJv1rz7Rmtr6qrI+NacZ7B8xX8sOV9XNaZbHuR
	 1AcIzdTy9jBSzTqnRlwlu41UzwdSAhIY+iXdB703ICxG3uEGAud+2A3if464k3IhTU
	 JBxMAd7nwTp8ma2o8s50j6GG9wYiwKT4mkclH7nWm19VB8zAxYuOKWXl8os7W+SE4a
	 GAHbcECajDB/aTB+gFQTykB0/T9P8BQ7MTFS7Sl8/2oMc4aREyfNdwf+KFjNl4OPWP
	 3h9V8A5xLDnD8BcpkoNb7ZsxUoQ60mOzfS3atHc857MMvZ4kgOIYdmlf3D317Hhl+0
	 7uk/bL8h/h97A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:00 -0500
Subject: [PATCH 04/20] filelock: fixups after the coccinelle changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-4-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
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
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=38946; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sNgqF4g3YkfoRNDeTqn9koZ5jWcSEtfwfxCLcnzjt9A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0gpBf4It/+V2rYmGOh2ir8HoKcSwmbdR1q5
 jnSMPw0hXqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FQvAEADCgtHOozUXGOG5N2es6Qe/qzhVNiQOSWtMJxZcse7A9rPs4E1E/63QSZW+6lLgNp5Vhiv
 B15honhTrDA1OmwjhTx4R450ntsd2nnxcjkDSMApkW3GvKE35Pya/jFEifSRYolwtvOv4j4U822
 pMLxtuYRPkpLCU0eRGgDNpeQ/NmLuVNyGs+laopzq3g7JeOqSLJ4Vxabz50iK6de0yLIXI1bwyW
 zFPllupxo/M9QOoSD5Je2XkL3kiQSWiXuUOGFh2tdrFv1S9Nd9Fi8fIvJT4KaC9F8OZGg0ymMWt
 wj0og9Hk3UldQctvQtHdsEsg4frH/GhKeZCvXUec41fhCkaFRalyb32lEzzQKB0ygvoZhWZLzQ5
 7YSfPU6HOpnjufjI1TOI+sGFplnK3SnT1Pl5cHUzAZefypAIotOiFuyVmqVn6dwIgXebZLToyG9
 aEVySSISURDoP8ctYDMKq8rbbUXqU8XDepr6DIMONs/0knZ3wNQiHaQw40bM+ai7KK7gGfK/Ioy
 ekK91j/jH1f1xPGuXFZnqBT4apkyNjctX10zzZLyYewzg2YxyNqOwj3fBViatZDkdN8cgQ429wr
 3RMQKMjdTXZpqNx4F8Oy+78Ix4rE62kUo+fKfHyTzcnwGMmqqHg2Ejm1sY3b67O/qaavSXr1uwp
 FbtfdeOJFsogPqg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The coccinelle script doesn't catch quite everythng (particularly with
embedded structs). These are some by-hand fixups after the split of
common fields into struct file_lock_core.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/locks.c                 |  8 ++---
 fs/lockd/clnt4xdr.c             |  8 ++---
 fs/lockd/clntproc.c             |  6 ++--
 fs/lockd/clntxdr.c              |  8 ++---
 fs/lockd/svc4proc.c             | 10 +++---
 fs/lockd/svclock.c              | 54 +++++++++++++++++----------------
 fs/lockd/svcproc.c              | 10 +++---
 fs/lockd/svcsubs.c              |  4 +--
 fs/lockd/xdr.c                  |  8 ++---
 fs/lockd/xdr4.c                 |  8 ++---
 fs/locks.c                      | 67 +++++++++++++++++++++--------------------
 fs/nfs/delegation.c             |  2 +-
 fs/nfs/nfs4state.c              |  2 +-
 fs/nfs/nfs4trace.h              |  4 +--
 fs/nfs/write.c                  |  4 +--
 fs/nfsd/nfs4callback.c          |  2 +-
 fs/nfsd/nfs4state.c             |  4 +--
 fs/smb/client/file.c            |  2 +-
 fs/smb/server/vfs.c             |  2 +-
 include/trace/events/afs.h      |  4 +--
 include/trace/events/filelock.h | 32 ++++++++++----------
 21 files changed, 126 insertions(+), 123 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ee12f9864980..55be5d231e38 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -386,9 +386,9 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 	ctx = locks_inode_context(inode);
 	if (ctx) {
 		spin_lock(&ctx->flc_lock);
-		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
+		list_for_each_entry(lock, &ctx->flc_posix, fl_core.fl_list)
 			++(*fcntl_count);
-		list_for_each_entry(lock, &ctx->flc_flock, fl_list)
+		list_for_each_entry(lock, &ctx->flc_flock, fl_core.fl_list)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
@@ -455,7 +455,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(lock, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(lock, &ctx->flc_posix, fl_core.fl_list) {
 		++seen_fcntl;
 		if (seen_fcntl > num_fcntl_locks) {
 			err = -ENOSPC;
@@ -466,7 +466,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 			goto fail;
 		++l;
 	}
-	list_for_each_entry(lock, &ctx->flc_flock, fl_list) {
+	list_for_each_entry(lock, &ctx->flc_flock, fl_core.fl_list) {
 		++seen_flock;
 		if (seen_flock > num_flock_locks) {
 			err = -ENOSPC;
diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index ed00bd2869a7..083a3b1bf288 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -243,7 +243,7 @@ static void encode_nlm4_holder(struct xdr_stream *xdr,
 	u64 l_offset, l_len;
 	__be32 *p;
 
-	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_RDLCK);
 	encode_int32(xdr, lock->svid);
 	encode_netobj(xdr, lock->oh.data, lock->oh.len);
 
@@ -357,7 +357,7 @@ static void nlm4_xdr_enc_testargs(struct rpc_rqst *req,
 	const struct nlm_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 }
 
@@ -380,7 +380,7 @@ static void nlm4_xdr_enc_lockargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 	encode_bool(xdr, args->reclaim);
 	encode_int32(xdr, args->state);
@@ -403,7 +403,7 @@ static void nlm4_xdr_enc_cancargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 }
 
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index ac1d07034346..15461e8952b4 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -143,7 +143,7 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	lock->svid = fl->fl_u.nfs_fl.owner->pid;
 	lock->fl.fl_start = fl->fl_start;
 	lock->fl.fl_end = fl->fl_end;
-	lock->fl.fl_type = fl->fl_core.fl_type;
+	lock->fl.fl_core.fl_type = fl->fl_core.fl_type;
 }
 
 static void nlmclnt_release_lockargs(struct nlm_rqst *req)
@@ -448,8 +448,8 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 			 */
 			fl->fl_start = req->a_res.lock.fl.fl_start;
 			fl->fl_end = req->a_res.lock.fl.fl_end;
-			fl->fl_core.fl_type = req->a_res.lock.fl.fl_type;
-			fl->fl_core.fl_pid = -req->a_res.lock.fl.fl_pid;
+			fl->fl_core.fl_type = req->a_res.lock.fl.fl_core.fl_type;
+			fl->fl_core.fl_pid = -req->a_res.lock.fl.fl_core.fl_pid;
 			break;
 		default:
 			status = nlm_stat_to_errno(req->a_res.status);
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index b0b87a00cd81..6823e2d3bf75 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -238,7 +238,7 @@ static void encode_nlm_holder(struct xdr_stream *xdr,
 	u32 l_offset, l_len;
 	__be32 *p;
 
-	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_RDLCK);
 	encode_int32(xdr, lock->svid);
 	encode_netobj(xdr, lock->oh.data, lock->oh.len);
 
@@ -357,7 +357,7 @@ static void nlm_xdr_enc_testargs(struct rpc_rqst *req,
 	const struct nlm_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 }
 
@@ -380,7 +380,7 @@ static void nlm_xdr_enc_lockargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 	encode_bool(xdr, args->reclaim);
 	encode_int32(xdr, args->state);
@@ -403,7 +403,7 @@ static void nlm_xdr_enc_cancargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 }
 
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b72023a6b4c1..fc98c3c74da8 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -52,16 +52,16 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.fl_flags = FL_POSIX;
-		lock->fl.fl_file  = file->f_file[mode];
-		lock->fl.fl_pid = current->tgid;
+		lock->fl.fl_core.fl_flags = FL_POSIX;
+		lock->fl.fl_core.fl_file  = file->f_file[mode];
+		lock->fl.fl_core.fl_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
 		lock->fl.fl_end = lock->lock_len ?
 				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
 				   OFFSET_MAX;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
-		if (!lock->fl.fl_owner) {
+		if (!lock->fl.fl_core.fl_owner) {
 			/* lockowner allocation has failed */
 			nlmsvc_release_host(host);
 			return nlm_lck_denied_nolocks;
@@ -106,7 +106,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.fl_owner;
+	test_owner = argp->lock.fl.fl_core.fl_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
 	if (resp->status == nlm_drop_reply)
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 520886a4b57e..59973f9d0406 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -150,9 +150,10 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 	struct file_lock	*fl;
 
 	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
-				file, lock->fl.fl_pid,
+				file, lock->fl.fl_core.fl_pid,
 				(long long)lock->fl.fl_start,
-				(long long)lock->fl.fl_end, lock->fl.fl_type);
+				(long long)lock->fl.fl_end,
+				lock->fl.fl_core.fl_type);
 	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
@@ -244,7 +245,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
 		goto failed_free;
 
 	/* Set notifier function for VFS, and init args */
-	call->a_args.lock.fl.fl_flags |= FL_SLEEP;
+	call->a_args.lock.fl.fl_core.fl_flags |= FL_SLEEP;
 	call->a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
 	nlmclnt_next_cookie(&call->a_args.cookie);
 
@@ -402,8 +403,8 @@ static struct nlm_lockowner *nlmsvc_find_lockowner(struct nlm_host *host, pid_t
 void
 nlmsvc_release_lockowner(struct nlm_lock *lock)
 {
-	if (lock->fl.fl_owner)
-		nlmsvc_put_lockowner(lock->fl.fl_owner);
+	if (lock->fl.fl_core.fl_owner)
+		nlmsvc_put_lockowner(lock->fl.fl_core.fl_owner);
 }
 
 void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
@@ -425,7 +426,7 @@ static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
 
 	/* set default data area */
 	call->a_args.lock.oh.data = call->a_owner;
-	call->a_args.lock.svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
+	call->a_args.lock.svid = ((struct nlm_lockowner *) lock->fl.fl_core.fl_owner)->pid;
 
 	if (lock->oh.len > NLMCLNT_OHSIZE) {
 		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
@@ -489,7 +490,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
 				inode->i_sb->s_id, inode->i_ino,
-				lock->fl.fl_type, lock->fl.fl_pid,
+				lock->fl.fl_core.fl_type,
+				lock->fl.fl_core.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end,
 				wait);
@@ -512,7 +514,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			goto out;
 		lock = &block->b_call->a_args.lock;
 	} else
-		lock->fl.fl_flags &= ~FL_SLEEP;
+		lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
 
 	if (block->b_flags & B_QUEUED) {
 		dprintk("lockd: nlmsvc_lock deferred block %p flags %d\n",
@@ -560,10 +562,10 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	spin_unlock(&nlm_blocked_lock);
 
 	if (!wait)
-		lock->fl.fl_flags &= ~FL_SLEEP;
+		lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
 	mode = lock_to_openmode(&lock->fl);
 	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
-	lock->fl.fl_flags &= ~FL_SLEEP;
+	lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
 
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
 	switch (error) {
@@ -616,7 +618,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_type,
+				lock->fl.fl_core.fl_type,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
@@ -636,19 +638,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	if (lock->fl.fl_type == F_UNLCK) {
+	if (lock->fl.fl_core.fl_type == F_UNLCK) {
 		ret = nlm_granted;
 		goto out;
 	}
 
 	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
-		lock->fl.fl_type, (long long)lock->fl.fl_start,
+		lock->fl.fl_core.fl_type, (long long)lock->fl.fl_start,
 		(long long)lock->fl.fl_end);
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.fl_pid;
-	conflock->fl.fl_type = lock->fl.fl_type;
+	conflock->svid = lock->fl.fl_core.fl_pid;
+	conflock->fl.fl_core.fl_type = lock->fl.fl_core.fl_type;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
 	locks_release_private(&lock->fl);
@@ -673,21 +675,21 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_pid,
+				lock->fl.fl_core.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
 	/* First, cancel any lock that might be there */
 	nlmsvc_cancel_blocked(net, file, lock);
 
-	lock->fl.fl_type = F_UNLCK;
-	lock->fl.fl_file = file->f_file[O_RDONLY];
-	if (lock->fl.fl_file)
-		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
+	lock->fl.fl_core.fl_type = F_UNLCK;
+	lock->fl.fl_core.fl_file = file->f_file[O_RDONLY];
+	if (lock->fl.fl_core.fl_file)
+		error = vfs_lock_file(lock->fl.fl_core.fl_file, F_SETLK,
 					&lock->fl, NULL);
-	lock->fl.fl_file = file->f_file[O_WRONLY];
-	if (lock->fl.fl_file)
-		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
+	lock->fl.fl_core.fl_file = file->f_file[O_WRONLY];
+	if (lock->fl.fl_core.fl_file)
+		error |= vfs_lock_file(lock->fl.fl_core.fl_file, F_SETLK,
 					&lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
@@ -710,7 +712,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_pid,
+				lock->fl.fl_core.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
@@ -863,12 +865,12 @@ nlmsvc_grant_blocked(struct nlm_block *block)
 	/* vfs_lock_file() can mangle fl_start and fl_end, but we need
 	 * them unchanged for the GRANT_MSG
 	 */
-	lock->fl.fl_flags |= FL_SLEEP;
+	lock->fl.fl_core.fl_flags |= FL_SLEEP;
 	fl_start = lock->fl.fl_start;
 	fl_end = lock->fl.fl_end;
 	mode = lock_to_openmode(&lock->fl);
 	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
-	lock->fl.fl_flags &= ~FL_SLEEP;
+	lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
 	lock->fl.fl_start = fl_start;
 	lock->fl.fl_end = fl_end;
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 32784f508c81..1809a1055e1e 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -77,12 +77,12 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		mode = lock_to_openmode(&lock->fl);
-		lock->fl.fl_flags = FL_POSIX;
-		lock->fl.fl_file  = file->f_file[mode];
-		lock->fl.fl_pid = current->tgid;
+		lock->fl.fl_core.fl_flags = FL_POSIX;
+		lock->fl.fl_core.fl_file  = file->f_file[mode];
+		lock->fl.fl_core.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
-		if (!lock->fl.fl_owner) {
+		if (!lock->fl.fl_core.fl_owner) {
 			/* lockowner allocation has failed */
 			nlmsvc_release_host(host);
 			return nlm_lck_denied_nolocks;
@@ -127,7 +127,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.fl_owner;
+	test_owner = argp->lock.fl.fl_core.fl_owner;
 
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 61b5c7ef8a12..f7e7ec6ac6df 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -218,7 +218,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 again:
 	file->f_locks = 0;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+	list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
 		if (fl->fl_lmops != &nlmsvc_lock_operations)
 			continue;
 
@@ -272,7 +272,7 @@ nlm_file_inuse(struct nlm_file *file)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
 			if (fl->fl_lmops == &nlmsvc_lock_operations) {
 				spin_unlock(&flctx->flc_lock);
 				return 1;
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 4a676a51eb6c..91611a909ad4 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -164,7 +164,7 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 
 	return true;
 }
@@ -184,7 +184,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
@@ -209,7 +209,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 
 	return true;
 }
@@ -223,7 +223,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
-	argp->lock.fl.fl_type = F_UNLCK;
+	argp->lock.fl.fl_core.fl_type = F_UNLCK;
 
 	return true;
 }
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 67e53f91717a..ba0206d28457 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -159,7 +159,7 @@ nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 
 	return true;
 }
@@ -179,7 +179,7 @@ nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
@@ -204,7 +204,7 @@ nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.fl_type = F_WRLCK;
 
 	return true;
 }
@@ -218,7 +218,7 @@ nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
-	argp->lock.fl.fl_type = F_UNLCK;
+	argp->lock.fl.fl_core.fl_type = F_UNLCK;
 
 	return true;
 }
diff --git a/fs/locks.c b/fs/locks.c
index cd6ffa22a1ce..afe6e82a6207 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -70,11 +70,11 @@
 
 #include <linux/uaccess.h>
 
-#define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
-#define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
-#define IS_LEASE(fl)	(fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
-#define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
-#define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
+#define IS_POSIX(fl)	(fl->fl_core.fl_flags & FL_POSIX)
+#define IS_FLOCK(fl)	(fl->fl_core.fl_flags & FL_FLOCK)
+#define IS_LEASE(fl)	(fl->fl_core.fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
+#define IS_OFDLCK(fl)	(fl->fl_core.fl_flags & FL_OFDLCK)
+#define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <= 0)
 
 static bool lease_breaking(struct file_lock *fl)
 {
@@ -206,7 +206,7 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
 {
 	struct file_lock *fl;
 
-	list_for_each_entry(fl, list, fl_list) {
+	list_for_each_entry(fl, list, fl_core.fl_list) {
 		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
 			fl->fl_core.fl_owner, fl->fl_core.fl_flags,
 			fl->fl_core.fl_type, fl->fl_core.fl_pid);
@@ -237,7 +237,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 	struct file_lock *fl;
 	struct inode *inode = file_inode(filp);
 
-	list_for_each_entry(fl, list, fl_list)
+	list_for_each_entry(fl, list, fl_core.fl_list)
 		if (fl->fl_core.fl_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
@@ -318,7 +318,7 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 	struct file_lock *fl;
 
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+	list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
 		if (fl->fl_core.fl_owner != owner)
 			continue;
 		if (!list_empty(&fl->fl_core.fl_blocked_requests)) {
@@ -345,7 +345,7 @@ locks_dispose_list(struct list_head *dispose)
 	struct file_lock *fl;
 
 	while (!list_empty(dispose)) {
-		fl = list_first_entry(dispose, struct file_lock, fl_list);
+		fl = list_first_entry(dispose, struct file_lock, fl_core.fl_list);
 		list_del_init(&fl->fl_core.fl_list);
 		locks_free_lock(fl);
 	}
@@ -412,7 +412,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 	list_splice_init(&fl->fl_core.fl_blocked_requests,
 			 &new->fl_core.fl_blocked_requests);
 	list_for_each_entry(f, &new->fl_core.fl_blocked_requests,
-			    fl_blocked_member)
+			    fl_core.fl_blocked_member)
 		f->fl_core.fl_blocker = new;
 	spin_unlock(&blocked_lock_lock);
 }
@@ -675,7 +675,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 		struct file_lock *waiter;
 
 		waiter = list_first_entry(&blocker->fl_core.fl_blocked_requests,
-					  struct file_lock, fl_blocked_member);
+					  struct file_lock, fl_core.fl_blocked_member);
 		__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
@@ -767,7 +767,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 
 new_blocker:
 	list_for_each_entry(fl, &blocker->fl_core.fl_blocked_requests,
-			    fl_blocked_member)
+			    fl_core.fl_blocked_member)
 		if (conflict(fl, waiter)) {
 			blocker =  fl;
 			goto new_blocker;
@@ -922,7 +922,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 
 retry:
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(cfl, &ctx->flc_posix, fl_core.fl_list) {
 		if (!posix_test_locks_conflict(fl, cfl))
 			continue;
 		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
@@ -985,7 +985,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 {
 	struct file_lock *fl;
 
-	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
+	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(block_fl)) {
 		if (posix_same_owner(fl, block_fl)) {
 			while (fl->fl_core.fl_blocker)
 				fl = fl->fl_core.fl_blocker;
@@ -1053,7 +1053,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	if (request->fl_core.fl_flags & FL_ACCESS)
 		goto find_conflict;
 
-	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_flock, fl_core.fl_list) {
 		if (request->fl_core.fl_file != fl->fl_core.fl_file)
 			continue;
 		if (request->fl_core.fl_type == fl->fl_core.fl_type)
@@ -1070,7 +1070,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	}
 
 find_conflict:
-	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_flock, fl_core.fl_list) {
 		if (!flock_locks_conflict(request, fl))
 			continue;
 		error = -EAGAIN;
@@ -1139,7 +1139,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * blocker's list of waiters and the global blocked_hash.
 	 */
 	if (request->fl_core.fl_type != F_UNLCK) {
-		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+		list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
 			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
@@ -1185,13 +1185,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		goto out;
 
 	/* Find the first old lock with the same owner as the new lock */
-	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
 		if (posix_same_owner(request, fl))
 			break;
 	}
 
 	/* Process locks with this owner. */
-	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
+	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_core.fl_list) {
 		if (!posix_same_owner(request, fl))
 			break;
 
@@ -1433,7 +1433,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list) {
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
@@ -1472,7 +1472,7 @@ any_leases_conflict(struct inode *inode, struct file_lock *breaker)
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
 		if (leases_conflict(fl, breaker))
 			return true;
 	}
@@ -1528,7 +1528,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			break_time++;	/* so that 0 means no break time */
 	}
 
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list) {
 		if (!leases_conflict(fl, new_fl))
 			continue;
 		if (want_write) {
@@ -1556,7 +1556,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 restart:
-	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_list);
+	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_core.fl_list);
 	break_time = fl->fl_break_time;
 	if (break_time != 0)
 		break_time -= jiffies;
@@ -1616,7 +1616,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
-					      struct file_lock, fl_list);
+					      struct file_lock, fl_core.fl_list);
 		if (fl && (fl->fl_core.fl_type == F_WRLCK))
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
@@ -1663,7 +1663,7 @@ int fcntl_getlease(struct file *filp)
 		percpu_down_read(&file_rwsem);
 		spin_lock(&ctx->flc_lock);
 		time_out_leases(inode, &dispose);
-		list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
 			if (fl->fl_core.fl_file != filp)
 				continue;
 			type = target_leasetype(fl);
@@ -1768,7 +1768,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	 * except for this filp.
 	 */
 	error = -EAGAIN;
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
 		if (fl->fl_core.fl_file == filp &&
 		    fl->fl_core.fl_owner == lease->fl_core.fl_owner) {
 			my_fl = fl;
@@ -1848,7 +1848,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
 		if (fl->fl_core.fl_file == filp &&
 		    fl->fl_core.fl_owner == owner) {
 			victim = fl;
@@ -2616,7 +2616,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list)
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list)
 		if (filp == fl->fl_core.fl_file)
 			lease_modify(fl, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
@@ -2781,8 +2781,9 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 		return NULL;
 
 	/* Next member in the linked list could be itself */
-	tmp = list_next_entry(node, fl_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_blocked_requests, fl_blocked_member)
+	tmp = list_next_entry(node, fl_core.fl_blocked_member);
+	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_core.fl_blocked_requests,
+			       fl_core.fl_blocked_member)
 		|| tmp == node) {
 		return NULL;
 	}
@@ -2797,7 +2798,7 @@ static int locks_show(struct seq_file *f, void *v)
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int level = 0;
 
-	cur = hlist_entry(v, struct file_lock, fl_link);
+	cur = hlist_entry(v, struct file_lock, fl_core.fl_link);
 
 	if (locks_translate_pid(cur, proc_pidns) == 0)
 		return 0;
@@ -2817,7 +2818,7 @@ static int locks_show(struct seq_file *f, void *v)
 			/* Turn left */
 			cur = list_first_entry_or_null(&cur->fl_core.fl_blocked_requests,
 						       struct file_lock,
-						       fl_blocked_member);
+						       fl_core.fl_blocked_member);
 			level++;
 		} else {
 			/* Turn right */
@@ -2841,7 +2842,7 @@ static void __show_fd_locks(struct seq_file *f,
 {
 	struct file_lock *fl;
 
-	list_for_each_entry(fl, head, fl_list) {
+	list_for_each_entry(fl, head, fl_core.fl_list) {
 
 		if (filp != fl->fl_core.fl_file)
 			continue;
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 31741967ab95..8c7c31d846a0 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -156,7 +156,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	list = &flctx->flc_posix;
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	list_for_each_entry(fl, list, fl_core.fl_list) {
 		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a148b6ac4713..2d51523be647 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1529,7 +1529,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	list_for_each_entry(fl, list, fl_core.fl_list) {
 		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d27919d7241d..41fbbc626cc3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -699,7 +699,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->fl_core.fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
@@ -771,7 +771,7 @@ TRACE_EVENT(nfs4_set_lock,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
-			__entry->type = request->fl_type;
+			__entry->type = request->fl_core.fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index a096c84c4678..b2a6c8c3078d 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1335,12 +1335,12 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	spin_lock(&flctx->flc_lock);
 	if (!list_empty(&flctx->flc_posix)) {
 		fl = list_first_entry(&flctx->flc_posix, struct file_lock,
-					fl_list);
+					fl_core.fl_list);
 		if (is_whole_file_wrlock(fl))
 			ret = 1;
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
-					fl_list);
+					fl_core.fl_list);
 		if (fl->fl_core.fl_type == F_WRLCK)
 			ret = 1;
 	}
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 926c29879c6a..e32ad2492eb1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -674,7 +674,7 @@ static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
 	const struct nfsd4_callback *cb = data;
 	const struct nfsd4_blocked_lock *nbl =
 		container_of(cb, struct nfsd4_blocked_lock, nbl_cb);
-	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_owner;
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_core.fl_owner;
 	struct nfs4_cb_compound_hdr hdr = {
 		.ident = 0,
 		.minorversion = cb->cb_clp->cl_minorversion,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a6089dbcee9d..cf5d0b3a553f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7927,7 +7927,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
 			if (fl->fl_core.fl_owner == (fl_owner_t)lowner) {
 				status = true;
 				break;
@@ -8456,7 +8456,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 	if (!ctx)
 		return 0;
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
 		if (fl->fl_core.fl_flags == FL_LAYOUT)
 			continue;
 		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1305183842fd..024afd3a81d4 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1581,7 +1581,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 
 	el = locks_to_send.next;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(flock, &flctx->flc_posix, fl_list) {
+	list_for_each_entry(flock, &flctx->flc_posix, fl_core.fl_list) {
 		if (el == &locks_to_send) {
 			/*
 			 * The list ended. We don't have enough allocated
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index f7bb6f19492b..c2abb9b6100d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -337,7 +337,7 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(flock, &ctx->flc_posix, fl_core.fl_list) {
 		/* check conflict locks */
 		if (flock->fl_end >= start && end >= flock->fl_start) {
 			if (flock->fl_core.fl_type == F_RDLCK) {
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5194b7e6dc8d..bd6cf09856b3 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1195,8 +1195,8 @@ TRACE_EVENT(afs_flock_op,
 		    __entry->from = fl->fl_start;
 		    __entry->len = fl->fl_end - fl->fl_start + 1;
 		    __entry->op = op;
-		    __entry->type = fl->fl_type;
-		    __entry->flags = fl->fl_flags;
+		    __entry->type = fl->fl_core.fl_type;
+		    __entry->flags = fl->fl_core.fl_flags;
 		    __entry->debug_id = fl->fl_u.afs.debug_id;
 			   ),
 
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 1646dadd7f37..92ed07544f94 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -82,11 +82,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_pid = fl ? fl->fl_pid : 0;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->fl_blocker = fl ? fl->fl_core.fl_blocker : NULL;
+		__entry->fl_owner = fl ? fl->fl_core.fl_owner : NULL;
+		__entry->fl_pid = fl ? fl->fl_core.fl_pid : 0;
+		__entry->fl_flags = fl ? fl->fl_core.fl_flags : 0;
+		__entry->fl_type = fl ? fl->fl_core.fl_type : 0;
 		__entry->fl_start = fl ? fl->fl_start : 0;
 		__entry->fl_end = fl ? fl->fl_end : 0;
 		__entry->ret = ret;
@@ -137,10 +137,10 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->fl_blocker = fl ? fl->fl_core.fl_blocker : NULL;
+		__entry->fl_owner = fl ? fl->fl_core.fl_owner : NULL;
+		__entry->fl_flags = fl ? fl->fl_core.fl_flags : 0;
+		__entry->fl_type = fl ? fl->fl_core.fl_type : 0;
 		__entry->fl_break_time = fl ? fl->fl_break_time : 0;
 		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
@@ -190,9 +190,9 @@ TRACE_EVENT(generic_add_lease,
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
 		__entry->icount = atomic_read(&inode->i_count);
-		__entry->fl_owner = fl->fl_owner;
-		__entry->fl_flags = fl->fl_flags;
-		__entry->fl_type = fl->fl_type;
+		__entry->fl_owner = fl->fl_core.fl_owner;
+		__entry->fl_flags = fl->fl_core.fl_flags;
+		__entry->fl_type = fl->fl_core.fl_type;
 	),
 
 	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
@@ -220,11 +220,11 @@ TRACE_EVENT(leases_conflict,
 
 	TP_fast_assign(
 		__entry->lease = lease;
-		__entry->l_fl_flags = lease->fl_flags;
-		__entry->l_fl_type = lease->fl_type;
+		__entry->l_fl_flags = lease->fl_core.fl_flags;
+		__entry->l_fl_type = lease->fl_core.fl_type;
 		__entry->breaker = breaker;
-		__entry->b_fl_flags = breaker->fl_flags;
-		__entry->b_fl_type = breaker->fl_type;
+		__entry->b_fl_flags = breaker->fl_core.fl_flags;
+		__entry->b_fl_type = breaker->fl_core.fl_type;
 		__entry->conflict = conflict;
 	),
 

-- 
2.43.0


