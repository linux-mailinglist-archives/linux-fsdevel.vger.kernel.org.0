Return-Path: <linux-fsdevel+bounces-11845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C4857BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13261C22DCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3777F2B;
	Fri, 16 Feb 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCbMbtZT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4vMxypF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e7U0D98d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="laPN68nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB71E532;
	Fri, 16 Feb 2024 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083828; cv=none; b=kYT4PPovQS6992HgD3MONoGbdJqhZKbSigLaMWfHZFI9JROHP4aUW92uXlA22YMzTk+LeqPW/IzJLiQXT70FxzbKftKMCwKvkUfLcCrivONNIezJJIvMXne8sH9vQby4saDzifF9mdwvewSw96Ol9gH1JHG5v/sh5ZE42azUZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083828; c=relaxed/simple;
	bh=l3ajDPrIVTw6Q5sonzmGfmd32ShXl9NtKGmNFXbWWTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4SMpOcb+o2lupSuO/OvCUpVET50CGmfOpFvzkAvc7lX2v8lkBxDVABreNkYVln526ZYFYp/wtmIwx/L5FDanCAkCNV2dgynIUllARnldgSb3MzrrbPo6NfqNitc9kbQOO6oHjk8bzjStKkr3/A/hpYKNrebF44FDcF2nWWnZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCbMbtZT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4vMxypF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e7U0D98d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=laPN68nw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1903A1FB65;
	Fri, 16 Feb 2024 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708083819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icwAL7s9OAkuwREddOlMt/tnCHt0fYsLsyeQACPjgPk=;
	b=OCbMbtZTc64wIhn5SoHc8DTXHZ0apk/yo1DRmwW34/oznN60E/jdo4YahJfU/saC7EAVYJ
	5CNWtn1f9LxxfblPHOVL2GDHTVIyfNuHN1YIjnugZeY/U+bhstM+Uc2Kw7QjEhgDz/KXaR
	jOSLUl0d1AvGFR6xV+IVOjwTIV1aeT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708083819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icwAL7s9OAkuwREddOlMt/tnCHt0fYsLsyeQACPjgPk=;
	b=D4vMxypF1XJBVBiph1sw5PTBXT4rfXvzPFewLzA5BvlgpZaobObLYLXb6XM5xSua90OsVV
	MfawoIH6WU4OHUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708083817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icwAL7s9OAkuwREddOlMt/tnCHt0fYsLsyeQACPjgPk=;
	b=e7U0D98ditlMFjMUMDAt441EXfPNbRU4uDcBdR37rLHVAfTLRYOLqQs4wynTJms6M0ARQK
	+gk6sZ62txt+JhE6q0z0yca17GFWiVxxhvWx0eTRUA0FztBBZaE80rtI/L/tZvfJ+a6wZu
	8vy44pnb2aYrt6+PoRk5qjT0RGiCit4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708083817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icwAL7s9OAkuwREddOlMt/tnCHt0fYsLsyeQACPjgPk=;
	b=laPN68nw7ULCeANaKX0wO90u58mGF7oAuVl+Hvwhq0CrkImEVc+WHZuktgbQ9bHgnnYJNG
	2nnDobAmAqMRaEAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 09FBB13421;
	Fri, 16 Feb 2024 11:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /e5rAmlKz2U2FwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 16 Feb 2024 11:43:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A27A1A0807; Fri, 16 Feb 2024 12:43:32 +0100 (CET)
Date: Fri, 16 Feb 2024 12:43:32 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4fcffdd85e518af6f129@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, akpm@linux-foundation.org, anprice@redhat.com,
	axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com,
	dvyukov@google.com, elver@google.com, gfs2@lists.linux.dev,
	glider@google.com, jack@suse.cz, kasan-dev@googlegroups.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] INFO: task hung in write_cache_pages (3)
Message-ID: <20240216114332.syzemwegji72j4uh@quack3>
References: <0000000000001f905c0604837659@google.com>
 <000000000000b06c9e06117db32b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b06c9e06117db32b@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e7U0D98d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=laPN68nw
X-Spamd-Result: default: False [2.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21];
	 TAGGED_RCPT(0.00)[4fcffdd85e518af6f129];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.01)[46.59%];
	 R_RATELIMIT(0.00)[to_ip_from(RL4bxzs479wr4ugdxt3xrjx6ud)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.68
X-Rspamd-Queue-Id: 1903A1FB65
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Fri 16-02-24 03:04:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151b2b78180000
> start commit:   92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17933a00680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef7104680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

