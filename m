Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959A6F9BA7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjEGU5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGU5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 16:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1386BB;
        Sun,  7 May 2023 13:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA22661CFE;
        Sun,  7 May 2023 20:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FEAC433D2;
        Sun,  7 May 2023 20:55:50 +0000 (UTC)
Date:   Sun, 7 May 2023 16:55:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <20230507165538.3c8331be@rorschach.local.home>
In-Reply-To: <ZFfd99w9vFTftB8D@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
        <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
        <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
        <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
        <ZFfd99w9vFTftB8D@moria.home.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 7 May 2023 13:20:55 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Thu, May 04, 2023 at 11:07:22AM +0200, Michal Hocko wrote:
> > No. I am mostly concerned about the _maintenance_ overhead. For the
> > bare tracking (without profiling and thus stack traces) only those
> > allocations that are directly inlined into the consumer are really
> > of any use. That increases the code impact of the tracing because any
> > relevant allocation location has to go through the micro surgery. 
> > 
> > e.g. is it really interesting to know that there is a likely memory
> > leak in seq_file proper doing and allocation? No as it is the specific
> > implementation using seq_file that is leaking most likely. There are
> > other examples like that See?  
> 
> So this is a rather strange usage of "maintenance overhead" :)
> 
> But it's something we thought of. If we had to plumb around a _RET_IP_
> parameter, or a codetag pointer, it would be a hassle annotating the
> correct callsite.
> 
> Instead, alloc_hooks() wraps a memory allocation function and stashes a
> pointer to a codetag in task_struct for use by the core slub/buddy
> allocator code.
> 
> That means that in your example, to move tracking to a given seq_file
> function, we just:
>  - hook the seq_file function with alloc_hooks
>  - change the seq_file function to call non-hooked memory allocation
>    functions.
> 
> > It would have been more convincing if you had some numbers at hands.
> > E.g. this is a typical workload we are dealing with. With the compile
> > time tags we are able to learn this with that much of cost. With a dynamic
> > tracing we are able to learn this much with that cost. See? As small as
> > possible is a rather vague term that different people will have a very
> > different idea about.  
> 
> Engineers don't prototype and benchmark everything as a matter of
> course, we're expected to have the rough equivealent of a CS education
> and an understanding of big O notation, cache architecture, etc.
> 
> The slub fast path is _really_ fast - double word non locked cmpxchg.
> That's what we're trying to compete with. Adding a big globally
> accessible hash table is going to tank performance compared to that.
> 
> I believe the numbers we already posted speak for themselves. We're
> considerably faster than memcg, fast enough to run in production.
> 
> I'm not going to be switching to a design that significantly regresses
> performance, sorry :)
> 
> > TBH I am much more concerned about the maintenance burden on the MM side
> > than the actual code tagging itslef which is much more self contained. I
> > haven't seen other potential applications of the same infrastructure and
> > maybe the code impact would be much smaller than in the MM proper. Our
> > allocator API is really hairy and convoluted.  
> 
> You keep saying "maintenance burden", but this is a criticism that can
> be directed at _any_ patchset that adds new code; it's generally
> understood that that is the accepted cost for new functionality.
> 
> If you have specific concerns where you think we did something that
> makes the code harder to maintain, _please point them out in the
> appropriate patch_. I don't think you'll find too much - the
> instrumentation in the allocators simply generalizes what memcg was
> already doing, and the hooks themselves are a bit boilerplaty but hardly
> the sort of thing people will be tripping over later.
> 


> TL;DR - put up or shut up :)

Your email would have been much better if you left the above line out. :-/
Comments like the above do not go over well via text. Even if you add the ":)"

Back to the comment about this being a burden. I just applied all the
patches and did a diff (much easier than to wade through 40 patches!)

One thing we need to get rid of, and this isn't your fault but this
series is extending it, is the use of the damn underscores to
differentiate functions. This is one of the abominations of the early
Linux kernel code base. I admit, I'm guilty of this too. But today I
have learned and avoid it at all cost. Underscores are meaningless and
error prone, not to mention confusing to people coming onboard. Let's
use something that has some meaning.

What's the difference between:

  _kmem_cache_alloc_node() and __kmem_cache_alloc_node()?

And if every allocation function requires a double hook, that is a
maintenance burden. We do this for things like system calls, but
there's a strong rationale for that. I'm guessing that Michal's concern
is that he and other mm maintainers will need to make sure any new
allocation function has this double call and is done properly. This
isn't just new code that needs to be maintained, it's something that
needs to be understood when adding any new interface to page
allocations.

It's true that all new code has a maintenance burden, and unless the
maintainer feels the burden is worth their time, they have the right to
complain about it.

I've given talks about how to get code into open source projects, and
the title is "Commits are pulled and never pushed". Where basically I
talk about convincing the maintainers that they want your change, and
not by pushing it because you want it.

-- Steve

