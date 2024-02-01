Return-Path: <linux-fsdevel+bounces-9852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1B4845544
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9851C299E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11ED15B966;
	Thu,  1 Feb 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWNyzDMq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="plh6rK/6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWNyzDMq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="plh6rK/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988415B0FE;
	Thu,  1 Feb 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783180; cv=none; b=VZTi/rwKp2TuDsGmnhyn04tK1cKRH4NRAm3cGdpKws/WCZ/stKU8wXcfaxYFDVESA+2iLOzNul5LBTpYe/i4UHcHfwikHPjJ3GDlbT7UWTA0x7OQsVOzSgNVWgwnkABOWvNy5tKgfutx6RevKe+zA/nu5vnaGsJV6ni5xPEK7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783180; c=relaxed/simple;
	bh=KuqVRHuy/uHTYtjLoxiHsDdelbmehuyfGaJfrYZD7Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW/RR8zCYKeU9agO/DMmtgg4hjithfRxj9wBDyuR6rkD1vmoZbdK2LlSOiSDsnp0+mUgQMiEvLlZznHHWjhyfh5ZPjMZUYnI6y4HYtkL4OWOTH/ltm37iHNbNN95i5Gc8f05oz8wmaPH3aUWJyx3uiU/PAUbvJwCMdX33c6xRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWNyzDMq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=plh6rK/6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWNyzDMq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=plh6rK/6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A084D21F3D;
	Thu,  1 Feb 2024 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvetHZhznre0c29HzSeWErcTEx4fuay+g1UBO2FRneo=;
	b=LWNyzDMqa4KM/XxJE8t2kfKXL3/wBBcrHRrpdk/6eHXmr0TUhi0QJdffsTsVhb8rfCOHpX
	+REm2OUdsEJ5TDM9Ulk2TTHhXf0VIDLBcHLcbLIrpKLZZnGpU444oeGDAfJV+2kRNaqFXO
	uG65/iE7dxFPEWtY/Z8zI52XnR5RhgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvetHZhznre0c29HzSeWErcTEx4fuay+g1UBO2FRneo=;
	b=plh6rK/6R1D9T6jMic4ZP0ifSCwqTpAd37P1NoLqhu5TB8xBvEX326H+ST11JcFU3azMTm
	W0ANEAOf1mIXf8Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvetHZhznre0c29HzSeWErcTEx4fuay+g1UBO2FRneo=;
	b=LWNyzDMqa4KM/XxJE8t2kfKXL3/wBBcrHRrpdk/6eHXmr0TUhi0QJdffsTsVhb8rfCOHpX
	+REm2OUdsEJ5TDM9Ulk2TTHhXf0VIDLBcHLcbLIrpKLZZnGpU444oeGDAfJV+2kRNaqFXO
	uG65/iE7dxFPEWtY/Z8zI52XnR5RhgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvetHZhznre0c29HzSeWErcTEx4fuay+g1UBO2FRneo=;
	b=plh6rK/6R1D9T6jMic4ZP0ifSCwqTpAd37P1NoLqhu5TB8xBvEX326H+ST11JcFU3azMTm
	W0ANEAOf1mIXf8Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 85D011329F;
	Thu,  1 Feb 2024 10:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tjdRIMhxu2XoXwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:26:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33B7DA0809; Thu,  1 Feb 2024 11:26:16 +0100 (CET)
Date: Thu, 1 Feb 2024 11:26:16 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 28/34] bdev: make bdev_release() private to block layer
Message-ID: <20240201102616.kzuflhvyck7xtmc7@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-28-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-28-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:45, Christian Brauner wrote:
> and move both of them to the private block header. There's no caller in
> the tree anymore that uses them directly.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

As Christoph noticed, the changelog needs a bit of work but otherwise feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  block/bdev.c           | 2 --
>  block/blk.h            | 4 ++++
>  include/linux/blkdev.h | 3 ---
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index eb5607af6ec5..1f64f213c5fa 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -916,7 +916,6 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  	kfree(handle);
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL(bdev_open_by_dev);
>  
>  static unsigned blk_to_file_flags(blk_mode_t mode)
>  {
> @@ -1045,7 +1044,6 @@ void bdev_release(struct bdev_handle *handle)
>  	blkdev_put_no_open(bdev);
>  	kfree(handle);
>  }
> -EXPORT_SYMBOL(bdev_release);
>  
>  /**
>   * lookup_bdev() - Look up a struct block_device by name.
> diff --git a/block/blk.h b/block/blk.h
> index 1ef920f72e0f..c9630774767d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -516,4 +516,8 @@ static inline int req_ref_read(struct request *req)
>  	return atomic_read(&req->ref);
>  }
>  
> +void bdev_release(struct bdev_handle *handle);
> +struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> +		const struct blk_holder_ops *hops);
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5880d5abfebe..495f55587207 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1482,8 +1482,6 @@ struct bdev_handle {
>  	blk_mode_t mode;
>  };
>  
> -struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> -		const struct blk_holder_ops *hops);
>  struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		const struct blk_holder_ops *hops);
>  struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
> @@ -1491,7 +1489,6 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  int bd_prepare_to_claim(struct block_device *bdev, void *holder,
>  		const struct blk_holder_ops *hops);
>  void bd_abort_claiming(struct block_device *bdev, void *holder);
> -void bdev_release(struct bdev_handle *handle);
>  
>  /* just for blk-cgroup, don't use elsewhere */
>  struct block_device *blkdev_get_no_open(dev_t dev);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

