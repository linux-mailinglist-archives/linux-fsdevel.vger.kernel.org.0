Return-Path: <linux-fsdevel+bounces-11998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3DD85A277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7734D2873F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11113613C;
	Mon, 19 Feb 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KjXgly4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pRHZFLHk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhKQFUXf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbdXmxzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14423611F;
	Mon, 19 Feb 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343350; cv=none; b=hmGxXW3RCrX1Q79MurCaPZQ6SVt75EmWMM08SD9OF5z2nVfZEdnC6w+5yf5FGtvnR5kuqDX5+39hzenIqi5YI6m41gU/gkx5qCvg9dH1TD1NMZGHy2SKIrLY95EMoEeExhdfrErL9BoktD6IVs14pZQaXh2sez54SfEwBwG1jiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343350; c=relaxed/simple;
	bh=Lo6sCC1fC1+Bel/lxSou5ElnZrU/dZZysDocGA56b3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnPWsl5r5z/4uKygnbD/NnmlO5ijCC0R+qUZjvvvzcsMOv1aKMrrH+6bX2PhnsoJ2XSODxzo6HjikNzcCum+HPBC8HytHsobwJ21Wl8FaZhAO20SsYil3QI+sV5I2b7H9LU/A+7KCek6aK/T3a5+GYrdcYJIwTWv/NyWLgpGDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KjXgly4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pRHZFLHk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhKQFUXf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbdXmxzi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E65E71FD08;
	Mon, 19 Feb 2024 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtBT5SbK5Ffzv4/eeYYKmEWeIOhVJQ4lapLMMc+zZQw=;
	b=2KjXgly4IeIz4cFBp8sf4WsGU6XX2O7J6KXBewR3L/1IMOVCmjzEVoiGpRr9UPDIY8eKOR
	nsscKCoKSCeM1UIjrbEH7tkEd4fsmzwOnwrY9aGrGDm1YjhQODnUDgOuijtYKoH+Nq5oLa
	s6mqSkk7MuwGAoO1V9Akr4VAoZfGmz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtBT5SbK5Ffzv4/eeYYKmEWeIOhVJQ4lapLMMc+zZQw=;
	b=pRHZFLHk3VmU0NtlEWXphz1uXfmwerB+8fwMiNLLHp2jWvfJ03HqyXT9c/58z8hAfo31T/
	XSKEWfvHvw8qKhAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtBT5SbK5Ffzv4/eeYYKmEWeIOhVJQ4lapLMMc+zZQw=;
	b=fhKQFUXfjxyHvrLxRytxafM3WEBrLLF6PERFfCdzcWF6/mz34e5EHId4sFAqLVmH6rpZa9
	Y7E1GCgvf59imMxCDx+/sBxxckEiekj6Dtw8iYRJyxrfzIbsj76PEw+6F5dilQ2O/7Svs9
	riVcMNJEQFVWpe4zm4yhgXev7+ELrmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtBT5SbK5Ffzv4/eeYYKmEWeIOhVJQ4lapLMMc+zZQw=;
	b=wbdXmxziEqWNuRtXEnNjfW64eHMn+NBCs1qPXD0FktTIbtxWaDLBCbopk48YyQ1Kdh1nFX
	2u1QoxcZxFaWxrCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D83E613585;
	Mon, 19 Feb 2024 11:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 53M7NDJA02VybgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:49:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 814E0A0806; Mon, 19 Feb 2024 12:49:06 +0100 (CET)
Date: Mon, 19 Feb 2024 12:49:06 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, hdanton@sina.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	trix@redhat.com
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in
 __lock_acquire (5)
Message-ID: <20240219114906.nbjdxtnp6mdxvttv@quack3>
References: <0000000000004b7b3a05f0bc25f8@google.com>
 <00000000000097c4480611a69ec8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000097c4480611a69ec8@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fhKQFUXf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wbdXmxzi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLz99z39gjb6to7kquhk75tipd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[38.29%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4];
	 TAGGED_RCPT(0.00)[0bc4c0668351ce1cab8f];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,kernel.dk,kernel.org,sina.com,suse.cz,vger.kernel.org,lists.linux.dev,google.com,googlegroups.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: E65E71FD08
X-Spam-Flag: NO

On Sun 18-02-24 03:53:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1301e1d0180000
> start commit:   ce9ecca0238b Linux 6.6-rc2
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=0bc4c0668351ce1cab8f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11814954680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103bc138680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 

Again. Nothing really suspicious in the reproducer but there are no working
reproducers anymore... Since this is ntfs3:

#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

