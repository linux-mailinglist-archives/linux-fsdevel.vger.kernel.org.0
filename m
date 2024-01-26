Return-Path: <linux-fsdevel+bounces-9063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721483DBC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360AE1F25399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ADD1EB21;
	Fri, 26 Jan 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVOh/LiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CF1DFFC;
	Fri, 26 Jan 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279067; cv=none; b=ULAdNHMr9rR0uOuU/y1xUasHlN7zD4bVg6mw9Fyw8CxL5FjPyG53X1AdSy6klGk08T1hS+A9+B4Upi+ewRSXZw63Eh0MVL+tjNHRV84sBRX7X04YZFUKWz0LSqy92vJfWKPjmy9umwMvRkrONblAp5y/T6LIyjgcmQkiFgRS5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279067; c=relaxed/simple;
	bh=C96FQrvkUshtgqC+qMcz5zCfSC9yhxnOKbwu0ZZpwb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFC1/hqdD3am/swb3iZ4WwYpUu9hBS+qyZySqYi8o1hM5942Bm5F/xNPr4xZgmZUUfi7ufGV8eYzZC4tq+dciQQL0MVxHVcIvKnV8FDqpG0Mrt8SYeeOHBmMjmPMTlT0j95S9cKRnu2BzGUwujFoqun0fM4II6KmAyxkzkQg3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VVOh/LiY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1w4U8mqf5nN23ca0l43hojotOzXL6u5NlkdrKkG3gw=; b=VVOh/LiYV98n4HUSTPi8VsF4qQ
	y0vRCN8/8/69YP57BXK6QxuDC2d+zcK5H1cFIUikmoTP/GT5pyZ4Tl3KaJKSMSKUG4naRe58ndi1d
	VFdb5Er50Vv254B7SACCIaOKkxYVVqz9XqFO0ORQsACCl7xfa5SbMmt9MD44ew6XxxqRcKGHdqUBG
	3swmjLp8DM+ut0Wbvo0CdiSdGxxY8RNKN6acQutLcpDFW8xQDtr0NkIJ/AZm4o6uycyangmnZu7Dw
	tWvk3uqEBnxm2wWCTN6hWUcWczTHGItHBXJKZFv6Hbsc2gEBnGnzMiMrfz2a4lhXUz3+z3P74efrC
	igRgdXMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTN7s-0000000DqpP-3S99;
	Fri, 26 Jan 2024 14:24:12 +0000
Date: Fri, 26 Jan 2024 14:24:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv4 1/1] block: introduce content activity based ioprio
Message-ID: <ZbPAjGJr7hrOvNOo@casper.infradead.org>
References: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com>

On Fri, Jan 26, 2024 at 08:08:00PM +0800, zhaoyang.huang wrote:
> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> +#define bio_add_page(bio, page, len, offset)	\
> +	({					\
> +		int class, level, hint, activity;	\
> +		int ret = 0;				\
> +		ret = bio_add_page(bio, page, len, offset);		\
> +		if (ret > 0) {						\
> +			class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);	\
> +			level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);	\
> +			hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);	\
> +			activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);		\
> +			activity += (bio->bi_vcnt + 1 <= IOPRIO_NR_ACTIVITY &&		\
> +				PageWorkingset(&folio->page)) ? 1 : 0;			\

I know you didn't even compile this version.

More importantly, conceptually it doesn't work.  All kinds of pages
get added to bios, and not all of them are file/anon pages.  That
PageWorkingset bit might well be reused for other purposes.  Only
the caller knows if this is file/anon memory.  You can't do this here.


