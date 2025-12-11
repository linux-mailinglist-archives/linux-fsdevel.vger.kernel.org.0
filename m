Return-Path: <linux-fsdevel+bounces-71133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFBCB6792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 17:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2B803001C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE62820A0;
	Thu, 11 Dec 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtF/otju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A21EB19B;
	Thu, 11 Dec 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470859; cv=none; b=t1FXiDgmgDODWL05FSrnu335HjdPf7QOxaSnlA1xNtBA7hT9940FKepiRDNSNx6LgfXLoBm0HyzDVlO7C9sXcN0k2Wm8wTMSmYSYLggh1Qf7/Ac7SjNUN095jmMQtEpCShl+WGQo1g5wBIERxIc6C6q6EQDZHfin/kCSOQ7+PWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470859; c=relaxed/simple;
	bh=cPRukpfjgKKdgPyBBWgAUHMv+z27naMDpWQ3l72BCFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLsgEdLtrd3gUIIsWDYxJXn+sZje5tqCk8Q9JtkPlYAYMuXAoLxEcj6yWaJmmnXG8RYRh8xv4qosmR+wFRi/nr7KuKUvxjpahmRGVsHAqpTgltBYTmpCQTN9CQ0GeGJkvyzF5DicphTbffPXNL6qiCzYQDKJCPrM2fNXjYoDw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtF/otju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E148C4CEF7;
	Thu, 11 Dec 2025 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765470859;
	bh=cPRukpfjgKKdgPyBBWgAUHMv+z27naMDpWQ3l72BCFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtF/otjunMnhCXPFwRxyww0u+pLbGv6VEkSM3daEoDt39DsKUuYk8Kic5Z7jjC9mU
	 oS8oTVUHEindPOckMUv+ZDiFcKfPEZQtlYo3Kc1ifRSn+5ngtPB9XzuAehWqSUHGlk
	 yRpmzrB7ZUicbs1DeH5wrqcAQzMSQ25EVi1Mw2/iBkqxid+DJ94jfi4iK/HSSvcoay
	 G+QiPINhoWKiStuudS+on7ex0z511L00YKx7opOcjtpCENWpqJ0n9zqwxrHrYsxK0c
	 Bir5BZz2hAPB/uyZiIxkquUVdsPmX5pCruy2un1I2yKJhMpcl7+q/87DsQ8CE/0JJO
	 jXIVhnWVVCFDQ==
Date: Thu, 11 Dec 2025 17:34:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] timers/nohz: Avoid /proc/stat idle/iowait
 fluctuation when cpu hotplug
Message-ID: <aTryiIrwL4WJZKPt@localhost.localdomain>
References: <20251210083135.3993562-1-jackzxcui1989@163.com>
 <20251210083135.3993562-3-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210083135.3993562-3-jackzxcui1989@163.com>

Hi Xin,

Le Wed, Dec 10, 2025 at 04:31:35PM +0800, Xin Zhao a écrit :
> The idle and iowait statistics in /proc/stat are obtained through
> get_idle_time() and get_iowait_time(). Assuming CONFIG_NO_HZ_COMMON is
> enabled, when CPU is online, the idle and iowait values use the
> idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
> use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
> is offline. Although /proc/stat do not print statistics of offline CPU,
> it still print aggregated statistics of all possible CPUs.
> 
> tick_cpu_sched and kernel_cpustat are maintained by different logic,
> leading to a significant gap. The first line of the data below shows the
> /proc/stat output when only one CPU remains after CPU offline, the second
> line shows the /proc/stat output after all CPUs are brought back online:
> 
> cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
> cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0
> 
> Obviously, other values do not experience significant fluctuations, while
> idle/iowait statistics show a substantial decrease, which make system CPU
> monitoring troublesome.
> 
> get_cpu_idle_time_us() calculates the latest cpu idle time based on
> idle_entrytime and current time. When CPU is idle when offline, the value
> return by get_cpu_idle_time_us() will continue to increase, which is
> unexpected. get_cpu_iowait_time_us() has the similar calculation logic.
> When CPU is in the iowait state when offline, the value return by
> get_cpu_iowait_time_us() will continue to increase.
> 
> Introduce get_cpu_idle_time_us_offline() as the _offline variants of
> get_cpu_idle_time_us(). get_cpu_idle_time_us_offline() just return the
> same value of idle_sleeptime without any calculation. In this way,
> /proc/stat logic can use it to get a correct CPU idle time, which remains
> unchanged during CPU offline period. Also, the aggregated statistics of
> all possible CPUs printed by /proc/stat will not experience significant
> fluctuation when CPU hotplug.
> So as the newly added get_cpu_iowait_time_us_offline().
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

So the problem is a bit deeper (warning: lots of bullets)

First of all you shouldn't need get_cpu_iowait_time_us_offline().
get_cpu_idle_time_us() is supposed to stop advancing after
tick_sched_timer_dying().

But since this code:

	if (cpu_is_offline(cpu)) {
		cpuhp_report_idle_dead();
		arch_cpu_idle_dead();
	}

is placed after tick_nohz_idle_enter() in do_idle(), the idle time
moves forward as long as the CPU is offline.

In fact offline handling in idle should happen at the very beginning
of do_idle because:

* There is no tick handling to do
* There is no nohz idle balancing to do
* And polling to TIF_RESCHED is useless
* No need to check if need_resched() before offline handling since
  stop_machine is done and all per-cpu kthread should be done with
  their job.

So:

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd17..35d79af3286d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -260,6 +260,12 @@ static void do_idle(void)
 {
 	int cpu = smp_processor_id();
 
+	if (cpu_is_offline(cpu)) {
+		local_irq_disable();
+		cpuhp_report_idle_dead();
+		arch_cpu_idle_dead();
+	}
+
 	/*
 	 * Check if we need to update blocked load
 	 */
@@ -311,11 +317,6 @@ static void do_idle(void)
 		 */
 		local_irq_disable();
 
-		if (cpu_is_offline(cpu)) {
-			cpuhp_report_idle_dead();
-			arch_cpu_idle_dead();
-		}
-
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
 

But tick_sched_timer_dying() temporarily clears the idle/iowait time.
It's fixable but that's not all. We still have two idle time accounting
with each having their shortcomings:

* The accounting for online CPUs which is based on delta between
  tick_nohz_start_idle() and tick_nohz_stop_idle().

  Pros:
       - Works when the tick is off

       - Has nsecs granularity
  Cons:
       - Ignore steal time and possibly spuriously substract it from later
         system accounting.

       - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but the
         idle irqtime is possibly spuriously substracted from later system
         accounting.

       - Is not accurate when CONFIG_IRQ_TIME_ACCOUNTING=n

       - The windows between 1) idle task scheduling and the first call to
         tick_nohz_start_idle() and 2) idle task between the last
         tick_nohz_stop_idle() and the rest of the idle time are blindspots
	 wrt. cputime accounting.

* The accounting for offline CPUs which is based on ticks and the
  jiffies delta during which the tick was stopped.

  Pros:
       - Handles steal time correctly

       - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and CONFIG_IRQ_TIME_ACCOUNTING=n
         correctly.

       - Handles the whole idle task

   Cons:
       - Doesn't elapse when the tick is off

       - Has TICK_NSEC granularity (jiffies)

       - Needs to track the idle ticks that were accounted and substract
         them from the total jiffies time spent while the tick was stopped.
	 This is ugly.
	 

So what I think we should do is having a single one solution always applying
to cpustat which does a hybrid approach with better support:

* Tick based accounting whenever the tick isn't stopped.

* When the tick is stopped, account like we do between tick_nohz_start_idle()
  and tick_nohz_stop_idle() (but only when the tick is actually stopped) and
  handle CONFIG_IRQ_TIME_ACCOUNTING correctly such that:

  - If y, stop on IRQ entry and restart on IRQ exit like we used to. It means
    we must flush cpu_irqtime::tick_delta upon tick restart so that it's not
    substracted later from system accounting.

  - If n, keep accounting on IRQs (remove calls to tick_nohz_start_idle()
    and tick_nohz_stop_idle() during IRQs)

  During that tick stopped time, tick based accounting must be ignored.

  Idle steal delta time must be recorded at tick stop/tick restart boundaries
  and substracted from later idle time accounting.

  This logic should be moved to vtime and we still need the offlining fix above.

Just give me a few days to work on that patchset.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

