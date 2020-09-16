Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA53626CBC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgIPUec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:34:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbgIPUeW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:34:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC9C6BD5A73D45D7311C;
        Wed, 16 Sep 2020 20:32:22 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 20:32:21 +0800
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
To:     <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
Date:   Wed, 16 Sep 2020 20:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915160344.GH35926@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2020/9/16 0:03, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 05:51:50PM +0200, peterz@infradead.org wrote:
> 
>> Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.
> 
> How's this?
> 
Thanks for that.

> ---
> Subject: locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count
> From: Hou Tao <houtao1@huawei.com>
> Date: Tue, 15 Sep 2020 22:07:50 +0800
> 
> From: Hou Tao <houtao1@huawei.com>
> 
> The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
> that percpu-rwsem is a blocking primitive, should be just fine.
> 
> However, file_end_write() is used from IRQ context and will cause
> load-store issues.
> 
> Fixing it by using the IRQ-safe this_cpu_*() for operations on
> read_count. This will generate more expensive code on a number of
> platforms, which might cause a performance regression for some of the
> other percpu-rwsem users.
> 
> If any such is reported, we can consider alternative solutions.
> 
I have simply test the performance impact on both x86 and aarch64.

There is no degradation under x86 (2 sockets, 18 core per sockets, 2 threads per core)

v5.8.9
no writer, reader cn                               | 18        | 36        | 72
the rate of down_read/up_read per second           | 231423957 | 230737381 | 109943028
the rate of down_read/up_read per second (patched) | 232864799 | 233555210 | 109768011

However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.

v4.19.111
no writer, reader cn                               | 24        | 48        | 72        | 96
the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920

I will test the aarch64 host by using v5.8 tomorrow.

Regards,
Tao


> Fixes: 70fe2f48152e ("aio: fix freeze protection of aio writes")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200915140750.137881-1-houtao1@huawei.com
> ---
>  include/linux/percpu-rwsem.h  |    8 ++++----
>  kernel/locking/percpu-rwsem.c |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -60,7 +60,7 @@ static inline void percpu_down_read(stru
>  	 * anything we did within this RCU-sched read-size critical section.
>  	 */
>  	if (likely(rcu_sync_is_idle(&sem->rss)))
> -		__this_cpu_inc(*sem->read_count);
> +		this_cpu_inc(*sem->read_count);
>  	else
>  		__percpu_down_read(sem, false); /* Unconditional memory barrier */
>  	/*
> @@ -79,7 +79,7 @@ static inline bool percpu_down_read_tryl
>  	 * Same as in percpu_down_read().
>  	 */
>  	if (likely(rcu_sync_is_idle(&sem->rss)))
> -		__this_cpu_inc(*sem->read_count);
> +		this_cpu_inc(*sem->read_count);
>  	else
>  		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
>  	preempt_enable();
> @@ -103,7 +103,7 @@ static inline void percpu_up_read(struct
>  	 * Same as in percpu_down_read().
>  	 */
>  	if (likely(rcu_sync_is_idle(&sem->rss))) {
> -		__this_cpu_dec(*sem->read_count);
> +		this_cpu_dec(*sem->read_count);
>  	} else {
>  		/*
>  		 * slowpath; reader will only ever wake a single blocked
> @@ -115,7 +115,7 @@ static inline void percpu_up_read(struct
>  		 * aggregate zero, as that is the only time it matters) they
>  		 * will also see our critical section.
>  		 */
> -		__this_cpu_dec(*sem->read_count);
> +		this_cpu_dec(*sem->read_count);
>  		rcuwait_wake_up(&sem->writer);
>  	}
>  	preempt_enable();
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
>  
>  static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
>  {
> -	__this_cpu_inc(*sem->read_count);
> +	this_cpu_inc(*sem->read_count);
>  
>  	/*
>  	 * Due to having preemption disabled the decrement happens on
> @@ -71,7 +71,7 @@ static bool __percpu_down_read_trylock(s
>  	if (likely(!atomic_read_acquire(&sem->block)))
>  		return true;
>  
> -	__this_cpu_dec(*sem->read_count);
> +	this_cpu_dec(*sem->read_count);
>  
>  	/* Prod writer to re-evaluate readers_active_check() */
>  	rcuwait_wake_up(&sem->writer);
> .
> 
