Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C306F9A86
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEGRVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGRVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 13:21:12 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0611559
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 10:21:10 -0700 (PDT)
Date:   Sun, 7 May 2023 13:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683480068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hurdbnJwUJqK07Lm+4BMc/GcG+c58gJSfQAtVR+cBkY=;
        b=t9HPg37zepSR1RnzhSUKFRxBUu28FVu1Yi23jFUki7ZMbwLSC/NiT3n7wFBZNUFaL6UoyB
        zJPC7zS/i2KkcdGtaRgLAJgrWe5jboQdCOvInvXLMeR4wfr6JjMe/ufK6pDB5akkqqXdTQ
        ldiDYd0e9CxSI40mvUKNrcXC5Ki5rqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFfd99w9vFTftB8D@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
 <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 11:07:22AM +0200, Michal Hocko wrote:
> No. I am mostly concerned about the _maintenance_ overhead. For the
> bare tracking (without profiling and thus stack traces) only those
> allocations that are directly inlined into the consumer are really
> of any use. That increases the code impact of the tracing because any
> relevant allocation location has to go through the micro surgery. 
> 
> e.g. is it really interesting to know that there is a likely memory
> leak in seq_file proper doing and allocation? No as it is the specific
> implementation using seq_file that is leaking most likely. There are
> other examples like that See?

So this is a rather strange usage of "maintenance overhead" :)

But it's something we thought of. If we had to plumb around a _RET_IP_
parameter, or a codetag pointer, it would be a hassle annotating the
correct callsite.

Instead, alloc_hooks() wraps a memory allocation function and stashes a
pointer to a codetag in task_struct for use by the core slub/buddy
allocator code.

That means that in your example, to move tracking to a given seq_file
function, we just:
 - hook the seq_file function with alloc_hooks
 - change the seq_file function to call non-hooked memory allocation
   functions.

> It would have been more convincing if you had some numbers at hands.
> E.g. this is a typical workload we are dealing with. With the compile
> time tags we are able to learn this with that much of cost. With a dynamic
> tracing we are able to learn this much with that cost. See? As small as
> possible is a rather vague term that different people will have a very
> different idea about.

Engineers don't prototype and benchmark everything as a matter of
course, we're expected to have the rough equivealent of a CS education
and an understanding of big O notation, cache architecture, etc.

The slub fast path is _really_ fast - double word non locked cmpxchg.
That's what we're trying to compete with. Adding a big globally
accessible hash table is going to tank performance compared to that.

I believe the numbers we already posted speak for themselves. We're
considerably faster than memcg, fast enough to run in production.

I'm not going to be switching to a design that significantly regresses
performance, sorry :)

> TBH I am much more concerned about the maintenance burden on the MM side
> than the actual code tagging itslef which is much more self contained. I
> haven't seen other potential applications of the same infrastructure and
> maybe the code impact would be much smaller than in the MM proper. Our
> allocator API is really hairy and convoluted.

You keep saying "maintenance burden", but this is a criticism that can
be directed at _any_ patchset that adds new code; it's generally
understood that that is the accepted cost for new functionality.

If you have specific concerns where you think we did something that
makes the code harder to maintain, _please point them out in the
appropriate patch_. I don't think you'll find too much - the
instrumentation in the allocators simply generalizes what memcg was
already doing, and the hooks themselves are a bit boilerplaty but hardly
the sort of thing people will be tripping over later.

TL;DR - put up or shut up :)
