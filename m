Return-Path: <linux-fsdevel+bounces-26489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE195A20B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD61F210BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432851BAECA;
	Wed, 21 Aug 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU0BKMlz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A281727
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255281; cv=none; b=cas5QhqCOO6+Lr0NgezXwdrwUSCbBy89AF7KhQLcSabAKDvlKN8JlunF86mkn1hr+9bmvka+uMMZjeSZYGtyMYg0CgUXDPHSm9kEDdgDdvgerIwpt9SX6HCQ971zFUikluHachAmDhgx71LGVG0njz2vOHpunhk368UkhWhv+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255281; c=relaxed/simple;
	bh=zaVb2d/NmW+GsWauUDjGcih6jIFjTkVW71FFkM9B/Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQfdYCFFYs7XS3od2Dh6ApU7AWgVjHkn6u1aoLg+ucKb1mMqD9Fc5ljzu1ORDy/qplbXXC93kZBozjoIU5+/lCH0VkjjpEBHE08Km2gBd15SQGDe/jDEgFqGc8Bxy5IApPE4GafE8OYFVmT4pb0oIPDQqFfPw3xy6g0eVTtKnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU0BKMlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8F0C32781;
	Wed, 21 Aug 2024 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255281;
	bh=zaVb2d/NmW+GsWauUDjGcih6jIFjTkVW71FFkM9B/Tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HU0BKMlzBfhLDy5Hupr7Rt7NYBfjQUi5z7OJ30R4PEUPHR6JQzbw2I7Q2WKVpi2eI
	 OGIU8WWgXEMVkGPbK5CPQy15RzUcFM8CAapjucffZMSk7fUuwOJbZV52PdjZvTSLVo
	 McwisU7lLSZN1nS4rvHMgGTFt7D7Ga5vmXx0tA0msxzC/RZYBC/KgZxZZoZKI51rsn
	 72Gz6GNL4Bf8u7v+3jaVXU/rvKYltPqdUbZRbMz2r+a7BzslCy0o8HtEyoI29hOj/P
	 NSL9dTywEKFhc0X56UTM0/5MmGKpJkOFHpqhmwJfiZpuXwhdUa0YPeYVdDcdniacPR
	 uAg6ExWefjS3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:34 +0200
Subject: [PATCH RFC v2 4/6] inode: port __I_NEW to var event
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-4-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zaVb2d/NmW+GsWauUDjGcih6jIFjTkVW71FFkM9B/Tg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41GdYH2J79f+rzNm3nf6nMop8OZ1x6s5E0tl//osK
 D4hOTNCsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKZkMv1lXiE63aTXffO1x
 jKzcv/z3eREy9yxjL5zXe7Ha/oebwA2G/9WrLm8MZOaV8849ZOz6ZtNcywUZ/T2LPWOdY51OpV3
 k4gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port the __I_NEW mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bcachefs/fs.c          | 10 ++++++----
 fs/dcache.c               |  3 +--
 fs/inode.c                | 18 ++++++++----------
 include/linux/writeback.h |  3 ++-
 4 files changed, 17 insertions(+), 17 deletions(-)

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
index 1af75fa68638..7037f9312ed4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1908,8 +1908,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(d_instantiate_new);
diff --git a/fs/inode.c b/fs/inode.c
index f2a2f6351ec3..d18e1567c487 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -733,7 +733,7 @@ static void evict(struct inode *inode)
 	 * used as an indicator whether blocking on it is safe.
 	 */
 	spin_lock(&inode->i_lock);
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 	spin_unlock(&inode->i_lock);
 
@@ -1141,8 +1141,7 @@ void unlock_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(unlock_new_inode);
@@ -1153,8 +1152,7 @@ void discard_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 	iput(inode);
 }
@@ -2343,8 +2341,8 @@ EXPORT_SYMBOL(inode_needs_sync);
  */
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
 {
-	wait_queue_head_t *wq;
-	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
 
 	/*
 	 * Handle racing against evict(), see that routine for more details.
@@ -2355,14 +2353,14 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
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
index 56b85841ae4c..bed795b8340b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -200,7 +200,8 @@ void inode_io_list_del(struct inode *inode);
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
 {
-	wait_on_bit(&inode->i_state, __I_NEW, TASK_UNINTERRUPTIBLE);
+	wait_var_event(inode_state_wait_address(inode, __I_NEW),
+		       !(inode->i_state & I_NEW));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK

-- 
2.43.0


