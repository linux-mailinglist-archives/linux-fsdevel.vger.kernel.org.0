Return-Path: <linux-fsdevel+bounces-26906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A795CCC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6411C223E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BA185E4E;
	Fri, 23 Aug 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7tYfyAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14B185936
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417286; cv=none; b=j90uzyUVJzeu2dHiHaU9j1joYtjjeP/w9Y6SgK3kXY8SR+U3do+4gaozY341mzW3cpcuXOmWVKkEWrTp47pY/jw8vtB9NLoG9T4QLA1+EF3mtOe2mjDBtRjASoKKRyQN9Lhv16nKF+TrCwQYsuDzRagRCq8CkarRQjejnxmyDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417286; c=relaxed/simple;
	bh=ZEdA1ZQhKBTXbibEMJ+tSrOron1bsRXVotsJkEwdcxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZKBQPpmghf8Oi0oo+DBt5U6VNfi1hx5pyZB+FPOIXpYB8uDxssyo61kos702v7KxGuuAQhfALaMZrLbaPrsOYEHtBSKOFcDG+7DLb83LjawzZWFgUQjogScObgiUd77IC/s0nOLNl12kbJ2V1ZFzQuMqoMjsjccT57emX5ob6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7tYfyAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3C4C4AF0B;
	Fri, 23 Aug 2024 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417286;
	bh=ZEdA1ZQhKBTXbibEMJ+tSrOron1bsRXVotsJkEwdcxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7tYfyAzuBnF/r7EkQS4BiCTurgU8eHm5+TrX9CF6C759UpHMDOEAszamaatzOTMz
	 SeIdmZvo+GJBmVOEvTHqGiFobo7J87+rMkC/5cMswdSBc/hz0HFNVpFUIyKJ83uR5x
	 JrKEwE9tPGUEcJsLgi7BQ7mvti5DSPsq9gHCC5mHhc0JdcODD9QTUoDdzuEraMS5Kl
	 bkLOTS3nLjuJILI+VpVUd/EkinpHzd42ABo5g6zHx/ZrHqoa7u9FoVSTRa2A/n3yZy
	 D4oI9Sc191rrsD9w29a32ZJ/jB7dnkIzrirRUJkOhW3ijiBMS4p31zU4leAiPvQKzC
	 wxKjl/+UmHzOg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/6] inode: port __I_NEW to var event
Date: Fri, 23 Aug 2024 14:47:38 +0200
Message-ID: <20240823-work-i_state-v3-4-5cd5fd207a57@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=5569; i=brauner@kernel.org; h=from:subject:message-id; bh=ZEdA1ZQhKBTXbibEMJ+tSrOron1bsRXVotsJkEwdcxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHl7nSltmlzL4h9mvQ+1nTpq/3S2Lt+zLW3jGsZgt ej2M2IPOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai6M7wP/Cjo92cDQ/mnN61 b/vGHZ7BXsynhAqK9Vnd9z27t1vGrIeR4UN1zTeG55+MFeILWeqt38RaPEpuqp1Tc35zuMvMZWa Z7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Port the __I_NEW mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
I'm not fully convinced that READ_ONCE() in wait_on_inode() is
sufficient when combined with smp_mb() before wake_up_var(). Maybe we
need smp_store_release() on inode->i_state before smp_mb() and paired
with smp_load_acquire() in wait_on_inode().
---
 fs/bcachefs/fs.c          | 10 ++++++----
 fs/dcache.c               |  7 ++++++-
 fs/inode.c                | 32 ++++++++++++++++++++++++--------
 include/linux/writeback.h |  3 ++-
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 94c392abef65..c0900c0c0f8a 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1644,14 +1644,16 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 				break;
 			}
 		} else if (clean_pass && this_pass_clean) {
-			wait_queue_head_t *wq = bit_waitqueue(&inode->v.i_state, __I_NEW);
-			DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
+			struct wait_bit_queue_entry wqe;
+			struct wait_queue_head *wq_head;
 
-			prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+			wq_head = inode_bit_waitqueue(&wqe, &inode->v, __I_NEW);
+			prepare_to_wait_event(wq_head, &wqe.wq_entry,
+					      TASK_UNINTERRUPTIBLE);
 			mutex_unlock(&c->vfs_inodes_lock);
 
 			schedule();
-			finish_wait(wq, &wait.wq_entry);
+			finish_wait(wq_head, &wqe.wq_entry);
 			goto again;
 		}
 	}
diff --git a/fs/dcache.c b/fs/dcache.c
index 1af75fa68638..894e38cdf4d0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1908,8 +1908,13 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
+	/*
+	 * Pairs with the barrier in prepare_to_wait_event() to make sure
+	 * ___wait_var_event() either sees the bit cleared or
+	 * waitqueue_active() check in wake_up_var() sees the waiter.
+	 */
 	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(d_instantiate_new);
diff --git a/fs/inode.c b/fs/inode.c
index 877c64a1bf63..37f20c7c2f72 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -734,7 +734,13 @@ static void evict(struct inode *inode)
 	 * used as an indicator whether blocking on it is safe.
 	 */
 	spin_lock(&inode->i_lock);
-	wake_up_bit(&inode->i_state, __I_NEW);
+	/*
+	 * Pairs with the barrier in prepare_to_wait_event() to make sure
+	 * ___wait_var_event() either sees the bit cleared or
+	 * waitqueue_active() check in wake_up_var() sees the waiter.
+	 */
+	smp_mb();
+	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 	spin_unlock(&inode->i_lock);
 
@@ -1142,8 +1148,13 @@ void unlock_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
+	/*
+	 * Pairs with the barrier in prepare_to_wait_event() to make sure
+	 * ___wait_var_event() either sees the bit cleared or
+	 * waitqueue_active() check in wake_up_var() sees the waiter.
+	 */
 	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(unlock_new_inode);
@@ -1154,8 +1165,13 @@ void discard_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW;
+	/*
+	 * Pairs with the barrier in prepare_to_wait_event() to make sure
+	 * ___wait_var_event() either sees the bit cleared or
+	 * waitqueue_active() check in wake_up_var() sees the waiter.
+	 */
 	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 	iput(inode);
 }
@@ -2344,8 +2360,8 @@ EXPORT_SYMBOL(inode_needs_sync);
  */
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
 {
-	wait_queue_head_t *wq;
-	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
 
 	/*
 	 * Handle racing against evict(), see that routine for more details.
@@ -2356,14 +2372,14 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
 		return;
 	}
 
-	wq = bit_waitqueue(&inode->i_state, __I_NEW);
-	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
+	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
 	rcu_read_unlock();
 	if (is_inode_hash_locked)
 		spin_unlock(&inode_hash_lock);
 	schedule();
-	finish_wait(wq, &wait.wq_entry);
+	finish_wait(wq_head, &wqe.wq_entry);
 	if (is_inode_hash_locked)
 		spin_lock(&inode_hash_lock);
 	rcu_read_lock();
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 56b85841ae4c..8f651bb0a1a5 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -200,7 +200,8 @@ void inode_io_list_del(struct inode *inode);
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
 {
-	wait_on_bit(&inode->i_state, __I_NEW, TASK_UNINTERRUPTIBLE);
+	wait_var_event(inode_state_wait_address(inode, __I_NEW),
+		       !(READ_ONCE(inode->i_state) & I_NEW));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK

-- 
2.43.0


