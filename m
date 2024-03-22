Return-Path: <linux-fsdevel+bounces-15109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251688870BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B753C1F24B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E75787F;
	Fri, 22 Mar 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fG9qAX5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B9482CF;
	Fri, 22 Mar 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124179; cv=none; b=FtmAAclWN17sBFZxbZ6SYKEygoGuIk84nc6ZNBfJvBeznR20Zab11a8qWH10Q/xHeDdfy1R+An2wUhUpEcAFrUHGWEpPDpvONzByL6WknHNynMlbt6aoHf6tqpPB1uB3gSn5dYhUJnXVor3YQk4aVXgSip0zz1QTEm8wbBBesSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124179; c=relaxed/simple;
	bh=b1C49xN8DJ5is45yDJa5mW8QnqvkmQ3T6/98AsiKo3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHvzwRWnrKAeX4lJ0KALJ+Rzb785kF7MUQ4BiiWoOWxohg/63KjGZrKwosozmDj9tale1cLykQ60MjP/t251SgnApB9bxBMxWPzeD2d+pyDO2bzqd1hGjvgzdwdD9fVFRNuT5axMq9B0tAOVQYEzP47725W7xl7HFu4VQtuLD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fG9qAX5B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=zj7OVhFxPxGxDX2ZPVBlD/KqiRwtKbXhNONQrnHXcp8=; b=fG9qAX5Bp9/PDmtK9xuRPtK2yI
	2f5GCuHFd3HmUqN0gXTW746cjOLGUIl14XqrgzPLTOA5MEQRHT83NqQzvx8bDYkIBZ6Vd6/09B8li
	sT1GGjN7VlgSgStj1JcyFsBu1pKCM+s0CLdwPbJOngTCu4HpHRTUCEffUwWgmg6KtVzalRhf8aAPM
	uK4YBJrHCufMFDDqPLM+fRo8RVuwaYWOk5CBz/g8Qn3frMVw83JPZd+WiAflow3eMyDWWeaBP9a0c
	baTOOnkKsY6FnvfU6hM2g1wuqyxWqb4mj20dymsaPY+lvf9Fv3YC/iethrM5G+chSYUYY9CFoox/8
	vppJZWPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnhYn-00EcYf-1j;
	Fri, 22 Mar 2024 16:16:01 +0000
Date: Fri, 22 Mar 2024 16:16:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322161601.GQ538574@ZenIV>
References: <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV>
 <20240322063955.GM538574@ZenIV>
 <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
 <20240322154347.GO538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322154347.GO538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 22, 2024 at 03:43:47PM +0000, Al Viro wrote:
> On Fri, Mar 22, 2024 at 02:52:16PM +0800, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2024/03/22 14:39, Al Viro 写道:
> > > On Fri, Mar 22, 2024 at 06:37:18AM +0000, Al Viro wrote:
> > > > On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:
> > > > 
> > > > > > blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> > > > > > inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> > > > > > block device instead of your file_bdev(inode->i_private)? I don't see any
> > > > > > advantage in stashing away that special bdev_file into inode->i_private but
> > > > > > perhaps I'm missing something...
> > > > > > 
> > > > > 
> > > > > Because we're goning to remove the 'block_device' from iomap and
> > > > > buffer_head, and replace it with a 'bdev_file'.
> > > > 
> > > > What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
> > > > just fine...
> > > 
> > > file->f_mapping->host, obviously - sorry.
> > > .
> > 
> > Yes, we already get bdev_inode this way, and use it in
> > blkdev_iomap_begin() and blkdev_get_block(), the problem is that if we
> > want to let iomap and buffer_head to use bdev_file for raw block fops as
> > well, we need a 'bdev_file' somehow.
> 
> Explain, please.  Why would anything care whether the file is bdevfs
> one or coming from devtmpfs/xfs/ext2/whatnot?

Yecchhh...  I see one possible reason, unfortunately, but I really doubt
that your approach is workable.  iomap is not a problem; nothing in
there will persist past the destruction of struct file you've used;
buffer_head, OTOH, is a problem.  They are, by their nature,
shared between various openers and we can't really withdraw them.

Why do we want ->b_bdev replaced with struct file * in the first place?
AFAICS, your patch tries to make it unique per opened bdev; that
makes the lifetime rules really convoluted, but that aside, what's
in that struct file that is not in struct block_device?

I don't see any point trying to shove that down into buffer_head, or,
Cthulhu forbid, bio.  Details, please...

