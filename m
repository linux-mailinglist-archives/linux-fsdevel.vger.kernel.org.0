Return-Path: <linux-fsdevel+bounces-20616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BAB8D6201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DC51C24854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91315DBA7;
	Fri, 31 May 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iQld/0+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF82158A14;
	Fri, 31 May 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159155; cv=none; b=DDZNUKO9Kwylk4WP9F1WVNGBxEBNZ7IAEj4MtJyn64KpVvoH+/OtCUJe9mkEQgn0j4TfqVIMW+0w1ytI4fD0s/bqGDZnDyI7apkgRG5r0+qhD3aC7rCO99mSq5qW+ZicJSMdNp80g2GMHYWiZVv1K6WDX/qf76WyxQ+sPdfD6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159155; c=relaxed/simple;
	bh=XHhIKllrLS04EQIbw2cXL6NKpGu+cxJfRqy8n5ltMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0h0HAvwm1BsAArAUoM3uup0CDpvIJs+E4GmgIH3sv5QcrkljwYElPiinFZsp1KY/kNEetBKDnB8bd1KAW+wPaY2KqQ0R+Lx/4M8t7ZoPtbRmXNyxXIY3xAzLtCZPxP18sVwtm6Rc3m8ygBmMR/993CY81bkUjeGjiKs9lSHWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iQld/0+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JUHpCtOFvJ217dOG69CLyUE0s9lGKzV3hZOfC/pApv8=; b=iQld/0+wSyfDLz98D3BIIzo6Ac
	x0Kz29ldzbaZqe3zBKjJV5QDN2L941s1LbVSuwnrhoAoU7XP/QxLTgu79MZ7uwZFM8R5ABwwaUS+E
	eCr7HJjGHMmlVgDZKCQ/ET2oUVa3AiYGlyTjXatp4q4nqfzZcBif0iRw6XtgN35+02gEDFDAIHxZb
	QkIAWVD7WxeqRRAcU63D4fj6MQcY4Bybro4TsAka9FJeb5N1ZYtMcqo/1a9pP6furrGehPRXH4v89
	Ev9xqid/1uHzTf44rjHWrxGPVRQitVoixmDtn/7rI4kGEH6u5FLVUmya0YnvDbWir4nTaE8Pw/CQx
	PL3jCGig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1XK-0000000ADsj-3R6h;
	Fri, 31 May 2024 12:39:10 +0000
Date: Fri, 31 May 2024 05:39:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 3/8] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <ZlnE7vrk_dmrqUxC@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-4-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> -		const struct iomap_ops *ops)
> +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> +		bool *did_zero, const struct iomap_ops *ops)
>  {
> -	unsigned int blocksize = i_blocksize(inode);
> -	unsigned int off = pos & (blocksize - 1);
> +	unsigned int off = rem_u64(pos, blocksize);
>  
>  	/* Block boundary? Nothing to do */
>  	if (!off)

Instad of passing yet another argument here, can we just kill
iomap_truncate_page?

I.e. just open code the rem_u64 and 0 offset check in the only caller
and call iomap_zero_range.  Same for the DAX variant and it's two
callers.


