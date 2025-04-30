Return-Path: <linux-fsdevel+bounces-47705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBAAA4565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08A9A35D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568BC219EAD;
	Wed, 30 Apr 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIjl0B80";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="34ylF4mT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0KLLECP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0xeY6gNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28546218587
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001676; cv=none; b=NlD1MNm5MkXqLoE68bquDizVCqVtacYyw+SPJAN8lE3yun/V5Mq/rL8DWuJX5T16ehnciVX2pBe/TjNqMYuckvnggy3MomCT+oxgqVh0V24VOUaOYMWZCIICpXICWNRwvlx+RbcwEE3/te9JJPcm2ng0DPAJJS1dpfrtUiPhy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001676; c=relaxed/simple;
	bh=KP0WbRYyXweFla+W9yKoUm82l153JkxLlFZrvyQgDFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8KFLPICqit3Oxv30F8UoOKLxynbOpK6UXgrQjR+5UcfWI3oUDSsHJ1Ss+XxazQbrSAYn7Hv5BMwQ2aShSnvCph6J2wG3/DuGkMQ7z31dUWJ3oS75NyeByyc2pg7+VhAJhrvUZms+7UdeBCF97D2RCbOt3gMv1djLLwazgnXc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIjl0B80; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=34ylF4mT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0KLLECP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0xeY6gNN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53CF51F7BF;
	Wed, 30 Apr 2025 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746001667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+g1TDP6rhx8pD3i0tB2oZWqxFYE0CqTNE2BvNf7Ycw=;
	b=VIjl0B80Uh3OUx3+Pshx9kY6dUdBWDIAmXxE40ltIMkkAw6HJy5NF8n2wR/Vw/N6U//Mz/
	q43tMlVKwvxlPjDZIZ36pWNmVElVfkBF4fjZjXjb+R/BwO3W7x7vCttQLcGPSfe9+U5wkc
	VwECC9C1r4ivjILpHWOsw+9pE8Eo2RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746001667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+g1TDP6rhx8pD3i0tB2oZWqxFYE0CqTNE2BvNf7Ycw=;
	b=34ylF4mTZj3STtfYtJGb1S3C6Ei9P7OlRGBTUYXWqsGldxCwQKSpPz7iANglSxXlRrs4UZ
	c6LQlp1HcrReJHAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r0KLLECP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0xeY6gNN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746001666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+g1TDP6rhx8pD3i0tB2oZWqxFYE0CqTNE2BvNf7Ycw=;
	b=r0KLLECPsP8+xL6H7OibzAZq/4xdyKExIWg8qM+i0x7PUIvIfnbE2dV7hSQSAO3cIBumqi
	iHq36qGokctFQcDoZgBGcdJsLcvBgorABMY+VR57Zx07RQ/nE28cZng+QrN6ez4u6DgzTN
	vxn1r/IhXvabSNT2XWH1rCieh1qKkJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746001666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+g1TDP6rhx8pD3i0tB2oZWqxFYE0CqTNE2BvNf7Ycw=;
	b=0xeY6gNNADEAcP/1u5v0rxgig/6h7Zy3mSE8sNHy7Dg42tJTDMR6SpT4vFQFK1wPPVq3nS
	3P54IpBgpCUANGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47A4D139E7;
	Wed, 30 Apr 2025 08:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4yVvEQLfEWgaEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 08:27:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05DDEA0AF0; Wed, 30 Apr 2025 10:27:45 +0200 (CEST)
Date: Wed, 30 Apr 2025 10:27:45 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/eventpoll: fix endless busy loop after timeout has
 expired
Message-ID: <diilyq37i35qlll7hu3si6dqrjntiif5gzajazkgtqvfsi4kgg@yr3v562urmjp>
References: <20250429185827.3564438-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429185827.3564438-1-max.kellermann@ionos.com>
X-Rspamd-Queue-Id: 53CF51F7BF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 29-04-25 20:58:27, Max Kellermann wrote:
> After commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in
> the future"), the following program would immediately enter a busy
> loop in the kernel:
> 
> ```
> int main() {
>   int e = epoll_create1(0);
>   struct epoll_event event = {.events = EPOLLIN};
>   epoll_ctl(e, EPOLL_CTL_ADD, 0, &event);
>   const struct timespec timeout = {.tv_nsec = 1};
>   epoll_pwait2(e, &event, 1, &timeout, 0);
> }
> ```
> 
> This happens because the given (non-zero) timeout of 1 nanosecond
> usually expires before ep_poll() is entered and then
> ep_schedule_timeout() returns false, but `timed_out` is never set
> because the code line that sets it is skipped.  This quickly turns
> into a soft lockup, RCU stalls and deadlocks, inflicting severe
> headaches to the whole system.
> 
> When the timeout has expired, we don't need to schedule a hrtimer, but
> we should set the `timed_out` variable.  Therefore, I suggest moving
> the ep_schedule_timeout() check into the `timed_out` expression
> instead of skipping it.
> 
> Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
> Cc: Joe Damato <jdamato@fastly.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

I agree this makes the logic somewhat more obvious than Joe's fix so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

								Honza

> ---
>  fs/eventpoll.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4bc264b854c4..d4dbffdedd08 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2111,9 +2111,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  
>  		write_unlock_irq(&ep->lock);
>  
> -		if (!eavail && ep_schedule_timeout(to))
> -			timed_out = !schedule_hrtimeout_range(to, slack,
> -							      HRTIMER_MODE_ABS);
> +		if (!eavail)
> +			timed_out = !ep_schedule_timeout(to) ||
> +				!schedule_hrtimeout_range(to, slack,
> +							  HRTIMER_MODE_ABS);
>  		__set_current_state(TASK_RUNNING);
>  
>  		/*
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

