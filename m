Return-Path: <linux-fsdevel+bounces-16665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A692C8A12A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82801C21DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF7147C9B;
	Thu, 11 Apr 2024 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOnePV1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3893147C69;
	Thu, 11 Apr 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833945; cv=none; b=h98LbVEam7xRgki4XttnTZT2Iz2c64+aqFbzIrTAx/sQV6X1Rj+WzJusI+td/uNHr8T22Pi6gI7I3CnbuhUGwgTascJ24LDXMV9bXVjYFY87Zs7oYgydwYCT+ops5AwKzDI4YAlFwrKXAE7W2TA4TpI76ILol+O2fwiqpVvb8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833945; c=relaxed/simple;
	bh=2rQtShlTQeeKDYUdJtQPvdiMpsI9pPqx8aAJuE6cUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4AfYUB/baMVBDQy77CUAoxws/SwnO1jrLcRLAmm4abJOHHfl0gpv5Q+mBm9iW2vYS6J8YW90z1d0tE1EeZEoE+Soi/zwb4ovqVR+fAOIggKFv4F9mEgF3VxAH8hTzqimxV9c28zc51hM41N3stlndR/aA68il8x4wvstmrl5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOnePV1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB41C433C7;
	Thu, 11 Apr 2024 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833945;
	bh=2rQtShlTQeeKDYUdJtQPvdiMpsI9pPqx8aAJuE6cUiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOnePV1WrI4jUhAwnGXmXNZFyh3Doqixw8cHtmaliwiwSRRxmhCiD08AEww2RJCJs
	 DFANl/qE4/s9l4WNx3yncn7Gp49wil5GwcRNaSDLyZmzhs/J57pWv3kUQaxZsgOeW9
	 x8D58thlDFq0vow4MwrVHAjDWrK/OMcf8hzHl2AHvOWm4LT9htdeiqvcSvuDWR8ids
	 SE0X8WHtO7ypm13AAr72SShx3XiodeT+euvJvjKH5sDIdSl5+m95OkK++aGinAFhMd
	 zLg4IZvPUrlu0g7O2K+54huuH68iPgtw8o82YzPpEgk4JTfCLxj4RbwAB6aIX5zHeo
	 hpXHcAUeatuuA==
Date: Thu, 11 Apr 2024 13:12:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, jack@suse.cz, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 04/26] block: prevent direct access of bd_inode
Message-ID: <20240411-periodisch-luchs-95fbe85c19f8@brauner>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-5-yukuai1@huaweicloud.com>
 <20240407022250.GH538574@ZenIV>
 <45c32706-b599-d968-4bff-4ad8f0768275@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c32706-b599-d968-4bff-4ad8f0768275@huaweicloud.com>

On Sun, Apr 07, 2024 at 10:37:08AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/04/07 10:22, Al Viro 写道:
> > On Sat, Apr 06, 2024 at 05:09:08PM +0800, Yu Kuai wrote:
> > > @@ -669,7 +669,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >   {
> > >   	struct file *file = iocb->ki_filp;
> > >   	struct block_device *bdev = I_BDEV(file->f_mapping->host);
> > > -	struct inode *bd_inode = bdev->bd_inode;
> > > +	struct inode *bd_inode = bdev_inode(bdev);
> > 
> > What you want here is this:
> > 
> > 	struct inode *bd_inode = file->f_mapping->host;
> > 	struct block_device *bdev = I_BDEV(bd_inode);
> 
> Yes, this way is better, logically.
> > 
> > 
> > > --- a/block/ioctl.c
> > > +++ b/block/ioctl.c
> > > @@ -97,7 +97,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
> > >   {
> > >   	uint64_t range[2];
> > >   	uint64_t start, len;
> > > -	struct inode *inode = bdev->bd_inode;
> > > +	struct inode *inode = bdev_inode(bdev);
> > >   	int err;
> > 
> > The uses of 'inode' in this function are
> >          filemap_invalidate_lock(inode->i_mapping);
> > and
> >          filemap_invalidate_unlock(inode->i_mapping);
> > 
> > IOW, you want bdev_mapping(bdev), not bdev_inode(bdev).
> > 
> > > @@ -166,7 +166,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
> > >   {
> > >   	uint64_t range[2];
> > >   	uint64_t start, end, len;
> > > -	struct inode *inode = bdev->bd_inode;
> > > +	struct inode *inode = bdev_inode(bdev);
> > 
> > Same story.
> 
> Yes.

I've folded in those changes during applying.

