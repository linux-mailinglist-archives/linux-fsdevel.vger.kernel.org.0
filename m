Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051046F35B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjEASPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEASPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 14:15:07 -0400
X-Greylist: delayed 1664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 11:15:05 PDT
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [IPv6:2001:41d0:203:375::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469A1BC6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 11:15:05 -0700 (PDT)
Date:   Mon, 1 May 2023 11:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682964902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6T2XIeT8518y54zvjorB3kR8+9w+3ujz9aAR//CBsM=;
        b=mSi6IKlT1RXSlUBLoPvq7jMrN2IDhBeePAQolSvVEaweLRyurIvLVwuABJN9Jpfic1Yvl3
        LVunGzZxNirFmh6ufKgjfRW52yn83tu+sfI5PXb6yM4xtBHMfTQkPxdaHjp58szJhD01u8
        vJeI+Y6gcJWP3T42UbTxsYN31rZoJ38=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
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
Message-ID: <ZFABlUB/RZM6lUyl@P9FQF9L96D>
References: <20230501165450.15352-1-surenb@google.com>
 <ZE/7FZbd31qIzrOc@P9FQF9L96D>
 <CAJuCfpHU3ZMsNuqi1gSxzAWKr2D3VkiaTY0BEUQgM-QHNxRtSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHU3ZMsNuqi1gSxzAWKr2D3VkiaTY0BEUQgM-QHNxRtSg@mail.gmail.com>
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

On Mon, May 01, 2023 at 11:08:05AM -0700, Suren Baghdasaryan wrote:
> On Mon, May 1, 2023 at 10:47 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Mon, May 01, 2023 at 09:54:10AM -0700, Suren Baghdasaryan wrote:
> > > Performance overhead:
> > > To evaluate performance we implemented an in-kernel test executing
> > > multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> > > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > > affinity set to a specific CPU to minimize the noise. Below is performance
> > > comparison between the baseline kernel, profiling when enabled, profiling
> > > when disabled (nomem_profiling=y) and (for comparison purposes) baseline
> > > with CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:
> > >
> > >                       kmalloc                 pgalloc
> > > Baseline (6.3-rc7)    9.200s                  31.050s
> > > profiling disabled    9.800 (+6.52%)          32.600 (+4.99%)
> > > profiling enabled     12.500 (+35.87%)        39.010 (+25.60%)
> > > memcg_kmem enabled    41.400 (+350.00%)       70.600 (+127.38%)
> >
> > Hm, this makes me think we have a regression with memcg_kmem in one of
> > the recent releases. When I measured it a couple of years ago, the overhead
> > was definitely within 100%.
> >
> > Do you understand what makes the your profiling drastically faster than kmem?
> 
> I haven't profiled or looked into kmem overhead closely but I can do
> that. I just wanted to see how the overhead compares with the existing
> accounting mechanisms.

It's a good idea and I generally think that +25-35% for kmalloc/pgalloc
should be ok for the production use, which is great!
In the reality, most workloads are not that sensitive to the speed of
memory allocation.

> 
> For kmalloc, the overhead is low because after we create the vector of
> slab_ext objects (which is the same as what memcg_kmem does), memory
> profiling just increments a lazy counter (which in many cases would be
> a per-cpu counter).

So does kmem (this is why I'm somewhat surprised by the difference).

> memcg_kmem operates on cgroup hierarchy with
> additional overhead associated with that. I'm guessing that's the
> reason for the big difference between these mechanisms but, I didn't
> look into the details to understand memcg_kmem performance.

I suspect recent rt-related changes and also the wide usage of
rcu primitives in the kmem code. I'll try to look closer as well.

Thanks!
