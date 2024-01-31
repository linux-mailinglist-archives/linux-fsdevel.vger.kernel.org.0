Return-Path: <linux-fsdevel+bounces-9755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF94844D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32534B30453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992514076A;
	Wed, 31 Jan 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+ffT/qR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDD13F00E;
	Wed, 31 Jan 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742236; cv=none; b=jPemhmc2nrPzK8FRY4DWHBXhgC+5lhcrM8CluIhElvamaGnYjO8rJE54qgXS/n4U43m4FD2V9gOcdfR1JeSoVNFGlVizxcWgMOTiRLnZlSdKYhwg/f48ue/PFxj2pJOT/gR5pHGFmgBn+3zyCbwQ5DKEeQuepTco9wo0Yy5rAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742236; c=relaxed/simple;
	bh=0YFUDJ7msiDJew/mNCnxfjta1yyk32KWVjgnCpcvpMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVJqXBAV/Th61j82L1C76iiBEYsAamIIduPZmT5YKHTWdiJlKfzOrk53vmePLKLkdI04yigEEVqEo07dJGNQ4FIrMW8RBXFIPwvCuh0+FZmPinirjk/az/B4MCIoehBx5kGDXpYNKDVcrs1nxH38A4ZmowXWHDrTduPQTkDfuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+ffT/qR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4683C43142;
	Wed, 31 Jan 2024 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742235;
	bh=0YFUDJ7msiDJew/mNCnxfjta1yyk32KWVjgnCpcvpMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j+ffT/qRGIsGgz7Jqzd9hFBoN1Tn9RQ6JDVbg1U693+Fpptc9ZaE/Y6oXUkrA8MTT
	 /9mpWYv7m+K91RPgB2aiiJ3GBvl8yEswcC+FD1XKvPHiU04qAIDVQuiScXO2gClieA
	 lHO5gMgCDRwiUprffe8iT7bacedFSv+P0+rUEVeQMhENNRCP0uY37XKEQb/1feL0PS
	 O8tYH6sGuBpNgDVy2lSCzeMfZ+Tlpj3UCTltualRUvEdhaeRiN8/X2g/fvC+J/0UUB
	 u9UG16Oeh4Xvrq5vI39WturtSbYil6d4AgZZFt5H7G4pV7T3abdqdJTD/J7NsqM2mY
	 c7iC6Nbod/trQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:06 -0500
Subject: [PATCH v3 25/47] filelock: convert __locks_insert_block, conflict
 and deadlock checks to use file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-25-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0YFUDJ7msiDJew/mNCnxfjta1yyk32KWVjgnCpcvpMM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFx/6/Tc/SoK4BCxBcA+1wRfGg6cmkImyPId
 q4q443BjQyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FfLYEADJShn/debHumZsaq9gcK/vGBoD6YKcC8ybLKrX4xjExxzTZOsKQCkRCzA0/+fBR9jD20w
 V7UYkaXu76rQWlsAUZowZ3GZNjeQO6o8hCrnJcEkWJlpw0jbQmQ/xGfbaSTc23trRjbbz2xUr5v
 xB++JmkmFK7GD4iajv084u6isNK076nWeBJvlJItLKljMvw2nxLY26SNuaRVsUUhFGydc8cwx0m
 FIoJ9SP0lRNCtWQV+kaTHg7ePur3I8UN+2UWtGgYcxX+sRBoJ8+lUfqKLccS0Q8VI8lIEKan+vt
 +X+++I+UsHHBqjjHvSBc6A/+YCwNqd3KCq/7F+0p6jAjdsks1E2y3eV0MMq5ajhluCzO0RlCyaq
 9ASjGcX7UgPJ/l+PwvoQudA9ZVP/KP6C60UVvuvn7I5HYCwX/+9WZQGsMCU24NGtMJ+CJylgNIm
 RaiJC+ViGl1AMs6KHea0yVYs6s9pOFnnXr3VIxKRPhWKC7K7Cix4HgaTpngEzGW9ioKDJyH09+C
 FMh0A851xx6zE6GGAfBR59u7yEB92OJtm3Jryuawys2ZUxgfazZw0kxGUVKLin+Z6Zy/HRY++97
 Qfy08JFMvZ28zH/IRUuH/pImXXT16B/Yoqb3DX2dH/71f0uID1bYAYDpdc07QgEukMGbO81rWjQ
 4MFpN4V6wZQMnAQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have both __locks_insert_block and the deadlock and conflict checking
functions take a struct file_lock_core pointer instead of a struct
file_lock one. Also, change posix_locks_deadlock to return bool.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 132 +++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 72 insertions(+), 60 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1e8b943bd7f9..0dc1c9da858c 100644
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
-	BUG_ON(!list_empty(&waiter->c.flc_blocked_member));
+	struct file_lock_core *blocker = &blocker_fl->c;
+	struct file_lock_core *waiter = &waiter_fl->c;
+	struct file_lock_core *flc;
 
+	BUG_ON(!list_empty(&waiter->flc_blocked_member));
 new_blocker:
-	list_for_each_entry(fl, &blocker->c.flc_blocked_requests,
-			    c.flc_blocked_member)
-		if (conflict(fl, waiter)) {
-			blocker =  fl;
+	list_for_each_entry(flc, &blocker->flc_blocked_requests, flc_blocked_member)
+		if (conflict(flc, waiter)) {
+			blocker =  flc;
 			goto new_blocker;
 		}
-	waiter->c.flc_blocker = blocker;
-	list_add_tail(&waiter->c.flc_blocked_member,
-		      &blocker->c.flc_blocked_requests);
-	if ((blocker->c.flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
-		locks_insert_global_blocked(&waiter->c);
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
-	__locks_wake_up_blocks(&waiter->c);
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
+static bool locks_conflict(struct file_lock_core *caller_flc,
+			   struct file_lock_core *sys_flc)
 {
-	if (lock_is_write(sys_fl))
+	if (sys_flc->flc_type == F_WRLCK)
 		return true;
-	if (lock_is_write(caller_fl))
+	if (caller_flc->flc_type == F_WRLCK)
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
-	if (posix_same_owner(&caller_fl->c, &sys_fl->c))
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
+	struct file_lock_core *caller = &caller_fl->c;
+	struct file_lock_core *sys = &sys_fl->c;
+
 	/* F_UNLCK checks any locks on the same fd. */
 	if (lock_is_unlock(caller_fl)) {
-		if (!posix_same_owner(&caller_fl->c, &sys_fl->c))
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
-	if (caller_fl->c.flc_file == sys_fl->c.flc_file)
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
 
-	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(&block_fl->c)) {
-		if (posix_same_owner(&fl->c, &block_fl->c)) {
-			while (fl->c.flc_blocker)
-				fl = fl->c.flc_blocker;
-			return fl;
+	hash_for_each_possible(blocked_hash, flc, flc_link, posix_owner_key(blocker)) {
+		if (posix_same_owner(flc, blocker)) {
+			while (flc->flc_blocker)
+				flc = &flc->flc_blocker->c;
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
+	struct file_lock_core *caller = &caller_fl->c;
+	struct file_lock_core *blocker = &block_fl->c;
 	int i = 0;
 
 	lockdep_assert_held(&blocked_lock_lock);
@@ -1007,16 +1017,16 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (caller_fl->c.flc_flags & FL_OFDLCK)
-		return 0;
+	if (caller->flc_flags & FL_OFDLCK)
+		return false;
 
-	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
+	while ((blocker = what_owner_is_waiting_for(blocker))) {
 		if (i++ > MAX_DEADLK_ITERATIONS)
-			return 0;
-		if (posix_same_owner(&caller_fl->c, &block_fl->c))
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
 	list_for_each_entry(fl, &ctx->flc_flock, c.flc_list) {
-		if (!flock_locks_conflict(request, fl))
+		if (!flock_locks_conflict(&request->c, &fl->c))
 			continue;
 		error = -EAGAIN;
 		if (!(request->c.flc_flags & FL_SLEEP))
@@ -1140,7 +1150,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 */
 	if (request->c.flc_type != F_UNLCK) {
 		list_for_each_entry(fl, &ctx->flc_posix, c.flc_list) {
-			if (!posix_locks_conflict(request, fl))
+			if (!posix_locks_conflict(&request->c, &fl->c))
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
-	if ((breaker->c.flc_flags & FL_LAYOUT) != (lease->c.flc_flags & FL_LAYOUT)) {
+	if ((bc->flc_flags & FL_LAYOUT) != (lc->flc_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
 	}
-	if ((breaker->c.flc_flags & FL_DELEG) && (lease->c.flc_flags & FL_LEASE)) {
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
 
-	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
-		if (leases_conflict(fl, breaker))
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		if (leases_conflict(flc, &breaker->c))
 			return true;
 	}
 	return false;
@@ -1529,7 +1541,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
-		if (!leases_conflict(fl, new_fl))
+		if (!leases_conflict(&fl->c, &new_fl->c))
 			continue;
 		if (want_write) {
 			if (fl->c.flc_flags & FL_UNLOCK_PENDING)

-- 
2.43.0


