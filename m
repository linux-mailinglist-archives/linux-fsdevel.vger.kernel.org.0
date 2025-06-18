Return-Path: <linux-fsdevel+bounces-52052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F1ADF18F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFB47AD5D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AA2EF9DC;
	Wed, 18 Jun 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pthvv1w8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUuX43XQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3675Dap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EgwCts+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665A2EBDEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261216; cv=none; b=J0y97aNdqvQ5M4xGAmJCDw71jwxe6vXSKk9chRDLo2q2s8t+ygdnob+xMjd8il2khzhJ9IbA5qKNlnalUBlIuCAQ+1Q76fMU7vwtCtFkpcQ4ENA5ZrxWll3dFjPTMNzyPUV1/IKNdQaoezrOF0w0Uxt6xD9Fc7NekRFFfAmtnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261216; c=relaxed/simple;
	bh=2ZNJkJ6X3kok9DQ6d4upSh74551BjlIERvlFKbnvhb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o//NMV3uFrEAKN1L5ggwK4ecCVhQGd9NO9L37FuVfxR1ZjfvDRuYkVVayo27ryJk+DEIjIJQUHOfRHps7put5daPa+bOO82h64GRtCsofPozF22CNpsygYdczF7yhfhMMYpYuvPwLbgYVG3L/N+cF9DErGGC0yyDa9OOFJivLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pthvv1w8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUuX43XQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3675Dap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EgwCts+5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD9E221169;
	Wed, 18 Jun 2025 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750261211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aajZbQNn5tYVZ46FLC5U7JgjuQ2ym4lHWJngHWpWCOo=;
	b=Pthvv1w8cc7M/21WoKmRX9Qu7Bp6afhfom87RT/3CTWoj7gJ0/7IsmVd/5ccZQLjCG2bW9
	w54unQNCbDxg+k9RAkx80YmdBFPPPL7SU4I8QvIs28RcYLJha7mKs6Gf/d+/hGBPyB0TJi
	kPv1gRz/ZmpfPdMdvhf+bTLY5jTbvCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750261211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aajZbQNn5tYVZ46FLC5U7JgjuQ2ym4lHWJngHWpWCOo=;
	b=cUuX43XQNIuBvjaPBDuz0pqpy/uJWp3bKADAtCkpm99W74D+PkKZFlxBKmXkvmdcJ3Wr1u
	C/WG4icw/nfHbbAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U3675Dap;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EgwCts+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750261210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aajZbQNn5tYVZ46FLC5U7JgjuQ2ym4lHWJngHWpWCOo=;
	b=U3675DapSG1zKUOQHX3qUccMZliXp2tJIDKX6xgMjtPcXq5PjS4T76IzwzrUSvcwpHTKb6
	gMFqmmehT5n4K33xowQj8jbo7QXf9OwgOHgc49ZFJ3AVjPto11wYCwO/cA1utRzKEQoTnV
	QN44WX+hiOnCwYa8ue8+xYIlw1XRAE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750261210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aajZbQNn5tYVZ46FLC5U7JgjuQ2ym4lHWJngHWpWCOo=;
	b=EgwCts+5RTu/ydiC3r5pMytUJC7HskCR4D2hPnQr6JCTkM6VLdugDV5dfh+MK6M4N4/bEU
	Np/YiqhpSWOW6lCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB75613A3F;
	Wed, 18 Jun 2025 15:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jYVjMdrdUmhXFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Jun 2025 15:40:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CBEEA09DC; Wed, 18 Jun 2025 17:40:02 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:40:02 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com, 
	kernel@pankajraghav.com
Subject: Re: [PATCH] fs/buffer: use min folio order to calculate upper limit
 in __getblk_slow()
Message-ID: <rf5sve3v7vlkzae7ralok4vkkit24ashon3htmp56rmqshgcv5@a3bmz7mpkcwb>
References: <20250618091710.119946-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091710.119946-1-p.raghav@samsung.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DD9E221169
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 18-06-25 11:17:10, Pankaj Raghav wrote:
> The maximum IO size that a block device can read as a single block is
> based on the min folio order and not the PAGE_SIZE as we have bs > ps
> support for block devices[1].
> 
> Calculate the upper limit based on the on min folio order.
> 
> [1] https://lore.kernel.org/linux-block/20250221223823.1680616-1-mcgrof@kernel.org/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

...

> ---
> I found this while I was adding bs > ps support to ext4. Ext4 uses this
> routine to read the superblock.
> 
>  fs/buffer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 8cf4a1dc481e..98f90da69a0a 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1121,10 +1121,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  	     unsigned size, gfp_t gfp)
>  {
>  	bool blocking = gfpflags_allow_blocking(gfp);
> +	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
>  
>  	/* Size must be multiple of hard sectorsize */
> -	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
> -			(size < 512 || size > PAGE_SIZE))) {
> +	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> +		     (size < 512 || size > (1U << blocklog)))) {

So this doesn't quite make sense to me.  Shouldn't it be capped from above
by PAGE_SIZE << mapping_max_folio_order(bdev->bd_mapping)?

								Honza


>  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
>  					size);
>  		printk(KERN_ERR "logical block size: %d\n",
> 
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

