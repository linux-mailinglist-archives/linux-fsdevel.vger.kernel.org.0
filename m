Return-Path: <linux-fsdevel+bounces-38421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B35A0240B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B783A43AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54B1DD0FE;
	Mon,  6 Jan 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+vdqCAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXAW3Az4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPIAmOaE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpbVXru5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAF192B74;
	Mon,  6 Jan 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162124; cv=none; b=BDn1WsJDd8YP9QUXHASkEXimCUokjLhcSBaq4wZi0EPd0iGpN/7s8GSN+oJgJHNgFvfZt1jpbrR92KD5SsunmPJTzO11lQk81OvfVlvPUSE12yWQhWc2G+Qw0rOWbW7HpT9dEZCzhXUfN7Pa5vsoqn0utBplV79YOXSi/smsSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162124; c=relaxed/simple;
	bh=jGgf1IdqkcKsN2wJGqOZQpH1gpOD8qr7xUBqY7jayiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAk3mvLrA3fITHWcYhZswR/xqZjd84oFKB6V56LfQyxDlUz/yiv+ULFM5oslPH8xAKEqMpdMWOoYO1ZG3dHiK/cp22kK3VF2kzVbGND1CEwUzdrmmEmxQ5ZVoJGfJB5yf5etetexupsH9cEkicgw168M0TItEasQMSR7D1CXGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+vdqCAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXAW3Az4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPIAmOaE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpbVXru5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE60E1F383;
	Mon,  6 Jan 2025 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736162120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVsN8Naqc6VYJEeLmB8KWyvbYwaAeY5RUlsecKObwTQ=;
	b=r+vdqCAjMWJ+Bucgfz1dmZ8EO+6IcNjwtxb8FGsmmh9Nj4L9PFc0wKV+rbq0XbXcnsXvMP
	5AvR0UJBaTEs1G1PJAhdraT+x4HzV3ntPHiT8zhafetflUClnuLfOE2Im1zTREOhz4fLXw
	PQLuocDh9taYbrIk+CylDFFmqI1gFYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736162120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVsN8Naqc6VYJEeLmB8KWyvbYwaAeY5RUlsecKObwTQ=;
	b=bXAW3Az4vjoljJXpamcneSObEktmWh7hwKU/3Ef9/t4M+ojJxJhSkeIfkYV0MA0NzHoFS3
	pwp515sjBpjuryBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736162119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVsN8Naqc6VYJEeLmB8KWyvbYwaAeY5RUlsecKObwTQ=;
	b=dPIAmOaEAHTSFvGDt0DlRJQWk/DUJGoluAFYmvx3T5UHJz8aifouzvanZbPGPdaO+vcGnJ
	sjc8FXPZ8C/L5g7gEbgS5/x/F7bKiNfH4rcircNtChpWDektWAYNcWUQjJDRFJ4I9HtPw1
	ze0eyfX3IMtpj4ZF4Z4yDMPeUCyRhC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736162119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVsN8Naqc6VYJEeLmB8KWyvbYwaAeY5RUlsecKObwTQ=;
	b=IpbVXru5zcP+IHNAinICcy18x9vF84h27PcBIXTkwfRPgVl3e6nl4QgMWtI5NxmZwfkJ7j
	n32798VXPBE58PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBDFB139AB;
	Mon,  6 Jan 2025 11:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2whQMUe7e2eTCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 11:15:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68758A089C; Mon,  6 Jan 2025 12:15:15 +0100 (CET)
Date: Mon, 6 Jan 2025 12:15:15 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
Message-ID: <dlkmio7icps3j2l7iz5g7d2patw2ivssiaus7jzucbrqd4jaq5@w3rekecxeeka>
References: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[6a3aa63412255587b21b];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,google.com,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.30
X-Spam-Flag: NO

On Tue 31-12-24 05:27:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=105ba818580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e670b0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f42ac4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com
> 
> RAX: ffffffffffffffda RBX: 00007ffd163c2680 RCX: 00007f8b75a4d669
> RDX: 00007f8b75a4c8a0 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 00007ffd163c2407 R09: 00000000000000a0
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ==================================================================
> BUG: KASAN: use-after-free in instrument_write include/linux/instrumented.h:40 [inline]
> BUG: KASAN: use-after-free in ___clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:44 [inline]
> BUG: KASAN: use-after-free in __clear_open_fd fs/file.c:324 [inline]
> BUG: KASAN: use-after-free in __put_unused_fd+0xdb/0x2a0 fs/file.c:600
> Write of size 8 at addr ffff88804952aa48 by task syz-executor128/5830

Good catch. Thanks! Should be fixed now:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

