Return-Path: <linux-fsdevel+bounces-14465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B287CF28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D0C1C22624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8138380;
	Fri, 15 Mar 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTXvhQtE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltaVKwJQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTOdbxsC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ecZvhwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5A1946C;
	Fri, 15 Mar 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513755; cv=none; b=auk84b6QoTGvR46hcDLEzHV7LuJqyVP6gSSpn+hsRPGRqo5ZKNnU0vSEVPk8i6VwHrV0p/uQ2MZvhdWm3YTv6hZzCehP4r4+g0BX3z6Ctq81FRhhzmQX6eKvMNmGihlDWBS7u3BfE7wlDjSNfiFn2X8SpmOVXFPlMbXffnUXD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513755; c=relaxed/simple;
	bh=xnkB9bldA/xd8KP4hUwVnK3+HzhwHIYmFIt/AYUlxVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiB/JwAeFuvHGitLhYUXFF8eNePkpzAz+DvcVvwoAwnst05GOP5/DTt1px+jaCfDT1ocv21y9aSM3Bf1BCBd22rVX839TlRDroBW9Qsdo7fwEBxO//hLIKB3N3dgTyzXlPD5dplDHoRqInSf7rfb+JMMdGudSLhWoHF428eNjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTXvhQtE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltaVKwJQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KTOdbxsC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ecZvhwm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05BE221DEC;
	Fri, 15 Mar 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMSmll4CC9d+TIngMOxNl+JR6IwcLqKkSacdh6annM=;
	b=kTXvhQtEwUV12tNJ+pKxyyyOdUBVLlhdpXhs4aSMxPgSleBpRwQXI70jGQvmFYGa8y1aNu
	+2iEpNNFr2Nj8wLndDxVIHCT6Zl0srTSv6A5jD9wlneqMYTpI7ngRzllBD71gYZ0Jp1jCA
	dOKJWsIh0eBw6jXO+F/tjLrnjjZfW0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMSmll4CC9d+TIngMOxNl+JR6IwcLqKkSacdh6annM=;
	b=ltaVKwJQe44RLYeusheyAH9T1uvSRviK0nMhrM3SKWe75uFbm6YHRDLTBGjvwvg5d8BgQ1
	I/2IR5dZpN8fv6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMSmll4CC9d+TIngMOxNl+JR6IwcLqKkSacdh6annM=;
	b=KTOdbxsCPnjlyQ4QfCrWXso3yiyDQr5u079TevLjQ00PYlB89XxZkwa5tG7zLyrdh2PkZs
	E8oBcaHfj0GQZ0z4XX8TDD/RHZEFywv4zW0zWjNCpImzEiAjFy/X6sNBTBrmeaThioeB5o
	ZW1T0OSIdhHICHP+O9iY3S95bYM7jTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMSmll4CC9d+TIngMOxNl+JR6IwcLqKkSacdh6annM=;
	b=9ecZvhwmFFFslKhYhEX2H8msB9zBmk11dBGzwRP88JBxMLZcGhw0Qwimfmm6F9MyIwV5AZ
	3SOZ9YKy0Fo7DEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBAA21368C;
	Fri, 15 Mar 2024 14:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T95/OVZe9GW0QwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:42:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97108A07D9; Fri, 15 Mar 2024 15:42:26 +0100 (CET)
Date: Fri, 15 Mar 2024 15:42:26 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 05/19] bcachefs: remove dead function
 bdev_sectors()
Message-ID: <20240315144226.vd7s3tje44ybposv@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-6-yukuai1@huaweicloud.com>
X-Spam-Score: -1.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KTOdbxsC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ecZvhwm
X-Rspamd-Queue-Id: 05BE221DEC

On Thu 22-02-24 20:45:41, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bdev_sectors() is not used hence remove it.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bcachefs/util.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 1b3aced8d83c..e2d7f22df618 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -443,11 +443,6 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
>  void bch2_bio_map(struct bio *bio, void *base, size_t);
>  int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
>  
> -static inline sector_t bdev_sectors(struct block_device *bdev)
> -{
> -	return bdev->bd_inode->i_size >> 9;
> -}
> -
>  #define closure_bio_submit(bio, cl)					\
>  do {									\
>  	closure_get(cl);						\
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

