Return-Path: <linux-fsdevel+bounces-26376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A880958BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37A7283ED1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312341B8E9E;
	Tue, 20 Aug 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDPtKdSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A70192B83
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170052; cv=none; b=muRDkmI6+uWYmq+/6gde2OnGtdhF43tqTB6gZ44kg/Fqm8y+XozD7FIEMWuQ1/aR/nn/kSPKsle0jJCIBSMS2xmJNGZyqikMAirPNtzjXaoO7AJiC6NNHvuxctd1w5+MCX7YyBBHkold+LmfiTapDfxYhSchsZY8NPOctiLtE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170052; c=relaxed/simple;
	bh=eguI6DtuiOl8/KnPYK2EPLl82uVmWoDPvYHtdJIgj2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwHFOJISDRkI2AOus240ETLOi8ekTbsZZ3xD0EDYiBAe6ZpUWsr1WK+oUqG902LDbfb45giwNmWp5HkOJGsTqYEEpt06Y2ihkkH25SHcTyNV7a2XhMbB6N8JBCOmfdNmVGsH58tx12vC65oTYiREYo7kM5GQaEFlXZghTF2MB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDPtKdSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF4BC4AF11;
	Tue, 20 Aug 2024 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170051;
	bh=eguI6DtuiOl8/KnPYK2EPLl82uVmWoDPvYHtdJIgj2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDPtKdSITkfegjz4j3TxlB59xWKjgqHkoDparhjI8RYGNDUZfPy8hGuiCCewjk9sq
	 NYcylWZ/I5sj7wQpuIz3c1HHJlcsuWIrWfggbdnJSOSv7brgiOrL8bouQOsCS5zYCj
	 RBH3U28NY36wtaPn7M9NTvs41iATWIwmLP/W9lAWLLmGrfT1ImSF/6wSYrc/GYqT+9
	 UDcGlNhg4xv8bWgRf94IRMfZkyXDv5iybRK9A7/SeMbvJus99ll+OcoADC9F9YkYpx
	 n8XJi+BPHrmLgKiJUTgIMU7UQsyT+AHf0dwlgDnTQaZbhWKjKr02/JQUg99IJZU47Z
	 t8+8D9xbi3sCA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 3/5] inode: port __I_NEW to var event
Date: Tue, 20 Aug 2024 18:06:56 +0200
Message-ID: <20240820-work-i_state-v1-3-794360714829@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820-work-i_state-v1-0-794360714829@kernel.org>
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; i=brauner@kernel.org; h=from:subject:message-id; bh=eguI6DtuiOl8/KnPYK2EPLl82uVmWoDPvYHtdJIgj2M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2a/YmKQz6+YW+wb13tN6z8Ql9VcffLLHh+ef0tH5c vkvnSff7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrwCGvxIsxskNzUpvdBeV TxVYvvTU299CJ04yxzEfZevf6PVm9SNGhjsZLOf7eLZGCsyY4rD08az1XMc6DRnv+9oyzkycs1h WjRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Port the __I_NEW mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bcachefs/fs.c          | 10 ++++++----
 fs/dcache.c               |  3 +--
 fs/inode.c                | 18 ++++++++----------
 include/linux/writeback.h |  3 ++-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 94c392abef65..8575aedb9fde 100644
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
+			wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
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
index d0f614677798..d9e119b5eeef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -734,7 +734,7 @@ static void evict(struct inode *inode)
 	 * used as an indicator whether blocking on it is safe.
 	 */
 	spin_lock(&inode->i_lock);
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 	spin_unlock(&inode->i_lock);
 
@@ -1142,8 +1142,7 @@ void unlock_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(unlock_new_inode);
@@ -1154,8 +1153,7 @@ void discard_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 	iput(inode);
 }
@@ -2344,8 +2342,8 @@ EXPORT_SYMBOL(inode_needs_sync);
  */
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
 {
-	wait_queue_head_t *wq;
-	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
 
 	/*
 	 * Handle racing against evict(), see that routine for more details.
@@ -2356,14 +2354,14 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
 		return;
 	}
 
-	wq = bit_waitqueue(&inode->i_state, __I_NEW);
-	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
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


