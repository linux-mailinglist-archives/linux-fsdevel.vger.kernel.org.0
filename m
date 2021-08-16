Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A3ECCAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhHPCgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:36:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524EC061764;
        Sun, 15 Aug 2021 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vMl2VNdGk09tKhD3GllFTX36GUewTvfnz70jPsRuisE=; b=I3HcwZSzqquYk2qrb9TMsXbbdU
        OFiZRP8wFNRyufteckPxWtUxpKV1lJeMBslJpcH1rVMm6iV61ZJ7PjM/Fjylv67sH3QLhnLTgIVwA
        hhGdH08VdNX20AFLVNGNjTVN22axpgchV23w17JTqVdUD4QtYs+acCcY3SUlb5zRhw7ijpKwboajS
        KdPL7lDSSchtlK3+6lgG/9dfDpgKabc5CPbVcSfsKSvR4JggPgobfdgZUS2noRgb9tqn1mVy1rRHX
        ba9T8YGprwqE8WRX0sY+72or6f3XnESvJhl5QM4yVFhsXVkMZNkh2omwaOBbc//tlkDHGljqrnowE
        B4hTnZsw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFST8-000sTw-Bg; Mon, 16 Aug 2021 02:35:28 +0000
Date:   Mon, 16 Aug 2021 03:35:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 084/138] mm/page_alloc: Add folio allocation functions
Message-ID: <YRnO5gudWRvGjxW4@casper.infradead.org>
References: <20210715033704.692967-85-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1814546.1628632283@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1814546.1628632283@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:51:23PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > +struct folio *folio_alloc(gfp_t gfp, unsigned order)
> > +{
> > +	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > +
> > +	if (page && order > 1)
> > +		prep_transhuge_page(page);
> 
> Ummm...  Shouldn't order==1 pages (two page folios) be prep'd also?

No.  The deferred list is stored in the second tail page, so there's
nowhere to store one if there are only two pages.

The free_transhuge_page() dtor only handles the deferred list, so
it's fine to skip setting the DTOR in the page too.

> Would it be better to just jump to alloc_pages() if order <= 1?  E.g.:
> 
> struct folio *folio_alloc(gfp_t gfp, unsigned order)
> {
> 	struct page *page;
> 
> 	if (order <= 1)
> 		return (struct folio *)alloc_pages(gfp | __GFP_COMP, order);
> 
> 	page = alloc_pages(gfp | __GFP_COMP, order);
> 	if (page)
> 		prep_transhuge_page(page);
> 	return (struct folio *)page;
> }

That doesn't look simpler to me?
