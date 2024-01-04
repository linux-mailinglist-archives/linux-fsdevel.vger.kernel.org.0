Return-Path: <linux-fsdevel+bounces-7402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931E824785
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E90F1C24349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78B288CF;
	Thu,  4 Jan 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUfmc3Qh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1CdOL97";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKngIZFV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYUhj4jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B02556C;
	Thu,  4 Jan 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E61EE220E3;
	Thu,  4 Jan 2024 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704389604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsRJvLQnecTvHGtb1HFyEgtgGzgqO3i0oqXp5vlKPWI=;
	b=FUfmc3Qh0MAGpw9hE1UCALTro4oNQzSromnIwoyARtAD67o1EK5qtJ8XnfjGZJ0Ckmcyin
	2GvHWi0pkSshwyWmpxnTQxWyE7brQqXjnRdKZ0cJI1hjYbRwYLGOkgEVJniy8RRtZtWALE
	tqZFBriSBgGuJbmgwggtW2xw//SSWjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704389604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsRJvLQnecTvHGtb1HFyEgtgGzgqO3i0oqXp5vlKPWI=;
	b=Q1CdOL97nApponZ0+Gy2YpFJyPecVMp/76l3qZN6oV6rZSpTGv9AcQbZOzdwOVKQBMAHW+
	VblZXIeMwLgoNqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704389603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsRJvLQnecTvHGtb1HFyEgtgGzgqO3i0oqXp5vlKPWI=;
	b=sKngIZFV37auVSfq3UB+l3+cObj5PhuLlhL1lIYtrTEr26ZSQ9JJKbk1nM2CSW2A+VA6mt
	mZ7xHp0jPIyF65C0y5irRidvaZujqZc9iFkv8qqHkhNQm0uPus/gYobdW4T8IfhQSh07af
	SM3oACnpH9apOP8kiMiM28EHRYvyk0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704389603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsRJvLQnecTvHGtb1HFyEgtgGzgqO3i0oqXp5vlKPWI=;
	b=KYUhj4joWBSk58EDoOrE0oqoK+ObIbf49vSBv976EsBlWrHkhl5lHbNSqx2rH3n4TKe0+8
	vjuLAiEKwSSzuPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4B1213722;
	Thu,  4 Jan 2024 17:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FLLiM+PrlmW5bwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 17:33:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 650E8A07EF; Thu,  4 Jan 2024 18:33:19 +0100 (CET)
Date: Thu, 4 Jan 2024 18:33:19 +0100
From: Jan Kara <jack@suse.cz>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: shr@devkernel.io, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v3 1/2] mm: fix arithmetic for bdi min_ratio
Message-ID: <20240104173319.a7ui5uh4jde5jan4@quack3>
References: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
 <20231219142508.86265-2-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219142508.86265-2-jefflexu@linux.alibaba.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E61EE220E3
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sKngIZFV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KYUhj4jo
X-Spam-Score: -2.92
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[alibaba.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.91)[99.60%]

On Tue 19-12-23 22:25:07, Jingbo Xu wrote:
> Since now bdi->min_ratio is part per million, fix the wrong arithmetic.
> Otherwise it will fail with -EINVAL when setting a reasonable min_ratio,
> as it tries to set min_ratio to (min_ratio * BDI_RATIO_SCALE) in
> percentage unit, which exceeds 100% anyway.
> 
>     # cat /sys/class/bdi/253\:0/min_ratio
>     0
>     # cat /sys/class/bdi/253\:0/max_ratio
>     100
>     # echo 1 > /sys/class/bdi/253\:0/min_ratio
>     -bash: echo: write error: Invalid argument
> 
> Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")
> Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  mm/page-writeback.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ee2fd6a6af40..2140382dd768 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -692,7 +692,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
>  
>  	if (min_ratio > 100 * BDI_RATIO_SCALE)
>  		return -EINVAL;
> -	min_ratio *= BDI_RATIO_SCALE;
>  
>  	spin_lock_bh(&bdi_lock);
>  	if (min_ratio > bdi->max_ratio) {
> -- 
> 2.19.1.6.gb485710b
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

