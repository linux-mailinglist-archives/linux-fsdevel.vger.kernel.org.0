Return-Path: <linux-fsdevel+bounces-49231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF3AB99D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0DD4E7D50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD1235075;
	Fri, 16 May 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYpmUliP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOV6xyBc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYpmUliP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOV6xyBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F39231841
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390317; cv=none; b=UkgyO8Sxq9RwnYNhPyJF17gD4zjlhjpxjNZUToQlX7UFHwots1ejpWl3gPWzeS/RCx8/A3XDRp2EGx8wp6M1rRCWhxhhy8IzbNZP0zazhXN/3bh/FewDlzoXKb6Zt86uWTgb8T/vDntOdenFXeKa4og030oBMhvZha6PFFTyyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390317; c=relaxed/simple;
	bh=+3aSa0zGyJVWOAEcjIMdpcVpebjJ9XPj2YDRvIVR1V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeIrx7nL1pKq2UO90ffBcZpM1Pj0dtcWH2xdoj1GSuyNNvcMikcFLjiV80ada4i3PYJwvIPhZo8D0CB9+SJkmHE+stpTrrrP9mq0n2XeIsi6Cd65wEHhay5wOc/eNQYvdc15NHfgJVmaz64BXQJsROy9T4LMii0Udads82XY0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TYpmUliP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOV6xyBc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TYpmUliP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOV6xyBc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 561E31F809;
	Fri, 16 May 2025 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youHGKw+zjVdB0o0ZjgatBC6iHWjbZv4aIw7gOUEDHo=;
	b=TYpmUliP43TLbAV/HUJ5iQ7ZLjJRT0TYghAkdMMIrwMjbr8wNF9jy6s6AeUxtAR/Zs77SV
	hos7JyhYXlK8DOIb++McF3YCWb7vmB+KM7j+5uy0RbivBoxwxAbOwBU3GOFCdAnmnsZO5n
	8zMbNK8N31klQLLLf9W8xHdkUb7rJ04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youHGKw+zjVdB0o0ZjgatBC6iHWjbZv4aIw7gOUEDHo=;
	b=FOV6xyBcg3XrdF9eNho1lKp0/Loif2bLWp1gCqsF8QQJpdywm+IthxteclRGMX2tjfSn5E
	MPUMvaIp1lxC1LBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youHGKw+zjVdB0o0ZjgatBC6iHWjbZv4aIw7gOUEDHo=;
	b=TYpmUliP43TLbAV/HUJ5iQ7ZLjJRT0TYghAkdMMIrwMjbr8wNF9jy6s6AeUxtAR/Zs77SV
	hos7JyhYXlK8DOIb++McF3YCWb7vmB+KM7j+5uy0RbivBoxwxAbOwBU3GOFCdAnmnsZO5n
	8zMbNK8N31klQLLLf9W8xHdkUb7rJ04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youHGKw+zjVdB0o0ZjgatBC6iHWjbZv4aIw7gOUEDHo=;
	b=FOV6xyBcg3XrdF9eNho1lKp0/Loif2bLWp1gCqsF8QQJpdywm+IthxteclRGMX2tjfSn5E
	MPUMvaIp1lxC1LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BA0013977;
	Fri, 16 May 2025 10:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QxB0EmoPJ2iGewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:11:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA35FA09DD; Fri, 16 May 2025 12:11:53 +0200 (CEST)
Date: Fri, 16 May 2025 12:11:53 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs/buffer: use sleeping lookup in __getblk_slowpath()
Message-ID: <2dati3l5r4u7uypyzrp5r6diuz6fuuhnv673szh7akdz55wbd3@gjexaphlhv7u>
References: <20250515173925.147823-1-dave@stgolabs.net>
 <20250515173925.147823-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515173925.147823-2-dave@stgolabs.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80

On Thu 15-05-25 10:39:22, Davidlohr Bueso wrote:
> Just as with the fast path, call the lookup variant depending
> on the gfp flags.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/buffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b8e1e6e325cd..5a4342881f3b 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1122,6 +1122,8 @@ static struct buffer_head *
>  __getblk_slow(struct block_device *bdev, sector_t block,
>  	     unsigned size, gfp_t gfp)
>  {
> +	bool blocking = gfpflags_allow_blocking(gfp);
> +
>  	/* Size must be multiple of hard sectorsize */
>  	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
>  			(size < 512 || size > PAGE_SIZE))) {
> @@ -1137,7 +1139,10 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  	for (;;) {
>  		struct buffer_head *bh;
>  
> -		bh = __find_get_block(bdev, block, size);
> +		if (blocking)
> +			bh = __find_get_block_nonatomic(bdev, block, size);
> +		else
> +			bh = __find_get_block(bdev, block, size);
>  		if (bh)
>  			return bh;
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

