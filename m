Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09E666BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjALHpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjALHpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:45:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B84F11C;
        Wed, 11 Jan 2023 23:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nzHwDouomVyJ1c2Xw2OmNpBzQCQzZ9c6gVs9Afvw21w=; b=FHDgptf0MVXGgvN8JRjPHW4mwO
        9VktTKVNgQtpjlgnlU329Q7w4wEfSqeFdW8G7yJeFZ2vD75A+RozPc1g/dnN8JkUiyJCjFWV4z5K3
        FlF4ptPBLr0Yy663pFCBkijZClpz1e0PIgRnIaodBpATojP1Taz+NKyfCTToZ+gI56ON1H6Bv1C1o
        kKoMDngV1VO8Y8O8g1FZImh6INXEUvsm0Ceq1P6RQIo4I2ne/CZbaVpKYfhayi6GPInKv4k1e83U4
        vK/Baciq/VnRW6otFY+jVzHhIwAl2+xCVw7qlDEbR0cIRE2zg6NCvfBagRIGdvOwV1RRzlmSHEJak
        EC30yyng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFsGH-00E2Fv-E2; Thu, 12 Jan 2023 07:44:33 +0000
Date:   Wed, 11 Jan 2023 23:44:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <Y7+6YVkhZsvdW+Hr@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:28:35PM +0000, David Howells wrote:
> [!] Note that this is tested a bit with ext4, but nothing else.

You probably want to also at least test it with block device I/O
as that is a slightly different I/O path from iomap.  More file systems
also never hurt, but aren't quite as important.

> +/*
> + * Clean up a page appropriately, where the page may be pinned, may have a
> + * ref taken on it or neither.
> + */
> +static void bio_release_page(struct bio *bio, struct page *page)
> +{
> +	if (bio_flagged(bio, BIO_PAGE_PINNED))
> +		unpin_user_page(page);
> +	if (bio_flagged(bio, BIO_PAGE_REFFED))
> +		put_page(page);
> +}
> +
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct bvec_iter_all iter_all;
> @@ -1183,7 +1197,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>  		if (mark_dirty && !PageCompound(bvec->bv_page))
>  			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +		bio_release_page(bio, bvec->bv_page);

So this does look correc an sensible, but given that the new pin/unpin
path has a significantly higher overhead I wonder if this might be a
good time to switch to folios here as soon as possible in a follow on
patch.


> +	size = iov_iter_extract_pages(iter, &pages,
> +				      UINT_MAX - bio->bi_iter.bi_size,
> +				      nr_pages, gup_flags,
> +				      &offset, &cleanup_mode);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  
> +	bio_clear_flag(bio, BIO_PAGE_REFFED);
> +	bio_clear_flag(bio, BIO_PAGE_PINNED);
> +	if (cleanup_mode & FOLL_GET)
> +		bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (cleanup_mode & FOLL_PIN)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);

The flags here must not change from one invocation to another, so
clearing and resetting them on every iteration seems dangerous.

This should probably be a:

	if (cleanup_mode & FOLL_GET) {
		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED));
		bio_set_flag(bio, BIO_PAGE_REFFED);
	}
	if (cleanup_mode & FOLL_PIN) {
		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_REFFED));
		bio_set_flag(bio, BIO_PAGE_PINNED);
	}
