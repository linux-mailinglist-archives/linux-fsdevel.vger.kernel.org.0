Return-Path: <linux-fsdevel+bounces-8911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE783C015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF771C23425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9B6A323;
	Thu, 25 Jan 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ/Vu6x6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259486A02B;
	Thu, 25 Jan 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179545; cv=none; b=ElhA+ZS75WieQ/MhmMNdBnGgThh2JJpzUSVGTnutpNAhNsQgKWQtYOII7/TcO16F3IVJOO8uNA/+Lz1X7IWzw5pVNpDJcMP67QdesThNosFA4PBwcvRibGY77LLzsT0BX1LwPs0pAWz9GKx3g8fEEEDSaz6kTn5gZnwi0eYRKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179545; c=relaxed/simple;
	bh=Bc7tS+aassSqdrdhnpohA5Vs8wnKfzMC2dWNyb0Wn/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ainnD0zQRzE2/HQGlB9onk6lXTsIE0nnwdAshsDAx9oMc1JzBG6svxl9ZW/eePfOF899bFd8LIspfUF2DG97dwuIGvcDsQSGKpGb1pEz0m02KhoUCOHRGSN187FTPDHYwAXzNj7sIJnw6cofoq0ej+7I4P9v10EeDZl1r/YYnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ/Vu6x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139EC43601;
	Thu, 25 Jan 2024 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179544;
	bh=Bc7tS+aassSqdrdhnpohA5Vs8wnKfzMC2dWNyb0Wn/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJ/Vu6x67q4S4gVpIOqCQNoulXnNIIT2aLokzt62toY1DVDsXveZm6u1YBX3+09rR
	 id2rHbrUcn2l3fLsTyWDR2tOuXRg9Jr//dMo3VvDF+lmyEV3Qr5T6OiUHxzOhIm1n8
	 GnhpDJUIV8M5Ll6OCFvgq1sDpF4trari0+T0ym9F6V4xmw0vuLORiulpJT64HYF8Yk
	 PMu+T7OMstFbJJiRVHhc+v/92Fj2G5NAJ7Bu9UWd7OgTjGHUWydnUcF88BTgoQdIJX
	 mQv8TjCxbCotHbWjfLMWsPHS0oyVtbaVP/TM2uDc+YZUi1DdciN5uqE5bTh6baxEc1
	 0E0maTLMEVfwA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:20 -0500
Subject: [PATCH v2 39/41] smb/server: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-39-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6992; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Bc7tS+aassSqdrdhnpohA5Vs8wnKfzMC2dWNyb0Wn/s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+xPvHMcFQ16NNadS1JpzZBMqEfqOkyuUsy
 JLpbxxLtgKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FcQHD/47CBUpbTK5oN3qm6hiNly+qXNrUEryOzV1nTvAr9HYQHyeOTS4QuhRoFfLUNFvCcCe3vy
 v8nQ/6817nMUbv+9n23/lmWhmaDKToPQf3MEf6+RAuf6Yb1Kb4hxwfEob2EYIRBmyPJ+ITa1F2Q
 FCqhyhhgy++yhvbUU5clP+8Ui/f+XsYOLZFx9H7tlz+TMhMY8M1t+a+ZDPz1TYV1i9DlNb1H1iP
 AL83P2+9qx8cbfGQ4uRdoBTkcWMNabO1Ehlo3E7e1V/lq60KUHhOsP1aGllPzLuAuUbbHPL3n5B
 Q/Jlge/j2eag9OxUk2N1ftXa8e9viDXADdibsPXg92FNmxhWa+WBMUcZ6O5U4wnq4/hbbiE2NSl
 WRoR0GhMhbpVjq6X4SoFlugLz1EsgOgUvlXe1ZZCy91OcdDYMmeZ9GdlihbzZAvKv78wG9TTGYc
 09GQFLnoZZHE8ydQNKWlTg5KjAlofnOnFTQkNZlyBJFGLeqOt91BVCCoWjM3TAjGrgioNQVHMnV
 KUcsPsGE0dj45hsE/+MsUmMxX25qkHqlBn92Qu5uCDDLq5fwwmIK7ZpuKMhzGo+JX2DAgNB0tpO
 CVaKvc3zVunZmpiOaYKGc3WDndHdtYz4V5qV++ZnDZPExyKeazWFE+0PFiMe9Nl70LyviAlLUiH
 ZtkrMAqk+/WfFZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/server/smb2pdu.c | 45 ++++++++++++++++++++++-----------------------
 fs/smb/server/vfs.c     | 15 +++++++--------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d12d11cdea29..1a1ce70c7b2d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -12,7 +12,6 @@
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
 #include <linux/mount.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "glob.h"
@@ -6761,10 +6760,10 @@ struct file_lock *smb_flock_init(struct file *f)
 
 	locks_init_lock(fl);
 
-	fl->fl_owner = f;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = f;
-	fl->fl_flags = FL_POSIX;
+	fl->fl_core.flc_owner = f;
+	fl->fl_core.flc_pid = current->tgid;
+	fl->fl_core.flc_file = f;
+	fl->fl_core.flc_flags = FL_POSIX;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -6781,30 +6780,30 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_SHARED:
 		ksmbd_debug(SMB, "received shared request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_RDLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->fl_core.flc_type = F_RDLCK;
+		flock->fl_core.flc_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE:
 		ksmbd_debug(SMB, "received exclusive request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_WRLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->fl_core.flc_type = F_WRLCK;
+		flock->fl_core.flc_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_SHARED | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received shared & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_RDLCK;
+		flock->fl_core.flc_type = F_RDLCK;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received exclusive & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.flc_type = F_WRLCK;
 		break;
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.flc_type = F_UNLCK;
 		cmd = F_SETLK;
 		break;
 	}
@@ -6842,13 +6841,13 @@ static void smb2_remove_blocked_lock(void **argv)
 	struct file_lock *flock = (struct file_lock *)argv[0];
 
 	ksmbd_vfs_posix_lock_unblock(flock);
-	wake_up(&flock->fl_wait);
+	wake_up(&flock->fl_core.flc_wait);
 }
 
 static inline bool lock_defer_pending(struct file_lock *fl)
 {
 	/* check pending lock waiters */
-	return waitqueue_active(&fl->fl_wait);
+	return waitqueue_active(&fl->fl_core.flc_wait);
 }
 
 /**
@@ -6939,8 +6938,8 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(cmp_lock, &lock_list, llist) {
 			if (cmp_lock->fl->fl_start <= flock->fl_start &&
 			    cmp_lock->fl->fl_end >= flock->fl_end) {
-				if (cmp_lock->fl->fl_type != F_UNLCK &&
-				    flock->fl_type != F_UNLCK) {
+				if (cmp_lock->fl->fl_core.flc_type != F_UNLCK &&
+				    flock->fl_core.flc_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
 					locks_free_lock(flock);
@@ -6988,12 +6987,12 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
-				if (file_inode(cmp_lock->fl->fl_file) !=
-				    file_inode(smb_lock->fl->fl_file))
+				if (file_inode(cmp_lock->fl->fl_core.flc_file) !=
+				    file_inode(smb_lock->fl->fl_core.flc_file))
 					continue;
 
-				if (smb_lock->fl->fl_type == F_UNLCK) {
-					if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file &&
+				if (smb_lock->fl->fl_core.flc_type == F_UNLCK) {
+					if (cmp_lock->fl->fl_core.flc_file == smb_lock->fl->fl_core.flc_file &&
 					    cmp_lock->start == smb_lock->start &&
 					    cmp_lock->end == smb_lock->end &&
 					    !lock_defer_pending(cmp_lock->fl)) {
@@ -7010,7 +7009,7 @@ int smb2_lock(struct ksmbd_work *work)
 					continue;
 				}
 
-				if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file) {
+				if (cmp_lock->fl->fl_core.flc_file == smb_lock->fl->fl_core.flc_file) {
 					if (smb_lock->flags & SMB2_LOCKFLAG_SHARED)
 						continue;
 				} else {
@@ -7052,7 +7051,7 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 		up_read(&conn_list_lock);
 out_check_cl:
-		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
+		if (smb_lock->fl->fl_core.flc_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
 			rsp->hdr.Status = STATUS_RANGE_NOT_LOCKED;
 			goto out;
@@ -7176,7 +7175,7 @@ int smb2_lock(struct ksmbd_work *work)
 		struct file_lock *rlock = NULL;
 
 		rlock = smb_flock_init(filp);
-		rlock->fl_type = F_UNLCK;
+		rlock->fl_core.flc_type = F_UNLCK;
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d0686ec344f5..2b67cccea91c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -6,7 +6,6 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
@@ -338,18 +337,18 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(flock, &ctx->flc_posix, fl_core.flc_list) {
 		/* check conflict locks */
 		if (flock->fl_end >= start && end >= flock->fl_start) {
-			if (flock->fl_type == F_RDLCK) {
+			if (flock->fl_core.flc_type == F_RDLCK) {
 				if (type == WRITE) {
 					pr_err("not allow write by shared lock\n");
 					error = 1;
 					goto out;
 				}
-			} else if (flock->fl_type == F_WRLCK) {
+			} else if (flock->fl_core.flc_type == F_WRLCK) {
 				/* check owner in lock */
-				if (flock->fl_file != filp) {
+				if (flock->fl_core.flc_file != filp) {
 					error = 1;
 					pr_err("not allow rw access by exclusive lock from other opens\n");
 					goto out;
@@ -1838,13 +1837,13 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 
 void ksmbd_vfs_posix_lock_wait(struct file_lock *flock)
 {
-	wait_event(flock->fl_wait, !flock->fl_blocker);
+	wait_event(flock->fl_core.flc_wait, !flock->fl_core.flc_blocker);
 }
 
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout)
 {
-	return wait_event_interruptible_timeout(flock->fl_wait,
-						!flock->fl_blocker,
+	return wait_event_interruptible_timeout(flock->fl_core.flc_wait,
+						!flock->fl_core.flc_blocker,
 						timeout);
 }
 

-- 
2.43.0


