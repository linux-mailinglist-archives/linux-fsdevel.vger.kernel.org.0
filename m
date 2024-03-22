Return-Path: <linux-fsdevel+bounces-15107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C454886FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C861F222FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B653E3C;
	Fri, 22 Mar 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JqoYZT3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35146535B5;
	Fri, 22 Mar 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122240; cv=none; b=UBkRwdbV39rJ5szvPdscEa8WxSb7ZmkraL0oAlt5iXH5anhkQFexU4WrD3pn83MxF5vSZoWlwtiCi07/TePvPaD3+uONEUMrzckXJ8YBMU2186kPoAtyFWEpU0PeZOU7LZdHHsg4+Ap/fvOKkFn9efwrAL3GXCuuCxWWL3kjuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122240; c=relaxed/simple;
	bh=EtKU86Bjt7zL4OwBcCnKyEkwFO+T9ax9hCGDVKtphqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU5uxLtx4wkH+I+4GOajt4braAmidefaT5WYRs5SBemEHgD37nIENRQb87FaGw/YcHMSq012W40gnuDbPEj7NwKpW1qgvMHQnjyO5ykPtT//H6armLQHLP2L6HhoN5VDxSmhjcTry9uGQyuMYMfsATC8/JOnuzwWMFviBg1Zlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JqoYZT3A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=iQlJ1jGfLP3kl51LwIn0tRFNDq0PcCSAx+joXjcyb8k=; b=JqoYZT3AgyNV4Fl819V09n7Baj
	cdpb0T6AZb9NwHyx+e+J8WhG7NpAejZGzMmfUOwMMmZPbabo/kSz7thvZFOmQnUz1RKnkfmIFeqpI
	XmIjzBGPL6CRIlgYnD63q2P0245lI0dUHQrNRBe96XjDrrWzTTpk581A0U7qwl9UH4bnIp/0mAAFj
	oLVU83FkY51AmTPGvDYi7k0sJmSfuOxfOUkuv8BmDomdw8Ce/RlLGAYHGDhtJ8dfJ9YkSHwHnzj4V
	2qpDEyNXKnj+/kvHpt0VuS17JL5jYuLAUG91U1AAlBPYkIi3VRxXbw47AINeasLbQasCSJkhqvPCW
	Wu9osKiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnh3b-00EbYg-23;
	Fri, 22 Mar 2024 15:43:47 +0000
Date: Fri, 22 Mar 2024 15:43:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322154347.GO538574@ZenIV>
References: <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV>
 <20240322063955.GM538574@ZenIV>
 <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 22, 2024 at 02:52:16PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/03/22 14:39, Al Viro 写道:
> > On Fri, Mar 22, 2024 at 06:37:18AM +0000, Al Viro wrote:
> > > On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:
> > > 
> > > > > blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> > > > > inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> > > > > block device instead of your file_bdev(inode->i_private)? I don't see any
> > > > > advantage in stashing away that special bdev_file into inode->i_private but
> > > > > perhaps I'm missing something...
> > > > > 
> > > > 
> > > > Because we're goning to remove the 'block_device' from iomap and
> > > > buffer_head, and replace it with a 'bdev_file'.
> > > 
> > > What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
> > > just fine...
> > 
> > file->f_mapping->host, obviously - sorry.
> > .
> 
> Yes, we already get bdev_inode this way, and use it in
> blkdev_iomap_begin() and blkdev_get_block(), the problem is that if we
> want to let iomap and buffer_head to use bdev_file for raw block fops as
> well, we need a 'bdev_file' somehow.

Explain, please.  Why would anything care whether the file is bdevfs
one or coming from devtmpfs/xfs/ext2/whatnot?

