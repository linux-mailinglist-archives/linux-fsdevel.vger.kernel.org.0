Return-Path: <linux-fsdevel+bounces-16671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF48A141C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ACE284CE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516214D293;
	Thu, 11 Apr 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07doc78H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FMFMwST2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJxrtyX3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sy1DkKZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEF14AD2E;
	Thu, 11 Apr 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837607; cv=none; b=br/8gvurGh8uhl/Ct2F4pl2A3ecGBpAR81Mc4GiNZCiRAoerjVqOtCfmc5i8y0WFyBsr2SX4BWzJzf67LgGbhK0L6O39OyCklqwm+tN0KZB8Tqk0EnCfURGHi9G/82nciLjzNTk4hWEGBZtEcrt63dnGkCZiFZoC+eVVBKwJJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837607; c=relaxed/simple;
	bh=Uo/keZaPgmoZnFzr4XmtbNX9/qmwuyRIAFaWvv/OD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fma/v18HT8Hu2E5xPxtcqJrmkxZOh32edH681VFw7RgvXdHeEKnXjw4Lr6xn+VxcWGiOWmP6/1Mg2bMcFMWpEbeOXEvqXzOuizmnZvkuvtX/QvTbWy8xN2eHNtNwbBUIZIh6JiSsRl1i9tU/cIFj19dyOmbErveo8hiEGx29EQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07doc78H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FMFMwST2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJxrtyX3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sy1DkKZY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BACA637444;
	Thu, 11 Apr 2024 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712837600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VAM8Ph4HfYwyb6rD0atMH++TCGob0pM6dlZ/MMA8TZg=;
	b=07doc78HBfvspOBkIDrYDxKwjVrT/icDEMOawOeSMPXRG98NCo+SB7N8TGIGRItlAjeUmh
	7m/6VCWR3eBCvGpBhBLsYey5z/nnVRZJ0JHQdheVd7Je+FaRcZ6LJ5Ju/lx02LZ3cL3EUG
	lL3SS0TZFcNvRu8Qf/72aObP7BLvJ98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712837600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VAM8Ph4HfYwyb6rD0atMH++TCGob0pM6dlZ/MMA8TZg=;
	b=FMFMwST2pvT+JNIGzXZx/lHVPhqtu2gz3KwyhXOqowO+Qscwyirzxt8GfU/8Xo9D4Z8qYL
	gbcjjP6InUPu/0AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wJxrtyX3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sy1DkKZY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712837599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VAM8Ph4HfYwyb6rD0atMH++TCGob0pM6dlZ/MMA8TZg=;
	b=wJxrtyX3iW4IzAdiqsi9yCadjNWvek2DkEscpxOuRmeSrohIbWe6DL/+XYfgSA4l0dZGAR
	zgduTSN1fDskEk1oSSXWcFBbXv84erDHGF194WiSl93UMeuCHarO62b/8tZx8e4g8YRxy4
	VuF0CyHmz8oSy7BOwhXm3s3qkIWyEas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712837599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VAM8Ph4HfYwyb6rD0atMH++TCGob0pM6dlZ/MMA8TZg=;
	b=sy1DkKZYQ5mSnU1Zw0PPiBihXLQ20nwpYHek1yKZrABJAxAxKnWzLSlw5E7fjAK7Zhbh95
	S+4ANIjY7ZwnRuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD397139DE;
	Thu, 11 Apr 2024 12:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LV5FKt/TF2YvFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Apr 2024 12:13:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C50AA06F8; Thu, 11 Apr 2024 14:13:19 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:13:19 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	repnop@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Message-ID: <20240411121319.adhz4ylacbv6ocuu@quack3>
References: <00000000000042c9190615cdb315@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000042c9190615cdb315@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,google.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,syzkaller.appspot.com:url,suse.com:email];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[5e3f9b2a67b45f16d4e6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BACA637444
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.51

On Thu 11-04-24 01:11:20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12be955d180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e3f9b2a67b45f16d4e6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c91175180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1621af9d180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b050f81f73ed/disk-6ebf211b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e/vmlinux-6ebf211b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/016527216c47/bzImage-6ebf211b.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/75ad050c9945/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> 
> Quota error (device loop0): do_check_range: Getting block 0 out of range 1-5
> EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/u8:4: Failed to release dquot type 1
> ==================================================================
> BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
> Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
> 
> CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-20240410-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events_unbound quota_release_workfn
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
>  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
>  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
>  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
>  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

Amir, I believe this happens on umount when the filesystem calls
fsnotify_sb_error() after calling fsnotify_sb_delete(). In theory these two
calls can even run in parallel and fsnotify() can be holding
fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so we
need to figure out some proper synchronization for that...

								Honza

> Allocated by task 5085:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  kmalloc_trace_noprof+0x19c/0x2b0 mm/slub.c:4109
>  kmalloc_noprof include/linux/slab.h:660 [inline]
>  kzalloc_noprof include/linux/slab.h:775 [inline]
>  fsnotify_attach_info_to_sb fs/notify/mark.c:600 [inline]
>  fsnotify_add_mark_list fs/notify/mark.c:692 [inline]
>  fsnotify_add_mark_locked+0x3b2/0xe60 fs/notify/mark.c:777
>  fanotify_add_new_mark fs/notify/fanotify/fanotify_user.c:1267 [inline]
>  fanotify_add_mark+0xbbd/0x1330 fs/notify/fanotify/fanotify_user.c:1334
>  do_fanotify_mark+0xbcc/0xd90 fs/notify/fanotify/fanotify_user.c:1896
>  __do_sys_fanotify_mark fs/notify/fanotify/fanotify_user.c:1919 [inline]
>  __se_sys_fanotify_mark fs/notify/fanotify/fanotify_user.c:1915 [inline]
>  __x64_sys_fanotify_mark+0xb5/0xd0 fs/notify/fanotify/fanotify_user.c:1915
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 5085:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2190 [inline]
>  slab_free mm/slub.c:4393 [inline]
>  kfree+0x149/0x350 mm/slub.c:4514
>  fsnotify_sb_delete+0x686/0x6f0 fs/notify/fsnotify.c:106
>  generic_shutdown_super+0xa5/0x2d0 fs/super.c:632
>  kill_block_super+0x44/0x90 fs/super.c:1675
>  ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7323
>  deactivate_locked_super+0xc4/0x130 fs/super.c:472
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa1b/0x27e0 kernel/exit.c:878
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>  __do_sys_exit_group kernel/exit.c:1038 [inline]
>  __se_sys_exit_group kernel/exit.c:1036 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88802f1dce80
>  which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 0 bytes inside of
>  freed 32-byte region [ffff88802f1dce80, ffff88802f1dcea0)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f1dc
> flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffefff(slab)
> raw: 00fff80000000000 ffff888015041500 ffffea000096b540 dead000000000004
> raw: 0000000000000000 0000000080400040 00000001ffffefff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid -625457465 (swapper/0), ts 1, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
>  prep_new_page mm/page_alloc.c:1476 [inline]
>  get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3438
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
>  __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2259
>  allocate_slab+0x5a/0x2e0 mm/slub.c:2422
>  new_slab mm/slub.c:2475 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
>  __slab_alloc+0x58/0xa0 mm/slub.c:3714
>  __slab_alloc_node mm/slub.c:3767 [inline]
>  slab_alloc_node mm/slub.c:3945 [inline]
>  __do_kmalloc_node mm/slub.c:4077 [inline]
>  kmalloc_node_track_caller_noprof+0x286/0x440 mm/slub.c:4098
>  kstrdup+0x3a/0x80 mm/util.c:62
>  kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
>  kobject_add_varg lib/kobject.c:368 [inline]
>  kobject_init_and_add+0xde/0x190 lib/kobject.c:457
>  sysfs_slab_add+0x7a/0x290 mm/slub.c:6877
>  slab_sysfs_init+0x66/0x170 mm/slub.c:6961
>  do_one_initcall+0x248/0x880 init/main.c:1263
>  do_initcall_level+0x157/0x210 init/main.c:1325
>  do_initcalls+0x3f/0x80 init/main.c:1341
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff88802f1dcd80: 00 00 05 fc fc fc fc fc 00 00 00 00 fc fc fc fc
>  ffff88802f1dce00: 00 00 00 06 fc fc fc fc fa fb fb fb fc fc fc fc
> >ffff88802f1dce80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>                    ^
>  ffff88802f1dcf00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>  ffff88802f1dcf80: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
> ==================================================================
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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

