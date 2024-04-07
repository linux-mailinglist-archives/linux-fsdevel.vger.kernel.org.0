Return-Path: <linux-fsdevel+bounces-16317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 257EC89AE9E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 06:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA147B22C5A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416B5240;
	Sun,  7 Apr 2024 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dHgac33R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B08A35;
	Sun,  7 Apr 2024 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712465892; cv=none; b=gGEAT9Ox2hdycIpifcZwSJmeEhKt1vIb+cAsBWks8Z9iYn3ZMRgUR+Z2CgudJbFixm7HvqqUb/h6fC6+N70OToMXDXKcI746RkQjfMb1d/QICYXWu6BGLy9RaMlNfhOZUTFxsS5GtZ4GuOtJ4qmmcAPJbJNNYsDUWM9tGFp3UXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712465892; c=relaxed/simple;
	bh=+aA+foFcuYWDdLYrZdvkgwWLVZ9yz4hubu2ZPFwCFbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVNjZV6ZCTwkA6oGSeAA0kUkbxHLC73yyUIlYfzUDEsyZSHK5WnFlwLVWP3qgWS3RflVL5HuYH0dCQi/OjAYzdsF3LY93A5/vLgkXRtn4FJgypKsZQfQaVu2Di2CQLFsOOKoOdCND1kYgYnNzQnFmbWM5LzioJta38njMSqE7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dHgac33R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j+/uhsC6sAg8D/msFhEYhbk2+tPipJplzLZvVeFYCXU=; b=dHgac33RTv0AxbXrG6bLBgNl6O
	FO8E8JFpWVISJ5UNEZecmpVmizh4Bq0WoqK8GNAj2eM8+Oyd3kMZJFC86z0Ronnx3bIUrdj1by0zh
	Ri1lsRhntRAPM/bM20xUIicskECN/sBX8kO5h4EMZNj91C3TyyGgq9rYKAShdp4bGZ7AW1PaRhrB5
	5MvPh9cxDBIvUBwstF5TJ6Xkssu/A5co3xI0vRzTIRNzQvkiERUQpsMFZ/xFhmgsyweSVX/BxL5V9
	9rid6EA90g4yY1xELOYUsbOyTyRodn4kISzRlS/dmRTfn23q6OfnktlxgIhVWONtulNlUf4SheeJ3
	D7wvlsxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtKbO-007c2m-2a;
	Sun, 07 Apr 2024 04:57:58 +0000
Date: Sun, 7 Apr 2024 05:57:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240407045758.GK538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 11:21:56AM +0800, Yu Kuai wrote:

> Perhaps this is what you missed, like the title of this set, in order to
> remove direct acceess of bdev->bd_inode from fs/buffer, we must store
> bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
> with 'file_inode(bdev)' now.

TBH, that looks like a very massive overkill that doesn't address
the real issues - you are still poking in that coallocated struct
inode, only instead of fetching it from pointer in struct block_device
you get it from a pointer in a dummy struct file.  How is that an
improvement?  After all, grepping for '\->[ 	]*bd_inode\>' and
looking through the few remaining users in e.g. fs/buffer.c is
*much* easier than grepping for file_inode callers.

AFAICS, Christoph's objections had been about the need to use saner
APIs instead of getting to inode in some way and poking in it.
And I agree that quite a few things in that series do just
that.  The final part doesn't.

IMO, those dummy struct file (used as convenient storage for pointer
to address_space *and* to the damn inode, with all its guts hanging
out) are simply wrong.

To reiterate:
	* we need to reduce the number of uses of those inodes
	* we need to find out what *is* getting used and sort out
the sane set of primitives; that's hard to do when we still have
a lot of noise.
	* we need convert to those saner primitives
	* we need to prevent reintroduction of noise, or at least
make such reintroduced noise easy to catch and whack.

->bd_inode is a problem because it's an attractive nuisance.  Removing
it would be fine, if there wasn't a harder to spot alternative way to
get the same pointer.  Try to grep for file_inode and bd_inode resp.
and compare the hit counts.  Seriously reduced set of bd_inode users is
fine - my impression is that after this series without the final part
we'd be down to 20 users or so.  In the meanwhile, there's about 1.4e3
users of file_inode(), most of them completely unrelated to block
devices.

PS: in grow_dev_folio() we probably want
	struct address_space *mapping = bdev->bd_inode->i_mapping;
instead of
	struct inode *inode = bdev->bd_inode;
as one of the preliminary chunks.
FWIW, it really looks like address_space (== page cache of block device,
not an unreasonably candidate for primitive) and block size (well,
logarithm thereof) cover the majority of what remains, with device
size possibly being (remote) third...

