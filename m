Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF550B299
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 10:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445450AbiDVIGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445447AbiDVIGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:06:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2F52B27;
        Fri, 22 Apr 2022 01:03:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5AE171F37F;
        Fri, 22 Apr 2022 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650614618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3qrTUUWLOvzrr/LvAjd6a8Y59rvn8/Wc+U1lk05QeU=;
        b=lezFbrP5jGkD5FxlHMoOg8wXgSiLfy/5gq6TTTy2R2TZFRXeXA06xQoqefhXIN8v8styGd
        SRo633iF8muSmmcxUCxteH2OCl6zeIe/PN1s2b79RXRGoafkBzhXxQfXNJhleU6RcskcW+
        sKGZ0Lp4ujj/JxbGHWsxTZ4UUnlsN8w=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 146482C145;
        Fri, 22 Apr 2022 08:03:38 +0000 (UTC)
Date:   Fri, 22 Apr 2022 10:03:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-04-22 14:42:13, Kent Overstreet wrote:
> On Thu, Apr 21, 2022 at 11:18:20AM +0200, Michal Hocko wrote:
[...]
> > > 00177 16644 pages reserved
> > > 00177 Unreclaimable slab info:
> > > 00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
> > > 00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
> > > 00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
> > > 00177 task_struct       total: 1.95 MiB active: 1.95 MiB
> > > 00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
> > > 00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
> > > 00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
> > > 00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
> > > 00177 perf_event        total: 1.02 MiB active: 1.02 MiB
> > > 00177 biovec-max        total: 992 KiB active: 960 KiB
> > > 00177 Shrinkers:
> > > 00177 super_cache_scan: objects: 127
> > > 00177 super_cache_scan: objects: 106
> > > 00177 jbd2_journal_shrink_scan: objects: 32
> > > 00177 ext4_es_scan: objects: 32
> > > 00177 bch2_btree_cache_scan: objects: 8
> > > 00177   nr nodes:          24
> > > 00177   nr dirty:          0
> > > 00177   cannibalize lock:  0000000000000000
> > > 00177 
> > > 00177 super_cache_scan: objects: 8
> > > 00177 super_cache_scan: objects: 1
> > 
> > How does this help to analyze this allocation failure?
> 
> You asked for an example of the output, which was an entirely reasonable
> request. Shrinkers weren't responsible for this OOM, so it doesn't help here -

OK, do you have an example where it clearly helps?

> are you asking me to explain why shrinkers are relevant to OOMs and memory
> reclaim...?

No, not really, I guess that is quite clear. The thing is that the oom
report is quite bloated already and we should be rather picky on what to
dump there. Your above example is a good one here. You have an order-5
allocation failure and that can be caused by almost anything. Compaction
not making progress for many reasons - e.g. internal framentation caused
by pinned pages but also kmalloc allocations. The above output doesn't
help with any of that. Could shrinkers operation be related? Of course
it could but how can I tell?

We already dump slab data when the slab usage is excessive for the oom
killer report and that was a very useful addition in many cases and it
is bound to cases where slab consumption could be the primary source of
the OOM condition.

That being said the additional output should be at least conditional and
reported when there is a chance that it could help with analysis.

> Since shrinkers own and, critically, _are responsible for freeing memory_, a
> shrinker not giving up memory when asked (or perhaps not being asked to give up
> memory) can cause an OOM. A starting point - not an end - if we want to improve
> OOM debugging is at least being able to see how much memory each shrinker owns.
> Since we don't even have that, number of objects will have to do.
> 
> The reason for adding the .to_text() callback is that shrinkers have internal
> state that affects whether they are able to give up objects when asked - the
> primary example being object dirtyness.
> 
> If your system is using a ton of memory caching inodes, and something's wedged
> writeback, and they're nearly all dirty - you're going to have a bad day.
> 
> The bcachefs btree node node shrinker included as an example of what we can do
> with this: internally we may have to allocate new btree nodes by reclaiming from
> our own cache, and we have a lock to prevent multiple threads from doing this at
> the same time, and this lock also blocks the shrinker from freeing more memory
> until we're done.
> 
> In filesystem land, debugging memory reclaim issues is a rather painful topic
> that often comes up, this is a starting point...

I completely understand the frustration. I've been analyzing oom reports
for years and I can tell that the existing report is quite good but
in many cases the information we provide is still insufficient. My
experience also tells me that those cases are usually very special and
a specific data dumped for them wouldn't be all that useful in the
majority of cases.

If we are lucky enough the oom is reproducible and additional
tracepoints (or whatever your prefer to use) tell us more. Far from
optimal, no question about that but I do not have a good answer on
where the trashhold should really be. Maybe we can come up with some
trigger based mechanism (e.g. some shrinkers are failing so they
register their debugging data which will get dumped on the OOM) which
would enable certain debugging information or something like that.

-- 
Michal Hocko
SUSE Labs
