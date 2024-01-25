Return-Path: <linux-fsdevel+bounces-8903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C983C0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB04B25F4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5265BA3;
	Thu, 25 Jan 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVJsmdYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E1657CC;
	Thu, 25 Jan 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179514; cv=none; b=NkCSIvHxfKiYv8mAthQ7TvSLtGgWKpLq9BMiZ+kKsLBGTEY57em0iNaHPWO0O3L+j2ujsiN7JRSAyPCBNInSyVbLsKp9QEaR5Kh70Xc+Bm4KTvKzchSj8UwI0K5m+AmztBef1Q80qA/XVqpuqeghVaDUEgILBGmSPRqfwEQyDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179514; c=relaxed/simple;
	bh=FO7gE+5QMwnUCamAXnZMUTb5iz1pqnz+4op5wc4NFF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPslef6QhxHTxNFqIdqHyzXiS4F4/VFsBRVBpP5fNZayRMqJXBR29DcaA6Lkfpxja29TA/mcwummlFyIrcl+i+ehjVpeSoZ8PpzgGIi9MkZRSgfNauraWOcsCUmBQoLLQny1zdh05HzT5wWh+GloJH8vSFqozwpCbPYqvZ0d/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVJsmdYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB95C43609;
	Thu, 25 Jan 2024 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179514;
	bh=FO7gE+5QMwnUCamAXnZMUTb5iz1pqnz+4op5wc4NFF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FVJsmdYIPsfQ7LSmV1SNjqtq4EOuZOXF0UqCpt+Oc6u1QZz5+lHX6nr1tO6rLJITD
	 51ebWrUF/hKHg1qgkpkUKv62UEZtpMs6zd4g/bmsGhGHM1ALJUk5wu/iT33TSQnAjK
	 N5xKywayBAgZKtjMRC3mRQJxvX4jp9OjhbuWJY9Se2ndRTFbYzvjRl49ZDnh4C1iq3
	 GTfVOYc+rO25pSHs8jHwKg3qd3RMp48/CQ7zxRJEXcGaUDDb7Nsbx1WSnObs9+XMxF
	 FwcUDZ/aWdNpJnMNWXHkBjxkdSTdoSE111dTg8dkLl59NK5707oaVpuTnnWvYMmRwb
	 A26SrtLkL8kzg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:12 -0500
Subject: [PATCH v2 31/41] ceph: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-31-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9470; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FO7gE+5QMwnUCamAXnZMUTb5iz1pqnz+4op5wc4NFF8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9jysf1jctmd8lFDksHUDpQqYbZAkrSKBof
 X48jlLhTUGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 FdcNEACEPxyhY7I+3tbEyAuhjI9Z0PE7BmUVfDTD+J8yCUlD4Fg+3+HjO2PoLMyAfDS130FSodS
 CMTq9MiPHWr9d4REcdv6kUdhmm/o3W0DuTh/92EXGsOkd59RbIkgtlDkk6jz543uRtSvKPqMevk
 rTcmyjpler+gI/PYZY5Z95+87hHVY7bRjO0lKXD07fcrQIi1wPGO2dq0wdRkK2m8afcdOvjc4S4
 SbfVODwALCkJRrySVpNGwGmXh2mJgyYD6IXuJAMBYBJlVsKGV42GBf1Qq0DJAtT64mGOEq9+IWX
 osvdddQcuk5H5NN62RJiE1OlpK6XBEsPlC27YMih8S67UvcRdHMDfNkKhq79ff+EjpwuKBCFom0
 J3+hwDY1QcTIP6P3QNmqoEb/4pApiX1sOEUygqC40dqSuDLFzBu6C65ThhxzT7RH3nGBxdI/nIq
 0+BBR0qvgnNCB5KpUclMe8M636X93hLUHawCKEB3GeZe+EgH33m3dKoauBUj3GCMA9in6c1xlqV
 ACFqkvH6KkTtU8ZE0gGMgbn80V8MsdcExSDCuOc4h5PBHlRNqPhCbnYo/zfu67rzwot6IlYtymQ
 zrKiNSktZxFmNdtA508XYGP4jVkgTO0J/bjUXMqaReVBm8Scu0tuFe5I1OavckhEMD7R/QSN4xh
 ocTrVFX+3Aplt4g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/locks.c | 75 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ccb358c398ca..89e44e7543eb 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -7,7 +7,6 @@
 
 #include "super.h"
 #include "mds_client.h"
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/ceph/pagelist.h>
 
@@ -34,7 +33,7 @@ void __init ceph_flock_init(void)
 
 static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
 {
-	struct inode *inode = file_inode(dst->fl_file);
+	struct inode *inode = file_inode(dst->fl_core.flc_file);
 	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
 	dst->fl_u.ceph.inode = igrab(inode);
 }
@@ -111,17 +110,18 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	else
 		length = fl->fl_end - fl->fl_start + 1;
 
-	owner = secure_addr(fl->fl_owner);
+	owner = secure_addr(fl->fl_core.flc_owner);
 
 	doutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
 		    "start: %llu, length: %llu, wait: %d, type: %d\n",
-		    (int)lock_type, (int)operation, owner, (u64)fl->fl_pid,
-		    fl->fl_start, length, wait, fl->fl_type);
+		    (int)lock_type, (int)operation, owner,
+		    (u64) fl->fl_core.flc_pid,
+		    fl->fl_start, length, wait, fl->fl_core.flc_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
 	req->r_args.filelock_change.owner = cpu_to_le64(owner);
-	req->r_args.filelock_change.pid = cpu_to_le64((u64)fl->fl_pid);
+	req->r_args.filelock_change.pid = cpu_to_le64((u64) fl->fl_core.flc_pid);
 	req->r_args.filelock_change.start = cpu_to_le64(fl->fl_start);
 	req->r_args.filelock_change.length = cpu_to_le64(length);
 	req->r_args.filelock_change.wait = wait;
@@ -131,13 +131,13 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 		err = ceph_mdsc_wait_request(mdsc, req, wait ?
 					ceph_lock_wait_for_completion : NULL);
 	if (!err && operation == CEPH_MDS_OP_GETFILELOCK) {
-		fl->fl_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
+		fl->fl_core.flc_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_RDLCK;
+			fl->fl_core.flc_type = F_RDLCK;
 		else if (CEPH_LOCK_EXCL == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_WRLCK;
+			fl->fl_core.flc_type = F_WRLCK;
 		else
-			fl->fl_type = F_UNLCK;
+			fl->fl_core.flc_type = F_UNLCK;
 
 		fl->fl_start = le64_to_cpu(req->r_reply_info.filelock_reply->start);
 		length = le64_to_cpu(req->r_reply_info.filelock_reply->start) +
@@ -151,8 +151,8 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	ceph_mdsc_put_request(req);
 	doutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
 	      "length: %llu, wait: %d, type: %d, err code %d\n",
-	      (int)lock_type, (int)operation, (u64)fl->fl_pid,
-	      fl->fl_start, length, wait, fl->fl_type, err);
+	      (int)lock_type, (int)operation, (u64) fl->fl_core.flc_pid,
+	      fl->fl_start, length, wait, fl->fl_core.flc_type, err);
 	return err;
 }
 
@@ -228,10 +228,10 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 static int try_unlock_file(struct file *file, struct file_lock *fl)
 {
 	int err;
-	unsigned int orig_flags = fl->fl_flags;
-	fl->fl_flags |= FL_EXISTS;
+	unsigned int orig_flags = fl->fl_core.flc_flags;
+	fl->fl_core.flc_flags |= FL_EXISTS;
 	err = locks_lock_file_wait(file, fl);
-	fl->fl_flags = orig_flags;
+	fl->fl_core.flc_flags = orig_flags;
 	if (err == -ENOENT) {
 		if (!(orig_flags & FL_EXISTS))
 			err = 0;
@@ -254,13 +254,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.flc_flags & FL_POSIX))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_owner: %p\n", fl->fl_owner);
+	doutc(cl, "fl_owner: %p\n", fl->fl_core.flc_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -274,19 +274,19 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type)
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_core.flc_type)
 			posix_lock_file(file, fl, NULL);
 		return err;
 	}
 
-	if (F_RDLCK == fl->fl_type)
+	if (F_RDLCK == fl->fl_core.flc_type)
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (F_WRLCK == fl->fl_core.flc_type)
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type) {
+	if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_core.flc_type) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -294,7 +294,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_type) {
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_core.flc_type) {
 			doutc(cl, "locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
@@ -320,13 +320,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_file: %p\n", fl->fl_file);
+	doutc(cl, "fl_file: %p\n", fl->fl_core.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
@@ -334,7 +334,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (F_UNLCK == fl->fl_type)
+		if (F_UNLCK == fl->fl_core.flc_type)
 			locks_lock_file_wait(file, fl);
 		return err;
 	}
@@ -342,14 +342,14 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
-	if (F_RDLCK == fl->fl_type)
+	if (F_RDLCK == fl->fl_core.flc_type)
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (F_WRLCK == fl->fl_core.flc_type)
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (F_UNLCK == fl->fl_type) {
+	if (F_UNLCK == fl->fl_core.flc_type) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -357,7 +357,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
 				inode, lock_cmd, wait, fl);
-	if (!err && F_UNLCK != fl->fl_type) {
+	if (!err && F_UNLCK != fl->fl_core.flc_type) {
 		err = locks_lock_file_wait(file, fl);
 		if (err) {
 			ceph_lock_message(CEPH_LOCK_FLOCK,
@@ -386,9 +386,9 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 	ctx = locks_inode_context(inode);
 	if (ctx) {
 		spin_lock(&ctx->flc_lock);
-		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
+		list_for_each_entry(lock, &ctx->flc_posix, fl_core.flc_list)
 			++(*fcntl_count);
-		list_for_each_entry(lock, &ctx->flc_flock, fl_list)
+		list_for_each_entry(lock, &ctx->flc_flock, fl_core.flc_list)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
@@ -409,10 +409,10 @@ static int lock_to_ceph_filelock(struct inode *inode,
 	cephlock->start = cpu_to_le64(lock->fl_start);
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
-	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
-	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
+	cephlock->pid = cpu_to_le64((u64) lock->fl_core.flc_pid);
+	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_core.flc_owner));
 
-	switch (lock->fl_type) {
+	switch (lock->fl_core.flc_type) {
 	case F_RDLCK:
 		cephlock->type = CEPH_LOCK_SHARED;
 		break;
@@ -423,7 +423,8 @@ static int lock_to_ceph_filelock(struct inode *inode,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		doutc(cl, "Have unknown lock type %d\n", lock->fl_type);
+		doutc(cl, "Have unknown lock type %d\n",
+		      lock->fl_core.flc_type);
 		err = -EINVAL;
 	}
 
@@ -454,7 +455,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(lock, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(lock, &ctx->flc_posix, fl_core.flc_list) {
 		++seen_fcntl;
 		if (seen_fcntl > num_fcntl_locks) {
 			err = -ENOSPC;
@@ -465,7 +466,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 			goto fail;
 		++l;
 	}
-	list_for_each_entry(lock, &ctx->flc_flock, fl_list) {
+	list_for_each_entry(lock, &ctx->flc_flock, fl_core.flc_list) {
 		++seen_flock;
 		if (seen_flock > num_flock_locks) {
 			err = -ENOSPC;

-- 
2.43.0


