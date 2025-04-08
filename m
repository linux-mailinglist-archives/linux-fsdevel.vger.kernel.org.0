Return-Path: <linux-fsdevel+bounces-45965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F6A7FE46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E6B7A1C40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B2269819;
	Tue,  8 Apr 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="frSkB1SL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvYY2X2M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="frSkB1SL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvYY2X2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC1265CC8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110664; cv=none; b=r/wUJiKwm3SAPn+NiD2YSI+eaYpT7QKWO4XgyVWP59Ehk0NpBI8UT4tPn0ej4XzBiayefI1AL63IvTiqQEKXYnKBR9urbTXYLCc+A3M/YYufxDkz9E7vp0hqObgDDBJ4d2bLtIPIUxfWf4hWJvbF7LLCOzyDBQrHkUi/d5gY3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110664; c=relaxed/simple;
	bh=neczy/yzHUVN6DMSXFkjEp6siv9+WsuIG2BuOwnUeD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeoszK5qlX/P8SBFd6i3yQXgq7UYkZ5Au7x68cxKdqT0avOYNHqXA/UgyYIlcLkZUYrf/jjm7It2O5O6IS2bOQdvAHIWBeUfWdoI2+gDBGaexyzsYeCDmpGJiKY4sj5RqzS074n0vtNzAs/F6MLpWutnAvFdUVNQGwP/He7Zkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=frSkB1SL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvYY2X2M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=frSkB1SL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvYY2X2M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC2721168;
	Tue,  8 Apr 2025 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744110661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLs1wCXCHuNQBb4Sq6+alqK/Fj9+AADgY0xu6d+kL5Q=;
	b=frSkB1SLcv54stBmxlAub333vPHSf8l64JOdrkG7RgTLukZhW32EAsu3hyiCtqVf5nHVQx
	WkOusujOUgT8rfa28g0EsnnYEYTNR+ojFhzNbaZjYCZETOYWn3Jdd9mj12AZzqOshdmMQc
	FpMcR1+t6zPtgnLhsfWSeBh8loEbrcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744110661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLs1wCXCHuNQBb4Sq6+alqK/Fj9+AADgY0xu6d+kL5Q=;
	b=nvYY2X2MNzQBl7N033bMjAL5SJ81Qne2cIZn7QTO0ntGKEG20UIA0KlmqM0UKSD8gNyuUW
	cGWKx6ZCnCAIsxAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=frSkB1SL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nvYY2X2M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744110661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLs1wCXCHuNQBb4Sq6+alqK/Fj9+AADgY0xu6d+kL5Q=;
	b=frSkB1SLcv54stBmxlAub333vPHSf8l64JOdrkG7RgTLukZhW32EAsu3hyiCtqVf5nHVQx
	WkOusujOUgT8rfa28g0EsnnYEYTNR+ojFhzNbaZjYCZETOYWn3Jdd9mj12AZzqOshdmMQc
	FpMcR1+t6zPtgnLhsfWSeBh8loEbrcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744110661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLs1wCXCHuNQBb4Sq6+alqK/Fj9+AADgY0xu6d+kL5Q=;
	b=nvYY2X2MNzQBl7N033bMjAL5SJ81Qne2cIZn7QTO0ntGKEG20UIA0KlmqM0UKSD8gNyuUW
	cGWKx6ZCnCAIsxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1380B13691;
	Tue,  8 Apr 2025 11:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2TABEUE9WdLBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 11:11:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C275BA0930; Tue,  8 Apr 2025 13:10:56 +0200 (CEST)
Date: Tue, 8 Apr 2025 13:10:56 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in file_end_write /
 posix_acl_update_mode
Message-ID: <qnlp2pkmbvrlclptj55q3yojcjwcyftjpcyyl7tjtmihv6cjcg@hxjhikad4her>
References: <67f4e5e9.050a0220.396535.055c.GAE@google.com>
 <20250408-stirn-wettkampf-1111f59d44e7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-stirn-wettkampf-1111f59d44e7@brauner>
X-Rspamd-Queue-Id: 1DC2721168
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e5bf3e2a48bfe768];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,suse.cz:dkim,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dbb3b5b8e91c5be8daad];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-04-25 12:29:23, Christian Brauner wrote:
> On Tue, Apr 08, 2025 at 02:01:29AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10c98070580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e5bf3e2a48bfe768
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dbb3b5b8e91c5be8daad
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d90ae40aa6df/disk-0af2f6be.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/616ed7a70804/vmlinux-0af2f6be.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ed2c418afc9a/bzImage-0af2f6be.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KCSAN: data-race in file_end_write / posix_acl_update_mode
> > 
> > write to 0xffff888118513aa0 of 2 bytes by task 16080 on cpu 1:
> >  posix_acl_update_mode+0x220/0x250 fs/posix_acl.c:720
> >  simple_set_acl+0x6c/0x120 fs/posix_acl.c:1022
> >  set_posix_acl fs/posix_acl.c:954 [inline]
> >  vfs_set_acl+0x581/0x720 fs/posix_acl.c:1133
> >  do_set_acl+0xab/0x130 fs/posix_acl.c:1278
> >  do_setxattr fs/xattr.c:633 [inline]
> >  filename_setxattr+0x1f1/0x2b0 fs/xattr.c:665
> >  path_setxattrat+0x28a/0x320 fs/xattr.c:713
> >  __do_sys_setxattr fs/xattr.c:747 [inline]
> >  __se_sys_setxattr fs/xattr.c:743 [inline]
> >  __x64_sys_setxattr+0x6e/0x90 fs/xattr.c:743
> >  x64_sys_call+0x28e7/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:189
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > read to 0xffff888118513aa0 of 2 bytes by task 16073 on cpu 0:
> >  file_end_write+0x1f/0x110 include/linux/fs.h:3059
> >  vfs_fallocate+0x3a5/0x3b0 fs/open.c:350
> >  ksys_fallocate fs/open.c:362 [inline]
> >  __do_sys_fallocate fs/open.c:367 [inline]
> >  __se_sys_fallocate fs/open.c:365 [inline]
> >  __x64_sys_fallocate+0x78/0xc0 fs/open.c:365
> >  x64_sys_call+0x295f/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:286
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > value changed: 0x8000 -> 0x8072
> 
> This race is benign.
> file_end_write() and similar helpers check whether this is a regular
> file or not. And the type of a file can never change. The only thing
> that can change here are the permission bits of course.
> 
> The only thing to worry about would be torn writes where somehow the
> file type is written back after the permission bits and so S_ISREG()
> could fail and the freeze protection semaphore wouldn't be released. If
> that is an actual possibility we'd need to READ_ONCE()/WRITE_ONCE() the
> hell out of this. Can this really happen with an unsigned short though?

Well, it is one of those things that "standards do not prohibit the
compiler from doing this". OTOH it would be quite insane compiler to do
this kind of thing so I'm not sure it's worth all the churn...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

