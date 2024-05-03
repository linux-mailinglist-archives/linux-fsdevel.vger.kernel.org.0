Return-Path: <linux-fsdevel+bounces-18583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F78BA9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E81F2184D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53B14F114;
	Fri,  3 May 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fo3Gasdm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9+Xtyq3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ax0ntS1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0B1ph2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729214F9D8;
	Fri,  3 May 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728685; cv=none; b=kdZrHUvLazX9yzzBmMwFVM8pxNi47Q3SYGBlyWZ/wEJhAz5upevuadeQysYJm1iUXWmNFje6mW/LIIPW5aspU0YmXzHu7njwzCQ1s9r8FdFCPhSfI6GEnyQTmBqUCg5iX/BkcHdICHxjnqotwMsW6aYIJObEEqN4A10Y8ziWt9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728685; c=relaxed/simple;
	bh=rq1B3V4Ttff1GxzycqF2I+P0+qaiI+ckG2zzJcA4MXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSP7nYDpyVSLb+PtfM6dJuhQJxDspfDEkJ9AFuBxjk1B95wXWiN+H8u5hvnITWiIM+t+rVomPXT0qfvs72+/NmKsgwArS/ipY8qpDbB0QfGJgVZFLkcsC/9IGa1+xolyqeFpfAJ2DAVLlKb0zvRarUdtMuOQySDMZqf6ivhlbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fo3Gasdm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9+Xtyq3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ax0ntS1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0B1ph2D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4958920002;
	Fri,  3 May 2024 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQLsjALtF8Dtf2dnf/M68oWEcW8pNv5BhZPogrR45fk=;
	b=Fo3GasdmI/w2XYV+lWiI3ZTLoS7TPis247itBZfBT7p4cb0j4aRi6uKL7KV+tFoxi3FjLC
	YzI7vXyoREZlNuwyMfZ1B9APr5i3EQPdabNyzLhaoVyW7gVbVf5dMJR8VdBwItjEOYspmu
	IV1izz/KPN8rYT7ByKwcyJXfJAAUxkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQLsjALtF8Dtf2dnf/M68oWEcW8pNv5BhZPogrR45fk=;
	b=J9+Xtyq3R/qge9xbc65qxhonMt9b2smjsqeQ1fwJjoIz8lErIatZstpb0ZUPlZwY7lwsim
	wo28StX4/lJyv4BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ax0ntS1G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q0B1ph2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQLsjALtF8Dtf2dnf/M68oWEcW8pNv5BhZPogrR45fk=;
	b=ax0ntS1GXzWM2nK4IbPmigJIwDNtELCjSAb7YpvvKaZq+oVb5PSr6Xg4V0hC4kbZV4l2PC
	xzmibNkDOXgy2WrgugIrS1rliANiHfqfxirmKGA1yrOwvyHBXQkEdPZtOJyzov3O21Sy3u
	7NZlkrEv2S35FIHsfMU5AotPunmOQPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQLsjALtF8Dtf2dnf/M68oWEcW8pNv5BhZPogrR45fk=;
	b=Q0B1ph2DL2HjHzFBldKprMx5fGpYptya5mIigYIbEHvzzk91PC/MIfT+219ijMRvfyYmWb
	TzBggLKtcDB502Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3959E139CB;
	Fri,  3 May 2024 09:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7/5DemuNGalMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 09:31:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00723A0A12; Fri,  3 May 2024 11:31:16 +0200 (CEST)
Date: Fri, 3 May 2024 11:31:16 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, tj@kernel.org,
	jack@suse.cz, hcochran@kernelspring.com, axboe@kernel.dk,
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: call __wb_calc_thresh instead of
 wb_calc_thresh in wb_over_bg_thresh
Message-ID: <20240503093116.jwur3sb3rwnjsin3@quack3>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131724.36778-4-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huaweicloud.com:email,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4958920002
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu 25-04-24 21:17:23, Kemeng Shi wrote:
> Call __wb_calc_thresh to calculate wb bg_thresh of gdtc in
> wb_over_bg_thresh to remove unnecessary wrap in wb_calc_thresh.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 14893b20d38c..22e1acec899e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2117,7 +2117,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>  	if (gdtc->dirty > gdtc->bg_thresh)
>  		return true;
>  
> -	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
> +	thresh = __wb_calc_thresh(gdtc, gdtc->bg_thresh);
>  	if (thresh < 2 * wb_stat_error())
>  		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
>  	else
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

