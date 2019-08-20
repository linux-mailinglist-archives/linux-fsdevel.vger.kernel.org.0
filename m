Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30EF96720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfHTRIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 13:08:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfHTRIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:08:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i07cI-0003YW-Vo; Tue, 20 Aug 2019 19:08:19 +0200
Date:   Tue, 20 Aug 2019 19:08:18 +0200
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: [PATCH] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular
 spinlock_t
Message-ID: <20190820170818.oldsdoumzashhcgh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
disable preemption, which is undesired for latency reasons and breaks when
regular spinlocks are taken within the bit_spinlock locked region because
regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
replaces the bit spinlocks with regular spinlocks to avoid this problem.
Bit spinlocks are also not covered by lock debugging, e.g. lockdep.

Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: remove the wrapper and use always spinlock_t]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/buffer.c                 | 19 +++++++------------
 fs/ext4/page-io.c           |  8 +++-----
 fs/ntfs/aops.c              |  9 +++------
 include/linux/buffer_head.h |  6 +++---
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 131d39ec7d316..eab37fbaa439f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -275,8 +275,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	 * decide that the page is now completely done.
 	 */
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -289,8 +288,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -302,8 +300,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 	return;
 }
 
@@ -331,8 +328,7 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	}
 
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->uptodate_lock, flags);
 
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
@@ -344,14 +340,12 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	}
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 	return;
 }
 EXPORT_SYMBOL(end_buffer_async_write);
@@ -3420,6 +3414,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
 	struct buffer_head *ret = kmem_cache_zalloc(bh_cachep, gfp_flags);
 	if (ret) {
 		INIT_LIST_HEAD(&ret->b_assoc_buffers);
+		spin_lock_init(&ret->uptodate_lock);
 		preempt_disable();
 		__this_cpu_inc(bh_accounting.nr);
 		recalc_bh_state();
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 12ceadef32c5a..7745ed23c6ad9 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -87,11 +87,10 @@ static void ext4_finish_bio(struct bio *bio)
 		}
 		bh = head = page_buffers(page);
 		/*
-		 * We check all buffers in the page under BH_Uptodate_Lock
+		 * We check all buffers in the page under uptodate_lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		spin_lock_irqsave(&head->uptodate_lock, flags);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -103,8 +102,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_status)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&head->uptodate_lock, flags);
 		if (!under_io) {
 			fscrypt_free_bounce_page(bounce_page);
 			end_page_writeback(page);
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 7202a1e39d70c..14ca433b3a9e4 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -92,8 +92,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 				"0x%llx.", (unsigned long long)bh->b_blocknr);
 	}
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -108,8 +107,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
@@ -142,8 +140,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	unlock_page(page);
 	return;
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->uptodate_lock, flags);
 	return;
 }
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7f902d4..c8f2a3076ce00 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -22,9 +22,6 @@ enum bh_state_bits {
 	BH_Dirty,	/* Is dirty */
 	BH_Lock,	/* Is locked */
 	BH_Req,		/* Has been submitted for I/O */
-	BH_Uptodate_Lock,/* Used by the first bh in a page, to serialise
-			  * IO completion of other buffers in the page
-			  */
 
 	BH_Mapped,	/* Has a disk mapping */
 	BH_New,		/* Disk mapping was newly created by get_block */
@@ -62,6 +59,9 @@ typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
  */
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
+	spinlock_t	uptodate_lock;	/* Used by the first bh in a page, to
+					 * serialise IO completion of other
+					 * buffers in the page */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
 	struct page *b_page;		/* the page this bh is mapped to */
 
-- 
2.23.0.rc1

