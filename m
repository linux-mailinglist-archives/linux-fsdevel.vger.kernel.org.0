Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C490B14E702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 03:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgAaCRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 21:17:07 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38268 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbgAaCRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:17:06 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 936E23A2BDF;
        Fri, 31 Jan 2020 13:17:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ixLrh-0006P1-9m; Fri, 31 Jan 2020 13:17:01 +1100
Date:   Fri, 31 Jan 2020 13:17:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/12] btrfs: Convert from readpages to readahead
Message-ID: <20200131021701.GB18575@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-7-willy@infradead.org>
 <20200129004609.GI18610@dread.disaster.area>
 <20200130080939.GL6615@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130080939.GL6615@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=-ZxxmdGvqcmE25f44t8A:9
        a=WA9dXB9HyJ0bNApb:21 a=s0uptFhnqMGzMIq5:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:09:39AM -0800, Matthew Wilcox wrote:
> On Wed, Jan 29, 2020 at 11:46:09AM +1100, Dave Chinner wrote:
> > On Fri, Jan 24, 2020 at 05:35:47PM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Use the new readahead operation in btrfs
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: linux-btrfs@vger.kernel.org
> > > ---
> > >  fs/btrfs/extent_io.c | 15 ++++-----------
> > >  fs/btrfs/extent_io.h |  2 +-
> > >  fs/btrfs/inode.c     | 18 +++++++++---------
> > >  3 files changed, 14 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 2f4802f405a2..b1e2acbec165 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -4283,7 +4283,7 @@ int extent_writepages(struct address_space *mapping,
> > >  	return ret;
> > >  }
> > >  
> > > -int extent_readpages(struct address_space *mapping, struct list_head *pages,
> > > +unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
> > >  		     unsigned nr_pages)
> > >  {
> > >  	struct bio *bio = NULL;
> > > @@ -4294,20 +4294,13 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
> > >  	int nr = 0;
> > >  	u64 prev_em_start = (u64)-1;
> > >  
> > > -	while (!list_empty(pages)) {
> > > +	while (nr_pages) {
> > >  		u64 contig_end = 0;
> > >  
> > > -		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
> > > -			struct page *page = lru_to_page(pages);
> > > +		for (nr = 0; nr < ARRAY_SIZE(pagepool) && nr_pages--;) {
> > 
> > What is stopping nr_pages from going negative here, and then looping
> > forever on the outer nr_pages loop? Perhaps "while(nr_pages > 0) {"
> > would be better there?
> 
> Ugh, nr_pages is unsigned, so that's no good.  Maybe make this a more
> conventional loop ...
> 
>         while (nr_pages) {
>                 u64 contig_end = 0;
> 
>                 for (nr = 0; nr < ARRAY_SIZE(pagepool); nr++) {
>                         struct page *page = readahead_page(mapping, start++);
> 
>                         prefetchw(&page->flags);
>                         pagepool[nr] = page;
>                         contig_end = page_offset(page) + PAGE_SIZE - 1;
>                         if (--nr_pages == 0)
>                                 break;
>                 }

Looks like it solves the problem :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
