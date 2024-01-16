Return-Path: <linux-fsdevel+bounces-8111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60182F77D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A567C28442A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3081AA4;
	Tue, 16 Jan 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB/SitUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA038120B;
	Tue, 16 Jan 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434470; cv=none; b=Af+W+Voru5FhpGiqtYRHT7pELBc/X8kbxvO/wjJsUg9akVDdjtRDVrUEyxExoqSVK6fhFZSxM3eEneT2gDSEhQxaf+kcB+1AiJNWvbSRhsFcqOQipiM6U6l6475MxHyV54yY467lYPwjl0VvcrghcVhGWI80AuJaMKKmgasINZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434470; c=relaxed/simple;
	bh=kls0ou0CepUaWcmG52kQ6qFEQcCGT2zxwwb8Xgjj51M=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=ea3cVl1iKqq9hjBZj2mY5osBku19UcHEojOzx2Hj64WfKTPCNZY1OwemhwpucKDPq5oDPxjh7LhXgjy41Bk3zl41EAh1oDhdqDqEDrrzIfGKrQD0HHAEm5EXC5SrADqVPhtRqvSSsRRSPhK9rS/hknZ/Iw/ylGJJdXSjoDoLTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB/SitUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFD6C433F1;
	Tue, 16 Jan 2024 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434469;
	bh=kls0ou0CepUaWcmG52kQ6qFEQcCGT2zxwwb8Xgjj51M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JB/SitUhJfUwFnpyXYd9dt1UNVn2wpH3+LaieI2QKP1DW6mOOWviEEDRZrtrYWL2k
	 Ra/072r0nhRsWZvd0xbd2jROArzvpEZk4vSMBQLkmju4PnMjRYVog1kG+T6SZagr4j
	 w+Qk1Codi+TGkK50EEfta0H0jXRoWmoZkb58n64Gb4u0KfK1IjEZszaG/oGhSNkk56
	 S6vw/pq9iyo4+P8pGNUibJAEazvR1Gw2Ctdl0qt2GkKygXmQAJIblwqQmkA3QqFJi/
	 IyPehaJI3xo+oDo/EGAHPn3j41Sg0bo0yoOHi7Lqej/ZQJ8SwlY5RIVeqpoWPz9bGn
	 e69pLTekd546A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:12 -0500
Subject: [PATCH 16/20] filelock: reorganize locks_delete_block and
 __locks_insert_block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-16-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5173; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kls0ou0CepUaWcmG52kQ6qFEQcCGT2zxwwb8Xgjj51M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0i3yR4/c4kiH3TPF+F79Kq42wwoL7+Rx/zv
 amElbkvKFmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FbL8D/4k9g/iQZOsLtiBHHpIIf4BJI03BPbjvrz5xSL2ghQ1fayjQGKClMiDdt4ZoRmerAi5Q90
 hR5cA9VjEL05KtCttnutdl4dQMNNCblGtObbwY1AgemJcan92LF/yWc2iNNE3C2t5tdaepWXlHg
 /4XEyNMU3qY1u7Q1VFiNS5Q8DlEsBqZeWe57990Nw2ipNwBu5+nO18hZIcajx4k1SSQ9y9QHhsC
 wyV+edmSVt4IJOOrw4bQKpKooW+73rDjyczKsp4HRSdZ8Pnp+7w33h3zh2OJUECdWFw49FTkdCf
 7sSlBG8z2BRXBqKbeoPVGL85qQpI8ql0uhVGzr96hH15n85lUDrJro0ylwORtdlAbsi9i9DoFSm
 VR0iyPSBugjFwEpa331KPMlMJehUGcKjQMu2NvUiXNVwQH292cGtjOvq88Cd60ozv8mL6TpJP7p
 qr0u35L0POXs14HfHZ+GoVijX0RkSF5DYB4bVD1rOjTmWkwL3JzYMSC2dXAm/sqXUBcXy+KFljK
 CB5WPvn7lsnrwun4GdCzt8+cb+g67uraolCIgYAIUiGSQMH2YuLMs+IDgrnEL/xtQL0iRREc0VQ
 0RsjSyelSIyfqfzpdGz+Swz14kBsazKmo4FBbt9fyVxYdfNajfDADuoGzBWn4dHKaDTERbDyHBC
 oZTcZ70VgjZH4cQ==
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
 fs/locks.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3a028a8aafeb..27160dc65d63 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -682,7 +682,7 @@ static void locks_delete_global_blocked(struct file_lock_core *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
-static void __locks_delete_block(struct file_lock_core *waiter)
+static void __locks_unlink_block(struct file_lock_core *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_blocked_member);
@@ -698,7 +698,7 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 					  struct file_lock_core, fl_blocked_member);
 
 		fl = file_lock(waiter);
-		__locks_delete_block(waiter);
+		__locks_unlink_block(waiter);
 		if ((IS_POSIX(waiter) || IS_FLOCK(waiter)) &&
 		    fl->fl_lmops && fl->fl_lmops->lm_notify)
 			fl->fl_lmops->lm_notify(fl);
@@ -714,16 +714,9 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
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
@@ -754,16 +747,27 @@ int locks_delete_block(struct file_lock *waiter_fl)
 	if (waiter->fl_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
-	__locks_delete_block(waiter);
+	__locks_unlink_block(waiter);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(waiter->fl_blocker, NULL);
+	smp_store_release(&waiter->fl_blocker, NULL);
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
@@ -781,13 +785,11 @@ EXPORT_SYMBOL(locks_delete_block);
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
 	BUG_ON(!list_empty(&waiter->fl_blocked_member));
 
@@ -812,8 +814,8 @@ static void __locks_insert_block(struct file_lock *blocker_fl,
 }
 
 /* Must be called with flc_lock held. */
-static void locks_insert_block(struct file_lock *blocker,
-			       struct file_lock *waiter,
+static void locks_insert_block(struct file_lock_core *blocker,
+			       struct file_lock_core *waiter,
 			       bool conflict(struct file_lock_core *,
 					     struct file_lock_core *))
 {
@@ -1111,7 +1113,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->fl_core.fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request, flock_locks_conflict);
+		locks_insert_block(&fl->fl_core, &request->fl_core, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_core.fl_flags & FL_ACCESS)
@@ -1205,7 +1207,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			__locks_wake_up_blocks(&request->fl_core);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request,
+				__locks_insert_block(&fl->fl_core, &request->fl_core,
 						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
@@ -1598,7 +1600,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
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


