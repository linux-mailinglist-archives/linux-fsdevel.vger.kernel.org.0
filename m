Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEC33EB8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCQIbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCQIbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:31:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79DDC06174A;
        Wed, 17 Mar 2021 01:31:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so889624wrd.1;
        Wed, 17 Mar 2021 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cHZTOPy8YpHReL/nMjpSJvrdN7LdFEoSUmRWRaZIzBY=;
        b=ipURJRhme0LjS0xWeMuiAfAsTYp60CwUWHlam21Yc1mHDQp3XlFyUdsZcevsZdQpGD
         JzpaZ+SAi2WBe1Qd1UV/y/P+LRs7O+q7t7eKYdQVS68po/G6bKGK1FJCML874VV+aHQM
         V1dFw75iuMCx1rQ7dZj2dDNFXFVBxo/E8cqHoLU9Qdvu7LzPhUUn/uiiJfm4KBuPBrDm
         9TcGoiQqldvN3uzuBOD4wWUZ7U2In25adEDuMWEvATGP/KfNa+uWl+B8/s1Zi/Mp97WV
         nAUSJwz1HRNnxrny6TjEvH85L17I3mx1OSaVlPzCFpS/8ZD8rZw39thBYOWm13lAXPwl
         X/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cHZTOPy8YpHReL/nMjpSJvrdN7LdFEoSUmRWRaZIzBY=;
        b=orguoMhe9EWW7R2LpHVinsOGuohoe5J9YqqbD4BDOgE6gDhvAzKfvOFsTXCAl135dO
         NZfVvbiJGB3x08S6ysKdokHs/Sjuxon4tIbytUDLU4RCRNnd5yXrMpNSLleyzxO4Rns9
         JGH8Zsayw7BIxdpcTM92lZPrSLeuHePnqaxxgICLh7khBV9oYkY8ldKRl8CgjHhJuNnV
         U7UlAQIcYI+sA3gPkaNf1DsLILl7PeFMeF/MlULgqgrsYrN5RMma0aVxxTHnbViRBEHz
         QRM5VSoql1ilXpDdf0QYe8hmHslYOHpOydHmj4s6xb3RIQaQJMEOw1/P7eQXeFOpcgZt
         V3qw==
X-Gm-Message-State: AOAM532aheszyL+nHw5uLNeVb/1upHtztYf+y6ckas0BgbsoqiqwK1U8
        nYCL/fISySn8wOFow/3XTYY=
X-Google-Smtp-Source: ABdhPJyibQ2Uc98eNeu9vi5EmhQ9eYYBRZNyKIEdpgEeCv2v0TBVPOz8x7D8gOu3rmamKX3AEHpSrg==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr3127563wrs.86.1615969903780;
        Wed, 17 Mar 2021 01:31:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v3sm1705710wmj.25.2021.03.17.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:31:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:31:41 +0100
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
Message-ID: <20210317083141.GB3881262@gmail.com>
References: <20210317045949.1584952-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317045949.1584952-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Josh Don <joshdon@google.com> wrote:

> +static inline u64 resched_latency_check(struct rq *rq)
> +{
> +	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
> +	bool warn_only_once = (latency_warn_ms == RESCHED_DEFAULT_WARN_LATENCY_MS);
> +	u64 need_resched_latency, now = rq_clock(rq);
> +	static bool warned_once;
> +
> +	if (warn_only_once && warned_once)
> +		return 0;
> +
> +	if (!need_resched() || latency_warn_ms < 2)
> +		return 0;
> +
> +	/* Disable this warning for the first few mins after boot */
> +	if (now < RESCHED_BOOT_QUIET_SEC * NSEC_PER_SEC)
> +		return 0;
> +
> +	if (!rq->last_seen_need_resched_ns) {
> +		rq->last_seen_need_resched_ns = now;
> +		rq->ticks_without_resched = 0;
> +		return 0;
> +	}
> +
> +	rq->ticks_without_resched++;

So AFAICS this will only really do something useful on full-nohz 
kernels with sufficiently long scheduler ticks, right?

On other kernels the scheduler tick interrupt, when it returns to 
user-space, will trigger a reschedule if it sees a need_resched.

Thanks,

	Ingo
