Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5316F9C12
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEGVx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjEGVx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 17:53:27 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B09EF1
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 14:53:23 -0700 (PDT)
Date:   Sun, 7 May 2023 17:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683496401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40BqnBW4/FlB5TIf35hpUldm+3Y4zBbG09TnotWsOUQ=;
        b=aZwHReiwGz+3e0UjAyYj3995zZnryJ+HL6chp+zp8zgo+84Zzb4sqI84KkA0FnHWWjB0Ry
        O/PRLGaSRAAHgRRCQkiBNiDE0ElsoXrkNmCxIUn8Xi9jG500CuG6laUuF0IdWR/J+txpy4
        npcSMQCrutw4mV1bOYsx8fosQG6rKzs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <ZFgdxR9PlUJYegDp@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
 <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
 <ZFfd99w9vFTftB8D@moria.home.lan>
 <20230507165538.3c8331be@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507165538.3c8331be@rorschach.local.home>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 04:55:38PM -0400, Steven Rostedt wrote:
> > TL;DR - put up or shut up :)
> 
> Your email would have been much better if you left the above line out. :-/
> Comments like the above do not go over well via text. Even if you add the ":)"

I stand by that comment :)

> Back to the comment about this being a burden. I just applied all the
> patches and did a diff (much easier than to wade through 40 patches!)
> 
> One thing we need to get rid of, and this isn't your fault but this
> series is extending it, is the use of the damn underscores to
> differentiate functions. This is one of the abominations of the early
> Linux kernel code base. I admit, I'm guilty of this too. But today I
> have learned and avoid it at all cost. Underscores are meaningless and
> error prone, not to mention confusing to people coming onboard. Let's
> use something that has some meaning.
> 
> What's the difference between:
> 
>   _kmem_cache_alloc_node() and __kmem_cache_alloc_node()?
> 
> And if every allocation function requires a double hook, that is a
> maintenance burden. We do this for things like system calls, but
> there's a strong rationale for that.

The underscore is a legitimate complaint - I brought this up in
development, not sure why it got lost. We'll do something better with a
consistent suffix, perhaps kmem_cache_alloc_noacct().

> I'm guessing that Michal's concern is that he and other mm maintainers
> will need to make sure any new allocation function has this double
> call and is done properly. This isn't just new code that needs to be
> maintained, it's something that needs to be understood when adding any
> new interface to page allocations.

Well, isn't that part of the problem then? We're _this far_ into the
thread and still guessing on what Michal's "maintenance concerns" are?

Regarding your specific concern: My main design consideration was making
sure every allocation gets accounted somewhere; we don't want a memory
allocation profiling system where it's possible for allocations to be
silently not tracked! There's warnings in the core allocators if they
see an allocation without an alloc tag, and in testing we chased down
everything we found.

So if anyone later creates a new memory allocation interface and forgets
to hook it, they'll see the same warning - but perhaps we could improve
the warning message so it says exactly what needs to be done (wrap the
allocation in an alloc_hooks() call).

> It's true that all new code has a maintenance burden, and unless the
> maintainer feels the burden is worth their time, they have the right to
> complain about it.

Sure, but complaints should say what they're complaining about.
Complaints so vague they could be levelled at any patchset don't do
anything for the discussion.
