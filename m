Return-Path: <linux-fsdevel+bounces-16705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026E8A18AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70726B28282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1A1773D;
	Thu, 11 Apr 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="go+W9Que"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C614F68;
	Thu, 11 Apr 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848931; cv=none; b=r+OD4dga2wOr18s+KdouyY4VzZk4moOGVUoIXBNzSX22bJcOHD+YBBZhN2w0AOB9tvk0HB8snqbXU6+4gU6NpRJ+o1q1Fj3nzVYGDbFcSyQkHWENIBVFbg3RBeia/NighFGJNg+IiL74mGtg/TSjQwjmaZKm+XL58UD8dHyfcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848931; c=relaxed/simple;
	bh=SwE0Ntr9Q2DsPczc+O+W8VNP/sF7LKUotga+t8sd6wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwlJOJnLs1NUwsiIlpWu7XMBe4/erNmqMGwYaV8ChSFG1LAXK9WhKR4frLp2hXkFlRM3YskSAQLtTPlPFL5Hqan8EAzyYP9gGwpIpPbh6q18ujxvEZqwscOFCBP+yMZ4TYx+4Cwqp4FoW9Luvvf0t2eJLjr1P50OWkGmGiPvPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=go+W9Que; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g5jnVkjaKMI1tklLBllrixUlSBdhkjD2GQ3QccSOE0s=; b=go+W9QueRUU674JkYzgB/7uKSK
	FVNzAMo2c768uPAYOWpwXKXEbf86O1MGa8wx31MlYbdtFGyTn/LR1UMDQZqPkGgJE2gy34N2cx2kf
	GJyusbvsOjdbdoLjdEvVFh9jKEx+4oY5v6mOu4T6zAZU9GRbXAkXdwL7FIdcCggeFM+BL+pvJRUpl
	MxwD/ptBPV6GbmLHW0TsoIBgae1W9vXCy4b0b0R9siXZIFOm4VkBii2eGNS5P/8kks56wFv+u5Fme
	mrBMjafx48HjeXK/MiUgxtMQL6WoEOgUpnfG1ul4g2l3zp5d4WLAihF/V5mjo2bkgfyAOTH42kMdw
	sGVS5X9w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruwFY-00000007Ddj-1BGG;
	Thu, 11 Apr 2024 15:22:04 +0000
Date: Thu, 11 Apr 2024 16:22:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <ZhgAHLZr6GZ-xxOM@casper.infradead.org>
References: <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240407045758.GK538574@ZenIV>
 <20240407051119.GL538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407051119.GL538574@ZenIV>

On Sun, Apr 07, 2024 at 06:11:19AM +0100, Al Viro wrote:
> On Sun, Apr 07, 2024 at 05:57:58AM +0100, Al Viro wrote:
> 
> > PS: in grow_dev_folio() we probably want
> > 	struct address_space *mapping = bdev->bd_inode->i_mapping;
> > instead of
> > 	struct inode *inode = bdev->bd_inode;
> > as one of the preliminary chunks.
> > FWIW, it really looks like address_space (== page cache of block device,
> > not an unreasonably candidate for primitive) and block size (well,
> > logarithm thereof) cover the majority of what remains, with device
> > size possibly being (remote) third...
> 
> Incidentally, how painful would it be to switch __bread_gfp() and __bread()
> to passing *logarithm* of block size instead of block size?  And possibly
> supply the same to clean_bdev_aliases()...

I've looked at it because blksize_bits() was pretty horrid.  But I got
scared because I couldn't figure out how to make unconverted places
fail to compile, without doing something ugly like

-__bread(struct block_device *bdev, sector_t block, unsigned size)
+__bread(unsigned shift, struct block_device *bdev, sector_t block)

I assume you're not talking about changing bh->b_size, just passing in
the log and comparing bh->b_size to 1<<shift?

