Return-Path: <linux-fsdevel+bounces-15320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CC88C233
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A863018B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8075A0FA;
	Tue, 26 Mar 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TOjiO3pZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cf2J6aND";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TOjiO3pZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cf2J6aND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168A6EB52;
	Tue, 26 Mar 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456512; cv=none; b=kyTUWh3TuqCDg3GMORo+9A/m/s0y/rRTzdsK3qkdHtHbmWy7YeFLZvqNruNqHSiHzBHoiTiLmUENrJybtTfh/PDw9Ha7capYbmir6n9k2FMiGkuquy3lE2PwRiRCRnbZjJDUOzM6/4/B/Q8qQ6vcPqPrkLOuB9FFOYRieRtRTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456512; c=relaxed/simple;
	bh=dgcPC9NomIkty18Wg70jAIx1755O4jg4IsU0lFA0a2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0gmS70lyBZ7jhVArhsOCYXPfXIXpvk27clNVzrZqjsJTGOvzyOifNwi92HaXQIWlGLuNfKlHJZAUiDSs9QMAHXx6q4A//MhppcadSxUZmdiFKiUxkmSP9UXtZKVXIr3dsYhYsglxINGcyCrYlB5EcIe6A76hxD4LQXilDHXnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TOjiO3pZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cf2J6aND; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TOjiO3pZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cf2J6aND; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51F1437BB6;
	Tue, 26 Mar 2024 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711456508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ellU7x8YCGXwJKrWV7ABao9PNb+LN/5kUyZ33fOdU=;
	b=TOjiO3pZ1crf51dWW9qEqm/7Qco0XAPmiXC/Q2MOoBhN/zSb6ifMGYO2eNZ1Ow+wTTvMpx
	rqZ2izBEtN0RcZLrKf5jObCFxSP49r6CiXvB4qYkt1F7DhPYD8fvBxJrrCnYi8o3WjNWp0
	bc9WNfoxnK0PqBzIiRl61fVcOpC18Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711456508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ellU7x8YCGXwJKrWV7ABao9PNb+LN/5kUyZ33fOdU=;
	b=Cf2J6aNDRK974IYzCsXFSg2GicFhQKNW/aQwjt/pbsGVC4kDbBu10WSPBYxYw0LBS8BcPz
	TJcMfPcDyHyLdADg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711456508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ellU7x8YCGXwJKrWV7ABao9PNb+LN/5kUyZ33fOdU=;
	b=TOjiO3pZ1crf51dWW9qEqm/7Qco0XAPmiXC/Q2MOoBhN/zSb6ifMGYO2eNZ1Ow+wTTvMpx
	rqZ2izBEtN0RcZLrKf5jObCFxSP49r6CiXvB4qYkt1F7DhPYD8fvBxJrrCnYi8o3WjNWp0
	bc9WNfoxnK0PqBzIiRl61fVcOpC18Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711456508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ellU7x8YCGXwJKrWV7ABao9PNb+LN/5kUyZ33fOdU=;
	b=Cf2J6aNDRK974IYzCsXFSg2GicFhQKNW/aQwjt/pbsGVC4kDbBu10WSPBYxYw0LBS8BcPz
	TJcMfPcDyHyLdADg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 429AD13215;
	Tue, 26 Mar 2024 12:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pW89EPzAAmZ7LAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 12:35:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E7A62A0812; Tue, 26 Mar 2024 13:35:03 +0100 (CET)
Date: Tue, 26 Mar 2024 13:35:03 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Message-ID: <20240326123503.kxyxg75xr7wk3ux3@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-7-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.30
X-Spamd-Result: default: False [4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Wed 20-03-24 19:02:22, Kemeng Shi wrote:
> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
> GDTC_INIT_NO_WB
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Please no, this leaves a trap for the future. If anything, I'd teach
GDTC_INIT() that 'wb' can be NULL and replace GDTC_INIT_NO_WB with
GDTC_INIT(NULL).

								Honza

> ---
>  mm/page-writeback.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 481b6bf34c21..09b2b0754cc5 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -154,8 +154,6 @@ struct dirty_throttle_control {
>  				.dom = &global_wb_domain,		\
>  				.wb_completions = &(__wb)->completions
>  
> -#define GDTC_INIT_NO_WB		.dom = &global_wb_domain
> -
>  #define MDTC_INIT(__wb, __gdtc)	.wb = (__wb),				\
>  				.dom = mem_cgroup_wb_domain(__wb),	\
>  				.wb_completions = &(__wb)->memcg_completions, \
> @@ -210,7 +208,6 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
>  
>  #define GDTC_INIT(__wb)		.wb = (__wb),                           \
>  				.wb_completions = &(__wb)->completions
> -#define GDTC_INIT_NO_WB
>  #define MDTC_INIT(__wb, __gdtc)
>  
>  static bool mdtc_valid(struct dirty_throttle_control *dtc)
> @@ -438,7 +435,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>   */
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
>  {
> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +	struct dirty_throttle_control gdtc = { };
>  
>  	gdtc.avail = global_dirtyable_memory();
>  	domain_dirty_limits(&gdtc);
> @@ -895,7 +892,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>  
>  unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
>  {
> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +	struct dirty_throttle_control gdtc = { };
>  	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
>  	unsigned long filepages, headroom, writeback;
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

