Return-Path: <linux-fsdevel+bounces-47511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0AA9F06E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6FE3B0A98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1826981E;
	Mon, 28 Apr 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxAQkRVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twh4wyhw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxAQkRVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twh4wyhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B42690CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842493; cv=none; b=Usie19O7V9Lyrep8zAiff5JWe5vuj/Awyy9ipmd48naqWgHOCeMuVF6qRJfuMHIjnjddEyASMV6+NU58yBhRuOm+sDerdwApIWJO1caXP+WeO4QwVKaDaQ+H7f8edKKNVXV8exln/ckPMPwFy/2SS/M2Qp9LWK01D2M/dxKGS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842493; c=relaxed/simple;
	bh=aMHNCdM1B1YlVmqJsC2X9YtwGoK0CghHtIKw9Du8ts8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjZSf/48cAtgXpajo1faLOm862soErO+wS/Xoayxh2tDjexqx0m54wpv/MaMGNRG21sV6bfFLGtzyda8oFeS/opkRjLUYQDM/YCuY/AsQRO1ltjsJkRxKxo1dnn9rHi4MUyreTxbW4srGhtvQuYQryF0Cod4WdPubg8QIPOS3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxAQkRVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twh4wyhw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxAQkRVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twh4wyhw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6B7621202;
	Mon, 28 Apr 2025 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745842489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+mMo7uk5RmaOGiC0vVI1M/VdXJrx2bD5Y8WN/ZyEgE=;
	b=bxAQkRVrEjcDA3Bc0g09UJpaspspCSwvxc5dVOHXSHPd/0von1KPy7XBOR3levpJB4e+jB
	ya11PrwjzkiI0p69ccjIMXZphqhy7D6B1fjeylseDI2bpjV1/0JO/RDC+srMQaOXgxlgwb
	WOPyX+83TfCfC6ETD4EEWXL9FaviWEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745842489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+mMo7uk5RmaOGiC0vVI1M/VdXJrx2bD5Y8WN/ZyEgE=;
	b=twh4wyhwkdZUAE/vGn23FosDZylyMRjmCF0BvcbWmwLnC+zsoKiejnpt1p85QlonWcUrqD
	6HNgGWeh6XgqYoBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745842489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+mMo7uk5RmaOGiC0vVI1M/VdXJrx2bD5Y8WN/ZyEgE=;
	b=bxAQkRVrEjcDA3Bc0g09UJpaspspCSwvxc5dVOHXSHPd/0von1KPy7XBOR3levpJB4e+jB
	ya11PrwjzkiI0p69ccjIMXZphqhy7D6B1fjeylseDI2bpjV1/0JO/RDC+srMQaOXgxlgwb
	WOPyX+83TfCfC6ETD4EEWXL9FaviWEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745842489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+mMo7uk5RmaOGiC0vVI1M/VdXJrx2bD5Y8WN/ZyEgE=;
	b=twh4wyhwkdZUAE/vGn23FosDZylyMRjmCF0BvcbWmwLnC+zsoKiejnpt1p85QlonWcUrqD
	6HNgGWeh6XgqYoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 957621336F;
	Mon, 28 Apr 2025 12:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jf9/JDlxD2iqSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Apr 2025 12:14:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4011AA0AD5; Mon, 28 Apr 2025 14:14:45 +0200 (CEST)
Date: Mon, 28 Apr 2025 14:14:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426-haben-redeverbot-0b58878ac722@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sat 26-04-25 14:29:15, Christian Brauner wrote:
> On Wed, Apr 16, 2025 at 06:58:25PM +0000, Joe Damato wrote:
> > Avoid an edge case where epoll_wait arms a timer and calls schedule()
> > even if the timer will expire immediately.
> > 
> > For example: if the user has specified an epoll busy poll usecs which is
> > equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
> > unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
> > consumed the entire timeout duration so it is unnecessary to induce
> > scheduling latency by calling schedule() (via schedule_hrtimeout_range).
> > 
> > This can be measured using a simple bpftrace script:
> > 
> > tracepoint:sched:sched_switch
> > / args->prev_pid == $1 /
> > {
> >   print(kstack());
> >   print(ustack());
> > }
> > 
> > Before this patch is applied:
> > 
> >   Testing an epoll_wait app with busy poll usecs set to 1000, and
> >   epoll_wait timeout set to 1ms using the script above shows:
> > 
> >      __traceiter_sched_switch+69
> >      __schedule+1495
> >      schedule+32
> >      schedule_hrtimeout_range+159
> >      do_epoll_wait+1424
> >      __x64_sys_epoll_wait+97
> >      do_syscall_64+95
> >      entry_SYSCALL_64_after_hwframe+118
> > 
> >      epoll_wait+82
> > 
> >   Which is unexpected; the busy poll usecs should have consumed the
> >   entire timeout and there should be no reason to arm a timer.
> > 
> > After this patch is applied: the same test scenario does not generate a
> > call to schedule() in the above edge case. If the busy poll usecs are
> > reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
> > armed as expected.
> > 
> > Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  v2: 
> >    - No longer an RFC and rebased on vfs/vfs.fixes
> >    - Added Jan's Reviewed-by
> >    - Added Fixes tag
> >    - No functional changes from the RFC
> > 
> >  rfcv1: https://lore.kernel.org/linux-fsdevel/20250415184346.39229-1-jdamato@fastly.com/
> > 
> >  fs/eventpoll.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 100376863a44..4bc264b854c4 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1996,6 +1996,14 @@ static int ep_try_send_events(struct eventpoll *ep,
> >  	return res;
> >  }
> >  
> > +static int ep_schedule_timeout(ktime_t *to)
> > +{
> > +	if (to)
> > +		return ktime_after(*to, ktime_get());
> > +	else
> > +		return 1;
> > +}
> > +
> >  /**
> >   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
> >   *           event buffer.
> > @@ -2103,7 +2111,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> >  
> >  		write_unlock_irq(&ep->lock);
> >  
> > -		if (!eavail)
> > +		if (!eavail && ep_schedule_timeout(to))
> >  			timed_out = !schedule_hrtimeout_range(to, slack,
> >  							      HRTIMER_MODE_ABS);
> 
> Isn't this buggy? If @to is non-NULL and ep_schedule_timeout() returns
> false you want to set timed_out to 1 to break the wait. Otherwise you
> hang, no?

Yep, looks like that. Good spotting!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

