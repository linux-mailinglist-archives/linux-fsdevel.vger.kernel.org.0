Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036AA56398B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGATIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGATIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:08:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96BA3A721
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dxovQmNiTE5o7nUeGHP2iETQFkJ4h48SBo1it3vB12U=; b=Ku8ECqJ0+4KWN1s1IzawE1jzl5
        RgBVPfmT46SQRL3BGQU/kzwSs3FpFXVioRjyrPlbXvOgFRHeqWPTYlQVVcixsqcBs+aupZG6WyV1n
        bvI25dFJumYGDLM3Gp2Tnm/+oVOvhQwdYzjz7NtunLIaGgoT1+7EtwWCP3gX0/EONs3NeQExA8UDp
        /j6K/wozogT5BASTSz3NVjJti/C42JOtgEgKsri3VsnojzcoHqWNF1xzMto4rmvI1rOmumoMUk8pD
        K/E6GQ8DKJVQdp+hajSfFoApsBJLDG98FctAo9UUshXVAxrHbgh+Bsxrd75WD2ZdiXHS9cFb2kaYJ
        f7e6urKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7M0L-0075bF-Nf;
        Fri, 01 Jul 2022 19:08:37 +0000
Date:   Fri, 1 Jul 2022 20:08:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr9GNfmeO/xCjzD4@ZenIV>
References: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:38:36PM -0600, Keith Busch wrote:
> On Fri, Jul 01, 2022 at 07:12:17PM +0100, Al Viro wrote:
> > On Fri, Jul 01, 2022 at 07:07:45PM +0100, Al Viro wrote:
> > > > page we got before would be leaked since unused pages are only released on an
> > > > add_page error. I was about to reply with a patch that fixes this, but here's
> > > > the one that I'm currently testing:
> > > 
> > > AFAICS, result is broken; you might end up consuming some data and leaving
> > > iterator not advanced at all.  With no way for the caller to tell which way it
> > > went.
> 
> I think I see what you mean, though the issue with a non-advancing iterator on
> a partially filled bio was happening prior to this patch.
> 
> > How about the following?
> 
> This looks close to what I was about to respond with. Just a couple issues
> below:
> 
> > -static void bio_put_pages(struct page **pages, size_t size, size_t off)
> > -{
> > -	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> > -
> > -	for (i = 0; i < nr; i++)
> > -		put_page(pages[i]);
> > -}
> > -
> >  static int bio_iov_add_page(struct bio *bio, struct page *page,
> >  		unsigned int len, unsigned int offset)
> >  {
> > @@ -1211,6 +1203,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	ssize_t size, left;
> >  	unsigned len, i;
> >  	size_t offset;
> > +	int ret;
> 
> 'ret' might never be initialized if 'size' aligns down to 0.

Point.

> >  	/*
> >  	 * Move page array up in the allocated memory for the bio vecs as far as
> > @@ -1228,14 +1221,13 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	 * the iov data will be picked up in the next bio iteration.
> >  	 */
> >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > -	if (size > 0)
> > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> >  	if (unlikely(size <= 0))
> >  		return size ? size : -EFAULT;
> > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> >  
> > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> 
> We still need to return EFAULT if size becomes 0 because that's the only way
> bio_iov_iter_get_pages()'s loop will break out in this condition.

I really don't like these calling conventions ;-/

What do you want to happen if we have that align-down to reduce size?
IOW, what should be the state after that loop in the caller?
