Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE52FAA0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436982AbhARTYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393913AbhARTVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:21:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB1C061573;
        Mon, 18 Jan 2021 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nWdAqrKpHwStjMb4MOxxBLcvUal39JAh+aD9BrJhEC8=; b=tiHjWhh7AFgG5KkRIsekZ2HmNE
        7tDitIlMhlQbgFB0ZeBDt+8j4YsA2u/UZSLUF0e1jL7fFYRTdfTd5P5NMW7JrKQ6hLCLT14lkJoXq
        5pOWJYjG9RfHwAmk/SW6tl4o1B+5HgjbbN4wcXl65YcrB/gSmyTugixpxpBvXGJupNFPkdXdXok15
        7uGiYRLjMmTydOXiArEl+2hnUMeW/skj9RlUj4DlAxw745Yk3hNcf6r1cnLurgYEV3ZSJBsADqNOW
        OqT6rrpgliEE5HOUV1ZG3a5yctXctLrbX0Lmf6QfXfQJsXKPhWJf6uTykzAQ+EhkVnYF387535k5X
        GXGzpyKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1a52-00DHn6-MF; Mon, 18 Jan 2021 19:20:50 +0000
Date:   Mon, 18 Jan 2021 19:20:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, 'Jens Axboe ' <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210118192048.GF2260413@casper.infradead.org>
References: <20210114194706.1905866-1-willy@infradead.org>
 <20210118181338.GA11002@lst.de>
 <20210118181712.GC2260413@casper.infradead.org>
 <20210118183113.GA11473@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118183113.GA11473@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 07:31:13PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 18, 2021 at 06:17:12PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 18, 2021 at 07:13:38PM +0100, Christoph Hellwig wrote:
> > > On Thu, Jan 14, 2021 at 07:47:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the
> > > > sign to be the same.  Introduce bio_limit() and change BIO_MAX_PAGES to
> > > > be unsigned to make it easier for the users.
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > I like the helper, but I'm not too happy with the naming.  Why not
> > > something like bio_guess_nr_segs() or similar?
> > 
> > This feels like it's a comment on an entirely different patch, like this one:
> > 
> > https://git.infradead.org/users/willy/pagecache.git/commitdiff/fe9841debe24e15100359acadd0b561bbb2dceb1
> > 
> > bio_limit() doesn't guess anything, it just clamps the argument to
> > BIO_MAX_PAGES (which is itself misnamed; it's BIO_MAX_SEGS now)
> 
> No, it was for thi patch.  Yes, it divides and clamps.  Which is sort of
> a guess as often we might need less of them.  That being said I'm not
> very fond of my suggestion either, but limit sounds wrong as well.

bio_limit() doesn't divide.  Some of the callers divide.

+static inline unsigned int bio_limit(unsigned int nr_segs)
+{
+       return min(nr_segs, BIO_MAX_PAGES);
+}

I'd rather the callers didn't have to worry about this at all (just pass
in a number and then deal with however many bvecs you were given), but
there are callers which depend on the current if-too-big-return-NULL
behaviour, and I don't want to track all of those down and fix them.

I chose limit because it's imposing the bio's limit.  Could be called
bio_clamp(), but the bio also doesn't impose a minimum, so that seemed
wrong.
