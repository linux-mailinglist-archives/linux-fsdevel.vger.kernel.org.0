Return-Path: <linux-fsdevel+bounces-9758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D3F844C42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E5292AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32691420C5;
	Wed, 31 Jan 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX9GxtHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CA1420A0;
	Wed, 31 Jan 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742248; cv=none; b=f7Xnv6DHmlId0Mz/blW67MzX3A/t+pfvqMiTFEkmt/FfBocQHovfZEt/rKeyctVZ9+m06JTqgtJFVVfQWy0JtxZVzQFSkp0uV4vpFL209j80T33MBUV7T3k37lGR2bBViICV1API7WXkDYI8l0DNeUVe3LU+4xr02LJ46toUVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742248; c=relaxed/simple;
	bh=oXsh7Z3Zj8YwVWNqhAyX9dCLEvRylLbk3GgRqMltkDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxKUKtuKn/gV+wNlNUddWnDj35dwQzAyPpcIwqoiVPaB0HWcKOP7e08QfIOFGsllTvfNtCPEwpu4iV7hcd0+YWN2RMmSxKY46ljBErslGgJPkND9Wd/NwhLmFkG/mFoYWNhItO2YIQTlFbMSor8/wvB5JCoCqcrJ8rdSHiW+4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX9GxtHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFC5C433B1;
	Wed, 31 Jan 2024 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742247;
	bh=oXsh7Z3Zj8YwVWNqhAyX9dCLEvRylLbk3GgRqMltkDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HX9GxtHji864xbCpDr8dxOatkhLnwmHD0kzn3uJRfOEEC8HMzkSQFFqiWpcbIe3II
	 8p97Hc3SuHpM6Gx9Gp5KIVavPWCQdNdOmdbGlav4n+VNubaw53U/nNlh4VUXSe6Tag
	 +K+KHbMb0HRmHeEdutcN9e6mWqsgOJCSrR/tI5eDCKq7+k+S7Cxfd4wRsNxA6vwOGB
	 de0Z0sMVLDjlMlaUKMgDvaYPhOkk/4WeAw/VEbMRbkZ9hbUxRU2XQwh4Dda41PL/c4
	 E2bXVexu35OP7niUGHSjDIICZ+oLBrXa/jPyCof119NB79ydojsS765KLBhLa1nXUY
	 YR6xc72bd3emA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:09 -0500
Subject: [PATCH v3 28/47] filelock: reorganize locks_delete_block and
 __locks_insert_block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-28-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5008; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oXsh7Z3Zj8YwVWNqhAyX9dCLEvRylLbk3GgRqMltkDI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxzre30atP5W7Sf7TY3lvrDobazNYOrGTQw
 1ZIjFXzhniJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FUqXD/93uE7hJ0eDVn4U040TdajOsoJFEqE1JMzX+yb36gB+XiyHGvC/8ulONCZCBeKaFB4uZ2v
 aV0ZxfzvOUN+PUbUt+vgA+K4V4x3CsJT/Y3XzKtyCusvA5Wd+TJ1mYIAmp2n2oyD2wzn/vTopV2
 to5rboxgaRQ57Qofqun64NDS/ZbvIVGgD36Y9Lsix9ZWqKTGwFJ08BLk1rimPLzbJHIg9lI/mFk
 VgJkncKS7d3skJ//+XzGLwAk4sZwtaPBk2HBu4H5VES9qVbC2NqwJu7zUKVao4j5AZHXaW2f0wB
 dAHFnfDDVA7ReLiv42YsbZeT8+2UikrtbQoqqRyEkDVGm5HpN3fU47lzP/7iaZ1qc6et80DnRKq
 tXbGmic0tpS7TdODZBv0CdatkBY04US4dYS52Kz4zmyYYXfuiilIigYeuYfoqQ081KE9uOunPsJ
 VTyeCUdfEdaaBpHpN8210I55Yg4QU8R6cjSPB+WAdQYoNdIISmIivpjMWNpNvahI6R20apzB2hg
 i8dIqBXN4/rr+BaEiYLFdezT3ENS36+E2QMrhRJrgp67NjPgv6/M5hkiMHr3IMLcbNLOLyA2I71
 qvak+Vhs5kLhHFmdsWNKsG0WJL4LfI8LeuXFNZJYvFN0cZvi2Sg2Av9qKBFpRAOxX6TNug8QQFu
 x1WBiRjN1IzKhfA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Rename the old __locks_delete_block to __locks_unlink_lock. Rename
change old locks_delete_block function to __locks_delete_block and
have it take a file_lock_core. Make locks_delete_block a simple wrapper
around __locks_delete_block.

Also, change __locks_insert_block to take struct file_lock_core, and
fix up its callers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index a2be1e0b5a94..c8fd2964dd98 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -659,7 +659,7 @@ static void locks_delete_global_blocked(struct file_lock_core *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
-static void __locks_delete_block(struct file_lock_core *waiter)
+static void __locks_unlink_block(struct file_lock_core *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->flc_blocked_member);
@@ -675,7 +675,7 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 					  struct file_lock_core, flc_blocked_member);
 
 		fl = file_lock(waiter);
-		__locks_delete_block(waiter);
+		__locks_unlink_block(waiter);
 		if ((waiter->flc_flags & (FL_POSIX | FL_FLOCK)) &&
 		    fl->fl_lmops && fl->fl_lmops->lm_notify)
 			fl->fl_lmops->lm_notify(fl);
@@ -691,16 +691,9 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 	}
 }
 
-/**
- *	locks_delete_block - stop waiting for a file lock
- *	@waiter: the lock which was waiting
- *
- *	lockd/nfsd need to disconnect the lock while working on it.
- */
-int locks_delete_block(struct file_lock *waiter_fl)
+static int __locks_delete_block(struct file_lock_core *waiter)
 {
 	int status = -ENOENT;
-	struct file_lock_core *waiter = &waiter_fl->c;
 
 	/*
 	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
@@ -731,7 +724,7 @@ int locks_delete_block(struct file_lock *waiter_fl)
 	if (waiter->flc_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
-	__locks_delete_block(waiter);
+	__locks_unlink_block(waiter);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
@@ -741,6 +734,17 @@ int locks_delete_block(struct file_lock *waiter_fl)
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
+
+/**
+ *	locks_delete_block - stop waiting for a file lock
+ *	@waiter: the lock which was waiting
+ *
+ *	lockd/nfsd need to disconnect the lock while working on it.
+ */
+int locks_delete_block(struct file_lock *waiter)
+{
+	return __locks_delete_block(&waiter->c);
+}
 EXPORT_SYMBOL(locks_delete_block);
 
 /* Insert waiter into blocker's block list.
@@ -758,13 +762,11 @@ EXPORT_SYMBOL(locks_delete_block);
  * waiters, and add beneath any waiter that blocks the new waiter.
  * Thus wakeups don't happen until needed.
  */
-static void __locks_insert_block(struct file_lock *blocker_fl,
-				 struct file_lock *waiter_fl,
+static void __locks_insert_block(struct file_lock_core *blocker,
+				 struct file_lock_core *waiter,
 				 bool conflict(struct file_lock_core *,
 					       struct file_lock_core *))
 {
-	struct file_lock_core *blocker = &blocker_fl->c;
-	struct file_lock_core *waiter = &waiter_fl->c;
 	struct file_lock_core *flc;
 
 	BUG_ON(!list_empty(&waiter->flc_blocked_member));
@@ -789,8 +791,8 @@ static void __locks_insert_block(struct file_lock *blocker_fl,
 }
 
 /* Must be called with flc_lock held. */
-static void locks_insert_block(struct file_lock *blocker,
-			       struct file_lock *waiter,
+static void locks_insert_block(struct file_lock_core *blocker,
+			       struct file_lock_core *waiter,
 			       bool conflict(struct file_lock_core *,
 					     struct file_lock_core *))
 {
@@ -1088,7 +1090,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->c.flc_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request, flock_locks_conflict);
+		locks_insert_block(&fl->c, &request->c, flock_locks_conflict);
 		goto out;
 	}
 	if (request->c.flc_flags & FL_ACCESS)
@@ -1182,7 +1184,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			__locks_wake_up_blocks(&request->c);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request,
+				__locks_insert_block(&fl->c, &request->c,
 						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
@@ -1575,7 +1577,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl, leases_conflict);
+	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);

-- 
2.43.0


