Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B23B3529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFXSFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:05:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BABC061574;
        Thu, 24 Jun 2021 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hLMjV/v2VMW7OPL88d4Rhvuc3mEsgbM4ADked1xlhzM=; b=OHOaogABad5RWlFl/ORqOrRUMA
        6yixELjA4e+dg38K3YPau19P+odwDhSWSG+qmbCPbwYiRZ3HIhAZQ5X03bQDB1SwYpuHCixP6ORDz
        KjT0AoFb4c3AF29QUH8h1rkjqTo8JIT8cA7Oh+xIRDxp9tPJiwkmJ+/FT8dea8X5pURKDHWFotm1R
        G1RnJKz6e4505XgtMZP+oGax3wRNI9x/xKE9EB+JIkCg1qveEVTabu3d67pZaEcDz9LWNsqEafOR6
        y+f9RoW1k1regH8wqMs4WXj0jrtC35rr/h3QutwKT09E7j1EwX/U+ya407u56/cDvERSQKYeG014N
        /ixOAgNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwTgF-00GqhW-Dz; Thu, 24 Jun 2021 18:02:25 +0000
Date:   Thu, 24 Jun 2021 19:02:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/46] mm/migrate: Add folio_migrate_copy()
Message-ID: <YNTIr/UGVrTOZD3f@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-21-willy@infradead.org>
 <YNLyNJupwcDdj0ZG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLyNJupwcDdj0ZG@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:35:00AM +0200, Christoph Hellwig wrote:
> > +void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
> >  {
> > +	unsigned int i = folio_nr_pages(folio) - 1;
> >  
> > +	copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
> > +	while (i-- > 0) {
> > +		cond_resched()a
> > +		/* folio_page() handles discontinuities in memmap */
> > +		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
> > +	}
> > +
> 
> What is the advantage of copying backwards here to start with?

Easier to write the loop this way?  I suppose we could do it as ...

	unsigned int i, nr = folio_nr_pages(folio);

	for (i = 0; i < nr; i++) {
		/* folio_page() handles discontinuities in memmap */
		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
		cond_resched();
	}

I'm not really bothered.  As long as we don't call folio_nr_pages() for
each iteration of the loop ... I've actually been wondering about
marking that as __pure, but I don't quite have the nerve to do it yet.
