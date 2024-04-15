Return-Path: <linux-fsdevel+bounces-16924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91D8A4F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F683B20DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAE6CDCA;
	Mon, 15 Apr 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beCzbxVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7E1FA1;
	Mon, 15 Apr 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184523; cv=none; b=FUlmXe9hdhtjqowbYguSvvM4n7TVd4j/NvE3x0ULd9fi5t8OQ18AFNjkMTG0ZJeTYM5k4W/ojJ9ehGGLLo1s/CCX9RP0FFVk6+NV+ZatSJVNoYYqhnvVdvmZh6axoyWLyGMoc/Lrk46SHN+2KJNq4izd4AiCjU0KIS+z5mKeKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184523; c=relaxed/simple;
	bh=hrnNKsiFl4HrCM3TEdZKXvsxysJvx4sIVZWM4gkhccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIkPItrUqxrxpESssdz0ZV888jnObNeYAAtQoGftd39X1i9T+Nl7To7uyC52TtzncTfcGzhWb+HMuP2OpjNJIpHeoClonkE52zoxAoRbxHt7+D+hY5tVBpCV0qNkVYRisvAEBBq20WmSVUGnzPB0Z+7lCgWtpSjVwHd4mv3rSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beCzbxVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D5DC113CC;
	Mon, 15 Apr 2024 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713184523;
	bh=hrnNKsiFl4HrCM3TEdZKXvsxysJvx4sIVZWM4gkhccg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beCzbxVHD0KSF6IlXcqzWnvyQsFgKqqyNa42tkPJ1v0qHbFZOFVacn5vOSsYXFcV9
	 9FPxAgyB26IPW05giFQmiNz31Lkos5n4MRSy2koozhWoBDIKxjOPP2wExS3IhGpIzR
	 npoNcbw3dHd5r5ehN0ZCl8xZ0HTwKXY8ZncgiN1bQ1rBGz2tLuZG1GVvHcDaCtVhYh
	 mlU4sAdQeHAclRp91/9wkljjmrh+1E6GQ2k7zFK1uSKOcEE2UOJGRXtWnKSlVu5B+3
	 Df9GOwFhz9rkKV8j6Mu2a8WdNX6XmiC+vjG8d7mDkBNzI169I7pkbq3lU+TOJ97WmX
	 q8jvYITMT5U0w==
Date: Mon, 15 Apr 2024 14:35:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <20240415-haufen-demolieren-8c6da8159586@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zhzyu6pQYkSNgvuh@fedora>

On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> Hello,
> 
> On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  drivers/md/dm.c               | 23 +++++++++++++----------
> >  drivers/md/md.c               | 12 ++++++------
> >  drivers/md/md.h               |  2 +-
> >  include/linux/device-mapper.h |  2 +-
> >  4 files changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 8dcabf84d866..87de5b5682ad 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> 
> ...
> 
> > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> >  {
> >  	if (md->disk->slave_dir)
> >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > -	bdev_release(td->dm_dev.bdev_handle);
> > +	fput(td->dm_dev.bdev_file);
> 
> The above change caused regression on 'dmsetup remove_all'.
> 
> blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> returns -EBUSY, then this dm disk is skipped in remove_all().
> 
> Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> mapper guys to check if it is safe.
> 
> Or other better solution?

Yeah, I think there is. You can just switch all fput() instances in
device mapper to bdev_fput() which is mainline now. This will yield the
device and make it able to be reclaimed. Should be as simple as the
patch below. Could you test this and send a patch based on this (I'm on
a prolonged vacation so I don't have time right now.):

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..0f681a1e70af 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
        return td;

 out_blkdev_put:
-       fput(bdev_file);
+       bdev_fput(bdev_file);
 out_free_td:
        kfree(td);
        return ERR_PTR(r);
@@ -778,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
        if (md->disk->slave_dir)
                bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-       fput(td->dm_dev.bdev_file);
+       bdev_fput(td->dm_dev.bdev_file);
        put_dax(td->dm_dev.dax_dev);
        list_del(&td->list);
        kfree(td);


