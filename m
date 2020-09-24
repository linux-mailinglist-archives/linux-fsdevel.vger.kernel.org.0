Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94322277AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIXVTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 17:19:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIXVTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:19:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600982393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/f2519A4FFfEiLO37RE5G/56UlC68vOhs3kQ5xBftDs=;
        b=zGWGGczcrPtzNvrC1XAax8sFAbJb/azuMPygmdZ24MAMzrc/rjxqzfXFcjpF+RO/Vrl/1e
        +FVzQkuP0EXtYU0GQJ1REFUeX1JdMrFC3EmQKMfjWwK/KINl3+NfNG58Ti5k2MkHtHSwmK
        m8PJx0ZQ0s/YMLaz5m3riFBqlfyDUeS5UyK7erdiU9EkoPsCZg6UpOI/6arxw8KNo6FbST
        j5kafCPdBC/8OSgIuNU0jnMUHqYnw9SCCluodEsuv/u/I81efcup1XxxD/RFex8cKksjD2
        L5ZPgFpCAZazHE3udxArK3sXCTaK+lvEtzNV3euIuwyrCZyvE4ASCMDLU2QnlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600982393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/f2519A4FFfEiLO37RE5G/56UlC68vOhs3kQ5xBftDs=;
        b=0j6xC2UCjpscBk8+SqseCoV0zxI+5wS2N+WGzn1FbjiK2tzMmySjJ9H6+QqcJ4GLVGCvQp
        Y5V37dIH/PgeasCw==
To:     Tom Hromatka <tom.hromatka@oracle.com>, tom.hromatka@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, mingo@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v2 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
In-Reply-To: <20200915193627.85423-3-tom.hromatka@oracle.com>
References: <20200915193627.85423-1-tom.hromatka@oracle.com> <20200915193627.85423-3-tom.hromatka@oracle.com>
Date:   Thu, 24 Sep 2020 23:19:53 +0200
Message-ID: <87h7rm7tza.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15 2020 at 13:36, Tom Hromatka wrote:
> Prior to this commit, the cpu idle and iowait data in /proc/stat used
> different data sources based upon whether the CPU was online or not.
> This would cause spikes in the cpu idle and iowait data.

This would not cause spikes. It _causes_ these times to go backwards and
start over from 0. That's something completely different than a spike.

Please describe problems precisely.

> This patch uses the same data source, get_cpu_{idle,iowait}_time_us(),
> whether the CPU is online or not.
>
> This patch and the preceding patch, "tick-sched: Do not clear the
> iowait and idle times", ensure that the cpu idle and iowait data
> are always increasing.

So now you have a mixture of 'This commit and this patch'. Oh well.

Aside of that the ordering of your changelog is backwards. Something
like this:

   The CPU idle and iowait times in /proc/stats are inconsistent accross
   CPU hotplug.

   The reason is that for NOHZ active systems the core accounting of CPU
   idle and iowait times used to be reset when a CPU was unplugged. The
   /proc/stat code tries to work around that by using the corresponding
   member of kernel_cpustat when the CPU is offline.

   This works as long as the CPU stays offline, but when it is onlined
   again then the accounting is taken from the NOHZ core data again
   which started over from 0 causing both times to go backwards.

   The HOHZ core has been fixed to preserve idle and iowait times
   accross CPU unplug, so the broken workaround is not longer required.

Hmm?

But...

> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -47,34 +47,12 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  
>  static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
>  {
> -	u64 idle, idle_usecs = -1ULL;
> -
> -	if (cpu_online(cpu))
> -		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> -
> -	if (idle_usecs == -1ULL)
> -		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> -		idle = kcs->cpustat[CPUTIME_IDLE];
> -	else
> -		idle = idle_usecs * NSEC_PER_USEC;
> -
> -	return idle;
> +	return get_cpu_idle_time_us(cpu, NULL) * NSEC_PER_USEC;

Q: How is this supposed to work on !NO_HZ systems or in case that NOHZ
   has been disabled at boot time via command line option or lack of
   hardware?

A: Not at all.

Hint #1: You removed the following comment:

	/* !NO_HZ or cpu offline so we can rely on cpustat.idle */

Hint #2: There is more than one valid kernel configuration.
'
Hint #3: Command line options and hardware features have side effects

Hint #4: git grep 'get_cpu_.*_time_us' 

Thanks,

        tglx

