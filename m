Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F6E7A7B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfG3MIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 08:08:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfG3MIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:08:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsQuN-0006QO-69; Tue, 30 Jul 2019 14:07:11 +0200
Message-Id: <20190730120321.489374435@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 30 Jul 2019 13:24:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, linux-ext4@vger.kernel.org,
        "Theodore Tso" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [patch 4/4] fs: jbd/jbd2: Substitute BH locks for RT and lock
 debugging
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

Substitute the BH_State and BH_JournalHead bit spinlocks with regular
spinlock for PREEMPT_RT enabled kernels.

Bit spinlocks are also not covered by lock debugging, e.g. lockdep. With
the spinlock substitution in place, they can be exposed via
CONFIG_DEBUG_BIT_SPINLOCKS.

Originally-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>
--
 include/linux/buffer_head.h |    8 ++++++++
 include/linux/jbd2.h        |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -79,6 +79,10 @@ struct buffer_head {
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
 	spinlock_t b_uptodate_lock;
+# if IS_ENABLED(CONFIG_JBD2)
+	spinlock_t b_state_lock;
+	spinlock_t b_journal_head_lock;
+# endif
 #endif
 };
 
@@ -101,6 +105,10 @@ bh_uptodate_unlock_irqrestore(struct buf
 static inline void buffer_head_init_locks(struct buffer_head *bh)
 {
 	spin_lock_init(&bh->b_uptodate_lock);
+#if IS_ENABLED(CONFIG_JBD2)
+	spin_lock_init(&bh->b_state_lock);
+	spin_lock_init(&bh->b_journal_head_lock);
+#endif
 }
 
 #else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -342,6 +342,40 @@ static inline struct journal_head *bh2jh
 	return bh->b_private;
 }
 
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
+
+static inline void jbd_lock_bh_state(struct buffer_head *bh)
+{
+	spin_lock(&bh->b_state_lock);
+}
+
+static inline int jbd_trylock_bh_state(struct buffer_head *bh)
+{
+	return spin_trylock(&bh->b_state_lock);
+}
+
+static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
+{
+	return spin_is_locked(&bh->b_state_lock);
+}
+
+static inline void jbd_unlock_bh_state(struct buffer_head *bh)
+{
+	spin_unlock(&bh->b_state_lock);
+}
+
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_lock(&bh->b_journal_head_lock);
+}
+
+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_unlock(&bh->b_journal_head_lock);
+}
+
+#else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_State, &bh->b_state);
@@ -372,6 +406,8 @@ static inline void jbd_unlock_bh_journal
 	bit_spin_unlock(BH_JournalHead, &bh->b_state);
 }
 
+#endif /* !PREEMPT_RT && !DEBUG_BIT_SPINLOCKS */
+
 #define J_ASSERT(assert)	BUG_ON(!(assert))
 
 #define J_ASSERT_BH(bh, expr)	J_ASSERT(expr)


