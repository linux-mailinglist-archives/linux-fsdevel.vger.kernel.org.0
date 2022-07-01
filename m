Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29BF563989
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGATF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGATF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD738BDC
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 12:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F1CB61DD4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 19:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D6BC3411E;
        Fri,  1 Jul 2022 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656702356;
        bh=3BAJ92aaUMi64BTem8R6V8/YJZDAPplsurW4xxw+alw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hW2AajXG3UvJQCbBI72svzLKcFGsN8tFSqtztgTXzBFjblATFVn6OESsMvfdZEXaA
         xeEX2UCCNYPeWC09MA9VVn+tPfyfDWPkLwVTsR0hOTTBLN/r54G1ivfvc4k4tZTtN9
         l43P3dANkw0SnlKrrJOuDWNaPROUG/7Jyjs9ud6TQiXKPu5rSuovOCX1WPU2neZgnZ
         pvDbwdJDw0O9tqrj4MpJe1UOuU1A02OOiy3hy4LwOV1jX32RwFIplUJkgiWaTxGDw+
         GE7/jHQoSc/y3xnIcr3ZfbUf8qCCZhhkq+q3BQ941uTlXeqdJE5eabWahmLHX0VBPy
         OssecHan1sfNA==
Date:   Fri, 1 Jul 2022 13:05:52 -0600
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
Message-ID: <Yr9FkKL2Iw3emaBP@kbusch-mbp.dhcp.thefacebook.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr838ci8FUsiZlSW@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 07:07:45PM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 11:53:44AM -0600, Keith Busch wrote:
> > On Fri, Jul 01, 2022 at 06:40:40PM +0100, Al Viro wrote:
> > > -static void bio_put_pages(struct page **pages, size_t size, size_t off)
> > > -{
> > > -	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> > > -
> > > -	for (i = 0; i < nr; i++)
> > > -		put_page(pages[i]);
> > > -}
> > > -
> > >  static int bio_iov_add_page(struct bio *bio, struct page *page,
> > >  		unsigned int len, unsigned int offset)
> > >  {
> > > @@ -1228,11 +1220,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >  	 * the iov data will be picked up in the next bio iteration.
> > >  	 */
> > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > -	if (size > 0)
> > > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > >  	if (unlikely(size <= 0))
> > >  		return size ? size : -EFAULT;
> > > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> > >  
> > > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > 
> > This isn't quite right. The result of the ALIGN_DOWN could be 0, so whatever
> > page we got before would be leaked since unused pages are only released on an
> > add_page error. I was about to reply with a patch that fixes this, but here's
> > the one that I'm currently testing:
> 
> AFAICS, result is broken; you might end up consuming some data and leaving
> iterator not advanced at all.  With no way for the caller to tell which way it
> went.

Looks like the possibility of a non-advancing iterator goes all the way back to
the below commit.

  commit 576ed9135489c723fb39b97c4e2c73428d06dd78
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Thu Sep 20 08:28:21 2018 +0200

      block: use bio_add_page in bio_iov_iter_get_pages

I guess the error condition never occured, and nor should it if the bio's
available vectors is accounted for correctly.
