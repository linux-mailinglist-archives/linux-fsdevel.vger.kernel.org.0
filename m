Return-Path: <linux-fsdevel+bounces-20031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C278CCA62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 03:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505381C20F37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225F1C36;
	Thu, 23 May 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LwXy2Km7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09EA29
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428522; cv=none; b=cEHhH60MkbK3RyiL/KJwyAuE5ASLC966oGUvIJ1VaEaBWk5Zlsaa10Wh6qf1Dwsqq9FZnIIoDv8kyO5vXDVWEbnj+VwrKJ1xvcnLRH5g5m/gcribzh/nkEkG5UJjJhxEnJgU+WmVWiF9hxq9uoV7GkGHU41sEQhjMHymcZr5rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428522; c=relaxed/simple;
	bh=Twmc7iHYEl9ZtShG9cL1vW+Iuo2Y2+obnSI/x0t8EYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLbPnEqRj0T36FQRBb27W4iwY/s1EgTe1c6qwQLJEcC4OJkezOwpFb1e7buPfjMJwzGka/BB4SElu3JuvrNLtNLozwp3rUU4QcgNc2GMG96NljLF74VlG36ftE1bSkYlTRZTpn6zgbgAgLevG5vYeCeswVCUS/C1tDDemFAzMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LwXy2Km7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6uL5/+sshX9f4rL0eXGdTkAIHl9U0GVSZiHyGReuIZk=; b=LwXy2Km7WOOtRzsvW+S6pHtfdZ
	Sh1JguFGbj2CS6M4Rg16edTmauEWLryRAu2b1ZJLFMDSC2ex6CvIFrLuq3iB/eiE9+yAxGvo6xuqx
	wonXI4K7jaF69aUa9sAFI/7x3PICaKzZW8iKwmj3TFO/URUnYeASQeqyFy0oMhSRlGgWjUaVLOEEG
	innLdWHkfKg8Jeckze9ILQkdHjhN9zdF427YrP1Y9+jYz6Y1Z/u+QoW2NDXbo8ekXwQFpL5nMl01z
	1VF0KoykWbU/b9H56ZHJ/FBfkMa6H2BsHptuv4zWyQmp1V/yTetKyxuKiacgsf34A4gQ48pNJQeP5
	igEYLCQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9xSp-00000001FID-2Qq1;
	Thu, 23 May 2024 01:41:51 +0000
Date: Thu, 23 May 2024 02:41:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <Zk6e30EMxz_8LbW6@casper.infradead.org>
References: <20240514152208.26935-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514152208.26935-1-jth@kernel.org>

On Tue, May 14, 2024 at 05:22:08PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Move reading of the on-disk superblock from page to kmalloc()ed memory.

No, this is wrong.

> +	super = kzalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
> +	if (!super)
>  		return -ENOMEM;
>  
> +	folio = virt_to_folio(super);

This will stop working at some point.  It'll return NULL once we get
to the memdesc future (because the memdesc will be a slab, not a folio).

>  	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
>  	bio.bi_iter.bi_sector = 0;
> -	__bio_add_page(&bio, page, PAGE_SIZE, 0);
> +	bio_add_folio_nofail(&bio, folio, ZONEFS_SUPER_SIZE,
> +			     offset_in_folio(folio, super));

It also doesn't solve the problem of trying to read 4KiB from a device
with 16KiB sectors.  We'll have to fail the bio because there isn't
enough memory in the bio to store one block.

I think the right way to handle this is to call read_mapping_folio().
That will allocate a folio in the page cache for you (obeying the
minimum folio size).  Then you can examine the contents.  It should
actually remove code from zonefs.  Don't forget to call folio_put()
when you're done with it (either at unmount or at the end of mount if
you copy what you need elsewhere).

