Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C89162786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBRN5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 08:57:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBRN5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jx8+RumY/EwaN3Vd/61tpY+Z1W663ztwfvZQrgDHUFQ=; b=rGfMPaIHAb3P6XbMGIvcdO+8rY
        sBmTkGPBJklVWdfNXRDuSKEjSq0AFVxR4igsRCNRWkLTSdZaPuKfDPGA85IxvS8KIcx7DFnTNZV6W
        BdpAM1dpoQIHKgx4dqZN2aRI0LWXjx8nIAWXYI687doAh4ldNBkXEkTVqekaKNY0CyubyWbqxE6M5
        Xg7Lryv3cm9nrFO31P1UJNHNA7wxuxRW2EtO7eKe5YABbDbdcnHZkGrigQTKXbiHgLY2umxIsSqvI
        Ual5Uy7fsYoF2dnMFCLJNX+0G4LlqI7WSviwe0Pg1FuWAxDtAWX90MWgUi414drJd5pYulG3q7dzP
        HhOcKxhQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j43NY-0000gx-Gn; Tue, 18 Feb 2020 13:57:36 +0000
Date:   Tue, 18 Feb 2020 05:57:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 04/19] mm: Rearrange readahead loop
Message-ID: <20200218135736.GP7778@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-5-willy@infradead.org>
 <20200218050824.GJ10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218050824.GJ10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:08:24PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:45:45AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Move the declaration of 'page' to inside the loop and move the 'kick
> > off a fresh batch' code to the end of the function for easier use in
> > subsequent patches.
> 
> Stale? the "kick off" code is moved to the tail of the loop, not the
> end of the function.

Braino; I meant to write end of the loop.

> > @@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
> >  		page = xa_load(&mapping->i_pages, page_offset);
> >  		if (page && !xa_is_value(page)) {
> >  			/*
> > -			 * Page already present?  Kick off the current batch of
> > -			 * contiguous pages before continuing with the next
> > -			 * batch.
> > +			 * Page already present?  Kick off the current batch
> > +			 * of contiguous pages before continuing with the
> > +			 * next batch.  This page may be the one we would
> > +			 * have intended to mark as Readahead, but we don't
> > +			 * have a stable reference to this page, and it's
> > +			 * not worth getting one just for that.
> >  			 */
> > -			if (readahead_count(&rac))
> > -				read_pages(&rac, &page_pool, gfp_mask);
> > -			rac._nr_pages = 0;
> > -			continue;
> > +			goto read;
> >  		}
> >  
> >  		page = __page_cache_alloc(gfp_mask);
> > @@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
> >  		if (page_idx == nr_to_read - lookahead_size)
> >  			SetPageReadahead(page);
> >  		rac._nr_pages++;
> > +		continue;
> > +read:
> > +		if (readahead_count(&rac))
> > +			read_pages(&rac, &page_pool, gfp_mask);
> > +		rac._nr_pages = 0;
> >  	}
> 
> Also, why? This adds a goto from branched code that continues, then
> adds a continue so the unbranched code doesn't execute the code the
> goto jumps to. In absence of any explanation, this isn't an
> improvement and doesn't make any sense...

I thought I was explaining it ... "for easier use in subsequent patches".
