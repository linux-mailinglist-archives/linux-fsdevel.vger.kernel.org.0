Return-Path: <linux-fsdevel+bounces-16009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5EC896AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E822928D6DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE74134CF7;
	Wed,  3 Apr 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bav0/G3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xyor9/Ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25933D1;
	Wed,  3 Apr 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137643; cv=none; b=tfvGVZ3VfZENT2gN/z240OZGcLENnY4F2uDswVE8jV7ZpFHrWqjBrDgIQLytOOtHs7w6UW4jGtifsc5/hu44zTVjFk4IHN+kvYoEtbZoYXYnUz3JdVPRgf1AfrescI6Ve9p+5QivSi+mJ6HG+jVfMjccgvExIU/mOmahxkTrajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137643; c=relaxed/simple;
	bh=pDqoiqsRHJ7JGcDUca4xI9mlEuCsLk0xb1Z8A3YQEYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo7jsFAC8RceeCkJiRdNbQO61YGAYDEzMWd4GzXXtQR+n/uPG3BTneSn1/O2Qq/nBt50BH7lRZsTYr5tZ+eIWGfS6F/5XdnCIrzSI9P8/ArQjr1Zb3QFkBTamBzb3gdh17pDH/CmoYZbeh1jwcIUvBI3IgnZVwB66L3rU9Py2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bav0/G3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xyor9/Ks; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A586351BA;
	Wed,  3 Apr 2024 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712137638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8w61GgJbz5+JOMeAhM5vpil1Yf4r4g/cL3/i9cbljQ=;
	b=Bav0/G3keqXN7b5n3QeppnQnjp3vzWvcMvkSWku/QurqirJEIUsA5hvHd4oZPCMuA4NIf0
	6W/B0qxeT3KDx/OOzTJBJ3dGOX6i7OATNhaknr5KE5RLFe9rOGcW0zh4/sPScunMLhadSp
	lAX2jb19lUzZ8Wg23rI0yYwbOOMTfSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712137638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8w61GgJbz5+JOMeAhM5vpil1Yf4r4g/cL3/i9cbljQ=;
	b=xyor9/KsesQgomjzx8Wm2sqgXX+debjCtSPV6cnHG2C9BZxKn3LQuv04y2OPckUxQGeb5S
	Rn/Z56nCCqZ2HmBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E3741331E;
	Wed,  3 Apr 2024 09:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ab9BC6YlDWbwfgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 09:47:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E889CA0814; Wed,  3 Apr 2024 11:47:17 +0200 (CEST)
Date: Wed, 3 Apr 2024 11:47:17 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz,
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [nilfs?] KASAN: slab-out-of-bounds Read in wb_writeback
Message-ID: <20240403094717.zex45tc2kpkfelny@quack3>
References: <000000000000fd0f2a061506cc93@google.com>
 <00000000000003b8c406151e0fd1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000003b8c406151e0fd1@google.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,suse.cz,gmail.com,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Score: -0.31
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 3A586351BA

On Tue 02-04-24 07:38:25, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14af7dd9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729f003180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa4341180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/9760c52a227c/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
> Read of size 8 at addr ffff888020485fa8 by task kworker/u8:2/35

Looks like the writeback cleanups are causing some use-after-free issues.
The code KASAN is complaining about is:

		/*
		 * Nothing written. Wait for some inode to
		 * become available for writeback. Otherwise
		 * we'll just busyloop.
		 */
		trace_writeback_wait(wb, work);
		inode = wb_inode(wb->b_more_io.prev);
>>>>>		spin_lock(&inode->i_lock); <<<<<<
		spin_unlock(&wb->list_lock);
		/* This function drops i_lock... */
		inode_sleep_on_writeback(inode);

in wb_writeback(). Now looking at the changes indeed the commit
167d6693deb ("fs/writeback: bail out if there is no more inodes for IO and
queued once") is buggy because it will result in trying to fetch 'inode'
from empty b_more_io list and thus we'll corrupt memory. I think instead of
modifying the condition:

		if (list_empty(&wb->b_more_io)) {

we should do:

-		if (progress) {
+		if (progress || !queued) {
                        spin_unlock(&wb->list_lock);
                        continue;
                }

Kemeng?

								Honza

> CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: writeback wb_workfn (flush-7:1)
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  wb_writeback+0x66f/0xd30 fs/fs-writeback.c:2160
>  wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
>  wb_do_writeback fs/fs-writeback.c:2286 [inline]
>  wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> 
> Allocated by task 5052:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4048 [inline]
>  __kmalloc_noprof+0x200/0x410 mm/slub.c:4061
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
>  security_inode_getattr+0xd8/0x130 security/security.c:2269
>  vfs_getattr+0x45/0x430 fs/stat.c:173
>  vfs_fstat fs/stat.c:198 [inline]
>  vfs_fstatat+0xd6/0x190 fs/stat.c:300
>  __do_sys_newfstatat fs/stat.c:468 [inline]
>  __se_sys_newfstatat fs/stat.c:462 [inline]
>  __x64_sys_newfstatat+0x125/0x1b0 fs/stat.c:462
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> Freed by task 5052:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2180 [inline]
>  slab_free mm/slub.c:4363 [inline]
>  kfree+0x149/0x350 mm/slub.c:4484
>  tomoyo_realpath_from_path+0x5a9/0x5e0 security/tomoyo/realpath.c:286
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
>  security_inode_getattr+0xd8/0x130 security/security.c:2269
>  vfs_getattr+0x45/0x430 fs/stat.c:173
>  vfs_fstat fs/stat.c:198 [inline]
>  vfs_fstatat+0xd6/0x190 fs/stat.c:300
>  __do_sys_newfstatat fs/stat.c:468 [inline]
>  __se_sys_newfstatat fs/stat.c:462 [inline]
>  __x64_sys_newfstatat+0x125/0x1b0 fs/stat.c:462
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> The buggy address belongs to the object at ffff888020484000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 4008 bytes to the right of
>  allocated 4096-byte region [ffff888020484000, ffff888020485000)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20480
> head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff80000000040(head|node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffefff(slab)
> raw: 00fff80000000040 ffff888015042140 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
> head: 00fff80000000040 ffff888015042140 dead000000000100 dead000000000122
> head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
> head: 00fff80000000003 ffffea0000812001 ffffea0000812048 00000000ffffffff
> head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid -957297381 (swapper/0), ts 1, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1490
>  prep_new_page mm/page_alloc.c:1498 [inline]
>  get_page_from_freelist+0x2e7e/0x2f40 mm/page_alloc.c:3454
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
>  __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2249
>  allocate_slab+0x5a/0x2e0 mm/slub.c:2412
>  new_slab mm/slub.c:2465 [inline]
>  ___slab_alloc+0xea8/0x1430 mm/slub.c:3599
>  __slab_alloc+0x58/0xa0 mm/slub.c:3684
>  __slab_alloc_node mm/slub.c:3737 [inline]
>  slab_alloc_node mm/slub.c:3915 [inline]
>  kmalloc_node_trace_noprof+0x20c/0x300 mm/slub.c:4087
>  kmalloc_node_noprof include/linux/slab.h:677 [inline]
>  bdi_alloc+0x4f/0x140 mm/backing-dev.c:894
>  __alloc_disk_node+0xb8/0x590 block/genhd.c:1347
>  __blk_mq_alloc_disk+0x17d/0x260 block/blk-mq.c:4166
>  loop_add+0x448/0xba0 drivers/block/loop.c:2032
>  loop_init+0x17a/0x230 drivers/block/loop.c:2275
>  do_one_initcall+0x248/0x880 init/main.c:1258
>  do_initcall_level+0x157/0x210 init/main.c:1320
>  do_initcalls+0x3f/0x80 init/main.c:1336
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff888020485e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888020485f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff888020485f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                   ^
>  ffff888020486000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888020486080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
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

