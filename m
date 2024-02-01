Return-Path: <linux-fsdevel+bounces-9870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8D84591F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA38DB284FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243595CDEB;
	Thu,  1 Feb 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNFdfy0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC85339F;
	Thu,  1 Feb 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794862; cv=none; b=oTgpcs7jUktZPTui9melsK30wIY1R8NwejJZs5J1K+8XrYLElDiIZTSI8Z+3uHi0UOI079kf1ICcCgTG+PEQmRxhIzq93ocsahtqmodZKq5x9J9tB5LZKBXWcFXcJzlpy1VGoUxNKDELpReTgafzsn/lzK5dfrXuecMrf5eqCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794862; c=relaxed/simple;
	bh=qrojIL/+Tvj44yrdYZXdy7f+y1kgo68yaO3z9vmeuIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9TmvR8Pgljay//kV6oVlA4Dw/idDd/UE/sh94x+MXnTN8YZO2qEf7hYJvUMSqPsqnVqFfiYgifQBn8pT1u5q7Z9luBn1D/0vabZ8xwp/YsY7gZ5adAEf1SGP8LZfjoFnxsC+1rG6mrY/K+ZJWr5kbAFtBlXXYPnkc1IZlu9O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNFdfy0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62615C433C7;
	Thu,  1 Feb 2024 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794862;
	bh=qrojIL/+Tvj44yrdYZXdy7f+y1kgo68yaO3z9vmeuIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNFdfy0UCuErj9RRWQ+ukZosKVCjf6WBfn+eK0/SthULm3lZXIHsy8ED4Mejy9eCt
	 D5BVzgPTaGkuKK62Bqz3jWJAuCXkeWhsE1LLQ0bqfGYYc+zviS9sxPwbg7rXa3XnNp
	 KQ81i+zHjOYLtgn10sAbstFuyXMCJN0pYnLioOhrOi5kevn9ld5pAeiKSsV6c9xNJA
	 Mx2vdbFm4lBxKM39VI1rU0GgRc9VC3RXLcVIMGC0ySpC0FzeazcPQmgBEYDG9KtAjX
	 hb+eoK1aZWCsCPM1Gv4jchH0dox2jLcYBBsqPz8rRwhionLqvJPI8MKaVyQyvHJKey
	 xJjUfn45s6GLQ==
Date: Thu, 1 Feb 2024 14:40:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 34/34] ext4: rely on sb->f_bdev only
Message-ID: <20240201-filzstift-jodeln-b368ae3b26fc@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-34-adbd023e19cc@kernel.org>
 <20240201113424.xyoeubrywa3vdgxt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201113424.xyoeubrywa3vdgxt@quack3>

On Thu, Feb 01, 2024 at 12:34:24PM +0100, Jan Kara wrote:
> On Tue 23-01-24 14:26:51, Christian Brauner wrote:
> > (1) Instead of bdev->bd_inode->i_mapping we do f_bdev->f_mapping
> > (2) Instead of bdev->bd_inode we could do f_bdev->f_inode
> > 
> > I mention this explicitly because (1) is dependent on how the block
> > device is opened while (2) isn't. Consider:
> > 
> > mount -t tmpfs tmpfs /mnt
> > mknod /mnt/foo b <minor> <major>
> > open("/mnt/foo", O_RDWR);
> > 
> > then (1) doesn't work because f_bdev->f_inode is a tmpfs inode _not_ the
> > actual bdev filesystem inode. But (2) is still the bd_inode->i_mapping
> > as that's set up during bdev_open().
> > 
> > IOW, I'm explicitly _not_ going via f_bdev->f_inode but via
> > f_bdev->f_mapping->host aka bdev_file_inode(f_bdev). Currently this
> > isn't a problem because sb->s_bdev_file stashes the a block device file
> > opened via bdev_open_by_*() which is always a file on the bdev
> > filesystem.
> > 
> > _If_ we ever wanted to allow userspace to pass a block device file
> > descriptor during superblock creation. Say:
> > 
> > fsconfig(fs_fd, FSCONFIG_CMD_CREATE_EXCL, "source", bdev_fd);
> > 
> > then using f_bdev->f_inode would be very wrong. Another thing to keep in
> > mind there would be that this would implicitly pin another filesystem.
> > Say:
> > 
> > mount -t ext4 /dev/sda /mnt
> > mknod /mnt/foo b <minor> <major>
> > bdev_fd = open("/mnt/foo", O_RDWR);
> > 
> > fd_fs = fsopen("xfs")
> > fsconfig(fd_fs, FSCONFIG_CMD_CREATE, "source", bdev_fd);
> > fd_mnt = fsmount(fd_fs);
> > move_mount(fd_mnt, "/mnt2");
> > 
> > umount /mnt # EBUSY
> > 
> > Because the xfs filesystem now pins the ext4 filesystem via the
> > bdev_file we're keeping. In other words, this is probably a bad idea and
> > if we allow userspace to do this then we should only use the provided fd
> > to lookup the block device and open our own handle to it.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I suppose this is more or less a sample how to get rid of sb->s_bdev /
> bd_inode dereferences AFAICT? Because otherwise I'm not sure why it was

Yes, correct. That was just a way to show that you don't need that
anymore.

> included in this series...

Yes, that would likely go separately.

> 
> > @@ -5576,7 +5576,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	 * used to detect the metadata async write error.
> >  	 */
> >  	spin_lock_init(&sbi->s_bdev_wb_lock);
> > -	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> > +	errseq_check_and_advance(&sb->s_bdev_file->f_mapping->wb_err,
> >  				 &sbi->s_bdev_wb_err);
> 
> So when we have struct file, it would be actually nicer to drop
> EXT4_SB(sb)->s_bdev_wb_err completely and instead use
> file_check_and_advance_wb_err(sb->s_bdev_file). But that's a separate
> cleanup I suppose.

Yep. I forgot about that helper.

