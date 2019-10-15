Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B943D7FC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 21:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfJOTSp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 15:18:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbfJOTSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:44 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLA-00067i-N4; Tue, 15 Oct 2019 21:18:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 23/34] fs: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:10 +0200
Message-Id: <20191015191821.11479-24-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the i_size() and part_nr_sects_…() code over to use
CONFIG_PREEMPTION. Update the comment for fsstack_copy_inode_size() also
to refer to CONFIG_PREEMPTION.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +PREEMPT comments]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/stack.c            | 6 +++---
 include/linux/fs.h    | 4 ++--
 include/linux/genhd.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 4ef2c056269d5..c9830924eb125 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -23,7 +23,7 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 
 	/*
 	 * But on 32-bit, we ought to make an effort to keep the two halves of
-	 * i_blocks in sync despite SMP or PREEMPT - though stat's
+	 * i_blocks in sync despite SMP or PREEMPTION - though stat's
 	 * generic_fillattr() doesn't bother, and we won't be applying quotas
 	 * (where i_blocks does become important) at the upper level.
 	 *
@@ -38,14 +38,14 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 		spin_unlock(&src->i_lock);
 
 	/*
-	 * If CONFIG_SMP or CONFIG_PREEMPT on 32-bit, it's vital for
+	 * If CONFIG_SMP or CONFIG_PREEMPTION on 32-bit, it's vital for
 	 * fsstack_copy_inode_size() to hold some lock around
 	 * i_size_write(), otherwise i_size_read() may spin forever (see
 	 * include/linux/fs.h).  We don't necessarily hold i_mutex when this
 	 * is called, so take i_lock for that case.
 	 *
 	 * And if on 32-bit, continue our effort to keep the two halves of
-	 * i_blocks in sync despite SMP or PREEMPT: use i_lock  for that case
+	 * i_blocks in sync despite SMP or PREEMPTION: use i_lock for that case
 	 * too, and do both at once by combining the tests.
 	 *
 	 * There is none of this locking overhead in the 64-bit case.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d357634..1941bfecf943a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -855,7 +855,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 		i_size = inode->i_size;
 	} while (read_seqcount_retry(&inode->i_size_seqcount, seq));
 	return i_size;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	loff_t i_size;
 
 	preempt_disable();
@@ -880,7 +880,7 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 	inode->i_size = i_size;
 	write_seqcount_end(&inode->i_size_seqcount);
 	preempt_enable();
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	inode->i_size = i_size;
 	preempt_enable();
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330dd5ac09..c1583357e9cd4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -717,7 +717,7 @@ static inline void hd_free_part(struct hd_struct *part)
  * accessor function.
  *
  * Code written along the lines of i_size_read() and i_size_write().
- * CONFIG_PREEMPT case optimizes the case of UP kernel with preemption
+ * CONFIG_PREEMPTION case optimizes the case of UP kernel with preemption
  * on.
  */
 static inline sector_t part_nr_sects_read(struct hd_struct *part)
@@ -730,7 +730,7 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 		nr_sects = part->nr_sects;
 	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
 	return nr_sects;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	sector_t nr_sects;
 
 	preempt_disable();
@@ -753,7 +753,7 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	part->nr_sects = size;
 	preempt_enable();
-- 
2.23.0

