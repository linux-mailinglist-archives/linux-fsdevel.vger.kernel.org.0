Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96E7D2B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfHABRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:17:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfHABQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:16:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszhM-0002IO-FR; Thu, 01 Aug 2019 03:16:04 +0200
Message-Id: <20190801010944.549462805@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 03:01:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: [patch V2 7/7] fs/jbd2: Free journal head outside of locked region
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On PREEMPT_RT bit-spinlocks have the same semantics as on PREEMPT_RT=n,
i.e. they disable preemption. That means functions which are not safe to be
called in preempt disabled context on RT trigger a might_sleep() assert.

The journal head bit spinlock is mostly held for short code sequences with
trivial RT safe functionality, except for one place:

jbd2_journal_put_journal_head() invokes __journal_remove_journal_head()
with the journal head bit spinlock held. __journal_remove_journal_head()
invokes kmem_cache_free() which must not be called with preemption disabled
on RT.

Jan suggested to rework the removal function so the actual free happens
outside the bit-spinlocked region.

Split it into two parts:

  - Do the sanity checks and the buffer head detach under the lock

  - Do the actual free after dropping the lock

There is error case handling in the free part which needs to dereference
the b_size field of the now detached buffer head. Due to paranoia (caused
by ignorance) the size is retrieved in the detach function and handed into
the free function. Might be over-engineered, but better safe than sorry.

This makes the journal head bit-spinlock usage RT compliant and also avoids
nested locking which is not covered by lockdep.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
---
V2: New patch
---
 fs/jbd2/journal.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2521,9 +2521,10 @@ struct journal_head *jbd2_journal_grab_j
 	return jh;
 }
 
-static void __journal_remove_journal_head(struct buffer_head *bh)
+static size_t __journal_remove_journal_head(struct buffer_head *bh)
 {
 	struct journal_head *jh = bh2jh(bh);
+	size_t b_size = READ_ONCE(bh->b_size);
 
 	J_ASSERT_JH(jh, jh->b_jcount >= 0);
 	J_ASSERT_JH(jh, jh->b_transaction == NULL);
@@ -2533,17 +2534,25 @@ static void __journal_remove_journal_hea
 	J_ASSERT_BH(bh, buffer_jbd(bh));
 	J_ASSERT_BH(bh, jh2bh(jh) == bh);
 	BUFFER_TRACE(bh, "remove journal_head");
+
+	/* Unlink before dropping the lock */
+	bh->b_private = NULL;
+	jh->b_bh = NULL;	/* debug, really */
+	clear_buffer_jbd(bh);
+
+	return b_size;
+}
+
+static void journal_release_journal_head(struct journal_head *jh, size_t b_size)
+{
 	if (jh->b_frozen_data) {
 		printk(KERN_WARNING "%s: freeing b_frozen_data\n", __func__);
-		jbd2_free(jh->b_frozen_data, bh->b_size);
+		jbd2_free(jh->b_frozen_data, b_size);
 	}
 	if (jh->b_committed_data) {
 		printk(KERN_WARNING "%s: freeing b_committed_data\n", __func__);
-		jbd2_free(jh->b_committed_data, bh->b_size);
+		jbd2_free(jh->b_committed_data, b_size);
 	}
-	bh->b_private = NULL;
-	jh->b_bh = NULL;	/* debug, really */
-	clear_buffer_jbd(bh);
 	journal_free_journal_head(jh);
 }
 
@@ -2559,11 +2568,14 @@ void jbd2_journal_put_journal_head(struc
 	J_ASSERT_JH(jh, jh->b_jcount > 0);
 	--jh->b_jcount;
 	if (!jh->b_jcount) {
-		__journal_remove_journal_head(bh);
+		size_t b_size = __journal_remove_journal_head(bh);
+
 		jbd_unlock_bh_journal_head(bh);
+		journal_release_journal_head(jh, b_size);
 		__brelse(bh);
-	} else
+	} else {
 		jbd_unlock_bh_journal_head(bh);
+	}
 }
 
 /*


