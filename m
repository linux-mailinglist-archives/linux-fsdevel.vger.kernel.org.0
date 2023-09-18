Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880E7A54B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 23:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjIRVBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 17:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRVBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:01:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDC8E;
        Mon, 18 Sep 2023 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=voBKfQZlSDADh+zlNbJvfxsPTMGaXinYcSirNGGzkd0=; b=M/Arl4i6WiJle77w1QQn6+VleA
        lBDtkiwEESteehLSXPWBk77myXuQXJh1/FmrBhvOsjSLzm68FwYMBwlmKs4kjJCUOEVn4n+qqbWFq
        3ZuoYG8c2gUYaONx+gSqtkowVg5VvJxSW3boLib+EATWL4fuEwwUIikznFjAKRD75TX5GgXren73P
        B6U0xM2J5GdPI791k5IAxSJxzlv2paQP9NqWkaWiOMgo3fFpsf/crHldsmcR8IiDuHIQNgH7qxTZ3
        5sLGw9wioUFm4eirVNg4lMLRS8vtGQFrgPumy3B947qM4BzJjvYkR6HokkBQ9OSArSFZhgqx2/DcS
        /z4g2PBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiLMi-00DDZe-4o; Mon, 18 Sep 2023 21:01:08 +0000
Date:   Mon, 18 Sep 2023 22:01:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] block/buffer_head: introduce
 block_{index_to_sector,sector_to_index}
Message-ID: <ZQi6lAJL2lydVH4A@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-4-hare@suse.de>
 <ZQh8jXqpHFXQyEDT@casper.infradead.org>
 <4b8014fc-a71b-4e2f-a6a7-a5dc6a120f9e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8014fc-a71b-4e2f-a6a7-a5dc6a120f9e@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:42:51PM +0200, Hannes Reinecke wrote:
> On 9/18/23 18:36, Matthew Wilcox wrote:
> > On Mon, Sep 18, 2023 at 01:04:55PM +0200, Hannes Reinecke wrote:
> > > @@ -449,6 +450,22 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
> > >   bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
> > > +static inline sector_t block_index_to_sector(pgoff_t index, unsigned int blkbits)
> > > +{
> > > +	if (PAGE_SHIFT < blkbits)
> > > +		return (sector_t)index >> (blkbits - PAGE_SHIFT);
> > > +	else
> > > +		return (sector_t)index << (PAGE_SHIFT - blkbits);
> > > +}
> > 
> > Is this actually more efficient than ...
> > 
> > 	loff_t pos = (loff_t)index * PAGE_SIZE;
> > 	return pos >> blkbits;
> > 
> > It feels like we're going to be doing this a lot, so we should find out
> > what's actually faster.
> > 
> I fear that's my numerical computation background chiming in again.
> One always tries to worry about numerical stability, and increasing a number
> always risks of running into an overflow.
> But yeah, I guess your version is simpler, and we can always lean onto the
> compiler folks to have the compiler arrive at the same assembler code than
> my version.

I actually don't mind the additional complexity -- if it's faster.
Yours is a conditional, two subtractions and two shifts (dependent on
the result of the subtractions).  Mine is two shifts, the second
dependent on the first.

I would say mine is safe because we're talking about a file (or a bdev).
By definition, the byte offset into one of those fits into an loff_t,
although maybe not an unsigned long.

