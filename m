Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC79B3CB0FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhGPDP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 23:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhGPDPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:15:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E25AC06175F;
        Thu, 15 Jul 2021 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TRDya8wHWkJxj5dWxTTzT73+dIkTaai0safBwEJTM+0=; b=MwzLcqHYbmp3Z0BhM8fXff+86l
        k2Lkime2zcBMJsOr6pG++QI9XGFLoWMwdot/nq5BMizLvsKhnhG2J2LrkWjI/4ouZ6pCkg1FD5A6a
        wpUv/moDpYyoRAB5EIoKy1zZhc07/0qXFDwTYEF01LlF7dbGOY2DTNgLuV5cBNnb738mxNUncogxY
        uqMjDCavSPsUSKbva4hdobjPZpXKbTTWPMZoSiE71V6c3T/mly+Y8ujoGM8gOhWq67dvuLeVm470W
        9PzxCxuX5ofo6UMb10Xh0R95dHa7FnDT6K5tiFBhi60MGwdcknp8Ag9RgjFGm+BE/xZwZ3DE8MY6r
        suGyIuFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4EGN-0045sr-7Q; Fri, 16 Jul 2021 03:11:53 +0000
Date:   Fri, 16 Jul 2021 04:11:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 102/138] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YPD476gr7MWsaAyr@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-103-willy@infradead.org>
 <20210715215105.GM22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715215105.GM22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:51:05PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:28AM +0100, Matthew Wilcox (Oracle) wrote:
> > +static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
> > +		unsigned flags, struct folio **foliop, struct iomap *iomap,
> > +		struct iomap *srcmap)
> >  {
> >  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> > +	struct folio *folio;
> >  	struct page *page;
> > +	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> >  	int status = 0;
> >  
> >  	BUG_ON(pos + len > iomap->offset + iomap->length);
> > @@ -604,30 +605,31 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >  			return status;
> >  	}
> >  
> > -	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> > -			AOP_FLAG_NOFS);
> > -	if (!page) {
> > +	folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,
> 
> Ah, ok, so we're moving the file_get_pages flags up to iomap now.

Right, saves us having a folio equivalent of
grab_cache_page_write_begin().  And lets us get rid of AOP_FLAG_NOFS
eventually (although that really should be obsoleted by scoped
allocations, but one windmill at a time).

> > +	struct page *page = folio_file_page(folio, pos / PAGE_SIZE);
> 
> pos >> PAGE_SHIFT ?

mmm.  We're inconsistent:

willy@pepe:~/kernel/folio$ git grep '/ PAGE_SIZE' mm/ fs/ |wc
     92     720    6475
willy@pepe:~/kernel/folio$ git grep '>> PAGE_SHIFT' mm/ fs/ |wc
    635    4582   39394

That said, there's a clear preference.  It's just that we had a bug the
other day where somebody shifted by PAGE_SHIFT in the wrong direction ...
But again, this is your code, so I'll change to the shift.

