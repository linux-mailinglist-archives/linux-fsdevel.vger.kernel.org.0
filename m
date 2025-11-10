Return-Path: <linux-fsdevel+bounces-67673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0CC46215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756C43A9C40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309E3081B7;
	Mon, 10 Nov 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uu5Vk6RF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZYqnQdx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uu5Vk6RF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZYqnQdx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E40253F07
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772868; cv=none; b=OSKoo+reempcYyHxutGlk22n0dAidic9Ypyxv7O5VebcSLvexMCT3bB56jv0Nys/zhyDpvNDR+GfBJsGTKZywhBluw/dhxho51UZIAQYl2agcf81dB7cTeraqJKKiactzoQCbKLjfdDjCYVIQMm2PGl+s6zCLpLtyNB9YeQcy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772868; c=relaxed/simple;
	bh=GtKnFa82UUHG8brBBYExKhnUuIs8KUv537EUGXool2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU4nXuhvdFGVM2AKL05V2AkTVyICEtQd3DCO4Mjm2mqZlrL89D9M7r2n5iPVZ95ainr9cZYln52M4lc+bUpS0F4lgdCXSZVKMk3M/uRvexSpkNaOlh8wFPC8OUz+S4Qwo0vfyIjeoevO0jQWZEpI7TBwV6FPxCGtXFbBtl1WlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uu5Vk6RF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZYqnQdx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uu5Vk6RF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZYqnQdx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A444421ECE;
	Mon, 10 Nov 2025 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762772863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4hHav4AAVyBAbi9Ov1eplEZvkyFsaDRFVXMuzOs08=;
	b=uu5Vk6RFhUEUwm8355gsdD9wVZzmfE81ghPhkDKGuhUYZzxt98szn4SA5CW4Qi6kP1RUVd
	cv8OKDM7XwlEitUfBhv+Vwfzhf+9hd3FbgHBomgZc2K8VvhydZ0TegXG7/aaEyslcuDdpz
	8cn5xGGJ2Yl15RzmmVGV3czbHkuXtU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762772863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4hHav4AAVyBAbi9Ov1eplEZvkyFsaDRFVXMuzOs08=;
	b=SZYqnQdxVX9yTNHhA+FBRpnFXkWFKQZXjLzGE4leQ2kuTaNhg3f2ZC7w3tLCwQsceuBdE4
	K6/8GMb1pRrDVYCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762772863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4hHav4AAVyBAbi9Ov1eplEZvkyFsaDRFVXMuzOs08=;
	b=uu5Vk6RFhUEUwm8355gsdD9wVZzmfE81ghPhkDKGuhUYZzxt98szn4SA5CW4Qi6kP1RUVd
	cv8OKDM7XwlEitUfBhv+Vwfzhf+9hd3FbgHBomgZc2K8VvhydZ0TegXG7/aaEyslcuDdpz
	8cn5xGGJ2Yl15RzmmVGV3czbHkuXtU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762772863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4hHav4AAVyBAbi9Ov1eplEZvkyFsaDRFVXMuzOs08=;
	b=SZYqnQdxVX9yTNHhA+FBRpnFXkWFKQZXjLzGE4leQ2kuTaNhg3f2ZC7w3tLCwQsceuBdE4
	K6/8GMb1pRrDVYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969981436E;
	Mon, 10 Nov 2025 11:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z8i/JH/HEWlFSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 11:07:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F538A28B1; Mon, 10 Nov 2025 12:07:35 +0100 (CET)
Date: Mon, 10 Nov 2025 12:07:35 +0100
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] select: store end_time as timespec64 in restart block
Message-ID: <whgf74jjaztowr36aivxcufbxdivfr6j3ef5u2yns5tdv73wmh@6ibbldmnuwbw>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
 <20251110-restart-block-expiration-v1-1-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-restart-block-expiration-v1-1-5d39cc93df4f@linutronix.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linutronix.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 10-11-25 10:38:51, Thomas Weiﬂschuh wrote:
> Storing the end time seconds as 'unsigned long' can lead to truncation
> on 32-bit architectures if assigned from the 64-bit timespec64::tv_sec.
> As the select() core uses timespec64 consistently, also use that in the
> restart block.
> 
> This also allows the simplification of the accessors.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c                   | 12 ++++--------
>  include/linux/restart_block.h |  4 ++--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 082cf60c7e2357dfd419c2128e38da95e3ef2ef3..5c3ce16bd251df9dfeaa562620483a257d7fd5d8 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -1042,14 +1042,11 @@ static long do_restart_poll(struct restart_block *restart_block)
>  {
>  	struct pollfd __user *ufds = restart_block->poll.ufds;
>  	int nfds = restart_block->poll.nfds;
> -	struct timespec64 *to = NULL, end_time;
> +	struct timespec64 *to = NULL;
>  	int ret;
>  
> -	if (restart_block->poll.has_timeout) {
> -		end_time.tv_sec = restart_block->poll.tv_sec;
> -		end_time.tv_nsec = restart_block->poll.tv_nsec;
> -		to = &end_time;
> -	}
> +	if (restart_block->poll.has_timeout)
> +		to = &restart_block->poll.end_time;
>  
>  	ret = do_sys_poll(ufds, nfds, to);
>  
> @@ -1081,8 +1078,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
>  		restart_block->poll.nfds = nfds;
>  
>  		if (timeout_msecs >= 0) {
> -			restart_block->poll.tv_sec = end_time.tv_sec;
> -			restart_block->poll.tv_nsec = end_time.tv_nsec;
> +			restart_block->poll.end_time = end_time;
>  			restart_block->poll.has_timeout = 1;
>  		} else
>  			restart_block->poll.has_timeout = 0;
> diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
> index 7e50bbc94e476c599eb1185e02b6e87854fc3eb8..0798a4ae67c6c75749c38c4673ab8ea012261319 100644
> --- a/include/linux/restart_block.h
> +++ b/include/linux/restart_block.h
> @@ -6,6 +6,7 @@
>  #define __LINUX_RESTART_BLOCK_H
>  
>  #include <linux/compiler.h>
> +#include <linux/time64.h>
>  #include <linux/types.h>
>  
>  struct __kernel_timespec;
> @@ -50,8 +51,7 @@ struct restart_block {
>  			struct pollfd __user *ufds;
>  			int nfds;
>  			int has_timeout;
> -			unsigned long tv_sec;
> -			unsigned long tv_nsec;
> +			struct timespec64 end_time;
>  		} poll;
>  	};
>  };
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

