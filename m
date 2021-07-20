Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18FA3CF8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhGTKtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbhGTKtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:49:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B3C061574;
        Tue, 20 Jul 2021 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xwobaQb1FtoorAifNrC0a++DX1OpJJJuP0HyKXbWqhA=; b=IA0drOFdzBuCf7zMtH6jGnYe4F
        8NxuGbjbK/GULHIv6cd+cVYH8hswOu0zT3SiNG+22HJykBeYhBAT/+uWyh5IWdTcFjf97c3FEwyZG
        +jwx75VKQa5/TGTzRfnAT+naUV/7xM44KJuB4SpwkA6itmFIgNIJae03hsJdQMBIefexelL2s3hsN
        ISI1c10Yc8DQ9rByWrg3pd60FATbDePn+X7a/E3t7AlGouj5d+gQpqj6EuA0ELbAB9sQqFycWIepF
        BBILwrAxAW1hdUqx/TfJ7ti6X7EyoPi+1BGRx4sjUcZ3vJyRn0QLZGMsSwyRm4L+y5yaEhluGcGhx
        atgP0E5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5nwB-00838Q-Sk; Tue, 20 Jul 2021 11:29:31 +0000
Date:   Tue, 20 Jul 2021 12:29:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 05/17] iomap: Convert iomap_page_release to take a
 folio
Message-ID: <YPazk2wV2J8+3chJ@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-6-willy@infradead.org>
 <YPZyuyAQx9yqO9qV@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZyuyAQx9yqO9qV@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:52:43AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 07:39:49PM +0100, Matthew Wilcox (Oracle) wrote:
> > -static void
> > -iomap_page_release(struct page *page)
> > +static void iomap_page_release(struct folio *folio)
> >  {
> > -	struct iomap_page *iop = detach_page_private(page);
> > -	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> > +	struct iomap_page *iop = folio_detach_private(folio);
> > +	unsigned int nr_blocks = i_blocks_per_folio(folio->mapping->host,
> > +							folio);
> 
> Nit: but I find this variant much easier to read:
> 
> 	unsigned int nr_blocks =
> 		i_blocks_per_folio(folio->mapping->host, folio);

Probably even better ...

	struct inode *inode = folio->mapping->host;
	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
