Return-Path: <linux-fsdevel+bounces-7530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89AD826CE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C01F228E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F912E73;
	Mon,  8 Jan 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJRujq7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808114AA8;
	Mon,  8 Jan 2024 11:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8D6C433C7;
	Mon,  8 Jan 2024 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704713686;
	bh=CZ4UUR9DzAhYrcsiMDxKtq8/ESnYpu7oOZ+gSQKenaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJRujq7xKUv/aPi9OcaHCnxpPvk7ecJHjmYL+yT7f6mnJkL96bxwmDek3q1OkvNlY
	 datngTtr33WDAEsRxatYk9f9ia1joZFFDfl55EFvLL2Bu04ELvSPnsHJA1GPRZLRkE
	 ODUnEUXPzOBTPH2YIWdGh9PhPLsq1dJgAyEGoJV6zFeZk1y6h6sziMUkTmsqNyWVhq
	 Yf8zglJsYkHl8JjFDAbAdwPeBcXQjJ0dh4G4xF+99ITXMAqLeix7teLHVOrxCbKll1
	 yt2XeLu94DwtP0WUiZVu5HBb9SfIG/54L8I6mkGOk+npuT2Mx7tZW+/8JUfXUOxGi3
	 jrqgK0A8hzKVg==
Date: Mon, 8 Jan 2024 12:34:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 07/34] xfs: port block device access to files
Message-ID: <20240108-raunen-forsten-46a5b3f63fa1@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-7-6c8ee55fb6ef@kernel.org>
 <ZZuJUgOaYONI1fwZ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZuJUgOaYONI1fwZ@dread.disaster.area>

On Mon, Jan 08, 2024 at 04:34:10PM +1100, Dave Chinner wrote:
> On Wed, Jan 03, 2024 at 01:55:05PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/xfs/xfs_buf.c   | 10 +++++-----
> >  fs/xfs/xfs_buf.h   |  4 ++--
> >  fs/xfs/xfs_super.c | 43 +++++++++++++++++++++----------------------
> >  3 files changed, 28 insertions(+), 29 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 545c7991b9b5..685eb2a9f9d2 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -1951,7 +1951,7 @@ xfs_free_buftarg(
> >  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
> >  	/* the main block device is closed by kill_block_super */
> >  	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
> > -		bdev_release(btp->bt_bdev_handle);
> > +		fput(btp->bt_f_bdev);
> 
> bt_bdev_file, please.
> 
> "_f_" is not a meaningful prefix, and if we fill the code up with
> single letter prefixes is becomes completely unreadable. 

Ack to all suggestions.

> 
> >  
> >  	kmem_free(btp);
> >  }
> > @@ -1994,7 +1994,7 @@ xfs_setsize_buftarg_early(
> >  struct xfs_buftarg *
> >  xfs_alloc_buftarg(
> >  	struct xfs_mount	*mp,
> > -	struct bdev_handle	*bdev_handle)
> > +	struct file		*f_bdev)
> 
> 	struct file		*bdev_file)
> >  {
> >  	xfs_buftarg_t		*btp;
> >  	const struct dax_holder_operations *ops = NULL;
> > @@ -2005,9 +2005,9 @@ xfs_alloc_buftarg(
> >  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
> >  
> >  	btp->bt_mount = mp;
> > -	btp->bt_bdev_handle = bdev_handle;
> > -	btp->bt_dev = bdev_handle->bdev->bd_dev;
> > -	btp->bt_bdev = bdev_handle->bdev;
> > +	btp->bt_f_bdev = f_bdev;
> > +	btp->bt_bdev = F_BDEV(f_bdev);
> 
> file_bdev(), please. i.e. similar to file_inode().
> 
> 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 0e64220bffdc..01ef0ef83c41 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -362,16 +362,16 @@ STATIC int
> >  xfs_blkdev_get(
> >  	xfs_mount_t		*mp,
> >  	const char		*name,
> > -	struct bdev_handle	**handlep)
> > +	struct file		**f_bdevp)
> 
> 	struct file		**filep
> 
> >  {
> >  	int			error = 0;
> >  
> > -	*handlep = bdev_open_by_path(name,
> > +	*f_bdevp = bdev_file_open_by_path(name,
> >  		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
> >  		mp->m_super, &fs_holder_ops);
> > -	if (IS_ERR(*handlep)) {
> > -		error = PTR_ERR(*handlep);
> > -		*handlep = NULL;
> > +	if (IS_ERR(*f_bdevp)) {
> > +		error = PTR_ERR(*f_bdevp);
> > +		*f_bdevp = NULL;
> >  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
> >  	}
> >  
> > @@ -436,26 +436,25 @@ xfs_open_devices(
> >  {
> >  	struct super_block	*sb = mp->m_super;
> >  	struct block_device	*ddev = sb->s_bdev;
> > -	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
> > +	struct file		*f_logdev = NULL, *f_rtdev = NULL;
> 
> 	struct file		*logdev_file = NULL;
> 	struct file		*rtdev_file = NULL;
> ...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

