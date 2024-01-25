Return-Path: <linux-fsdevel+bounces-8892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF583BFA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D493F1C23FB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA960BB5;
	Thu, 25 Jan 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYNbZ34m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986A60B9B;
	Thu, 25 Jan 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179472; cv=none; b=mGrNuil0NGIUDKBrcx2wKkiIZ4FJMrByI1vh9TYqLD7am3Tcc28WVWv28cVp1lawiuOHDYjvSlTIA6yPIqZNfBe+E2BXZ9Ck84SL2d6EPb4xJY9ZfpOeHMJ3HCQZ1curQ8MgkOBFwuODz2Wl3EI8H/uwXG9KuYc3XtfjpNClQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179472; c=relaxed/simple;
	bh=Ghbte5EbxS7nyasl+Gb2DnaWu0CsjIyjXTgQhNH8UK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VA11Z0dxCJae+F1dTIrCfH6rRg2wQf3XTc/hFLzV/bE8ejf7822jTMR9blTHTJhEwrGzllsJOnR3WDVeU4uw+sR5Wu4sTUzrlyzvZRVrjR7CrTMGBO7tlgyFNeMhiYbrrn0oP1H1/Ncs4kxeYrDoakm9USUtPrzLpS9bXn1mtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYNbZ34m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC1C43399;
	Thu, 25 Jan 2024 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179471;
	bh=Ghbte5EbxS7nyasl+Gb2DnaWu0CsjIyjXTgQhNH8UK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HYNbZ34m8uZQXpO00B79Hjf6dBM4nPvPZSVbPtgJBkhrIVKvI2WHn3rw6MLclixfE
	 8o8gXeOFmC2eITDSSdEeqXsKU6Qrezk8LB6L0s5w1TGSNF6+jcPyW5+rYsWyal4LtH
	 oyxODhKIt00Hli33Y4l893GYNXXEjidBw7S8C8rjZFpZPEL/HcIq0k2IOdgK9PO7LZ
	 hFrjK1rz5OetZpbGI5rkxFBx8dJOVU65sd7GU4tjUWIfMow6NXL7j2A1p3l0JamT4x
	 Cm9tlVtvHHisgLMvS/071UOpoI1gwHb98gvAAlL1bvGx3h/K61ZC7jWbTBrhXZKFF9
	 7Y7I1oAaSMaKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:01 -0500
Subject: [PATCH v2 20/41] filelock: convert __locks_insert_block, conflict
 and deadlock checks to use file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-20-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10987; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ghbte5EbxS7nyasl+Gb2DnaWu0CsjIyjXTgQhNH8UK4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8H6APyCBiq/PBoIYn3BDdbi8o+VVElAlQX
 8ov6ZUnCfSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FRTUEACgqkoVOH/M6C8gDaH3qq1l2QqyHcik8rnZgTJ1H5xgXr80OkqyZMpavgfPsoP2S+ygf9h
 VAyd+sPCux6LKaWpIA47Ae3N643sqzAV/C2BCGa58fJBU5KTfo15zdX4+uGqPlireIVmxYUJ1PR
 FOm0UEjp4zaxVFCwfWGXPnPRAC4TvfWYEkAuQiekNKFNIyq89P9agy/nDjCu3yCWvON2GNQ1422
 erInykImjOmsS9T+jdSyr0A+vVYVZKI+7AlkmGS154ODu2xGiv+q81O2qWj4sA0MaXX07tgz1bg
 xGGemeBqJIQWqD0xBPlAalitL7Fe8fgLZKDOiCyig1jKR0wHL6V4dxpHMhgzA6ZkPAPNEbtrigS
 Fj5aUlTcEWDRVVjgk4Ea5e7bndAcsZk4IcsOzVy04iz2l6Lxp6cEznGyRqy3++nXN7/pkJXp5ok
 fIJbqZjRRdJwvvPjO7NyMaFwQto8Q5T2Rx0n8DHaOdHPEbhuXf+N9Ok27N8TdHyYbGcO2mVHXgS
 Gl61qKtgoSsRWvMFSiCRuo/n5CvB+LFVjC16qdV/lyFIzNk0jzXOvp+FGeObc4XQiUwaB8aG6je
 qAQLJThOxZqZTmD8wfRQ+orN6Q/fN0fevaHv5p4pAsRDBcmkvvH8w+jNF/504LFt1PGK3pVq+JT
 hhRwYzO65pbsyYg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have both __locks_insert_block and the deadlock and conflict checking
functions take a struct file_lock_core pointer instead of a struct
file_lock one. Also, change posix_locks_deadlock to return bool.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 134 +++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index fb113103dc1b..a86841fc8220 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -757,39 +757,41 @@ EXPORT_SYMBOL(locks_delete_block);
  * waiters, and add beneath any waiter that blocks the new waiter.
  * Thus wakeups don't happen until needed.
  */
-static void __locks_insert_block(struct file_lock *blocker,
-				 struct file_lock *waiter,
-				 bool conflict(struct file_lock *,
-					       struct file_lock *))
+static void __locks_insert_block(struct file_lock *blocker_fl,
+				 struct file_lock *waiter_fl,
+				 bool conflict(struct file_lock_core *,
+					       struct file_lock_core *))
 {
-	struct file_lock *fl;
-	BUG_ON(!list_empty(&waiter->fl_core.flc_blocked_member));
+	struct file_lock_core *blocker = &blocker_fl->fl_core;
+	struct file_lock_core *waiter = &waiter_fl->fl_core;
+	struct file_lock_core *flc;
 
+	BUG_ON(!list_empty(&waiter->flc_blocked_member));
 new_blocker:
-	list_for_each_entry(fl, &blocker->fl_core.flc_blocked_requests,
-			    fl_core.flc_blocked_member)
-		if (conflict(fl, waiter)) {
-			blocker =  fl;
+	list_for_each_entry(flc, &blocker->flc_blocked_requests, flc_blocked_member)
+		if (conflict(flc, waiter)) {
+			blocker =  flc;
 			goto new_blocker;
 		}
-	waiter->fl_core.flc_blocker = blocker;
-	list_add_tail(&waiter->fl_core.flc_blocked_member,
-		      &blocker->fl_core.flc_blocked_requests);
-	if ((blocker->fl_core.flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
-		locks_insert_global_blocked(&waiter->fl_core);
+	waiter->flc_blocker = file_lock(blocker);
+	list_add_tail(&waiter->flc_blocked_member,
+		      &blocker->flc_blocked_requests);
 
-	/* The requests in waiter->fl_blocked are known to conflict with
+	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) == (FL_POSIX|FL_OFDLCK))
+		locks_insert_global_blocked(waiter);
+
+	/* The requests in waiter->flc_blocked are known to conflict with
 	 * waiter, but might not conflict with blocker, or the requests
 	 * and lock which block it.  So they all need to be woken.
 	 */
-	__locks_wake_up_blocks(&waiter->fl_core);
+	__locks_wake_up_blocks(waiter);
 }
 
 /* Must be called with flc_lock held. */
 static void locks_insert_block(struct file_lock *blocker,
 			       struct file_lock *waiter,
-			       bool conflict(struct file_lock *,
-					     struct file_lock *))
+			       bool conflict(struct file_lock_core *,
+					     struct file_lock_core *))
 {
 	spin_lock(&blocked_lock_lock);
 	__locks_insert_block(blocker, waiter, conflict);
@@ -846,12 +848,12 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static bool locks_conflict(struct file_lock *caller_fl,
-			   struct file_lock *sys_fl)
+static bool locks_conflict(struct file_lock_core *caller_fl,
+			   struct file_lock_core *sys_fl)
 {
-	if (sys_fl->fl_core.flc_type == F_WRLCK)
+	if (sys_fl->flc_type == F_WRLCK)
 		return true;
-	if (caller_fl->fl_core.flc_type == F_WRLCK)
+	if (caller_fl->flc_type == F_WRLCK)
 		return true;
 	return false;
 }
@@ -859,20 +861,23 @@ static bool locks_conflict(struct file_lock *caller_fl,
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
  * checking before calling the locks_conflict().
  */
-static bool posix_locks_conflict(struct file_lock *caller_fl,
-				 struct file_lock *sys_fl)
+static bool posix_locks_conflict(struct file_lock_core *caller_flc,
+				 struct file_lock_core *sys_flc)
 {
+	struct file_lock *caller_fl = file_lock(caller_flc);
+	struct file_lock *sys_fl = file_lock(sys_flc);
+
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
+	if (posix_same_owner(caller_flc, sys_flc))
 		return false;
 
 	/* Check whether they overlap */
 	if (!locks_overlap(caller_fl, sys_fl))
 		return false;
 
-	return locks_conflict(caller_fl, sys_fl);
+	return locks_conflict(caller_flc, sys_flc);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Used on xx_GETLK
@@ -881,28 +886,31 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 				      struct file_lock *sys_fl)
 {
+	struct file_lock_core *caller = &caller_fl->fl_core;
+	struct file_lock_core *sys = &sys_fl->fl_core;
+
 	/* F_UNLCK checks any locks on the same fd. */
-	if (caller_fl->fl_core.flc_type == F_UNLCK) {
-		if (!posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
+	if (caller->flc_type == F_UNLCK) {
+		if (!posix_same_owner(caller, sys))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
 	}
-	return posix_locks_conflict(caller_fl, sys_fl);
+	return posix_locks_conflict(caller, sys);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
  * checking before calling the locks_conflict().
  */
-static bool flock_locks_conflict(struct file_lock *caller_fl,
-				 struct file_lock *sys_fl)
+static bool flock_locks_conflict(struct file_lock_core *caller_flc,
+				 struct file_lock_core *sys_flc)
 {
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
-	if (caller_fl->fl_core.flc_file == sys_fl->fl_core.flc_file)
+	if (caller_flc->flc_file == sys_flc->flc_file)
 		return false;
 
-	return locks_conflict(caller_fl, sys_fl);
+	return locks_conflict(caller_flc, sys_flc);
 }
 
 void
@@ -980,25 +988,27 @@ EXPORT_SYMBOL(posix_test_lock);
 
 #define MAX_DEADLK_ITERATIONS 10
 
-/* Find a lock that the owner of the given block_fl is blocking on. */
-static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
+/* Find a lock that the owner of the given @blocker is blocking on. */
+static struct file_lock_core *what_owner_is_waiting_for(struct file_lock_core *blocker)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
-	hash_for_each_possible(blocked_hash, fl, fl_core.flc_link, posix_owner_key(&block_fl->fl_core)) {
-		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
-			while (fl->fl_core.flc_blocker)
-				fl = fl->fl_core.flc_blocker;
-			return fl;
+	hash_for_each_possible(blocked_hash, flc, flc_link, posix_owner_key(blocker)) {
+		if (posix_same_owner(flc, blocker)) {
+			while (flc->flc_blocker)
+				flc = &flc->flc_blocker->fl_core;
+			return flc;
 		}
 	}
 	return NULL;
 }
 
 /* Must be called with the blocked_lock_lock held! */
-static int posix_locks_deadlock(struct file_lock *caller_fl,
-				struct file_lock *block_fl)
+static bool posix_locks_deadlock(struct file_lock *caller_fl,
+				 struct file_lock *block_fl)
 {
+	struct file_lock_core *caller = &caller_fl->fl_core;
+	struct file_lock_core *blocker = &block_fl->fl_core;
 	int i = 0;
 
 	lockdep_assert_held(&blocked_lock_lock);
@@ -1007,16 +1017,16 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (caller_fl->fl_core.flc_flags & FL_OFDLCK)
-		return 0;
+	if (caller->flc_flags & FL_OFDLCK)
+		return false;
 
-	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
+	while ((blocker = what_owner_is_waiting_for(blocker))) {
 		if (i++ > MAX_DEADLK_ITERATIONS)
-			return 0;
-		if (posix_same_owner(&caller_fl->fl_core, &block_fl->fl_core))
-			return 1;
+			return false;
+		if (posix_same_owner(caller, blocker))
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
@@ -1071,7 +1081,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 
 find_conflict:
 	list_for_each_entry(fl, &ctx->flc_flock, fl_core.flc_list) {
-		if (!flock_locks_conflict(request, fl))
+		if (!flock_locks_conflict(&request->fl_core, &fl->fl_core))
 			continue;
 		error = -EAGAIN;
 		if (!(request->fl_core.flc_flags & FL_SLEEP))
@@ -1140,7 +1150,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 */
 	if (request->fl_core.flc_type != F_UNLCK) {
 		list_for_each_entry(fl, &ctx->flc_posix, fl_core.flc_list) {
-			if (!posix_locks_conflict(request, fl))
+			if (!posix_locks_conflict(&request->fl_core, &fl->fl_core))
 				continue;
 			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
 				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
@@ -1442,23 +1452,25 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 	}
 }
 
-static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
+static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc)
 {
 	bool rc;
+	struct file_lock *lease = file_lock(lc);
+	struct file_lock *breaker = file_lock(bc);
 
 	if (lease->fl_lmops->lm_breaker_owns_lease
 			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
 		return false;
-	if ((breaker->fl_core.flc_flags & FL_LAYOUT) != (lease->fl_core.flc_flags & FL_LAYOUT)) {
+	if ((bc->flc_flags & FL_LAYOUT) != (lc->flc_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
 	}
-	if ((breaker->fl_core.flc_flags & FL_DELEG) && (lease->fl_core.flc_flags & FL_LEASE)) {
+	if ((bc->flc_flags & FL_DELEG) && (lc->flc_flags & FL_LEASE)) {
 		rc = false;
 		goto trace;
 	}
 
-	rc = locks_conflict(breaker, lease);
+	rc = locks_conflict(bc, lc);
 trace:
 	trace_leases_conflict(rc, lease, breaker);
 	return rc;
@@ -1468,12 +1480,12 @@ static bool
 any_leases_conflict(struct inode *inode, struct file_lock *breaker)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry(fl, &ctx->flc_lease, fl_core.flc_list) {
-		if (leases_conflict(fl, breaker))
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		if (leases_conflict(flc, &breaker->fl_core))
 			return true;
 	}
 	return false;
@@ -1529,7 +1541,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.flc_list) {
-		if (!leases_conflict(fl, new_fl))
+		if (!leases_conflict(&fl->fl_core, &new_fl->fl_core))
 			continue;
 		if (want_write) {
 			if (fl->fl_core.flc_flags & FL_UNLOCK_PENDING)

-- 
2.43.0


