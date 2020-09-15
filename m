Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28026B0D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgIOWUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgIOQ3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:29:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBBC061226;
        Tue, 15 Sep 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gmRfhl0zVqM19BJLbrFhaB+tlpuWH7TN/PvY9E+maBw=; b=FF5mc2aJQN3WXXp0KhgrGxlZvC
        2kfepRAiCwew9sJzhjmD3ARsGPBWDDlwf+Tlh+PRLxGkemp7ZANYZW8HqmPW/ZFP8l6xymmhVBoUt
        J3mY/w5aiAYUPIRvKUX3BcoCK6nQijkjBVE7NEo3oM5IrTET490HcTnmgUH25mXC2QK6e6mgogCwd
        00VgONh4RgQzCSkY2YUOs7HN6SfnVqh79c4wyoiZZ42sIwQp91pUKUPm69KHFEaB+0hvNZU7Ivark
        RcRRKO8/JUOKJcMULRFNERftqqAtH5BgKYS2YxcpBIeJ+MbwLMoJ+NFcnoPR+voul25T1CfmKha8l
        oW8WA1sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIDQo-0002Ac-5g; Tue, 15 Sep 2020 16:03:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA959301E02;
        Tue, 15 Sep 2020 18:03:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50BEB205A5BA8; Tue, 15 Sep 2020 18:03:44 +0200 (CEST)
Date:   Tue, 15 Sep 2020 18:03:44 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915160344.GH35926@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155150.GD2674@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:51:50PM +0200, peterz@infradead.org wrote:

> Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.

How's this?

---
Subject: locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count
From: Hou Tao <houtao1@huawei.com>
Date: Tue, 15 Sep 2020 22:07:50 +0800

From: Hou Tao <houtao1@huawei.com>

The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
that percpu-rwsem is a blocking primitive, should be just fine.

However, file_end_write() is used from IRQ context and will cause
load-store issues.

Fixing it by using the IRQ-safe this_cpu_*() for operations on
read_count. This will generate more expensive code on a number of
platforms, which might cause a performance regression for some of the
other percpu-rwsem users.

If any such is reported, we can consider alternative solutions.

Fixes: 70fe2f48152e ("aio: fix freeze protection of aio writes")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200915140750.137881-1-houtao1@huawei.com
---
 include/linux/percpu-rwsem.h  |    8 ++++----
 kernel/locking/percpu-rwsem.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -60,7 +60,7 @@ static inline void percpu_down_read(stru
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
@@ -79,7 +79,7 @@ static inline bool percpu_down_read_tryl
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
@@ -103,7 +103,7 @@ static inline void percpu_up_read(struct
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss))) {
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 	} else {
 		/*
 		 * slowpath; reader will only ever wake a single blocked
@@ -115,7 +115,7 @@ static inline void percpu_up_read(struct
 		 * aggregate zero, as that is the only time it matters) they
 		 * will also see our critical section.
 		 */
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 		rcuwait_wake_up(&sem->writer);
 	}
 	preempt_enable();
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	__this_cpu_inc(*sem->read_count);
+	this_cpu_inc(*sem->read_count);
 
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -71,7 +71,7 @@ static bool __percpu_down_read_trylock(s
 	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
-	__this_cpu_dec(*sem->read_count);
+	this_cpu_dec(*sem->read_count);
 
 	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
