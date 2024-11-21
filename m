Return-Path: <linux-fsdevel+bounces-35436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18D9D4C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701042822F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FB1D1F6B;
	Thu, 21 Nov 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eL6cOxuP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfPyXL+N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eL6cOxuP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfPyXL+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFC1C728F;
	Thu, 21 Nov 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189799; cv=none; b=ZDVeEG41n7TTxdztmmrLkE9uEWgHYr7Ccfk+qlcasrQ7yc+l6g4vegVLvg5o0M5vALNfqPFcEVoc3eNkFjvVAKvAQACf+TBCEc812i9cPzoVdNkpKR5R7a+icnsvlu9ZlZhg9aEliwCBohysrMTJv0pPOSyW83q18d5cm4mr8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189799; c=relaxed/simple;
	bh=Gbdc7YRc/+Gju6ZZDPX+O06gNSLXRayRDP5dM53siL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ideNgfozUXAJuDCZh/tP/3W6AFnqo47N9Ckr+458DbeMTXJa4p9jIowRuZ/AhLmTmvbGdZQp6aQp19RMqsbetpJh52xD3ht9/g+xvU7B3LKdomrmO+wLcQa4QFy5HwMVhooVp6ittwcrynNJ573ZmUp+u+b3DC44kzGqEx774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eL6cOxuP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfPyXL+N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eL6cOxuP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfPyXL+N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59E541F800;
	Thu, 21 Nov 2024 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732189795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQJmzcEK5Mg1r3/eEDfuHI1PwGO7fARlwgDUnl7dBU0=;
	b=eL6cOxuP9bDelgonDV1jZ2wcdwkl1OHB24gfKYdtITJ81pRWhsgGz1d7DIraCwPCN2z8QC
	cQwB1UJgQD86Z/fdhZjb7pY93oNtQ4K4sIoVA5lS0uierVrh22brNUjHeJ1dp+kZHqVV1y
	/PmXPjoLf8FWAifs32H91vr4VregkUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732189795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQJmzcEK5Mg1r3/eEDfuHI1PwGO7fARlwgDUnl7dBU0=;
	b=DfPyXL+NfV2NK01c8fD3yGDfcmKtWjl2OyVz6xaI7ADqdO6+hvMw2kYjytRf44D9P/Qd99
	ANXBVacXrm7sBHDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732189795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQJmzcEK5Mg1r3/eEDfuHI1PwGO7fARlwgDUnl7dBU0=;
	b=eL6cOxuP9bDelgonDV1jZ2wcdwkl1OHB24gfKYdtITJ81pRWhsgGz1d7DIraCwPCN2z8QC
	cQwB1UJgQD86Z/fdhZjb7pY93oNtQ4K4sIoVA5lS0uierVrh22brNUjHeJ1dp+kZHqVV1y
	/PmXPjoLf8FWAifs32H91vr4VregkUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732189795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQJmzcEK5Mg1r3/eEDfuHI1PwGO7fARlwgDUnl7dBU0=;
	b=DfPyXL+NfV2NK01c8fD3yGDfcmKtWjl2OyVz6xaI7ADqdO6+hvMw2kYjytRf44D9P/Qd99
	ANXBVacXrm7sBHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BB113927;
	Thu, 21 Nov 2024 11:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id reK2EWMeP2dJCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:49:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA8D4A089E; Thu, 21 Nov 2024 12:49:50 +0100 (CET)
Date: Thu, 21 Nov 2024 12:49:50 +0100
From: Jan Kara <jack@suse.cz>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH v2] mm/page-writeback: raise wb_thresh to prevent write
 blocking with strictlimit
Message-ID: <20241121114950.5ie64l3lmi3dkoz5@quack3>
References: <20241113100735.4jafa56p4td66z7a@quack3>
 <20241119114444.3925495-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 19-11-24 19:44:42, Jim Zhao wrote:
> With the strictlimit flag, wb_thresh acts as a hard limit in
> balance_dirty_pages() and wb_position_ratio().  When device write
> operations are inactive, wb_thresh can drop to 0, causing writes to be
> blocked.  The issue occasionally occurs in fuse fs, particularly with
> network backends, the write thread is blocked frequently during a period.
> To address it, this patch raises the minimum wb_thresh to a controllable
> level, similar to the non-strictlimit case.
> 
> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> ---
> Changes in v2:
> 1. Consolidate all wb_thresh bumping logic in __wb_calc_thresh for consistency;
> 2. Replace the limit variable with thresh for calculating the bump value,
> as __wb_calc_thresh is also used to calculate the background threshold;
> 3. Add domain_dirty_avail in wb_calc_thresh to get dtc->dirty.

Since the odd value of BdiDirryThresh got explained (independent cosmetic
bug), feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 48 ++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e5a9eb795f99..8b13bcb42de3 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>  				      unsigned long thresh)
>  {
>  	struct wb_domain *dom = dtc_dom(dtc);
> +	struct bdi_writeback *wb = dtc->wb;
>  	u64 wb_thresh;
> +	u64 wb_max_thresh;
>  	unsigned long numerator, denominator;
>  	unsigned long wb_min_ratio, wb_max_ratio;
>  
> @@ -931,11 +933,27 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>  	wb_thresh *= numerator;
>  	wb_thresh = div64_ul(wb_thresh, denominator);
>  
> -	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
> +	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
>  
>  	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
> -	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
> -		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> +
> +	/*
> +	 * It's very possible that wb_thresh is close to 0 not because the
> +	 * device is slow, but that it has remained inactive for long time.
> +	 * Honour such devices a reasonable good (hopefully IO efficient)
> +	 * threshold, so that the occasional writes won't be blocked and active
> +	 * writes can rampup the threshold quickly.
> +	 */
> +	if (thresh > dtc->dirty) {
> +		if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
> +			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
> +		else
> +			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
> +	}
> +
> +	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> +	if (wb_thresh > wb_max_thresh)
> +		wb_thresh = wb_max_thresh;
>  
>  	return wb_thresh;
>  }
> @@ -944,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>  {
>  	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
>  
> +	domain_dirty_avail(&gdtc, true);
>  	return __wb_calc_thresh(&gdtc, thresh);
>  }
>  
> @@ -1120,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>  	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>  		long long wb_pos_ratio;
>  
> -		if (dtc->wb_dirty < 8) {
> -			dtc->pos_ratio = min_t(long long, pos_ratio * 2,
> -					   2 << RATELIMIT_CALC_SHIFT);
> -			return;
> -		}
> -
>  		if (dtc->wb_dirty >= wb_thresh)
>  			return;
>  
> @@ -1196,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>  	 */
>  	if (unlikely(wb_thresh > dtc->thresh))
>  		wb_thresh = dtc->thresh;
> -	/*
> -	 * It's very possible that wb_thresh is close to 0 not because the
> -	 * device is slow, but that it has remained inactive for long time.
> -	 * Honour such devices a reasonable good (hopefully IO efficient)
> -	 * threshold, so that the occasional writes won't be blocked and active
> -	 * writes can rampup the threshold quickly.
> -	 */
> -	wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
>  	/*
>  	 * scale global setpoint to wb's:
>  	 *	wb_setpoint = setpoint * wb_thresh / thresh
> @@ -1459,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
>  	 * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
>  	 * Hence, to calculate "step" properly, we have to use wb_dirty as
>  	 * "dirty" and wb_setpoint as "setpoint".
> -	 *
> -	 * We rampup dirty_ratelimit forcibly if wb_dirty is low because
> -	 * it's possible that wb_thresh is close to zero due to inactivity
> -	 * of backing device.
>  	 */
>  	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>  		dirty = dtc->wb_dirty;
> -		if (dtc->wb_dirty < 8)
> -			setpoint = dtc->wb_dirty + 1;
> -		else
> -			setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
> +		setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
>  	}
>  
>  	if (dirty < setpoint) {
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

