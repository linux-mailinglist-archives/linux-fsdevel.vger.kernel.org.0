Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60B6163667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBRWsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:48:33 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57094 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726556AbgBRWsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:48:32 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D144F7E9387;
        Wed, 19 Feb 2020 09:48:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4BfJ-0003lA-7e; Wed, 19 Feb 2020 09:48:29 +1100
Date:   Wed, 19 Feb 2020 09:48:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 04/19] mm: Rearrange readahead loop
Message-ID: <20200218224829.GU10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-5-willy@infradead.org>
 <20200218050824.GJ10776@dread.disaster.area>
 <20200218135736.GP7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218135736.GP7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=alOI8opFAFPe2SRtgw8A:9
        a=xQkswpi2j_EUEYvS:21 a=GSRXKHwoUNCfdhKr:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:57:36AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:08:24PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:45AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Move the declaration of 'page' to inside the loop and move the 'kick
> > > off a fresh batch' code to the end of the function for easier use in
> > > subsequent patches.
> > 
> > Stale? the "kick off" code is moved to the tail of the loop, not the
> > end of the function.
> 
> Braino; I meant to write end of the loop.
> 
> > > @@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		page = xa_load(&mapping->i_pages, page_offset);
> > >  		if (page && !xa_is_value(page)) {
> > >  			/*
> > > -			 * Page already present?  Kick off the current batch of
> > > -			 * contiguous pages before continuing with the next
> > > -			 * batch.
> > > +			 * Page already present?  Kick off the current batch
> > > +			 * of contiguous pages before continuing with the
> > > +			 * next batch.  This page may be the one we would
> > > +			 * have intended to mark as Readahead, but we don't
> > > +			 * have a stable reference to this page, and it's
> > > +			 * not worth getting one just for that.
> > >  			 */
> > > -			if (readahead_count(&rac))
> > > -				read_pages(&rac, &page_pool, gfp_mask);
> > > -			rac._nr_pages = 0;
> > > -			continue;
> > > +			goto read;
> > >  		}
> > >  
> > >  		page = __page_cache_alloc(gfp_mask);
> > > @@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		if (page_idx == nr_to_read - lookahead_size)
> > >  			SetPageReadahead(page);
> > >  		rac._nr_pages++;
> > > +		continue;
> > > +read:
> > > +		if (readahead_count(&rac))
> > > +			read_pages(&rac, &page_pool, gfp_mask);
> > > +		rac._nr_pages = 0;
> > >  	}
> > 
> > Also, why? This adds a goto from branched code that continues, then
> > adds a continue so the unbranched code doesn't execute the code the
> > goto jumps to. In absence of any explanation, this isn't an
> > improvement and doesn't make any sense...
> 
> I thought I was explaining it ... "for easier use in subsequent patches".

Sorry, my braino there. :) I commented on the problem with the first
part of the sentence, then the rest of the sentence completely
failed to sink in.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
