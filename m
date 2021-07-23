Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3543D31F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 04:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhGWCAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 22:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhGWCAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:00:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03AC061575;
        Thu, 22 Jul 2021 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bvpCKyJPKQ+52VGiNWJJ88JT5lIx01OMRbRWDKPTqTM=; b=NXA5uHy4/Ittca66HSknUtfumF
        zTtO6XSGT1YO7UP6247R2NDdNion/+J6gNl8kGxNG4lMhKyn2bXw+IQAIGi+dBeKVZp4H/lxltCQk
        ZBBiqOBKlOkf2u8fyRsznnFfC2QTdjn0E6UNW1BiMN+9A8oEBXcoXcUsHnKMqg6mIhulHlS+dymml
        0lzzyUxAUC6WQt+DeIDwuMGSxYMY72hMHbxt6Rdnn3Z+7QWsc7ChWKZYdzmrN5+/A7C9tJ1jKqrSu
        q9PSi9ccXXrFy9+8g2YuWvxMltN4viVvE3phGqWQ3NNu+mQAX8zzJzCqNF8uzvc/B9nt6VPAzA0r0
        T20CUYGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6l6x-00Av3q-13; Fri, 23 Jul 2021 02:40:30 +0000
Date:   Fri, 23 Jul 2021 03:40:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Message-ID: <YPosG9HKRBt9+GUy@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-3-willy@infradead.org>
 <YPZxp6ZbRGYYBnYK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZxp6ZbRGYYBnYK@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:48:07AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 07:39:46PM +0100, Matthew Wilcox (Oracle) wrote:
> >  #define bio_for_each_bvec_all(bvl, bio, i)		\
> >  	for (i = 0, bvl = bio_first_bvec_all(bio);	\
> > -	     i < (bio)->bi_vcnt; i++, bvl++)		\
> > +	     i < (bio)->bi_vcnt; i++, bvl++)
> 
> Pleae split out this unrelated fixup.
> 
> > +static inline
> > +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> 
> Please fix the strange formatting.

static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
		int i)

> > +{
> > +	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> > +
> > +	fi->folio = page_folio(bvec->bv_page);
> > +	fi->offset = bvec->bv_offset +
> > +			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> 
> Can we have a little helper for the offset in folio calculation, like:
> 
> static inline size_t offset_of_page_in_folio(struct page *page)
> {
> 	return (bvec->bv_page - &page_folio(page)->page) * PAGE;
> }
> 
> as that makes the callers a lot easier to read.

I've spent most of today thinking about this one.  I actually don't
want to make this easy to read.  This is code that, in an ideal world,
would not exist.  A bio_vec should not contain a struct page; it should
probably be:

struct bio_vec {
	phys_addr_t bv_start;
	unsigned int bv_len;
};

and then the helper to get from a bio_vec to a folio_iter looks like:

	fi->folio = pfn_folio(bvec->bv_start >> PAGE_SHIFT);
	fi->offset = offset_in_folio(fi->folio, bvec->bv_start);

If instead we decide to keep bvecs the way they are, we can at
least turn the bv_page into bv_folio, and then we won't need this
code either.
