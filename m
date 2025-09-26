Return-Path: <linux-fsdevel+bounces-62903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DBCBA483A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907471C065ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157722424C;
	Fri, 26 Sep 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZgAZFrk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAxhEVTZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZgAZFrk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAxhEVTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB388224240
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902154; cv=none; b=GPHzubO4RAGEvQ/AtzfumouHYJwjZOG3L/n6YCq1locXFHToCUIZV3ii1yI2nuGJwqoFYsEZ4Is5iyEww/JdW1d8QWt41J8bxWFisaVrqk+flADiMMB6W6UN1acZKM/iwFDcc+VqRO14T1iS7m9lPdlBRXaxVbZA3AGjFTHbHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902154; c=relaxed/simple;
	bh=elgYVV7Yt2w31P89M88TuIf6Pr72yi7Lqlmu1YhdFlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG9W5qEimYfls6Q8dcI1SoDj0hP7/psTwcXr01gpcNQvzzCtOl6PwKr21bNbRY+wMOCY1xgmHgDQS/GHqbv55wLrO0eVdW09ugxl5z/a8rBOK+LM1VKsvpHp9KXyDJpfpj9hP9KkedAl3/sNYWiophBKsS2ws4qQKIpEetXrsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZgAZFrk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KAxhEVTZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZgAZFrk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KAxhEVTZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9D683F48D;
	Fri, 26 Sep 2025 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758902150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC8Phlndb0wDab4iVYcdTlbtV7zJBXm9PxYdFxTriDQ=;
	b=QZgAZFrkDjd6JloaA7EBWiNkvbxBA6lDgrABuRAY8IsaSc5BIbvOn4Nd3ZrjSLXxdEjVJo
	Fw6knz8hoq55BAsC/PUyIVhaGuf6TYpUhfZfT9rvAxYoVcJoK592GMK17WgQVkr35Z8hkf
	+VNDLVWMVofZB8g1UoJDi4qOCkGmSnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758902150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC8Phlndb0wDab4iVYcdTlbtV7zJBXm9PxYdFxTriDQ=;
	b=KAxhEVTZsrHtvbMM85WeTon+TY6dFZkv0slOXRISEk0ViM/JPU+0gQH8nLVi0sOPLoBtkm
	1/zarfsXBwPrY+CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QZgAZFrk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KAxhEVTZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758902150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC8Phlndb0wDab4iVYcdTlbtV7zJBXm9PxYdFxTriDQ=;
	b=QZgAZFrkDjd6JloaA7EBWiNkvbxBA6lDgrABuRAY8IsaSc5BIbvOn4Nd3ZrjSLXxdEjVJo
	Fw6knz8hoq55BAsC/PUyIVhaGuf6TYpUhfZfT9rvAxYoVcJoK592GMK17WgQVkr35Z8hkf
	+VNDLVWMVofZB8g1UoJDi4qOCkGmSnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758902150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC8Phlndb0wDab4iVYcdTlbtV7zJBXm9PxYdFxTriDQ=;
	b=KAxhEVTZsrHtvbMM85WeTon+TY6dFZkv0slOXRISEk0ViM/JPU+0gQH8nLVi0sOPLoBtkm
	1/zarfsXBwPrY+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF581373E;
	Fri, 26 Sep 2025 15:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a5axKoa31mjcCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Sep 2025 15:55:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BF0BA0AA0; Fri, 26 Sep 2025 17:55:46 +0200 (CEST)
Date: Fri, 26 Sep 2025 17:55:46 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Julian Sun <sunjunchao@bytedance.com>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	peterz@infradead.org, akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
Message-ID: <dvfobm24dgl4hhvirwabai47toypkvrimv7rthevrcvig6xmjf@scpmbv7qucme>
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
 <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
 <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com>
 <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
 <xetmahjj5tlxksfxfkronyam6ppdeiobpdz2zuvigichqkqcos@6hembfwhlayn>
 <CAGudoHETCiATjWYcHbO_SBkE-X0fWWi0YCkn51+VLcjw7620oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHETCiATjWYcHbO_SBkE-X0fWWi0YCkn51+VLcjw7620oA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B9D683F48D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Fri 26-09-25 17:50:43, Mateusz Guzik wrote:
> On Fri, Sep 26, 2025 at 5:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 26-09-25 14:05:59, Mateusz Guzik wrote:
> > > On Fri, Sep 26, 2025 at 1:43 PM Julian Sun <sunjunchao@bytedance.com> wrote:
> > > >
> > > > On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> > > > > On Fri, Sep 26, 2025 at 4:26 AM Julian Sun <sunjunchao@bytedance.com> wrote:
> > > > >>
> > > > >> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> > > > >>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> > > > >>>> Writing back a large number of pages can take a lots of time.
> > > > >>>> This issue is exacerbated when the underlying device is slow or
> > > > >>>> subject to block layer rate limiting, which in turn triggers
> > > > >>>> unexpected hung task warnings.
> > > > >>>>
> > > > >>>> We can trigger a wake-up once a chunk has been written back and the
> > > > >>>> waiting time for writeback exceeds half of
> > > > >>>> sysctl_hung_task_timeout_secs.
> > > > >>>> This action allows the hung task detector to be aware of the writeback
> > > > >>>> progress, thereby eliminating these unexpected hung task warnings.
> > > > >>>>
> > > > >>>
> > > > >>> If I'm reading correctly this is also messing with stats how long the
> > > > >>> thread was stuck to begin with.
> > > > >>
> > > > >> IMO, it will not mess up the time. Since it only updates the time when
> > > > >> we can see progress (which is not a hang). If the task really hangs for
> > > > >> a long time, then we can't perform the time update—so it will not mess
> > > > >> up the time.
> > > > >>
> > > > >
> > > > > My point is that if you are stuck in the kernel for so long for the
> > > > > hung task detector to take notice, that's still something worth
> > > > > reporting in some way, even if you are making progress. I presume with
> > > > > the patch at hand this information is lost.
> > > > >
> > > > > For example the detector could be extended to drop a one-liner about
> > > > > encountering a thread which was unable to leave the kernel for a long
> > > > > time, even though it is making progress. Bonus points if the message
> > > > > contained info this is i/o and for which device.
> > > >
> > > > Let me understand: you want to print logs when writeback is making
> > > > progress but is so slow that the task can't exit, correct?
> > > > I see this as a new requirement different from the existing hung task
> > > > detector: needing to print info when writeback is slow.
> > > > Indeed, the existing detector prints warnings in two cases: 1) no
> > > > writeback progress; 2) progress is made but writeback is so slow it will
> > > > take too long.
> > >
> > > I am saying it would be a nice improvement to extend the htd like that.
> > >
> > > And that your patch as proposed would avoidably make it harder -- you
> > > can still get what you are aiming for without the wakeups.
> > >
> > > Also note that when looking at a kernel crashdump it may be beneficial
> > > to know when a particular thread got first stuck in the kernel, which
> > > is again gone with your patch.
> >
> > I understand your concerns but I think it's stretching the goals for this
> > patch a bit too much.  I'm fine with the patch going in as is and if Julian
> > is willing to work on this additional debug features, then great!
> >
> 
> I am not asking the patch does all that work, merely that it gets
> implemented in a way which wont require a rewrite should the above
> work get done. Which boils down to storing the timestamp somewhere in
> task_struct.

Well, but that doesn't really make much sense without the debug patch
itself, does it? And it could be a potential discussion point. So I think
the debug patch should just move the timestamp from the wb completion to
task_struct if that's needed...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

