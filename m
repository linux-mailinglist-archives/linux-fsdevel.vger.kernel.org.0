Return-Path: <linux-fsdevel+bounces-8902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C009583BFE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CDE1C21FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26564CFC;
	Thu, 25 Jan 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeMTSbq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A589651B7;
	Thu, 25 Jan 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179510; cv=none; b=WeOC6IFlLe+hZGzkafrhoGqIfyXWSyTkGu5pQD4JezZyoYDB5Avgx5Gew+TUKqGvkp9q4iNXjhtJvHUDL39Ao9FwnlAoYB0Daif+68CZDe6J0RXo41FyQgm0smcMA3BPJbVDhgGdKkUdp5o+/l//r4U5TltdS6+gqehAes62moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179510; c=relaxed/simple;
	bh=ZkTTYoCA2JlWhYjScha+TyRj1HN/csZff3oEh1xuuu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+cwaWVJorNOt1pJmgWY4smDFSkkVQbM6Itfqe8nzKOYM2vuRL1KVT8GyT2/c/B7/UC6mTYssGcC/8h2kSpMD3lOOxCAlPsO3FRrkuIED/gQ8zez0vE/6rwOkbgwQE8SvdcU6CxPadw75D8FiTJmQPo35TVQgTlWNvmXj2LEgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeMTSbq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7771CC43330;
	Thu, 25 Jan 2024 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179510;
	bh=ZkTTYoCA2JlWhYjScha+TyRj1HN/csZff3oEh1xuuu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NeMTSbq/2heSUczpbWYpkZ+BvTNmpiD5jfTgpEpPBvQJEwzxch+8uLjTZ19dwr7OJ
	 9oq0HwqC8TH6STaxIN46G34Gix4rI+TUkGi8/g1wSIe1IluKLHssh3Qp/eFd8fU1Kr
	 F844G89hefMrcTzG4gmiJXczsnpkGOtugZ21oXYLlCxnLv689T5MOqF7qKKk2zpVWd
	 LNBAuklzscV5/qbRkYPtMirOkVXkaDoLgEg68vN3dYhcDgTFQbNawRl1oZhIJ9DNhP
	 yNv+Y31Dqf125Us9qq+Btoly19K9w697iMAFSMQtsuS+Q/wuAtLjYlVS7DRFysujIn
	 rlCS/r6ZTP04w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:11 -0500
Subject: [PATCH v2 30/41] afs: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-30-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9048; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZkTTYoCA2JlWhYjScha+TyRj1HN/csZff3oEh1xuuu4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9wjuhavfHFy9xm6b4MtexA+bAWQ8qp1Hvx
 9/wgJB304eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 FdOpD/4mTfs/cFoMHA4hkKXcEibxIWH109C7caMMzF2zUvqKA3whBH9st7rIbWm60AJkd5lHO2M
 IvxLX3vVeyX5yaApctiRm3fwQRI2E+72fS3Om/R9vWMZ9nFrdxSXYahMBN5SC7StCuFzHtaUvAf
 eqFfd5Nm0kQnSI8kz4WwmlYXHYsRbOARU0N0LJt3cl2aZcOxkFxV4sfPlaERYb0dBXvAcyP12oR
 EyeYUm6YKKXhNPA1tOU/tk7A86NPLLN7DDQo153uMWyQaYOaJ7SLIaVn9HmpEakO3IQKlmw5/Sl
 wCmyv+LlaSIj1ZKjFuYaEM/k53tFCeIvV9CzaCbkYVLBPsCSfPmNgsQ7kAHN7zQ7tNMwdjVph2x
 tbZJpeQ1PnP/yVke0UYtpxo4yX1esFUV0o0NZEouocGU74dlMcXkUKcer0eb2VNKgyv+m+QzVgJ
 HJnLVWi3TVR2II6Yuex9/Ji9FPVgzpQ+qCb+ZICPlWiO5IXAmQFa/jztkRvWpIEW2aqctN/GdkL
 RTmTqgHjNyXfwK6K+lGQ3MQVNQcMefJU0Ih6dyasBKOrZPKitt/BJARn4OlkIRXuyYnDVc3T5pR
 h26QuvwxcuU88c5KgBY52JU5BIu6KhHzEoicx2yXu74/+CtIxGG/kzQKXDQbSheZvIV5SAoLWs7
 qfWUdIln9ylXPSw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/flock.c             | 55 +++++++++++++++++++++++-----------------------
 fs/afs/internal.h          |  1 -
 include/trace/events/afs.h |  4 ++--
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index e7feaf66bddf..34e7510526b9 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -93,13 +93,13 @@ static void afs_grant_locks(struct afs_vnode *vnode)
 	bool exclusive = (vnode->lock_type == AFS_LOCK_WRITE);
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
-		if (!exclusive && p->fl_type == F_WRLCK)
+		if (!exclusive && p->fl_core.flc_type == F_WRLCK)
 			continue;
 
 		list_move_tail(&p->fl_u.afs.link, &vnode->granted_locks);
 		p->fl_u.afs.state = AFS_LOCK_GRANTED;
 		trace_afs_flock_op(vnode, p, afs_flock_op_grant);
-		wake_up(&p->fl_wait);
+		wake_up(&p->fl_core.flc_wait);
 	}
 }
 
@@ -121,16 +121,16 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == type &&
-		    afs_file_key(p->fl_file) == key) {
+		    p->fl_core.flc_type == type &&
+		    afs_file_key(p->fl_core.flc_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;
-			wake_up(&p->fl_wait);
+			wake_up(&p->fl_core.flc_wait);
 		}
 
 		/* Select the next locker to hand off to. */
 		if (next &&
-		    (next->fl_type == F_WRLCK || p->fl_type == F_RDLCK))
+		    (next->fl_core.flc_type == F_WRLCK || p->fl_core.flc_type == F_RDLCK))
 			continue;
 		next = p;
 	}
@@ -142,7 +142,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_SETTING);
 		next->fl_u.afs.state = AFS_LOCK_YOUR_TRY;
 		trace_afs_flock_op(vnode, next, afs_flock_op_wake);
-		wake_up(&next->fl_wait);
+		wake_up(&next->fl_core.flc_wait);
 	} else {
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_NONE);
 		trace_afs_flock_ev(vnode, NULL, afs_flock_no_lockers, 0);
@@ -166,7 +166,7 @@ static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
 			       struct file_lock, fl_u.afs.link);
 		list_del_init(&p->fl_u.afs.link);
 		p->fl_u.afs.state = -ENOENT;
-		wake_up(&p->fl_wait);
+		wake_up(&p->fl_core.flc_wait);
 	}
 
 	key_put(vnode->lock_key);
@@ -464,14 +464,14 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%llu-%llu,%u,%u",
 	       vnode->fid.vid, vnode->fid.vnode,
-	       fl->fl_start, fl->fl_end, fl->fl_type, mode);
+	       fl->fl_start, fl->fl_end, fl->fl_core.flc_type, mode);
 
 	fl->fl_ops = &afs_lock_ops;
 	INIT_LIST_HEAD(&fl->fl_u.afs.link);
 	fl->fl_u.afs.state = AFS_LOCK_PENDING;
 
 	partial = (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX);
-	type = (fl->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
+	type = (fl->fl_core.flc_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 	if (mode == afs_flock_mode_write && partial)
 		type = AFS_LOCK_WRITE;
 
@@ -524,7 +524,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	}
 
 	if (vnode->lock_state == AFS_VNODE_LOCK_NONE &&
-	    !(fl->fl_flags & FL_SLEEP)) {
+	    !(fl->fl_core.flc_flags & FL_SLEEP)) {
 		ret = -EAGAIN;
 		if (type == AFS_LOCK_READ) {
 			if (vnode->status.lock_count == -1)
@@ -621,7 +621,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	return 0;
 
 lock_is_contended:
-	if (!(fl->fl_flags & FL_SLEEP)) {
+	if (!(fl->fl_core.flc_flags & FL_SLEEP)) {
 		list_del_init(&fl->fl_u.afs.link);
 		afs_next_locker(vnode, 0);
 		ret = -EAGAIN;
@@ -641,7 +641,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	spin_unlock(&vnode->lock);
 
 	trace_afs_flock_ev(vnode, fl, afs_flock_waiting, 0);
-	ret = wait_event_interruptible(fl->fl_wait,
+	ret = wait_event_interruptible(fl->fl_core.flc_wait,
 				       fl->fl_u.afs.state != AFS_LOCK_PENDING);
 	trace_afs_flock_ev(vnode, fl, afs_flock_waited, ret);
 
@@ -704,7 +704,8 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
-	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
+	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode,
+	       fl->fl_core.flc_type);
 
 	trace_afs_flock_op(vnode, fl, afs_flock_op_unlock);
 
@@ -730,11 +731,11 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 	if (vnode->lock_state == AFS_VNODE_LOCK_DELETED)
 		return -ENOENT;
 
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.flc_type = F_UNLCK;
 
 	/* check local lock records first */
 	posix_test_lock(file, fl);
-	if (fl->fl_type == F_UNLCK) {
+	if (fl->fl_core.flc_type == F_UNLCK) {
 		/* no local locks; consult the server */
 		ret = afs_fetch_status(vnode, key, false, NULL);
 		if (ret < 0)
@@ -743,18 +744,18 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 		lock_count = READ_ONCE(vnode->status.lock_count);
 		if (lock_count != 0) {
 			if (lock_count > 0)
-				fl->fl_type = F_RDLCK;
+				fl->fl_core.flc_type = F_RDLCK;
 			else
-				fl->fl_type = F_WRLCK;
+				fl->fl_core.flc_type = F_WRLCK;
 			fl->fl_start = 0;
 			fl->fl_end = OFFSET_MAX;
-			fl->fl_pid = 0;
+			fl->fl_core.flc_pid = 0;
 		}
 	}
 
 	ret = 0;
 error:
-	_leave(" = %d [%hd]", ret, fl->fl_type);
+	_leave(" = %d [%hd]", ret, fl->fl_core.flc_type);
 	return ret;
 }
 
@@ -769,7 +770,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags,
+	       fl->fl_core.flc_type, fl->fl_core.flc_flags,
 	       (long long) fl->fl_start, (long long) fl->fl_end);
 
 	if (IS_GETLK(cmd))
@@ -778,7 +779,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_lock);
 
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.flc_type == F_UNLCK)
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);
@@ -804,7 +805,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags);
+	       fl->fl_core.flc_type, fl->fl_core.flc_flags);
 
 	/*
 	 * No BSD flocks over NFS allowed.
@@ -813,14 +814,14 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 	 * Not sure whether that would be unique, though, or whether
 	 * that would break in other places.
 	 */
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_flock);
 
 	/* we're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.flc_type == F_UNLCK)
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);
@@ -843,7 +844,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
  */
 static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_core.flc_file));
 
 	_enter("");
 
@@ -861,7 +862,7 @@ static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
  */
 static void afs_fl_release_private(struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_core.flc_file));
 
 	_enter("");
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f5dd428e40f4..9c03fcf7ffaa 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 8d73171cb9f0..51b41d957c66 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1164,8 +1164,8 @@ TRACE_EVENT(afs_flock_op,
 		    __entry->from = fl->fl_start;
 		    __entry->len = fl->fl_end - fl->fl_start + 1;
 		    __entry->op = op;
-		    __entry->type = fl->fl_type;
-		    __entry->flags = fl->fl_flags;
+		    __entry->type = fl->fl_core.flc_type;
+		    __entry->flags = fl->fl_core.flc_flags;
 		    __entry->debug_id = fl->fl_u.afs.debug_id;
 			   ),
 

-- 
2.43.0


