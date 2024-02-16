Return-Path: <linux-fsdevel+bounces-11838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46198579B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C31F24736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB011CA88;
	Fri, 16 Feb 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJ3gdO8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRAqEXl6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJ3gdO8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRAqEXl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB31B812;
	Fri, 16 Feb 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077538; cv=none; b=rtEwwqsDeswZsomUv9DrJnDAN6u7hv56KcDHEux7py8AZKwJVBGX2x0hFsbXV+skOrsXTiBv5Tkw53mMkofSjh424L/8jj0uPX5aZsEG9J4KfxYU5xfQgnVgosZyzwuY9oBskkQd3lRhLX9/GHPqCnHX2s+ZJ6wQCRFx+MxlR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077538; c=relaxed/simple;
	bh=dISV4Bpjf+vg1Qohm9s3s5/Blp3tV56jKsaOnn9rR3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haPzwssK4f6VUy4YP7DoPPDha2PGHOPpzBTfSGClDhiUSEfyaDNCpmgK0Sd4mZvttIUM9562MHcvQf+muWR3x7szmftML9xYjGrdS/tK6nNvs7Fd/Gnq5TN/B4nbc2Oe49gujlPRxzh18wB+0D+4RpV+tjVCHk1mbRoT26bd3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJ3gdO8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRAqEXl6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJ3gdO8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRAqEXl6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F03322060;
	Fri, 16 Feb 2024 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708077533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dT0rk885hi+AHcX8Qg062FXAV5FIIm3x22shuB55fZs=;
	b=XJ3gdO8xIkZI9heyAh6F89zUzNz7tJeBcnQd7R+D0ZeW3iN60i/wQyy+ZVKMUCPSjdUIF/
	umoJ+UP9IxBbWu7/2lDndpaG4Ac3+zRRq132ppoXVqTUBNtTmHjCPkcSD5YTxeJ2+UlAqo
	7zGphWOsG/fDf5hhTSv9ST9e9YyjGqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708077533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dT0rk885hi+AHcX8Qg062FXAV5FIIm3x22shuB55fZs=;
	b=eRAqEXl67zVmje1ov7/53MTKGU3LQHi2ypqyLaO3t3GlE8JDA+LDgf38lRhm4obU1vGJSf
	UuAP8kD6bANhbsDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708077533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dT0rk885hi+AHcX8Qg062FXAV5FIIm3x22shuB55fZs=;
	b=XJ3gdO8xIkZI9heyAh6F89zUzNz7tJeBcnQd7R+D0ZeW3iN60i/wQyy+ZVKMUCPSjdUIF/
	umoJ+UP9IxBbWu7/2lDndpaG4Ac3+zRRq132ppoXVqTUBNtTmHjCPkcSD5YTxeJ2+UlAqo
	7zGphWOsG/fDf5hhTSv9ST9e9YyjGqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708077533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dT0rk885hi+AHcX8Qg062FXAV5FIIm3x22shuB55fZs=;
	b=eRAqEXl67zVmje1ov7/53MTKGU3LQHi2ypqyLaO3t3GlE8JDA+LDgf38lRhm4obU1vGJSf
	UuAP8kD6bANhbsDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0471013421;
	Fri, 16 Feb 2024 09:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qYASAd0xz2VHAgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 16 Feb 2024 09:58:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1E3FA0807; Fri, 16 Feb 2024 10:58:48 +0100 (CET)
Date: Fri, 16 Feb 2024 10:58:48 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, david@fromorbit.com, fgheet255t@gmail.com,
	hdanton@sina.com, jack@suse.cz, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev, sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ntfs3?] INFO: task hung in
 __generic_file_fsync (3)
Message-ID: <20240216095848.bufsxoaarnkdlmcb@quack3>
References: <00000000000096592405e5dcaa9f@google.com>
 <0000000000005626e80611789a1b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005626e80611789a1b@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XJ3gdO8x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eRAqEXl6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLxr3to48eg89ueqwmmq68679o)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[36.96%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd];
	 TAGGED_RCPT(0.00)[ed920a72fd23eb735158];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,kernel.dk,kernel.org,fromorbit.com,gmail.com,sina.com,suse.cz,vger.kernel.org,lists.linux.dev,samsung.com,googlegroups.com,zeniv.linux.org.uk];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 0F03322060
X-Spam-Flag: NO

On Thu 15-02-24 20:59:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131679fc180000
> start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd033e080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dbfa46080000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes some sense and since there are no reproducers:
 
#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

