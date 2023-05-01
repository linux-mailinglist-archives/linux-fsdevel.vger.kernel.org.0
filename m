Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CE6F383E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjEATiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjEATih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 15:38:37 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84EB2D48
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 12:38:11 -0700 (PDT)
Date:   Mon, 1 May 2023 15:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682969889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=541SBwyTjoC6k6Jt8ATpGdLRFrI++rPhwZtbphGiRj8=;
        b=lnRRPNHDnF956aCf54S4b+95wpSdnMmfllJ+6mgP3DVbBtmrb4enc8FuntmqzwjK58Ko7c
        it/LA23okYPlPhL1EmutvgUcpOO1uJdahdi7yk4z9T9+7XExEeC1ejFxjJ/ZhIL438pW5Q
        o4DgZYkgJup7Fn/8Y5iYBiJhhdnxzVA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
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
Message-ID: <ZFAVFlrRtpVgxJ0q@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZE/7FZbd31qIzrOc@P9FQF9L96D>
 <CAJuCfpHU3ZMsNuqi1gSxzAWKr2D3VkiaTY0BEUQgM-QHNxRtSg@mail.gmail.com>
 <ZFABlUB/RZM6lUyl@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFABlUB/RZM6lUyl@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 11:14:45AM -0700, Roman Gushchin wrote:
> It's a good idea and I generally think that +25-35% for kmalloc/pgalloc
> should be ok for the production use, which is great!
> In the reality, most workloads are not that sensitive to the speed of
> memory allocation.

:)

My main takeaway has been "the slub fast path is _really_ fast". No
disabling of preemption, no atomic instructions, just a non locked
double word cmpxchg - it's a slick piece of work.

> > For kmalloc, the overhead is low because after we create the vector of
> > slab_ext objects (which is the same as what memcg_kmem does), memory
> > profiling just increments a lazy counter (which in many cases would be
> > a per-cpu counter).
> 
> So does kmem (this is why I'm somewhat surprised by the difference).
> 
> > memcg_kmem operates on cgroup hierarchy with
> > additional overhead associated with that. I'm guessing that's the
> > reason for the big difference between these mechanisms but, I didn't
> > look into the details to understand memcg_kmem performance.
> 
> I suspect recent rt-related changes and also the wide usage of
> rcu primitives in the kmem code. I'll try to look closer as well.

Happy to give you something to compare against :)
