Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A83D2790
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGVPr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGVPr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:47:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A46C061575;
        Thu, 22 Jul 2021 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8MEr16L96bOGxKrBhIZgt0+SVG6JvQfAHW+MYTYylcg=; b=TvzNICZHhKg2kYETwRHyWEfnsD
        0Q5CTsjrbOdcDGY5Aj2GY+TFn74s9evoKF+nWwUzYL6y7BtpAO5Rk6ahQ/O9yibmq6/7rCHtKWUE3
        Ae4bGBfntW5q38OZhHG9qq75GtELL5yvYheJHNl1kGhuLZy/ugbt7znISS/btweBZoq09iHzz8PGW
        0NJ59+DUKVi6ZPG2wqarhgJDbEHhfl2VvnB0QSpwp92k2CVqpQEkKxcjO1e6hZRLSh8XgbHoK3IWx
        a7G1cNScVd3ocXuWqkOH62nFRKfOIkxLZIr/g1HKUzcV+/y+RZJ997NN6BcY1y42oTgqIGFAZWizg
        G4OyOANQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6bXr-00AR4t-C2; Thu, 22 Jul 2021 16:27:42 +0000
Date:   Thu, 22 Jul 2021 17:27:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <YPmcd29EBU7s+/LY@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
 <YPZwODMq1ilIeS4t@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZwODMq1ilIeS4t@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 07:42:00AM +0100, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 07:39:45PM +0100, Matthew Wilcox (Oracle) wrote:
> > +/**
> > + * bio_add_folio - Attempt to add part of a folio to a bio.
> > + * @bio: Bio to add to.
> > + * @folio: Folio to add.
> > + * @len: How many bytes from the folio to add.
> > + * @off: First byte in this folio to add.
> > + *
> > + * Always uses the head page of the folio in the bio.  If a submitter only
> > + * uses bio_add_folio(), it can count on never seeing tail pages in the
> > + * completion routine.  BIOs do not support folios that are 4GiB or larger.
> > + *
> > + * Return: The number of bytes from this folio added to the bio.
> > + */
> > +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> > +		size_t off)
> > +{
> > +	if (len > UINT_MAX || off > UINT_MAX)
> > +		return 0;
> > +	return bio_add_page(bio, &folio->page, len, off);
> > +}
> 
> I'd use the opportunity to switch to a true/false return instead of
> the length.  This has been on my todo list for bio_add_page for a while,
> so it might make sense to start out the new API the right way.

Looking at it with fresh eyes, I decided to rewrite the docs too.
ie this:

 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
- * @bio: Bio to add to.
+ * @bio: BIO to add to.
  * @folio: Folio to add.
  * @len: How many bytes from the folio to add.
  * @off: First byte in this folio to add.
  *
- * Always uses the head page of the folio in the bio.  If a submitter only
- * uses bio_add_folio(), it can count on never seeing tail pages in the
- * completion routine.  BIOs do not support folios that are 4GiB or larger.
+ * Filesystems that use folios can call this function instead of calling
+ * bio_add_page() for each page in the folio.  If @off is bigger than
+ * PAGE_SIZE, this function can create a bio_vec that starts in a page
+ * after the bv_page.  BIOs do not support folios that are 4GiB or larger.
  *
- * Return: The number of bytes from this folio added to the bio.
+ * Return: Whether the addition was successful.
  */
-size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
                size_t off)
 {
        if (len > UINT_MAX || off > UINT_MAX)
                return 0;
-       return bio_add_page(bio, &folio->page, len, off);
+       return bio_add_page(bio, &folio->page, len, off) > 0;
 }

(i decided to go with > 0 so it's impervious to when you change
bio_add_page())
