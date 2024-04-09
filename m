Return-Path: <linux-fsdevel+bounces-16412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90F89D1A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE201F25394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93A535A2;
	Tue,  9 Apr 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B9gW6P2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77106433C8;
	Tue,  9 Apr 2024 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638408; cv=none; b=XWCPNIZyH1fwzU+kXxX7I3EJsFyG9G0BBlexywjNz3iXrAxjh6K+Y+LzbCXBfyqd1JsXhiOjwW/05FeP4p5axXXMhKYxupk/BBIe7mRAr27vmYp3eH/6+7pO8KgW1mF/+6dviX/TpWdjJuysB2dDOHRw4y8mzhXeUST5I4h0xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638408; c=relaxed/simple;
	bh=KbxZgjZzkJbR0OHc0XROD1pbjYpoGmH7KmBu8pGiqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSXhDisWQhH/HGaHAsHl1ud6eTZJbYPzWCQTAq7G5rwpRoX3r8ve1iVQhuIO/GTXWgE55H91wLDkijqzhWHgTEX7n7DoJdP6MOHP0CIhcY2Lafaez8cCsiAYDXOeS4QFrTICvA7x6oNzcQYUubgAJbm0HdmL0B/jRobn8F/aPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B9gW6P2d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=9ZgT8IZePivBKznbr73l0ASZZ8ZS3ee5b1o64Z2xpuw=; b=B9gW6P2d/SQHVEF5cyt70HPJjA
	bZuJWeBaBKXgbVNTEQuhSSjJDiecmqkwpX+2OKJLOioWmxl+/yzhK4U8zPxLecPW06BuNnl/Ksm/P
	CuESCTUXVyEPwUSE8hdu9o+Ebf3GH6X4hI3oFQS8eEr+1VxHqTIsoiJZTMY3N++u9ZV47kg9WlKSy
	UAP6GLspMIHd79JtNDOXS1YbFNTWNPSNF8kMe/+TKKrdZovSD3M6/zEfsKWXzrYsNQpP/atCIbzd2
	MoI/h96hMlSCaDkGWi67Zs5HV0n/8pGDK+OlB9CwV90V8WkaFlJOghM1LlMbzu22faV71XTpfwTps
	7ijkrSqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ru3Tw-008to8-2M;
	Tue, 09 Apr 2024 04:53:16 +0000
Date: Tue, 9 Apr 2024 05:53:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240409045316.GA2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409042643.GP538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 09, 2024 at 05:26:43AM +0100, Al Viro wrote:
> On Sun, Apr 07, 2024 at 11:21:56AM +0800, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2024/04/07 11:06, Al Viro 写道:
> > > On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
> > > 
> > > > Other than raw block_device fops, other filesystems can use the opened
> > > > bdev_file directly for iomap and buffer_head, and they actually don't
> > > > need to reference block_device anymore. The point here is that whether
> > > 
> > > What do you mean, "reference"?  The counting reference is to opened
> > > file; ->s_bdev is a cached pointer to associated struct block_device,
> > > and neither it nor pointers in buffer_head are valid past the moment
> > > when you close the file.  Storing (non-counting) pointers to struct
> > > file in struct buffer_head is not different in that respect - they
> > > are *still* only valid while the "master" reference is held.
> > > 
> > > Again, what's the point of storing struct file * in struct buffer_head
> > > or struct iomap?  In any instances of those structures?
> > 
> > Perhaps this is what you missed, like the title of this set, in order to
> > remove direct acceess of bdev->bd_inode from fs/buffer, we must store
> > bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
> > with 'file_inode(bdev)' now.
> 
> BTW, what does that have to do with iomap?  All it passes ->bdev to is
> 	1) bio_alloc()
> 	2) bio_alloc_bioset()
> 	3) bio_init()
> 	4) bdev_logical_block_size()
> 	5) bdev_iter_is_aligned()
> 	6) bdev_fua() 
> 	7) bdev_write_cache()
> 
> None of those goes anywhere near fs/buffer.c or uses ->bd_inode, AFAICS.

Note that callers of iomap stuff in block/fops.c *do* have struct file *,
so there's no problem with getting to inode - there the use of ->f_mapping->host
is normal for ->write_iter()/->read_iter() instances.  Same for filemap_read()
and iomap_file_buffered_write().

As the matter of fact, the only use of ->bd_inode in block/fops.c is easily
killable, as discussed upthread.

