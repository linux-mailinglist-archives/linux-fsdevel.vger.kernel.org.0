Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E8560AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiF2UWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2UWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:22:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777232F39D;
        Wed, 29 Jun 2022 13:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CE74B82701;
        Wed, 29 Jun 2022 20:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BDEC34114;
        Wed, 29 Jun 2022 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656534127;
        bh=fvM7ZMw2Riiyy+rC8yD5Hs0887tFPszfGYW0/LXaWfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5xyov45v0ccCJ1IxlXGAtOz0PLoK/zebDjvrlZx9wn+a2UJEu8uwQ1j2Lr0kmqxN
         Tnw9Np6W699I9p5LTM5u6FD1UMEpV1gRiDRSn2T/CyhnDy9vBruEH6y7E3i8M0xP6t
         C5t3O6eWH7ETdiiSIbiO5OrCLtbGq6IBsUskxEPzZN8NyZnJ1A6pPH++fBkS2uAn8F
         0rpdHSluLb+ddTvJk4blbbN25jH7s9JekC00yHjBPs1NkhBJByQRbiIgE+Uu3wFHQb
         GQsxdAmCDxXn5FI8ZOQreulWGtoPBroIArSqS2EEq4x17z6xZA8p9onh/VKK+v5whL
         iL1StzTNq7nOA==
Date:   Wed, 29 Jun 2022 13:22:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <Yry0bkQRN4sGgTbf@magnolia>
References: <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
 <20220628221757.GJ227878@dread.disaster.area>
 <YruNE72sW4Aizq8U@magnolia>
 <YrxMOgIvKVe6u/uR@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrxMOgIvKVe6u/uR@bfoster>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:57:30AM -0400, Brian Foster wrote:
> On Tue, Jun 28, 2022 at 04:21:55PM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 29, 2022 at 08:17:57AM +1000, Dave Chinner wrote:
> > > On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> > > > On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > > > > So using this technique, I've discovered that there's a dirty page
> > > > > > > accounting leak that eventually results in fsx hanging in
> > > > > > > balance_dirty_pages().
> > > > > > 
> > > > > > Alas, I think this is only an accounting error, and not related to
> > > > > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > > > > seeing is dirty pages being dropped at truncation without the
> > > > > > appropriate accounting.  ie this should be the fix:
> > > > > 
> > > > > Argh, try one that actually compiles.
> > > > 
> > > > ... that one's going to underflow the accounting.  Maybe I shouldn't
> > > > be writing code at 6am?
> > > > 
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index f7248002dad9..4eec6ee83e44 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <linux/shrinker.h>
> > > >  #include <linux/mm_inline.h>
> > > >  #include <linux/swapops.h>
> > > > +#include <linux/backing-dev.h>
> > > >  #include <linux/dax.h>
> > > >  #include <linux/khugepaged.h>
> > > >  #include <linux/freezer.h>
> > > > @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > >  		__split_huge_page_tail(head, i, lruvec, list);
> > > >  		/* Some pages can be beyond EOF: drop them from page cache */
> > > >  		if (head[i].index >= end) {
> > > > -			ClearPageDirty(head + i);
> > > > -			__delete_from_page_cache(head + i, NULL);
> > > > +			struct folio *tail = page_folio(head + i);
> > > > +
> > > >  			if (shmem_mapping(head->mapping))
> > > >  				shmem_uncharge(head->mapping->host, 1);
> > > > -			put_page(head + i);
> > > > +			else if (folio_test_clear_dirty(tail))
> > > > +				folio_account_cleaned(tail,
> > > > +					inode_to_wb(folio->mapping->host));
> > > > +			__filemap_remove_folio(tail, NULL);
> > > > +			folio_put(tail);
> > > >  		} else if (!PageAnon(page)) {
> > > >  			__xa_store(&head->mapping->i_pages, head[i].index,
> > > >  					head + i, 0);
> > > > 
> > > 
> > > Yup, that fixes the leak.
> > > 
> > > Tested-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Four hours of generic/522 running is long enough to conclude that this
> > is likely the fix for my problem and migrate long soak testing to my
> > main g/522 rig and:
> > 
> > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > 
> 
> Just based on Willy's earlier comment.. what I would probably be a
> little careful/curious about here is whether the accounting fix leads to
> an indirect behavior change that does impact reproducibility of the
> corruption problem. For example, does artificially escalated dirty page
> tracking lead to increased reclaim/writeback activity than might
> otherwise occur, and thus contend with the fs workload? Clearly it has
> some impact based on Dave's balance_dirty_pages() problem reproducer,
> but I don't know if it extends beyond that off the top of my head. That
> might make some sense if the workload is fsx, since that doesn't
> typically stress cache/memory usage the way a large fsstress workload or
> something might.
> 
> So for example, interesting questions might be... Do your corruption
> events happen to correspond with dirty page accounting crossing some
> threshold based on available memory in your test environment? Does
> reducing available memory affect reproducibility? Etc.

Yeah, I wonder that too now.  I managed to trace generic/522 a couple of
times before willy's patch dropped.  From what I could tell, a large
folio X would get page P assigned to the fsx file's page cache to cover
range R, dirtied, and written to disk.  At some point later, we'd
reflink into part of the file range adjacent to P, but not P itself.
I /think/ that should have caused the whole folio to get invalidated?

Then some more things happened (none of which dirtied R, according to
fsx) and then suddenly writeback would trigger on some page (don't know
which) that would write to the disk blocks backing R.  I'm fairly sure
that's where the incorrect disk contents came from.

Next, we'd reflink part of the file range including R into a different
part of the file (call it R2).  fsx would read R2, bringing a new page
into cache, and it wouldn't match the fsxgood buffer, leading to fsx
aborting.

After a umount/mount cycle, reading R and R2 would both reveal the
incorrect contents that had caused fsx to abort.

Unfortunately the second ftrace attempt ate some trace data, so I was
unable to figure out if the same thing happened again.

At this point I really need to get on reviewing patches for 5.20, so
I'll try to keep poking at this (examining the trace data requires a lot
of concentration which isn't really possible while sawzall construction
is going on at home) but at worst I can ask Linus to merge a patch for
5.19 final that makes setting mapping_set_large_folio a
Kconfig/CONFIG_XFS_DEBUG option.

--D

> 
> Brian
> 
> > --D
> > 
> > > Cheers,
> > > 
> > > Dave.
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
> > 
> 
