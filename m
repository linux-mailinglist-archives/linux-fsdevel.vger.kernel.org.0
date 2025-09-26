Return-Path: <linux-fsdevel+bounces-62901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C1BA4807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1729F17B021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037DE22B8B0;
	Fri, 26 Sep 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jnz73II3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmnZOYsY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTfdHk/3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkXk8f7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF62356C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901738; cv=none; b=GFmbkHSIgtK28lpXm1Dbe2dhD5gJLnE+wba9PoyM/vVfgj91z4oXlcRlTsohWY/JnGl17WFISbh8zny6EW8+x0Eg4rQJvZ76pP4ab8ywN6Kg/D/h4PNOQLigRh6QUdIyWJPPcNEjAM8iOXBdcvSsbNumDnK8qFKHLVC4spLTTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901738; c=relaxed/simple;
	bh=xk7rLAGZfo0NJ/+Gh+IFF2tTAWBFTwPs24o/4EIsWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+JflX3NPpBLpwH61bcD8y7siurfy7iZ9KeFTVGiWn3RYv5IL3qFePasQv5tsvcc8JzAJ1ofDohKb+54b8CjHSMZp6FUVHdqbZZHaS+0cA3sA8DWLNSOtd6X4KmojE9Lct3cMoybkVPrY2d8tUilYnc/33i5MGE3qlC57S+wzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jnz73II3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmnZOYsY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTfdHk/3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YkXk8f7V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F075124383;
	Fri, 26 Sep 2025 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758901734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxp670mYR72L+cU9R15zF/sVX2zuz5V5RhVGux1U57M=;
	b=jnz73II3Uq5C0vDv7L/1Eh/q4+6F3/jfqaOUFqxsj6dPzc3es5ZE74hr6/+DTPppiy4C1d
	9X4GXXRPy/8XY00lYkQHbdw+kPUoOjCApgBWZj8ZQevkQoUymYCiMMN8kSBW6mdMxbDXZb
	JV7juGgsOYMfD7TaeuIl2o800adHwbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758901734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxp670mYR72L+cU9R15zF/sVX2zuz5V5RhVGux1U57M=;
	b=PmnZOYsYGueBSMAXwXE5GLJ7fITcBbLGVYJdrOMLoXg+yf56ydsmwF/Pu90vQJrXWEfBdK
	qvkLeca2DCmNERDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758901732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxp670mYR72L+cU9R15zF/sVX2zuz5V5RhVGux1U57M=;
	b=jTfdHk/33DJ3gfYIEAdnyJMPtU4t4i2OvDR95inAT/KMW6n3xoYw276/Q3o/XbrHiF485T
	sg1Oykk9eddtXdfCDtLbGvZowIYj0DCrVBzLO7073eb/qdKOl1y2iJwDhhaEXQhFC1RHw0
	65Eh6R74cnwNZqpZvvTLvQIZIyVp3+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758901732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxp670mYR72L+cU9R15zF/sVX2zuz5V5RhVGux1U57M=;
	b=YkXk8f7VHPwmqZwrp14Vdn5o+m2dZpwAUchvByVp2FRlTv4bA3AsliD4+ZlIaAvbjr5D6N
	Pm1uTmhvkhdsfrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E216A1373E;
	Fri, 26 Sep 2025 15:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 49STNuS11mjGBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Sep 2025 15:48:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8AF7EA0AA0; Fri, 26 Sep 2025 17:48:52 +0200 (CEST)
Date: Fri, 26 Sep 2025 17:48:52 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	peterz@infradead.org, akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
Message-ID: <xetmahjj5tlxksfxfkronyam6ppdeiobpdz2zuvigichqkqcos@6hembfwhlayn>
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
 <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
 <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com>
 <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 26-09-25 14:05:59, Mateusz Guzik wrote:
> On Fri, Sep 26, 2025 at 1:43 PM Julian Sun <sunjunchao@bytedance.com> wrote:
> >
> > On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> > > On Fri, Sep 26, 2025 at 4:26 AM Julian Sun <sunjunchao@bytedance.com> wrote:
> > >>
> > >> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> > >>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> > >>>> Writing back a large number of pages can take a lots of time.
> > >>>> This issue is exacerbated when the underlying device is slow or
> > >>>> subject to block layer rate limiting, which in turn triggers
> > >>>> unexpected hung task warnings.
> > >>>>
> > >>>> We can trigger a wake-up once a chunk has been written back and the
> > >>>> waiting time for writeback exceeds half of
> > >>>> sysctl_hung_task_timeout_secs.
> > >>>> This action allows the hung task detector to be aware of the writeback
> > >>>> progress, thereby eliminating these unexpected hung task warnings.
> > >>>>
> > >>>
> > >>> If I'm reading correctly this is also messing with stats how long the
> > >>> thread was stuck to begin with.
> > >>
> > >> IMO, it will not mess up the time. Since it only updates the time when
> > >> we can see progress (which is not a hang). If the task really hangs for
> > >> a long time, then we can't perform the time update—so it will not mess
> > >> up the time.
> > >>
> > >
> > > My point is that if you are stuck in the kernel for so long for the
> > > hung task detector to take notice, that's still something worth
> > > reporting in some way, even if you are making progress. I presume with
> > > the patch at hand this information is lost.
> > >
> > > For example the detector could be extended to drop a one-liner about
> > > encountering a thread which was unable to leave the kernel for a long
> > > time, even though it is making progress. Bonus points if the message
> > > contained info this is i/o and for which device.
> >
> > Let me understand: you want to print logs when writeback is making
> > progress but is so slow that the task can't exit, correct?
> > I see this as a new requirement different from the existing hung task
> > detector: needing to print info when writeback is slow.
> > Indeed, the existing detector prints warnings in two cases: 1) no
> > writeback progress; 2) progress is made but writeback is so slow it will
> > take too long.
> 
> I am saying it would be a nice improvement to extend the htd like that.
> 
> And that your patch as proposed would avoidably make it harder -- you
> can still get what you are aiming for without the wakeups.
> 
> Also note that when looking at a kernel crashdump it may be beneficial
> to know when a particular thread got first stuck in the kernel, which
> is again gone with your patch.

I understand your concerns but I think it's stretching the goals for this
patch a bit too much.  I'm fine with the patch going in as is and if Julian
is willing to work on this additional debug features, then great!

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

