Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AB29FA35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJ3BDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3BDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:03:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD5C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 18:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3EfAuOnJDJ1asoS3XB1gO2rZ1Iw2AXrfYkZ/147UKcA=; b=bOx6jDmwzjm+7h+IY4yU/vO6HE
        3JSN06lyqqujRfsTWcR75VgxRXFcgGImLDtI3mWJn53y7FmPteP4qp4nWPn1t76EfFPM1Sva9fAEH
        fsDks6jtR4QfvUV5yAbPTGGXUX/fzcYiqbZkTJ7BcP1iG8Sdu5yATjorI9y+eXa9TE9as5LQWht8c
        xBIk6OUd5juk6/eHITUdbvBniET0GYfHPTubpuvNeckchwvT7YT5IysfarbGfTV5Yuj3yzStfYODC
        q31XdClzEQ398oJA5YiXxMZ0J27XKqJ7rtSHslszMbZIxv65j5BYhlQicOBaAIqfV92Tzx0Nsa3Lf
        kTlkzMEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYIou-0003mL-Sz; Fri, 30 Oct 2020 01:03:09 +0000
Date:   Fri, 30 Oct 2020 01:03:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/19] mm/filemap: Use head pages in
 generic_file_buffered_read
Message-ID: <20201030010308.GF27442@casper.infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-8-willy@infradead.org>
 <20201030001909.GC2123636@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030001909.GC2123636@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:19:09PM -0400, Kent Overstreet wrote:
> On Thu, Oct 29, 2020 at 07:33:53PM +0000, Matthew Wilcox (Oracle) wrote:
> > Add mapping_get_read_heads() which returns the head pages which
> > represent a contiguous array of bytes in the file.  It also stops
> > when encountering a page marked as Readahead or !Uptodate (but
> > does return that page) so it can be handled appropriately by
> > gfbr_get_pages().
> 
> I don't like the _heads naming - this is like find_get_pages_contig() except it
> returns compound pages instead of single pages, and the naming should reflect
> that. And, working with compound pages should be the default in the future -
> code working with individual pages should be considered a code smell in the
> future, i.e. find_get_pages() et. all. should be considered deprecated.

You're right.  It should just be called mapping_get_(something)_thps.

> Also - you're implementing new core functionality with a pecularity of the read
> path, the two probably be split out. Perhaps find_get_cpages (compound_pages)
> that can also be passed a stop condition.

It isn't clear to me _how_ to do that, so in the absence of that obvious,
I decided to implement what we need right now, and we can figure out how
to abstract it later.

So until we have a better idea, I'm going with "read" for the (something)
above.

> > +			if (writably_mapped) {
> > +				int j;
> > +
> > +				for (j = 0; j < thp_nr_pages(page); j++)
> > +					flush_dcache_page(page + j);
> > +			}
> 
> this should be a new helper

Good point.  One flush_dcache_thp() coming right up!
