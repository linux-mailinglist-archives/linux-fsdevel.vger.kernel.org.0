Return-Path: <linux-fsdevel+bounces-8108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAD82F76B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D0287834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B622318;
	Tue, 16 Jan 2024 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX8LQhaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFA7CF3E;
	Tue, 16 Jan 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434458; cv=none; b=S6AaqkBEngVBHE6URGtK+U8Ynf6BtpzBZjoF5L4h6FbUUgA962NgeLPyw2Se5h5x6enYN2cbkaMASs2rO1KwWurNcf3CjturlefH/XMVbgfNHHcaxMISfWVKuV4aUyR7qnO+MYdT4iTI1XO4nFAZ3xIWlYkFs24k2Lv5ugU28pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434458; c=relaxed/simple;
	bh=pwXKsOLMA39qGe1pWMGJ+cEJ/IOGKFqtfcRpJaO4ADs=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=uPE6CzsE8GmvGWbJ6zj3KAu2cF+wOR5RJQbpSgVaRkTPwl8QBaHdiywzeWF6dPG3HmaNJbL8zDxx5+cuSeN6pUqzWjYvCkkPTKT4kLnSGVcopNw+sDzqfrOQIywY5l+Ss35dOVxslY2QTPpOWUS7a6Im/dUZQtClkvN/LsQJ9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX8LQhaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50558C43390;
	Tue, 16 Jan 2024 19:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434458;
	bh=pwXKsOLMA39qGe1pWMGJ+cEJ/IOGKFqtfcRpJaO4ADs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KX8LQhaG7gcLIN8wB5hcLNWMPpZkdBfa5pQuw3JMkaLkY3p5HVP3riXhXktFNgcav
	 uNplozIrYQPkL8OE67thPoA4PLrmYTC4yVaSAUXWEi97QkcAOfqhMYNv1TuBphhOHM
	 LrZqUYXOskQkCM9XfNTL7KWPpw9CCIKED12EbN5OnlQrckAMzzq0FPreIr7L1ajCAK
	 ef8edYI5YFSLlXZUXbuZV5iSFnBXGdK4iSr6U+AmYMhCiHahVnYmV5ny1a37BGWloa
	 qHAqQnJKcpA28je/tpx8M+v0bUQzO3wqox6VgfK/XI7H1CTlobiCgRKOvMSQsDRmdo
	 0eAWhGnNTrMcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:09 -0500
Subject: [PATCH 13/20] filelock: convert __locks_insert_block, conflict and
 deadlock checks to use file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-13-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10881; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pwXKsOLMA39qGe1pWMGJ+cEJ/IOGKFqtfcRpJaO4ADs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0hs8i3UlSny6JLQMGxbpqdfGCP/rIswXMio
 dcEEduC982JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FQ9tD/41k11ICXk15Y9Te7Z3HUZHaJn4udDfFN0uHj75kXGXAIHblmPG8U8xiAMtkiIVBJFEXUu
 jgmjAhkUcoHTIeLH7uijcwJI8VvMSWwf2icK7y1CarU114iJED/NJT9EqPYY29v+flqDTZ6walz
 W/m15lnn3XhUKVpICHpR5ywmJ0rrBxIG7zbFKTW86qPrQknIuTeQNziZUTTO1j7kKF1SwxzR5N/
 gB2/qIHhGvcfNnyl64TfkyJg47o5XdzlpZn1ha35O5T+Ji+UXFG27gTXMhlywhxJ4HPO3Izo8iE
 0AzAItP3wRARdJBbc3L+pd8xKZUdCe0XhNDDm9LABfOmPCMa/EyDMwdeFa3bNKeQG2UCMB61SJz
 /pjR0OrV/Upu39irnotDryYb3MJ9WsuI6j91J5di9veTfin3lqCbRosQ41UE2dB0tO331TGuJIx
 S8Vi1wwV+OwmcXPfSR4UuVnyTsx6GHeHzQ5+KJQkSueoBsC70bLRhXfNF0p6nHEk+9FwM6iCHKi
 VYiBz92ICl47NBkgG3xjMyJSVxkvZaoZJD2uOVP+2d+nJzxxhytMoBMXDOHk9wc/5RVw+Dxe3M5
 YNklTNCWQ1YFmIm6ylavX+/JfEGIgNWSP1yj9xKbrbxh3zCLN9GkHIAK9RMwNtZyM4k44n8l8U+
 L7mvGHfF9WiChBA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have both __locks_insert_block and the deadlock and conflict checking
functions take a struct file_lock_core pointer instead of a struct
file_lock one. Also, change posix_locks_deadlock to return bool.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 132 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6b8e8820dec9..280149860d5e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -780,42 +780,41 @@ EXPORT_SYMBOL(locks_delete_block);
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
-	struct file_lock_core *bflc;
-	BUG_ON(!list_empty(&waiter->fl_core.fl_blocked_member));
+	struct file_lock_core *blocker = &blocker_fl->fl_core;
+	struct file_lock_core *waiter = &waiter_fl->fl_core;
+	struct file_lock_core *flc;
+	BUG_ON(!list_empty(&waiter->fl_blocked_member));
 
 new_blocker:
-	list_for_each_entry(fl, &blocker->fl_core.fl_blocked_requests,
-			    fl_core.fl_blocked_member)
-		if (conflict(fl, waiter)) {
-			blocker =  fl;
+	list_for_each_entry(flc, &blocker->fl_blocked_requests, fl_blocked_member)
+		if (conflict(flc, waiter)) {
+			blocker =  flc;
 			goto new_blocker;
 		}
-	waiter->fl_core.fl_blocker = blocker;
-	list_add_tail(&waiter->fl_core.fl_blocked_member,
-		      &blocker->fl_core.fl_blocked_requests);
+	waiter->fl_blocker = file_lock(blocker);
+	list_add_tail(&waiter->fl_blocked_member,
+		      &blocker->fl_blocked_requests);
 
-	bflc = &blocker->fl_core;
-	if (IS_POSIX(bflc) && !IS_OFDLCK(bflc))
-		locks_insert_global_blocked(&waiter->fl_core);
+	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
+		locks_insert_global_blocked(waiter);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
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
@@ -872,12 +871,12 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static bool locks_conflict(struct file_lock *caller_fl,
-			   struct file_lock *sys_fl)
+static bool locks_conflict(struct file_lock_core *caller_fl,
+			   struct file_lock_core *sys_fl)
 {
-	if (sys_fl->fl_core.fl_type == F_WRLCK)
+	if (sys_fl->fl_type == F_WRLCK)
 		return true;
-	if (caller_fl->fl_core.fl_type == F_WRLCK)
+	if (caller_fl->fl_type == F_WRLCK)
 		return true;
 	return false;
 }
@@ -885,20 +884,23 @@ static bool locks_conflict(struct file_lock *caller_fl,
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
@@ -907,28 +909,31 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 				      struct file_lock *sys_fl)
 {
+	struct file_lock_core *caller = &caller_fl->fl_core;
+	struct file_lock_core *sys = &sys_fl->fl_core;
+
 	/* F_UNLCK checks any locks on the same fd. */
-	if (caller_fl->fl_core.fl_type == F_UNLCK) {
-		if (!posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
+	if (caller->fl_type == F_UNLCK) {
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
-	if (caller_fl->fl_core.fl_file == sys_fl->fl_core.fl_file)
+	if (caller_flc->fl_file == sys_flc->fl_file)
 		return false;
 
-	return locks_conflict(caller_fl, sys_fl);
+	return locks_conflict(caller_flc, sys_flc);
 }
 
 void
@@ -1006,27 +1011,28 @@ EXPORT_SYMBOL(posix_test_lock);
 
 #define MAX_DEADLK_ITERATIONS 10
 
-/* Find a lock that the owner of the given block_fl is blocking on. */
-static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
+/* Find a lock that the owner of the given @blocker is blocking on. */
+static struct file_lock_core *what_owner_is_waiting_for(struct file_lock_core *blocker)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
-	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(&block_fl->fl_core)) {
-		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
-			while (fl->fl_core.fl_blocker)
-				fl = fl->fl_core.fl_blocker;
-			return fl;
+	hash_for_each_possible(blocked_hash, flc, fl_link, posix_owner_key(blocker)) {
+		if (posix_same_owner(flc, blocker)) {
+			while (flc->fl_blocker)
+				flc = &flc->fl_blocker->fl_core;
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
-	struct file_lock_core *flc = &caller_fl->fl_core;
 
 	lockdep_assert_held(&blocked_lock_lock);
 
@@ -1034,16 +1040,16 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (IS_OFDLCK(flc))
+	if (IS_OFDLCK(caller))
 		return 0;
 
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
@@ -1098,7 +1104,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 
 find_conflict:
 	list_for_each_entry(fl, &ctx->flc_flock, fl_core.fl_list) {
-		if (!flock_locks_conflict(request, fl))
+		if (!flock_locks_conflict(&request->fl_core, &fl->fl_core))
 			continue;
 		error = -EAGAIN;
 		if (!(request->fl_core.fl_flags & FL_SLEEP))
@@ -1167,7 +1173,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 */
 	if (request->fl_core.fl_type != F_UNLCK) {
 		list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
-			if (!posix_locks_conflict(request, fl))
+			if (!posix_locks_conflict(&request->fl_core, &fl->fl_core))
 				continue;
 			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
 				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
@@ -1469,23 +1475,25 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
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
-	if ((breaker->fl_core.fl_flags & FL_LAYOUT) != (lease->fl_core.fl_flags & FL_LAYOUT)) {
+	if ((bc->fl_flags & FL_LAYOUT) != (lc->fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
 	}
-	if ((breaker->fl_core.fl_flags & FL_DELEG) && (lease->fl_core.fl_flags & FL_LEASE)) {
+	if ((bc->fl_flags & FL_DELEG) && (lc->fl_flags & FL_LEASE)) {
 		rc = false;
 		goto trace;
 	}
 
-	rc = locks_conflict(breaker, lease);
+	rc = locks_conflict(bc, lc);
 trace:
 	trace_leases_conflict(rc, lease, breaker);
 	return rc;
@@ -1495,12 +1503,12 @@ static bool
 any_leases_conflict(struct inode *inode, struct file_lock *breaker)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
-		if (leases_conflict(fl, breaker))
+	list_for_each_entry(flc, &ctx->flc_lease, fl_list) {
+		if (leases_conflict(flc, &breaker->fl_core))
 			return true;
 	}
 	return false;
@@ -1556,7 +1564,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list) {
-		if (!leases_conflict(fl, new_fl))
+		if (!leases_conflict(&fl->fl_core, &new_fl->fl_core))
 			continue;
 		if (want_write) {
 			if (fl->fl_core.fl_flags & FL_UNLOCK_PENDING)

-- 
2.43.0


