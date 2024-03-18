Return-Path: <linux-fsdevel+bounces-14731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27A87E75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1741F22E41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809292E63B;
	Mon, 18 Mar 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKc3DScj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D62DF73;
	Mon, 18 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757763; cv=none; b=n2xV3sV8EvTDXuIB+NVxfrYg612UgMs9QdKysrp9A1theKVKbAjLUj55RaVL9oPLJnYaWajfGY+T23yLqyFRNhOE7Vzboe+DvcXeRtdykUcShem49ZekrXRmdK+4agyAhTZG157wuvcVekIxDfwWf1453d9nV6JzFguoG50QNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757763; c=relaxed/simple;
	bh=63wgk+zNy/9D4UuLjlWR1lRHsB7lUL+jcN+7IZ2eUp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZhCNHIvbTDT5pPNBKFUEvsC7u+BtyHm7dnR421BpSckCGgPx0wuW5QOBrUpHdt/HRa4BzyR3mGvybaXPQrQqNiXusBJFDtLlJNoM4qXXJVW2vod9MicPkQVPWB/k0LgMnQv7m6bEle3eKe9iMAB5F4DnWX6Q6DpDGJGJe2iiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKc3DScj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A3C433C7;
	Mon, 18 Mar 2024 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710757762;
	bh=63wgk+zNy/9D4UuLjlWR1lRHsB7lUL+jcN+7IZ2eUp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKc3DScjPkiLWB1u3sDSwwMH/l9zgcC5RJscHveAvPfMQtn3NRoZJghP+pE1CdZeZ
	 8997hlqm31GFhc5XDSGBJVdJ6ZG4B2b1lP/pTkDn9saJhhIyFvXM4z7+PRBvKz7MLc
	 XUqO0GkCwpwKbBMJGACHejnZpXrdM4YBIuNc1NEowTBq8bkQeH7pnvIWjI51TYgEpT
	 wNp075gAXPapLtyOnXaIb3k9nwR7nc/KF4dfMEserc1CIgWFhRMUNk3s6+UZi/m0cA
	 rHCvIat0L5nE9fAL5AJxcUtEeoGF3FSJ/vFcyb05Yae4y6hBJv5mmkDGJJZKRPG7zs
	 pJAB1pISQwf0w==
Date: Mon, 18 Mar 2024 11:29:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318-fassen-xylofon-1d50d573a196@brauner>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318-umwirbt-fotowettbewerb-63176f9d75f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318-umwirbt-fotowettbewerb-63176f9d75f3@brauner>

On Mon, Mar 18, 2024 at 11:07:49AM +0100, Christian Brauner wrote:
> On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
> > Hi, Christoph!
> > 
> > 在 2024/03/18 9:51, Yu Kuai 写道:
> > > Hi,
> > > 
> > > 在 2024/03/18 9:32, Christoph Hellwig 写道:
> > > > On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
> > > > > Because there is a real filesystem(devtmpfs) used for raw block devcie
> > > > > file operations, open syscall to devtmpfs:

Don't forget:

mknod /my/xfs/file/system b 8 0

which means you're not opening it via devtmpfs but via xfs. IOW, the
inode for that file is from xfs.

> > > > > 
> > > > > blkdev_open
> > > > >   bdev = blkdev_get_no_open
> > > > >   bdev_open -> pass in file is from devtmpfs
> > > > >   -> in this case, file inode is from devtmpfs,
> > > > 
> > > > But file->f_mapping->host should still point to the bdevfs inode,
> > > > and file->f_mapping->host is what everything in the I/O path should
> > > > be using.
> 
> I mentioned this in
> https://lore.kernel.org/r/20240118-gemustert-aalen-ee71d0c69826@brauner
> 
> "[...] if we want to have all code pass a file and we have code in
> fs/buffer.c like iomap_to_bh():
> 
> iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>         loff_t offset = block << inode->i_blkbits;
> 
>         bh->b_bdev = iomap->bdev;
> +       bh->f_b_bdev = iomap->f_bdev;
> 
> While that works for every single filesystem that uses block devices
> because they stash them somewhere (like s_bdev_file) it doesn't work for
> the bdev filesystem itself. So if the bdev filesystem calls into helpers
> that expect e.g., buffer_head->s_f_bdev to have been initialized from
> iomap->f_bdev this wouldn't work.
> 
> So if we want to remove b_bdev from struct buffer_head and fully rely on
> f_b_bdev - and similar in iomap - then we need a story for the bdev fs
> itself. And I wasn't clear on what that would be."
> 
> > > > 
> > > > > Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
> > > > > no access to the devtmpfs file, we can't use s_bdev_file() as other
> > > > > filesystems here.
> > > > 
> > > > We can just pass the file down in iomap_iter.private
> > > 
> > > I can do this for blkdev_read_folio(), however, for other ops like
> > > blkdev_writepages(), I can't find a way to pass the file to
> > > iomap_iter.private yet.
> > > 
> > > Any suggestions?
> > 
> > I come up with an ideal:
> > 
> > While opening the block_device the first time, store the generated new
> > file in "bd_inode->i_private". And release it after the last opener
> > close the block_device.
> > 
> > The advantages are:
> >  - multiple openers can share the same bdev_file;
> 
> You mean use the file stashed in bdev_inode->i_private only to retrieve
> the inode/mapping in the block layer ops.
> 
> >  - raw block device ops can use the bdev_file as well, and there is no
> > need to distinguish iomap/buffer_head for raw block_device;
> > 
> > Please let me know what do you think?
> 
> It's equally ugly but probably slightly less error prone than the union
> approach. But please make that separate patches on top of the series.
> 
> This is somewhat reminiscent of the approach that Dave suggested in the
> thread that I linked above. I only wonder whether we run into issue with
> multiple block device openers when the original opener opened the block
> device exclusively. So there might be some corner-cases.

