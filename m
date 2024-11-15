Return-Path: <linux-fsdevel+bounces-34895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD439CDDA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22347B2592D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E011B85D7;
	Fri, 15 Nov 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tjVse01e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jl2eHDo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tjVse01e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jl2eHDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD01B0F01;
	Fri, 15 Nov 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671001; cv=none; b=GzQBt0ouwTWCUWJGmeupc84I0H2gF9JtraDa3hJc0LXQEFO4OPHoMqV8GG16oVD2lRceFv38X1/6DfvpxAiwQ2kxUcC0JknMQkHu2WMN+v+9zNP6ESG7gp69fWUji/aaBMR3P5JiZXDs3Up3DK/fYmPePDd2crKWvqb3wVqr4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671001; c=relaxed/simple;
	bh=GcLpIyPvJbNsw+NrTKj8LwVrdJQlG+ZNe2TcjmstYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTzqNu/77rsW5/75ES465G0es8vaC5pW1jQ+hEInINkIbNl3szroEkB9EHRsZ2rAUTOFnyZleaUUWRNrBNHgKM38C2Mn89WNW1xqkbNhs0c3blaDB0OO3r/tIkCJBUFT7gtWRh82jm+dGVJ0Lv4ueYV0HtX17GIgyoZcdcaNjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tjVse01e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jl2eHDo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tjVse01e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jl2eHDo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE43D211D5;
	Fri, 15 Nov 2024 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731670994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6g60W+2gZhvsDr9fUHhz3WwNsDPK21sc48It32UHeA=;
	b=tjVse01eBLXmVrr2AOa50bY0G5E4KnuT0kUlzGAprjTX5Ayh2B0KBTsNAD8Up881IDLpIH
	KTsWf1St+KcfKPhkx92mNw5jo0oAcCarc/Iuqv2oNhF+4mzLJ7bF5uzBUgLF1tUZ1hui7i
	0ntbQIfQmoyhdAm1VTRgXCyZgimLv1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731670994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6g60W+2gZhvsDr9fUHhz3WwNsDPK21sc48It32UHeA=;
	b=2jl2eHDouD4ayn5dj7/o+6fICOU2BqOImSOaSl4zs3X2pfPAN+0XmFdYXGC1muAlYCqPmi
	0UVE7Mw7IIEoUtCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731670994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6g60W+2gZhvsDr9fUHhz3WwNsDPK21sc48It32UHeA=;
	b=tjVse01eBLXmVrr2AOa50bY0G5E4KnuT0kUlzGAprjTX5Ayh2B0KBTsNAD8Up881IDLpIH
	KTsWf1St+KcfKPhkx92mNw5jo0oAcCarc/Iuqv2oNhF+4mzLJ7bF5uzBUgLF1tUZ1hui7i
	0ntbQIfQmoyhdAm1VTRgXCyZgimLv1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731670994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6g60W+2gZhvsDr9fUHhz3WwNsDPK21sc48It32UHeA=;
	b=2jl2eHDouD4ayn5dj7/o+6fICOU2BqOImSOaSl4zs3X2pfPAN+0XmFdYXGC1muAlYCqPmi
	0UVE7Mw7IIEoUtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3082134B8;
	Fri, 15 Nov 2024 11:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vjPFJ9IzN2f5cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Nov 2024 11:43:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 668E5A0986; Fri, 15 Nov 2024 12:43:06 +0100 (CET)
Date: Fri, 15 Nov 2024 12:43:06 +0100
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: add check for symlink corrupted
Message-ID: <20241115114306.5sgqa3opc56rhu4x@quack3>
References: <67363c96.050a0220.1324f8.009e.GAE@google.com>
 <20241115094908.3783952-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115094908.3783952-1-lizhi.xu@windriver.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[73d8fc29ec7cba8286fa];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 15-11-24 17:49:08, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in pick_link. [1]
> When symlink's inode is corrupted, the value of the i_link is 2 in this case,
> it will trigger null pointer deref when accessing *res in pick_link(). 
> 
> To avoid this issue, add a check for inode mode, return -EINVAL when it's
> not symlink.
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 UID: 0 PID: 5310 Comm: syz-executor255 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:pick_link+0x51c/0xd50 fs/namei.c:1864

Hum, based on line number is:

        if (*res == '/') { <<<< HERE
                error = nd_jump_root(nd);
                if (unlikely(error))

So res would be non-zero but a small number.

> Code: c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 fc 00 e9 ff 48 8b 2b 48 85 ed 0f 84 92 00 00 00 e8 7b 36 7f ff 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 a2 05 00 00 0f b6 5d 00 bf 2f 00 00 00
> RSP: 0018:ffffc9000d147998 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff88804558dec8 RCX: ffff88801ec7a440
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000002 R08: ffffffff8215a35f R09: 1ffffffff203a13d
> R10: dffffc0000000000 R11: fffffbfff203a13e R12: 1ffff92001a28f93
> R13: ffffc9000d147af8 R14: 1ffff92001a28f5f R15: dffffc0000000000
> FS:  0000555577611380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc0a595ed8 CR3: 0000000035760000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  step_into+0xca9/0x1080 fs/namei.c:1923
>  lookup_last fs/namei.c:2556 [inline]
>  path_lookupat+0x16f/0x450 fs/namei.c:2580
>  filename_lookup+0x256/0x610 fs/namei.c:2609
>  user_path_at+0x3a/0x60 fs/namei.c:3016
>  do_mount fs/namespace.c:3844 [inline]
>  __do_sys_mount fs/namespace.c:4057 [inline]
>  __se_sys_mount+0x297/0x3c0 fs/namespace.c:4034
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4b18ad5b19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc2e486c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f4b18ad5b19
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000000
> RBP: 00007f4b18b685f0 R08: 0000000000000000 R09: 00005555776124c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc2e486c70
> R13: 00007ffc2e486e98 R14: 431bde82d7b634db R15: 00007f4b18b1e03b
>  </TASK>
> 
> Reported-and-tested-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4a4a22a08ac2..f5dbccb3aafc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1844,6 +1844,9 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
>  	if (unlikely(error))
>  		return ERR_PTR(error);
>  
> +	if (!S_ISLNK(inode->i_mode))
> +		return ERR_PTR(-EINVAL);
> +

So I don't see how we can get here without inode being a symlink.
pick_link() is called from step_into() which has among other things:

if (likely(!d_is_symlink(path.dentry)) || ...)
	do something and return

so we are checking whether the inode is a symlink before calling
pick_link(). And yes, the d_is_symlink() is using cached type in
dentry->d_flags so they could mismatch. But inode is not supposed to change
its type during its lifetime so if there is a mismatch that is the problem
that needs to be fixed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

