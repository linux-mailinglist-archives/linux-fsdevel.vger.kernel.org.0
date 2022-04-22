Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735D50B2E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443090AbiDVIdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392566AbiDVIdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:33:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC13E2A278;
        Fri, 22 Apr 2022 01:30:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j9so5348456qkg.1;
        Fri, 22 Apr 2022 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x7EviTHMNmtzDbkP3DS2ypjy8GzAzVe5hD4oCLU6V84=;
        b=a7B0JWYxPns6xU0Y+DoUL/yCA5+MxkKqWD+UswjttIeFTskEdE4J0P3iPBlIGyvnz9
         qlZ2f0Xd8SXtXpQtbHVLxBsP486LW5H60ohhITBuiQoiin6vt+qdUlYCJf+ok2BBO3t8
         KfEULWuz9BJXx1a2VmQqzFawKPa8H7iDStWvvQA7NhPXUmfSkfIv9VaVclM0fGjhcnvX
         f1/99q5WOYfwO2HsZ52u87Mdazgg7GP1AVT6YJAq5MaK+QYjmv3CNKLQ9aTRxjyICF7t
         noOl6wVUuwq/FyZpyar/gBKOURNB3viP7OwC1JzOwimC7eyoXQXxJIi2SuzkKL8kmnO4
         MfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7EviTHMNmtzDbkP3DS2ypjy8GzAzVe5hD4oCLU6V84=;
        b=sl5Gkq9ohnDJ6G2GIXub8JOGUZvau7KuTSx2v1KzgFLj0OsfABY84LTCFvHafuC2k9
         o1EPD10gyDVa4u4DyHIdeoVwAVrkKvSvk1mRSLeyhL8ooMKP2gdqfjNcYtxz4pWnbG+S
         3M3UmQ+QCOBxThV2a/I8wFyuv2HqvNazKtcYTP9rUV8n0iPianCwD3hv14CRLDQAItm6
         Rk0NSSpQvK4z0ETrPSXMklkFgIoArtfX/Zjf53u9Tp7eeS0N80gwFRMB6vh/ClTwgEnY
         Ap5SLFI5OY4F2LuxaNDm2XNvpP4ytLYSahv2cSEXhiqUW30MoofoomyQj6IPpQkGnGci
         U/tg==
X-Gm-Message-State: AOAM532aluzlDsvrBujxyBNcntGmpJT5YPU/w1eYq+7EYTZN1LGs2BtY
        DGqT/axR+V97JF3s1V+EmPHOlchx96GY
X-Google-Smtp-Source: ABdhPJzz+QVCCsUhV/HWk8yp/aP0NPnsL1ijGhzEGoyMp0aHLZIsk7jSNz6TVMa0U7cpLR64U395jA==
X-Received: by 2002:a05:620a:178e:b0:69f:19c4:3241 with SMTP id ay14-20020a05620a178e00b0069f19c43241mr765307qkb.244.1650616240029;
        Fri, 22 Apr 2022 01:30:40 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id h123-20020a379e81000000b0069e955169e5sm643639qke.2.2022.04.22.01.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:30:39 -0700 (PDT)
Date:   Fri, 22 Apr 2022 04:30:37 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
 <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:03:36AM +0200, Michal Hocko wrote:
> On Thu 21-04-22 14:42:13, Kent Overstreet wrote:
> > On Thu, Apr 21, 2022 at 11:18:20AM +0200, Michal Hocko wrote:
> [...]
> > > > 00177 16644 pages reserved
> > > > 00177 Unreclaimable slab info:
> > > > 00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
> > > > 00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
> > > > 00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
> > > > 00177 task_struct       total: 1.95 MiB active: 1.95 MiB
> > > > 00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
> > > > 00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
> > > > 00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
> > > > 00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
> > > > 00177 perf_event        total: 1.02 MiB active: 1.02 MiB
> > > > 00177 biovec-max        total: 992 KiB active: 960 KiB
> > > > 00177 Shrinkers:
> > > > 00177 super_cache_scan: objects: 127
> > > > 00177 super_cache_scan: objects: 106
> > > > 00177 jbd2_journal_shrink_scan: objects: 32
> > > > 00177 ext4_es_scan: objects: 32
> > > > 00177 bch2_btree_cache_scan: objects: 8
> > > > 00177   nr nodes:          24
> > > > 00177   nr dirty:          0
> > > > 00177   cannibalize lock:  0000000000000000
> > > > 00177 
> > > > 00177 super_cache_scan: objects: 8
> > > > 00177 super_cache_scan: objects: 1
> > > 
> > > How does this help to analyze this allocation failure?
> > 
> > You asked for an example of the output, which was an entirely reasonable
> > request. Shrinkers weren't responsible for this OOM, so it doesn't help here -
> 
> OK, do you have an example where it clearly helps?

I've debugged quite a few issues with shrinkers over the years where this would
have helped a lot (especially if it was also in sysfs), although nothing
currently. I was just talking with Dave earlier tonight about more things that
could be added for shrinkers, but I'm going to have to go over that conversation
again and take notes.

Also, I feel I have to point out that OOM & memory reclaim debugging is an area
where many filesystem developers feel that the MM people have been dropping the
ball, and your initial response to this patch series...  well, it feels like
more of the same.

Still does to be honest, you're coming across like I haven't been working in
this area for a decade+ and don't know what I'm touching. Really, I'm not new to
this stuff.

> > are you asking me to explain why shrinkers are relevant to OOMs and memory
> > reclaim...?
> 
> No, not really, I guess that is quite clear. The thing is that the oom
> report is quite bloated already and we should be rather picky on what to
> dump there. Your above example is a good one here. You have an order-5
> allocation failure and that can be caused by almost anything. Compaction
> not making progress for many reasons - e.g. internal framentation caused
> by pinned pages but also kmalloc allocations. The above output doesn't
> help with any of that. Could shrinkers operation be related? Of course
> it could but how can I tell?

Yeah sure and internal fragmentation would actually be an _excellent_ thing to
add to the show_mem report.

> We already dump slab data when the slab usage is excessive for the oom
> killer report and that was a very useful addition in many cases and it
> is bound to cases where slab consumption could be the primary source of
> the OOM condition.
> 
> That being said the additional output should be at least conditional and
> reported when there is a chance that it could help with analysis.

These things don't need to be conditional if we're more carefully selective
about how we report, instead of just dumping everything like we currently do
with slab info.

We don't need to report on all the slabs that are barely used - if you'll read
my patch and example output, which changes it to the top 10 slabs by memory
usage.

I feel like I keep repeating myself here. It would help if you would make more
of an effort to follow the full patch series and descriptions before commenting
generically.

> > Since shrinkers own and, critically, _are responsible for freeing memory_, a
> > shrinker not giving up memory when asked (or perhaps not being asked to give up
> > memory) can cause an OOM. A starting point - not an end - if we want to improve
> > OOM debugging is at least being able to see how much memory each shrinker owns.
> > Since we don't even have that, number of objects will have to do.
> > 
> > The reason for adding the .to_text() callback is that shrinkers have internal
> > state that affects whether they are able to give up objects when asked - the
> > primary example being object dirtyness.
> > 
> > If your system is using a ton of memory caching inodes, and something's wedged
> > writeback, and they're nearly all dirty - you're going to have a bad day.
> > 
> > The bcachefs btree node node shrinker included as an example of what we can do
> > with this: internally we may have to allocate new btree nodes by reclaiming from
> > our own cache, and we have a lock to prevent multiple threads from doing this at
> > the same time, and this lock also blocks the shrinker from freeing more memory
> > until we're done.
> > 
> > In filesystem land, debugging memory reclaim issues is a rather painful topic
> > that often comes up, this is a starting point...
> 
> I completely understand the frustration. I've been analyzing oom reports
> for years and I can tell that the existing report is quite good but
> in many cases the information we provide is still insufficient. My
> experience also tells me that those cases are usually very special and
> a specific data dumped for them wouldn't be all that useful in the
> majority of cases.
> 
> If we are lucky enough the oom is reproducible and additional
> tracepoints (or whatever your prefer to use) tell us more. Far from
> optimal, no question about that but I do not have a good answer on
> where the trashhold should really be. Maybe we can come up with some
> trigger based mechanism (e.g. some shrinkers are failing so they
> register their debugging data which will get dumped on the OOM) which
> would enable certain debugging information or something like that.

Why would we need a trigger mechanism?

Could you explain your objection to simply unconditionally dumping the top 10
slabs and the top 10 shrinkers?
