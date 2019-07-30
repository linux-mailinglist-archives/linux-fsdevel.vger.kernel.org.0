Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE387A7A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfG3MHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 08:07:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfG3MHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:07:53 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsQuM-0006QL-Op; Tue, 30 Jul 2019 14:07:10 +0200
Message-Id: <20190730120321.393759046@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 30 Jul 2019 13:24:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        "Theodore Tso" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: [patch 3/4] fs/buffer: Substitute BH_Uptodate_Lock for RT and bit
 spinlock debugging
References: <20190730112452.871257694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bit spinlocks are problematic if PREEMPT_RT is enabled. They disable
preemption, which is undesired for latency reasons and breaks when regular
spinlocks are taken within the bit_spinlock locked region because regular
spinlocks are converted to 'sleeping spinlocks' on RT.

Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock for
PREEMPT_RT enabled kernels.

Bit spinlocks are also not covered by lock debugging, e.g. lockdep. With
the spinlock substitution in place, they can be exposed via
CONFIG_DEBUG_BIT_SPINLOCKS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/buffer.c                 |    1 +
 include/linux/buffer_head.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3360,6 +3360,7 @@ struct buffer_head *alloc_buffer_head(gf
 	struct buffer_head *ret = kmem_cache_zalloc(bh_cachep, gfp_flags);
 	if (ret) {
 		INIT_LIST_HEAD(&ret->b_assoc_buffers);
+		buffer_head_init_locks(ret);
 		preempt_disable();
 		__this_cpu_inc(bh_accounting.nr);
 		recalc_bh_state();
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -76,8 +76,35 @@ struct buffer_head {
 	struct address_space *b_assoc_map;	/* mapping this buffer is
 						   associated with */
 	atomic_t b_count;		/* users using this buffer_head */
+
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
+	spinlock_t b_uptodate_lock;
+#endif
 };
 
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
+
+static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bh->b_uptodate_lock, flags);
+	return flags;
+}
+
+static inline void
+bh_uptodate_unlock_irqrestore(struct buffer_head *bh, unsigned long flags)
+{
+	spin_unlock_irqrestore(&bh->b_uptodate_lock, flags);
+}
+
+static inline void buffer_head_init_locks(struct buffer_head *bh)
+{
+	spin_lock_init(&bh->b_uptodate_lock);
+}
+
+#else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
+
 static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
 {
 	unsigned long flags;
@@ -94,6 +121,10 @@ bh_uptodate_unlock_irqrestore(struct buf
 	local_irq_restore(flags);
 }
 
+static inline void buffer_head_init_locks(struct buffer_head *bh) { }
+
+#endif /* !PREEMPT_RT && !DEBUG_BIT_SPINLOCKS */
+
 /*
  * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
  * and buffer_foo() functions.


