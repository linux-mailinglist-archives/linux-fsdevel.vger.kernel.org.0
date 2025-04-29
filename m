Return-Path: <linux-fsdevel+bounces-47636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13542AA1A82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 20:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A239836EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BF253B42;
	Tue, 29 Apr 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7Plhp3r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1HLQ60f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IUrPCMto";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkGIEqrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3863155A4E
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950752; cv=none; b=TDY7o8oJdP8v3qhcoUIUgWeB4zxZeY+Ujac0u61eeRm91dQ1a1NDMAAK4tYb7ZgbnGiS7Lo1JKhD1cPkhFCOmBBT2ZkC3plSl0ARvqo/c+jm+C01+GBVLUHT9w1Yb6QNf7L6ga0/UNRMQgQ44vHLXMd9ggvjx8sifMRpVdqi0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950752; c=relaxed/simple;
	bh=pDtPY5G1bgPWWMsc5mRyVdova/GQU5G1vxe50KbA6tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re1PFxgIWqw5Z9NXu0Q/didFr9GxVSP3+Q3m6H9ro2DSXzV1LUB8l3jcx8k8kOhPCNl32keWHRatzBjyjeqJeLuzK46DoW+TFkqOP5n4XIc0xYKvdjbH4dX6HpZg4jRPA3G7jrf48GX9naZFyVfu5YHpx6HXr4K1wfbxIlI1+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7Plhp3r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1HLQ60f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IUrPCMto; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkGIEqrB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6AAA211AC;
	Tue, 29 Apr 2025 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745950749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nnw5ae/HO1yyHSgwf2xuM2bVdUNSuja2EqHtH5v8DhM=;
	b=h7Plhp3r7VEPw6qUeGtTJklvC/POKMbNrDkeZedgLFtzUkJ1Ded7Ip+43vJ2ZyI5u1R9Qw
	UtFhvynUDMGvO65azn4xG+hNFitvKBFGGvVQPyytcXjWbyrVERRa6r+sI6x2/FhpTaWPET
	9xVPu9/ELCoLB+NHnXXp3dzrHydevoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745950749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nnw5ae/HO1yyHSgwf2xuM2bVdUNSuja2EqHtH5v8DhM=;
	b=p1HLQ60fdTGtKNNGq+qpfns/cSkk4CdfHNtoiYO2mQOybFRPlc7z7KwI2mhPF6Y3ZSzoj8
	5huTUUe/Re7yLpBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745950748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nnw5ae/HO1yyHSgwf2xuM2bVdUNSuja2EqHtH5v8DhM=;
	b=IUrPCMtoHh2NyKtRxU15vuKNfnHQQKXyCeRHhnI6zVAks/kpX7pjztEnEQfjB4+BzkyE5p
	ZFzNeWnbd7rj9gIWVZ2P+ZEiGWhRj1Vh1WWTyqbis7RRYEZ2F71jCzhYvxa5EXqB2sV+gv
	AI8Aqp2kU2KnR07NAfKTwD2uYSM0U9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745950748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nnw5ae/HO1yyHSgwf2xuM2bVdUNSuja2EqHtH5v8DhM=;
	b=VkGIEqrBjSI19CoPXKnO+RmdS7IMwT76ohiXaL8sFvYenXxau1RWLepRDEh4pp0BSFdcyd
	JFLmJcUmNx/YKuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB67D13931;
	Tue, 29 Apr 2025 18:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4xd0LRwYEWgbPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 18:19:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD7ACA0AF0; Tue, 29 Apr 2025 20:19:03 +0200 (CEST)
Date: Tue, 29 Apr 2025 20:19:03 +0200
From: Jan Kara <jack@suse.cz>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Mike Pagano <mpagano@gentoo.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs.fixes] eventpoll: Prevent hang in epoll_wait
Message-ID: <a5t4wx72g3mnyz6h7ko5joairx6zjycdt5jkfdfgmvbrfwhlus@jtsewowpwsxd>
References: <20250429153419.94723-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429153419.94723-1-jdamato@fastly.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 29-04-25 15:34:19, Joe Damato wrote:
> In commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the
> future"), a bug was introduced causing the loop in ep_poll to hang under
> certain circumstances.
> 
> When the timeout is non-NULL and ep_schedule_timeout returns false, the
> flag timed_out was not set to true. This causes a hang.
> 
> Adjust the logic and set timed_out, if needed, fixing the original code.
> 
> Reported-by: Christian Brauner <brauner@kernel.org>
> Closes: https://lore.kernel.org/linux-fsdevel/20250426-haben-redeverbot-0b58878ac722@brauner/
> Reported-by: Mike Pagano <mpagano@gentoo.org>
> Closes: https://bugs.gentoo.org/954806
> Reported-by: Carlos Llamas <cmllamas@google.com>
> Closes: https://lore.kernel.org/linux-fsdevel/aBAB_4gQ6O_haAjp@google.com/
> Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
> Tested-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/eventpoll.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4bc264b854c4..1a5d1147f082 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  
>  		write_unlock_irq(&ep->lock);
>  
> -		if (!eavail && ep_schedule_timeout(to))
> +		if (!ep_schedule_timeout(to))
> +			timed_out = 1;
> +		else if (!eavail)
>  			timed_out = !schedule_hrtimeout_range(to, slack,
>  							      HRTIMER_MODE_ABS);
>  		__set_current_state(TASK_RUNNING);
> 
> base-commit: f520bed25d17bb31c2d2d72b0a785b593a4e3179
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

