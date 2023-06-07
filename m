Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53D5726522
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjFGPzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbjFGPzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:55:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AE1FE8;
        Wed,  7 Jun 2023 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W9J/3jLih2dwfzpWikLR8B9yjir80x6pybkiXAXQV1I=; b=GhgOGCsJPuVsNSDLQIk8IAtPWo
        dRgLJLJUEXoOU/N9fupFHQDWphxLKEbX7AnzKF8fendagu26cff7CPBKKfsWTTh6GDqQVYFUgITad
        pxn7Unr2WVk4Iwt9V9tfcSBVN1DcOC0s//htzIbM6fHPuGwp2yRihozqo71t2c8Rd2d6K5SqHvAvl
        TrIyvT06Csd2Zx4H0E36LyoyXadhbHaaG+BJ5RQKF04DNBA1VXCc/58Itm+oMFjUZBeXj21U5W9uI
        QrDq7+oDyoGmHrykPlQR6VnU0RUFP7BzVS9XS2qpOgC3pBFRA06UHsPfkA8ZwEDzSttmRV8Hyts12
        pQCRBxYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6vVA-00EPEW-0t; Wed, 07 Jun 2023 15:55:12 +0000
Date:   Wed, 7 Jun 2023 16:55:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Message-ID: <ZICoXy5TEgSy0yFr@casper.infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
 <ZH0MDtoTyUMQ7eok@casper.infradead.org>
 <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
 <ZH91+QWd3k8a2x/Z@casper.infradead.org>
 <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:21:41AM +0800, Yin Fengwei wrote:
> On 6/7/23 02:07, Matthew Wilcox wrote:
> > +++ b/lib/iov_iter.c
> > @@ -857,24 +857,36 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
> >  }
> >  EXPORT_SYMBOL(iov_iter_zero);
> >  
> > -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> > -				  struct iov_iter *i)
> > +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> > +		size_t bytes, struct iov_iter *i)
> >  {
> > -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
> > -	if (!page_copy_sane(page, offset, bytes)) {
> > -		kunmap_atomic(kaddr);
> > +	size_t n = bytes, copied = 0;
> > +
> > +	if (!page_copy_sane(page, offset, bytes))
> >  		return 0;
> > -	}
> > -	if (WARN_ON_ONCE(!i->data_source)) {
> > -		kunmap_atomic(kaddr);
> > +	if (WARN_ON_ONCE(!i->data_source))
> >  		return 0;
> > +
> > +	page += offset / PAGE_SIZE;
> > +	offset %= PAGE_SIZE;
> > +	if (PageHighMem(page))
> > +		n = min_t(size_t, bytes, PAGE_SIZE);
> This is smart.

Thanks ;-)

> > +	while (1) {
> > +		char *kaddr = kmap_atomic(page) + offset;
> > +		iterate_and_advance(i, n, base, len, off,
> > +			copyin(kaddr + off, base, len),
> > +			memcpy_from_iter(i, kaddr + off, base, len)
> > +		)
> > +		kunmap_atomic(kaddr);
> > +		copied += n;
> > +		if (!PageHighMem(page) || copied == bytes || n == 0)
> > +			break;
> My understanding is copied == bytes could cover !PageHighMem(page).

It could!  But the PageHighMem test serves two purposes.  One is that
it tells the human reader that this is all because of HighMem.  The
other is that on !HIGHMEM systems it compiles to false:

PAGEFLAG_FALSE(HighMem, highmem)

static inline int Page##uname(const struct page *page) { return 0; }

So it tells the _compiler_ that all of this code is ignorable and
it can optimise it out.  Now, you and I know that it will always
be true, but it lets the compiler remove the test.  Hopefully the
compiler can also see that:

	while (1) {
		...
		if (true)
			break;
	}

means it can optimise away the entire loop structure and just produce
the same code that it always did.
