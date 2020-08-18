Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8024831F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRKft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRKfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:35:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCADC061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 03:35:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so17701433qkf.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qlc8i4WcaLGzjuzLCQuYqKKSVFT1SJwivNfqZW5VqT4=;
        b=D+AXs5u4icCFXOrccNIya9OfdiSVGHptiCbS4U4MtOZK/btvSa9eX8FVKZBh1negDV
         FemQeVyJCt8wUbC+K0euzqx7jvOmXbQm5Dn3nJcMx6aDQnmw0A/HkuGACqgYd2kPfJiG
         vdcnekXyohzB2PvtYEUWuln9SFWFdhspRM8oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qlc8i4WcaLGzjuzLCQuYqKKSVFT1SJwivNfqZW5VqT4=;
        b=BlYK/L52ux8oAqUzaL2qF4YyaQc7PyMfJdvyPBKl8Sxit8+NceOr658xGOZVobM3Wq
         E+da86zPU3QxqwwrOFbMaz2H1ce6Xtiz4Zyd2Yr5YFw/kOjQy+DXTEm6UjTQGVuKqILc
         d/m+/9NzwCEZG+qEx2a0ZV/JYznF08hr9BHe4H1pKgiiSBbGEUTAxRyV0f27U5e2BS4k
         0TEkunm9a96S+TwKj9eZokIEyWJ6S2EyweFmOUi8MVddc0MLtpIkQMsYLDwklQD1Yahy
         MLPNsFd62uvcI8XGuxXJmkhQNUyQxVxJvcoA9jdViJZoyoVGGKDD0pdkgtKLDOVuBilJ
         iEug==
X-Gm-Message-State: AOAM532yaP6rft+vKBrIOfxmg4T3SsqobE0LSRhvqND9ndDDZJ4Dbsvi
        +1EKJV77is6r79SSphgIJvJsrQ==
X-Google-Smtp-Source: ABdhPJyP9123mjcEB4Gacb/otH7/RlkpFN/q342fEZhyE2JQ0hS+aZmtOxf4Y511PcIOlkRd899Dhw==
X-Received: by 2002:a37:9c6:: with SMTP id 189mr16374124qkj.122.1597746941391;
        Tue, 18 Aug 2020 03:35:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:179c])
        by smtp.gmail.com with ESMTPSA id n6sm18455790qkh.74.2020.08.18.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 03:35:40 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:35:39 +0100
From:   Chris Down <chris@chrisdown.name>
To:     peterz@infradead.org
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818103539.GA156577@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818101756.GA155582@chrisdown.name>
 <20200818102616.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818102616.GP2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

peterz@infradead.org writes:
>On Tue, Aug 18, 2020 at 11:17:56AM +0100, Chris Down wrote:
>
>> I'd ask that you understand a bit more about the tradeoffs and intentions of
>> the patch before rushing in to declare its failure, considering it works
>> just fine :-)
>>
>> Clamping the maximal time allows the application to take some action to
>> remediate the situation, while still being slowed down significantly. 2
>> seconds per allocation batch is still absolutely plenty for any use case
>> I've come across. If you have evidence it isn't, then present that instead
>> of vague notions of "wrongness".
>
>There is no feedback from the freeing rate, therefore it cannot be
>correct in maintaining a maximum amount of pages.

memory.high is not about maintaining a maximum amount of pages. It's strictly 
best-effort, and the ramifications of a breach are typically fundamentally 
different than for dirty throttling.

>0.5 pages / sec is still non-zero, and if the free rate is 0, you'll
>crawl across whatever limit was set without any bounds. This is math
>101.
>
>It's true that I haven't been paying attention to mm in a while, but I
>was one of the original authors of the I/O dirty balancing, I do think I
>understand how these things work.

You're suggesting we replace a well understood, easy to reason about model with 
something non-trivially more complex, all on the back of you suggesting that 
the current approach is "wrong" without any evidence or quantification.

Peter, we're not going to throw out perfectly function memcg code simply 
because of your say so, especially when you've not asked for information or 
context about the tradeoffs involved, or presented any evidence that something 
perverse is actually happening.

Prescribing a specific solution modelled on some other code path here without 
producing evidence or measurements specific to the nuances of this particular 
endpoint is not a recipe for success.
