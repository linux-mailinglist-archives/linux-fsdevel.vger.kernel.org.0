Return-Path: <linux-fsdevel+bounces-63019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6BBA8E43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5261C4E161D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B52FBDE9;
	Mon, 29 Sep 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeBNUCT0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nwO1M/L+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnWBEMLy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnsC6/pP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C222258C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141826; cv=none; b=EY9U8a/YjljuSjKErnIBKtQ4uN/r0LqzD1b4oowDE9+N9K4mDGJoQZ61TYiWzev+Qwhs/SK15t+VqUPfQkCGof72ds60jhvRp+E8TRgxx+9wVFisI2PzxykPvVc59w0WvkiyKcqN+80lK/LIYH9qSqvlvZGrw7J9MyIxWITSGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141826; c=relaxed/simple;
	bh=2X4GIA3ABlzEP7AmHnt7dwsZoDGsMt1AVBD5dTSLIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTjR2Nl0OoBgyV6muSk8s39z0HvOpJLsgw00/Qd1VJDeQ1Z/DdpK1Hd8bMpSWbZBJA7Mfi1P34wEjSJFJprHSukQ3w/IqiCh/fokTEzNCZLIhTBbZ5PXdUYTSMHA6KeMg3hYB9Z3U55jNM8fXwKOyaMUe07zroy8QsMaD/Bildo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeBNUCT0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nwO1M/L+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnWBEMLy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QnsC6/pP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9ACB3202C;
	Mon, 29 Sep 2025 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759141821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4z01wwJm6Op9yi8KhGYc2ScWgAR9oBuHjnM0c5YWK0=;
	b=UeBNUCT0a/VcKVboJPKo+s+8sMF9fXOEr65hVMb/X7MRjzGDpaXGVxbYaYdwM3ZPZUo+HQ
	0QuamdSoeUGW+uzvxfHjeUCxcmuzAx3ZnbZ5YI1rzzkSeaBuS0K0Rs05iLvR7n6gNZT0YE
	q7ZJzO5tsI/xz5sP5o3Uf75NNbkx8xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759141821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4z01wwJm6Op9yi8KhGYc2ScWgAR9oBuHjnM0c5YWK0=;
	b=nwO1M/L+tHqcZuNUEo43xXPd1Fp2PLICHRIxvbeHgLLvA5kZ0zTwY/ZNybDoh070ExGdTv
	wyzi37m4sdZUbVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759141820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4z01wwJm6Op9yi8KhGYc2ScWgAR9oBuHjnM0c5YWK0=;
	b=SnWBEMLyV3f10SFxVSbCKGMycU7kbSVJA2khb0/tynB20GDBpQnKAWq28zMctw9CymXYjC
	F88Kksq3NOCGXPy/75byXaiDPtfGxQgPJpC9lMNheaO+Cb1wUWwAWRWh/4lHHaQzGsqPkn
	iDDJ64Fddh3290k54GLixrfVHDVcHIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759141820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4z01wwJm6Op9yi8KhGYc2ScWgAR9oBuHjnM0c5YWK0=;
	b=QnsC6/pPynl4MGY/2kBXIpCDFqEDHSXeIdk1aEYJTXdhH4GnP3+TI5Rp3bWwewkCU5GxHG
	mqP+LvqJl6LYEXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEDB313A21;
	Mon, 29 Sep 2025 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id thJnNrxf2mjYXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 10:30:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95BD2A0A96; Mon, 29 Sep 2025 12:30:20 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:30:20 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com
Subject: Re: [PATCH 2/2] writeback: Add logging for slow writeback (exceeds
 sysctl_hung_task_timeout_secs)
Message-ID: <graq3rgzomoz3dvqvmkfqlfftlbp7vr3jf23sub6t7auvw5rvy@7suabykwibrn>
References: <20250929092304.245154-1-sunjunchao@bytedance.com>
 <20250929092304.245154-2-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092304.245154-2-sunjunchao@bytedance.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bytedance.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 29-09-25 17:23:04, Julian Sun wrote:
> When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
> to identify that it's slow-this helps us pinpoint potential issues.
> 
> Additionally, recording the starting jiffies is useful when debugging a
> crashed vmcore.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

A comment below:

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 475d52abfb3e..3686b4981deb 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1981,8 +1981,17 @@ static long writeback_sb_inodes(struct super_block *sb,
>  
>  		/* Report progress to inform the hung task detector of the progress. */
>  		if (work->done && (jiffies - work->done->stamp) >
> -		    HZ * sysctl_hung_task_timeout_secs / 2)
> +		    HZ * sysctl_hung_task_timeout_secs / 2) {
> +			unsigned long lasted_secs = (jiffies - work->done->start) / HZ;
> +
> +			if (lasted_secs >= sysctl_hung_task_timeout_secs)
> +				pr_info("The writeback work for bdi(%s) has lasted "
> +					"for more than %lu seconds with agv_bw %ld\n",
> +					wb->bdi->dev_name, lasted_secs,
> +					READ_ONCE(wb->avg_write_bandwidth));
> +
>  			wake_up_all(work->done->waitq);
> +		}
>  
>  		wbc_detach_inode(&wbc);
>  		work->nr_pages -= write_chunk - wbc.nr_to_write;
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index c37c6bd5ef5c..4c2013caee2b 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -64,10 +64,12 @@ struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
>  	unsigned long stamp;
> +	unsigned long start; /* jiffies when writeback work is issued */
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
> -	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
> +	(struct wb_completion)		\
> +	{ .cnt = ATOMIC_INIT(1), .waitq = (_waitq), .start = jiffies }

This doesn't work for memcgs because there wb_completion is just
initialized once on allocation. I think 'start' should simply be set in
wb_wait_for_completion() and the checking for too long wait should happen
on wakeups there as well (plus there you can also properly report the task
that's actually blocked for so long).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

