Return-Path: <linux-fsdevel+bounces-52235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A34AE0664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECEE3BDC11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2224339D;
	Thu, 19 Jun 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="npJdW27m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41228682;
	Thu, 19 Jun 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337959; cv=none; b=mLPjw5ht7t3Kisn4SN8QrZrxuQEftArwoMAOlxRVxysGSltpcW0oiOH2aJsrYK38EaE6ZA5wx1L54WbTc3SwTJ//uCBE4wjq8h7gq1q5BV7RpRoBnCtJvEesK0h7JiLlkw8UY7IhWVfh28JGil91IvJSltWrIwpgB+e4AagP7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337959; c=relaxed/simple;
	bh=ldW7q8MFCm7Q3zu2PUDWsXEM/4tL7xet9LkvnVb0zeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeKPUHjgSPZdchJ3GvrSJYrxsJ0jNjP0ewF7Hokzm/SyglSUCT6/3zYmgTi0myXgi+dxycIkMy4IqYybaTpLEoTSxYuToO9ET3NM9uWuRHl+wB7fBS1ALyNka/2c59G8WkjQq5/aHujjJyNKtvUaEgG3MOFm7wvgpF55+BxmG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=npJdW27m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=27p96N4Z7LfPlmIL8W6PXxQIA+BzM1QN+JHDCJgE+CM=; b=npJdW27mQEphVXyMAmli2Lmkij
	asAJPXz5d5f/tCmA74btbiZNWkeq1ulkASLMtHGJeqdwOavre1+ArWqBkayhq5YCiTdDuMFI+g5ku
	ylSVumY4lOMb7I6UsBkG+Cdli2FzGqha5euq2pWnF1i3mQIel+o8xzxF96qQ+I/c5TGnDdijywe+5
	lK3Fr9Oo4K5o/Ug6BwAl0lOn9Z4xat2RMaHEbynZLaL0WUMtQ2x8qNCvFpNUMD5WGS/xDiLNH3aoL
	zgL++ozb6CzGBBs1q8SJwAmLb2YYH10KMyZY65fnE7drR4gGEXN2lKXEEqX57mmGcyzrP92KTz/R1
	LwHUyNuw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSErJ-00000008k2S-0RqM;
	Thu, 19 Jun 2025 12:59:13 +0000
Date: Thu, 19 Jun 2025 13:59:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2] fs/buffer: use min folio order to calculate upper
 limit in __getblk_slow()
Message-ID: <aFQJoA6gyq6l56XS@casper.infradead.org>
References: <20250619121058.140122-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619121058.140122-1-p.raghav@samsung.com>

On Thu, Jun 19, 2025 at 02:10:58PM +0200, Pankaj Raghav wrote:
> +++ b/fs/buffer.c
> @@ -1121,9 +1121,10 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  	     unsigned size, gfp_t gfp)
>  {
>  	bool blocking = gfpflags_allow_blocking(gfp);
> +	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
>  
>  	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> -		     (size < 512 || size > PAGE_SIZE))) {
> +		     (size < 512 || size > (1U << blocklog)))) {
>  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
>  					size);
>  		printk(KERN_ERR "logical block size: %d\n",

Is this what we want though?  If ext4 wants to create an 8kB block size
filesystem on top of a 512 byte sector size device, shouldn't it be
allowed to?  So just drop the max:

 	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
-		     (size < 512 || size > PAGE_SIZE))) {
+		     (size < 512)))) {

(also, surely logical_block_size is always at least 512, so do we really
need this check at all?)

