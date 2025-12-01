Return-Path: <linux-fsdevel+bounces-70377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09AC99281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299E54E2529
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36665279DC3;
	Mon,  1 Dec 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrlPt3aJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3D184524;
	Mon,  1 Dec 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623828; cv=none; b=BBKbykTy/oPbu9oOPeDV1fpBZxTBNO2DQ9qhg9TbzoCHBQ99sytxHrAdJyw+laWmtAGK067V+9G5Ap6N3tyiPB/XStSLPoAyjJFn/uE8qLDdAqZUXDBU2WPRek51VhACd0/IKiVBWHnsuP4ILPYBVGop4tJQFulduvWOC7PjVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623828; c=relaxed/simple;
	bh=EQQGqUygfCeyoKnVtYdipshmhMfEApSwTrpxjqbDsO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i058SNPMC9Uw0RGkqhUkrO94rzwr/wAI0hK0mq3OOuvChHWxCrb/wRO53b4TYhJKcC+cgxEAyJtTn1ZJAGSRn6NKk+yTr2OIlZ5052ptUEe6iKaxDQJ4QYSheApSrdk6JUiv1JAxf+cGDMvOACvgiuYMmSIGBi5rxW5CntiMue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrlPt3aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B4BC4CEF1;
	Mon,  1 Dec 2025 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623827;
	bh=EQQGqUygfCeyoKnVtYdipshmhMfEApSwTrpxjqbDsO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrlPt3aJiKDtrhmSMLwCZEjm06E7EVCVrNBC4gSNvwqXXbLVkCIWwuDXo48OopSYA
	 totV6fSPYLflvG23rnK4MZ+rxuqah3T30JgNSb0rxJJirCjO4hkoFwbsvaIVOMQmyq
	 1lFfF506f5ZpRev80+t/+WDbs1PJK1YqMvGOnA5SWQwJlCd9L8RdQxSPVV+qkndLXK
	 V8N9NfrT41vA+GE98FwiAC8HKoHGZV6+Abl2Sg/mmpejpXU9eAMDY/VaCJGwln8KBF
	 4GAVFG9EGiYAXUIhPPOMb6dCCIGcUXZvwmko711rwENcu6WqyRk3Y1UrMAhmlVQ4Ri
	 /KVrBhSVlWm5g==
Date: Mon, 1 Dec 2025 22:17:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] timers/nohz: Avoid /proc/stat idle/iowait
 fluctuation when cpu hotplug
Message-ID: <aS4FztjNAwVNfoUk@gmail.com>
References: <20251129133526.1460119-1-jackzxcui1989@163.com>
 <20251129133526.1460119-3-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129133526.1460119-3-jackzxcui1989@163.com>


* Xin Zhao <jackzxcui1989@163.com> wrote:

> The idle and iowait statistics in /proc/stat are obtained through
> get_idle_time and get_iowait_time. Assuming CONFIG_NO_HZ_COMMON is
> enabled, when CPU is online, the idle and iowait values use the
> idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
> use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
> is offline. Although /proc/stat do not print statistics of offline CPU,
> it still print aggregated statistics for all possible CPUs.
> tick_cpu_sched and kernel_cpustat are maintained by different logic,
> leading to a significant gap. The first line of the data below shows the
> /proc/stat output when only one CPU remains after CPU offline, the second
> line shows the /proc/stat output after all CPUs are brought back online:
> 
> cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
> cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0

Yeah, that outlier indeed looks suboptimal, and there's 
very little user-space tooling can do to detect it. I 
think your suggestion, to use the 'frozen' values of an 
offline CPU, might as well be the right approach.

What value is printed if the CPU was never online, is 
it properly initialized to zero?


> Obviously, other values do not experience significant fluctuations, while
> idle/iowait statistics show a substantial decrease, which make system CPU
> monitoring troublesome.
> Introduce get_cpu_idle_time_us_raw and get_cpu_iowait_time_us_raw, so that
> /proc/stat logic can use them to get the last raw value of idle_sleeptime
> and iowait_sleeptime from tick_cpu_sched without any calculation when CPU
> is offline. It avoids /proc/stat idle/iowait fluctuation when cpu hotplug.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
>  fs/proc/stat.c           |  4 ++++
>  include/linux/tick.h     |  4 ++++
>  kernel/time/tick-sched.c | 46 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index 8b444e862..de13a2e1c 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -28,6 +28,8 @@ u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
>  
>  	if (cpu_online(cpu))
>  		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> +	else
> +		idle_usecs = get_cpu_idle_time_us_raw(cpu);
>  
>  	if (idle_usecs == -1ULL)
>  		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> @@ -44,6 +46,8 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  
>  	if (cpu_online(cpu))
>  		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
> +	else
> +		iowait_usecs = get_cpu_iowait_time_us_raw(cpu);

So why not just use the get_cpu_idle_time_us() and 
get_cpu_iowait_time_us() values unconditionally, for 
all possible_cpus?

The raw/non-raw distinction makes very little sense in 
this context, the read_seqlock_retry loop will always 
succeed after a single step (because there are no 
writers), so the behavior of the full get_cpu_idle/iowait_time_us()
functions should be close to the _raw() variants.

Patch would be much simpler that way.

Thanks,

	Ingo

