Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4D7A7AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 14:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfG3MHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 08:07:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56554 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfG3MHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:07:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsQuL-0006QF-SX; Tue, 30 Jul 2019 14:07:09 +0200
Message-Id: <20190730120321.193069837@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 30 Jul 2019 13:24:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        "Theodore Tso" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: [patch 1/4] locking/lockdep: Add Kconfig option for bit spinlocks
References: <20190730112452.871257694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some usage sites of bit spinlocks have a substitution with regular
spinlocks which depends on CONFIG_PREEMPT_RT. But this substitution can
also be used to expose these locks to the regular lock debugging
infrastructure, e.g. lockdep.

As this increases the size of affected data structures significantly this
is guarded by a separate Kconfig switch.

Note, that only the bit spinlocks which have a substitution implemented
will be covered by this. All other bit spinlocks evade lock debugging as
before.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/Kconfig.debug |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1201,6 +1201,16 @@ config DEBUG_RWSEMS
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.
 
+config DEBUG_BIT_SPINLOCKS
+	bool "Bit spinlock debugging"
+	depends on DEBUG_SPINLOCK
+	help
+	  This debugging feature substitutes bit spinlocks in some use
+	  cases, e.g. buffer head, zram, with with regular spinlocks so
+	  these locks are exposed to lock debugging features.
+
+	  Not all bit spinlocks are covered by this.
+
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT


