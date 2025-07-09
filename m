Return-Path: <linux-fsdevel+bounces-54335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1963AFE29B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126E2581DB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8227511F;
	Wed,  9 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Be+jc9tF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tS8aZpEc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Be+jc9tF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tS8aZpEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2D274B48
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049816; cv=none; b=r2ZbqO/D1B289884+laSVtsN9wx0PvIP6/76vgzgt6TLcA8jsI0ZJqhMPcY5cFAkSfUSjCbwkVq6g3/wcq+7g/csVYS3gwZKBS7SFTg41heaT3lxAslrq2xsVH18EvdCCS+UCw0tghWNn2aQLTj0P/kwdbrFMffxsg5DCo3zO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049816; c=relaxed/simple;
	bh=kSih1qJ7i7xKYn9F9RDk2G/u7x1nadVnoP9/M0XEcKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soVwhGzMuxMB3lqbTU4G6vM56GAypePyqn3FN0QLoG496kpaNaHATQDi0R9YjT893DzGzYe75uU5pLFPNdz6UJEDzL43WJcE2DK39rHTbrSqtbB1jjvVr4qSmfyziHeYWpEwRIrG6zp877g3SBSEjdUmeIN+NoVmFI0ibJ2HP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Be+jc9tF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tS8aZpEc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Be+jc9tF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tS8aZpEc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B14F1F451;
	Wed,  9 Jul 2025 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752049813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtMeClq9et3DEqdyjTbORBR+uMKXpuRTSSshQUU8BE=;
	b=Be+jc9tFF949Eqs0IlZGKfYGnmZOuITNhKADSaOR1D7/e3fVkN3foBlRIW0E9X1y13Ml0p
	QWQH+KjEJ4/9I2rwpxBlpGC8MTdOdiamenqItI2Jy4AAM8tBWf2uxL9UjnMwoLphD9T2mi
	C+aRPaCKt6ahbQntXDS2GT9ihRLnPRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752049813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtMeClq9et3DEqdyjTbORBR+uMKXpuRTSSshQUU8BE=;
	b=tS8aZpEcl35FTprEbjA9f4nCiIEVM0X3VCiIVSTtOVCSjUWr9QOenH+UzAdx2EXj98+wn4
	eqKElJ/SxszzbiDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752049813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtMeClq9et3DEqdyjTbORBR+uMKXpuRTSSshQUU8BE=;
	b=Be+jc9tFF949Eqs0IlZGKfYGnmZOuITNhKADSaOR1D7/e3fVkN3foBlRIW0E9X1y13Ml0p
	QWQH+KjEJ4/9I2rwpxBlpGC8MTdOdiamenqItI2Jy4AAM8tBWf2uxL9UjnMwoLphD9T2mi
	C+aRPaCKt6ahbQntXDS2GT9ihRLnPRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752049813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtMeClq9et3DEqdyjTbORBR+uMKXpuRTSSshQUU8BE=;
	b=tS8aZpEcl35FTprEbjA9f4nCiIEVM0X3VCiIVSTtOVCSjUWr9QOenH+UzAdx2EXj98+wn4
	eqKElJ/SxszzbiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B24E13757;
	Wed,  9 Jul 2025 08:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bWubBpUobmhSeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 08:30:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C184AA099A; Wed,  9 Jul 2025 10:30:12 +0200 (CEST)
Date: Wed, 9 Jul 2025 10:30:12 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net
Subject: Re: [syzbot] [nilfs?] kernel BUG in may_open (2)
Message-ID: <xrpmf6yj32iirfaumpbal6qxph7mkmgwtra7p4hpbvzozlp4zr@2bzl4p5ejgfj>
References: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=72aa0474e3c3b9ac];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[895c23f6917da440ed0d];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk,paragon-software.com,lists.linux.dev,lists.sourceforge.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,storage.googleapis.com:url,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Hi!

On Tue 08-07-25 10:51:27, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=107e728c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=72aa0474e3c3b9ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11305582580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10952bd4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/disk-d7b8f8e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmlinux-d7b8f8e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926/bzImage-d7b8f8e2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2a7ab270a8da/mount_0.gz
> 
> The issue was bisected to:
> 
> commit af153bb63a336a7ca0d9c8ef4ca98119c5020030
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Sun Feb 9 18:55:21 2025 +0000
> 
>     vfs: catch invalid modes in may_open()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f94a8c580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14054a8c580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10054a8c580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
> Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")
> 
> VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880724735b8

FWIW the reproducer just mounts a filesystem image and opens a file there
which crashes because the inode type is invalid. Which suggests there's
insufficient validation of inode metadata (in particular the inode mode)
being loaded from the disk... There are reproducers in the syzbot dashboard
for nilfs2, ntfs3, isofs, jfs. I'll take care of isofs, added other
filesystem maintainers to CC.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

