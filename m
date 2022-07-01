Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB756393E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiGASip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 14:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGASio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:38:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE03275E8
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 11:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7B30B8315D
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 18:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48F5C3411E;
        Fri,  1 Jul 2022 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656700720;
        bh=9fWZiD9K9cdBgqEM5Re/cNJ4U2m82/ffqJTgyWLYcP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgHxBQjrsaUPCu02kqTmLxUgxW8Qps/shjgT7a8P6Cmi6+QyzyjT4jG4KKXNHCufI
         WyuS/tGbxTsVKsVyfbfTJlvtE+Zol1YuFA0NY6FTtB2xfGWpxCQp48da2tdfkTfg5S
         P9zlNOwFBtJsMb5eewFespOwWS8MoRBup3tE4IuyVuAnaackKM56dTirgMZP3GKznG
         UHTMTs1eEBtwPMTc35tNgdLXtE2vrxS5H9vg4n+FzDLRhBOH97wBpUI9DS8Wgb+b9J
         b/MCAIxX8xuagKqV8Ff/kwOyNhwqnChfibGyNE0B3iRV/pnIFW0aoNSUe7Rx1eEf/E
         EylIbzIB0B6eQ==
Date:   Fri, 1 Jul 2022 12:38:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr85AaNqNAEr+5ve@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 07:12:17PM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 07:07:45PM +0100, Al Viro wrote:
> > > page we got before would be leaked since unused pages are only released on an
> > > add_page error. I was about to reply with a patch that fixes this, but here's
> > > the one that I'm currently testing:
> > 
> > AFAICS, result is broken; you might end up consuming some data and leaving
> > iterator not advanced at all.  With no way for the caller to tell which way it
> > went.

I think I see what you mean, though the issue with a non-advancing iterator on
a partially filled bio was happening prior to this patch.

> How about the following?

This looks close to what I was about to respond with. Just a couple issues
below:

> -static void bio_put_pages(struct page **pages, size_t size, size_t off)
> -{
> -	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> -
> -	for (i = 0; i < nr; i++)
> -		put_page(pages[i]);
> -}
> -
>  static int bio_iov_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int offset)
>  {
> @@ -1211,6 +1203,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	ssize_t size, left;
>  	unsigned len, i;
>  	size_t offset;
> +	int ret;

'ret' might never be initialized if 'size' aligns down to 0.

>  	/*
>  	 * Move page array up in the allocated memory for the bio vecs as far as
> @@ -1228,14 +1221,13 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> -	if (size > 0)
> -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
> +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
>  
> +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));

We still need to return EFAULT if size becomes 0 because that's the only way
bio_iov_iter_get_pages()'s loop will break out in this condition.
