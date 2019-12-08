Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB9116286
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLHO6i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 8 Dec 2019 09:58:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfLHO6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy11-0000R6-Ab; Sun, 08 Dec 2019 15:58:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E91311C2884;
        Sun,  8 Dec 2019 15:58:30 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, fs: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-24-bigeasy@linutronix.de>
References: <20191015191821.11479-24-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711082.21853.1069083977574720664.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2496396fcb44404ead24b578c583d5286886e857
Gitweb:        https://git.kernel.org/tip/2496396fcb44404ead24b578c583d5286886e857
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:36 +01:00

sched/rt, fs: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the i_size() and part_nr_sects_…() code over to use
CONFIG_PREEMPTION. Update the comment for fsstack_copy_inode_size() also
to refer to CONFIG_PREEMPTION.

[bigeasy: +PREEMPT comments]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-24-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/stack.c            | 6 +++---
 include/linux/fs.h    | 4 ++--
 include/linux/genhd.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 4ef2c05..c983092 100644
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
index 98e0349..dddfcbb 100644
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
index 8bb6302..a927829 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -718,7 +718,7 @@ static inline void hd_free_part(struct hd_struct *part)
  * accessor function.
  *
  * Code written along the lines of i_size_read() and i_size_write().
- * CONFIG_PREEMPT case optimizes the case of UP kernel with preemption
+ * CONFIG_PREEMPTION case optimizes the case of UP kernel with preemption
  * on.
  */
 static inline sector_t part_nr_sects_read(struct hd_struct *part)
@@ -731,7 +731,7 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 		nr_sects = part->nr_sects;
 	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
 	return nr_sects;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	sector_t nr_sects;
 
 	preempt_disable();
@@ -754,7 +754,7 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	part->nr_sects = size;
 	preempt_enable();
