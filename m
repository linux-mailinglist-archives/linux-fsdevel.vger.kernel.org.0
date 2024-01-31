Return-Path: <linux-fsdevel+bounces-9766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF7844C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9D1F21AD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF91482EF;
	Wed, 31 Jan 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG3oWC+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6011487C0;
	Wed, 31 Jan 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742279; cv=none; b=fEBPaxo7fTsKnNORam60jFSFt3AIz0lrECGGC+JGbtlUNBDCu1rwH3WLQbe8iWVradBbphJE0MpfaLUrAp+cUdY/RKbHrkmGmTcYDFNijiLr1L1Ae1uaYpY1yfQ+1Krg6Nq7Dm0jKmmyoYmv9eQXfJ4LPq4WZP7QB5/MS+EVPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742279; c=relaxed/simple;
	bh=0SlLixkZdWShrK8132oBmH9L0tQjlyo0eXjNsCZMP6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVX8+gPnubBaKAL0IBX/Nld3KyeYV/EQLLJAgyNCKKATDx30WnB9ErVsHMvQ+OmIwhfk+D6sMnsg+nouMDGJY+T3AZD1xfQNzazecOnaCSTZeSxYs7Rw3dtn7SFLScMzmvClzrKjMOfWBwOp5HP76HsrHXVw/YK8uOhhMF9odnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG3oWC+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E24C433A6;
	Wed, 31 Jan 2024 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742279;
	bh=0SlLixkZdWShrK8132oBmH9L0tQjlyo0eXjNsCZMP6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hG3oWC+Hg8xugLvmP0MX5frBkeW2rjA65ZtIDl3GOCZ3jQCXu2hMFzg48VMFVlRIy
	 wwuN8qSm9YLoHeo03QY9ctC63KdxBRZXPiYEgJmlustbUUcM7GpuWVnQ0r/WjQYSp9
	 tAGIR4CZ8bI1l4Hd4c5On8XnJRYH0kGZ1Ui8SdL4CWgO5DmzJOqJOsfMSxt9X2I73+
	 0RHNwYBfUPLs2sDPnrLo5eURkeZ8cjWmUjFbvCZwwxMj6wdqUwKAoOOiASnsd1lgHI
	 tQjDBuH5ybKcuk0d9QsPxAHMmXKaBqW6YyrAnz2PDJRLWYnNQYkQGOvQsKjtMqjYwc
	 k30hnwCnJRIug==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:17 -0500
Subject: [PATCH v3 36/47] ceph: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-36-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6558; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0SlLixkZdWShrK8132oBmH9L0tQjlyo0eXjNsCZMP6M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFy0WnbP9/gv2a03enPktDhXE57rrenfGbTO
 ksFmsLlyFqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FUqwD/953trDH8LafoXlmPzSRw5Igyw1XQjVmnxEqHhj+vU7FN8M/1eYG/eZiRl7cKcbSxXL+Pi
 MenUVgD/1XBGR3p4TU1iBAwW6i5Udh8VhLAHdm+nPYZ3trDfhdAUg1Gsh9FA8KbF7nqc4S0EQHN
 B7J+ae2krXivycbPQ3lbLPVEE4Qzab84UYVfFfKUOlIN4s/mvbWTiz7zpvi0kp3Wf0Kg4LSGXOc
 leQ5UpUw+Jw+k7MxMRg7zPEVlwcjSzOOfcj0dHFdXpsiBVxLO+sXrDpy6I+DE1YJuH7dF2QY6aj
 LjyKdRsv8rittMIsMuVN8NnxYQ+bggS6MGKJCsP4avklQf7as9e5Kt9l9dbznyPQzYDvFruzqWf
 2Gr2anSkVmwDO3zsp3R3ffUcrpjNTgJir6XjHKBthhxfLBx9tNrV2F3lYUhzBRNVYBNhraUPeXx
 G2Z4rT6DAFsMuEI+57oV0eVp4MkWt0F0EwHBhyvnRrt0SsvEnGpKBd0a0NbjDlYGV8o7uQVHa02
 wQQz2CDwU86S0iU42sLTF/2sCj1PNOap6R5G64b+kkI1tXkVnmZcyqdvltc9yrZHHQXm2Vx/14z
 TiDCkvZSWFBycLo3luFiYC8v3QMZMCj2jtqivEtsVL3tghgwm2ZS85aidiQnoWNCWrO492ajaJA
 FSzKCZDvqmjGWIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/locks.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ce773e9c0b79..ebf4ac0055dd 100644
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
+	struct inode *inode = file_inode(dst->c.flc_file);
 	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
 	dst->fl_u.ceph.inode = igrab(inode);
 }
@@ -111,17 +110,18 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	else
 		length = fl->fl_end - fl->fl_start + 1;
 
-	owner = secure_addr(fl->fl_owner);
+	owner = secure_addr(fl->c.flc_owner);
 
 	doutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
 		    "start: %llu, length: %llu, wait: %d, type: %d\n",
-		    (int)lock_type, (int)operation, owner, (u64)fl->fl_pid,
-		    fl->fl_start, length, wait, fl->fl_type);
+		    (int)lock_type, (int)operation, owner,
+		    (u64) fl->c.flc_pid,
+		    fl->fl_start, length, wait, fl->c.flc_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
 	req->r_args.filelock_change.owner = cpu_to_le64(owner);
-	req->r_args.filelock_change.pid = cpu_to_le64((u64)fl->fl_pid);
+	req->r_args.filelock_change.pid = cpu_to_le64((u64) fl->c.flc_pid);
 	req->r_args.filelock_change.start = cpu_to_le64(fl->fl_start);
 	req->r_args.filelock_change.length = cpu_to_le64(length);
 	req->r_args.filelock_change.wait = wait;
@@ -131,13 +131,13 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 		err = ceph_mdsc_wait_request(mdsc, req, wait ?
 					ceph_lock_wait_for_completion : NULL);
 	if (!err && operation == CEPH_MDS_OP_GETFILELOCK) {
-		fl->fl_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
+		fl->c.flc_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_RDLCK;
+			fl->c.flc_type = F_RDLCK;
 		else if (CEPH_LOCK_EXCL == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_WRLCK;
+			fl->c.flc_type = F_WRLCK;
 		else
-			fl->fl_type = F_UNLCK;
+			fl->c.flc_type = F_UNLCK;
 
 		fl->fl_start = le64_to_cpu(req->r_reply_info.filelock_reply->start);
 		length = le64_to_cpu(req->r_reply_info.filelock_reply->start) +
@@ -151,8 +151,8 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	ceph_mdsc_put_request(req);
 	doutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
 	      "length: %llu, wait: %d, type: %d, err code %d\n",
-	      (int)lock_type, (int)operation, (u64)fl->fl_pid,
-	      fl->fl_start, length, wait, fl->fl_type, err);
+	      (int)lock_type, (int)operation, (u64) fl->c.flc_pid,
+	      fl->fl_start, length, wait, fl->c.flc_type, err);
 	return err;
 }
 
@@ -228,10 +228,10 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 static int try_unlock_file(struct file *file, struct file_lock *fl)
 {
 	int err;
-	unsigned int orig_flags = fl->fl_flags;
-	fl->fl_flags |= FL_EXISTS;
+	unsigned int orig_flags = fl->c.flc_flags;
+	fl->c.flc_flags |= FL_EXISTS;
 	err = locks_lock_file_wait(file, fl);
-	fl->fl_flags = orig_flags;
+	fl->c.flc_flags = orig_flags;
 	if (err == -ENOENT) {
 		if (!(orig_flags & FL_EXISTS))
 			err = 0;
@@ -254,13 +254,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_owner: %p\n", fl->fl_owner);
+	doutc(cl, "fl_owner: %p\n", fl->c.flc_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -294,7 +294,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_type) {
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->c.flc_type) {
 			doutc(cl, "locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
@@ -320,13 +320,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_file: %p\n", fl->fl_file);
+	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
@@ -357,7 +357,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
 				inode, lock_cmd, wait, fl);
-	if (!err && F_UNLCK != fl->fl_type) {
+	if (!err && F_UNLCK != fl->c.flc_type) {
 		err = locks_lock_file_wait(file, fl);
 		if (err) {
 			ceph_lock_message(CEPH_LOCK_FLOCK,
@@ -409,10 +409,10 @@ static int lock_to_ceph_filelock(struct inode *inode,
 	cephlock->start = cpu_to_le64(lock->fl_start);
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
-	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
-	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
+	cephlock->pid = cpu_to_le64((u64) lock->c.flc_pid);
+	cephlock->owner = cpu_to_le64(secure_addr(lock->c.flc_owner));
 
-	switch (lock->fl_type) {
+	switch (lock->c.flc_type) {
 	case F_RDLCK:
 		cephlock->type = CEPH_LOCK_SHARED;
 		break;
@@ -423,7 +423,8 @@ static int lock_to_ceph_filelock(struct inode *inode,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		doutc(cl, "Have unknown lock type %d\n", lock->fl_type);
+		doutc(cl, "Have unknown lock type %d\n",
+		      lock->c.flc_type);
 		err = -EINVAL;
 	}
 

-- 
2.43.0


