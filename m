Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4A47E566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbhLWPSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbhLWPSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:18:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EADCC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KXbYPtu6c4izulwkGYHyNy4v0pLcq0pJiP6IwBzT1BY=; b=dZsKdYlICJs6w6ZgnrzsjBjap0
        0YmUCN5iRmK8z01ycWdIlX1qVGfroYBjD+Gq5x+BTbGAY5+tUuicq/xCncIVjO6DCA63PxWzotinj
        69NNUqiiw4ZT/Hp0bcjOsOW1V4vQgtfxaKtINuqWuCt9zWrqfbMhP8OIhDFN+Jt8Z9qEtCrQEvUBO
        OZH2y/DBe5Rsj8GpHvDU8vpOenTpdfs1M4Vl1pQv2e4yaUZBQmDt94cxD9wfIRAqp9hl7kKFiI+zn
        xxkh28aDpHGr2QDKuMc3NCYmh5VK2jRnxPL1309SOlTb62BF+3z2iMBKKyVeRBEFyDdIDEpFDdiat
        wxO7krhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0PrW-004MpU-DL; Thu, 23 Dec 2021 15:18:34 +0000
Date:   Thu, 23 Dec 2021 15:18:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 25/48] filemap: Add read_cache_folio and
 read_mapping_folio
Message-ID: <YcSTSnTYINYgkMhJ@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-26-willy@infradead.org>
 <YcQlbjBKzMlGOLI7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQlbjBKzMlGOLI7@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:39:59AM +0100, Christoph Hellwig wrote:
> > thn makes up for the extra 100 bytes of text added to the various
> 
> s/thn/
> 
> >  	return read_cache_page(mapping, index, NULL, data);
> >  }
> >  
> > +static inline struct folio *read_mapping_folio(struct address_space *mapping,
> > +				pgoff_t index, void *data)
> > +{
> > +	return read_cache_folio(mapping, index, NULL, data);
> > +}
> 
> Is there much of a point in this wrapper?

Comparing read_mapping_page() vs read_cache_page(), 4 callers vs ~50.
It's definitely the preferred form, so I'd rather keep it.

> > +static struct page *do_read_cache_page(struct address_space *mapping,
> > +		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
> > +{
> > +	struct folio *folio = read_cache_folio(mapping, index, filler, data);
> > +	if (IS_ERR(folio))
> > +		return &folio->page;
> > +	return folio_file_page(folio, index);
> > +}
> 
> This drops the gfp on the floor.

Oops.  Will fix.
