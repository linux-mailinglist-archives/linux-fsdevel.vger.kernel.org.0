Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE333EB63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 09:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCQIZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCQIZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:25:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5DC06174A;
        Wed, 17 Mar 2021 01:25:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so643950wmc.0;
        Wed, 17 Mar 2021 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XlkVO6VFXg55yuEE9nnAKjJmnNqPrYchZV1BwfG3vEE=;
        b=Jam1UbwprzCXzzWEp+LYot8Zkf2BvneeSOULv9A/8hivTc7bJiuQdj2Lye7Ncn1/hI
         yOWrgSsCJPKI81KEEUxt0cNhLIDhTj0zuXCAfSmKkjBEhq/C8C9n3RgPI4d7yTO3wndo
         SRpue61U3aUFu2FhbI3SHxQseZdkr8adguroFIxHEuAIcmAmg/7dOmJOH2b+Ixr0J/P3
         ilvdZXLP2uU7J6LoVy0R2mZkzrKnw58IZdkF3qQUtiHOkTjKgi3qKEmJmHn5XqMHbvfY
         N9p558Mq3y/NlUET0mSgzuidFT9a7hGdiIfF25p6Q9tUYowSVA7wuIPq+X5W93N2bv51
         cZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XlkVO6VFXg55yuEE9nnAKjJmnNqPrYchZV1BwfG3vEE=;
        b=P9VnCa8K5jKGbNowbz2UWCFST58eZ/NK/SrghSuhcrC5GYm+WvF1+R08JKsflK0Qis
         40AtvYmY6fErHBzg2hr70KY5g4EVa7ZKVeUy7kIJWl++/WIYSIC0sh0nvAOdMvw91t12
         5kpcrZ9YRpZXF1SLkPRURZOv/Ea3MZal2cxh9zAsghiWXHOTPPPqoBDDX95DhXzbJx+U
         q/FlxAwEsO3rf50tQT4471nx6Ye9O6dArUGntnbr8eNLqxYseNoBHRWYSGXWtUgIs7Kg
         ANH3AmLc/6zgz9mt58c4CISlSSOd7s8DkuQTM44goJebkN/QiP5dh/LgSrSE8wmChPjs
         oTqA==
X-Gm-Message-State: AOAM533X6DnO0eZXmOKO8BnuHPUV32rWgeR0o9Yq5xSy70DV2mFlIHRe
        bT7xJYn6dQa952PKhugSlmQ=
X-Google-Smtp-Source: ABdhPJyYp3dTaFQrggmXs8bfJj/VA/D+NPW2wY1Vxyf4X9WNVm/dAfNNvAW3+3t1iix/uEqsIqtUMg==
X-Received: by 2002:a1c:e184:: with SMTP id y126mr2514928wmg.163.1615969553494;
        Wed, 17 Mar 2021 01:25:53 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c6sm285377wri.32.2021.03.17.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:25:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:25:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: Warn on long periods of pending need_resched
Message-ID: <20210317082550.GA3881262@gmail.com>
References: <20210317045949.1584952-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317045949.1584952-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Josh Don <joshdon@google.com> wrote:

> From: Paul Turner <pjt@google.com>
> 
> CPU scheduler marks need_resched flag to signal a schedule() on a
> particular CPU. But, schedule() may not happen immediately in cases
> where the current task is executing in the kernel mode (no
> preemption state) for extended periods of time.
> 
> This patch adds a warn_on if need_resched is pending for more than the
> time specified in sysctl resched_latency_warn_ms. Monitoring is done via
> the tick and the accuracy is hence limited to jiffy scale. This also
> means that we won't trigger the warning if the tick is disabled.

Looks useful.

> If resched_latency_warn_ms is set to the default value, only one warning
> will be produced per boot.

Looks like a value hack, should probably be a separate flag, 
defaulting to warn-once.

> This warning only exists under CONFIG_SCHED_DEBUG. If it goes off, it is
> likely that there is a missing cond_resched() somewhere.

CONFIG_SCHED_DEBUG is default-y, so most distros have it enabled.

> +/*
> + * Print a warning if need_resched is set for at least this long. At the
> + * default value, only a single warning will be printed per boot.
> + *
> + * Values less than 2 disable the feature.
> + *
> + * A kernel compiled with CONFIG_KASAN tends to run more slowly on average.
> + * Increase the need_resched timeout to reduce false alarms.
> + */
> +#ifdef CONFIG_KASAN
> +#define RESCHED_DEFAULT_WARN_LATENCY_MS 101
> +#define RESCHED_BOOT_QUIET_SEC 600
> +#else
> +#define RESCHED_DEFAULT_WARN_LATENCY_MS 51
> +#define RESCHED_BOOT_QUIET_SEC 300
>  #endif
> +int sysctl_resched_latency_warn_ms = RESCHED_DEFAULT_WARN_LATENCY_MS;
> +#endif /* CONFIG_SCHED_DEBUG */

I'd really just make this a single value - say 100 or 200 msecs.

> +static inline void resched_latency_warn(int cpu, u64 latency)
> +{
> +	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
> +
> +	WARN(__ratelimit(&latency_check_ratelimit),
> +	     "CPU %d: need_resched set for > %llu ns (%d ticks) "
> +	     "without schedule\n",
> +	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
> +}

Could you please put the 'sched:' prefix into scheduler warnings. 
Let's have a bit of a namespace structure in new warnings.

Thanks,

	Ingo
