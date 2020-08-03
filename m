Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA923B03A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHCWg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgHCWgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:36:55 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1897C061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 15:36:55 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g18so6764154ooa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plK0GqymQ3C+2tzFtVYK3uq+W2cl/h2HrwEp4cvkNz0=;
        b=HuLhhen2pDFfGpx7/pDu8MlNO84aMsg+zaGc7beck6LLA8p82M5PV/B9ewhKHGLtF8
         T1m2D316IHgQQKVDmQE+GesG8evh3kRnP4lIPiaaam2fdkHeeTWXSHmowl8LfPcDr4wY
         u6pXasbCL7IUjQyFmSyFrMeBgYGbPgKsRmumzMyaXPI3Th5pQP7Ku83hV2qqNNdSiVkJ
         Xgb3eUjKCbyrGboUJ4TLiqdyooAhuztmh4fa7vB5Gxxq7mWEZGWhBFGdH3fzotUqeVbs
         G8ZzoK7xExYC+gcaejEtLYLPsAj/kPh+fZDBBriMf4lFdOaESlzFSO7rHj3t5JOOLqpU
         ZkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plK0GqymQ3C+2tzFtVYK3uq+W2cl/h2HrwEp4cvkNz0=;
        b=ukKkS+gcI/fe+RxXvA/IphbdK6FtYp2sXjNyAk9qoMLUeghP+Hg7T2we+VIkYjOF1n
         6SxdsFqm+LdMBeZISMJHZVNtqGgLHKjw2JV1G4m5DQID/OfcCa9X0QpOfqFaCoerjzf2
         +gseQ1+yzZBIckvA4gURywXhcsD10+pYMhJuiBB0HTkvaxyNUYjsm/4Ry8GmzdvpgjrF
         aQukcIg39qJQP2ceoOmKzVlD32OyNnoqhGmAwL/iV5GWzYk3wIM2D0QslF2h3A2quBci
         6e4brWrMeEHmp4J/8uHMdw18KcPHNF9RVDK1B0jOlPcTEjJSIhbEMxdS8zb/T24/rv1J
         L1ZQ==
X-Gm-Message-State: AOAM531rgCYjdO7t3AiRfC5hxBdo/M03S0l4oW5vi/YRFWrm6uuSE5eZ
        bBcxP7HnHS4tvcY9eOJBxeYjAkVTUrLog2KYK13YTQ==
X-Google-Smtp-Source: ABdhPJzRdyOIZ6AaODF+3TWMXbK/cmhMhDk54se1B4pktCP1gqBjujYPJDPznkQQURjT7Fdpu3qwxN+CZGs/XGVfqO8=
X-Received: by 2002:a4a:751a:: with SMTP id j26mr9527841ooc.7.1596494214434;
 Mon, 03 Aug 2020 15:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200728070131.1629670-1-xii@google.com> <20200728103907.GT119549@hirez.programming.kicks-ass.net>
 <CAOBoifg6Cm2P+HUH0mS1tNpVMa1giWDwKbQ6FofWGZoz1tTt5A@mail.gmail.com>
In-Reply-To: <CAOBoifg6Cm2P+HUH0mS1tNpVMa1giWDwKbQ6FofWGZoz1tTt5A@mail.gmail.com>
From:   Xi Wang <xii@google.com>
Date:   Mon, 3 Aug 2020 15:38:18 -0700
Message-ID: <CAOBoifhX9v-KOP2bt-ppSFfNB2b26vzOHANUYaFx8hESsiQDnQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Make select_idle_sibling search domain configurable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:54 AM Xi Wang <xii@google.com> wrote:
>
> On Tue, Jul 28, 2020 at 3:39 AM <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 28, 2020 at 12:01:31AM -0700, Xi Wang wrote:
> > > The scope of select_idle_sibling idle cpu search is LLC. This
> > > becomes a problem for the AMD CCX architecture, as the sd_llc is only
> > > 4 cores. On a many core machine, the range of search is too small to
> > > reach a satisfactory level of statistical multiplexing / efficient
> > > utilization of short idle time slices.
> > >
> > > With this patch idle sibling search is detached from LLC and it
> > > becomes run time configurable. To reduce search and migration
> > > overheads, a presearch domain is added. The presearch domain will be
> > > searched first before the "main search" domain, e.g.:
> > >
> > > sysctl_sched_wake_idle_domain == 2 ("MC" domain)
> > > sysctl_sched_wake_idle_presearch_domain == 1 ("DIE" domain)
> > >
> > > Presearch will go through 4 cores of a CCX. If no idle cpu is found
> > > during presearch, full search will go through the remaining cores of
> > > a cpu socket.
> >
> > *groan*, this is horrific :-(
> >
> > It is also in direct conflict with people wanting to make it smaller.
> >
> > On top of that, a domain number is a terrible terrible interface. They
> > aren't even available without SCHED_DEBUG on.
> >
> > What is the inter-L3 latency? Going by this that had better be awesome.
> > And if this Infinity Fabric stuff if highly effective in effectively
> > merging L3s -- analogous to what Intel does with it's cache slices, then
> > should we not change the AMD topology setup instead of this 'thing'?
> >
> > Also, this commit:
> >
> >   051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
> >
> > seems to suggest L3 is actually bigger. Suravee, can you please comment?
>
> I think 051f3ca02e46 was still saying 4 cores sharing an L3 but there
> is another numa layer which is 8 cores or 2 * 4 core L3 groups. This
> should be the chiplet layer.
>
> I don't have precise data but some anecdotes are: The latency
> difference between inter 4 core group access and inter 8 core group
> access is not huge. Also my experience from Intel machines was that
> accessing L3 data across numa domains (also across cpu socket) was not
> too bad until the link bandwidth was saturated. I am hoping the
> bandwidth situation is better for AMD as L3 groups are smaller.
> Another factor is sometimes the trade off is spending 10s of us of
> sched overhead vs time slicing at ~12.5ms latency.
>
> What makes the decision trickly is the configuration can depend on
> applications and the scale of the system. For a system with 8 cores,
> running it the old way with 2 * 4 core LLCs might be the best
> decision. For a system with a lot more cores, the number of threads on
> the machine would also scale up, which means more potential to create
> a dynamic imbalance. I have another (even more horrific) patch for
> auto configuring the sysctls, which has (nnext is the size of the next
> higher sched domain):
>
> /*
> * Widen the range of idle core search if llc domain is too small, both in
> * absolute sense and when compared to the next higher level domain.
> */
> if (nllc < min(24, nnext / 4)) {
>         sysctl_sched_wake_idle_domain = next_level;
>         sysctl_sched_wake_idle_presearch_domain = llc_level;
>         /* Also make new idle search domain params more like default llc */
>         sysctl_sched_wake_idle_domain_tune_flags = 1;
> }
>
> -Xi


Overall I think the current numa defaults should be considered broken
for large AMD machines due to latency and core utilization problems.
We need to have some solution for it. Simply Moving up the llc domain
should work, but we likely also want to avoid some of the obvious
overheads. Maybe switching to a CCX local first search order inside
select_idle_core would simplify it? It appears the configuration part
is still difficult to clean up.

-Xi
