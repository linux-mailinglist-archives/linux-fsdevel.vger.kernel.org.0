Return-Path: <linux-fsdevel+bounces-11351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB8852DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C5A1F212ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB3022638;
	Tue, 13 Feb 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ifQFy0mG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvlxOnIn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gexvepV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJg3G2Ya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF4225DA;
	Tue, 13 Feb 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819900; cv=none; b=j1FP51GTJx7E/als543sFp3KUbj+YEAAoItUjZf6+HDrp7Mw8b79JW5SA6pSf6slCGdO11B9nUzFrb4639Nsd1IUNmso3wQoIUx5iQcO1Wgi/DsfPi/dA2V/SPvxQTaaUunOjzJpbyVJFBjXK5uaWzSbqpovZO2H1+MyUNXwKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819900; c=relaxed/simple;
	bh=s4JlE4fKNXlqIXqNM1hnjz9Eo0A9KOGZ+8DqDWCaUFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgBbnm+KamC0juIGdBYRelEs83z4H0ItWaAE/rhjGo1oOy8maqDwM3ZWSpjpFVelZbwAhHdAo2zaI3nAXtWR2WOPvvpU/V/pH2R9LACk+fK4zhEZjJr7vEE/mQjsZui2hac+gJsxro9kf/6AjdH71otMFCNXye4tQN9njwDFR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ifQFy0mG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvlxOnIn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gexvepV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJg3G2Ya; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C70F21AF9;
	Tue, 13 Feb 2024 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+EOo/LZjqjoBiGIO35YpPDhSE1PM8je1VBpRIQoP9E=;
	b=ifQFy0mGwGLrHpV/xSCP56UDnp2SneI9HOeX9fz+w7LJAdksM8IBn1kU6xPM4MAdAOjtrN
	VO087TBOe2pS2zLAsWSkmmEwBO11NsHwkQkKeK7nmNp4M9ccJ2jjlqusMqmzEOrW2pHUAX
	GpgGBuZuZQDMiVW2BBnpnUOUNduLMLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+EOo/LZjqjoBiGIO35YpPDhSE1PM8je1VBpRIQoP9E=;
	b=nvlxOnInRBsTSIDx17rdanYOnEpnFy4h8DEr33R1Y9pX4twIIBACjGVC6OI5Ls2hCU4E62
	qltp8EHFCkgKoqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+EOo/LZjqjoBiGIO35YpPDhSE1PM8je1VBpRIQoP9E=;
	b=1gexvepVjjvIz9naX2X3CupPsSxffFxprbb8lYtlW4cIMwFVM3/u05KUm6rYGRJobHvGsW
	wbczL2gpAuQt9solOqoxQWJGTwXL4VZUmEPtyRkuhB2xXiFWAAaE87VQKHUdH/UtUvJ+Wc
	IPceu4VT0hWxJWiHpF9OqUyDeXVCI90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+EOo/LZjqjoBiGIO35YpPDhSE1PM8je1VBpRIQoP9E=;
	b=wJg3G2YaOHFR8SBxvPVQMl1c0hY6n6beWhyVoCVlTh0k9Cj2tAaSqWW+We+x7D9s1quzyk
	aPxEy8Mdmrwh5rBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 221EB1329E;
	Tue, 13 Feb 2024 10:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2XxNCHdDy2UYMQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 10:24:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC187A0809; Tue, 13 Feb 2024 11:24:46 +0100 (CET)
Date: Tue, 13 Feb 2024 11:24:46 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+451384fb192454e258de@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] kernel BUG in txLock
Message-ID: <20240213102446.pctcff4txs7cikce@quack3>
References: <00000000000079c7640604eefa47@google.com>
 <0000000000009bd5560611401f9d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009bd5560611401f9d@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[56.88%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead];
	 TAGGED_RCPT(0.00)[451384fb192454e258de];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.87
X-Spam-Flag: NO

On Tue 13-02-24 01:36:06, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1588d6ec180000
> start commit:   65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
> dashboard link: https://syzkaller.appspot.com/bug?extid=451384fb192454e258de
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140b48c8680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15276fb8680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

