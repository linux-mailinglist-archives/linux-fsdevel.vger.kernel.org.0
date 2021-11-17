Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F952454B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhKQRKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhKQRKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:10:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E404C615A4;
        Wed, 17 Nov 2021 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637168828;
        bh=Ta2Z5YSxnkVBMPA4KSpYfpVT/Yv/HAz/kPMqYKYr4+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfSq71CkGosAbNkmI6HVgisrrydgCrpMaHZc922ZNyCED4CEcViCFhh/x/o+fsIkz
         mGr5I0ltF5Ft0iMGDP4H79uzgeM4L/EJBIX4MKvgWQbBFJyQcG+YFm+ZN5bYnjZEjy
         qZRM/wxjp81ftnjLXpwmuQbbewXz3f7FfsKQKoTyKuouaEpzJXiSf/6MGsyrWu1vhv
         CWXxjcVgt9sIpentJn/rE13FB1HqAlHa80+ksDB3sHFadtaQVA9MsqJ8eu8uG4b7ck
         tnlGBJ3pO+p6Lqti3AK0TkK0GHvO8zwmk6KUPcqgbQXktfk01OL30j6gMcCgLF3bGM
         y7L1aseORhrCw==
Date:   Wed, 17 Nov 2021 09:07:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <20211117170707.GW24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
 <20211117044527.GO24307@magnolia>
 <YZUMhDDHott2Q4W+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZUMhDDHott2Q4W+@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:07:00PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 16, 2021 at 08:45:27PM -0800, Darrick J. Wong wrote:
> > > +/**
> > > + * folio_zero_segment() - Zero a byte range in a folio.
> > > + * @folio: The folio to write to.
> > > + * @start: The first byte to zero.
> > > + * @end: One more than the last byte in the first range.
> > > + */
> > > +static inline void folio_zero_segment(struct folio *folio,
> > > +		size_t start, size_t end)
> > > +{
> > > +	zero_user_segments(&folio->page, start, end, 0, 0);
> > > +}
> > > +
> > > +/**
> > > + * folio_zero_range() - Zero a byte range in a folio.
> > > + * @folio: The folio to write to.
> > > + * @start: The first byte to zero.
> > > + * @length: The number of bytes to zero.
> > > + */
> > > +static inline void folio_zero_range(struct folio *folio,
> > > +		size_t start, size_t length)
> > > +{
> > > +	zero_user_segments(&folio->page, start, start + length, 0, 0);
> > 
> > At first I thought "Gee, this is wrong, end should be start+length-1!"
> > 
> > Then I looked at zero_user_segments and realized that despite the
> > parameter name "endi1", it really wants you to tell it the next byte.
> > Not the end byte of the range you want to zero.
> > 
> > Then I looked at the other two new functions and saw that you documented
> > this, and now I get why Linus ranted about this some time ago.
> > 
> > The code looks right, but the "end" names rankle me.  Can we please
> > change them all?  Or at least in the new functions, if you all already
> > fought a flamewar over this that I'm not aware of?
> 
> Change them to what?  I tend to use 'end' to mean 'excluded end' and
> 'max' to mean 'included end'.  What would you call the excluded end?

I've started using 'next', or changing the code to make 'end' be the
last element in the range the caller wants to act upon.  The thing is,
those are all iterators, so 'next' fits, whereas it doesn't fit so well
for range zeroing where that might have been all the zeroing we wanted
to do.

Though.  'xend' (shorthand for 'excluded end') is different enough to
signal that the reader should pay attention.  Ok, how about xend then?

--D
