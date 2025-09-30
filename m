Return-Path: <linux-fsdevel+bounces-63093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED90BABD59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E41C5256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791782BE658;
	Tue, 30 Sep 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kaSz5T5J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IDpf4v00";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kaSz5T5J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IDpf4v00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C822BE7AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217500; cv=none; b=AKhTX16Z6EJL2zedo0Q/mkIHBTKcu1u1pZm1xYPD1UKtMHeEOKZNnwGW2GmNxU/BhpJR/6RHlBcTlBqX0F5M9xrr+16AgpBmgSfK0Nc+moj4uCbGDHs74QguTwr+hEARgGkIsOngcYB/EvT/jnqkGQbqvqHMzeyeGsgEFr2+Ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217500; c=relaxed/simple;
	bh=LO+2/UETOyVO+Ra9HFZV0guRh4DQnQyNydt2lm29IJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiYLh0phls9GHm0iW8XWG0TaZ2r7xESUPkMqgB+dQNM6aoezDMyOhxNn99EPkTz5MK02Q+hOEuegC5GWWegdO0KMakBz90FIfp71r9SXEovPW9ChW8zqzSlX0ttcLPUJx8Vw7wV0j8F05c1eZ4qXjQm6fN8NyRMZuq8ElempnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kaSz5T5J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IDpf4v00; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kaSz5T5J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IDpf4v00; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE1F21F7A1;
	Tue, 30 Sep 2025 07:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759217496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIwsi7wT21Z8q3Ry5OTnFNx0yHs10rqvGb7Ys0ZFRlA=;
	b=kaSz5T5J6BRRUtWjXjFY6w+kpxw3imUXlEQAgKQ0MfQeiXy/HUAtDWBkV+uPxr2Luara4h
	08Vpwxhmg3QYMCNhAXzP9QutFIAGLjcYfwX1v4mYZKBr8z17PyzLmB5pwX3VXScTOuMpc4
	zXq0tkmXtc1FtNKZVLwJVW+WFo9+Nb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759217496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIwsi7wT21Z8q3Ry5OTnFNx0yHs10rqvGb7Ys0ZFRlA=;
	b=IDpf4v00oZtuNdmImvUnMsZmlFoKmtBKl5s+f7IXSFqj8GAmeRwZoj/FLvbZTxvgu+M2UB
	rPAMYz15Pmv/KLBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759217496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIwsi7wT21Z8q3Ry5OTnFNx0yHs10rqvGb7Ys0ZFRlA=;
	b=kaSz5T5J6BRRUtWjXjFY6w+kpxw3imUXlEQAgKQ0MfQeiXy/HUAtDWBkV+uPxr2Luara4h
	08Vpwxhmg3QYMCNhAXzP9QutFIAGLjcYfwX1v4mYZKBr8z17PyzLmB5pwX3VXScTOuMpc4
	zXq0tkmXtc1FtNKZVLwJVW+WFo9+Nb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759217496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIwsi7wT21Z8q3Ry5OTnFNx0yHs10rqvGb7Ys0ZFRlA=;
	b=IDpf4v00oZtuNdmImvUnMsZmlFoKmtBKl5s+f7IXSFqj8GAmeRwZoj/FLvbZTxvgu+M2UB
	rPAMYz15Pmv/KLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3B4F1342D;
	Tue, 30 Sep 2025 07:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0N3zJ1iH22h3UAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Sep 2025 07:31:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4FCCBA0AB8; Tue, 30 Sep 2025 09:31:32 +0200 (CEST)
Date: Tue, 30 Sep 2025 09:31:32 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/2] writeback: Add logging for slow writeback
 (exceeds sysctl_hung_task_timeout_secs)
Message-ID: <reum6a6ffc6sisg3coja3e46ykw67u5fpewpxtrapxcngojw4m@wb2y4v2k7wwq>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
 <20250930071829.1898889-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930071829.1898889-1-sunjunchao@bytedance.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 30-09-25 15:18:29, Julian Sun wrote:
> When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
> to identify that there are tasks waiting for a long time-this helps us
> pinpoint potential issues.
> 
> Additionally, recording the starting jiffies is useful when debugging a
> crashed vmcore.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Looks good.

								Honza

> ---
> Changes in v3:
>  * Show blocked task info instead of BDI info as Jan suggested.
> 
> Changes in v2:
>   * rename start to wait_stamp
>   * init wait_stamp in wb_wait_for_completion()
> 
>  fs/fs-writeback.c                | 17 +++++++++++++++--
>  include/linux/backing-dev-defs.h |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 61785a9d6669..4b54189f27ac 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -201,6 +201,19 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  	spin_unlock_irq(&wb->work_lock);
>  }
>  
> +static bool wb_wait_for_completion_cb(struct wb_completion *done)
> +{
> +	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
> +
> +	done->progress_stamp = jiffies;
> +	if (waited_secs > sysctl_hung_task_timeout_secs)
> +		pr_info("INFO: The task %s:%d has been waiting for writeback "
> +			"completion for more than %lu seconds.",
> +			current->comm, current->pid, waited_secs);
> +
> +	return !atomic_read(&done->cnt);
> +}
> +
>  /**
>   * wb_wait_for_completion - wait for completion of bdi_writeback_works
>   * @done: target wb_completion
> @@ -213,9 +226,9 @@ static void wb_queue_work(struct bdi_writeback *wb,
>   */
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
> +	done->wait_start = jiffies;
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq,
> -		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));
> +	wait_event(*done->waitq, wb_wait_for_completion_cb(done));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 1057060bb2aa..fd71340e5562 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -64,6 +64,7 @@ struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
>  	unsigned long progress_stamp;	/* The jiffies when slow progress is detected */
> +	unsigned long wait_start;	/* The jiffies when waiting for the writeback work to finish */
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

