Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4E47E47E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348813AbhLWOWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 09:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348809AbhLWOWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:22:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D653C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9rXZLYcPFrczYMK7u+QWj33Y06uzQ/T0+vv+Pk6PyLY=; b=Wt3daIStnfTHmAYw/0I18D/FRs
        +vhd1/l3n65yU8BfiIPKsjsWHGb8aXBdrxd4+jSgJledfDyjmFg8LwAp5nfy3PSb78NbKhS0p0/tl
        fMMyMd6K214+yzsFxDwosY4b0kWf8/hWuIjwvCwQnH/KHK81KAVldVXe1/3icshxwcYZKGGV8tpZv
        Hk+0ZWU4SDMli1lykKWpJOXZaw8Oxk7m15iNQCrCbrQsl35k7dpOQmJ+2U0/yBzxwwRZ+29Ul2G51
        7avS3HSFenqgAYTlG0UenJHZNFL1MdLYNioKwBnIeBdRT9hhHOyyps79k+ETFxzz6Gy1sjgDwAHVj
        Mrugj+NQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0OzS-004KcT-1Q; Thu, 23 Dec 2021 14:22:42 +0000
Date:   Thu, 23 Dec 2021 14:22:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/48] iov_iter: Add copy_folio_to_iter()
Message-ID: <YcSGMof2I6GRWYBi@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-7-willy@infradead.org>
 <YcQdWKCGHK5dZfWz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQdWKCGHK5dZfWz@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:55:20PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 08, 2021 at 04:22:14AM +0000, Matthew Wilcox (Oracle) wrote:
> > +static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
> > +		size_t bytes, struct iov_iter *i)
> > +{
> > +	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
> > +}
> 
> I think we had this 2 or three series ago, but these open coded casts
> are a bad idea.  I think we need a proper and well documented helper for
> them.

I don't want to see casts between folio & page in most code, but I think
having it in this kind of helper is fine.  It literally exists in order
to document that the callee handles folios correctly.
