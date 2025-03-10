Return-Path: <linux-fsdevel+bounces-43586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5FA5900F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF723A743D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C038228CB8;
	Mon, 10 Mar 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN2VF5Wa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEA229B38
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599782; cv=none; b=r8/BqXa2T/6FZKmY6X17JQObMO/HazEZaeMl5BNtzpbFBjU/bVCVx+zIjcw1D8MyPB4GHJG1oo9kVDsqsr3sf0HaW/bb1P71aTHMOPaJE9zsFxsV8A5D1udEKaAYUNGSzFOc0u07LreOar5gfJlRjCxgG2TS1X8us9qjxPhaH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599782; c=relaxed/simple;
	bh=aumxTOPjrUnUuW6eC/ryM/5CyTHCARkXtAow5GOwo0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4Ruuk1W4+OnVdQ+mb7QBfIh0cFCevepLIUk9Gz0AM15GoQ7EhYYDz6hyZA0C/4pLjO3tJBFRNuSZZm7EKeBi2CeZ+hmLLlwwc+vBJRmrvnMHbGk4Zxb7ZejqZsTDUmkkTFKcUjR9nmUdIz6rqJPUoxPFLCl0UyiXPs2PlDs220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QN2VF5Wa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAvciIykKJLMNxGHQf8kaQjS1DwchiuzyQPyLasKTWg=;
	b=QN2VF5WaQqZC3VT6fJW+y/QfUnFuxyKImVc95t6GCr0/stxrpqwZNBojUt2sGSK98xRqm8
	842KS2bMk1A6O9YQ3cx2oelGZa2b64N6nIQg1ji+eicDVSKAiJLWGBofMF2Qru9F8VTC6F
	xa79y64H50EpO4H7Mx/1MQ0hCK10iEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-AQK5usQaND2px50PiZcj6w-1; Mon,
 10 Mar 2025 05:42:55 -0400
X-MC-Unique: AQK5usQaND2px50PiZcj6w-1
X-Mimecast-MFC-AGG-ID: AQK5usQaND2px50PiZcj6w_1741599774
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AE6B1800349;
	Mon, 10 Mar 2025 09:42:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 744151800366;
	Mon, 10 Mar 2025 09:42:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] afs: Simplify cell record handling
Date: Mon, 10 Mar 2025 09:42:04 +0000
Message-ID: <20250310094206.801057-12-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Simplify afs_cell record handling to avoid very occasional races that cause
module removal to hang (it waits for all cell records to be removed).

There are two things that particularly contribute to the difficulty:
firstly, the code tries to pass a ref on the cell to the cell's maintenance
work item (which gets awkward if the work item is already queued); and,
secondly, there's an overall cell manager that tries to use just one timer
for the entire cell collection (to avoid having loads of timers).  However,
both of these are probably unnecessarily restrictive.

To simplify this, the following changes are made:

 (1) The cell record collection manager is removed.  Each cell record
     manages itself individually.

 (2) Each afs_cell is given a second work item (cell->destroyer) that is
     queued when its refcount reaches zero.  This is not done in the
     context of the putting thread as it might be in an inconvenient place
     to sleep.

 (3) Each afs_cell is given its own timer.  The timer is used to expire the
     cell record after a period of unuse if not otherwise pinned and can
     also be used for other maintenance tasks if necessary (of which there
     are currently none as DNS refresh is triggered by filesystem
     operations).

 (4) The afs_cell manager work item (cell->manager) is no longer given a
     ref on the cell when queued; rather, the manager must be deleted.
     This does away with the need to deal with the consequences of losing a
     race to queue cell->manager.  Clean up of extra queuing is deferred to
     the destroyer.

 (5) The cell destroyer work item makes sure the cell timer is removed and
     that the normal cell work is cancelled before farming the actual
     destruction off to RCU.

 (6) When a network namespace is destroyed or the kafs module is unloaded,
     it's now a simple matter of marking the namespace as dead then just
     waking up all the cell work items.  They will then remove and destroy
     themselves once all remaining activity counts and/or a ref counts are
     dropped.  This makes sure that all server records are dropped first.

 (7) The cell record state set is reduced to just four states: SETTING_UP,
     ACTIVE, REMOVING and DEAD.  The record persists in the active state
     even when it's not being used until the time comes to remove it rather
     than downgrading it to an inactive state from whence it can be
     restored.

     This means that the cell still appears in /proc and /afs when not in
     use until it switches to the REMOVING state - at which point it is
     removed.

     Note that the REMOVING state is included so that someone wanting to
     resurrect the cell record is forced to wait whilst the cell is torn
     down in that state.  Once it's in the DEAD state, it has been removed
     from net->cells tree and is no longer findable and can be replaced.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-16-dhowells@redhat.com/ # v1
---
 fs/afs/cell.c              | 404 +++++++++++++++----------------------
 fs/afs/dynroot.c           |   4 +-
 fs/afs/internal.h          |  16 +-
 fs/afs/main.c              |   3 -
 fs/afs/server.c            |   8 +-
 fs/afs/vl_rotate.c         |   2 +-
 include/trace/events/afs.h |  23 +--
 7 files changed, 187 insertions(+), 273 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 694714d296ba..0168bbf53fe0 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -20,8 +20,9 @@ static unsigned __read_mostly afs_cell_min_ttl = 10 * 60;
 static unsigned __read_mostly afs_cell_max_ttl = 24 * 60 * 60;
 static atomic_t cell_debug_id;
 
-static void afs_queue_cell_manager(struct afs_net *);
-static void afs_manage_cell_work(struct work_struct *);
+static void afs_cell_timer(struct timer_list *timer);
+static void afs_destroy_cell_work(struct work_struct *work);
+static void afs_manage_cell_work(struct work_struct *work);
 
 static void afs_dec_cells_outstanding(struct afs_net *net)
 {
@@ -29,19 +30,11 @@ static void afs_dec_cells_outstanding(struct afs_net *net)
 		wake_up_var(&net->cells_outstanding);
 }
 
-/*
- * Set the cell timer to fire after a given delay, assuming it's not already
- * set for an earlier time.
- */
-static void afs_set_cell_timer(struct afs_net *net, time64_t delay)
+static void afs_set_cell_state(struct afs_cell *cell, enum afs_cell_state state)
 {
-	if (net->live) {
-		atomic_inc(&net->cells_outstanding);
-		if (timer_reduce(&net->cells_timer, jiffies + delay * HZ))
-			afs_dec_cells_outstanding(net);
-	} else {
-		afs_queue_cell_manager(net);
-	}
+	smp_store_release(&cell->state, state); /* Commit cell changes before state */
+	smp_wmb(); /* Set cell state before task state */
+	wake_up_var(&cell->state);
 }
 
 /*
@@ -116,7 +109,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 				       const char *name, unsigned int namelen,
 				       const char *addresses)
 {
-	struct afs_vlserver_list *vllist;
+	struct afs_vlserver_list *vllist = NULL;
 	struct afs_cell *cell;
 	int i, ret;
 
@@ -163,7 +156,9 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->net = net;
 	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
+	INIT_WORK(&cell->destroyer, afs_destroy_cell_work);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
+	timer_setup(&cell->management_timer, afs_cell_timer, 0);
 	init_rwsem(&cell->vs_lock);
 	cell->volumes = RB_ROOT;
 	INIT_HLIST_HEAD(&cell->proc_volumes);
@@ -220,6 +215,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	if (ret == -EINVAL)
 		printk(KERN_ERR "kAFS: bad VL server IP address\n");
 error:
+	afs_put_vlserverlist(cell->net, vllist);
 	kfree(cell->name - 1);
 	kfree(cell);
 	_leave(" = %d", ret);
@@ -296,26 +292,28 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 
 	cell = candidate;
 	candidate = NULL;
-	atomic_set(&cell->active, 2);
-	trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 2, afs_cell_trace_insert);
+	afs_use_cell(cell, trace);
 	rb_link_node_rcu(&cell->net_node, parent, pp);
 	rb_insert_color(&cell->net_node, &net->cells);
 	up_write(&net->cells_lock);
 
-	afs_queue_cell(cell, afs_cell_trace_get_queue_new);
+	afs_queue_cell(cell, afs_cell_trace_queue_new);
 
 wait_for_cell:
-	trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), atomic_read(&cell->active),
-		       afs_cell_trace_wait);
 	_debug("wait_for_cell");
-	wait_var_event(&cell->state,
-		       ({
-			       state = smp_load_acquire(&cell->state); /* vs error */
-			       state == AFS_CELL_ACTIVE || state == AFS_CELL_REMOVED;
-		       }));
+	state = smp_load_acquire(&cell->state); /* vs error */
+	if (state != AFS_CELL_ACTIVE &&
+	    state != AFS_CELL_DEAD) {
+		afs_see_cell(cell, afs_cell_trace_wait);
+		wait_var_event(&cell->state,
+			       ({
+				       state = smp_load_acquire(&cell->state); /* vs error */
+				       state == AFS_CELL_ACTIVE || state == AFS_CELL_DEAD;
+			       }));
+	}
 
 	/* Check the state obtained from the wait check. */
-	if (state == AFS_CELL_REMOVED) {
+	if (state == AFS_CELL_DEAD) {
 		ret = cell->error;
 		goto error;
 	}
@@ -397,7 +395,6 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 
 	/* install the new cell */
 	down_write(&net->cells_lock);
-	afs_see_cell(new_root, afs_cell_trace_see_ws);
 	old_root = rcu_replace_pointer(net->ws_cell, new_root,
 				       lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
@@ -530,30 +527,14 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	_leave(" [destroyed]");
 }
 
-/*
- * Queue the cell manager.
- */
-static void afs_queue_cell_manager(struct afs_net *net)
-{
-	int outstanding = atomic_inc_return(&net->cells_outstanding);
-
-	_enter("%d", outstanding);
-
-	if (!queue_work(afs_wq, &net->cells_manager))
-		afs_dec_cells_outstanding(net);
-}
-
-/*
- * Cell management timer.  We have an increment on cells_outstanding that we
- * need to pass along to the work item.
- */
-void afs_cells_timer(struct timer_list *timer)
+static void afs_destroy_cell_work(struct work_struct *work)
 {
-	struct afs_net *net = container_of(timer, struct afs_net, cells_timer);
+	struct afs_cell *cell = container_of(work, struct afs_cell, destroyer);
 
-	_enter("");
-	if (!queue_work(afs_wq, &net->cells_manager))
-		afs_dec_cells_outstanding(net);
+	afs_see_cell(cell, afs_cell_trace_destroy);
+	timer_delete_sync(&cell->management_timer);
+	cancel_work_sync(&cell->manager);
+	call_rcu(&cell->rcu, afs_cell_destroy);
 }
 
 /*
@@ -585,7 +566,7 @@ void afs_put_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 		if (zero) {
 			a = atomic_read(&cell->active);
 			WARN(a != 0, "Cell active count %u > 0\n", a);
-			call_rcu(&cell->rcu, afs_cell_destroy);
+			WARN_ON(!queue_work(afs_wq, &cell->destroyer));
 		}
 	}
 }
@@ -597,10 +578,9 @@ struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
 	int r, a;
 
-	r = refcount_read(&cell->ref);
-	WARN_ON(r == 0);
+	__refcount_inc(&cell->ref, &r);
 	a = atomic_inc_return(&cell->active);
-	trace_afs_cell(cell->debug_id, r, a, reason);
+	trace_afs_cell(cell->debug_id, r + 1, a, reason);
 	return cell;
 }
 
@@ -612,6 +592,7 @@ void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
 	unsigned int debug_id;
 	time64_t now, expire_delay;
+	bool zero;
 	int r, a;
 
 	if (!cell)
@@ -626,13 +607,15 @@ void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 		expire_delay = afs_cell_gc_delay;
 
 	debug_id = cell->debug_id;
-	r = refcount_read(&cell->ref);
 	a = atomic_dec_return(&cell->active);
-	trace_afs_cell(debug_id, r, a, reason);
-	WARN_ON(a == 0);
-	if (a == 1)
+	if (!a)
 		/* 'cell' may now be garbage collected. */
-		afs_set_cell_timer(cell->net, expire_delay);
+		afs_set_cell_timer(cell, expire_delay);
+
+	zero = __refcount_dec_and_test(&cell->ref, &r);
+	trace_afs_cell(debug_id, r - 1, a, reason);
+	if (zero)
+		WARN_ON(!queue_work(afs_wq, &cell->destroyer));
 }
 
 /*
@@ -652,9 +635,27 @@ void afs_see_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  */
 void afs_queue_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	afs_get_cell(cell, reason);
-	if (!queue_work(afs_wq, &cell->manager))
-		afs_put_cell(cell, afs_cell_trace_put_queue_fail);
+	queue_work(afs_wq, &cell->manager);
+}
+
+/*
+ * Cell-specific management timer.
+ */
+static void afs_cell_timer(struct timer_list *timer)
+{
+	struct afs_cell *cell = container_of(timer, struct afs_cell, management_timer);
+
+	afs_see_cell(cell, afs_cell_trace_see_mgmt_timer);
+	if (refcount_read(&cell->ref) > 0 && cell->net->live)
+		queue_work(afs_wq, &cell->manager);
+}
+
+/*
+ * Set/reduce the cell timer.
+ */
+void afs_set_cell_timer(struct afs_cell *cell, unsigned int delay_secs)
+{
+	timer_reduce(&cell->management_timer, jiffies + delay_secs * HZ);
 }
 
 /*
@@ -737,212 +738,125 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	_leave("");
 }
 
+static bool afs_has_cell_expired(struct afs_cell *cell, time64_t *_next_manage)
+{
+	const struct afs_vlserver_list *vllist;
+	time64_t expire_at = cell->last_inactive;
+	time64_t now = ktime_get_real_seconds();
+
+	if (atomic_read(&cell->active))
+		return false;
+	if (!cell->net->live)
+		return true;
+
+	vllist = rcu_dereference_protected(cell->vl_servers, true);
+	if (vllist && vllist->nr_servers > 0)
+		expire_at += afs_cell_gc_delay;
+
+	if (expire_at <= now)
+		return true;
+	if (expire_at < *_next_manage)
+		*_next_manage = expire_at;
+	return false;
+}
+
 /*
  * Manage a cell record, initialising and destroying it, maintaining its DNS
  * records.
  */
-static void afs_manage_cell(struct afs_cell *cell)
+static bool afs_manage_cell(struct afs_cell *cell)
 {
 	struct afs_net *net = cell->net;
-	int ret, active;
+	time64_t next_manage = TIME64_MAX;
+	int ret;
 
 	_enter("%s", cell->name);
 
-again:
 	_debug("state %u", cell->state);
 	switch (cell->state) {
-	case AFS_CELL_INACTIVE:
-	case AFS_CELL_FAILED:
-		down_write(&net->cells_lock);
-		active = 1;
-		if (atomic_try_cmpxchg_relaxed(&cell->active, &active, 0)) {
-			rb_erase(&cell->net_node, &net->cells);
-			trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 0,
-				       afs_cell_trace_unuse_delete);
-			smp_store_release(&cell->state, AFS_CELL_REMOVED);
-		}
-		up_write(&net->cells_lock);
-		if (cell->state == AFS_CELL_REMOVED) {
-			wake_up_var(&cell->state);
-			goto final_destruction;
-		}
-		if (cell->state == AFS_CELL_FAILED)
-			goto done;
-		smp_store_release(&cell->state, AFS_CELL_UNSET);
-		wake_up_var(&cell->state);
-		goto again;
-
-	case AFS_CELL_UNSET:
-		smp_store_release(&cell->state, AFS_CELL_ACTIVATING);
-		wake_up_var(&cell->state);
-		goto again;
-
-	case AFS_CELL_ACTIVATING:
-		ret = afs_activate_cell(net, cell);
-		if (ret < 0)
-			goto activation_failed;
+	case AFS_CELL_SETTING_UP:
+		goto set_up_cell;
+	case AFS_CELL_ACTIVE:
+		goto cell_is_active;
+	case AFS_CELL_REMOVING:
+		WARN_ON_ONCE(1);
+		return false;
+	case AFS_CELL_DEAD:
+		return false;
+	default:
+		_debug("bad state %u", cell->state);
+		WARN_ON_ONCE(1); /* Unhandled state */
+		return false;
+	}
 
-		smp_store_release(&cell->state, AFS_CELL_ACTIVE);
-		wake_up_var(&cell->state);
-		goto again;
+set_up_cell:
+	ret = afs_activate_cell(net, cell);
+	if (ret < 0) {
+		cell->error = ret;
+		goto remove_cell;
+	}
 
-	case AFS_CELL_ACTIVE:
-		if (atomic_read(&cell->active) > 1) {
-			if (test_and_clear_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags)) {
-				ret = afs_update_cell(cell);
-				if (ret < 0)
-					cell->error = ret;
-			}
-			goto done;
-		}
-		smp_store_release(&cell->state, AFS_CELL_DEACTIVATING);
-		wake_up_var(&cell->state);
-		goto again;
+	afs_set_cell_state(cell, AFS_CELL_ACTIVE);
 
-	case AFS_CELL_DEACTIVATING:
-		if (atomic_read(&cell->active) > 1)
-			goto reverse_deactivation;
-		afs_deactivate_cell(net, cell);
-		smp_store_release(&cell->state, AFS_CELL_INACTIVE);
-		wake_up_var(&cell->state);
-		goto again;
+cell_is_active:
+	if (afs_has_cell_expired(cell, &next_manage))
+		goto remove_cell;
 
-	case AFS_CELL_REMOVED:
-		goto done;
+	if (test_and_clear_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags)) {
+		ret = afs_update_cell(cell);
+		if (ret < 0)
+			cell->error = ret;
+	}
 
-	default:
-		break;
+	if (next_manage < TIME64_MAX && cell->net->live) {
+		time64_t now = ktime_get_real_seconds();
+
+		if (next_manage - now <= 0)
+			afs_queue_cell(cell, afs_cell_trace_queue_again);
+		else
+			afs_set_cell_timer(cell, next_manage - now);
 	}
-	_debug("bad state %u", cell->state);
-	BUG(); /* Unhandled state */
+	_leave(" [done %u]", cell->state);
+	return false;
 
-activation_failed:
-	cell->error = ret;
-	afs_deactivate_cell(net, cell);
+remove_cell:
+	down_write(&net->cells_lock);
 
-	smp_store_release(&cell->state, AFS_CELL_FAILED); /* vs error */
-	wake_up_var(&cell->state);
-	goto again;
+	if (atomic_read(&cell->active)) {
+		up_write(&net->cells_lock);
+		goto cell_is_active;
+	}
 
-reverse_deactivation:
-	smp_store_release(&cell->state, AFS_CELL_ACTIVE);
-	wake_up_var(&cell->state);
-	_leave(" [deact->act]");
-	return;
+	/* Make sure that the expiring server records are going to see the fact
+	 * that the cell is caput.
+	 */
+	afs_set_cell_state(cell, AFS_CELL_REMOVING);
 
-done:
-	_leave(" [done %u]", cell->state);
-	return;
+	afs_deactivate_cell(net, cell);
+	afs_purge_servers(cell);
+
+	rb_erase(&cell->net_node, &net->cells);
+	afs_see_cell(cell, afs_cell_trace_unuse_delete);
+	up_write(&net->cells_lock);
 
-final_destruction:
 	/* The root volume is pinning the cell */
 	afs_put_volume(cell->root_volume, afs_volume_trace_put_cell_root);
 	cell->root_volume = NULL;
-	afs_purge_servers(cell);
-	afs_put_cell(cell, afs_cell_trace_put_destroy);
+
+	afs_set_cell_state(cell, AFS_CELL_DEAD);
+	return true;
 }
 
 static void afs_manage_cell_work(struct work_struct *work)
 {
 	struct afs_cell *cell = container_of(work, struct afs_cell, manager);
+	bool final_put;
 
-	afs_manage_cell(cell);
-	afs_put_cell(cell, afs_cell_trace_put_queue_work);
-}
-
-/*
- * Manage the records of cells known to a network namespace.  This includes
- * updating the DNS records and garbage collecting unused cells that were
- * automatically added.
- *
- * Note that constructed cell records may only be removed from net->cells by
- * this work item, so it is safe for this work item to stash a cursor pointing
- * into the tree and then return to caller (provided it skips cells that are
- * still under construction).
- *
- * Note also that we were given an increment on net->cells_outstanding by
- * whoever queued us that we need to deal with before returning.
- */
-void afs_manage_cells(struct work_struct *work)
-{
-	struct afs_net *net = container_of(work, struct afs_net, cells_manager);
-	struct rb_node *cursor;
-	time64_t now = ktime_get_real_seconds(), next_manage = TIME64_MAX;
-	bool purging = !net->live;
-
-	_enter("");
-
-	/* Trawl the cell database looking for cells that have expired from
-	 * lack of use and cells whose DNS results have expired and dispatch
-	 * their managers.
-	 */
-	down_read(&net->cells_lock);
-
-	for (cursor = rb_first(&net->cells); cursor; cursor = rb_next(cursor)) {
-		struct afs_cell *cell =
-			rb_entry(cursor, struct afs_cell, net_node);
-		unsigned active;
-		bool sched_cell = false;
-
-		active = atomic_read(&cell->active);
-		trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
-			       active, afs_cell_trace_manage);
-
-		ASSERTCMP(active, >=, 1);
-
-		if (purging) {
-			if (test_and_clear_bit(AFS_CELL_FL_NO_GC, &cell->flags)) {
-				active = atomic_dec_return(&cell->active);
-				trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
-					       active, afs_cell_trace_unuse_pin);
-			}
-		}
-
-		if (active == 1) {
-			struct afs_vlserver_list *vllist;
-			time64_t expire_at = cell->last_inactive;
-
-			read_lock(&cell->vl_servers_lock);
-			vllist = rcu_dereference_protected(
-				cell->vl_servers,
-				lockdep_is_held(&cell->vl_servers_lock));
-			if (vllist->nr_servers > 0)
-				expire_at += afs_cell_gc_delay;
-			read_unlock(&cell->vl_servers_lock);
-			if (purging || expire_at <= now)
-				sched_cell = true;
-			else if (expire_at < next_manage)
-				next_manage = expire_at;
-		}
-
-		if (!purging) {
-			if (test_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags))
-				sched_cell = true;
-		}
-
-		if (sched_cell)
-			afs_queue_cell(cell, afs_cell_trace_get_queue_manage);
-	}
-
-	up_read(&net->cells_lock);
-
-	/* Update the timer on the way out.  We have to pass an increment on
-	 * cells_outstanding in the namespace that we are in to the timer or
-	 * the work scheduler.
-	 */
-	if (!purging && next_manage < TIME64_MAX) {
-		now = ktime_get_real_seconds();
-
-		if (next_manage - now <= 0) {
-			if (queue_work(afs_wq, &net->cells_manager))
-				atomic_inc(&net->cells_outstanding);
-		} else {
-			afs_set_cell_timer(net, next_manage - now);
-		}
-	}
-
-	afs_dec_cells_outstanding(net);
-	_leave(" [%d]", atomic_read(&net->cells_outstanding));
+	afs_see_cell(cell, afs_cell_trace_manage);
+	final_put = afs_manage_cell(cell);
+	afs_see_cell(cell, afs_cell_trace_managed);
+	if (final_put)
+		afs_put_cell(cell, afs_cell_trace_put_final);
 }
 
 /*
@@ -951,6 +865,7 @@ void afs_manage_cells(struct work_struct *work)
 void afs_cell_purge(struct afs_net *net)
 {
 	struct afs_cell *ws;
+	struct rb_node *cursor;
 
 	_enter("");
 
@@ -960,12 +875,19 @@ void afs_cell_purge(struct afs_net *net)
 	up_write(&net->cells_lock);
 	afs_unuse_cell(ws, afs_cell_trace_unuse_ws);
 
-	_debug("del timer");
-	if (del_timer_sync(&net->cells_timer))
-		atomic_dec(&net->cells_outstanding);
+	_debug("kick cells");
+	down_read(&net->cells_lock);
+	for (cursor = rb_first(&net->cells); cursor; cursor = rb_next(cursor)) {
+		struct afs_cell *cell = rb_entry(cursor, struct afs_cell, net_node);
+
+		afs_see_cell(cell, afs_cell_trace_purge);
 
-	_debug("kick mgr");
-	afs_queue_cell_manager(net);
+		if (test_and_clear_bit(AFS_CELL_FL_NO_GC, &cell->flags))
+			afs_unuse_cell(cell, afs_cell_trace_unuse_pin);
+
+		afs_queue_cell(cell, afs_cell_trace_queue_purge);
+	}
+	up_read(&net->cells_lock);
 
 	_debug("wait");
 	wait_var_event(&net->cells_outstanding,
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 011c63350df1..9732a1e17db3 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -293,8 +293,8 @@ static int afs_dynroot_readdir_cells(struct afs_net *net, struct dir_context *ct
 		cell = idr_get_next(&net->cells_dyn_ino, &ix);
 		if (!cell)
 			return 0;
-		if (READ_ONCE(cell->state) == AFS_CELL_FAILED ||
-		    READ_ONCE(cell->state) == AFS_CELL_REMOVED) {
+		if (READ_ONCE(cell->state) == AFS_CELL_REMOVING ||
+		    READ_ONCE(cell->state) == AFS_CELL_DEAD) {
 			ctx->pos += 2;
 			ctx->pos &= ~1;
 			continue;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1e0ab5e7fc88..440b0e731093 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -289,8 +289,6 @@ struct afs_net {
 	struct rb_root		cells;
 	struct idr		cells_dyn_ino;	/* cell->dynroot_ino mapping */
 	struct afs_cell __rcu	*ws_cell;
-	struct work_struct	cells_manager;
-	struct timer_list	cells_timer;
 	atomic_t		cells_outstanding;
 	struct rw_semaphore	cells_lock;
 	struct mutex		cells_alias_lock;
@@ -339,13 +337,10 @@ struct afs_net {
 extern const char afs_init_sysname[];
 
 enum afs_cell_state {
-	AFS_CELL_UNSET,
-	AFS_CELL_ACTIVATING,
+	AFS_CELL_SETTING_UP,
 	AFS_CELL_ACTIVE,
-	AFS_CELL_DEACTIVATING,
-	AFS_CELL_INACTIVE,
-	AFS_CELL_FAILED,
-	AFS_CELL_REMOVED,
+	AFS_CELL_REMOVING,
+	AFS_CELL_DEAD,
 };
 
 /*
@@ -376,7 +371,9 @@ struct afs_cell {
 	struct afs_cell		*alias_of;	/* The cell this is an alias of */
 	struct afs_volume	*root_volume;	/* The root.cell volume if there is one */
 	struct key		*anonymous_key;	/* anonymous user key for this cell */
+	struct work_struct	destroyer;	/* Destroyer for cell */
 	struct work_struct	manager;	/* Manager for init/deinit/dns */
+	struct timer_list	management_timer; /* General management timer */
 	struct hlist_node	proc_link;	/* /proc cell list link */
 	time64_t		dns_expiry;	/* Time AFSDB/SRV record expires */
 	time64_t		last_inactive;	/* Time of last drop of usage count */
@@ -1053,8 +1050,7 @@ extern struct afs_cell *afs_get_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_see_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_put_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_queue_cell(struct afs_cell *, enum afs_cell_trace);
-extern void afs_manage_cells(struct work_struct *);
-extern void afs_cells_timer(struct timer_list *);
+void afs_set_cell_timer(struct afs_cell *cell, unsigned int delay_secs);
 extern void __net_exit afs_cell_purge(struct afs_net *);
 
 /*
diff --git a/fs/afs/main.c b/fs/afs/main.c
index bff0363286b0..c845c5daaeba 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -78,9 +78,6 @@ static int __net_init afs_net_init(struct net *net_ns)
 	net->cells = RB_ROOT;
 	idr_init(&net->cells_dyn_ino);
 	init_rwsem(&net->cells_lock);
-	INIT_WORK(&net->cells_manager, afs_manage_cells);
-	timer_setup(&net->cells_timer, afs_cells_timer, 0);
-
 	mutex_init(&net->cells_alias_lock);
 	mutex_init(&net->proc_cells_lock);
 	INIT_HLIST_HEAD(&net->proc_cells);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 487e2134aea4..c530d1ca15df 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -103,7 +103,7 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	afs_get_cell(cell, afs_cell_trace_get_server);
 
 exists:
-	afs_use_server(server, true, afs_server_trace_get_install);
+	afs_use_server(server, true, afs_server_trace_use_install);
 	return server;
 }
 
@@ -356,7 +356,7 @@ void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
 
 	if (atomic_dec_and_test(&server->active)) {
 		if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) ||
-		    READ_ONCE(server->cell->state) >= AFS_CELL_FAILED)
+		    READ_ONCE(server->cell->state) >= AFS_CELL_REMOVING)
 			schedule_work(&server->destroyer);
 	}
 
@@ -374,7 +374,7 @@ void afs_unuse_server(struct afs_net *net, struct afs_server *server,
 
 	if (atomic_dec_and_test(&server->active)) {
 		if (!test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) &&
-		    READ_ONCE(server->cell->state) < AFS_CELL_FAILED) {
+		    READ_ONCE(server->cell->state) < AFS_CELL_REMOVING) {
 			time64_t unuse_time = ktime_get_real_seconds();
 
 			server->unuse_time = unuse_time;
@@ -424,7 +424,7 @@ static bool afs_has_server_expired(const struct afs_server *server)
 		return false;
 
 	if (server->cell->net->live ||
-	    server->cell->state >= AFS_CELL_FAILED) {
+	    server->cell->state >= AFS_CELL_REMOVING) {
 		trace_afs_server(server->debug_id, refcount_read(&server->ref),
 				 0, afs_server_trace_purging);
 		return true;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index d8f79f6ada3d..6ad9688d8f4b 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -48,7 +48,7 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 	    cell->dns_expiry <= ktime_get_real_seconds()) {
 		dns_lookup_count = smp_load_acquire(&cell->dns_lookup_count);
 		set_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags);
-		afs_queue_cell(cell, afs_cell_trace_get_queue_dns);
+		afs_queue_cell(cell, afs_cell_trace_queue_dns);
 
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			if (wait_var_event_interruptible(
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 02f8b2a6977c..8857f5ea77d4 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -131,7 +131,6 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_destroy,		"DESTROY  ") \
 	EM(afs_server_trace_free,		"FREE     ") \
 	EM(afs_server_trace_gc,			"GC       ") \
-	EM(afs_server_trace_get_install,	"GET inst ") \
 	EM(afs_server_trace_get_probe,		"GET probe") \
 	EM(afs_server_trace_purging,		"PURGE    ") \
 	EM(afs_server_trace_put_cbi,		"PUT cbi  ") \
@@ -149,6 +148,7 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
 	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
 	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
+	EM(afs_server_trace_use_install,	"USE inst ") \
 	E_(afs_server_trace_wait_create,	"WAIT crt ")
 
 #define afs_volume_traces \
@@ -171,37 +171,36 @@ enum yfs_cm_operation {
 
 #define afs_cell_traces \
 	EM(afs_cell_trace_alloc,		"ALLOC     ") \
+	EM(afs_cell_trace_destroy,		"DESTROY   ") \
 	EM(afs_cell_trace_free,			"FREE      ") \
 	EM(afs_cell_trace_get_atcell,		"GET atcell") \
-	EM(afs_cell_trace_get_queue_dns,	"GET q-dns ") \
-	EM(afs_cell_trace_get_queue_manage,	"GET q-mng ") \
-	EM(afs_cell_trace_get_queue_new,	"GET q-new ") \
 	EM(afs_cell_trace_get_server,		"GET server") \
 	EM(afs_cell_trace_get_vol,		"GET vol   ") \
-	EM(afs_cell_trace_insert,		"INSERT    ") \
-	EM(afs_cell_trace_manage,		"MANAGE    ") \
+	EM(afs_cell_trace_purge,		"PURGE     ") \
 	EM(afs_cell_trace_put_atcell,		"PUT atcell") \
 	EM(afs_cell_trace_put_candidate,	"PUT candid") \
-	EM(afs_cell_trace_put_destroy,		"PUT destry") \
-	EM(afs_cell_trace_put_queue_work,	"PUT q-work") \
-	EM(afs_cell_trace_put_queue_fail,	"PUT q-fail") \
+	EM(afs_cell_trace_put_final,		"PUT final ") \
 	EM(afs_cell_trace_put_server,		"PUT server") \
 	EM(afs_cell_trace_put_vol,		"PUT vol   ") \
+	EM(afs_cell_trace_queue_again,		"QUE again ") \
+	EM(afs_cell_trace_queue_dns,		"QUE dns   ") \
+	EM(afs_cell_trace_queue_new,		"QUE new   ") \
+	EM(afs_cell_trace_queue_purge,		"QUE purge ") \
+	EM(afs_cell_trace_manage,		"MANAGE    ") \
+	EM(afs_cell_trace_managed,		"MANAGED   ") \
 	EM(afs_cell_trace_see_source,		"SEE source") \
-	EM(afs_cell_trace_see_ws,		"SEE ws    ") \
+	EM(afs_cell_trace_see_mgmt_timer,	"SEE mtimer") \
 	EM(afs_cell_trace_unuse_alias,		"UNU alias ") \
 	EM(afs_cell_trace_unuse_check_alias,	"UNU chk-al") \
 	EM(afs_cell_trace_unuse_delete,		"UNU delete") \
 	EM(afs_cell_trace_unuse_dynroot_mntpt,	"UNU dyn-mp") \
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
-	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
 	EM(afs_cell_trace_unuse_lookup_dynroot,	"UNU lu-dyn") \
 	EM(afs_cell_trace_unuse_lookup_error,	"UNU lu-err") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
 	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \
 	EM(afs_cell_trace_unuse_pin,		"UNU pin   ") \
-	EM(afs_cell_trace_unuse_probe,		"UNU probe ") \
 	EM(afs_cell_trace_unuse_sbi,		"UNU sbi   ") \
 	EM(afs_cell_trace_unuse_ws,		"UNU ws    ") \
 	EM(afs_cell_trace_use_alias,		"USE alias ") \


