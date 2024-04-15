Return-Path: <linux-fsdevel+bounces-16944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6888A55A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E11C21F19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74874E3A;
	Mon, 15 Apr 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyS0H7E3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F522433C9;
	Mon, 15 Apr 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192829; cv=none; b=iVH8PZzDmLYW+U7uPOCXirZ+YghrLcJjmsQRC+5sVEjsVuunldGMisLwL6A2GfgbcwtQGCjUEKYEPiRW628ylE+uv0WMkajM5Qc6icEKQ2bluDU4onvv0+HEiEymmsBSxUu+pYV47SG4X0HxDswwvXgsez6cC7tDO23IbUvxgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192829; c=relaxed/simple;
	bh=RnxLzAEkXSaKiwpNETr4zwu6nWkTxfTBo96/CP3i0PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCaod5pTjJ0bGRlbWt9fu7O99fP+v+NJkdwmuZ0pDMNVYfl8HU3HeutwxXPhpa4mJ/FYLWOu6E5gdIDGhmyO/ghJp7wpzyhtMNlZqUQSv2VH1XiDQUqiXwMDhfOvwkmFyr85FedQ1FIo3RvxiaTaNahJ+b8ZXvJ2B2fNY1eKFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyS0H7E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C46C113CC;
	Mon, 15 Apr 2024 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192828;
	bh=RnxLzAEkXSaKiwpNETr4zwu6nWkTxfTBo96/CP3i0PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyS0H7E3bDxAj5JL40daKZsxMQ3N0wG9udAe7Er0biMIpT2uVlD+hYtNWYbuwv1ns
	 eMNQraTE+5ZVEA74XkRi+X+IOqUOffxIzA00s6rwoJ8eQnvGXlOOL6EkMv3sUGmHtd
	 GHL5wYWuUsmxC8gMofEFHpqEam3Pf5ifli5KjG8o3WpISc1nWe6GLvIBUu9wP1Yqvg
	 m/qg5lHLWBPoGi+1s5HXrZbwxyN4KBp9HrH1R/rM8JYAk6K+SLtzWjt38pQ20ECVl4
	 lyfV3XNhTocKEHsOn8Z1V9gGxUxGIHKe7qvy11SwNzZDTu9p0K+XoG15zitObrMRbD
	 YEFccTbjmn81w==
Date: Mon, 15 Apr 2024 16:53:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <20240415-neujahr-schummeln-c334634ab5ad@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
 <20240415-haufen-demolieren-8c6da8159586@brauner>
 <Zh07Sc3lYStOWK8J@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh07Sc3lYStOWK8J@fedora>

On Mon, Apr 15, 2024 at 10:35:53PM +0800, Ming Lei wrote:
> On Mon, Apr 15, 2024 at 02:35:17PM +0200, Christian Brauner wrote:
> > On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> > > Hello,
> > > 
> > > On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  drivers/md/dm.c               | 23 +++++++++++++----------
> > > >  drivers/md/md.c               | 12 ++++++------
> > > >  drivers/md/md.h               |  2 +-
> > > >  include/linux/device-mapper.h |  2 +-
> > > >  4 files changed, 21 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > index 8dcabf84d866..87de5b5682ad 100644
> > > > --- a/drivers/md/dm.c
> > > > +++ b/drivers/md/dm.c
> > > 
> > > ...
> > > 
> > > > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> > > >  {
> > > >  	if (md->disk->slave_dir)
> > > >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > > > -	bdev_release(td->dm_dev.bdev_handle);
> > > > +	fput(td->dm_dev.bdev_file);
> > > 
> > > The above change caused regression on 'dmsetup remove_all'.
> > > 
> > > blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> > > returns -EBUSY, then this dm disk is skipped in remove_all().
> > > 
> > > Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> > > mapper guys to check if it is safe.
> > > 
> > > Or other better solution?
> > 
> > Yeah, I think there is. You can just switch all fput() instances in
> > device mapper to bdev_fput() which is mainline now. This will yield the
> > device and make it able to be reclaimed. Should be as simple as the
> > patch below. Could you test this and send a patch based on this (I'm on
> > a prolonged vacation so I don't have time right now.):
> 
> Unfortunately it doesn't work.
> 
> Here the problem is that blkdev_release() is delayed, which changes
> 'dmsetup remove_all' behavior, and causes that some of dm disks aren't
> removed.
> 
> Please see dm_lock_for_deletion() and dm_blk_open()/dm_blk_close().

So you really need blkdev_release() itself to be synchronous? Groan, in
that case use __fput_sync() instead of fput() which ensures that this
file is closed synchronously.

