Return-Path: <linux-fsdevel+bounces-14415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4F87C21D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036B51F21AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF7745FD;
	Thu, 14 Mar 2024 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WDsjItyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMtvHE/Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WDsjItyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMtvHE/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161D73188;
	Thu, 14 Mar 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437256; cv=none; b=t30ObtLEMb8UGTlk9lN7MC+3i/RHgQ/Yg6uPpLqSCQXdTYj5htCQCqE9MuhKlMq7OHZ8ON3Ew1PYyFB1QewkmJzWmXdNhs2Ib+ghh81412fvSNfBaCHkgIrpvzZZymCizjK96I0M39QKilYjwHM2ODiKu2EaME9XnymkeaEyItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437256; c=relaxed/simple;
	bh=B/dUDJ+FC/Q/7I3NTS5TFK+8o6kzp+UWMPQy2PAnVcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNqwzpAmtXgHatYF1KT3/hgQBrajDbNaapd3y0xNQcBuTcATPwtn1cGPVtkpWIP3GmF3olIpBaTy+uax6XneGxpXiUtcdnWMEP6WRgblL4coH8cV0zuguVB+DiHEe9JDlw0fNerJkFHLBXhOHIAR7GBcOFA5Dhd9UvHamXrMIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WDsjItyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMtvHE/Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WDsjItyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMtvHE/Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67F0F21CF9;
	Thu, 14 Mar 2024 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710437251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/+9/5bjIzrw/RZYm6gEINh9Fv0oieKWok1BqPHL2UI=;
	b=WDsjItyKabrx37SaO3uWk+sTT/DSXz9vPEfziNhENeI7I3SEdjWvIefwpKkp3Ysah3F6Zd
	dpZjyTLisnQz1DBWRDRGzbFEm/RCg1Dnhg3mCvB3L3YiODhBa87XYj2x+gac8oZmIkgSFV
	Oix3kU4UaS4dPTyipV05Chr8j+yMBI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710437251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/+9/5bjIzrw/RZYm6gEINh9Fv0oieKWok1BqPHL2UI=;
	b=MMtvHE/Q0ZtkFdlO0FtVG2ZJvC1sQCIqxBGrepyFb0Ic20C2ZywYv7yRSTYUFN6ZyHUVfv
	j8SSWpewRBcZ3sAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710437251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/+9/5bjIzrw/RZYm6gEINh9Fv0oieKWok1BqPHL2UI=;
	b=WDsjItyKabrx37SaO3uWk+sTT/DSXz9vPEfziNhENeI7I3SEdjWvIefwpKkp3Ysah3F6Zd
	dpZjyTLisnQz1DBWRDRGzbFEm/RCg1Dnhg3mCvB3L3YiODhBa87XYj2x+gac8oZmIkgSFV
	Oix3kU4UaS4dPTyipV05Chr8j+yMBI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710437251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/+9/5bjIzrw/RZYm6gEINh9Fv0oieKWok1BqPHL2UI=;
	b=MMtvHE/Q0ZtkFdlO0FtVG2ZJvC1sQCIqxBGrepyFb0Ic20C2ZywYv7yRSTYUFN6ZyHUVfv
	j8SSWpewRBcZ3sAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B1451368B;
	Thu, 14 Mar 2024 17:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /2IzFoMz82XAUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 17:27:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C5AAA07D9; Thu, 14 Mar 2024 18:27:31 +0100 (CET)
Date: Thu, 14 Mar 2024 18:27:31 +0100
From: Jan Kara <jack@suse.cz>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>,
	axboe@kernel.dk, brauner@kernel.org, jmorris@namei.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	serge@hallyn.com, syzkaller-bugs@googlegroups.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
Message-ID: <20240314172731.vj4tspj6yudztmxu@quack3>
References: <000000000000fcfb4a05ffe48213@google.com>
 <0000000000009e1b00060ea5df51@google.com>
 <20240111092147.ywwuk4vopsml3plk@quack3>
 <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
 <20240314155417.aysvaktvvqxc34zb@quack3>
 <CANp29Y6uevNW1SmXi_5muEeruP0TVh9Y9xwhgKO==J3fh8oa=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y6uevNW1SmXi_5muEeruP0TVh9Y9xwhgKO==J3fh8oa=w@mail.gmail.com>
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[33.28%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[28aaddd5a3221d7fd709];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLqycc6etx38sbaub577ukw8bm)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi Aleksandr,

On Thu 14-03-24 17:21:30, Aleksandr Nogikh wrote:
> Yes, the CONFIG_BLK_DEV_WRITE_MOUNTED=n change did indeed break our C
> executor code (and therefore our C reproducers). I posted a fix[1]
> soon afterwards, but the problem is that syzbot will keep on using old
> reproducers for old bugs. Syzkaller descriptions change over time, so
> during bisection and patch testing we have to use the exact syzkaller
> revision that detected the original bug. All older syzkaller revisions
> now neither find nor reproduce fs bugs on newer Linux kernel revisions
> with CONFIG_BLK_DEV_WRITE_MOUNTED=n.

I see, thanks for explanation!

> If the stream of such bisection results is already bothering you and
> other fs people, a very quick fix could be to ban this commit from the
> possible bisection results (it's just a one line change in the syzbot
> config). Then such bugs would just get gradually obsoleted by syzbot
> without any noise.

It isn't bothering me as such but it results in
CONFIG_BLK_DEV_WRITE_MOUNTED=n breaking all fs-related reproducers and thus
making it difficult to evaluate whether the reproducer was somehow
corrupting the fs image or not. Practically it means closing most
fs-related syzbot bugs and (somewhat needlessly) starting over from scratch
with search for reproducers. I'm OK with that although it is a bit
unfortunate... But I'm pretty sure within a few months syzbot will deliver
a healthy portion of new issues :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

