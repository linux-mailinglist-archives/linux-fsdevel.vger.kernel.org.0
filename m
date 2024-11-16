Return-Path: <linux-fsdevel+bounces-35026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA919D00D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 21:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C5287632
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13C199FBB;
	Sat, 16 Nov 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZeLdtAUl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2TQAEVT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qsWTde+J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+fHpy6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79581D529;
	Sat, 16 Nov 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731790526; cv=none; b=RxAvOidxHl6+E7PteHD5LeSZhq1/DHSSAnIDn6becpfTUynhJe531WmrXd2ldRY+2hZndNjF0WCYvWUUZ85XET+XPHsQ/KUVaVPlLlV17lJkbDc8+iUQIvrPVsFJBkpP0ZHPVCf3aM31fob8DQJtXapeM46FWYDIFu5A/VlNaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731790526; c=relaxed/simple;
	bh=Jdopr7u/ffXVKUrsNs22AVsCtSHYfdcL47LdotTDXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYTiTRq7tSyFMtAFK2zfYYJkD9OJJLC6fdEQsSPqwqLSilhL7gIYJHxZ4ispOz4rTXMaK+RDfqARD3di8DRE6oNZAMGnR2d2jfuQJww6d+yVYlOz20Yq53z5vRFwi8cj4RtBJqP18FbjPZ7ZV7KLdcyPUEbR+mwvNbOLvlRXhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZeLdtAUl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2TQAEVT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qsWTde+J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+fHpy6K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96BA92125E;
	Sat, 16 Nov 2024 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731790516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySTJ4mtj4g7S3YDrIIaCXKduBsiaFtGwmDzcuVPmzZ4=;
	b=ZeLdtAUlCBrHyyDNa8CY+yjCqxxdSQlvA4tAD0V0/nawUs5HFuXd8S+Gr1eaduiRWbylYG
	C5lOWmPYYWSStZg1xcpze2OEzJswpFZJiXMU+hAhiqxCFBwJnJFevNOr29WfiPscPljQwD
	5aKg4JAK04V7aMm9PGFFLI8CskEhSuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731790516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySTJ4mtj4g7S3YDrIIaCXKduBsiaFtGwmDzcuVPmzZ4=;
	b=N2TQAEVT5Z2koHQz/8dtiPsLepe22+kd5RDEOZcND0Rq/NKoN/nJpuNIiAoDoB1hhGtUgx
	eiHhGDd5MIA9b1CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qsWTde+J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i+fHpy6K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731790515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySTJ4mtj4g7S3YDrIIaCXKduBsiaFtGwmDzcuVPmzZ4=;
	b=qsWTde+JHDhT+RTzi3XhyC2jWr3xi12Lm1KthSpPnMlhB/a0p5b+2DnDRIfxmewF+lagE3
	aOPDUpIxU5E8hzZyXBhBA8Rz7M+oKO+Xnsyq5SVp0e0KricD7glxjqGoA3gQjLKmgPffl7
	ZnRF2EqOKquwHU1JWNaBJZ9BJGv4muo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731790515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySTJ4mtj4g7S3YDrIIaCXKduBsiaFtGwmDzcuVPmzZ4=;
	b=i+fHpy6K3GvloQY3HbXoYyWnOXGXjJ+CVk1VGlsvWjl3bLKAqeT8GKbjhnd+bcit86r7/e
	PSetFPGPtYdn++BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73BA6136D9;
	Sat, 16 Nov 2024 20:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pnaqG7MGOWelAgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 16 Nov 2024 20:55:15 +0000
Message-ID: <61473df2-2ea2-4dc7-94a1-5e58ee02cd78@suse.cz>
Date: Sat, 16 Nov 2024 21:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ltp-syscalls/ioctl04: sysfs: cannot create duplicate filename
 '/kernel/slab/:a-0000176'
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvVAvEBbFzhQQ_UBf+PYMojtN1O4qHKXngu33AT8HqEnA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CA+G9fYvVAvEBbFzhQQ_UBf+PYMojtN1O4qHKXngu33AT8HqEnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96BA92125E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:url,linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,tuxsuite.com:url,suse.cz:mid,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/16/24 17:50, Naresh Kamboju wrote:
> The LTP syscalls ioctl04 and sequence test cases reported failures due
> to following
> reasons in the test log on the following environments on
> sashal/linus-next.git tree.
>  - qemu-x86_64
>  - qemu-x86_64-compat
>  - testing still in progress
> 
> LTP test failed log:
> ---------------
> <4>[   70.931891] sysfs: cannot create duplicate filename
> '/kernel/slab/:a-0000176'
> ...
> <0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
> <3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
> <3>[   70.977680] EXT4-fs (loop0): mount failed
> ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)
> 
> First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
>   Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
>   Bad:  c12cd257292c0c29463aa305967e64fc31a514d8
>   (not able to fetch these ^ commit ids now)

The problem was in the slab tree not fs, sorry for the noise:
https://lore.kernel.org/all/52be272d-009b-477b-9929-564f75208168%40suse.cz

> qemu-x86_64:
>   * ltp-syscalls/fanotify14
>   * ltp-syscalls/ioctl04
>   * etc..
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ---------
> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-8XkJXJek4F/LTP_iocSaDyQw
> as tmpdir (ext2/ext3/ext4 filesystem)
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> <6>[   70.394900] loop0: detected capacity change from 0 to 614400
> tst_test.c:1158: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.1 (20-May-2024)
> tst_test.c:1860: TINFO: LTP version: 20240930
> tst_test.c:1864: TINFO: Tested kernel: 6.12.0-rc7 #1 SMP
> PREEMPT_DYNAMIC @1731766491 x86_64
> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
> ioctl04.c:29: TPASS: BLKROGET returned 0
> <6>[   70.921794] EXT4-fs (loop0): mounting ext2 file system using the
> ext4 subsystem
> ioctl04.c:42: TPASS: BLKROGET returned 1
> ioctl04.c:53: TPASS: Mounting RO device RW failed: EACCES (13)
> <4>[   70.931891] sysfs: cannot create duplicate filename
> '/kernel/slab/:a-0000176'
> <4>[   70.932354] CPU: 0 UID: 0 PID: 992 Comm: ioctl04 Not tainted 6.12.0-rc7 #1
> <4>[   70.932936] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[   70.933433] Call Trace:
> <4>[   70.933894]  <TASK>
> <4>[   70.934161]  dump_stack_lvl+0x96/0xb0
> <4>[   70.934608]  dump_stack+0x14/0x20
> <4>[   70.934909]  sysfs_warn_dup+0x5f/0x80
> <4>[   70.935215]  sysfs_create_dir_ns+0xd0/0xf0
> <4>[   70.935521]  kobject_add_internal+0xa8/0x2e0
> <4>[   70.935944]  kobject_init_and_add+0x8c/0xd0
> <4>[   70.936265]  sysfs_slab_add+0x11a/0x1f0
> <4>[   70.936446]  do_kmem_cache_create+0x433/0x500
> <4>[   70.936622]  __kmem_cache_create_args+0x19c/0x250
> <4>[   70.936827]  ext4_mb_init+0x690/0x7e0
> <4>[   70.937180]  ext4_fill_super+0x1934/0x31e0
> <4>[   70.937547]  ? sb_set_blocksize+0x21/0x70
> <4>[   70.937911]  ? __pfx_ext4_fill_super+0x10/0x10
> <4>[   70.938346]  get_tree_bdev_flags+0x13c/0x1d0
> <4>[   70.938780]  get_tree_bdev+0x14/0x20
> <4>[   70.939118]  ext4_get_tree+0x19/0x20
> <4>[   70.939354]  vfs_get_tree+0x2e/0xe0
> <4>[   70.939717]  path_mount+0x309/0xb00
> <4>[   70.940025]  ? putname+0x5e/0x80
> <4>[   70.940183]  __x64_sys_mount+0x11d/0x160
> <4>[   70.940353]  x64_sys_call+0x1719/0x20b0
> <4>[   70.940516]  do_syscall_64+0xb2/0x1d0
> <4>[   70.940711]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> <4>[   70.941202] RIP: 0033:0x7f667d9dd4ea
> <4>[   70.941527] Code: 48 8b 0d 39 39 0d 00 f7 d8 64 89 01 48 83 c8
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00
> 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 06 39 0d 00 f7 d8 64
> 89 01 48
> <4>[   70.942905] RSP: 002b:00007ffe22faecf8 EFLAGS: 00000246
> ORIG_RAX: 00000000000000a5
> <4>[   70.943283] RAX: ffffffffffffffda RBX: 00007f667d8d26c8 RCX:
> 00007f667d9dd4ea
> <4>[   70.943788] RDX: 00007ffe22fb0e59 RSI: 000055e50098e60b RDI:
> 000055e50099cca0
> <4>[   70.944248] RBP: 000055e50098e5d8 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   70.944479] R10: 0000000000000001 R11: 0000000000000246 R12:
> 00007ffe22faed0c
> <4>[   70.944704] R13: 000055e50098e60b R14: 0000000000000000 R15:
> 0000000000000000
> <4>[   70.945086]  </TASK>
> <3>[   70.946069] kobject: kobject_add_internal failed for :a-0000176
> with -EEXIST, don't try to register things with the same name in the
> same directory.
> <3>[   70.948453] SLUB: Unable to add cache ext4_groupinfo_1k to sysfs
> <4>[   70.951178] __kmem_cache_create_args(ext4_groupinfo_1k) failed
> with error -22
> <4>[   70.952636] CPU: 0 UID: 0 PID: 992 Comm: ioctl04 Not tainted 6.12.0-rc7 #1
> <4>[   70.953183] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[   70.953975] Call Trace:
> <4>[   70.954215]  <TASK>
> <4>[   70.954460]  dump_stack_lvl+0x96/0xb0
> <4>[   70.954877]  dump_stack+0x14/0x20
> <4>[   70.955079]  __kmem_cache_create_args+0x7d/0x250
> <4>[   70.955331]  ext4_mb_init+0x690/0x7e0
> <4>[   70.955698]  ext4_fill_super+0x1934/0x31e0
> <4>[   70.956271]  ? sb_set_blocksize+0x21/0x70
> <4>[   70.958236]  ? __pfx_ext4_fill_super+0x10/0x10
> <4>[   70.958570]  get_tree_bdev_flags+0x13c/0x1d0
> <4>[   70.958812]  get_tree_bdev+0x14/0x20
> <4>[   70.958990]  ext4_get_tree+0x19/0x20
> <4>[   70.959752]  vfs_get_tree+0x2e/0xe0
> <4>[   70.960137]  path_mount+0x309/0xb00
> <4>[   70.960340]  ? putname+0x5e/0x80
> <4>[   70.960560]  __x64_sys_mount+0x11d/0x160
> <4>[   70.961572]  x64_sys_call+0x1719/0x20b0
> <4>[   70.961841]  do_syscall_64+0xb2/0x1d0
> <4>[   70.962060]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> <4>[   70.963017] RIP: 0033:0x7f667d9dd4ea
> <4>[   70.963229] Code: 48 8b 0d 39 39 0d 00 f7 d8 64 89 01 48 83 c8
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00
> 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 06 39 0d 00 f7 d8 64
> 89 01 48
> <4>[   70.964889] RSP: 002b:00007ffe22faecf8 EFLAGS: 00000246
> ORIG_RAX: 00000000000000a5
> <4>[   70.965471] RAX: ffffffffffffffda RBX: 00007f667d8d26c8 RCX:
> 00007f667d9dd4ea
> <4>[   70.965693] RDX: 00007ffe22fb0e59 RSI: 000055e50098e60b RDI:
> 000055e50099cca0
> <4>[   70.965938] RBP: 000055e50098e5d8 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   70.966152] R10: 0000000000000001 R11: 0000000000000246 R12:
> 00007ffe22faed0c
> <4>[   70.966370] R13: 000055e50098e60b R14: 0000000000000000 R15:
> 0000000000000000
> <4>[   70.966593]  </TASK>
> <0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
> <3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
> <3>[   70.977680] EXT4-fs (loop0): mount failed
> ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)
> 
> Summary:
> passed   3
> failed   1
> 
> Build image:
> -----------
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15432-gac3274b9a6ec/testrun/25851045/suite/ltp-syscalls/test/ioctl04/log
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15430-gc12cd257292c/testrun/25848631/suite/ltp-syscalls/test/ioctl04/history/
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15432-gac3274b9a6ec/testrun/25851045/suite/ltp-syscalls/test/ioctl04/details/
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ow28dxrEwN5dFu4vChS2wgU93J
> 
> Steps to reproduce:
> ------------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ow28dxrEwN5dFu4vChS2wgU93J/reproducer
> 
> metadata:
> ----
>   Linux version: 6.12.0-rc7
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
>   git sha: ac3274b9a6ec132398615faaa725c8fa23700219
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2ow9ILyg8kMOGCJOc8VDIGOlz1h/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ow9ILyg8kMOGCJOc8VDIGOlz1h/
>   toolchain: gcc-13
>   config: gcc-13-lkftconfig
>   arch: x86_64 and testing is in progress for other architectures
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 


