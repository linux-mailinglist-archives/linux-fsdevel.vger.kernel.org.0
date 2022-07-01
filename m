Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60915638E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGASDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGASDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967CBBC;
        Fri,  1 Jul 2022 11:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8D561510;
        Fri,  1 Jul 2022 18:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701D9C3411E;
        Fri,  1 Jul 2022 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698596;
        bh=vT02OD89nzqQeux3lU5PTLWSkuWwg2A4jl+fJzQTBiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpsbNbbk510jBveZFzWcSSjiVkKVJTicoM6YEoJBk1ulS2y1Tm3WhSS3AjU3/3CEo
         sSm10aAOqVaIibxwGEI9O/Kh2yDNotegPTfD+GIq3yR00W3ElFJnGfYVn45r4RIjGK
         3QWc83t6kxDPxlYSQ+MpMxRuZIdf29zjy3qHHXxvR4pyIqfviD9yEsgKMZ0UEXHKLj
         v2oyc5jQL7+RH9QJO7bAnBUKk+QZXFNIsvSIXfLf4PTujxMJBw0UNPz3celydwz1mP
         GxjzBUGBXVhbFpLTMHKfG6FVaMNyVfCU4+m45BrVPVYZy7GeK8UDfSBC7yj3bk7eqq
         we9fOVXFrFS3Q==
Date:   Fri, 1 Jul 2022 11:03:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <Yr824zvJevO8/HH4@magnolia>
References: <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
 <20220628221757.GJ227878@dread.disaster.area>
 <YruNE72sW4Aizq8U@magnolia>
 <YrxMOgIvKVe6u/uR@bfoster>
 <Yry0bkQRN4sGgTbf@magnolia>
 <Yr8ay3FJiL+7q0bW@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8ay3FJiL+7q0bW@bfoster>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:03:23PM -0400, Brian Foster wrote:
> On Wed, Jun 29, 2022 at 01:22:06PM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 29, 2022 at 08:57:30AM -0400, Brian Foster wrote:
> > > On Tue, Jun 28, 2022 at 04:21:55PM -0700, Darrick J. Wong wrote:
> > > > On Wed, Jun 29, 2022 at 08:17:57AM +1000, Dave Chinner wrote:
> > > > > On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > > > > > > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > > > > > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > > > > > > So using this technique, I've discovered that there's a dirty page
> > > > > > > > > accounting leak that eventually results in fsx hanging in
> > > > > > > > > balance_dirty_pages().
> > > > > > > > 
> > > > > > > > Alas, I think this is only an accounting error, and not related to
> > > > > > > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > > > > > > seeing is dirty pages being dropped at truncation without the
> > > > > > > > appropriate accounting.  ie this should be the fix:
> > > > > > > 
> > > > > > > Argh, try one that actually compiles.
> > > > > > 
> > > > > > ... that one's going to underflow the accounting.  Maybe I shouldn't
> > > > > > be writing code at 6am?
> > > > > > 
> > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > index f7248002dad9..4eec6ee83e44 100644
> > > > > > --- a/mm/huge_memory.c
> > > > > > +++ b/mm/huge_memory.c
> > > > > > @@ -18,6 +18,7 @@
> > > > > >  #include <linux/shrinker.h>
> > > > > >  #include <linux/mm_inline.h>
> > > > > >  #include <linux/swapops.h>
> > > > > > +#include <linux/backing-dev.h>
> > > > > >  #include <linux/dax.h>
> > > > > >  #include <linux/khugepaged.h>
> > > > > >  #include <linux/freezer.h>
> > > > > > @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > >  		__split_huge_page_tail(head, i, lruvec, list);
> > > > > >  		/* Some pages can be beyond EOF: drop them from page cache */
> > > > > >  		if (head[i].index >= end) {
> > > > > > -			ClearPageDirty(head + i);
> > > > > > -			__delete_from_page_cache(head + i, NULL);
> > > > > > +			struct folio *tail = page_folio(head + i);
> > > > > > +
> > > > > >  			if (shmem_mapping(head->mapping))
> > > > > >  				shmem_uncharge(head->mapping->host, 1);
> > > > > > -			put_page(head + i);
> > > > > > +			else if (folio_test_clear_dirty(tail))
> > > > > > +				folio_account_cleaned(tail,
> > > > > > +					inode_to_wb(folio->mapping->host));
> > > > > > +			__filemap_remove_folio(tail, NULL);
> > > > > > +			folio_put(tail);
> > > > > >  		} else if (!PageAnon(page)) {
> > > > > >  			__xa_store(&head->mapping->i_pages, head[i].index,
> > > > > >  					head + i, 0);
> > > > > > 
> > > > > 
> > > > > Yup, that fixes the leak.
> > > > > 
> > > > > Tested-by: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Four hours of generic/522 running is long enough to conclude that this
> > > > is likely the fix for my problem and migrate long soak testing to my
> > > > main g/522 rig and:
> > > > 
> > > > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > 
> > > Just based on Willy's earlier comment.. what I would probably be a
> > > little careful/curious about here is whether the accounting fix leads to
> > > an indirect behavior change that does impact reproducibility of the
> > > corruption problem. For example, does artificially escalated dirty page
> > > tracking lead to increased reclaim/writeback activity than might
> > > otherwise occur, and thus contend with the fs workload? Clearly it has
> > > some impact based on Dave's balance_dirty_pages() problem reproducer,
> > > but I don't know if it extends beyond that off the top of my head. That
> > > might make some sense if the workload is fsx, since that doesn't
> > > typically stress cache/memory usage the way a large fsstress workload or
> > > something might.
> > > 
> > > So for example, interesting questions might be... Do your corruption
> > > events happen to correspond with dirty page accounting crossing some
> > > threshold based on available memory in your test environment? Does
> > > reducing available memory affect reproducibility? Etc.
> > 
> > Yeah, I wonder that too now.  I managed to trace generic/522 a couple of
> > times before willy's patch dropped.  From what I could tell, a large
> > folio X would get page P assigned to the fsx file's page cache to cover
> > range R, dirtied, and written to disk.  At some point later, we'd
> > reflink into part of the file range adjacent to P, but not P itself.
> > I /think/ that should have caused the whole folio to get invalidated?
> > 
> > Then some more things happened (none of which dirtied R, according to
> > fsx) and then suddenly writeback would trigger on some page (don't know
> > which) that would write to the disk blocks backing R.  I'm fairly sure
> > that's where the incorrect disk contents came from.
> > 
> > Next, we'd reflink part of the file range including R into a different
> > part of the file (call it R2).  fsx would read R2, bringing a new page
> > into cache, and it wouldn't match the fsxgood buffer, leading to fsx
> > aborting.
> > 
> > After a umount/mount cycle, reading R and R2 would both reveal the
> > incorrect contents that had caused fsx to abort.
> > 
> 
> FWIW, I hadn't been able to reproduce this in my default environment to
> this point. With the memory leak issue in the light, I was eventually
> able to by reducing dirty_bytes to something the system would be more
> likely to hit sooner (i.e. 16-32MB), but I also see stalling behavior
> and whatnot due to the leak that requires backing off from the specified
> dirty limit every so often.
> 
> If I apply the accounting patch to avoid the leak and set
> dirty_background_bytes to something notably aggressive (1kB), the test
> survived 100 iterations or so before I stopped it. If I then set
> dirty_bytes to something similarly aggressive (1MB), I hit the failure
> on the next iteration (assuming it's the same problem). It's spinning
> again at ~25 or so iterations without a failure so far, so I'd have to
> wait and see how reliable the reproducer really is. Though if it doesn't
> reoccur soonish, perhaps I'll try reducing dirty_bytes a bit more...
> 
> My suspicion based on these characteristics would be that the blocking
> limit triggers more aggressive reclaim/invalidation, and thus helps
> detect the problem sooner. If reflink is involved purely as a cache
> invalidation step (i.e. so a subsequent read will hit the disk and
> detect a cache inconsistency), then it might be interesting to see if it
> can still be reproduced without reflink operations enabled but instead
> with some combination of the -f/-X fsx flags to perform more flush
> invals and on-disk data checks..

Hm.  I didn't try -f or lowering dirty_bytes, but with the reflink
operations disabled, g522 ran for 3 hours before I gave up and killed
it.  I would've thought that the fallocate zero/collapse/insert range
functions (which use the same flush/unmap helper) would have sufficed to
make the problem happen, but ... it didn't.

I think I'll try changing dirty_bytes next, to see if I can reproduce
the problem that way.  I'm not surprised that you had to set dirty_bytes
to 1MB, since 522 is only ever creating a 600K file anyway.

(Hopefully willy will be back next week to help us shed some light on
this.)

--D

> Brian
> 
> > Unfortunately the second ftrace attempt ate some trace data, so I was
> > unable to figure out if the same thing happened again.
> > 
> > At this point I really need to get on reviewing patches for 5.20, so
> > I'll try to keep poking at this (examining the trace data requires a lot
> > of concentration which isn't really possible while sawzall construction
> > is going on at home) but at worst I can ask Linus to merge a patch for
> > 5.19 final that makes setting mapping_set_large_folio a
> > Kconfig/CONFIG_XFS_DEBUG option.
> > 
> > --D
> > 
> > > 
> > > Brian
> > > 
> > > > --D
> > > > 
> > > > > Cheers,
> > > > > 
> > > > > Dave.
> > > > > -- 
> > > > > Dave Chinner
> > > > > david@fromorbit.com
> > > > 
> > > 
> > 
> 
