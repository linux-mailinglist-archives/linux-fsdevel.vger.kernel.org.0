Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B728E546
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgJNRXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNRXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:23:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E71C061755;
        Wed, 14 Oct 2020 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQBp1EgPdtL8Qs4qso/PVo7/b/IICCiUCO43QNj5csk=; b=jYAg9SQ7tQ15WQe+RnGL6zYBtL
        tgy54wfcEdwvnj0O8zjNIqYOTd+WPnFIcipPJ+7KrF3EfQdC+BHI7eZqd7S+9rMfnyUclA/ov3xA6
        k0i8fN3Pyuc4HfAweaY/Mv08Fh01YiPQASiUlOlA16Xf9/bAPZjZtIsPJctmzmCjYhZRCuTPehcuj
        yOvR1g6LOMCU+BlHEgcw8rtkr48Xbf2qZFrCaICIESraZ0WVp6VYcIJdv7+9N5DCyo31/ePZ9znkb
        xdAD+lm2NDAmpaiDf1P1mgs9Evm/Bwadc69uRuCcUqLatAKAf7Pna1wcEXy1YTqMlWooOrexFIXbA
        A37aHkCw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSkUa-0004bk-QK; Wed, 14 Oct 2020 17:23:13 +0000
Date:   Wed, 14 Oct 2020 18:23:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/14] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20201014172312.GO20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-3-willy@infradead.org>
 <20201014161704.GF9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014161704.GF9832@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:17:04AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 14, 2020 at 04:03:45AM +0100, Matthew Wilcox (Oracle) wrote:
> > If the page is compound, check the last index in the page and return
> > the appropriate size.  Change the return type to ssize_t in case we ever
> > support pages larger than 2GB.
> 
> "But what about 16G pages?" :P

They're not practical with today's I/O limits; a x4 PCIe link running at
gen4 speeds will take 2 seconds to do 16GB of I/O.  Assuming doubling of PCIe
speeds every four years, and a reasonable latency of 0.1 seconds, we're
about fifteen years away from that being reasonable.  I'm sure this
code will have bitrotted by then and whoever tries to add support for
them will have work to do ...

> >  	/* page is wholly inside EOF */
> > -	if (page->index < index)
> > -		return PAGE_SIZE;
> > +	if (page->index + thp_nr_pages(page) - 1 < index)
> 
> Just curious, is this expression common enough to create a helper for
> that too?
> 
> #define thp_last_index(page) ((page)->index + thp_nr_pages(page) - 1) ?
> 
> (Maybe make that a static inline, I used a macro for brevity)

I had that in an earlier version and there were two callers, so I
took it out again because it was more effort to explain what it did
than it was to open-code it.
