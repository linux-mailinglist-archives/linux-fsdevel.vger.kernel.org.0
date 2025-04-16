Return-Path: <linux-fsdevel+bounces-46546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E4A8B4E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409B03AB8C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB49233722;
	Wed, 16 Apr 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2XkdRc3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xCFye5Wh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RCVgMjdh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H8ghe5UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBF225419
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794738; cv=none; b=JLxRTa5YZ7aO3clNlbH7dzg3Z8xSUjbaceUBO97QVs3bosuyXj8GNVBk/hzIBY65feIxTMpjRJNvcL++8k2ye5h6xUpR+AdoE7nTrm0wL4tpDg5ZOZFZWEmvlb74jWpDnEnNSNAGiJpmReLkhGHdmhUQcDdVbv6uOBOZRiBVyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794738; c=relaxed/simple;
	bh=GodOAskcLtHSu7odIU0A3MJHpsDVwKYa4n5215XdlhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIKBiPDwwWXG1AvuIopMLdgHfrUFQlxEIHIViPecuscpkv64RphzRr7L9sKpO0A0egCGMfR+uHjucgxTuAaN79b+u02MWDnAVBYW4YumRxqaRTtzTubTsNatq14d8DcXh/KXpgcomu1uXzyuSV4QVFQU7o+8FIDfKc1g5hy4MGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2XkdRc3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xCFye5Wh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RCVgMjdh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H8ghe5UZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF90421185;
	Wed, 16 Apr 2025 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744794735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQZ2eeaBtxrHbP9Px/mU/fgWsqj/ogBc9ZP61o6M+JQ=;
	b=2XkdRc3kL3UqZjBIux9plckJYbVfQV9fTUf+0LMOgvo7nviOHqW43TbP9gCoM4m7OZfLMz
	AdljKVZgtGmWvJTpW/xMC1R9FCZ25zxIelHGrJDMkcTrd9kQ2kRCQNnje7XwWeb52aOTf8
	D/DnYkReel3vf2l+lcKddmhnrcehqrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744794735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQZ2eeaBtxrHbP9Px/mU/fgWsqj/ogBc9ZP61o6M+JQ=;
	b=xCFye5WhIs+HV2+c1y/qS5DBjdwiitZPKOVB5ZW667Xzej1idHcC0sKYuqSm9LUuS+h08j
	KAGQtsN+KHc0pBAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744794734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQZ2eeaBtxrHbP9Px/mU/fgWsqj/ogBc9ZP61o6M+JQ=;
	b=RCVgMjdhCOJToqSg/ZMSUOHBCF39zA/I2XlZX6IXbPfrQoGdaPu71VMxAANeuoSZr7uQJY
	o9ZZ+MSCYXqkdsEIOC+b2KY7uvz5GnUImhYZL7MPv9VYFS9BgymwswDEcmiBfJ/yTxOj1X
	34W2BbxmG8/jDkLuBlPNHSjn9GIWzOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744794734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQZ2eeaBtxrHbP9Px/mU/fgWsqj/ogBc9ZP61o6M+JQ=;
	b=H8ghe5UZoW6YNP6MFlh44jhwuDMhdA3uaONdtD67O4TyJqQ5Y+2hTSrmXjpARZF1Z++RvH
	x+gKIdtjCaZ74nAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C35E613976;
	Wed, 16 Apr 2025 09:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gSSuL250/2d6bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:12:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 701CFA0947; Wed, 16 Apr 2025 11:12:10 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:12:10 +0200
From: Jan Kara <jack@suse.cz>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC vfs/for-next 1/1] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <qg2whv57hpyiw66ocb6zuhcus5yajqm3gypau3p655hp53pwnj@vxdhp2m7d5qg>
References: <20250415184346.39229-1-jdamato@fastly.com>
 <20250415184346.39229-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415184346.39229-2-jdamato@fastly.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 18:43:46, Joe Damato wrote:
> Avoid an edge case where epoll_wait arms a timer and calls schedule()
> even if the timer will expire immediately.
> 
> For example: if the user has specified an epoll busy poll usecs which is
> equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
> unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
> consumed the entire timeout duration so it is unnecessary to induce
> scheduling latency by calling schedule() (via schedule_hrtimeout_range).
> 
> This can be measured using a simple bpftrace script:
> 
> tracepoint:sched:sched_switch
> / args->prev_pid == $1 /
> {
>   print(kstack());
>   print(ustack());
> }
> 
> Before this patch is applied:
> 
>   Testing an epoll_wait app with busy poll usecs set to 1000, and
>   epoll_wait timeout set to 1ms using the script above shows:
> 
>      __traceiter_sched_switch+69
>      __schedule+1495
>      schedule+32
>      schedule_hrtimeout_range+159
>      do_epoll_wait+1424
>      __x64_sys_epoll_wait+97
>      do_syscall_64+95
>      entry_SYSCALL_64_after_hwframe+118
> 
>      epoll_wait+82
> 
>   Which is unexpected; the busy poll usecs should have consumed the
>   entire timeout and there should be no reason to arm a timer.
> 
> After this patch is applied: the same test scenario does not generate a
> call to schedule() in the above edge case. If the busy poll usecs are
> reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
> armed as expected.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Hum, I guess this is about the interpretation of the 'timeout' value of
epoll_pwait2() and friends. Does the runtime of the system call itself
(including possible polling) count into the timeout or does timeout mean
how long we should sleep after we've done all our work? The manpage says
"The timeout argument specifies the number of milliseconds that
epoll_wait() will block." which I guess can be understood both ways. Seeing
the epoll code it seems the author's intention was indeed rather the former.
So I guess feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/eventpoll.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f9898e60dd8b..ca0c7e843da7 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1980,6 +1980,14 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
>  	return ret;
>  }
>  
> +static int ep_schedule_timeout(ktime_t *to)
> +{
> +	if (to)
> +		return ktime_after(*to, ktime_get());
> +	else
> +		return 1;
> +}
> +
>  /**
>   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
>   *           event buffer.
> @@ -2095,7 +2103,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  
>  		write_unlock_irq(&ep->lock);
>  
> -		if (!eavail)
> +		if (!eavail && ep_schedule_timeout(to))
>  			timed_out = !schedule_hrtimeout_range(to, slack,
>  							      HRTIMER_MODE_ABS);
>  		__set_current_state(TASK_RUNNING);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

