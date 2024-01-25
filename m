Return-Path: <linux-fsdevel+bounces-8895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0D83BFBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09F81F21E16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA30627FB;
	Thu, 25 Jan 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+xgrRXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64486169B;
	Thu, 25 Jan 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179483; cv=none; b=h6kNJYzpwwAuOiO79AcloWaDqvU11rCfp51DPVcTNjTpAU5dlAKfyv5oxp6anHdUaef0lpNolk1sbx5yv4Smd8ZX8pW+nrbIAooxwrwPdNwe6R5JL6hVWJ7Xm37y59Gs3tGji7DWWL8fPGdYt/xNA7ByVm6BLhoWwaVCFDY97Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179483; c=relaxed/simple;
	bh=P81l9CeupMYdqhOH3E0vPo3/X1cBmXJaSRU1Gd76sZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6rEUX4er94QZF+k6aiXW1C2U5zq8h6haXw/nrz35HRjqzys2uBPo4RPaES9+YNgiId/QfcwsVo8zT9+xJyYxwfX6hE1zf48M8GO2iinkm+h7X+ax+epyqAdR68TM0DA/hpJSQXpCNzXi/tTEz8KjF39wyqlHS70u+QN5qNxV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+xgrRXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984EEC43609;
	Thu, 25 Jan 2024 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179483;
	bh=P81l9CeupMYdqhOH3E0vPo3/X1cBmXJaSRU1Gd76sZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X+xgrRXHwj3X9Z+wKEUAdpsITdY51l0/DrrmPcHe5wJzMCrxiuVe5l9+i2+DHbioH
	 aFSfirU1QTiCgJst5ml2qFfu5tNW/2V/Ge2eg5j8ZzqaiiAuSdrDIG+SH4SbkxIZ87
	 6JpmeZhLRNeJlWPbVCh4kojN8RXRwj4KyzzYAilLsMA0k2xYEVgHmwuDGh0hrMEwR4
	 zUmerh0qwQRMKcFXH6Py46gOSGvwUJglbGZmRKnxtTL3X9h6x2Tv4trv4qD62LGWHb
	 t0/2uYTS9ynBXWVYccz2dHGh8GCXj7Gog1qHfGW3RxOZYPTpN7Qrcs/wpd7HdGHZpC
	 sKbRvNsGrsv7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:04 -0500
Subject: [PATCH v2 23/41] filelock: reorganize locks_delete_block and
 __locks_insert_block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-23-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5086; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P81l9CeupMYdqhOH3E0vPo3/X1cBmXJaSRU1Gd76sZo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8xMA7qbl9kJbsMDBBCmzEcIA40ThoVKWlb
 4BFfz22Z/2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FZ6WD/961IPRxkXS8cop9gsr/jf4ahobJvArZA2jWSgjo3uWNHxHorj+j8aEu0+9nPgHvI1o+qm
 mEW96VcBHiE4XoQuNUStNRCd+qE8YxCC8e/2T0T+rX8b+cs2O3/QtgIIfPSIPPUXu0thcvvnvbJ
 x3L6tNzRYvWbFVnfYcV/hT7xqKyAgsgC97fg9FTYOwhlmWxwBPLmS+4dT2GdjQ89XSsTON6K/n8
 b4XQdT6Ds5tSD0BO4WuHCblHp6vTUpenfiyNQ7prhZi+l63gC21oPb2fmQdkP2r5J8MjOWbIXQq
 g5GLnhI6rZZ3Va6E52c3uxAscKMmetu3RsOYIE/L8lQREB9kQw4iG1wBxuyUUZZ4edrOo3rSFJW
 VJgtvCq0Fh5yFHBBO5ynm2ltR1yfY3rBCp2F/qe+eb6LvagCay2ALxqtkNSCUtTOcKwBSwid6eD
 KtKqn9YmWjZ5AkjAta0XhYGU29reFEhDOW8HRrImJUPWmB+KfNO2HPWU2mGY9VPxV200UAJsTut
 NZBwfpzTLT1JeSbTwF3A/qh3bqKKA+vm4jBsERy/l+YiKz/UVLqZsVYBe2ElbKEnyRo3BwtvGku
 JV8oGCaa2Qs1kVpjKOBjOTMbetOTUpNkSdiRoaLWpWl5TXIjAMdkM5GG8S13QwoW6OTT6zzaFl0
 nOA9GMbW6+0vedw==
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
index 739af36d98df..647a778d2c85 100644
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
-	struct file_lock_core *waiter = &waiter_fl->fl_core;
 
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
+	return __locks_delete_block(&waiter->fl_core);
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
-	struct file_lock_core *blocker = &blocker_fl->fl_core;
-	struct file_lock_core *waiter = &waiter_fl->fl_core;
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
 		if (!(request->fl_core.flc_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request, flock_locks_conflict);
+		locks_insert_block(&fl->fl_core, &request->fl_core, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_core.flc_flags & FL_ACCESS)
@@ -1182,7 +1184,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			__locks_wake_up_blocks(&request->fl_core);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request,
+				__locks_insert_block(&fl->fl_core, &request->fl_core,
 						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
@@ -1575,7 +1577,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl, leases_conflict);
+	locks_insert_block(&fl->fl_core, &new_fl->fl_core, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);

-- 
2.43.0


