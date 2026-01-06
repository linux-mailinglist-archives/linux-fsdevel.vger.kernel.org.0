Return-Path: <linux-fsdevel+bounces-72465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547FCF795F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E99430BF310
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647A31A555;
	Tue,  6 Jan 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D/VPbRrI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEB4/zdZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Feg38TbU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GpzjVgc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90659314B94
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692232; cv=none; b=JbUvxoO/+cdiXGS8Cn2uDv/C2figKXJpL6ZKTa57nRGolTuuXHcCGUQhU2tFv8y5nA71CcQ1nDcuDbpbjSVqVx7ycG6h8ljRhVPckl0rm13bxTM5iNMes90+eN9I6dH6VGTDwjL5ZgXbBEIAAh9jXkWGcesce4StzCStGLpyNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692232; c=relaxed/simple;
	bh=27lw9qNxOFDn4sBYv63lwXsTrI0pFc8Ks2C8sqvjAFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKtVjTlKOSaN4ljnNx2zfwqSC/j4qzABYPhqoD73+ukgSec3PzK/UhmmBFQb3KFz+dg9N8oHPHwkR21V9JY3cuNSUjuasXnpqEzBTKA7cOnsDBaf6I0AaFTOHu5Bl7lr4/m5B0zg2czDZ+kijsOguzp/fVp1YQBn/LPs1F9ZOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D/VPbRrI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEB4/zdZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Feg38TbU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GpzjVgc7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ED1F339D0;
	Tue,  6 Jan 2026 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QS0ak+UJ4+n9ra41ADH1mey7TJ2MGOn48OWXsn70Ig=;
	b=D/VPbRrIfxQm9tNVc0al3zvd8w4ZQDk+8HxO48A1JF7MWsQM1Y1m2O2ndML/ZUZrWWwC1O
	/RYtn6nwkwOVkJZBmvMDWQQGRqDA0gSvnNoNzsQ+2w6i2MaydzCOfJJ53EOA80huhR6jT8
	WQDByPX/YM5ZrilbcSec/qoDHNQ7G68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QS0ak+UJ4+n9ra41ADH1mey7TJ2MGOn48OWXsn70Ig=;
	b=YEB4/zdZjbcHqxcpKXNXN2ILUnUPmk1i80aMmICJTOGPY3J0JRJv2dz5lgnEvtdnArWwuI
	DbSRiNusgMsdT2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QS0ak+UJ4+n9ra41ADH1mey7TJ2MGOn48OWXsn70Ig=;
	b=Feg38TbUOxws7NQ4Me0v7cqQz9Zyghya71TUhZ6ZKGleTaz6ppRR/xiP35AEu09rJCZUW3
	KnYoIJBgxKG9ywlVhopZIx9b5NwuniKfh/3ZjHNMBjjV5HusU34enhH7KSCVNG6210UKvQ
	9d5xKL8uaW6A0hdbIECKfuA3MhES0kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QS0ak+UJ4+n9ra41ADH1mey7TJ2MGOn48OWXsn70Ig=;
	b=GpzjVgc7SccZmna0JNZvgdXj8vzRuNrA3ouU2YSyxRpnpM5mXHcmMIUz/vfElR/l9MEa9J
	UPr7sQZkkrMXx5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73A393EA63;
	Tue,  6 Jan 2026 09:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2xcvHMHXXGnLcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 09:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34C76A08E3; Tue,  6 Jan 2026 10:36:57 +0100 (CET)
Date: Tue, 6 Jan 2026 10:36:57 +0100
From: Jan Kara <jack@suse.cz>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] writeback: fix 100% CPU usage when
 dirtytime_expire_interval is 0
Message-ID: <uavnnpboeyxdodjksgtl7hrb57pd3uqo7xt3qwcjqfqz3nmtoj@flocketbnpym>
References: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
 <20260102201657.305094-2-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102201657.305094-2-laveeshb@laveeshbansal.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]

On Fri 02-01-26 20:16:56, Laveesh Bansal wrote:
> When vm.dirtytime_expire_seconds is set to 0, wakeup_dirtytime_writeback()
> schedules delayed work with a delay of 0, causing immediate execution.
> The function then reschedules itself with 0 delay again, creating an
> infinite busy loop that causes 100% kworker CPU usage.
> 
> Fix by:
> - Only scheduling delayed work in wakeup_dirtytime_writeback() when
>   dirtytime_expire_interval is non-zero
> - Cancelling the delayed work in dirtytime_interval_handler() when
>   the interval is set to 0
> - Adding a guard in start_dirtytime_writeback() for defensive coding
> 
> Tested by booting kernel in QEMU with virtme-ng:
> - Before fix: kworker CPU spikes to ~73%
> - After fix: CPU remains at normal levels
> - Setting interval back to non-zero correctly resumes writeback
> 
> Fixes: a2f4870697a5 ("fs: make sure the timestamps for lazytime inodes eventually get written")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220227
> Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..cd21c74cd0e5 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2492,7 +2492,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
>  				wb_wakeup(wb);
>  	}
>  	rcu_read_unlock();
> -	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> +	if (dirtytime_expire_interval)
> +		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
>  }
>  
>  static int dirtytime_interval_handler(const struct ctl_table *table, int write,
> @@ -2501,8 +2502,12 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
>  	int ret;
>  
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -	if (ret == 0 && write)
> -		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
> +	if (ret == 0 && write) {
> +		if (dirtytime_expire_interval)
> +			mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
> +		else
> +			cancel_delayed_work_sync(&dirtytime_work);
> +	}
>  	return ret;
>  }
>  
> @@ -2519,7 +2524,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
>  
>  static int __init start_dirtytime_writeback(void)
>  {
> -	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> +	if (dirtytime_expire_interval)
> +		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
>  	register_sysctl_init("vm", vm_fs_writeback_table);
>  	return 0;
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

