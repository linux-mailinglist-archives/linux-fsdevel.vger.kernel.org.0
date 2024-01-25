Return-Path: <linux-fsdevel+bounces-8906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E214983BFF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9327C297849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082466B32;
	Thu, 25 Jan 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XghAqTgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DF664D7;
	Thu, 25 Jan 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179526; cv=none; b=M6zkvg0km43YjoVeWN5GxDZ/RNGOPNypl4jc1BoLrD8TH8KrGOoN1Cs5WRR4IdJOT9h9NFF1lhOeGfrfFaXxkp1jy0i8FJaYOLiQkEyLHzzKRV6JCAWY7MLEs53DYPJeuFzLeai66zXPyHxcZ7T1nTkWguard3YCD+AvKoW65bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179526; c=relaxed/simple;
	bh=rTCJibMk1UNHqXlykKT05CsM6TFSdjbS0RqhuQjRrw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2Z3KHqu55tqjj7l3OWHjGEtv9MQDCT10DHhfecOOsvbY3/yd01pLO8SL4XTgomFsiPDeYhp7PfLu5JxkM+VNR8+vzubNtqJSKNvRrEPyrvK+8e0tk+sVWB6m7F2bjtLJ6Av6FwqWqXCeOU+r7gYXgrt94aB8vOY03bbWoQszCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XghAqTgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C3C4166A;
	Thu, 25 Jan 2024 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179525;
	bh=rTCJibMk1UNHqXlykKT05CsM6TFSdjbS0RqhuQjRrw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XghAqTgREI2rP7sBbXByJg46WJAj0eWhGJmzCPUOoo84lfmCDjadCT14IXrbwt8JP
	 tZdgEr+mL0doRJN29DAE4PSSSluySRWKuKX4sC/GM+sleEbDIvA9Viu8kZrFlEEsnl
	 yaMdYBuE3ICtD8Y+HP4aZaBe8DXzTpRkenHiRB4isXy4Kz594O54rQPk5ihmP4HxCB
	 eSeRNY4U0JZ7fX58eBkZQaf3lwacau5b+rZra7I39On29Vp70Dbm7EQMZzRnhSKKfw
	 YtTVF2YWCfojrrEOBaxjmYTo+XEhfLuvgQ2rBtVDlgZk4m3WBJu+Ae1lAIr5i8UCZ/
	 RqWVVT/W+fE0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:15 -0500
Subject: [PATCH v2 34/41] lockd: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-34-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=31733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rTCJibMk1UNHqXlykKT05CsM6TFSdjbS0RqhuQjRrw8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+6XokPKSufTPVTycO9pdGJcEfp0ZIDPpez
 VPqWRyQxeGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FSP1D/9QpWbI5hjjP278+qC2wi285bBAjystazGsjiITeBUoIQWhVycZnlVhc7qSGEzmu+kuq97
 /hNcH32BV64vXfx99HE78Xrw0VPXFYIG87BhrG0rxSRGxXM3yUsPgoBA3BiS1tGZBzr3qlcKMUu
 w1kZSmddWrSYlFrt3qKuucplJRgsqL+FsCmlmSL28hVCxn57uS7TfezEYCaMeqyv/p6kALS81Hu
 eu2/Q0l4HejCYKubDwf3YAbIFp+d8XW7pyKAVfQ6wuru4Tm9db22x4YHyQji3g2sNvGXF9Y1d6m
 kXg+vmMiaJYSB76L3KHZVm1YdosS/fhffZW3+XdaGbJe6lR14w4txlUZw2Tb2GqqISlUDYZDC6d
 glq2ayeIgmfDco+n9r0N+8uYw4uSxa9qkots7NygQIvXbJZuzv2CF9/VMAMUUoNCk4e8BmXogSZ
 e7h+xmahpMV31lwdsPn0Tt/i+PmufAI9Mb7j3MaBbuurCrMP/Mqgy9C/RwlDNRGy7qPcQCL9kqH
 SU9SAFUjhGemS2az+Iy028Y/gaayWdB0+4GYMO4CXbeA8vx9CWKl4P7A8XdIhCWIw76Rst0ymTd
 l4QtyVOexNQ+ukBf577wbOcTehxeY1MM4kl4mAyMuC+BgEoZ4DtIZjZozTI99BST6WX5laRnSRD
 kfjUBZqFqz69j1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clnt4xdr.c         | 14 +++++-----
 fs/lockd/clntlock.c         |  2 +-
 fs/lockd/clntproc.c         | 62 +++++++++++++++++++++++--------------------
 fs/lockd/clntxdr.c          | 14 +++++-----
 fs/lockd/svc4proc.c         | 10 +++----
 fs/lockd/svclock.c          | 64 +++++++++++++++++++++++----------------------
 fs/lockd/svcproc.c          | 10 +++----
 fs/lockd/svcsubs.c          | 24 ++++++++---------
 fs/lockd/xdr.c              | 14 +++++-----
 fs/lockd/xdr4.c             | 14 +++++-----
 include/linux/lockd/lockd.h |  8 +++---
 include/linux/lockd/xdr.h   |  1 -
 12 files changed, 121 insertions(+), 116 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 8161667c976f..de58ec4ff374 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -243,7 +243,7 @@ static void encode_nlm4_holder(struct xdr_stream *xdr,
 	u64 l_offset, l_len;
 	__be32 *p;
 
-	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_RDLCK);
 	encode_int32(xdr, lock->svid);
 	encode_netobj(xdr, lock->oh.data, lock->oh.len);
 
@@ -270,7 +270,7 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 		goto out_overflow;
 	exclusive = be32_to_cpup(p++);
 	lock->svid = be32_to_cpup(p);
-	fl->fl_pid = (pid_t)lock->svid;
+	fl->fl_core.flc_pid = (pid_t)lock->svid;
 
 	error = decode_netobj(xdr, &lock->oh);
 	if (unlikely(error))
@@ -280,8 +280,8 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	if (unlikely(p == NULL))
 		goto out_overflow;
 
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
+	fl->fl_core.flc_flags = FL_POSIX;
+	fl->fl_core.flc_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	p = xdr_decode_hyper(p, &l_offset);
 	xdr_decode_hyper(p, &l_len);
 	nlm4svc_set_file_lock_range(fl, l_offset, l_len);
@@ -357,7 +357,7 @@ static void nlm4_xdr_enc_testargs(struct rpc_rqst *req,
 	const struct nlm_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 }
 
@@ -380,7 +380,7 @@ static void nlm4_xdr_enc_lockargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 	encode_bool(xdr, args->reclaim);
 	encode_int32(xdr, args->state);
@@ -403,7 +403,7 @@ static void nlm4_xdr_enc_cancargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm4_lock(xdr, lock);
 }
 
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 5d85715be763..eaa463f2d44d 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -185,7 +185,7 @@ __be32 nlmclnt_grant(const struct sockaddr *addr, const struct nlm_lock *lock)
 			continue;
 		if (!rpc_cmp_addr(nlm_addr(block->b_host), addr))
 			continue;
-		if (nfs_compare_fh(NFS_FH(file_inode(fl_blocked->fl_file)), fh) != 0)
+		if (nfs_compare_fh(NFS_FH(file_inode(fl_blocked->fl_core.flc_file)), fh) != 0)
 			continue;
 		/* Alright, we found a lock. Set the return status
 		 * and wake up the caller
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 1f71260603b7..0b8d0297523f 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
@@ -134,7 +133,8 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	char *nodename = req->a_host->h_rpcclnt->cl_nodename;
 
 	nlmclnt_next_cookie(&argp->cookie);
-	memcpy(&lock->fh, NFS_FH(file_inode(fl->fl_file)), sizeof(struct nfs_fh));
+	memcpy(&lock->fh, NFS_FH(file_inode(fl->fl_core.flc_file)),
+	       sizeof(struct nfs_fh));
 	lock->caller  = nodename;
 	lock->oh.data = req->a_owner;
 	lock->oh.len  = snprintf(req->a_owner, sizeof(req->a_owner), "%u@%s",
@@ -143,7 +143,7 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	lock->svid = fl->fl_u.nfs_fl.owner->pid;
 	lock->fl.fl_start = fl->fl_start;
 	lock->fl.fl_end = fl->fl_end;
-	lock->fl.fl_type = fl->fl_type;
+	lock->fl.fl_core.flc_type = fl->fl_core.flc_type;
 }
 
 static void nlmclnt_release_lockargs(struct nlm_rqst *req)
@@ -183,7 +183,7 @@ int nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *dat
 	call->a_callback_data = data;
 
 	if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
-		if (fl->fl_type != F_UNLCK) {
+		if (fl->fl_core.flc_type != F_UNLCK) {
 			call->a_args.block = IS_SETLKW(cmd) ? 1 : 0;
 			status = nlmclnt_lock(call, fl);
 		} else
@@ -433,13 +433,14 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 {
 	int	status;
 
-	status = nlmclnt_call(nfs_file_cred(fl->fl_file), req, NLMPROC_TEST);
+	status = nlmclnt_call(nfs_file_cred(fl->fl_core.flc_file), req,
+			      NLMPROC_TEST);
 	if (status < 0)
 		goto out;
 
 	switch (req->a_res.status) {
 		case nlm_granted:
-			fl->fl_type = F_UNLCK;
+			fl->fl_core.flc_type = F_UNLCK;
 			break;
 		case nlm_lck_denied:
 			/*
@@ -447,8 +448,8 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 			 */
 			fl->fl_start = req->a_res.lock.fl.fl_start;
 			fl->fl_end = req->a_res.lock.fl.fl_end;
-			fl->fl_type = req->a_res.lock.fl.fl_type;
-			fl->fl_pid = -req->a_res.lock.fl.fl_pid;
+			fl->fl_core.flc_type = req->a_res.lock.fl.fl_core.flc_type;
+			fl->fl_core.flc_pid = -req->a_res.lock.fl.fl_core.flc_pid;
 			break;
 		default:
 			status = nlm_stat_to_errno(req->a_res.status);
@@ -486,14 +487,15 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
-	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host, fl->fl_owner);
+	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
+						       fl->fl_core.flc_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
 static int do_vfs_lock(struct file_lock *fl)
 {
-	return locks_lock_file_wait(fl->fl_file, fl);
+	return locks_lock_file_wait(fl->fl_core.flc_file, fl);
 }
 
 /*
@@ -519,11 +521,11 @@ static int do_vfs_lock(struct file_lock *fl)
 static int
 nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 {
-	const struct cred *cred = nfs_file_cred(fl->fl_file);
+	const struct cred *cred = nfs_file_cred(fl->fl_core.flc_file);
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait block;
-	unsigned char flags = fl->fl_flags;
+	unsigned char flags = fl->fl_core.flc_flags;
 	unsigned char type;
 	__be32 b_status;
 	int status = -ENOLCK;
@@ -532,9 +534,9 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		goto out;
 	req->a_args.state = nsm_local_state;
 
-	fl->fl_flags |= FL_ACCESS;
+	fl->fl_core.flc_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
-	fl->fl_flags = flags;
+	fl->fl_core.flc_flags = flags;
 	if (status < 0)
 		goto out;
 
@@ -592,11 +594,11 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			goto again;
 		}
 		/* Ensure the resulting lock will get added to granted list */
-		fl->fl_flags |= FL_SLEEP;
+		fl->fl_core.flc_flags |= FL_SLEEP;
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-		fl->fl_flags = flags;
+		fl->fl_core.flc_flags = flags;
 		status = 0;
 	}
 	if (status < 0)
@@ -623,13 +625,13 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	type = fl->fl_type;
-	fl->fl_type = F_UNLCK;
+	type = fl->fl_core.flc_type;
+	fl->fl_core.flc_type = F_UNLCK;
 	down_read(&host->h_rwsem);
 	do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_type = type;
-	fl->fl_flags = flags;
+	fl->fl_core.flc_type = type;
+	fl->fl_core.flc_flags = flags;
 	nlmclnt_async_call(cred, req, NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	return status;
 }
@@ -652,12 +654,14 @@ nlmclnt_reclaim(struct nlm_host *host, struct file_lock *fl,
 	nlmclnt_setlockargs(req, fl);
 	req->a_args.reclaim = 1;
 
-	status = nlmclnt_call(nfs_file_cred(fl->fl_file), req, NLMPROC_LOCK);
+	status = nlmclnt_call(nfs_file_cred(fl->fl_core.flc_file), req,
+			      NLMPROC_LOCK);
 	if (status >= 0 && req->a_res.status == nlm_granted)
 		return 0;
 
 	printk(KERN_WARNING "lockd: failed to reclaim lock for pid %d "
-				"(errno %d, status %d)\n", fl->fl_pid,
+				"(errno %d, status %d)\n",
+				fl->fl_core.flc_pid,
 				status, ntohl(req->a_res.status));
 
 	/*
@@ -684,26 +688,26 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	int status;
-	unsigned char flags = fl->fl_flags;
+	unsigned char flags = fl->fl_core.flc_flags;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
 	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
 	 * case, we want to unlock.
 	 */
-	fl->fl_flags |= FL_EXISTS;
+	fl->fl_core.flc_flags |= FL_EXISTS;
 	down_read(&host->h_rwsem);
 	status = do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_flags = flags;
+	fl->fl_core.flc_flags = flags;
 	if (status == -ENOENT) {
 		status = 0;
 		goto out;
 	}
 
 	refcount_inc(&req->a_count);
-	status = nlmclnt_async_call(nfs_file_cred(fl->fl_file), req,
-			NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
+	status = nlmclnt_async_call(nfs_file_cred(fl->fl_core.flc_file), req,
+				    NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	if (status < 0)
 		goto out;
 
@@ -796,8 +800,8 @@ static int nlmclnt_cancel(struct nlm_host *host, int block, struct file_lock *fl
 	req->a_args.block = block;
 
 	refcount_inc(&req->a_count);
-	status = nlmclnt_async_call(nfs_file_cred(fl->fl_file), req,
-			NLMPROC_CANCEL, &nlmclnt_cancel_ops);
+	status = nlmclnt_async_call(nfs_file_cred(fl->fl_core.flc_file), req,
+				    NLMPROC_CANCEL, &nlmclnt_cancel_ops);
 	if (status == 0 && req->a_res.status == nlm_lck_denied)
 		status = -ENOLCK;
 	nlmclnt_release_call(req);
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 4df62f635529..e6081fe3a51c 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -238,7 +238,7 @@ static void encode_nlm_holder(struct xdr_stream *xdr,
 	u32 l_offset, l_len;
 	__be32 *p;
 
-	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_RDLCK);
 	encode_int32(xdr, lock->svid);
 	encode_netobj(xdr, lock->oh.data, lock->oh.len);
 
@@ -265,7 +265,7 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 		goto out_overflow;
 	exclusive = be32_to_cpup(p++);
 	lock->svid = be32_to_cpup(p);
-	fl->fl_pid = (pid_t)lock->svid;
+	fl->fl_core.flc_pid = (pid_t)lock->svid;
 
 	error = decode_netobj(xdr, &lock->oh);
 	if (unlikely(error))
@@ -275,8 +275,8 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	if (unlikely(p == NULL))
 		goto out_overflow;
 
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
+	fl->fl_core.flc_flags = FL_POSIX;
+	fl->fl_core.flc_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	l_offset = be32_to_cpup(p++);
 	l_len = be32_to_cpup(p);
 	end = l_offset + l_len - 1;
@@ -357,7 +357,7 @@ static void nlm_xdr_enc_testargs(struct rpc_rqst *req,
 	const struct nlm_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 }
 
@@ -380,7 +380,7 @@ static void nlm_xdr_enc_lockargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 	encode_bool(xdr, args->reclaim);
 	encode_int32(xdr, args->state);
@@ -403,7 +403,7 @@ static void nlm_xdr_enc_cancargs(struct rpc_rqst *req,
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
-	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
+	encode_bool(xdr, lock->fl.fl_core.flc_type == F_WRLCK);
 	encode_nlm_lock(xdr, lock);
 }
 
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b72023a6b4c1..b0a68d8856f9 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -52,16 +52,16 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.fl_flags = FL_POSIX;
-		lock->fl.fl_file  = file->f_file[mode];
-		lock->fl.fl_pid = current->tgid;
+		lock->fl.fl_core.flc_flags = FL_POSIX;
+		lock->fl.fl_core.flc_file  = file->f_file[mode];
+		lock->fl.fl_core.flc_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
 		lock->fl.fl_end = lock->lock_len ?
 				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
 				   OFFSET_MAX;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
-		if (!lock->fl.fl_owner) {
+		if (!lock->fl.fl_core.flc_owner) {
 			/* lockowner allocation has failed */
 			nlmsvc_release_host(host);
 			return nlm_lck_denied_nolocks;
@@ -106,7 +106,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.fl_owner;
+	test_owner = argp->lock.fl.fl_core.flc_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
 	if (resp->status == nlm_drop_reply)
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 2dc10900ad1c..e371ec1354dd 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -150,16 +150,17 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 	struct file_lock	*fl;
 
 	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
-				file, lock->fl.fl_pid,
+				file, lock->fl.fl_core.flc_pid,
 				(long long)lock->fl.fl_start,
-				(long long)lock->fl.fl_end, lock->fl.fl_type);
+				(long long)lock->fl.fl_end,
+				lock->fl.fl_core.flc_type);
 	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
 		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
-				block->b_file, fl->fl_pid,
+				block->b_file, fl->fl_core.flc_pid,
 				(long long)fl->fl_start,
-				(long long)fl->fl_end, fl->fl_type,
+				(long long)fl->fl_end, fl->fl_core.flc_type,
 				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
 			kref_get(&block->b_count);
@@ -244,7 +245,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
 		goto failed_free;
 
 	/* Set notifier function for VFS, and init args */
-	call->a_args.lock.fl.fl_flags |= FL_SLEEP;
+	call->a_args.lock.fl.fl_core.flc_flags |= FL_SLEEP;
 	call->a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
 	nlmclnt_next_cookie(&call->a_args.cookie);
 
@@ -402,14 +403,14 @@ static struct nlm_lockowner *nlmsvc_find_lockowner(struct nlm_host *host, pid_t
 void
 nlmsvc_release_lockowner(struct nlm_lock *lock)
 {
-	if (lock->fl.fl_owner)
-		nlmsvc_put_lockowner(lock->fl.fl_owner);
+	if (lock->fl.fl_core.flc_owner)
+		nlmsvc_put_lockowner(lock->fl.fl_core.flc_owner);
 }
 
 void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
 						pid_t pid)
 {
-	fl->fl_owner = nlmsvc_find_lockowner(host, pid);
+	fl->fl_core.flc_owner = nlmsvc_find_lockowner(host, pid);
 }
 
 /*
@@ -425,7 +426,7 @@ static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
 
 	/* set default data area */
 	call->a_args.lock.oh.data = call->a_owner;
-	call->a_args.lock.svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
+	call->a_args.lock.svid = ((struct nlm_lockowner *) lock->fl.fl_core.flc_owner)->pid;
 
 	if (lock->oh.len > NLMCLNT_OHSIZE) {
 		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
@@ -489,7 +490,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
 				inode->i_sb->s_id, inode->i_ino,
-				lock->fl.fl_type, lock->fl.fl_pid,
+				lock->fl.fl_core.flc_type,
+				lock->fl.fl_core.flc_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end,
 				wait);
@@ -512,7 +514,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			goto out;
 		lock = &block->b_call->a_args.lock;
 	} else
-		lock->fl.fl_flags &= ~FL_SLEEP;
+		lock->fl.fl_core.flc_flags &= ~FL_SLEEP;
 
 	if (block->b_flags & B_QUEUED) {
 		dprintk("lockd: nlmsvc_lock deferred block %p flags %d\n",
@@ -560,10 +562,10 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	spin_unlock(&nlm_blocked_lock);
 
 	if (!wait)
-		lock->fl.fl_flags &= ~FL_SLEEP;
+		lock->fl.fl_core.flc_flags &= ~FL_SLEEP;
 	mode = lock_to_openmode(&lock->fl);
 	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
-	lock->fl.fl_flags &= ~FL_SLEEP;
+	lock->fl.fl_core.flc_flags &= ~FL_SLEEP;
 
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
 	switch (error) {
@@ -616,7 +618,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_type,
+				lock->fl.fl_core.flc_type,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
@@ -636,19 +638,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	if (lock->fl.fl_type == F_UNLCK) {
+	if (lock->fl.fl_core.flc_type == F_UNLCK) {
 		ret = nlm_granted;
 		goto out;
 	}
 
 	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
-		lock->fl.fl_type, (long long)lock->fl.fl_start,
+		lock->fl.fl_core.flc_type, (long long)lock->fl.fl_start,
 		(long long)lock->fl.fl_end);
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.fl_pid;
-	conflock->fl.fl_type = lock->fl.fl_type;
+	conflock->svid = lock->fl.fl_core.flc_pid;
+	conflock->fl.fl_core.flc_type = lock->fl.fl_core.flc_type;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
 	locks_release_private(&lock->fl);
@@ -673,21 +675,21 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_pid,
+				lock->fl.fl_core.flc_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
 	/* First, cancel any lock that might be there */
 	nlmsvc_cancel_blocked(net, file, lock);
 
-	lock->fl.fl_type = F_UNLCK;
-	lock->fl.fl_file = file->f_file[O_RDONLY];
-	if (lock->fl.fl_file)
-		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
+	lock->fl.fl_core.flc_type = F_UNLCK;
+	lock->fl.fl_core.flc_file = file->f_file[O_RDONLY];
+	if (lock->fl.fl_core.flc_file)
+		error = vfs_lock_file(lock->fl.fl_core.flc_file, F_SETLK,
 					&lock->fl, NULL);
-	lock->fl.fl_file = file->f_file[O_WRONLY];
-	if (lock->fl.fl_file)
-		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
+	lock->fl.fl_core.flc_file = file->f_file[O_WRONLY];
+	if (lock->fl.fl_core.flc_file)
+		error |= vfs_lock_file(lock->fl.fl_core.flc_file, F_SETLK,
 					&lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
@@ -710,7 +712,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
 				nlmsvc_file_inode(file)->i_ino,
-				lock->fl.fl_pid,
+				lock->fl.fl_core.flc_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
@@ -863,12 +865,12 @@ nlmsvc_grant_blocked(struct nlm_block *block)
 	/* vfs_lock_file() can mangle fl_start and fl_end, but we need
 	 * them unchanged for the GRANT_MSG
 	 */
-	lock->fl.fl_flags |= FL_SLEEP;
+	lock->fl.fl_core.flc_flags |= FL_SLEEP;
 	fl_start = lock->fl.fl_start;
 	fl_end = lock->fl.fl_end;
 	mode = lock_to_openmode(&lock->fl);
 	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
-	lock->fl.fl_flags &= ~FL_SLEEP;
+	lock->fl.fl_core.flc_flags &= ~FL_SLEEP;
 	lock->fl.fl_start = fl_start;
 	lock->fl.fl_end = fl_end;
 
@@ -993,8 +995,8 @@ nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
 		/* Client doesn't want it, just unlock it */
 		nlmsvc_unlink_block(block);
 		fl = &block->b_call->a_args.lock.fl;
-		fl->fl_type = F_UNLCK;
-		error = vfs_lock_file(fl->fl_file, F_SETLK, fl, NULL);
+		fl->fl_core.flc_type = F_UNLCK;
+		error = vfs_lock_file(fl->fl_core.flc_file, F_SETLK, fl, NULL);
 		if (error)
 			pr_warn("lockd: unable to unlock lock rejected by client!\n");
 		break;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 32784f508c81..16013be0d8ae 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -77,12 +77,12 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		mode = lock_to_openmode(&lock->fl);
-		lock->fl.fl_flags = FL_POSIX;
-		lock->fl.fl_file  = file->f_file[mode];
-		lock->fl.fl_pid = current->tgid;
+		lock->fl.fl_core.flc_flags = FL_POSIX;
+		lock->fl.fl_core.flc_file  = file->f_file[mode];
+		lock->fl.fl_core.flc_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
-		if (!lock->fl.fl_owner) {
+		if (!lock->fl.fl_core.flc_owner) {
 			/* lockowner allocation has failed */
 			nlmsvc_release_host(host);
 			return nlm_lck_denied_nolocks;
@@ -127,7 +127,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.fl_owner;
+	test_owner = argp->lock.fl.fl_core.flc_owner;
 
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e3b6229e7ae5..4b55d0d9365a 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -73,7 +73,7 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 
 int lock_to_openmode(struct file_lock *lock)
 {
-	return (lock->fl_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
+	return (lock->fl_core.flc_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
 }
 
 /*
@@ -181,18 +181,18 @@ static int nlm_unlock_files(struct nlm_file *file, const struct file_lock *fl)
 	struct file_lock lock;
 
 	locks_init_lock(&lock);
-	lock.fl_type  = F_UNLCK;
+	lock.fl_core.flc_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
-	lock.fl_owner = fl->fl_owner;
-	lock.fl_pid   = fl->fl_pid;
-	lock.fl_flags = FL_POSIX;
+	lock.fl_core.flc_owner = fl->fl_core.flc_owner;
+	lock.fl_core.flc_pid   = fl->fl_core.flc_pid;
+	lock.fl_core.flc_flags = FL_POSIX;
 
-	lock.fl_file = file->f_file[O_RDONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	lock.fl_core.flc_file = file->f_file[O_RDONLY];
+	if (lock.fl_core.flc_file && vfs_lock_file(lock.fl_core.flc_file, F_SETLK, &lock, NULL))
 		goto out_err;
-	lock.fl_file = file->f_file[O_WRONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	lock.fl_core.flc_file = file->f_file[O_WRONLY];
+	if (lock.fl_core.flc_file && vfs_lock_file(lock.fl_core.flc_file, F_SETLK, &lock, NULL))
 		goto out_err;
 	return 0;
 out_err:
@@ -218,14 +218,14 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 again:
 	file->f_locks = 0;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+	list_for_each_entry(fl, &flctx->flc_posix, fl_core.flc_list) {
 		if (fl->fl_lmops != &nlmsvc_lock_operations)
 			continue;
 
 		/* update current lock count */
 		file->f_locks++;
 
-		lockhost = ((struct nlm_lockowner *)fl->fl_owner)->host;
+		lockhost = ((struct nlm_lockowner *) fl->fl_core.flc_owner)->host;
 		if (match(lockhost, host)) {
 
 			spin_unlock(&flctx->flc_lock);
@@ -272,7 +272,7 @@ nlm_file_inuse(struct nlm_file *file)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		list_for_each_entry(fl, &flctx->flc_posix, fl_core.flc_list) {
 			if (fl->fl_lmops == &nlmsvc_lock_operations) {
 				spin_unlock(&flctx->flc_lock);
 				return 1;
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 2fb5748dae0c..0331278a62ae 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -88,8 +88,8 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 
 	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;
+	fl->fl_core.flc_flags = FL_POSIX;
+	fl->fl_core.flc_type  = F_RDLCK;
 	end = start + len - 1;
 	fl->fl_start = s32_to_loff_t(start);
 	if (len == 0 || end < 0)
@@ -107,7 +107,7 @@ svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 	s32 start, len;
 
 	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+	if (xdr_stream_encode_bool(xdr, fl->fl_core.flc_type != F_RDLCK) < 0)
 		return false;
 	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
 		return false;
@@ -164,7 +164,7 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 
 	return true;
 }
@@ -184,7 +184,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
@@ -209,7 +209,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 
 	return true;
 }
@@ -223,7 +223,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
-	argp->lock.fl.fl_type = F_UNLCK;
+	argp->lock.fl.fl_core.flc_type = F_UNLCK;
 
 	return true;
 }
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 5fcbf30cd275..54e30fd064a2 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -89,8 +89,8 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 
 	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;
+	fl->fl_core.flc_flags = FL_POSIX;
+	fl->fl_core.flc_type  = F_RDLCK;
 	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
 	return true;
 }
@@ -102,7 +102,7 @@ svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 	s64 start, len;
 
 	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+	if (xdr_stream_encode_bool(xdr, fl->fl_core.flc_type != F_RDLCK) < 0)
 		return false;
 	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
 		return false;
@@ -159,7 +159,7 @@ nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 
 	return true;
 }
@@ -179,7 +179,7 @@ nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
@@ -204,7 +204,7 @@ nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
 	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
+		argp->lock.fl.fl_core.flc_type = F_WRLCK;
 
 	return true;
 }
@@ -218,7 +218,7 @@ nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return false;
-	argp->lock.fl.fl_type = F_UNLCK;
+	argp->lock.fl.fl_core.flc_type = F_UNLCK;
 
 	return true;
 }
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 9f565416d186..bc438007a7fb 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -375,12 +375,12 @@ static inline int nlm_privileged_requester(const struct svc_rqst *rqstp)
 static inline int nlm_compare_locks(const struct file_lock *fl1,
 				    const struct file_lock *fl2)
 {
-	return file_inode(fl1->fl_file) == file_inode(fl2->fl_file)
-	     && fl1->fl_pid   == fl2->fl_pid
-	     && fl1->fl_owner == fl2->fl_owner
+	return file_inode(fl1->fl_core.flc_file) == file_inode(fl2->fl_core.flc_file)
+	     && fl1->fl_core.flc_pid   == fl2->fl_core.flc_pid
+	     && fl1->fl_core.flc_owner == fl2->fl_core.flc_owner
 	     && fl1->fl_start == fl2->fl_start
 	     && fl1->fl_end   == fl2->fl_end
-	     &&(fl1->fl_type  == fl2->fl_type || fl2->fl_type == F_UNLCK);
+	     &&(fl1->fl_core.flc_type  == fl2->fl_core.flc_type || fl2->fl_core.flc_type == F_UNLCK);
 }
 
 extern const struct lock_manager_operations nlmsvc_lock_operations;
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index a3f068b0ca86..80cca9426761 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -11,7 +11,6 @@
 #define LOCKD_XDR_H
 
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>

-- 
2.43.0


