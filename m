Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5097D2A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfHABQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfHABQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:16:38 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszhG-0002I7-RD; Thu, 01 Aug 2019 03:15:58 +0200
Message-Id: <20190801010944.065808812@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 03:01:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        "Theodore Tso" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: [patch V2 2/7] fs/buffer: Move BH_Uptodate_Lock locking into wrapper
 functions
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
disable preemption, which is undesired for latency reasons and breaks when
regular spinlocks are taken within the bit_spinlock locked region because
regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
replaces the bit spinlocks with regular spinlocks to avoid this problem.

To avoid ifdeffery at the source level, wrap all BH_Uptodate_Lock bitlock
operations with inline functions, so the spinlock substitution can be done
at one place.

Using regular spinlocks can also be enabled for lock debugging purposes so
the lock operations become visible to lockdep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
V2: Collected Reviewed-by tag
---
 fs/buffer.c                 |   20 ++++++--------------
 fs/ext4/page-io.c           |    6 ++----
 fs/ntfs/aops.c              |   10 +++-------
 include/linux/buffer_head.h |   16 ++++++++++++++++
 4 files changed, 27 insertions(+), 25 deletions(-)

--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -275,8 +275,7 @@ static void end_buffer_async_read(struct
 	 * decide that the page is now completely done.
 	 */
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	flags = bh_uptodate_lock_irqsave(first);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -289,8 +288,7 @@ static void end_buffer_async_read(struct
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(first, flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -302,9 +300,7 @@ static void end_buffer_async_read(struct
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
-	return;
+	bh_uptodate_unlock_irqrestore(first, flags);
 }
 
 /*
@@ -331,8 +327,7 @@ void end_buffer_async_write(struct buffe
 	}
 
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	flags = bh_uptodate_lock_irqsave(first);
 
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
@@ -344,15 +339,12 @@ void end_buffer_async_write(struct buffe
 		}
 		tmp = tmp->b_this_page;
 	}
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(first, flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
-	return;
+	bh_uptodate_unlock_irqrestore(first, flags);
 }
 EXPORT_SYMBOL(end_buffer_async_write);
 
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -90,8 +90,7 @@ static void ext4_finish_bio(struct bio *
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -103,8 +102,7 @@ static void ext4_finish_bio(struct bio *
 			if (bio->bi_status)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 			fscrypt_free_bounce_page(bounce_page);
 			end_page_writeback(page);
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -92,8 +92,7 @@ static void ntfs_end_buffer_async_read(s
 				"0x%llx.", (unsigned long long)bh->b_blocknr);
 	}
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	flags = bh_uptodate_lock_irqsave(first);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -108,8 +107,7 @@ static void ntfs_end_buffer_async_read(s
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(first, flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
@@ -142,9 +140,7 @@ static void ntfs_end_buffer_async_read(s
 	unlock_page(page);
 	return;
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
-	return;
+	bh_uptodate_unlock_irqrestore(first, flags);
 }
 
 /**
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -78,6 +78,22 @@ struct buffer_head {
 	atomic_t b_count;		/* users using this buffer_head */
 };
 
+static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptodate_Lock, &bh->b_state);
+	return flags;
+}
+
+static inline void
+bh_uptodate_unlock_irqrestore(struct buffer_head *bh, unsigned long flags)
+{
+	bit_spin_unlock(BH_Uptodate_Lock, &bh->b_state);
+	local_irq_restore(flags);
+}
+
 /*
  * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
  * and buffer_foo() functions.


