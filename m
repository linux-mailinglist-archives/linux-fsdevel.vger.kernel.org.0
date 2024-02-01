Return-Path: <linux-fsdevel+bounces-9917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD48460B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D7B1F26FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52F85270;
	Thu,  1 Feb 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpS8ZkqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289485266
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814763; cv=none; b=aQS63Vdem3CieJw4xqz8BUO5lrE+GCUAwjt9njK9gxpWtjNw0yR4zG9usjhpUVIJjdM0Gq73S9gQ/mN/qXJAwhaAOSEAAa69MoNLisk6n7XLf4+dF8KWPX08OqEQ0crgVk5zVrRqpmZugzLCfdTH0XziRWWtQEo5w6TnkaELwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814763; c=relaxed/simple;
	bh=n69u70JlN7M8hN+6Sda5u2i6Ps5HUivB1vs5MRkfDuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs/xFlhE/hPZRekIeqdcdFtwA/hen22F/gnHyftXhOT21clmNGfMmL8t4RQNKqYwqQrT8s8D2mLiRWUXbrH6RJU4jJyjf61CB2cclWZmrx6ZNGM3kAI4syPwLpHYWhVxfcy5UsKQNX1JX07oMmjgmCCUDbkQbznAXn+lDdDg3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gpS8ZkqN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jE38DTsOLGGqymbJG9xeMoHK05zmQS/FtgMqOHuw1zs=; b=gpS8ZkqN+AvsQR5RY1ia0z+Xfi
	Wg+38OXvhH9lh54gmCU36nMurca+BcYySWYHTCGJfhdXr1+dWWtbpnVvhgPDbdVIFeYYi0Bqucc3I
	5um8mZM9t4kxoFLQcRN4rKo8J9mMnqGNpqAlpgwO9hsC39kg9E2QWg1oqfRQO2IcDPCC3VsNDkZx4
	HHZv4RfZEGnvwt1Jz/yW5IX8hmUs+ZfGouGXzXWtPr7by+Ku751C7dmINNreePkXLEIDNi+RUBpNe
	7FB+tsi3meaGfDXZh8lTCsm4WemI/FG4vu9ehIXKCiGS12b6a3zKR8vIDS+vk/I/qJc0j1M+9dCua
	Al+p8dkw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVcU6-0000000GasR-0ACZ;
	Thu, 01 Feb 2024 19:12:26 +0000
Date: Thu, 1 Feb 2024 19:12:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rfc 1/9] mm: migrate: simplify __buffer_migrate_folio()
Message-ID: <ZbvtGWphK1uGg25J@casper.infradead.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070934.3717659-2-wangkefeng.wang@huawei.com>

On Mon, Jan 29, 2024 at 03:09:26PM +0800, Kefeng Wang wrote:
> @@ -774,24 +774,16 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		}
>  	}
>  
> -	rc = folio_migrate_mapping(mapping, dst, src, 0);
> +	rc = filemap_migrate_folio(mapping, dst, src, mode);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		goto unlock_buffers;
>  
> -	folio_attach_private(dst, folio_detach_private(src));
> -
>  	bh = head;
>  	do {
>  		folio_set_bh(bh, dst, bh_offset(bh));
>  		bh = bh->b_this_page;
>  	} while (bh != head);
>  
> -	if (mode != MIGRATE_SYNC_NO_COPY)
> -		folio_migrate_copy(dst, src);
> -	else
> -		folio_migrate_flags(dst, src);
> -
> -	rc = MIGRATEPAGE_SUCCESS;

I wondered if maybe there was an ordering requirement; that we had to
set up the BHs before copying the data over.  But I don't think there
is; the page should be frozen, the buffer heads are locked, and I don't
think the ordering matters.  So ...

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

