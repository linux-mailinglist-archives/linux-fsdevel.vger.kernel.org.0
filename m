Return-Path: <linux-fsdevel+bounces-9775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100E844C96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A261F219F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7793150997;
	Wed, 31 Jan 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOY3gKrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E06405CF;
	Wed, 31 Jan 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742315; cv=none; b=tADNaP9SyLw21qw8/IIQRuD5jSZFxTHBC7hOwuC3VEMjJtXT3tFj8B0pfhsg+JCW3UtPRIImlXStDPvynNHdLVXlFRYASTXIk17BfOi9C+SY+XEgHfOZSmLEGF/jU8Gytz51iB11mZJ/dhxWM+p+plaLdoPIrK+ueEDjWGk6Tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742315; c=relaxed/simple;
	bh=dSaCs+Bm9tYHBvdJMNSthOP35PYGis9sNBqXCIMGwHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxCOkaW0GI6RdPpWeVuO+SHMDknzaKW+A69j/8P2xH9Np/4yEyx4Gm1rMh1dfK42bNx27J45S4I6kPWbF5JxjBLGDuYzTGOZrpcj/gj/EggNF/AG6V/tNv6E+3aQuKdmCKRGf18g1MXFfE/kNvSAVz6d6tpAQQqAxPeZcOA05rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOY3gKrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AA2C43330;
	Wed, 31 Jan 2024 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742315;
	bh=dSaCs+Bm9tYHBvdJMNSthOP35PYGis9sNBqXCIMGwHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WOY3gKrNaCE7Z6Hjekb8T7UIi1Q+hERCivgVyOm11USYZkgFcQ0BoVZJgx1P5Lzy/
	 /pShYoWoRbkwLWjp20LfgauMh96yQ+foh/xZvCa7+F40YHduy89Yjf5rOM7R4nGEjZ
	 Iyn9GZszdeMwWF1JRAKUv8jcvz8d7wQcavfzvq6XXOFSLFUySqc/+i5dEZgqyVhIl5
	 Oxeo1BS2Gw4lmiy1cX7kxtz/klyB+pKWc1dTWL4IfOFYNP5494GXwCjaF530xZkWUY
	 VuMN+zAz1UTaj9rvFyQRnW0AYvQ52MJz8SoMLRWomfXsr6m4Srg9qfa+oXWsndYUay
	 lNrWN4Y5CKM2w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:26 -0500
Subject: [PATCH v3 45/47] smb/server: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-45-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5725; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dSaCs+Bm9tYHBvdJMNSthOP35PYGis9sNBqXCIMGwHo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutF0fHpDxQe5jd7zWIIwpMPJGlsF7Yac2CE2G
 lxsz8A1n9iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRdAAKCRAADmhBGVaC
 FVv/EACZP1vb4m2MAiHecxrrG3PB5py0xDrd+xmB2KuVNc5/qPeJzP9O7tZPac5IiEWooYvj6RT
 rmnU7vWnHPkVyOJdDgk3F7JyNxJAZm567WhCtzamBeFAxa3d2bRgCJpErmdp0LrdupEfvA3sCJ8
 L4zat4aOaMavhf87rih8A9bvrX8qMAzwOY6e6XCdo1HcCHfH3IGY+GHyv68IamLxaigGi1VAAWK
 iPOQkfIYdHNNo58K5DgFYCh/9rfFU7hpU079J7riSbwa4qiHnxtfBG5zjZZ3+3f4KVXetSHS4gy
 03iEQ3s6qVCuzFnsbZpzXyCDthrBf/M+h+TAeNolRhqqc5SKqVLNpaVk8G8Y6Ydztyk4vdpw3i0
 tv413xT4PEuG0EYR/W/qKIsMQgVKL3+pmhDUG+HNUfnXyPJWDZJcNL+Zm2+2ZC55ACurNT1aX3W
 DGIHccTExhwOh3R8hAFkYpNQkbBdgMg8/HZpyqovW84JFKQ1VpcUVGX+KJ0ilZFidTulmBFvedJ
 SdHN0IzOPlZxIXH5ftNIdCS+AroqjO15Pnup0jYO0s6VerZx2UlH3kpCljANt5+UilgAr/THbEg
 cJUBuvcPPTM9dQ6TtbZ5CwuBlTLHKPZvDUmXQGJ+WdQyaA8xdLHdKu3VwzRh7N4mL0BHGdYrgwO
 FPL4s6xJIlSUpZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/server/smb2pdu.c | 39 +++++++++++++++++++--------------------
 fs/smb/server/vfs.c     |  9 ++++-----
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 11cc28719582..bec0a846a8d5 100644
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
+	fl->c.flc_owner = f;
+	fl->c.flc_pid = current->tgid;
+	fl->c.flc_file = f;
+	fl->c.flc_flags = FL_POSIX;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -6781,30 +6780,30 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_SHARED:
 		ksmbd_debug(SMB, "received shared request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_RDLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->c.flc_type = F_RDLCK;
+		flock->c.flc_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE:
 		ksmbd_debug(SMB, "received exclusive request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_WRLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->c.flc_type = F_WRLCK;
+		flock->c.flc_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_SHARED | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received shared & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_RDLCK;
+		flock->c.flc_type = F_RDLCK;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received exclusive & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_WRLCK;
+		flock->c.flc_type = F_WRLCK;
 		break;
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
-		flock->fl_type = F_UNLCK;
+		flock->c.flc_type = F_UNLCK;
 		cmd = F_SETLK;
 		break;
 	}
@@ -6848,7 +6847,7 @@ static void smb2_remove_blocked_lock(void **argv)
 static inline bool lock_defer_pending(struct file_lock *fl)
 {
 	/* check pending lock waiters */
-	return waitqueue_active(&fl->fl_wait);
+	return waitqueue_active(&fl->c.flc_wait);
 }
 
 /**
@@ -6939,8 +6938,8 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(cmp_lock, &lock_list, llist) {
 			if (cmp_lock->fl->fl_start <= flock->fl_start &&
 			    cmp_lock->fl->fl_end >= flock->fl_end) {
-				if (cmp_lock->fl->fl_type != F_UNLCK &&
-				    flock->fl_type != F_UNLCK) {
+				if (cmp_lock->fl->c.flc_type != F_UNLCK &&
+				    flock->c.flc_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
 					locks_free_lock(flock);
@@ -6988,12 +6987,12 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
-				if (file_inode(cmp_lock->fl->fl_file) !=
-				    file_inode(smb_lock->fl->fl_file))
+				if (file_inode(cmp_lock->fl->c.flc_file) !=
+				    file_inode(smb_lock->fl->c.flc_file))
 					continue;
 
 				if (lock_is_unlock(smb_lock->fl)) {
-					if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file &&
+					if (cmp_lock->fl->c.flc_file == smb_lock->fl->c.flc_file &&
 					    cmp_lock->start == smb_lock->start &&
 					    cmp_lock->end == smb_lock->end &&
 					    !lock_defer_pending(cmp_lock->fl)) {
@@ -7010,7 +7009,7 @@ int smb2_lock(struct ksmbd_work *work)
 					continue;
 				}
 
-				if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file) {
+				if (cmp_lock->fl->c.flc_file == smb_lock->fl->c.flc_file) {
 					if (smb_lock->flags & SMB2_LOCKFLAG_SHARED)
 						continue;
 				} else {
@@ -7176,7 +7175,7 @@ int smb2_lock(struct ksmbd_work *work)
 		struct file_lock *rlock = NULL;
 
 		rlock = smb_flock_init(filp);
-		rlock->fl_type = F_UNLCK;
+		rlock->c.flc_type = F_UNLCK;
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5dc87649400b..c487e834331a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -6,7 +6,6 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
@@ -349,7 +348,7 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 				}
 			} else if (lock_is_write(flock)) {
 				/* check owner in lock */
-				if (flock->fl_file != filp) {
+				if (flock->c.flc_file != filp) {
 					error = 1;
 					pr_err("not allow rw access by exclusive lock from other opens\n");
 					goto out;
@@ -1838,13 +1837,13 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 
 void ksmbd_vfs_posix_lock_wait(struct file_lock *flock)
 {
-	wait_event(flock->fl_wait, !flock->fl_blocker);
+	wait_event(flock->c.flc_wait, !flock->c.flc_blocker);
 }
 
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout)
 {
-	return wait_event_interruptible_timeout(flock->fl_wait,
-						!flock->fl_blocker,
+	return wait_event_interruptible_timeout(flock->c.flc_wait,
+						!flock->c.flc_blocker,
 						timeout);
 }
 

-- 
2.43.0


