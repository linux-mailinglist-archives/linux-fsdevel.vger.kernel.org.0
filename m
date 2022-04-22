Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ADF50B405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445985AbiDVJaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiDVJaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:30:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9275046A;
        Fri, 22 Apr 2022 02:27:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8E9921F37F;
        Fri, 22 Apr 2022 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650619626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mtpfE3HniUKfj6fmPxze6Iw4oOnUTvCkmygkgqHEeJE=;
        b=AvUKHkFcaLWUzkPSZEFfFUSzLy89wwjkyfuckUn+IrfMv3XNM1BmEa7vbcEa2FKmNvXeRo
        b21zD6zjzGj6vtE80qxr7QtHdukVeUW5f4G9Cs6V+w0OklqeBzLPr0ewHMd4nAWWxW/bbx
        s3ILLVJTl4XM2+63tqAzJyqVB/fciwI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 404F82C142;
        Fri, 22 Apr 2022 09:27:06 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:27:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <YmJ06cEyX2u4DGtD@dhcp22.suse.cz>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
 <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
 <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 22-04-22 04:30:37, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 10:03:36AM +0200, Michal Hocko wrote:
> > On Thu 21-04-22 14:42:13, Kent Overstreet wrote:
> > > On Thu, Apr 21, 2022 at 11:18:20AM +0200, Michal Hocko wrote:
> > [...]
> > > > > 00177 16644 pages reserved
> > > > > 00177 Unreclaimable slab info:
> > > > > 00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
> > > > > 00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
> > > > > 00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
> > > > > 00177 task_struct       total: 1.95 MiB active: 1.95 MiB
> > > > > 00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
> > > > > 00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
> > > > > 00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
> > > > > 00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
> > > > > 00177 perf_event        total: 1.02 MiB active: 1.02 MiB
> > > > > 00177 biovec-max        total: 992 KiB active: 960 KiB
> > > > > 00177 Shrinkers:
> > > > > 00177 super_cache_scan: objects: 127
> > > > > 00177 super_cache_scan: objects: 106
> > > > > 00177 jbd2_journal_shrink_scan: objects: 32
> > > > > 00177 ext4_es_scan: objects: 32
> > > > > 00177 bch2_btree_cache_scan: objects: 8
> > > > > 00177   nr nodes:          24
> > > > > 00177   nr dirty:          0
> > > > > 00177   cannibalize lock:  0000000000000000
> > > > > 00177 
> > > > > 00177 super_cache_scan: objects: 8
> > > > > 00177 super_cache_scan: objects: 1
> > > > 
> > > > How does this help to analyze this allocation failure?
> > > 
> > > You asked for an example of the output, which was an entirely reasonable
> > > request. Shrinkers weren't responsible for this OOM, so it doesn't help here -
> > 
> > OK, do you have an example where it clearly helps?
> 
> I've debugged quite a few issues with shrinkers over the years where this would
> have helped a lot (especially if it was also in sysfs), although nothing
> currently. I was just talking with Dave earlier tonight about more things that
> could be added for shrinkers, but I'm going to have to go over that conversation
> again and take notes.
> 
> Also, I feel I have to point out that OOM & memory reclaim debugging is an area
> where many filesystem developers feel that the MM people have been dropping the
> ball, and your initial response to this patch series...  well, it feels like
> more of the same.

Not sure where you get that feeling. Debugging memory reclaim is a PITA
because many problems can be indirect and tools we have available are
not really great. I do not remember MM people would be blocking useful
debugging tools addition.
 
> Still does to be honest, you're coming across like I haven't been working in
> this area for a decade+ and don't know what I'm touching. Really, I'm not new to
> this stuff.

I am sorry to hear that but there certainly is no intention like that
and TBH I do not even see where you get that feeling. You have posted a
changelog which doesn't explain really much. I am aware that you are far
from a kernel newbie and therefore I would really expect much more in
that regards.

> > > are you asking me to explain why shrinkers are relevant to OOMs and memory
> > > reclaim...?
> > 
> > No, not really, I guess that is quite clear. The thing is that the oom
> > report is quite bloated already and we should be rather picky on what to
> > dump there. Your above example is a good one here. You have an order-5
> > allocation failure and that can be caused by almost anything. Compaction
> > not making progress for many reasons - e.g. internal framentation caused
> > by pinned pages but also kmalloc allocations. The above output doesn't
> > help with any of that. Could shrinkers operation be related? Of course
> > it could but how can I tell?
> 
> Yeah sure and internal fragmentation would actually be an _excellent_ thing to
> add to the show_mem report.

Completely agreed. The only information we currently have is the
buddyinfo part which reports movability status but I do not think this
is remotely sufficient.

[...]

> > If we are lucky enough the oom is reproducible and additional
> > tracepoints (or whatever your prefer to use) tell us more. Far from
> > optimal, no question about that but I do not have a good answer on
> > where the trashhold should really be. Maybe we can come up with some
> > trigger based mechanism (e.g. some shrinkers are failing so they
> > register their debugging data which will get dumped on the OOM) which
> > would enable certain debugging information or something like that.
> 
> Why would we need a trigger mechanism?

Mostly because reasons for reclaim failures can vary a lot and the oom
report part doesn't have an idea what has happened during the
reclaim/compaction.

> Could you explain your objection to simply unconditionally dumping the top 10
> slabs and the top 10 shrinkers?

We already do that in some form. We dump unreclaimable slabs if they
consume more memory than user pages on LRUs. We also dump all slab
caches with some objects. Why is this approach not good? Should we tweak
the condition to dump or should we limit the dump? These are reasonable 
questions to ask. Your patch has dropped those without explaining any
of the motivation.

I am perfectly OK to modify should_dump_unreclaim_slab to dump even if
the slab memory consumption is lower. Also dumping small caches with
handful of objects can be excessive.

Wrt to shrinkers I really do not know what kind of shrinkers data would
be useful to dump and when. Therefore I am asking about examples.
-- 
Michal Hocko
SUSE Labs
