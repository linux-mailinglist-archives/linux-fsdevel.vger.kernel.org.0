Return-Path: <linux-fsdevel+bounces-14732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41287E7A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58663282A77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07E3612A;
	Mon, 18 Mar 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxadk7Aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40B35F0C;
	Mon, 18 Mar 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758777; cv=none; b=Hk2T3KDhBxV154LSQJnaqgNec2QD4HkHS67owd2771w7X9hLSQTyf/GMS3vPf3mT9lWGkIvkKZzKtXShIgXrIk6KqfTDPZCBM8htMNgLLgpk1a2FkVtfrYmThzBv/DKx9Tpm3kGKNqFMgohV1L2fm9QXx8re2X1UMdVwWEWYQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758777; c=relaxed/simple;
	bh=rBPRSsaHskqwYUUIxxFfRl0uy2m7svrk3m7gCM2JP1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCehK/MtLGVlcJe0b/LMSYbDH4sS7QetMlZxZNQ9XvtdfOVE4o5icxrkWNK5V+kC2Xts9/rk4VGq5lFXjizliHsB5LjP6LCnEYCOrn8Cs1qHFnhiEPynqMRTPSiOUHd/maBlJfFeDFoyMbQmeMsIoiSSwElEB7VS/paZbGXvJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxadk7Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AECFC433C7;
	Mon, 18 Mar 2024 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710758776;
	bh=rBPRSsaHskqwYUUIxxFfRl0uy2m7svrk3m7gCM2JP1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hxadk7AjNmDDW5nuuMcJHskN/wDdDop842onzbEh7B3WRNzgmSQ/yqsguMCSCTowB
	 N+F5dF5GPPcMGPuClgJSy2VUwImQCo6q0+1p0uwz9AmGK3IhPU0JlfDjDvZI2V9NPU
	 pNzFfUlc+6c1f2WpPJr5qYOfaqXeN2vva2f4Rf9LrfwaL8ElOpRh8t40GOjAV2ZEsZ
	 5wMTw6kSO9FPaEmwZbrQjtxeFypd4hTRahBGjztDodZpBJNvzmk3A0C3UyfdYg7loS
	 TO5VQFQE8odfAUwhJoAdzfg7ifde+qkn2rRv9YBbfNfQtM1YC/eyCtcInY1K1I/Lmf
	 Oh80ctP9Le77Q==
Date: Mon, 18 Mar 2024 11:46:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318-darauf-lachhaft-b7a510575d87@brauner>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318-umwirbt-fotowettbewerb-63176f9d75f3@brauner>
 <20240318-fassen-xylofon-1d50d573a196@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318-fassen-xylofon-1d50d573a196@brauner>

On Mon, Mar 18, 2024 at 11:29:22AM +0100, Christian Brauner wrote:
> On Mon, Mar 18, 2024 at 11:07:49AM +0100, Christian Brauner wrote:
> > On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
> > > Hi, Christoph!
> > > 
> > > 在 2024/03/18 9:51, Yu Kuai 写道:
> > > > Hi,
> > > > 
> > > > 在 2024/03/18 9:32, Christoph Hellwig 写道:
> > > > > On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
> > > > > > Because there is a real filesystem(devtmpfs) used for raw block devcie
> > > > > > file operations, open syscall to devtmpfs:
> 
> Don't forget:
> 
> mknod /my/xfs/file/system b 8 0
> 
> which means you're not opening it via devtmpfs but via xfs. IOW, the
> inode for that file is from xfs.
> 
> > > > > > 
> > > > > > blkdev_open
> > > > > >   bdev = blkdev_get_no_open
> > > > > >   bdev_open -> pass in file is from devtmpfs
> > > > > >   -> in this case, file inode is from devtmpfs,
> > > > > 
> > > > > But file->f_mapping->host should still point to the bdevfs inode,
> > > > > and file->f_mapping->host is what everything in the I/O path should
> > > > > be using.
> > 
> > I mentioned this in
> > https://lore.kernel.org/r/20240118-gemustert-aalen-ee71d0c69826@brauner
> > 
> > "[...] if we want to have all code pass a file and we have code in
> > fs/buffer.c like iomap_to_bh():
> > 
> > iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
> >         loff_t offset = block << inode->i_blkbits;
> > 
> >         bh->b_bdev = iomap->bdev;
> > +       bh->f_b_bdev = iomap->f_bdev;
> > 
> > While that works for every single filesystem that uses block devices
> > because they stash them somewhere (like s_bdev_file) it doesn't work for
> > the bdev filesystem itself. So if the bdev filesystem calls into helpers
> > that expect e.g., buffer_head->s_f_bdev to have been initialized from
> > iomap->f_bdev this wouldn't work.
> > 
> > So if we want to remove b_bdev from struct buffer_head and fully rely on
> > f_b_bdev - and similar in iomap - then we need a story for the bdev fs
> > itself. And I wasn't clear on what that would be."
> > 
> > > > > 
> > > > > > Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
> > > > > > no access to the devtmpfs file, we can't use s_bdev_file() as other
> > > > > > filesystems here.
> > > > > 
> > > > > We can just pass the file down in iomap_iter.private
> > > > 
> > > > I can do this for blkdev_read_folio(), however, for other ops like
> > > > blkdev_writepages(), I can't find a way to pass the file to
> > > > iomap_iter.private yet.
> > > > 
> > > > Any suggestions?
> > > 
> > > I come up with an ideal:
> > > 
> > > While opening the block_device the first time, store the generated new
> > > file in "bd_inode->i_private". And release it after the last opener
> > > close the block_device.
> > > 
> > > The advantages are:
> > >  - multiple openers can share the same bdev_file;
> > 
> > You mean use the file stashed in bdev_inode->i_private only to retrieve
> > the inode/mapping in the block layer ops.
> > 
> > >  - raw block device ops can use the bdev_file as well, and there is no
> > > need to distinguish iomap/buffer_head for raw block_device;
> > > 
> > > Please let me know what do you think?
> > 
> > It's equally ugly but probably slightly less error prone than the union
> > approach. But please make that separate patches on top of the series.

The other issue with this on-demand inode->i_private allocation will be
lifetime management. If you're doing some sort of writeback initiated
from the filesystem then you're guaranteed that the file stashed in
sb->bdev_file is aligned with the lifetime of the filesystem. All
writeback related stuff that relies on inode's can rely on the
superblock being valid while it is doing stuff.

In your approach that guarantee can't be given easily. If someone opens
a block device /dev/sda does some buffered writes and then closes it the
file might be cleaned up while there's still operations ongoing that
rely on the file stashed in inode->i_private to be valid.

If on the other hand you allocate a stub file on-demand during
bdev_open() and stash it in inode->i_private you need to make sure to
avoid creating reference count cycles that keep the inode alive.

