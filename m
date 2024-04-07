Return-Path: <linux-fsdevel+bounces-16308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A389AE0A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9DE1F21BA1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926B63A9;
	Sun,  7 Apr 2024 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rkrGxEZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337E3D69;
	Sun,  7 Apr 2024 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712456584; cv=none; b=Qf/EMuXrwIqvOfuzBpzEfo8B2xxKk916ZRC2aUBC0gQ3RsPbsRl1QmKlpaT6zo8q+rdEg4PTkvcOq7AIgVGBAqMXGVNUPk1+U0vDSvO0TYiiG4TMKIf3JtKXiq9Sfg3Un+QAbHEdgE00cveujGBNYMCE+BR3sDJG4ZJ/pJ6neFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712456584; c=relaxed/simple;
	bh=O0gVYLZDVDmnvBNfknW/sjULkd1ROat4iHgwFF2m27Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPGZlz+hSckTixQhNmwBmD0yZtTcRQRKwfAS2GR+KLgFj9SWCxeZXVzAuGec8hJr6TPYxfrREGxCAjodJ0a8w/L4TvWpR8MdAAooaD/MA2H13TVwb7jSmIm/mDSU80UmeqVC0kB6/E+FaFNoFE3KNxjYQ3NMKzSPfnCj0gEJhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rkrGxEZU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q4Jrd91tRAWgR9sEBFtYYl4wg0aYCXzXxq/qXO1MqdU=; b=rkrGxEZUBxFKZXxAayR/M/IzHg
	3UyMpw1X9z1Z0FaSBoERu94R6JJcjzrXriWjftKcQmVnttPdpsj/XgLngQj4L2Jx/ko1qDnTBfLbn
	s9/UoApu7sNJY8nYL84BFfYMiSpQ9AzsbZu8eJsLa6x7R27ybQWBh13hS4gRP3huQAKGCBrt28TSl
	HuvP7Ahq0YbU+/5bOP/QYQp+ZzeRx5W5V9c6j+vprVRoijdK7mdpRY/nOlS9AHOHI60UV1ofhdJQM
	XC6zFtkBHDd+GEnJaGefJY2KNRYNDNOB4fzCLRCourSOrcXf2Gjejfl2f30Xff1dllCcvWFaqdRCj
	R0PanYgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtIBG-007XqA-1a;
	Sun, 07 Apr 2024 02:22:50 +0000
Date: Sun, 7 Apr 2024 03:22:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 04/26] block: prevent direct access of bd_inode
Message-ID: <20240407022250.GH538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406090930.2252838-5-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 05:09:08PM +0800, Yu Kuai wrote:
> @@ -669,7 +669,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct block_device *bdev = I_BDEV(file->f_mapping->host);
> -	struct inode *bd_inode = bdev->bd_inode;
> +	struct inode *bd_inode = bdev_inode(bdev);

What you want here is this:

	struct inode *bd_inode = file->f_mapping->host;
	struct block_device *bdev = I_BDEV(bd_inode);


> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -97,7 +97,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  {
>  	uint64_t range[2];
>  	uint64_t start, len;
> -	struct inode *inode = bdev->bd_inode;
> +	struct inode *inode = bdev_inode(bdev);
>  	int err;

The uses of 'inode' in this function are
        filemap_invalidate_lock(inode->i_mapping);
and
        filemap_invalidate_unlock(inode->i_mapping);

IOW, you want bdev_mapping(bdev), not bdev_inode(bdev).

> @@ -166,7 +166,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>  {
>  	uint64_t range[2];
>  	uint64_t start, end, len;
> -	struct inode *inode = bdev->bd_inode;
> +	struct inode *inode = bdev_inode(bdev);

Same story.

