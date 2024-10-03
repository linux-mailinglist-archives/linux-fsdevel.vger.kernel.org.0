Return-Path: <linux-fsdevel+bounces-30878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9357E98EFE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DC281642
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E6199249;
	Thu,  3 Oct 2024 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSuy4WQQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yaz0ICle";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0INHP0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R367zyVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE173174EFC;
	Thu,  3 Oct 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960502; cv=none; b=uCNji+9jTX4QufCekUiC2X+VzbBlETLjb4A7CE8YDGXM6+2ms4it12LQ35ESnFhiGAx2XLEBVax5o4FRWrBwGn1dScfxwQIkE2k+20TZMYwhrmgN2G2OVRL3IvpOZFuDoUVzb/wpj5v5gQ246cXNBbd/Y3Q1Yl1aSQVyUAo5Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960502; c=relaxed/simple;
	bh=sOOOXzWOyOs1IttdKnUBFcFrB4sE99IHM6gxmfBFsMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm2W5NvEi5foVdE2uaavWVt49xuXPXKYrKKS/dNDp5/tKsos1olP/eQnvaIqzifTovpsZ5PB1r3/xgwyFxP5tuodlqoIm8LUXxO6ZPc7ZQqf6jr5R7G9mAbuXR41Bo42tmTPsO6ueQHYco2dAQzDK1ayHiownCHL73bRR2hK/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSuy4WQQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yaz0ICle; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0INHP0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R367zyVR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7CA721CF9;
	Thu,  3 Oct 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727960497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGrWkgtWZ7ybtkodVE47K/bIOA95Ek62bNoaevx/Yx4=;
	b=lSuy4WQQSZglzTr38DBbDzg/LEA0ZGg0W4dc/wfVPpRE+imq5pdoRk/chhOU+TUq6SlwBZ
	wU7Ovc7meOsCQCi+T6CxVF69SCfO0Es0CqJiFCsTmG8Ci+Ip0n8p+pzsaXZa+baWTXuOiU
	wq9toDdQduBYD2eEwFEjCnTbrC+0xWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727960497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGrWkgtWZ7ybtkodVE47K/bIOA95Ek62bNoaevx/Yx4=;
	b=Yaz0ICleOTXTquPKp291/7gLa+xTdKpgMMrflJmYxtsLY5Uk49SIN22YFIsCnfilhyARWs
	VcIopQw9pRNj7OCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727960495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGrWkgtWZ7ybtkodVE47K/bIOA95Ek62bNoaevx/Yx4=;
	b=B0INHP0gabsYClVV/fLHLLBbV8dRiVU2x6Vr1PjrejWFm27VFiRo+vuE89vDl+q7r12gEc
	TeAHnLmFVu+j239iF3PoHH0kr35LPRmkNfDz9E36e1Dr73vzfu2t5nO58SzmCLJriCao4s
	RhZ3KHD8SRnnizBPkZIxSVTZGT1rkdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727960495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGrWkgtWZ7ybtkodVE47K/bIOA95Ek62bNoaevx/Yx4=;
	b=R367zyVRMASiVNuYp7RUXGUOHwtu51OjEpbVrcJo+d9DaQa+M2vzLnRUKWDOV7Z/aLuXCu
	6RLBhaq0w9Z0oQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0C26139CE;
	Thu,  3 Oct 2024 13:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qvHpMq+V/mZaMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 13:01:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 82502A086F; Thu,  3 Oct 2024 15:01:27 +0200 (CEST)
Date: Thu, 3 Oct 2024 15:01:27 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to
 UPDATE_INTERVAL
Message-ID: <20241003130127.45kinxoh77xm5qfb@quack3>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002130004.69010-2-yizhou.tang@shopee.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
> only used in the bandwidth update functions wb_update_bandwidth() and
> __wb_update_bandwidth(), but also in the dirty limit update function
> domain_update_dirty_limit().
> 
> Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.
> 
> This patche doesn't introduce any behavioral changes.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTERVAL does
not seem much better to be honest. I actually have hard time coming up with
a more descriptive name so what if we settled on updating the comment only
instead of renaming to something not much better?

								Honza

> ---
>  mm/page-writeback.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fcd4c1439cb9..a848e7f0719d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -54,9 +54,9 @@
>  #define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
>  
>  /*
> - * Estimate write bandwidth at 200ms intervals.
> + * Estimate write bandwidth or update dirty limit at 200ms intervals.
>   */
> -#define BANDWIDTH_INTERVAL	max(HZ/5, 1)
> +#define UPDATE_INTERVAL		max(HZ/5, 1)
>  
>  #define RATELIMIT_CALC_SHIFT	10
>  
> @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struct dirty_throttle_control *dtc,
>  	/*
>  	 * check locklessly first to optimize away locking for the most time
>  	 */
> -	if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL))
> +	if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL))
>  		return;
>  
>  	spin_lock(&dom->lock);
> -	if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL)) {
> +	if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL)) {
>  		update_dirty_limit(dtc);
>  		dom->dirty_limit_tstamp = now;
>  	}
> @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		wb->dirty_exceeded = gdtc->dirty_exceeded ||
>  				     (mdtc && mdtc->dirty_exceeded);
>  		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> -					   BANDWIDTH_INTERVAL))
> +					   UPDATE_INTERVAL))
>  			__wb_update_bandwidth(gdtc, mdtc, true);
>  
>  		/* throttle according to the chosen dtc */
> @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  	 * writeback bandwidth is updated once in a while.
>  	 */
>  	if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> -				   BANDWIDTH_INTERVAL))
> +				   UPDATE_INTERVAL))
>  		wb_update_bandwidth(wb);
>  	return ret;
>  }
> @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
>  	atomic_dec(&wb->writeback_inodes);
>  	/*
>  	 * Make sure estimate of writeback throughput gets updated after
> -	 * writeback completed. We delay the update by BANDWIDTH_INTERVAL
> +	 * writeback completed. We delay the update by UPDATE_INTERVAL
>  	 * (which is the interval other bandwidth updates use for batching) so
>  	 * that if multiple inodes end writeback at a similar time, they get
>  	 * batched into one bandwidth update.
>  	 */
>  	spin_lock_irqsave(&wb->work_lock, flags);
>  	if (test_bit(WB_registered, &wb->state))
> -		queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> +		queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTERVAL);
>  	spin_unlock_irqrestore(&wb->work_lock, flags);
>  }
>  
> -- 
> 2.25.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

