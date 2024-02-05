Return-Path: <linux-fsdevel+bounces-10292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1758499E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A174E1C22B27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E81B978;
	Mon,  5 Feb 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qokjBZp3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lvPWTfyH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qokjBZp3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lvPWTfyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381F1B969;
	Mon,  5 Feb 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135337; cv=none; b=TjenV/qD3+9L0aMRZLBYUGJIy97Fq/jnFJNJWOv7LHp1GLAQK0iCcbgK9ge85fq551JM4HgSbynXfR3jZZw2sCchdOSLwwgZfLpHfmaUH2wM2ZPnI1wqW0vJjMfk2cwTJqkG/ng1vAxLySgbVSNsZoiUmsFtGvae4XWSBs1jeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135337; c=relaxed/simple;
	bh=zc0pRgZYZxJALjoYpqFAdp7FMSnYX9ikWZHhYJIwhpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZmuvEW4oTYwsggEUK43fGwNIrIX+AVIWXYWwtOhINgEOskYZypaWJjEmaOCS4g6TSAM834uUK6alyQDuiwuRIyWiCRaByZGNI8oo7EUfoutBmrbrA+UHsIM8PV5PqRRSqr3s+npzDskcZxphmegoH8Crdz/DfUmZ5FSTx3vxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qokjBZp3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lvPWTfyH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qokjBZp3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lvPWTfyH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63F201F8C0;
	Mon,  5 Feb 2024 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707135333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEO4eHB2RkgWgrfIv+zq/AuT//7QQAheycepXP2TWTg=;
	b=qokjBZp37IYl0KRBl9puo4nI/vE9Bx9agFbx9Ch6mY/6iIASNHe5Kp81k76O9chLJOXoVE
	g5DoAoKHzOTlYeOEyfcjjg406NOf9xAS7xdSvGrhFHAn6gGY3uPAOMX2ha2LO5R9pL9r8b
	hTPkow8Gu51rKxZF/SGDYhA8QiZpQ10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707135333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEO4eHB2RkgWgrfIv+zq/AuT//7QQAheycepXP2TWTg=;
	b=lvPWTfyHZmxYa51B4jbheuYBJ/dnTR5Gen2RwGvrBVLkHE15+ZNXeZHQAEGqS04A2yy9p/
	FNxzhQKszocSwmAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707135333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEO4eHB2RkgWgrfIv+zq/AuT//7QQAheycepXP2TWTg=;
	b=qokjBZp37IYl0KRBl9puo4nI/vE9Bx9agFbx9Ch6mY/6iIASNHe5Kp81k76O9chLJOXoVE
	g5DoAoKHzOTlYeOEyfcjjg406NOf9xAS7xdSvGrhFHAn6gGY3uPAOMX2ha2LO5R9pL9r8b
	hTPkow8Gu51rKxZF/SGDYhA8QiZpQ10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707135333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEO4eHB2RkgWgrfIv+zq/AuT//7QQAheycepXP2TWTg=;
	b=lvPWTfyHZmxYa51B4jbheuYBJ/dnTR5Gen2RwGvrBVLkHE15+ZNXeZHQAEGqS04A2yy9p/
	FNxzhQKszocSwmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41CB3136F5;
	Mon,  5 Feb 2024 12:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FTGD2XRwGWKTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 12:15:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1C32A0809; Mon,  5 Feb 2024 13:15:32 +0100 (CET)
Date: Mon, 5 Feb 2024 13:15:32 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, clm@fb.com, dsterba@suse.com, jack@suse.cz,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	repnop@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in bcmp (2)
Message-ID: <20240205121532.nj7yfb56jjgglkgu@quack3>
References: <000000000000b6ffa9060ee52c74@google.com>
 <0000000000003e469906108cde8d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003e469906108cde8d@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=656820e61b758b15];
	 TAGGED_RCPT(0.00)[3ce5dea5b1539ff36769];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,storage.googleapis.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,suse.cz,toxicpanda.com,vger.kernel.org,google.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sun 04-02-24 03:44:30, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10fcfdc0180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ce5dea5b1539ff36769
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139dd53fe80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12685aa8180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/25f4008bd752/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in memcmp lib/string.c:692 [inline]
> BUG: KMSAN: uninit-value in bcmp+0x186/0x1c0 lib/string.c:713
>  memcmp lib/string.c:692 [inline]
>  bcmp+0x186/0x1c0 lib/string.c:713
>  fanotify_fh_equal fs/notify/fanotify/fanotify.c:51 [inline]

So I'm not sure how this is possible. In fanotify_encode_fh() we have:

        dwords = fh_len >> 2;
        type = exportfs_encode_fid(inode, buf, &dwords);
        err = -EINVAL;
        if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
                goto out_err;

        fh->type = type;
        fh->len = fh_len;

So if the encoded file handle was different length than what we expected we
will fail the creation of the event...

Aha, the FAT filesystem is mounted in nfs=nostale_ro which means that we're
using fat_export_ops_nostale and thus fat_encode_fh_nostale for encoding
fh. And FAT_FID_SIZE_WITHOUT_PARENT is 3 (i.e. 12 bytes) but the function
initializes just the first 10 bytes of struct fat_fid. I'll send a fix for
FAT.

								Honza


>  fanotify_fid_event_equal fs/notify/fanotify/fanotify.c:72 [inline]
>  fanotify_should_merge fs/notify/fanotify/fanotify.c:168 [inline]
>  fanotify_merge+0x15f5/0x27e0 fs/notify/fanotify/fanotify.c:209
>  fsnotify_insert_event+0x1d0/0x600 fs/notify/notification.c:113
>  fanotify_handle_event+0x47f7/0x6140 fs/notify/fanotify/fanotify.c:966
>  send_to_group fs/notify/fsnotify.c:360 [inline]
>  fsnotify+0x2510/0x3530 fs/notify/fsnotify.c:570
>  fsnotify_parent include/linux/fsnotify.h:80 [inline]
>  fsnotify_file include/linux/fsnotify.h:100 [inline]
>  fsnotify_close include/linux/fsnotify.h:362 [inline]
>  __fput+0x578/0x10c0 fs/file_table.c:368
>  __fput_sync+0x74/0x90 fs/file_table.c:467
>  __do_sys_close fs/open.c:1554 [inline]
>  __se_sys_close+0x28a/0x4c0 fs/open.c:1539
>  __x64_sys_close+0x48/0x60 fs/open.c:1539
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  slab_alloc mm/slub.c:3486 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>  kmem_cache_alloc+0x579/0xa90 mm/slub.c:3502
>  fanotify_alloc_fid_event fs/notify/fanotify/fanotify.c:584 [inline]
>  fanotify_alloc_event fs/notify/fanotify/fanotify.c:817 [inline]
>  fanotify_handle_event+0x2ff6/0x6140 fs/notify/fanotify/fanotify.c:952
>  send_to_group fs/notify/fsnotify.c:360 [inline]
>  fsnotify+0x2510/0x3530 fs/notify/fsnotify.c:570
>  fsnotify_parent include/linux/fsnotify.h:80 [inline]
>  fsnotify_file include/linux/fsnotify.h:100 [inline]
>  fsnotify_close include/linux/fsnotify.h:362 [inline]
>  __fput+0x578/0x10c0 fs/file_table.c:368
>  __fput_sync+0x74/0x90 fs/file_table.c:467
>  __do_sys_close fs/open.c:1554 [inline]
>  __se_sys_close+0x28a/0x4c0 fs/open.c:1539
>  __x64_sys_close+0x48/0x60 fs/open.c:1539
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 5010 Comm: syz-executor120 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> =====================================================
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

