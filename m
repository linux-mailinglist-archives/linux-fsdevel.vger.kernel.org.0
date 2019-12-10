Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4738119BFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 23:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfLJWMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 17:12:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729369AbfLJWMr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:12:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 903DCAD2B;
        Tue, 10 Dec 2019 22:12:45 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, will@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"
Date:   Tue, 10 Dec 2019 14:05:23 -0800
Message-Id: <20191210220523.28540-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
References: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

This reverts commit 5d4ebaa87329ef226e74e52c80ac1c62e4948987.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/mutex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 54cc5f9286e9..5352ce50a97e 100644
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
-- 
2.16.4

