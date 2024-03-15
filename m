Return-Path: <linux-fsdevel+bounces-14461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A3087CECF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265342811E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59752381B3;
	Fri, 15 Mar 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KppBX0Ui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgpUIW3t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KppBX0Ui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgpUIW3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5D25543;
	Fri, 15 Mar 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512886; cv=none; b=eauNNy+HFAvwQvM/t0fU9ujg2tgRw28ZoWvA20IlEKx74EdOAs54WoCdGyRrdqfK0ZeNfcb6dPGlWE4RnVYohwM7IN2tU6X2asHZZ9Fht98diMlaieuD39+3Yix/nSdTDZikunMTyP7NGW6gv4YxLjJoNlgbeuND2QUpGyFKl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512886; c=relaxed/simple;
	bh=ptKcQGvNLExqOhWDrtAimTpFjorljsqetWFvr5qfxag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8Dirc/Qi1HBdr8DV6kANlp/1quHAuzsbgqNTBXOz4d2hXvtU13rMh1sXLTrkI5jd1PR0DlAFmoSbhNfNTsdE375GKH/luk1cVDNPRTp03hIQguPea8S/sqOMFOHJEfEuH/dzTBiriSCe2oue5faxKGnBkiSuLOlBedwE/xVmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KppBX0Ui; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgpUIW3t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KppBX0Ui; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgpUIW3t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A96B41FB6E;
	Fri, 15 Mar 2024 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710512882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qcP3WTXoxRhAHwlYfBjFyJGoKiUMi4+gC0JUW+zVvY=;
	b=KppBX0UivD4PuOE4zhwUFMF9p4+T3UIi2G4kMtA8DK5u58cqlX07hs0NQlo86xeYEKmDQU
	eC5v+Iggp+AD7JSmGHvJOlDMimspS0nKVekk17igIaDZEgbKxDO5g0dM0OqKxxOObhnwwr
	sYlRHaLrN5Z8IEIeYltb7wpVlgVvOrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710512882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qcP3WTXoxRhAHwlYfBjFyJGoKiUMi4+gC0JUW+zVvY=;
	b=PgpUIW3tv+/la6mofkVRiS4LmyzUtuU24as4Sv3XYT5+PxC3DrwY+gLwPf0q2JZYUkGkUI
	g5cQUUsZTRqVMBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710512882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qcP3WTXoxRhAHwlYfBjFyJGoKiUMi4+gC0JUW+zVvY=;
	b=KppBX0UivD4PuOE4zhwUFMF9p4+T3UIi2G4kMtA8DK5u58cqlX07hs0NQlo86xeYEKmDQU
	eC5v+Iggp+AD7JSmGHvJOlDMimspS0nKVekk17igIaDZEgbKxDO5g0dM0OqKxxOObhnwwr
	sYlRHaLrN5Z8IEIeYltb7wpVlgVvOrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710512882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qcP3WTXoxRhAHwlYfBjFyJGoKiUMi4+gC0JUW+zVvY=;
	b=PgpUIW3tv+/la6mofkVRiS4LmyzUtuU24as4Sv3XYT5+PxC3DrwY+gLwPf0q2JZYUkGkUI
	g5cQUUsZTRqVMBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F3BE1383D;
	Fri, 15 Mar 2024 14:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fMzbJvJa9GX+PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:28:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46625A07D9; Fri, 15 Mar 2024 15:28:02 +0100 (CET)
Date: Fri, 15 Mar 2024 15:28:02 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs,block: get holder during claim
Message-ID: <20240315142802.i3ja63b4b7l3akeb@quack3>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-freibad-annehmbar-ca68c375af91@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 15-03-24 14:23:07, Christian Brauner wrote:
> Now that we open block devices as files we need to deal with the
> realities that closing is a deferred operation. An operation on the
> block device such as e.g., freeze, thaw, or removal that runs
> concurrently with umount, tries to acquire a stable reference on the
> holder. The holder might already be gone though. Make that reliable by
> grabbing a passive reference to the holder during bdev_open() and
> releasing it during bdev_release().
> 
> Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/r/ZfEQQ9jZZVes0WCZ@infradead.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey all,
> 
> I ran blktests with nbd enabled which contains a reliable repro for the
> issue. Thanks to Christoph for pointing in that direction. The
> underlying issue is not reproducible anymore with this patch applied.
> xfstests and blktests pass.

Thanks for the fix! It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> diff --git a/block/bdev.c b/block/bdev.c
> index e7adaaf1c219..7a5f611c3d2e 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -583,6 +583,9 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
>  	mutex_unlock(&bdev->bd_holder_lock);
>  	bd_clear_claiming(whole, holder);
>  	mutex_unlock(&bdev_lock);
> +
> +	if (hops && hops->get_holder)
> +		hops->get_holder(holder);
>  }
>  
>  /**
> @@ -605,6 +608,7 @@ EXPORT_SYMBOL(bd_abort_claiming);
>  static void bd_end_claim(struct block_device *bdev, void *holder)
>  {
>  	struct block_device *whole = bdev_whole(bdev);
> +	const struct blk_holder_ops *hops = bdev->bd_holder_ops;
>  	bool unblock = false;
>  
>  	/*
> @@ -627,6 +631,9 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  		whole->bd_holder = NULL;
>  	mutex_unlock(&bdev_lock);
>  
> +	if (hops && hops->put_holder)
> +		hops->put_holder(holder);
> +
>  	/*
>  	 * If this was the last claim, remove holder link and unblock evpoll if
>  	 * it was a write holder.
> diff --git a/fs/super.c b/fs/super.c
> index ee05ab6b37e7..71d9779c42b1 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1515,11 +1515,29 @@ static int fs_bdev_thaw(struct block_device *bdev)
>  	return error;
>  }
>  
> +static void fs_bdev_super_get(void *data)
> +{
> +	struct super_block *sb = data;
> +
> +	spin_lock(&sb_lock);
> +	sb->s_count++;
> +	spin_unlock(&sb_lock);
> +}
> +
> +static void fs_bdev_super_put(void *data)
> +{
> +	struct super_block *sb = data;
> +
> +	put_super(sb);
> +}
> +
>  const struct blk_holder_ops fs_holder_ops = {
>  	.mark_dead		= fs_bdev_mark_dead,
>  	.sync			= fs_bdev_sync,
>  	.freeze			= fs_bdev_freeze,
>  	.thaw			= fs_bdev_thaw,
> +	.get_holder		= fs_bdev_super_get,
> +	.put_holder		= fs_bdev_super_put,
>  };
>  EXPORT_SYMBOL_GPL(fs_holder_ops);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f9b87c39cab0..c3e8f7cf96be 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1505,6 +1505,16 @@ struct blk_holder_ops {
>  	 * Thaw the file system mounted on the block device.
>  	 */
>  	int (*thaw)(struct block_device *bdev);
> +
> +	/*
> +	 * If needed, get a reference to the holder.
> +	 */
> +	void (*get_holder)(void *holder);
> +
> +	/*
> +	 * Release the holder.
> +	 */
> +	void (*put_holder)(void *holder);
>  };
>  
>  /*
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

