Return-Path: <linux-fsdevel+bounces-10370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FF84A8FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325B61F2DD09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1E4D117;
	Mon,  5 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8KQ+NgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D81AB7F6;
	Mon,  5 Feb 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170726; cv=none; b=m91uCsZCJR0n6/Sy8WN4oDdzccfFW8TTpb+66z0LjRd2DYtpOqt+/oI+eG+7weGc64szfB3daPZ9nP8aOTir0oSitE/ER+CVTUgK149zzFAfArZ1vZBzZ4AzscZp4uvkg0HV+jtMpNdm5e418ZiNMzaA0Hw+5OcEv7VZPhb2N1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170726; c=relaxed/simple;
	bh=mBdzkE+dp33mTXyDUdaiNEDK3SSO1DVF+TPuTY5o3bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCxl+0udE0hF04EQsMAxve5i+gNobjlXy6bkc00KXukLyZOHjy1llDgs30fkEtSL7mjdxGFPZ5F4cas5HXQbzitjKW1kACYoAuQ6zPeSK4k1fe0XJvBAeO3YvIa+OVsVgAJWB7fxi7+zN1E537VNUB9xlX2hl0aKE6PyWaapEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I8KQ+NgT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WwVddD5SOQafzot7tI9REXdsEtho3qPgU310yej4F+4=; b=I8KQ+NgTK/KRyZh/oh61Htpb6h
	j2FTtGQDXzqQ3SUSgEslu5u2GAeHi7efAyxkRPREs/xdYXxW2B9q+Zb1mXBwM9DCQkfRE8Hgv9Sxa
	+sGgkYGZ1RCK6vr5IjXoE8djECJ9f9T3QTN7uOQVJQcqrvLTm311gDHBnLmqSrOIYnBfqu8CfzVsA
	aOafL/rx1yGo3VVJbkdZBhTXbpSddd1t87jNZOmlIVAWZqM9TAPwJqDrabfOtE0fOTrAh+/bXG+fk
	/H2vsxHhFI/Eyajk3p7/5XqMfFHNzFaaP5I0q9FdbAJVAa7H6KRDbsZnkWdZ8PGGxJoajPZFFwfQ4
	kxI0r0kw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX75T-0000000AY5h-47CJ;
	Mon, 05 Feb 2024 22:05:12 +0000
Date: Mon, 5 Feb 2024 22:05:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv8 1/1] block: introduce content activity based ioprio
Message-ID: <ZcFbl0zP2pK6vEmh@casper.infradead.org>
References: <20240205090552.40567-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205090552.40567-1-zhaoyang.huang@unisoc.com>

On Mon, Feb 05, 2024 at 05:05:52PM +0800, zhaoyang.huang wrote:
> +void bio_set_active_ioprio(struct bio *bio)

why does this still exist?  i said no.

> +void bio_set_active_ioprio_page(struct bio *bio, struct page *page)

this function should not exist.

> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)

this is the only one which should.  did you even look at the
implementation of PageWorkingset?

> +extern void bio_set_active_ioprio(struct bio *bio);
> +extern void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio);
> +extern void bio_set_active_ioprio_page(struct bio *bio, struct page *page);

do not mark function prototypes with extern.

> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +	/*
> +	 * bi_cont_act record total activities of bi_io_vec->pages
> +	 */
> +	u64			bi_cont_act;
> +#endif

what?

look, you just don't understand.  i've spent too much time replying to
you trying to help you.  i give up.  everything to do with this idea is
NAKed.  go away.

