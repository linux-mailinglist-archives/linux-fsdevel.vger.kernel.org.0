Return-Path: <linux-fsdevel+bounces-8267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF82831E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69D21F21A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB262C85B;
	Thu, 18 Jan 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmYc+ni9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858A2C846;
	Thu, 18 Jan 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598536; cv=none; b=PYiksGfGtJsdv6I+yWkhj92rkI7WrCj196Gen8rSxAL8llaMwybQZ0R9PAhkbYEHFZB7pK8rpt/7D+FBHWGI8P87an1SafGw04UH/9uM23HC1ecFqfL3anavdQNwD841+NwNLYOpwG6OBNCskD1sg+00h5/hLqW7XAHD59ua7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598536; c=relaxed/simple;
	bh=W4qYmQKnapA3pGKjvBRYcobIrqaJtaIz2f5T1nFmVyM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=H31/8eiHNo3pNrGE60G1rf0VE4ZCu9VAhzMg2a+EaToojbFxkjl69Lhs3ztORC+mJ6aFegKFyiLJWZ8L1rJ9W3/dM6CiulVaQQ0QqMNm/3Ud8goBLUz2wpQ/WtX21+aWyOpvkpTPjqAPC+KWJI4ZgiBmBxG0LYIIdDwFDUPmiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmYc+ni9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F0BC433C7;
	Thu, 18 Jan 2024 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598536;
	bh=W4qYmQKnapA3pGKjvBRYcobIrqaJtaIz2f5T1nFmVyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmYc+ni9CeD3oNAtH1550bA/SHR9cKC+2i6yOwJ3Wuti4E99iHeNIJMLt0RdaS4hs
	 UO/IwAc9vDTepe4fwp8RN8c/bIn/jxViWkisTtKIcMnUrfdAICrz+MpZsGZmHsFanu
	 em2zA/udYJzHKoEDoduEZ/vrQ0HaMu3bph4QTa50FIuuYMpHWh4L34dqNl9GKzipw4
	 cl9CeNQAgdAFaq6k7wAkZod4gMUrYlF4BzdKN69Ls8zZSupn33Ba/qpkD9CPB0pYq7
	 r3DRDTCO/Jmxrmz59PCB3KO1q7N3EiST3Adcr3gVm/TkC77MnrJCFY1cWiM4F9l7bK
	 eCUf+o8SbEevA==
Date: Thu, 18 Jan 2024 18:22:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 01/34] bdev: open block device as files
Message-ID: <20240118-unangebracht-audienz-94b835928ac7@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
 <20240117153107.pilkkl56ngpp3xlj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117153107.pilkkl56ngpp3xlj@quack3>

On Wed, Jan 17, 2024 at 04:31:07PM +0100, Jan Kara wrote:
> On Wed 03-01-24 13:54:59, Christian Brauner wrote:
> > +struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> > +				   const struct blk_holder_ops *hops)
> > +{
> > +	struct file *file;
> > +	struct bdev_handle *handle;
> > +	unsigned int flags;
> > +
> > +	handle = bdev_open_by_dev(dev, mode, holder, hops);
> > +	if (IS_ERR(handle))
> > +		return ERR_CAST(handle);
> > +
> > +	flags = blk_to_file_flags(mode);
> > +	file = alloc_file_pseudo(handle->bdev->bd_inode, blockdev_mnt, "",
> > +				 flags | O_LARGEFILE, &def_blk_fops);
> > +	if (IS_ERR(file)) {
> > +		bdev_release(handle);
> > +		return file;
> > +	}
> > +	ihold(handle->bdev->bd_inode);
> > +
> > +	file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT | FMODE_NOACCOUNT;
> > +	if (bdev_nowait(handle->bdev))
> > +		file->f_mode |= FMODE_NOWAIT;
> > +
> > +	file->f_mapping = handle->bdev->bd_inode->i_mapping;
> > +	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
> > +	file->private_data = handle;
> > +	return file;
> 
> Maybe I'm dense but when the file is closed where do we drop the
> bdev_handle?

It's just a bit hidden. blkdev_release() wraps bdev_release():
file->f_op->release::blkdev_release()
-> bdev_release()
But in the updated version the handle is removed completely.

