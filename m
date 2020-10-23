Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01B529734D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750170AbgJWQNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 12:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373717AbgJWQNi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:13:38 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDEA2192A;
        Fri, 23 Oct 2020 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603469617;
        bh=/ugoQvKytjJzXG/Kbb2JDR2nd8GjaKFnEc+uATegcgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QU7QOnDRejIe6hqRjlNvnd8pU7ZbE1ZRNS1/1KB8kKLqV57EGXJp2Q4umUksX6p7
         PVV7MqAvf8x7rLUp5SRwKYFYXKsMB2Rs8E95KkHPNcF49HuaQr/E9CKSs3ZyIkVYlU
         2f/dJRujw0qyF6kCou9bgUI1lWD7SD+5C3Ef7a3E=
Date:   Fri, 23 Oct 2020 09:13:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: Convert block_read_full_page to be synchronous
Message-ID: <20201023161335.GB3908702@gmail.com>
References: <20201022212228.15703-1-willy@infradead.org>
 <20201022212228.15703-4-willy@infradead.org>
 <20201022234011.GD3613750@gmail.com>
 <20201023132138.GB20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023132138.GB20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:21:38PM +0100, Matthew Wilcox wrote:
> > 
> > The following is needed to set the bio encryption context for the
> > '-o inlinecrypt' case on ext4:
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 95c338e2b99c..546a08c5003b 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2237,6 +2237,7 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
> >  			submit_bio(bio);
> >  		}
> >  		bio = bio_alloc(GFP_NOIO, 1);
> > +		fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
> >  		bio_set_dev(bio, bh->b_bdev);
> >  		bio->bi_iter.bi_sector = sector;
> >  		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
> 
> Thanks!  I saw that and had every intention of copying it across.
> And then I forgot.  I'll add that.  I'm also going to do:
> 
> -                           __bio_try_merge_page(bio, bh->b_page, bh->b_size,
> -                                       bh_offset(bh), &same_page))
> +                           bio_add_page(bio, bh->b_page, bh->b_size,
> +                                       bh_offset(bh)))
> 
> I wonder about allocating bios that can accommodate more bvecs.  Not sure
> how often filesystems have adjacent blocks which go into non-adjacent
> sub-page blocks.  It's certainly possible that a filesystem might have
> a page consisting of DDhhDDDD ('D' for Data, 'h' for hole), but how
> likely is it to have written the two data chunks next to each other?
> Maybe with O_SYNC?
> 

I think that's a rare case that's not very important to optimize.  And there's
already a lot of code where filesystems *could* submit a single bio in that case
but don't.  For example, both fs/direct-io.c and fs/iomap/direct-io.c only
submit bios that contain logically contiguous data.

If you do implement this optimization, note that it wouldn't work when a
bio_crypt_ctx is set, since the data must be logically contiguous in that case.
To handle that you'd need to call fscrypt_mergeable_bio_bh() when adding each
block, and submit the bio if it returns false.  (In contrast, with your current
proposal, calling fscrypt_mergeable_bio_bh() isn't necessary because each bio
only contains logically contiguous data within one page.)

- Eric
