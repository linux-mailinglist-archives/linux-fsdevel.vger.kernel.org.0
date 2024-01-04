Return-Path: <linux-fsdevel+bounces-7403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B60824798
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E4B1F252C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E6288DD;
	Thu,  4 Jan 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WO5Etiid";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="04dZR2xX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WO5Etiid";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="04dZR2xX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A7286AD;
	Thu,  4 Jan 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC7A3220E7;
	Thu,  4 Jan 2024 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704390061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12e9jUxfm5hixJE8HJKUVsReJEnWe7uObiTgEXpBrgI=;
	b=WO5Etiid/pU3xN8w8vhjx90jdz7GK/ncX4XV1mlb233QI1S/lio8krvCVsGscJW5PhPqvc
	0bVnkl2pnwFmQ2i+GCN2xetg/g5gITNjKHu9pnNxQQPA18gqw3C/lCw4n8iRrd2HpDtQ6W
	c/wd2rNKB/YBMJE6eX6KeMEDSQ9MP8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704390061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12e9jUxfm5hixJE8HJKUVsReJEnWe7uObiTgEXpBrgI=;
	b=04dZR2xXWmGMLLO5uuzGGktjAp99J+iHO8dZj9tgJRDaB+Hb3Cn7PhnIBpWBGRpSB76B2T
	ydTyey72oz3kwXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704390061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12e9jUxfm5hixJE8HJKUVsReJEnWe7uObiTgEXpBrgI=;
	b=WO5Etiid/pU3xN8w8vhjx90jdz7GK/ncX4XV1mlb233QI1S/lio8krvCVsGscJW5PhPqvc
	0bVnkl2pnwFmQ2i+GCN2xetg/g5gITNjKHu9pnNxQQPA18gqw3C/lCw4n8iRrd2HpDtQ6W
	c/wd2rNKB/YBMJE6eX6KeMEDSQ9MP8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704390061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12e9jUxfm5hixJE8HJKUVsReJEnWe7uObiTgEXpBrgI=;
	b=04dZR2xXWmGMLLO5uuzGGktjAp99J+iHO8dZj9tgJRDaB+Hb3Cn7PhnIBpWBGRpSB76B2T
	ydTyey72oz3kwXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D89A13722;
	Thu,  4 Jan 2024 17:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kuyQJq3tlmWQcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 17:41:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C27EA07EF; Thu,  4 Jan 2024 18:41:01 +0100 (CET)
Date: Thu, 4 Jan 2024 18:41:01 +0100
From: Jan Kara <jack@suse.cz>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: shr@devkernel.io, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v3 2/2] mm: fix arithmetic for max_prop_frac when setting
 max_ratio
Message-ID: <20240104174101.oax6zbdhy4v5u4bf@quack3>
References: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
 <20231219142508.86265-3-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219142508.86265-3-jefflexu@linux.alibaba.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WO5Etiid;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=04dZR2xX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,alibaba.com:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.95%]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: AC7A3220E7
X-Spam-Flag: NO

On Tue 19-12-23 22:25:08, Jingbo Xu wrote:
> Since now bdi->max_ratio is part per million, fix the wrong arithmetic
> for max_prop_frac when setting max_ratio.  Otherwise the miscalculated
> max_prop_frac will affect the incrementing of writeout completion count
> when max_ratio is not 100%.
> 
> Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2140382dd768..05e5c425b3ff 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -728,7 +728,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
>  		ret = -EINVAL;
>  	} else {
>  		bdi->max_ratio = max_ratio;
> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
> +		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) /
> +						(100 * BDI_RATIO_SCALE);
>  	}
>  	spin_unlock_bh(&bdi_lock);
>  
> -- 
> 2.19.1.6.gb485710b
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

