Return-Path: <linux-fsdevel+bounces-114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3777C5BCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB595282788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC820305;
	Wed, 11 Oct 2023 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXFwdGH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459F22301
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 18:49:34 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D310E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0rk6i7/jt81dwnETzkMbjuSyjTR9R3WkETb0wXI0Wfo=; b=SXFwdGH9i4Z9cG/erKOoacpHv1
	ZCplqwWmHXJdeGd+boz1Xv1/FtxZfu4f3vvvcb4bTz1wfSHM6GzMqFXEPKDbFioG22m+HRRWbfZSu
	NiggA/SM7243WP9rb3vl75cgv65Oa/Zskvfpl+WRlT39FpMi09isLlsx8z4Lfj/giex/ad96keL4L
	WDsEmCHWxPN5gMv00j9dMOGF/zT/3JEndIA5RRJyNWri4GXHwh3AJ6JriLrfy7f+Gl5bqNFTd8KOz
	dd2bmCHmZ13owvCJhOVA1RhJGeOw8w10W1nCZjD6tWRHbXczVLewArYtTfvN4kb3Sj6+AFFbhH7A+
	4UHSpWCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qqeGn-00CM05-FS; Wed, 11 Oct 2023 18:49:21 +0000
Date: Wed, 11 Oct 2023 19:49:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <ZSbuMWGYyulgUA6g@casper.infradead.org>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
 <ZSbo1aAjteepdmcz@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbo1aAjteepdmcz@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:26:29AM -0700, Yury Norov wrote:
> Long story short: KCSAN found some potential issues related to how
> people use bitmap API. And instead of working through that issues,
> the following code shuts down KCSAN by applying READ_ONCE() here
> and there.

Pfft.

> READ_ONCE() fixes nothing because nothing is broken in find_bit() API.
> As I suspected, and as Matthew confirmed in his email, the true reason
> for READ_ONCE() here is to disable KCSAN check:
> 
>         READ_ONCE() serves two functions here;
>         one is that it tells the compiler not to try anything fancy, and
>         the other is that it tells KCSAN to not bother instrumenting this
>         load; no load-delay-reload.
> 
> https://lkml.kernel.org/linux-mm/ZQkhgVb8nWGxpSPk@casper.infradead.org/
> 
> And as side-effect, it of course hurts the performance. In the same
> email Matthew said he doesn't believe me that READ_ONCE would do that,
> so thank you for testing and confirming that it does.

You really misinterpreted what Jan wrote to accomplish this motivated
reasoning.

> Jan, I think that in your last email you confirmed that the xarray
> problem that you're trying to solve is about a lack of proper locking:
> 
>         Well, for xarray the write side is synchronized with a spinlock but the read
>         side is not (only RCU protected).
> 
> https://lkml.kernel.org/linux-mm/20230918155403.ylhfdbscgw6yek6p@quack3/
> 
> If there's no enough synchronization, why not just adding it?

You don't understand.  We _intend_ for there to be no locking.
We_understand_ there is a race here.  We're _fine_ with there being
a race here.

> Regardless performance consideration, my main concern is that this patch
> considers bitmap as an atomic structure, which is intentionally not.
> There are just a few single-bit atomic operations like set_bit() and
> clear_bit(). All other functions are non-atomic, including those
> find_bit() operations.

... and for KCSAN to understand that, we have to use READ_ONCE.

> There is quite a lot of examples of wrong use of bitmaps wrt
> atomicity, the most typical is like:
>         for(idx = 0; idx < num; idx++) {
>                 ...
>                 set_bit(idx, bitmap);
>         }
> 
> This is wrong because a series of atomic ops is not atomic itself, and
> if you see something like this in you code, it should be converted to
> using non-atomic __set_bit(), and protected externally if needed.

That is a bad use of set_bit()!  I agree!  See, for example, commit
b21866f514cb where I remove precisely this kind of code.

> Similarly, READ_ONCE() in a for-loop doesn't guarantee any ordering or
> atomicity, and only hurts the performance. And this is exactly what
> this patch does.

Go back and read Jan's patch again, instead of cherry-picking some
little bits that confirm your prejudices.

