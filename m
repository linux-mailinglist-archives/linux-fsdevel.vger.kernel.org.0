Return-Path: <linux-fsdevel+bounces-9734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6F844BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445F51C230DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5233EA83;
	Wed, 31 Jan 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0f1OulF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AF3D56D;
	Wed, 31 Jan 2024 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742152; cv=none; b=YnMlC8t+VT9eoD01X440v86Fl/NJng6y6E+J5xJAf5BnPYRlt9FG8G5FLNC28hfcOzT09Xu3KXK9Yil9ccP0oxKrLP4DpYztnacfAtDxIE4zw+G4sRO0Wv76v70kUkn49q5N50vvsHA/q4MGy9hqE6yI4QTYBBk0OrrriJpuVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742152; c=relaxed/simple;
	bh=xt33cafGvSFvt222mAMoOTpMEQG2ghQN1EIR655yJN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx8TxqY07120cXAVISV6idCpwF7itHsQFIh3Zf9V0Bc6CVh6PYoOc0rpabRCQIhz7s4D4UMYeLpMAu5q8dJ+wsqLjaPLlbvZy5DtkG56LyOyChKnAiYDyTprJIyYlaXMln6POI0sVpAaEWF/ohkbusECX5zkhGxM7WX4r0XoxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0f1OulF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82292C43601;
	Wed, 31 Jan 2024 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742152;
	bh=xt33cafGvSFvt222mAMoOTpMEQG2ghQN1EIR655yJN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p0f1OulFEEElmyKK0Uv3B9cug7v7Zvq3/Zr1OsgJU58i/PbhRAmS0eYpcNHsgg3ZH
	 8ewJ9meelgEleUNxIAQHvx9aieyewDZpV/Jr0ydIB08icoKmnqsK+oUSiU4L29hEN1
	 Sjgs9Ggp5cPk/FhYQNlOSrlFP8lA1O0NxngHb31Flo8CXDm3nguei+lPtazyhDvbmn
	 +hErSf2YcdRUCCfiNa+3zxbg9F85t6Optjh+4aGlwyYMAGe6RzaCT1TQmk5JWPFGDw
	 9qF1wMJibm+JHs/TQU5+/YHxa46v4yQvGtOv6dyEhD7cmTnItpWEBVX41GYDR8Fq7O
	 hpXn5k/BFtC/A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:45 -0500
Subject: [PATCH v3 04/47] filelock: add some new helper functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4239; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xt33cafGvSFvt222mAMoOTpMEQG2ghQN1EIR655yJN0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFu7pak3ysU7YUEadmffL0cjTzgn6W58PqPi
 O+VkLJOJleJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbgAKCRAADmhBGVaC
 FTkgEACwR7rQ5JTYFNjlZe0wLt9N7ReG5E7lt9pi+v4QXxMxU6zFDBf65iHA00yAzZxcnlMFdqV
 b8UtO2fotBzn7i/F1UR5aCknZGuU0AiwEr+6ic0xQrH7VFDPu5JmAxQOCReVedjrrYe+23sOA1X
 sTvQTBkjy4/tNqdA8dvT82dqlo3wZe8kO/Am61eFX7Fs5z6WPGbmUQGQutIotImyHqHgu5MFE1B
 Me+Etok0NCCoTA7kKou3TjaK96y916+UtwgKH0YKnkYp/fel2u4RfEOS+m85tFPn4Xk0NrDDubY
 50eunzAil4PTazfxa8GEZSGcMW1tVPf+1GMJIWlF0+C7OzDG8GMmEhM1wkSmvKUzn8SYuI+W61V
 V++GdegN2vVXhdpWAWYrvWnpp2vQZWfWtoYKM507mdQUh4dU0RTwOwBWBo156/dB2UbN6Sx1qE8
 fDPJyn54Y8Rfa/IjJQBiLskGVDp1l0ryQOm6UD4gofJ2dnvWuOoJnb/dZivB/7n4qSO4e5pIvRM
 3tcKlUS8U9x8ATMiKgTL1NEr5zqh8CNNaOD2A2szZ1TfoP5YLEF7xZb0H1txOLLvZXAUFKOgQJk
 PVfJV9H5psKLfN4lkqD5C5bii/HfiSCQLOiU+CH0ccSH35x3UBEc1y8v5Ka2IvVtIfLOJdUm6aN
 omSEWafx298uVwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to embed some common fields into a new
structure inside struct file_lock. Smooth the transition by adding some
new helper functions, and converting the core file locking code to use
them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 18 +++++++++---------
 include/linux/filelock.h | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1eceaa56e47f..149070fd3b66 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -674,7 +674,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
-			wake_up(&waiter->fl_wait);
+			locks_wake_up(waiter);
 
 		/*
 		 * The setting of fl_blocker to NULL marks the "done"
@@ -841,9 +841,9 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 static bool locks_conflict(struct file_lock *caller_fl,
 			   struct file_lock *sys_fl)
 {
-	if (sys_fl->fl_type == F_WRLCK)
+	if (lock_is_write(sys_fl))
 		return true;
-	if (caller_fl->fl_type == F_WRLCK)
+	if (lock_is_write(caller_fl))
 		return true;
 	return false;
 }
@@ -874,7 +874,7 @@ static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 				      struct file_lock *sys_fl)
 {
 	/* F_UNLCK checks any locks on the same fd. */
-	if (caller_fl->fl_type == F_UNLCK) {
+	if (lock_is_unlock(caller_fl)) {
 		if (!posix_same_owner(caller_fl, sys_fl))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
@@ -1055,7 +1055,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		break;
 	}
 
-	if (request->fl_type == F_UNLCK) {
+	if (lock_is_unlock(request)) {
 		if ((request->fl_flags & FL_EXISTS) && !found)
 			error = -ENOENT;
 		goto out;
@@ -1107,7 +1107,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
-		return (request->fl_type == F_UNLCK) ? 0 : -ENOMEM;
+		return lock_is_unlock(request) ? 0 : -ENOMEM;
 
 	/*
 	 * We may need two file_lock structures for this operation,
@@ -1228,7 +1228,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				continue;
 			if (fl->fl_start > request->fl_end)
 				break;
-			if (request->fl_type == F_UNLCK)
+			if (lock_is_unlock(request))
 				added = true;
 			if (fl->fl_start < request->fl_start)
 				left = fl;
@@ -1279,7 +1279,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	error = 0;
 	if (!added) {
-		if (request->fl_type == F_UNLCK) {
+		if (lock_is_unlock(request)) {
 			if (request->fl_flags & FL_EXISTS)
 				error = -ENOENT;
 			goto out;
@@ -1608,7 +1608,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
 					      struct file_lock, fl_list);
-		if (fl && (fl->fl_type == F_WRLCK))
+		if (fl && lock_is_write(fl))
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
 	}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 085ff6ba0653..a814664b1053 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -147,6 +147,29 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);
 
+static inline bool lock_is_unlock(struct file_lock *fl)
+{
+	return fl->fl_type == F_UNLCK;
+}
+
+static inline bool lock_is_read(struct file_lock *fl)
+{
+	return fl->fl_type == F_RDLCK;
+}
+
+static inline bool lock_is_write(struct file_lock *fl)
+{
+	return fl->fl_type == F_WRLCK;
+}
+
+static inline void locks_wake_up(struct file_lock *fl)
+{
+	wake_up(&fl->fl_wait);
+}
+
+/* for walking lists of file_locks linked by fl_list */
+#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, fl_list)
+
 /* fs/locks.c */
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);

-- 
2.43.0


