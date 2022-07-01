Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6938563A0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGAT3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGAT3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:29:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5A12A9C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 12:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D035B831A5
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F80C3411E;
        Fri,  1 Jul 2022 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656703696;
        bh=FH4brdONAm4m/QU5pplePcNhLbuVfcTsYPctqeS0lTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brtn1eJOpzfeib/0lgE09+ABpEZdRQ1IrY4RtfRgaqQkpY9SJiR3bgmV7FzCbHX2D
         isieVX/RYeWsxfRSkM2wfA2DvmFxMdM+xs/CKvgWEbHrhqWl56zgIaiHNhp0KnoFZX
         kY8hN1YejnIGML/jr6ycLR0Yek4CaH7j+fLNfWd9cryJTAYf3esPHKKYklPEldnZMS
         56cS+XixDKRMV+iuncOd9BbBQP+6f5H691mrW+xB4p/KaXAsD2M5vzQtxeaND9me2B
         wGCE9In7ND568XXm1rzimk0pTO6LqHQy7LWHaYhGN0QIrQyYFuSsOHUkzkqGZ2GmKy
         GQ3QEDg/bv+pw==
Date:   Fri, 1 Jul 2022 13:28:13 -0600
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
Message-ID: <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9GNfmeO/xCjzD4@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr9GNfmeO/xCjzD4@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:08:37PM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 12:38:36PM -0600, Keith Busch wrote:
> > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > -	if (size > 0)
> > > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > >  	if (unlikely(size <= 0))
> > >  		return size ? size : -EFAULT;
> > > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> > >  
> > > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > 
> > We still need to return EFAULT if size becomes 0 because that's the only way
> > bio_iov_iter_get_pages()'s loop will break out in this condition.
> 
> I really don't like these calling conventions ;-/

No argument here; I'm just working in the space as I found it. :)
 
> What do you want to happen if we have that align-down to reduce size?
> IOW, what should be the state after that loop in the caller?

We fill up the bio to bi_max_vecs. If there are more pages than vectors, then
the bio is submitted as-is with the partially drained iov_iter. The remainder
of the iov is left for a subsequent bio to deal with.

The ALIGN_DOWN is required because I've replaced the artificial kernel aligment
with the underlying hardware's alignment. The hardware's alignment is usually
smaller than a block size. If the last bvec has a non-block aligned offset,
then it has to be truncated down, which could result in a 0 size when bi_vcnt
is already non-zero. If that happens, we just submit the bio as-is, and
allocate a new one to deal with the rest of the iov.
