Return-Path: <linux-fsdevel+bounces-14754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4B87EE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62901F24A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A754FB2;
	Mon, 18 Mar 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0nbuP9Do";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CczetMun";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm1QiBgo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5mzg8b9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292354BEA;
	Mon, 18 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781835; cv=none; b=risLy1vqu6Oag7SNK3xRr7nE89uMF6xzFtxfcfSQIn7KIHww+XwT49pvfk2KoVJcV1NPCje6yJhD0aifcd66GeCXGO49wahD7XD3ErhFdktW8NRvFNo/Ta0a8yGwarlz4zhW8e3oFi/UPc6cv7i4k7FxJS/W2pHIZJYDmVJgtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781835; c=relaxed/simple;
	bh=vglBofb08ocuNhH6yEZdJnGOBKA0rmTwcb6yq52+l0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk1AFOBnxm+6YwN0jkjpFNMd+A8OIE1v3aSO74KI9LWqpkO+2444mwMWCjDclPM3XHU0reKO1ZoNzK2Ie2ygZc15OC0/6KYwY9QBW2OoDeW+Fp0iEI9iyMeXlTksIV9F2amH/VlSutw02NVZJGazj/FmJBxbUUYzGMwWdvxoeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0nbuP9Do; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CczetMun; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jm1QiBgo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5mzg8b9d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 284C534CBA;
	Mon, 18 Mar 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yarzoTsRuj8Emrnbn2M575ER7Vs+qkT96GvxoQnAZKI=;
	b=0nbuP9DokzheIoEsPXA0OxerxioLxW3Sm8h0EsTd5cW9sNgu3Bm1EMC91XFlJALAEsRRtF
	ehL5Iz6TsqVlRJkCWNq7kLBYritXRCaEtrWwIZ8hLnVDRn33gjQ/+XU1Zt7r3y5fEcOJtJ
	jyFEAB/R0uZOdNSFzKk+VVLo8nEqTLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yarzoTsRuj8Emrnbn2M575ER7Vs+qkT96GvxoQnAZKI=;
	b=CczetMun/FTASezaghTeCpzgumd5MoKKcQFUWCjntm93iAG3YA522yHO+1pvRAVHcOYwad
	v8Kb04fmq/UJDtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yarzoTsRuj8Emrnbn2M575ER7Vs+qkT96GvxoQnAZKI=;
	b=Jm1QiBgoUuHwzT2Q7NnEMvNtypImdmCBl7ttPKyCgtMf8Q/xuhB7VsZderZNgMVG1ZV8JW
	00PvCQWbG0N2d6Ujo6g+sfz6OAeifwkTIgA1TfLxaWwMWvZEONbhybdFGTELtlJgSjtnDp
	03obxyvKFdJrlcA0fw3STEVHcBQYKBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yarzoTsRuj8Emrnbn2M575ER7Vs+qkT96GvxoQnAZKI=;
	b=5mzg8b9dg9L7DgcdFmKd6yPLEh4xvOx++dLCBFJsczjBdoPOuHHviRyrT+vjZjcQwUzk8R
	O0K3wtceKxAOiRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E85B136A5;
	Mon, 18 Mar 2024 17:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fAp0B4Z1+GUjdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 17:10:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CF33EA07D9; Mon, 18 Mar 2024 18:10:29 +0100 (CET)
Date: Mon, 18 Mar 2024 18:10:29 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tim.c.chen@linux.intel.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs/writeback: only calculate dirtied_before when
 b_io is empty
Message-ID: <20240318171029.3rn3a7k7tse7b2bi@quack3>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
 <20240228091958.288260-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228091958.288260-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jm1QiBgo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5mzg8b9d
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.14 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.13)[67.40%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.14
X-Rspamd-Queue-Id: 284C534CBA
X-Spam-Flag: NO

On Wed 28-02-24 17:19:56, Kemeng Shi wrote:
> The dirtied_before is only used when b_io is not empty, so only calculate
> when b_io is not empty.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2105,20 +2105,21 @@ static long wb_writeback(struct bdi_writeback *wb,
>  
>  		spin_lock(&wb->list_lock);
>  
> -		/*
> -		 * Kupdate and background works are special and we want to
> -		 * include all inodes that need writing. Livelock avoidance is
> -		 * handled by these works yielding to any other work so we are
> -		 * safe.
> -		 */
> -		if (work->for_kupdate) {
> -			dirtied_before = jiffies -
> -				msecs_to_jiffies(dirty_expire_interval * 10);
> -		} else if (work->for_background)
> -			dirtied_before = jiffies;
> -
>  		trace_writeback_start(wb, work);
>  		if (list_empty(&wb->b_io)) {
> +			/*
> +			 * Kupdate and background works are special and we want
> +			 * to include all inodes that need writing. Livelock
> +			 * avoidance is handled by these works yielding to any
> +			 * other work so we are safe.
> +			 */
> +			if (work->for_kupdate) {
> +				dirtied_before = jiffies -
> +					msecs_to_jiffies(dirty_expire_interval *
> +							 10);
> +			} else if (work->for_background)
> +				dirtied_before = jiffies;
> +
>  			queue_io(wb, work, dirtied_before);
>  			queued = true;
>  		}
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

