Return-Path: <linux-fsdevel+bounces-18580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDC8BA97F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5FF1C22552
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99514F110;
	Fri,  3 May 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvXngvbD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgiV5Cqk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvXngvbD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgiV5Cqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4614A0AC;
	Fri,  3 May 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727477; cv=none; b=WDneHgE1fsRl7HuhkI43NKNKgI3Z35G7mNRbjJyzzMBt8eBjXXnhYKs1Un1AXEwFaUJOum+IbGT+lZAjphEskcpDSRYuZzxEUvLASl2e87nu7Ing7lMlgW5+TpfSd8cFajki6gav5P/SpUEAwIh4wtiiOyegDydfNZI8PetN5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727477; c=relaxed/simple;
	bh=DaruKjb1/FkhZOrtH48vN3I5b7w9R0LWzFugwUkf7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqgx5DkaQiSqakuL8uwsxSoSc+RxhaiahJXjvNE8lkQgHXPQT+uK2GdAPCOxk/NJuwdi4/CaYAPQ7GQ7Lkyuf49UhHDKfob4zJZvaAzjVA4yvCeCK1IVkRx0AIfgwloYzhKBYMkYJmrluuXkjfEmG/hteTznSLBPRsPLFQ7cU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvXngvbD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgiV5Cqk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvXngvbD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgiV5Cqk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B44B0229F4;
	Fri,  3 May 2024 09:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714727473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhjug2pP1FcqHpUp6SZr2JmbXQhkwBjXb46lfZXSx9g=;
	b=wvXngvbDAxeg6dfnV6zvydbKtfSWaXXc/maNCIS9JXTYVKem2iiqN1N8OJ+PvviZy8er6Q
	JTsOm0arHvmGXjGOgHA90wSaUD7qNIxDhVsZoINz+Omx5KDtfrGeNc7RzDEYtQB5puFNNj
	An3aYD0l4Yu0QWg87JAjWo+TSYemIjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714727473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhjug2pP1FcqHpUp6SZr2JmbXQhkwBjXb46lfZXSx9g=;
	b=rgiV5CqkirCzDfm0dX/nr4SMMGpLYjwGcLCKE+Hnah+2/oMPSD8tAdwoCtzDXq480m6QDh
	CrC0r2L6KJQ4MaBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714727473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhjug2pP1FcqHpUp6SZr2JmbXQhkwBjXb46lfZXSx9g=;
	b=wvXngvbDAxeg6dfnV6zvydbKtfSWaXXc/maNCIS9JXTYVKem2iiqN1N8OJ+PvviZy8er6Q
	JTsOm0arHvmGXjGOgHA90wSaUD7qNIxDhVsZoINz+Omx5KDtfrGeNc7RzDEYtQB5puFNNj
	An3aYD0l4Yu0QWg87JAjWo+TSYemIjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714727473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhjug2pP1FcqHpUp6SZr2JmbXQhkwBjXb46lfZXSx9g=;
	b=rgiV5CqkirCzDfm0dX/nr4SMMGpLYjwGcLCKE+Hnah+2/oMPSD8tAdwoCtzDXq480m6QDh
	CrC0r2L6KJQ4MaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A541D139CB;
	Fri,  3 May 2024 09:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RIdUKDGqNGb4KwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 09:11:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C62DA0A12; Fri,  3 May 2024 11:11:13 +0200 (CEST)
Date: Fri, 3 May 2024 11:11:13 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, tj@kernel.org,
	jack@suse.cz, hcochran@kernelspring.com, axboe@kernel.dk,
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: enable __wb_calc_thresh to calculate dirty
 background threshold
Message-ID: <20240503091113.bkrw3ihx7gggtlxo@quack3>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131724.36778-2-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 25-04-24 21:17:21, Kemeng Shi wrote:
> Originally, __wb_calc_thresh always calculate wb's share of dirty
> throttling threshold. By getting thresh of wb_domain from caller,
> __wb_calc_thresh could be used for both dirty throttling and dirty
> background threshold.
> 
> This is a preparation to correct threshold calculation of wb in cgroup.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index db5769cb12fd..2a3b68aae336 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -838,13 +838,15 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
>  }
>  
>  /**
> - * __wb_calc_thresh - @wb's share of dirty throttling threshold
> + * __wb_calc_thresh - @wb's share of dirty threshold
>   * @dtc: dirty_throttle_context of interest
> + * @thresh: dirty throttling or dirty background threshold of wb_domain in @dtc
>   *
> - * Note that balance_dirty_pages() will only seriously take it as a hard limit
> - * when sleeping max_pause per page is not enough to keep the dirty pages under
> - * control. For example, when the device is completely stalled due to some error
> - * conditions, or when there are 1000 dd tasks writing to a slow 10MB/s USB key.
> + * Note that balance_dirty_pages() will only seriously take dirty throttling
> + * threshold as a hard limit when sleeping max_pause per page is not enough
> + * to keep the dirty pages under control. For example, when the device is
> + * completely stalled due to some error conditions, or when there are 1000
> + * dd tasks writing to a slow 10MB/s USB key.
>   * In the other normal situations, it acts more gently by throttling the tasks
>   * more (rather than completely block them) when the wb dirty pages go high.
>   *
> @@ -855,19 +857,20 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
>   * The wb's share of dirty limit will be adapting to its throughput and
>   * bounded by the bdi->min_ratio and/or bdi->max_ratio parameters, if set.
>   *
> - * Return: @wb's dirty limit in pages. The term "dirty" in the context of
> - * dirty balancing includes all PG_dirty and PG_writeback pages.
> + * Return: @wb's dirty limit in pages. For dirty throttling limit, the term
> + * "dirty" in the context of dirty balancing includes all PG_dirty and
> + * PG_writeback pages.
>   */
> -static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
> +static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
> +				      unsigned long thresh)
>  {
>  	struct wb_domain *dom = dtc_dom(dtc);
> -	unsigned long thresh = dtc->thresh;
>  	u64 wb_thresh;
>  	unsigned long numerator, denominator;
>  	unsigned long wb_min_ratio, wb_max_ratio;
>  
>  	/*
> -	 * Calculate this BDI's share of the thresh ratio.
> +	 * Calculate this wb's share of the thresh ratio.
>  	 */
>  	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
>  			      &numerator, &denominator);
> @@ -887,9 +890,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
>  
>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>  {
> -	struct dirty_throttle_control gdtc = { GDTC_INIT(wb),
> -					       .thresh = thresh };
> -	return __wb_calc_thresh(&gdtc);
> +	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
> +
> +	return __wb_calc_thresh(&gdtc, thresh);
>  }
>  
>  unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
> @@ -908,7 +911,7 @@ unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
>  	mdtc_calc_avail(&mdtc, filepages, headroom);
>  	domain_dirty_limits(&mdtc);
>  
> -	return __wb_calc_thresh(&mdtc);
> +	return __wb_calc_thresh(&mdtc, mdtc.thresh);
>  }
>  
>  /*
> @@ -1655,7 +1658,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
>  	 *   wb_position_ratio() will let the dirtier task progress
>  	 *   at some rate <= (write_bw / 2) for bringing down wb_dirty.
>  	 */
> -	dtc->wb_thresh = __wb_calc_thresh(dtc);
> +	dtc->wb_thresh = __wb_calc_thresh(dtc, dtc->thresh);
>  	dtc->wb_bg_thresh = dtc->thresh ?
>  		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

