Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C129268174
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIMV1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 17:27:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMV1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:27:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600032435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mn+lpAZkUaJqWbxEFRYMZxDOSxcAn/m1i3GxkUhpnHQ=;
        b=OuFtZfWQCUT2Rb/MT91ILoTnI1YcdasEECYWRc2hmzvOT5434UM6yNuX1+bzEk/tChUjTi
        vDvBIro4cG9auCpdIQDse2+qekzEleaDcjdC7YTj1DWrRK/cZY21CO+55dCcsbYU/lxLnI
        UWBMd2hKD0NnAHeXBlqJm3nm0m0XVIAtzXhIqDG3Xi7ELu6mQ4lNpW3/gKgMKRcK8KbG1z
        l3COZr4cdSPZB9wMfpmvDn4aE8Ok3VUQQzozpamDBQyXKHxmlf8xaejy6j5ENsKQ19Cvma
        A9XSAaEKpOVpFdO1aoPYdKppjv46Z/XDqJyk7wHKCnEeQBQQjiIEH1jSJTIOUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600032435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mn+lpAZkUaJqWbxEFRYMZxDOSxcAn/m1i3GxkUhpnHQ=;
        b=hIXeJozMIkN6E6UsA/OlcA2rnMJ3aYOhXPmnfigXRA9FIJiA9aiJUwcWKNoiff79q7ic8V
        /+MZYYFL3Q+4RjAQ==
To:     Tom Hromatka <tom.hromatka@oracle.com>, tom.hromatka@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, mingo@kernel.org, adobriyan@gmail.com
Subject: Re: [RESEND PATCH 1/2] tick-sched: Do not clear the iowait and idle times
In-Reply-To: <20200909144122.77210-2-tom.hromatka@oracle.com>
References: <20200909144122.77210-1-tom.hromatka@oracle.com> <20200909144122.77210-2-tom.hromatka@oracle.com>
Date:   Sun, 13 Sep 2020 23:27:14 +0200
Message-ID: <87ft7lpdu5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom,

On Wed, Sep 09 2020 at 08:41, Tom Hromatka wrote:
> A customer reported that when a cpu goes offline and then comes back
> online, the overall cpu idle and iowait data in /proc/stat decreases.
> This is wreaking havoc with their cpu usage calculations.

for a changelog it's pretty irrelevant whether a customer reported
something or not.

Fact is that this happens and you fail to explain WHY it happens,
i.e. because the values are cleared when the CPU goes down and therefore
the accounting starts over from 0 when the CPU comes online again.

Describing this is much more useful than showing random numbers before
and after.

> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1375,13 +1375,22 @@ void tick_setup_sched_timer(void)
>  void tick_cancel_sched_timer(int cpu)
>  {
>  	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
> +	ktime_t idle_sleeptime, iowait_sleeptime;
>  
>  # ifdef CONFIG_HIGH_RES_TIMERS
>  	if (ts->sched_timer.base)
>  		hrtimer_cancel(&ts->sched_timer);
>  # endif
>  
> +	/* save off and restore the idle_sleeptime and the iowait_sleeptime
> +	 * to avoid discontinuities and ensure that they are monotonically
> +	 * increasing
> +	 */

  /*
   * Please use sane multiline comment style and not the above
   * abomination.
   */

Also please explain what this 'monotonically increasing' thing is
about. Without consulting the changelog it's hard to figure out what
that means.

Comments are valuable but only when they make actually sense on
their own. Something like the below perhaps?

  /*
   * Preserve idle and iowait sleep times accross a CPU offline/online
   * sequence as they are accumulative.
   */
   
Hmm?

> +	idle_sleeptime = ts->idle_sleeptime;
> +	iowait_sleeptime = ts->iowait_sleeptime;
>  	memset(ts, 0, sizeof(*ts));
> +	ts->idle_sleeptime = idle_sleeptime;
> +	ts->iowait_sleeptime = iowait_sleeptime;
>  }

Thanks,

        tglx
