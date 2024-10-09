Return-Path: <linux-fsdevel+bounces-31456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCE996FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 17:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206861F212E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208C1E1A3B;
	Wed,  9 Oct 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lm31+UCs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NkTzABFx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bO1iP7Pg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/2IkfBLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C81E1A25;
	Wed,  9 Oct 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487253; cv=none; b=dh9sGRY/czpY+vFx+rRq1ADojp2j7Xd79XKNUkXVpiVGqhsEqm9KBi0SfAJI/DFYa7rJBlwyV9ddbYPOIosNjgXZXxAMa6xOBvGvT33ylnpSN5A/6aEqGthU6dDBKaLkCCESFSu8btmeTgqtNX+j2E9F3JhvMShM5XoQ12HbQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487253; c=relaxed/simple;
	bh=survOVxA/zx0xwYQ/MbRTGIHTmXpnfh+GwbLLEcZYQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl30SaX6JS9Su08hkSRxSOz7Grq1e7cmE59RGp6QkU/+Pex2/fPQlE0zLN0vl+aet6PFlhwcbtu7TEEedQm4Phb1vZICi+0gfioF2lTA8ycW0aN6HMNJdj9vsJDjr8yuq3QdqRIgUVtH+YLblE9tcpuOuiJS3+MkUBNfjuFwGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lm31+UCs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NkTzABFx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bO1iP7Pg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/2IkfBLb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A704021E95;
	Wed,  9 Oct 2024 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728487236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo49WiSuG4sCrNKiK7epakneXryhlOqOWg2rfR6y4QM=;
	b=lm31+UCs8WiVSd9Yz1J4qR15NZmjejLPZpxLmG1snj2OxoJ6puP9kAkr40zCiPvsOdhoy4
	Nenwu7oNjIBMbZOfWIOB2L9522SZ+TZEnhMGA0RXFnlKhHoYkwByO3IAEZWG4Q9jO9zsV8
	TbQ4zX1RIJYVg4dr6k7xZavIE0LPv+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728487236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo49WiSuG4sCrNKiK7epakneXryhlOqOWg2rfR6y4QM=;
	b=NkTzABFxMLvbyceEfWppx0kZjoyp4JGq0im7v5G9Z3T4rmi9ZZuQ7s6q58mYLw16cueWhL
	O71qZmQdH7/HSMAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bO1iP7Pg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/2IkfBLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728487235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo49WiSuG4sCrNKiK7epakneXryhlOqOWg2rfR6y4QM=;
	b=bO1iP7PglAqwn/zSFWDlyQlwfCktWTI+5npTLXFpMEKBkqPQ5cDz61yjy/7G0a5E/IvSvh
	Kntnq4n0rugINGqoiduoUUgUTjfVJDFLD+PpUoipPd+0zJdEdYeoF/pXvNE8h3LetK+C94
	pXZgLLy0yxTFlh2Bb3W5N0b39rLd/jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728487235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo49WiSuG4sCrNKiK7epakneXryhlOqOWg2rfR6y4QM=;
	b=/2IkfBLbUv6CtoZSGlQXFUmV/rnKDxLKzCV76UqZs3ly9CiJMLWv9CwTuKPSKHRJo7fen4
	O0kjlspb6FTkk8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99E6B13A58;
	Wed,  9 Oct 2024 15:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t6GQJUOfBmfNVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 15:20:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43CD1A0896; Wed,  9 Oct 2024 17:20:35 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:20:35 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: jack@suse.cz, hch@infradead.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/page-writeback.c: Update comment for
 BANDWIDTH_INTERVAL
Message-ID: <20241009152035.cwkzs2ryy2fdrs2h@quack3>
References: <20241009151728.300477-1-yizhou.tang@shopee.com>
 <20241009151728.300477-2-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009151728.300477-2-yizhou.tang@shopee.com>
X-Rspamd-Queue-Id: A704021E95
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,shopee.com:email,suse.cz:dkim,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 09-10-24 23:17:27, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
> only used in the bandwidth update functions wb_update_bandwidth() and
> __wb_update_bandwidth(), but also in the dirty limit update function
> domain_update_dirty_limit().
> 
> Currently, we haven't found an ideal name, so update the comment only.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fcd4c1439cb9..c7c6b58a8461 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -54,7 +54,7 @@
>  #define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
>  
>  /*
> - * Estimate write bandwidth at 200ms intervals.
> + * Estimate write bandwidth or update dirty limit at 200ms intervals.
>   */
>  #define BANDWIDTH_INTERVAL	max(HZ/5, 1)
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

