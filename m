Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7342E409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhJNWQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 18:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhJNWQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:16:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A19AC061570;
        Thu, 14 Oct 2021 15:14:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so6695308pff.3;
        Thu, 14 Oct 2021 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5ZuKrGzyI6sXcttUGT8m4bIhAiihLIa6Po9/1DTork=;
        b=AsE4PDAG7h8rwyf8bL0F9Io1UF0AoB2kT269QADqYzz+dKtUQx60eUE9HUAHP8Z2Bn
         uC08a/3eAlVxbqwKa/qT8bLYMerUdPOKCGoFBWmLJcRh7g8cFRavDIDHuoNAXemunyc3
         V6INJTbXAxAS9Jnbszimpa1g+68qh9s0SdjeSYXc0UhbjCvYuKjefabWJe4ojMhhZn+C
         pbnXxRrC/Eylg/ZBrgx543czX/iLm3zfSmRuuHlLHU/tGce8ckWeiAQkhJHLxrec8wht
         p4MFNx48pCbGHNwS5DPD82va6P50sWg/rE7o+au6qdSB8gB9Yg3jZXtRzNNJ+QnFrzM1
         nWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C5ZuKrGzyI6sXcttUGT8m4bIhAiihLIa6Po9/1DTork=;
        b=JCD+u6In0lVwFe/SsLynWOWjaLV+wY3UzALbCuqyPYVi1GQ9D5iHBy24uRCnaA98gC
         +tyoX97lPaEEohnSdFQ4CJxzhFExsYIMI8Z63eFFsegwWKGhC7ZpJt9wgz0oNRZAHg4M
         +/w32XX9p+pRiHCSlrp7IAjHq/qoijn8l6NTuhyzpdX4sZ1bsTbcNdRWyqOTCO7ZOYtY
         to5knIMFdAKd3xxxFgkzi9Z11XVtogZl+tvjPEyY+VkFQYmqjgi4od2ahFqdAZodgfsn
         Sc5A0TrNt/Cs624K9qh5eo/OCAgGYeklr4aHTIXb6H2yF9P1X5VCMjHCknOljZVC8LWE
         BVpw==
X-Gm-Message-State: AOAM532KaH0upLv9iw/+5vGOGW/Zl7aAYPBcCVti4b/QsWlhcHrMCX8T
        ITiHJPNjY+qbI/vcjMz5Uw16y0jnKlL/7g==
X-Google-Smtp-Source: ABdhPJwbfxlAoia3kcqBZJw5PExi3eKMTEzSvH3nooHbwUgFD0V2vSQCTqQuhbBWK7latyS5h4Xwzg==
X-Received: by 2002:a63:2361:: with SMTP id u33mr6168320pgm.369.1634249670578;
        Thu, 14 Oct 2021 15:14:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l4sm3233910pga.71.2021.10.14.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:14:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Oct 2021 12:14:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        containers@lists.linux.dev, containers@lists.linux-foundation.org,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
Message-ID: <YWirxCjschoRJQ14@slm.duckdns.org>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
 <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Oct 12, 2021 at 02:12:18PM +0530, Pratik Sampat wrote:
> > > The control and the display interface is fairly disjoint with each
> > > other. Restrictions can be set through control interfaces like cgroups,
> > A task wouldn't really opt-in to cpu isolation with CLONE_NEWCPU it
> > would only affect resource reporting. So it would be one half of the
> > semantics of a namespace.
> > 
> I completely agree with you on this, fundamentally a namespace should
> isolate both the resource as well as the reporting. As you mentioned
> too, cgroups handles the resource isolation while this namespace
> handles the reporting and this seems to break the semantics of what a
> namespace should really be.
> 
> The CPU resource is unique in that sense, at least in this context,
> which makes it tricky to design a interface that presents coherent
> information.

It's only unique in the context that you're trying to place CPU distribution
into the namespace framework when the resource in question isn't distributed
that way. All of the three major local resources - CPU, memory and IO - are
in the same boat. Computing resources, the physical ones, don't render
themselves naturally to accounting and ditributing by segmenting _name_
spaces which ultimately just shows and hides names. This direction is a
dead-end.

> I too think that having a brand new interface all together and teaching
> userspace about it is much cleaner approach.
> On the same lines, if were to do that, we could also add more useful
> metrics in that interface like ballpark number of threads to saturate
> usage as well as gather more such metrics as suggested by Tejun Heo.
> 
> My only concern for this would be that if today applications aren't
> modifying their code to read the existing cgroup interface and would
> rather resort to using userspace side-channel solutions like LXCFS or
> wrapping them up in kata containers, would it now be compelling enough
> to introduce yet another interface?

While I'm sympathetic to compatibility argument, identifying available
resources was never well-define with the existing interfaces. Most of the
available information is what hardware is available but there's no
consistent way of knowing what the software environment is like. Is the
application the only one on the system? How much memory should be set aside
for system management, monitoring and other administrative operations?

In practice, the numbers that are available can serve as the starting points
on top of which application and environment specific knoweldge has to be
applied to actually determine deployable configurations, which in turn would
go through iterative adjustments unless the workload is self-sizing.

Given such variability in requirements, I'm not sure what numbers should be
baked into the "namespaced" system metrics. Some numbers, e.g., number of
CPUs can may be mapped from cpuset configuration but even that requires
quite a bit of assumptions about how cpuset is configured and the
expectations the applications would have while other numbers - e.g.
available memory - is a total non-starter.

If we try to fake these numbers for containers, what's likely to happen is
that the service owners would end up tuning workload size against whatever
number the kernel is showing factoring in all the environmental factors
knowingly or just through iterations. And that's not *really* an interface
which provides compatibility. We're just piping new numbers which don't
really mean what they used to mean and whose meanings can change depending
on configuration through existing interfaces and letting users figure out
what to do with the new numbers.

To achieve compatibility where applications don't need to be changed, I
don't think there is a solution which doesn't involve going through
userspace. For other cases and long term, the right direction is providing
well-defined resource metrics that applications can make sense of and use to
size themselves dynamically.

> While I concur with Tejun Heo's comment the mail thread and overloading
> existing interfaces of sys and proc which were originally designed for
> system wide resources, may not be a great idea:
> 
> > There is a fundamental problem with trying to represent a resource shared
> > environment controlled with cgroup using system-wide interfaces including
> > procfs
> 
> A fundamental question we probably need to ascertain could be -
> Today, is it incorrect for applications to look at the sys and procfs to
> get resource information, regardless of their runtime environment?

Well, it's incomplete even without containerization. Containerization just
amplifies the shortcomings. All of these problems existed well before
cgroups / namespaces. How would you know how much resource you can consume
on a system just looking at hardware resources without implicit knowledge of
what else is on the system? It's just that we are now more likely to load
systems dynamically with containerization.

> Also, if an application were to only be able to view the resources
> based on the restrictions set regardless of the interface - would there
> be a disadvantage for them if they could only see an overloaded context
> sensitive view rather than the whole system view?

Can you elaborate further? I have a hard time understanding what's being
asked.

Thanks.

-- 
tejun
