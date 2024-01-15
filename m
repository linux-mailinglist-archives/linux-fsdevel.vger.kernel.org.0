Return-Path: <linux-fsdevel+bounces-7947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3582DB35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFBD1F22839
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05AB17599;
	Mon, 15 Jan 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS9ObrKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5717587;
	Mon, 15 Jan 2024 14:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08F2C43394;
	Mon, 15 Jan 2024 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705328703;
	bh=5apflpn4fECSQ55zxglCTrqEv8mnTukoOngCiY3USUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lS9ObrKpmxPfpvwOytLQF3ueQpYUdSMiGoXV+TOm+9WIqPvobEq3z0RygRJjxRp1G
	 1d1SY89b180cHDuqg3hnk+zw1Vqhhvlmo1FN1pBriSDW5jH82XnFJPdUaNc9/K2mA5
	 B43DSVtwInozWbGBqqbHCT/5HRGsQhFdRkOpYi6Tc2wuucxdmCYJ2edtidyv5U0rkk
	 +C/MQz9+UVlKvyjwfyQX3DvKOw9MWRmfGBYVYbQIXASEGCW/Gcq4u7CvUdqIDUKu6I
	 BHGLhoBbKYgdzh/J0eOYIl2VbgQd8mdHS6MCpKcKS/PacR7P/bumNMbMbD2CEKDstB
	 mBZ2JS8MgfA0g==
Date: Mon, 15 Jan 2024 15:24:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/34] Open block devices as files & a bd_inode
 proposal
Message-ID: <20240115-fluide-solvent-72c82ea973cc@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240108162641.GA7842@lst.de>
 <20240109084627.p6nekbvq6wpiqq3x@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109084627.p6nekbvq6wpiqq3x@quack3>

On Tue, Jan 09, 2024 at 09:46:27AM +0100, Jan Kara wrote:
> On Mon 08-01-24 17:26:41, Christoph Hellwig wrote:
> > On Wed, Jan 03, 2024 at 01:54:58PM +0100, Christian Brauner wrote:
> > > I wanted to see whether we can make struct bdev_handle completely
> > > private to the block layer in the next cycle and unexport low-level
> > > helpers such as bdev_release() - formerly blkdev_put() - completely.
> > 
> > I think we can actually kill bdev_handle entirely.  We can get the
> > bdev from the bdev inode using I_BDEV already, so no need to store
> > the bdev.  We don't need the mode field as we known an exlusive
> > open is equivalent to having a holder.  So just store the older in
> > file->private_data and the bdev_handle can be removed again.
> 
> Well, we also need the read-write mode of the handle in some places but that
> could be stored in file->f_mode (not sure if it really gets stored there
> in this patch set - still need to read the details) so in principle I agree
> that bdev_handle should not be necessary.

So I think I've found a way to not even use a new fmode flag for this.
We can just use a set of file operations def_blk_fops_restricted to
detect when a block device was opened with restricted write access.
def_blk_fops isn't needed to check whether something is a block device
IS_BLK() is enough for that. And def_blk_fops_restricted can be kept
completely local to block/.

