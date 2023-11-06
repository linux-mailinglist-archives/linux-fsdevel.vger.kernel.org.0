Return-Path: <linux-fsdevel+bounces-2104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FAA7E2885
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAD62814F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7A28DDF;
	Mon,  6 Nov 2023 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DY0nPuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5i70PJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6828DD7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 15:18:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CBF3;
	Mon,  6 Nov 2023 07:18:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60BEA1FF9A;
	Mon,  6 Nov 2023 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699283907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EiBnCxtqYOZ3wNMkJly8DGIq5dz+B7Xw3NhuZueafc=;
	b=3DY0nPuBkXf62i+NVMOQCamLUXEGrAFFa+i1Cbq5VzCmqFwh5K+XjKoER/uMRO3iQBinFe
	S8tpv5GGxKnSkA9ErvzrL1k2YkC/G16O6VpBIjxgGMJCIz1g3qqueM+8vJ5YWDefGJUJum
	QTBY2MuMSJ44HHorwQbwwtqS2gp1sGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699283907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EiBnCxtqYOZ3wNMkJly8DGIq5dz+B7Xw3NhuZueafc=;
	b=m5i70PJqwNPaDymbcW1gwafQPRPLLYytyMRgfxeRp1vWV3rb1lU3ZENZ3FPaD6yWircvCi
	FW9paSfyw/n1t+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 527EC138E5;
	Mon,  6 Nov 2023 15:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id me0cFMMDSWXgJAAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 06 Nov 2023 15:18:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6320A07BE; Mon,  6 Nov 2023 16:18:26 +0100 (CET)
Date: Mon, 6 Nov 2023 16:18:26 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 3/7] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231106151826.wxjw6ullsx6mhmov@quack3>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-3-jack@suse.cz>
 <20231106-einladen-macht-30a9ad957294@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-einladen-macht-30a9ad957294@brauner>

On Mon 06-11-23 15:47:54, Christian Brauner wrote:
> On Wed, Nov 01, 2023 at 06:43:08PM +0100, Jan Kara wrote:
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add tracking of writers to each block device and a kernel cmdline
> > argument which controls whether other writeable opens to block devices
> > open with BLK_OPEN_RESTRICT_WRITES flag are allowed. We will make
> > filesystems use this flag for used devices.
> > 
> > Note that this effectively only prevents modification of the particular
> > block device's page cache by other writers. The actual device content
> > can still be modified by other means - e.g. by issuing direct scsi
> > commands, by doing writes through devices lower in the storage stack
> > (e.g. in case loop devices, DM, or MD are involved) etc. But blocking
> > direct modifications of the block device page cache is enough to give
> > filesystems a chance to perform data validation when loading data from
> > the underlying storage and thus prevent kernel crashes.
> > 
> > Syzbot can use this cmdline argument option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this option for hardening.
> > 
> > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> A few minor tweaks I would do in-tree. Please see below.
> I know it's mostly stylistic that's why I would do it so there's no
> resend dance for non-technical reasons.

Whatever works best for you. I agree with the changes but please see my
comments below for some fixes.

> >  block/Kconfig             | 20 +++++++++++++
> >  block/bdev.c              | 62 ++++++++++++++++++++++++++++++++++++++-
> >  include/linux/blk_types.h |  1 +
> >  include/linux/blkdev.h    |  2 ++
> >  4 files changed, 84 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/Kconfig b/block/Kconfig
> > index f1364d1c0d93..ca04b657e058 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -78,6 +78,26 @@ config BLK_DEV_INTEGRITY_T10
> >  	select CRC_T10DIF
> >  	select CRC64_ROCKSOFT
> >  
> > +config BLK_DEV_WRITE_MOUNTED
> > +	bool "Allow writing to mounted block devices"
> > +	default y
> 
> Let's hope that this can become the default one day.

Yes, I'd hope as well but we need some tooling work (util-linux, e2fsprogs)
before that can happen.

> > +static void bdev_unblock_writes(struct block_device *bdev)
> > +{
> > +	bdev->bd_writers = 0;
> > +}
> > +
> > +static bool blkdev_open_compatible(struct block_device *bdev, blk_mode_t mode)
> 
> I would like to mirror our may_{open,create}() routines here and call
> this:
> 
>     bdev_may_open()
> 
> This is a well-known vfs pattern and also easy to understand for block
> devs as well.

Sure.

> > @@ -800,12 +834,21 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> >  		goto abort_claiming;
> >  	if (!try_module_get(disk->fops->owner))
> >  		goto abort_claiming;
> > +	ret = -EBUSY;
> > +	if (!blkdev_open_compatible(bdev, mode))
> > +		goto abort_claiming;
> >  	if (bdev_is_partition(bdev))
> >  		ret = blkdev_get_part(bdev, mode);
> >  	else
> >  		ret = blkdev_get_whole(bdev, mode);
> >  	if (ret)
> >  		goto put_module;
> > +	if (!bdev_allow_write_mounted) {
> > +		if (mode & BLK_OPEN_RESTRICT_WRITES)
> > +			bdev_block_writes(bdev);
> > +		else if (mode & BLK_OPEN_WRITE)
> > +			bdev->bd_writers++;
> > +	}
> 
> I would like to move this to a tiny helper for clarity:
> 
> static void bdev_claim_write_access(struct block_device *bdev)
> {
>         if (!bdev_allow_write_mounted)

This should be the other way around.

>                 return;
> 
>         /* Claim exclusive or shared write access to the block device. */
>         if (mode & BLK_OPEN_RESTRICT_WRITES)
>                 bdev_block_writes(bdev);
>         else if (mode & BLK_OPEN_WRITE)
>                 bdev->bd_writers++;
> }
> 
> >  	if (holder) {
> >  		bd_finish_claiming(bdev, holder, hops);
> >  
> > @@ -901,6 +944,14 @@ void bdev_release(struct bdev_handle *handle)
> >  		sync_blockdev(bdev);
> >  
> >  	mutex_lock(&disk->open_mutex);
> > +	if (!bdev_allow_write_mounted) {
> > +		/* The exclusive opener was blocking writes? Unblock them. */
> > +		if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
> > +			bdev_unblock_writes(bdev);
> > +		else if (handle->mode & BLK_OPEN_WRITE)
> > +			bdev->bd_writers--;
> > +	}
> 
> static void bdev_yield_write_access(struct block_device *bdev)
> {
>         if (!bdev_allow_write_mounted)

And this as well.

>                 return;
> 
>         /* Yield exclusive or shared write access. */
>         if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
>                 bdev_unblock_writes(bdev);
>         else if (handle->mode & BLK_OPEN_WRITE)
>                 bdev->bd_writers--;
> }

								Honza
 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

