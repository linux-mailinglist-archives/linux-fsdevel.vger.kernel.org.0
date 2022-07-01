Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA554563A26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiGATnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGATnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:43:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B430543
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IxdwlTDLWlmsjaJWSfdyEKGi2RD0YVgUP3oISvT+vK8=; b=rBp47I7SmaHFie63GC3IWKgOXu
        PDkmY3GvkWUyHnKn8xi6gEeByKLrf+Fu4To+GVyHuUAuSzQJNlc9alEXSSkdV+2Agj1d2bmDJlAUJ
        8LVpJ+3yPKDjESuAMAIh0XruB0P8GEpr8DqkxHQoTC0gJQJmnifKtqy89a293Q535F2k3X6+72Omm
        QkqWibtTCaTaRiFJXVu7GTv0uC0lumPCMAGppkLU4Gf4vpWnpAPsXO7eF7I5y0cteNqtFXW7yM33N
        cXkwMrPQkJf1cuY2Jhlkx89qWm3TpBggFBebASaqPx5MxfwCSVs0fRPXTdNCh9GAhTtkW96XWHsSt
        GZzZrexg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7MY8-0076MA-Oq;
        Fri, 01 Jul 2022 19:43:33 +0000
Date:   Fri, 1 Jul 2022 20:43:32 +0100
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
Message-ID: <Yr9OZJ9Usn24XYFG@ZenIV>
References: <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9GNfmeO/xCjzD4@ZenIV>
 <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:28:13PM -0600, Keith Busch wrote:
> On Fri, Jul 01, 2022 at 08:08:37PM +0100, Al Viro wrote:
> > On Fri, Jul 01, 2022 at 12:38:36PM -0600, Keith Busch wrote:
> > > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > > -	if (size > 0)
> > > > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > > >  	if (unlikely(size <= 0))
> > > >  		return size ? size : -EFAULT;
> > > > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> > > >  
> > > > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > > 
> > > We still need to return EFAULT if size becomes 0 because that's the only way
> > > bio_iov_iter_get_pages()'s loop will break out in this condition.
> > 
> > I really don't like these calling conventions ;-/
> 
> No argument here; I'm just working in the space as I found it. :)
>  
> > What do you want to happen if we have that align-down to reduce size?
> > IOW, what should be the state after that loop in the caller?
> 
> We fill up the bio to bi_max_vecs. If there are more pages than vectors, then
> the bio is submitted as-is with the partially drained iov_iter. The remainder
> of the iov is left for a subsequent bio to deal with.
> 
> The ALIGN_DOWN is required because I've replaced the artificial kernel aligment
> with the underlying hardware's alignment. The hardware's alignment is usually
> smaller than a block size. If the last bvec has a non-block aligned offset,
> then it has to be truncated down, which could result in a 0 size when bi_vcnt
> is already non-zero. If that happens, we just submit the bio as-is, and
> allocate a new one to deal with the rest of the iov.

Wait a sec.  Looks like you are dealing with the round-down in the wrong place -
it applies to the *total* you've packed into the bio, no matter how it is
distributed over the segments you've gathered it from.  Looks like it would
be more natural to handle it after the loop in the caller, would it not?

I.e.
	while bio is not full
		grab pages
		if got nothing
			break
		pack pages into bio
		if can't add a page (bio_add_hw_page() failure)
			drop the ones not shoved there
			break
	see how much had we packed into the sucker
	if not a multiple of logical block size
		trim the bio, dropping what needs to be dropped
		iov_iter_revert()
	if nothing's packed
		return -EINVAL if it was a failed bio_add_hw_page()
		return -EFAULT otherwise
	return 0
