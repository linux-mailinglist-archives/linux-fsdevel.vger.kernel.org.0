Return-Path: <linux-fsdevel+bounces-725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5207CF2A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AB71F23A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507E15AD2;
	Thu, 19 Oct 2023 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3MRcV+v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgBaToaR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96D15AC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:34:14 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD410F;
	Thu, 19 Oct 2023 01:34:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 945241F459;
	Thu, 19 Oct 2023 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697704450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4zASi8pyt2DJnC5OJSjfqH1Uj7s2mVggiUJB9ZeZ6U=;
	b=e3MRcV+vOfUM6zohISVryxhdicNgQJ4dJti3S7M2axSQ9DUFpIeY96wC9574Bt1jXbHwB8
	UDMQbtiQ7si7QgGn3z6gizPFi2oDMWBXpM2gSFRK9Prb9fSgUz58anKbYLih66AyHtrv/X
	JLDNBFCKhnrfG+FJm9cjpDzCRlZ8hzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697704450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4zASi8pyt2DJnC5OJSjfqH1Uj7s2mVggiUJB9ZeZ6U=;
	b=XgBaToaRzx3sodtJ1F7dufO3Q8gmcuzpNrfps+JrFHIn+cp7ObuW3S5ZEw89aDqKhpDWXk
	6U5t21Tvxg/B7lCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 852CC1357F;
	Thu, 19 Oct 2023 08:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FTfmHwLqMGUDPgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 08:34:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A9EDA06B0; Thu, 19 Oct 2023 10:34:10 +0200 (CEST)
Date: Thu, 19 Oct 2023 10:34:09 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231019083409.px2y3dgrkanobbma@quack3>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-4-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue 17-10-23 20:48:21, Christoph Hellwig wrote:
> disk_check_media_change is mostly called from ->open where it makes
> little sense to mark the file system on the device as dead, as we
> are just opening it.  So instead of calling bdev_mark_dead from
> disk_check_media_change move it into the few callers that are not
> in an open instance.  This avoid calling into bdev_mark_dead and
> thus taking s_umount with open_mutex held.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice and looks good to me (with the fixed up export). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  block/disk-events.c     | 18 +++++++-----------
>  drivers/block/ataflop.c |  4 +++-
>  drivers/block/floppy.c  |  4 +++-
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/block/disk-events.c b/block/disk-events.c
> index 13c3372c465a39..2f697224386aa8 100644
> --- a/block/disk-events.c
> +++ b/block/disk-events.c
> @@ -266,11 +266,8 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
>   * disk_check_media_change - check if a removable media has been changed
>   * @disk: gendisk to check
>   *
> - * Check whether a removable media has been changed, and attempt to free all
> - * dentries and inodes and invalidates all block device page cache entries in
> - * that case.
> - *
> - * Returns %true if the media has changed, or %false if not.
> + * Returns %true and marks the disk for a partition rescan whether a removable
> + * media has been changed, and %false if the media did not change.
>   */
>  bool disk_check_media_change(struct gendisk *disk)
>  {
> @@ -278,12 +275,11 @@ bool disk_check_media_change(struct gendisk *disk)
>  
>  	events = disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
>  				   DISK_EVENT_EJECT_REQUEST);
> -	if (!(events & DISK_EVENT_MEDIA_CHANGE))
> -		return false;
> -
> -	bdev_mark_dead(disk->part0, true);
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	return true;
> +	if (events & DISK_EVENT_MEDIA_CHANGE) {
> +		set_bit(GD_NEED_PART_SCAN, &disk->state);
> +		return true;
> +	}
> +	return false;
>  }
>  EXPORT_SYMBOL(disk_check_media_change);
>  
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index cd738cab725f39..50949207798d2a 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1760,8 +1760,10 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		/* invalidate the buffer track to force a reread */
>  		BufferDrive = -1;
>  		set_bit(drive, &fake_change);
> -		if (disk_check_media_change(disk))
> +		if (disk_check_media_change(disk)) {
> +			bdev_mark_dead(disk->part0, true);
>  			floppy_revalidate(disk);
> +		}
>  		return 0;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index ea4eb88a2e45f4..11114a5d9e5c46 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3215,8 +3215,10 @@ static int invalidate_drive(struct gendisk *disk)
>  	/* invalidate the buffer track to force a reread */
>  	set_bit((long)disk->private_data, &fake_change);
>  	process_fd_request();
> -	if (disk_check_media_change(disk))
> +	if (disk_check_media_change(disk)) {
> +		bdev_mark_dead(disk->part0, true);
>  		floppy_revalidate(disk);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

