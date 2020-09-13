Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67D26817F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIMVfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 17:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMVfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:35:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EC3C06174A;
        Sun, 13 Sep 2020 14:35:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600032929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWVkyCxypX9NL1JAA4Hx8hx7gQdL9vEJD46ea+6OI18=;
        b=UlCbduzwFD7qoYvzlYyhNNV680aF4OjmieAYoNyr0QM5QZ+ZiarzrVm0qelPkRT5/iDxlx
        SOTR7Gz0CjcLIw1dO0TLIpdnmB8iH4smllBoy+I9LddrcF4oZGfTQ+1PSzLpmPzZ/4ltix
        dkq/RQKkv6sdq+3IyyH4xE8K5doRqSdOXtJNsW22L1uqPOcfWxNuumhH+7314uX8wjN1OW
        3Qt52K6FFYmmRuU6rldPRyoFFtMRKwFSsjK9x6UIOB3duYhSUaHfchOTw/bVODcdp5+NUK
        uh99YIhucxW/1BMrQjwsG65vl9jY6BMlXe4pJ/VCzzq0L5rzlsG9AlSmckwXgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600032929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWVkyCxypX9NL1JAA4Hx8hx7gQdL9vEJD46ea+6OI18=;
        b=VdGjZPH9VpTTeqKYLNMwIa3mQxbi1My6auql5lzt4VLqpXP7c6Vmk3yMfxZer6gclkY0n6
        ngRGhpfQc2oXLCBA==
To:     Tom Hromatka <tom.hromatka@oracle.com>, tom.hromatka@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, mingo@kernel.org, adobriyan@gmail.com
Subject: Re: [RESEND PATCH 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
In-Reply-To: <20200909144122.77210-3-tom.hromatka@oracle.com>
References: <20200909144122.77210-1-tom.hromatka@oracle.com> <20200909144122.77210-3-tom.hromatka@oracle.com>
Date:   Sun, 13 Sep 2020 23:35:28 +0200
Message-ID: <87d02ppdgf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09 2020 at 08:41, Tom Hromatka wrote:

> A customer reported that when a cpu goes offline, the iowait and idle
> times reported in /proc/stat will sometimes spike.  This is being
> caused by a different data source being used for these values when a
> cpu is offline.
>
> Prior to this patch:
>
> put the system under heavy load so that there is little idle time
>
> 	       user nice system    idle iowait
> 	cpu  109515   17  32111  220686    607
>
> take cpu1 offline
>
> 	       user nice system    idle iowait
> 	cpu  113742   17  32721  220724    612
>
> bring cpu1 back online
>
> 	       user nice system    idle iowait
> 	cpu  118332   17  33430  220687    607
>
> To prevent this, let's use the same data source whether a cpu is
> online or not.

Let's use? Your patch makes it use the same data source.

And again, neither the customer story nor the numbers are helpful to
understand the underlying problem. Also this lacks a reference to the
previous change which preserves the times accross a CPU offline/online
sequence.

> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index 46b3293015fe..35b92539e711 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -47,32 +47,20 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  
>  static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
>  {
> -	u64 idle, idle_usecs = -1ULL;
> +	u64 idle, idle_usecs;
>  
> -	if (cpu_online(cpu))
> -		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> -
> -	if (idle_usecs == -1ULL)
> -		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> -		idle = kcs->cpustat[CPUTIME_IDLE];
> -	else
> -		idle = idle_usecs * NSEC_PER_USEC;
> +	idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> +	idle = idle_usecs * NSEC_PER_USEC;
>  
>  	return idle;

        return get_cpu_idle_time_us(cpu, NULL) * NSEC_PER_USEC;

perhaps?

Thanks,

        tglx
