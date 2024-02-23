Return-Path: <linux-fsdevel+bounces-12579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8F86136E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2E31F23338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E480030;
	Fri, 23 Feb 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4fViFq1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6ABmZeZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4fViFq1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6ABmZeZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6EA7C0B7;
	Fri, 23 Feb 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696698; cv=none; b=iq+W2s3N6ZWgFrJ9IxNmAVH2MffFa++hKsmcCMAOBpyV8jKR1W4GsfLSTKNQlup5gLSq8+/4VOnpBDu4Jw2vE1sbAJJgJcVazbTdCyR/N0LLkv+66m0ibbD5ScaiaLiA8j601Dgls7VeEyCKegBeLrfDyDtfkA14X/0SEakeXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696698; c=relaxed/simple;
	bh=pbT1DFOMCZma8a0J0tZ+ldSzxHSWwwOMY4t/dTeJQ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwDKRexdLcNpSm4Z2bFokPffb8RsaE7jAzU2DC7R/gJ74toA5scFSlSZXH18A4knAzIZzjVi8sj7uemgDe5c3sOb8qnc/6ofS2wzJnnc45u8jcT2zEc7nOUOWF0G9orl650sTHG6EGpXtMZxLcPafpyRAvLk6u4zPg5044wxX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4fViFq1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6ABmZeZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4fViFq1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6ABmZeZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF3AD21F7C;
	Fri, 23 Feb 2024 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86CqIYZTrjWBjOvyfZhYyfrz9ttjC31SiucXjy42NZY=;
	b=m4fViFq1RlKZr3+8ZGN6T6aOr6ZMhaTeCJXlXSquZorv9Ok/TNzkXLoFCMGmvHFbBCRK9/
	ThiE99It8py4Hp2QWvxV/k0ziCEN6fnQECtwgk4Bgznz6CNOucQ4v85/xAc5N38Ut7NEdZ
	ZzgmbvRdautNtxkSTM7CZEsG2ofqllc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86CqIYZTrjWBjOvyfZhYyfrz9ttjC31SiucXjy42NZY=;
	b=V6ABmZeZzSyOqf3at2PIu0H47A3dtVgXd2Ac9PMu+FRFBQuSBnGjorGlckz4x6khvwEvst
	xp1011R8Zw7itCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86CqIYZTrjWBjOvyfZhYyfrz9ttjC31SiucXjy42NZY=;
	b=m4fViFq1RlKZr3+8ZGN6T6aOr6ZMhaTeCJXlXSquZorv9Ok/TNzkXLoFCMGmvHFbBCRK9/
	ThiE99It8py4Hp2QWvxV/k0ziCEN6fnQECtwgk4Bgznz6CNOucQ4v85/xAc5N38Ut7NEdZ
	ZzgmbvRdautNtxkSTM7CZEsG2ofqllc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86CqIYZTrjWBjOvyfZhYyfrz9ttjC31SiucXjy42NZY=;
	b=V6ABmZeZzSyOqf3at2PIu0H47A3dtVgXd2Ac9PMu+FRFBQuSBnGjorGlckz4x6khvwEvst
	xp1011R8Zw7itCCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B1B4B13776;
	Fri, 23 Feb 2024 13:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Bb91K3Wk2GUzfgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:58:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 539A2A07D1; Fri, 23 Feb 2024 14:58:09 +0100 (CET)
Date: Fri, 23 Feb 2024 14:58:09 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] fs/writeback: only calculate dirtied_before when
 b_io is empty
Message-ID: <20240223135809.5bvyl7ex3zm6bnta@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-6-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m4fViFq1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V6ABmZeZ
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.49)[79.65%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.30
X-Rspamd-Queue-Id: BF3AD21F7C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 09-02-24 01:20:22, Kemeng Shi wrote:
> The dirtied_before is only used when b_io is not empty, so only calculate
> when b_io is not empty.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/fs-writeback.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

OK, but please wrap the comment at 80 columns as well.

								Honza

> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index b61bf2075931..e8868e814e0a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2118,20 +2118,21 @@ static long wb_writeback(struct bdi_writeback *wb,
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
> +			 * Kupdate and background works are special and we want to
> +			 * include all inodes that need writing. Livelock avoidance is
> +			 * handled by these works yielding to any other work so we are
> +			 * safe.
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

