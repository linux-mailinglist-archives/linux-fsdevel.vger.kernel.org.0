Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077A4119F91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 00:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLJXfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 18:35:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfLJXfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iep2S-0007Qa-6r; Wed, 11 Dec 2019 00:35:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6BA721C047B;
        Wed, 11 Dec 2019 00:35:31 +0100 (CET)
Date:   Tue, 10 Dec 2019 23:35:30 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] Revert "locking/mutex: Complain upon mutex API
 misuse in IRQ contexts"
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        will@kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191210220523.28540-1-dave@stgolabs.net>
References: <20191210220523.28540-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157602093075.30329.6269791000248748517.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     c571b72e2b845ca0519670cb7c4b5fe5f56498a5
Gitweb:        https://git.kernel.org/tip/c571b72e2b845ca0519670cb7c4b5fe5f56498a5
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 10 Dec 2019 14:05:23 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Dec 2019 00:27:43 +01:00

Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"

This ended up causing some noise in places such as rxrpc running in softirq.

The warning is misleading in this case as the mutex trylock and unlock
operations are done within the same context; and therefore we need not
worry about the PI-boosting issues that comes along with no single-owner
lock guarantees.

While we don't want to support this in mutexes, there is no way out of
this yet; so lets get rid of the WARNs for now, as it is only fair to
code that has historically relied on non-preemptible softirq guarantees.
In addition, changing the lock type is also unviable: exclusive rwsems
have the same issue (just not the WARN_ON) and counting semaphores
would introduce a performance hit as mutexes are a lot more optimized.

This reverts:

    a0855d24fc22: ("locking/mutex: Complain upon mutex API misuse in IRQ contexts")

Fixes: a0855d24fc22: ("locking/mutex: Complain upon mutex API misuse in IRQ contexts")
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Tested-by: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-afs@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: will@kernel.org
Link: https://lkml.kernel.org/r/20191210220523.28540-1-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mutex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 54cc5f9..5352ce5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -733,9 +733,6 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
-	WARN_ON(in_interrupt());
-#endif
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 	if (__mutex_unlock_fast(lock))
 		return;
@@ -1416,7 +1413,6 @@ int __sched mutex_trylock(struct mutex *lock)
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-	WARN_ON(in_interrupt());
 #endif
 
 	locked = __mutex_trylock(lock);
