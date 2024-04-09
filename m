Return-Path: <linux-fsdevel+bounces-16407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A546189D184
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FBF2843EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF16757F2;
	Tue,  9 Apr 2024 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mjQRE0+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA26A033;
	Tue,  9 Apr 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636820; cv=none; b=Oy6goNf1RYUho7VeQJ5zU2IDvwu45Tlo6eCxE7tILt7nFYZ5DuAwpDz2+ztewn41OKO+98SdhujU90gr7bbtLlZYKcQyu8BUh1geAVCNxicJUdZCqmuVJ7MkfQyXqh/Qvot1ywJVYp0aqFE5moS86foXyRVj5DspPaAKn19SIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636820; c=relaxed/simple;
	bh=JsdNnNN14Y8km759YLswQ09JMjRMdHh4EBv85Hvm2Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIIAHSVa3MxlS/jr29Zvf+nAoUIJRK0ZLCv0z2rXYQBrMOTvMfm6t2sHSkd2P/mDjvGMAHdASEvyPPnLi3UebsX+ru8zJC5KG248xAFb8Me10Gr+4y2OOcwKE2FSpk/4m5xgjCEy/nB7EFoQHBKpyzRLg2bm/8cSjXO4I6vsAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mjQRE0+j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=9WqpvBRHVVg+1bHOUSPH9fz96Lh6UbeU4ry7uYHvXJY=; b=mjQRE0+jJ8A+z7k5Nv1+k+AaDA
	qkIxFEZ5YnIc8CX6ie/HM0wczXZa7T3DQ7dYrU7Y7X+erSBtNGqIyZJZgNBQfysNIvWAXSBELKLDN
	pyG14eeE3DtmpqITiQeAYg8R+VKwvHhCF2MHonj8AMsBxbNN5vNgwzTqezdLI435/4zAh3ed+RPdo
	lL7+Sg+sypyxGILDqgeDFL/NSUNzmoT50h1JYK1B0QfXYeutEHMZWW9q4+D/4u3yKs1LixeBiffyV
	JxAwXoCxrfJr+psXvfkZk3jdMArKj+J/uPfjHSBqzHskHhFbc4o9/3/psZfoSxufe5aXT1cfGmPyj
	QKFArEEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ru34F-008t6i-20;
	Tue, 09 Apr 2024 04:26:43 +0000
Date: Tue, 9 Apr 2024 05:26:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240409042643.GP538574@ZenIV>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 11:21:56AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/04/07 11:06, Al Viro 写道:
> > On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
> > 
> > > Other than raw block_device fops, other filesystems can use the opened
> > > bdev_file directly for iomap and buffer_head, and they actually don't
> > > need to reference block_device anymore. The point here is that whether
> > 
> > What do you mean, "reference"?  The counting reference is to opened
> > file; ->s_bdev is a cached pointer to associated struct block_device,
> > and neither it nor pointers in buffer_head are valid past the moment
> > when you close the file.  Storing (non-counting) pointers to struct
> > file in struct buffer_head is not different in that respect - they
> > are *still* only valid while the "master" reference is held.
> > 
> > Again, what's the point of storing struct file * in struct buffer_head
> > or struct iomap?  In any instances of those structures?
> 
> Perhaps this is what you missed, like the title of this set, in order to
> remove direct acceess of bdev->bd_inode from fs/buffer, we must store
> bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
> with 'file_inode(bdev)' now.

BTW, what does that have to do with iomap?  All it passes ->bdev to is
	1) bio_alloc()
	2) bio_alloc_bioset()
	3) bio_init()
	4) bdev_logical_block_size()
	5) bdev_iter_is_aligned()
	6) bdev_fua() 
	7) bdev_write_cache()

None of those goes anywhere near fs/buffer.c or uses ->bd_inode, AFAICS.

Again, what's the point?  It feels like you are trying to replace *all*
uses of struct block_device with struct file, just because.

If that's what's going on, please don't.  Using struct file instead
of that bdev_handle crap - sure, makes perfect sense.  But shoving it
down into struct bio really, really does not.

I'd suggest to start with adding ->bd_mapping as the first step and
converting the places where mapping is all we want to using that.
Right at the beginning of your series.  Then let's see what gets
left.

And leave ->bd_inode there for now; don't blindly replace it with
->bd_mapping->host everywhere.  It's much easier to grep for.
The point of the exercise is to find what do we really need ->bd_inode
for and what primitives are missing, not getting rid of a bad word...

