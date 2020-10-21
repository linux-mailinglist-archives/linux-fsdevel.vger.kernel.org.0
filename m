Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB0294B5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410097AbgJUKks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 06:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393554AbgJUKkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:40:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EDC0613CE;
        Wed, 21 Oct 2020 03:40:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1546072wme.1;
        Wed, 21 Oct 2020 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RyeqwiVWhD1AChCbYlvVJx3I+RxnZhFcWElvXEHU2aw=;
        b=DnbMey2LhsdzCMM6wwgcAlvsoJASlg1DLvHkVJ06oIwkkskBDP9C+sEraFlg4ufzBZ
         lR190/PTN9BhsTri2jMDbCWY8wB9CQSWxRQhMCvBxVsgl3PKgYgyo27OtIC0INYSqy20
         XxbNWO2WrerCd0Z66qLgFQoK5X5z+jXajrWcX5dFJRMi5Px8QiogvgbgNYlXfUdy9fQG
         sRxsW4pk9Z3kY5LzC6nJ5MpIi4GvUmvYt3x1yWGGopGL5I4FU/xED6TgUcofqo+Mhgag
         Jceu2CBAHh56oqaOnU5o9izxGd70Wh2KLVwuefaZ7N/XqJv+lWgL8NpZKVcXojehJVTp
         03/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RyeqwiVWhD1AChCbYlvVJx3I+RxnZhFcWElvXEHU2aw=;
        b=VtZvhSwRvpozHOXLFw+wxTtHcu0MSr0XmhOeCpiOuxHRyE9t6plvGpiOYbs1jjM7v8
         Dp4wDH+FrqS8dSOke04K0bWXF1a6O43ZIvrWMWEo6e/MAn5P1Ixjk54C8QvnQYt0mmep
         hY0VltyhUO+eT/JC3hmIfR0dTJmKJIDPhEhbNullS0ZXRo2C8iB6c/hxbmEw5fSM3Mlb
         HvR8vtYu1ku2kf5YkGK5SWZoE+CczQHgoMdWDZ8Xnmr1br3OZwh9ThQwaLYw00JYz1LE
         Qb1QH7Ov5Fpwq+ghCNnmNsXdS+cBQDxpJof/OmYu70JFo+SGkJHdljXbi3WF7HQAOWDf
         u76g==
X-Gm-Message-State: AOAM531jj4sjgog+i1so7tNlLqpXuFWNQ8+6LcadKN4TPuUjSLxN3jzM
        beXD56ab7fMqbpOV611clc/ZgklkPjrXAg==
X-Google-Smtp-Source: ABdhPJyO5PUbwlFlgznDqmwemf5Hzr70UD7fQ4iUgGuMfFJ7xvmlqvPs2W6i5Tm/y68bx82L7MOgQA==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr2825289wmi.34.1603276845707;
        Wed, 21 Oct 2020 03:40:45 -0700 (PDT)
Received: from [132.227.76.3] (dell-redha.rsr.lip6.fr. [132.227.76.3])
        by smtp.gmail.com with ESMTPSA id 30sm3299181wrr.35.2020.10.21.03.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 03:40:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] sched: delayed thread migration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Ignatov <rdna@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
 <20201021072612.GV2628@hirez.programming.kicks-ass.net>
From:   Redha <redha.gouicem@gmail.com>
Message-ID: <ad9b8a29-7f14-d8bf-0c6d-5aeb8c6c7912@gmail.com>
Date:   Wed, 21 Oct 2020 12:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021072612.GV2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/10/2020 09:26, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 05:44:38PM +0200, Redha Gouicem wrote:
>> The first patch of the series is not specific to scheduling. It allows us
>> (or anyone else) to use the cpufreq infrastructure at a different sampling
>> rate without compromising the cpufreq subsystem and applications that
>> depend on it.
> It's also completely redudant as the scheduler already reads aperf/mperf
> on every tick. Clearly you didn't do your homework ;-)
My bad. I worked on this a year ago, just never got time to submit to the
lkml and I should have re-done my homework more thoroughly before
submitting. The paper was submitted approximately at the same time as the
patch introducing support frequency invariance and frequency reading at
every tick (1 week apart!)
Again, my bad.

>
>> The main idea behind this patch series is to bring to light the frequency
>> inversion problem that will become more and more prominent with new CPUs
>> that feature per-core DVFS. The solution proposed is a first idea for
>> solving this problem that still needs to be tested across more CPUs and
>> with more applications.
> Which is why schedutil (the only cpufreq gov anybody should be using) is
> integrated with the scheduler and closes the loop and tells the CPU
> about the expected load.
>
While I agree that schedutil is probably a good option, I'm not sure we
treat exactly the same problem. schedutil aims at mapping the frequency of
the CPU to the actual load. What I'm saying is that since it takes some
time for the frequency to match the load, why not account for the frequency
when making placement/migration decisions. I know that with the frequency
invariance code, capacity accounts for frequency, which means that thread
placement decisions do account for frequency indirectly. However, we still
have performance improvements with our patch for the workloads with
fork/wait patterns. I really believe that we can still gain performance if
we make decisions while accounting for the frequency more directly.
