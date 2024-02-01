Return-Path: <linux-fsdevel+bounces-9902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D619845D3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F756B2E617
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EF5A4DA;
	Thu,  1 Feb 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivSDdJxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1035A4C3;
	Thu,  1 Feb 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804333; cv=none; b=Tqnae1X3Y0awDBLStmoR7kmRgfAa4p7ftCY489q6VubiaGx1QI9MXEbLFa3+Ra4tGyCI4sIClRShgqj+Xp3pWbHD+OpmWJSUHfju7Yl9biyFEybFsJqm/hf+a/7Y7O0usbntu7ZIMsZP9A8uqwiS6YDgIOdsG6wzQeVWsF+HVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804333; c=relaxed/simple;
	bh=UZmbUKHXlhkMEPOD9A8kR+s6s65NGkta6aTiFLQhrgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+6wGiYlczTdb0u5264F7nR3XWdJC4SbKNu3H7t1XFmn2rmqCrD3jmuXGULnLgI82NonkGdLgTbb7aJfAxmEJoJUieS3Agbm/RckkBK5jkGuDUfSh3eIkxGmYCIaSZvX58ipeR1a/3OfNN1P9zZ6NisGPG9NCYGADfoQZ5Nh6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivSDdJxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C754C433C7;
	Thu,  1 Feb 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804333;
	bh=UZmbUKHXlhkMEPOD9A8kR+s6s65NGkta6aTiFLQhrgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivSDdJxP9xKI6qpwHYtY4RiDtbdhMsH9F6VNs+v7MRM+yO/vgZIbWg+hYTKBe5NXw
	 vvf217dfMoycYCIeCEJw1LQx27UF//4/kQvM3yM/xV43EwX9U8KassW422775KO2BF
	 CixEgWmEv3Uv2zAmKwYHhgc8sLEw77wLfRm5GVPPLcgJ8eRncrkzR/M+MGMVxH4pmp
	 Ol3Enf10Na1XO676ClUnzFaWwWdpGrA+Yp7+zcftdyyD90NxKHRDK1D4+zREk8btl+
	 3W/Up/QKz2AF22VVgDEEUIa5oxsher3weLUxI2N2FLmtB3OBrimg6KH977Vo7OeSRg
	 fZiNEtuicbtrg==
Date: Thu, 1 Feb 2024 17:18:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 32/34] block: remove bdev_handle completely
Message-ID: <20240201-krokus-geerbt-d66e1068b88b@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-32-adbd023e19cc@kernel.org>
 <20240201112008.6kdph4ctuyeck5tq@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201112008.6kdph4ctuyeck5tq@quack3>

On Thu, Feb 01, 2024 at 12:20:08PM +0100, Jan Kara wrote:
> On Tue 23-01-24 14:26:49, Christian Brauner wrote:
> > We just need to use the holder to indicate whether a block device open
> > was exclusive or not. We did use to do that before but had to give that
> > up once we switched to struct bdev_handle. Before struct bdev_handle we
> > only stashed stuff in file->private_data if this was an exclusive open
> > but after struct bdev_handle we always set file->private_data to a
> > struct bdev_handle and so we had to use bdev_handle->mode or
> > bdev_handle->holder. Now that we don't use struct bdev_handle anymore we
> > can revert back to the old behavior.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Two small comments below.
> 
> > diff --git a/block/fops.c b/block/fops.c
> > index f56bdfe459de..a0bff2c0d88d 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -569,7 +569,6 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
> >  blk_mode_t file_to_blk_mode(struct file *file)
> >  {
> >  	blk_mode_t mode = 0;
> > -	struct bdev_handle *handle = file->private_data;
> >  
> >  	if (file->f_mode & FMODE_READ)
> >  		mode |= BLK_OPEN_READ;
> > @@ -579,8 +578,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
> >  	 * do_dentry_open() clears O_EXCL from f_flags, use handle->mode to
> >  	 * determine whether the open was exclusive for already open files.
> >  	 */
> ^^^ This comment needs update now...
> 
> > -	if (handle)
> > -		mode |= handle->mode & BLK_OPEN_EXCL;
> > +	if (file->private_data)
> > +		mode |= BLK_OPEN_EXCL;
> >  	else if (file->f_flags & O_EXCL)
> >  		mode |= BLK_OPEN_EXCL;
> >  	if (file->f_flags & O_NDELAY)
> > @@ -601,12 +600,17 @@ static int blkdev_open(struct inode *inode, struct file *filp)
> >  {
> >  	struct block_device *bdev;
> >  	blk_mode_t mode;
> > -	void *holder;
> >  	int ret;
> >  
> > +	/*
> > +	 * Use the file private data to store the holder for exclusive opens.
> > +	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
> > +	 */
> > +	if (filp->f_flags & O_EXCL)
> > +		filp->private_data = filp;
> 
> Well, if we have O_EXCL in f_flags here, then file_to_blk_mode() on the
> next line is going to do the right thing and set BLK_OPEN_EXCL even
> without filp->private_data. So this shound't be needed AFAICT.

Fixed.

