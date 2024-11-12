Return-Path: <linux-fsdevel+bounces-34438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE09C5700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88AC1F2266F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD41CD21E;
	Tue, 12 Nov 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZPqX7Ox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5tUsExoi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNJEWHmd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+rWd44m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955C1BB6B5;
	Tue, 12 Nov 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412271; cv=none; b=cWo79Mj7VfVx9AnxYs9sAWJR6k0r9S/rrR75ENS7X0scGmR5I3SuEY97MzAVTJqrx7ddisWJ0P0L5ZXwrIH5BHbvAvQE5sl24dh4Kd3wmLvtmmPx7PDgE10hxpoElZRTbyHoZrgBI+zB99fc/aqZr9sq7cTFGN8TUFZHqhzyh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412271; c=relaxed/simple;
	bh=3rlxtWliyMuv3JDEWd08whdOgUV+I9uw9Ben19Jv3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpb4vrHSaNzFlIGT+sj9B3GHLwI3gz/Qi5FgjaqH/Pw9NPbicJ5W+xqYQowcg52Sy4Gg2n6zxYLKD7qTFv3cqLFvqcSekri3nKDPwUvFNwBbwYcLyswFK1DuXOIq6lUf9KawcsmVjTp2hSsmMmdd26lvZjUXXKpPqM7MFw++7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZPqX7Ox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5tUsExoi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNJEWHmd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+rWd44m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC46B216E1;
	Tue, 12 Nov 2024 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731412264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTLeAUmNVTFUiNmIg9/uK7qjQg7O05/THU7O/9Lt4FA=;
	b=aZPqX7OxWxjbf8rtJgXqLs2EgSZ/4H3jhoo9eSftCowid/IL0bg+CyPL18bV5TDyy48aC0
	+DEpaMn6mWIQxqumsPH0eGmFTB7BfSePOAhc2eKkBbOuwX71TUL32f088p0j1uexF3FYt9
	vbUBtCf2NlKJzBnpc/yF7v10z9PKUz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731412264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTLeAUmNVTFUiNmIg9/uK7qjQg7O05/THU7O/9Lt4FA=;
	b=5tUsExoimDB8CxdWZQIPWNSxIWUMkacZlYRkWU2CktCTknDkjCrhQ/vI4c16bvWwlivFTD
	lTi6/7ttwKwYbtAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731412263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTLeAUmNVTFUiNmIg9/uK7qjQg7O05/THU7O/9Lt4FA=;
	b=bNJEWHmd7gRD2n1R3w9mUqaWoR4kdBhqd/0vuaHTPwL47+7d6lJYpfjVNxm/WXJ5CZLhr3
	iNW1m81jCeKm+sBiE9OlaXvZGOwjfTPfvH0j/ZSCV6oIZyKyzTcqr9WHFolv1Lgq0Hspuw
	Qt1xnuUnBOmB0PUXUZKJMVTAYKDycK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731412263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTLeAUmNVTFUiNmIg9/uK7qjQg7O05/THU7O/9Lt4FA=;
	b=T+rWd44m0Is1XfEQYOy2mrXKauN9giiACRC0tOaNd8wwD0CR2fWPFbJx7KsOEHc/AiOktI
	K3eAwwqvPhmvBPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCFAB13721;
	Tue, 12 Nov 2024 11:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O/jLLSdBM2e4SwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 11:51:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E121A08D0; Tue, 12 Nov 2024 12:50:59 +0100 (CET)
Date: Tue, 12 Nov 2024 12:50:59 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+318aab2cf26bb7d40228@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, repnop@google.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in fanotify_handle_event (2)
Message-ID: <20241112115059.ecvomkalee5m4i4i@quack3>
References: <6732d7c7.050a0220.5088e.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6732d7c7.050a0220.5088e.0004.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,google.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[318aab2cf26bb7d40228];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 11-11-24 20:21:27, syzbot wrote:
> HEAD commit:    906bd684e4b1 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=177d4ea7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1168dd87980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fd4ea7980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-906bd684.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/88c5c4ba7e33/vmlinux-906bd684.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/07094e69f47b/bzImage-906bd684.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/643aa6b4830a/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+318aab2cf26bb7d40228@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 128
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_info_copy_name fs/notify/fanotify/fanotify.h:216 [inline]
> WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_alloc_name_event fs/notify/fanotify/fanotify.c:646 [inline]
> WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_alloc_event fs/notify/fanotify/fanotify.c:810 [inline]
> WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_handle_event+0x2eba/0x3c50 fs/notify/fanotify/fanotify.c:936

Interesting. So this is complaining that the dentry name is longer than
NAME_MAX and checking the code, indeed VFS supports names upto PATH_MAX,
only individual filesystems limit them further to something smaller. So I
think we need to go though fanotify and make sure we are able to
accommodate names up to PATH_MAX (which is going to be somewhat non-trivial
because the resulting name event can be longer than PAGE_SIZE but I'd just
use kvmalloc() to make things simpler - in practice such events do not
really exist because so far nobody reported the WARNING would trigger).

								Honza

> Modules linked in:
> CPU: 0 UID: 0 PID: 5308 Comm: syz-executor207 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:fanotify_info_copy_name fs/notify/fanotify/fanotify.h:216 [inline]
> RIP: 0010:fanotify_alloc_name_event fs/notify/fanotify/fanotify.c:646 [inline]
> RIP: 0010:fanotify_alloc_event fs/notify/fanotify/fanotify.c:810 [inline]
> RIP: 0010:fanotify_handle_event+0x2eba/0x3c50 fs/notify/fanotify/fanotify.c:936
> Code: f6 ff ff e8 58 a4 6e ff 90 0f 0b 90 e9 c0 f7 ff ff e8 4a a4 6e ff 90 0f 0b 90 4c 8b 6c 24 10 e9 e7 f8 ff ff e8 37 a4 6e ff 90 <0f> 0b 90 4c 8b 6c 24 10 e9 04 fb ff ff e8 24 a4 6e ff 90 0f 0b 90
> RSP: 0018:ffffc9000d0473e0 EFLAGS: 00010293
> RAX: ffffffff82263629 RBX: ffffc9000d047844 RCX: ffff888000848000
> RDX: 0000000000000000 RSI: 0000000000000ffd RDI: 00000000000000ff
> RBP: ffffc9000d0475e0 R08: ffffffff82262f60 R09: 0000000000000000
> R10: ffff888043bd8038 R11: ffffffff821d7890 R12: ffff888043bd8000
> R13: 0000000000000ffd R14: ffff888043bd8000 R15: dffffc0000000000
> FS:  0000555581eb6380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020004000 CR3: 000000003600e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  send_to_group fs/notify/fsnotify.c:394 [inline]
>  fsnotify+0x1657/0x1f60 fs/notify/fsnotify.c:607
>  __fsnotify_parent+0x4f5/0x5e0 fs/notify/fsnotify.c:264
>  fsnotify_parent include/linux/fsnotify.h:96 [inline]
>  fsnotify_file include/linux/fsnotify.h:131 [inline]
>  fsnotify_open include/linux/fsnotify.h:401 [inline]
>  vfs_open+0x28d/0x330 fs/open.c:1095
>  do_open fs/namei.c:3774 [inline]
>  path_openat+0x2c84/0x3590 fs/namei.c:3933
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_creat fs/open.c:1508 [inline]
>  __se_sys_creat fs/open.c:1502 [inline]
>  __x64_sys_creat+0x123/0x170 fs/open.c:1502
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fde2034f6b9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff3d0c3658 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 00007fff3d0c3828 RCX: 00007fde2034f6b9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020003500
> RBP: 00007fde203c3610 R08: 00007fff3d0c3828 R09: 00007fff3d0c3828
> R10: 00007fff3d0c3828 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff3d0c3818 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

