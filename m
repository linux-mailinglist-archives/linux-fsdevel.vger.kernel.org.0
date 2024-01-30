Return-Path: <linux-fsdevel+bounces-9526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FC84242A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060D8285B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E014679EA;
	Tue, 30 Jan 2024 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1/K2Lja";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1pRKWzY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bTJ6JEVv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9bOvETPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68167730;
	Tue, 30 Jan 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615676; cv=none; b=JLJyX56erIRwSqyvmF6W1MIElMjogiSUtj+PNtCC4S7tX2I0p2Y9+SxJTwnpmd0AcrqDetyLc+OChrVAI5Jrno/eLl+U0RZQllS2DmChSmQshrpTSPAthKY3k6SxGNJpCLnftS+l9s3EiGfPsvJzTCBdhcYOXG/oGZOW1w+z3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615676; c=relaxed/simple;
	bh=uFzF0c7y0Xa5eSfpXQjqGeNrxWa15vZJgvwqZSw5274=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQqXJtst+uodcEFAwQm4a2rnFHYMGzoT9NO5nKOtLu1Nq1t8MF4VwreQRE7jmDAMSqCUiGBz/8W85FwNRwCHnKl+yqSIzAHt0qSRRzFr9zrWRrr2jOTp5yGO1MwSFEGbluwU1HMb9yCv65JnnDR4efeXszt0V4S6g6lNErx00dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1/K2Lja; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1pRKWzY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bTJ6JEVv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9bOvETPW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76A7A1F848;
	Tue, 30 Jan 2024 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706615672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnqLZBlDKpe4vlipCmXXPECUe1oy+3ydvLI/2aiDEv8=;
	b=a1/K2LjasCHk8VC1+Mv9MMio1D7f+pKVCjtL2QvlP4ud6ZJn/jrPzv1HW0lZw4nhyiE6OO
	w8Mh25o1VAaeNHtbAPaiBgF3wrKuDeVvDWQv9MJnj1MDg5EQNoflnBYd2tcN86clPJF433
	hu1jDRX/Ii9KMMGot0KKUUz9U44Bl00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706615672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnqLZBlDKpe4vlipCmXXPECUe1oy+3ydvLI/2aiDEv8=;
	b=o1pRKWzY/K2bnB4oa2+DxPSI9kNchKco4S3HJJKut0FnJlyV5nlQf9ch3GPYbyyj8+EYmB
	WRpCMU/GfoxJPhAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706615670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnqLZBlDKpe4vlipCmXXPECUe1oy+3ydvLI/2aiDEv8=;
	b=bTJ6JEVvHTL1X4SldT6ke7pjLnJ03JzIPjm3+FdH/PZPETNwOsA3YMkmxfysIWSOo48ozg
	XPJbtaljXB/+zCw0hCxFgefHm5bjr6Z+X2TaftOVjuTMHCfJvTVJzPkqZq3nYi9oWlhKQ2
	1muuCC42T7KLL7Bpk8G9gcUi12qQy1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706615670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnqLZBlDKpe4vlipCmXXPECUe1oy+3ydvLI/2aiDEv8=;
	b=9bOvETPWQ8F6h2aztso666fLDiQVBQP4e0vjNNAhAyWRzfiXw3Zc86Y5EjZnR/47SVGohq
	Q+WVAr8dJP7OTdDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6327A13462;
	Tue, 30 Jan 2024 11:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9JcxGHbjuGWDFAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 11:54:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B758A0807; Tue, 30 Jan 2024 12:54:30 +0100 (CET)
Date: Tue, 30 Jan 2024 12:54:30 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	chenzhongjin@huawei.com, dchinner@redhat.com, hch@infradead.org,
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in __getblk_gfp
Message-ID: <20240130115430.rljjwjcji3vlrgyz@quack3>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <0000000000000d130006101f7e0e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000d130006101f7e0e@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd];
	 TAGGED_RCPT(0.00)[69b40dc5fd40f32c199f];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Mon 29-01-24 17:15:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116642dfe80000
> start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a77593680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104a593680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

This doesn't look correct. The problem here really is that sysv is calling
sb_bread() under a RWLOCK - pointers_lock - in get_block(). Which more or
less shows nobody has run sysv in ages because otherwise the chances of
sleeping in atomic context are really high? Perhaps another candidate for
removal?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

