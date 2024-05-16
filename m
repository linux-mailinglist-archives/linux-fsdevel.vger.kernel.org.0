Return-Path: <linux-fsdevel+bounces-19586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DE8C787A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779921C2090A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0614B965;
	Thu, 16 May 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydLXNBzY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E3EP4dB3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilPM3lk7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJGao9t8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9A1DFEF;
	Thu, 16 May 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870157; cv=none; b=lkBLEID2+MytS5s7+yeqR5nVfthuzSuZErtGAtittJLa3u5HuBgn/sp89MlghkLS+KzFw7L3Kl1VvSchISWywD9m5h3blvYWF+1GQLxahC+sGCk3e9yVCp8cxsivk2nXjX83HO9qokoxayCcL7xuQ9yt/g0Phi6F2dCs4Es+lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870157; c=relaxed/simple;
	bh=ijQlsnNW7lJzuUB4KNofJ7wkb6Kv+AAcAqf1SHUvUMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRLe5/G8uMhOGmvSxrNcpZDvJubAurusrB/lqGQM5gfwF/+i0nJOP2JmE6a8dKRRA3TJhJfVYq35EM4IE42U1jMbM8ZA60PScwLBp2ZH83cLTT066YKGNRJLOCAqEs3TQ2RelF8/XVfigLS2CnKGGtJU51DV7GbJ7YcrnQZQSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydLXNBzY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E3EP4dB3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilPM3lk7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJGao9t8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF9445C54B;
	Thu, 16 May 2024 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715870150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdc0aA9Zp1xa9M6PnPI2To4Pdsq08YKwmPt1p6bHXds=;
	b=ydLXNBzYKk47goltPP396i0/+nCqnKsEPfY0iIYOEXEo0DDO3+KioHjg03VDc4rca26OIl
	QcehGjz//D/2lut8IpxtV7htuDMQRSXJYyZFlkefzpsi7qSxAoumobxZZhwDtOs3ao0EHV
	02PNn4/GvCLcJjrI8f4Tp8JX6SR3+b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715870150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdc0aA9Zp1xa9M6PnPI2To4Pdsq08YKwmPt1p6bHXds=;
	b=E3EP4dB3b0vKwoMmA1wXyTcHWVPF9AWHPj8/bYH2lk3hur0BI8NdvXSjrKCarZZwiNX2gG
	eNEZWVZ1phh4uqDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ilPM3lk7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vJGao9t8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715870149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdc0aA9Zp1xa9M6PnPI2To4Pdsq08YKwmPt1p6bHXds=;
	b=ilPM3lk7RvZlVDpahCWHZClAXveeyL8WpsnlNwYk973dPsQMoZSWpr2Bz34wSf+T61ao+Z
	tw5GkwKcLon7CM0RVSuEavXH6XJ1mRNSp89BL2BX8ZyeZzEEdG2+/KMi/6Wj9Fs7bWZWgt
	wApofg3HgjAhWKZA5AO3JV/3FsSxLyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715870149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdc0aA9Zp1xa9M6PnPI2To4Pdsq08YKwmPt1p6bHXds=;
	b=vJGao9t8pWC7xOQI0ixHs2Im3wDcaVxv2J7eOPQfojRMR51Obztip2WPliG/U9SwQ08eNf
	bBB8zhu++b2Tt6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B845C137C3;
	Thu, 16 May 2024 14:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JxTOLMUZRmbfXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 14:35:49 +0000
Date: Thu, 16 May 2024 16:35:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Sterba <dsterba@suse.cz>,
	syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20240516143543.GY4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000c8fcd905adefe24b@google.com>
 <20240515161314.GO4449@twin.jikos.cz>
 <20240515170054.GM2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515170054.GM2118490@ZenIV>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[c92c93d1f1aaaacdb9db];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CF9445C54B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.71

On Wed, May 15, 2024 at 06:00:54PM +0100, Al Viro wrote:
> On Wed, May 15, 2024 at 06:13:14PM +0200, David Sterba wrote:
> > On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    d012a719 Linux 5.9-rc2
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
> > > 
> > > The issue was bisected to:
> > > 
> > > commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
> > > Author: Marc Zyngier <maz@kernel.org>
> > > Date:   Wed Aug 19 16:12:17 2020 +0000
> > > 
> > >     epoll: Keep a reference on files added to the check list
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
> > > Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
> > > 
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/inode.c:1668!
> > 
> > #syz set subsystem: fs
> > 
> > This has been among btrfs bugs but this is is 'fs' and probably with a
> > fix but I was not able to identify it among all the changes in
> > eventpoll.c
> 
> It has nothing to do with btrfs, and there's a good chance it had been
> fixed as a side effect of 319c15174757 "epoll: take epitem list out of struct file"
> merge at 1a825a6a0e7e in 5.10 merge window; IOW, it should be in 5.11-rc1.

Ok, thanks, let's use the commit 319c15174757 as the fix,

#syz fix: epoll: take epitem list out of struct file

