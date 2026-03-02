Return-Path: <linux-fsdevel+bounces-78885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDQGBp9spWlXAgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:55:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0501D6FDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DD8304F22A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56C35A3BF;
	Mon,  2 Mar 2026 10:52:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704F35A385
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448758; cv=none; b=Ef63bPBTdeUhBTcDegGEHfht6DUgn5oLCtvljvF5Lt90onTm8L3Jnm7JQOpeqyF+/Yqx3Qx81RkJsbXJQV3Z9cFPnlUjNaH4Fqj5vMITPhZOgcOUTsZtacQoKtyK5mg037dd4MokRDf2o0vXwimBBMHGJZe+a7KaZldAjWjzmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448758; c=relaxed/simple;
	bh=tuVBblHyHt7UBql7fKWC63jTpziYPSu1B92ShuH7Owc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pF4HJzio+jDBGmCfZ2REpLgPt0vbPraqxz4T38akW9pqSoMiBle2Skkk9YWIhvUAggKIg0XrwgheCb4KZ52cxRymKtTaa1899iZDGtHh379wpcKuhNdOllylAZDuDlE5RC1HcRP0+RvbvKcOlCdj32/X9Km1EmEvhA0ELsOqQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c44ae7abso102759608eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 02:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448755; x=1773053555;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugBx2lU+QTbij+bl/XEsRp1k0NEm70t1/CupFlcutAo=;
        b=f9ks9UxukNOlOtS8Zib8WCnmp8LIsUkXlspDRwsgYuQWJ6LU7oX+Z6GI1AlitOX0op
         EglWqn9ea/YYwkri/zdOHw4Vst+tB7Q1ZVBwvsBdeeazCTgrh8+Pylmo65Hbj/bVJDgW
         oeqpMlBC+6b7fSutsgMt+K+YWkaxWGz96Hn4QWzJyL0kaFTylYt7lgoDpMfXG773ikBb
         T/F8IxHtlMYQOOLb+gWwitXWEt6FaDNHu6Q83Un5PVlS5uXGhZjhnsxzfsbmj1XomHUW
         meLNvLin/oCsGWDEnjdFxnOkomGa1v5yM0cFxH5XIkEiXlZnk2NEb0FcRVkq+6i+2pDE
         Cvuw==
X-Forwarded-Encrypted: i=1; AJvYcCVAEKL+SCnaqYH+dWULz2g7KNPSfyjT8iM/xGSkioOKzYPaLBJJDuwxAWVxNS8yxEYii6PglXjtrPIiMDWw@vger.kernel.org
X-Gm-Message-State: AOJu0YyQthtE4hzkrR/uSAawQ9lbVyCzRqSl+oHg52z754pVpcW5z520
	9JBBYBHjIVErhNkHCeE+xZjFC6gqDYI8XpWnIOdvxr+Z7/ZRPTfmyQfG+wwZIG8+bKGR94tfqup
	AqjNS4MhuFl8XNK51Sgope+aCLXlIyyEMpcNkq67usOnt7WXbcomts0rl7wc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:99b:b0:679:cab0:6099 with SMTP id
 006d021491bc7-679f2331d1emr9790055eaf.31.1772448754983; Mon, 02 Mar 2026
 02:52:34 -0800 (PST)
Date: Mon, 02 Mar 2026 02:52:34 -0800
In-Reply-To: <tencent_4C5966F83C65375A97D236684A6C75237609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a56bf2.050a0220.3a55be.0074.GAE@google.com>
Subject: [syzbot ci] Re: ext4: avoid infinite loops caused by data conflicts
From: syzbot ci <syzbot+ci4ea9e91a328607dd@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78885-lists,linux-fsdevel=lfdr.de,ci4ea9e91a328607dd];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,qq.com,suse.cz,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.308];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 6B0501D6FDE
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] ext4: avoid infinite loops caused by data conflicts
https://lore.kernel.org/all/tencent_4C5966F83C65375A97D236684A6C75237609@qq.com
* [PATCH] ext4: avoid infinite loops caused by data conflicts

and found the following issues:
* KASAN: slab-out-of-bounds Write in ext4_xattr_block_set
* KASAN: slab-use-after-free Read in do_exit
* KASAN: slab-use-after-free Write in ext4_xattr_block_set
* KASAN: use-after-free Write in ext4_xattr_block_set
* WARNING in ext4_xattr_block_set

Full report is available here:
https://ci.syzbot.org/series/175d31ab-3a77-4fe8-ba80-457d1e9b7ff0

***

KASAN: slab-out-of-bounds Write in ext4_xattr_block_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      eb71ab2bf72260054677e348498ba995a057c463
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fba2a0c2-e161-4ef9-a2c8-ddca4c80da09/config
C repro:   https://ci.syzbot.org/findings/7226f006-36f9-4dc2-8e42-67ddd1662a4a/c_repro
syz repro: https://ci.syzbot.org/findings/7226f006-36f9-4dc2-8e42-67ddd1662a4a/syz_repro

loop0: lost filesystem error report for type 5 error -117
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
Write of size 1024 at addr ffff88810eafad08 by task syz.0.17/5950

CPU: 1 UID: 0 PID: 5950 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
 ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
 ext4_expand_extra_isize_ea+0x12e6/0x1eb0 fs/ext4/xattr.c:2832
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6297
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6340 [inline]
 __ext4_mark_inode_dirty+0x45c/0x730 fs/ext4/inode.c:6418
 ext4_setattr+0x166e/0x1c60 fs/ext4/inode.c:5932
 notify_change+0xc1a/0xf40 fs/attr.c:556
 do_truncate+0x1c2/0x250 fs/open.c:68
 vfs_truncate+0x4b4/0x540 fs/open.c:118
 do_sys_truncate+0xf3/0x1c0 fs/open.c:142
 __do_sys_truncate fs/open.c:154 [inline]
 __se_sys_truncate fs/open.c:152 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:152
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f608c79c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f608bdfe028 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f608ca15fa0 RCX: 00007f608c79c799
RDX: 0000000000000000 RSI: 0000000003000000 RDI: 0000200000000900
RBP: 00007f608c832bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f608ca16038 R14: 00007f608ca15fa0 R15: 00007ffe3b059518
 </TASK>

The buggy address belongs to the physical page:
page: refcount:2 mapcount:0 mapping:ffff88810783d900 index:0x8 pfn:0x10eafa
memcg:ffff8881026b9b00
aops:def_blk_aops ino:700000 dentry name(?):""
flags: 0x17ff38000004a2c(referenced|uptodate|lru|workingset|owner_2|private|node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff38000004a2c ffffea00044efa08 ffffea00043dc788 ffff88810783d900
raw: 0000000000000008 ffff8881bb9b4740 00000002ffffffff ffff8881026b9b00
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5814, tgid 5814 (udevd), ts 64590193146, free_ts 64427187441
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2585
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
 ractl_alloc_folio mm/readahead.c:189 [inline]
 page_cache_ra_unbounded+0x39b/0xa50 mm/readahead.c:277
 do_page_cache_ra mm/readahead.c:334 [inline]
 force_page_cache_ra+0x26e/0x2e0 mm/readahead.c:364
 filemap_get_pages+0x4c0/0x1f10 mm/filemap.c:2690
 filemap_read+0x447/0x1230 mm/filemap.c:2800
 blkdev_read_iter+0x30a/0x440 block/fops.c:855
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 12 tgid 12 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 __ebt_unregister_table+0x3d3/0x600 net/bridge/netfilter/ebtables.c:1174
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49f/0x940 net/core/net_namespace.c:252
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88810eafaf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810eafb000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88810eafb080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
                                     ^
 ffff88810eafb100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810eafb180: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


***

KASAN: slab-use-after-free Read in do_exit

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      eb71ab2bf72260054677e348498ba995a057c463
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fba2a0c2-e161-4ef9-a2c8-ddca4c80da09/config
syz repro: https://ci.syzbot.org/findings/30fcf15f-7140-40ad-abff-af01ef67fdf0/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in stack_not_used kernel/exit.c:800 [inline]
BUG: KASAN: slab-use-after-free in check_stack_usage kernel/exit.c:849 [inline]
BUG: KASAN: slab-use-after-free in do_exit+0x1892/0x2320 kernel/exit.c:1006
Read of size 8 at addr ffffc900039c0748 by task kworker/R-ext4-/6060

CPU: 1 UID: 0 PID: 6060 Comm: kworker/R-ext4- Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 stack_not_used kernel/exit.c:800 [inline]
 check_stack_usage kernel/exit.c:849 [inline]
 do_exit+0x1892/0x2320 kernel/exit.c:1006
 kthread_exit+0x22b/0x280 kernel/kthread.c:336
 kthread+0x3a6/0x470 kernel/kthread.c:469
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to stack of task kworker/R-ext4-/6060

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc900039c0000 allocated at copy_process+0x508/0x3cf0 kernel/fork.c:2050
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11ade0
flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 65632032727, free_ts 57080349786
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
 vm_area_alloc_pages mm/vmalloc.c:3662 [inline]
 __vmalloc_area_node mm/vmalloc.c:3876 [inline]
 __vmalloc_node_range_noprof+0x79b/0x1730 mm/vmalloc.c:4064
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:355 [inline]
 dup_task_struct+0x228/0x9a0 kernel/fork.c:924
 copy_process+0x508/0x3cf0 kernel/fork.c:2050
 kernel_clone+0x248/0x8e0 kernel/fork.c:2654
 kernel_thread+0x13f/0x1b0 kernel/fork.c:2715
 create_kthread kernel/kthread.c:490 [inline]
 kthreadd+0x4ec/0x6e0 kernel/kthread.c:848
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5859 tgid 5859 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 kcov_put kernel/kcov.c:442 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:543
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc900039c0600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900039c0680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900039c0700: 00 00 00 00 00 00 00 00 00 fb 1d 00 01 00 00 00
                                              ^
 ffffc900039c0780: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00
 ffffc900039c0800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


***

KASAN: slab-use-after-free Write in ext4_xattr_block_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      eb71ab2bf72260054677e348498ba995a057c463
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fba2a0c2-e161-4ef9-a2c8-ddca4c80da09/config
C repro:   https://ci.syzbot.org/findings/6fc160a0-280f-49cf-8793-84b846dbb3d4/c_repro
syz repro: https://ci.syzbot.org/findings/6fc160a0-280f-49cf-8793-84b846dbb3d4/syz_repro

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
==================================================================
BUG: KASAN: slab-use-after-free in ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
Write of size 1024 at addr ffff888166b09d08 by task syz.0.18/5961

CPU: 0 UID: 0 PID: 5961 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
 ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
 ext4_expand_extra_isize_ea+0x12e6/0x1eb0 fs/ext4/xattr.c:2832
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6297
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6340 [inline]
 __ext4_mark_inode_dirty+0x45c/0x730 fs/ext4/inode.c:6418
 ext4_dirty_inode+0xd0/0x110 fs/ext4/inode.c:6450
 __mark_inode_dirty+0x3a4/0x1470 fs/fs-writeback.c:2609
 generic_update_time fs/inode.c:2198 [inline]
 touch_atime+0x576/0x6b0 fs/inode.c:2273
 file_accessed include/linux/fs.h:2263 [inline]
 filemap_read+0x1053/0x1230 mm/filemap.c:2872
 __kernel_read+0x504/0x9b0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x12c3/0x17f0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x48b/0x930 security/integrity/ima/ima_api.c:295
 process_measurement+0x12cd/0x1c80 security/integrity/ima/ima_main.c:407
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:667
 security_file_post_open+0xb3/0x260 security/security.c:2652
 do_open fs/namei.c:4673 [inline]
 path_openat+0x2e4d/0x3860 fs/namei.c:4830
 do_file_open+0x23e/0x4a0 fs/namei.c:4859
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0bb039c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0baf9fe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0bb0615fa0 RCX: 00007f0bb039c799
RDX: 0000000000000042 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f0bb0432bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0bb0616038 R14: 00007f0bb0615fa0 R15: 00007fff0f6badc8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:2 mapcount:0 mapping:ffff88816785e480 index:0x8 pfn:0x166b09
memcg:ffff8881026d1b00
aops:def_blk_aops ino:700000 dentry name(?):""
flags: 0x57ff38000004a2c(referenced|uptodate|lru|workingset|owner_2|private|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff38000004a2c ffffea00069d7208 ffffea0005a8fac8 ffff88816785e480
raw: 0000000000000008 ffff888119801740 00000002ffffffff ffff8881026d1b00
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5814, tgid 5814 (udevd), ts 66017733899, free_ts 66011346759
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2585
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
 ractl_alloc_folio mm/readahead.c:189 [inline]
 page_cache_ra_unbounded+0x39b/0xa50 mm/readahead.c:277
 do_page_cache_ra mm/readahead.c:334 [inline]
 force_page_cache_ra+0x26e/0x2e0 mm/readahead.c:364
 filemap_get_pages+0x4c0/0x1f10 mm/filemap.c:2690
 filemap_read+0x447/0x1230 mm/filemap.c:2800
 blkdev_read_iter+0x30a/0x440 block/fops.c:855
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5814 tgid 5814 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 free_unref_folios+0xed5/0x16d0 mm/page_alloc.c:3040
 folios_put_refs+0x789/0x8d0 mm/swap.c:1002
 folios_put include/linux/mm.h:1876 [inline]
 folio_batch_move_lru+0x39d/0x430 mm/swap.c:179
 lru_add_drain_cpu+0xb8/0x7b0 mm/swap.c:648
 lru_add_drain+0x121/0x3e0 mm/swap.c:737
 __folio_batch_release+0x48/0x90 mm/swap.c:1059
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x52c/0x1660 mm/shmem.c:1149
 shmem_truncate_range mm/shmem.c:1277 [inline]
 shmem_evict_inode+0x240/0x9e0 mm/shmem.c:1407
 evict+0x61e/0xb10 fs/inode.c:846
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 end_renaming fs/namei.c:4096 [inline]
 filename_renameat2+0x61e/0x9c0 fs/namei.c:6146
 __do_sys_rename fs/namei.c:6188 [inline]
 __se_sys_rename+0x55/0x2c0 fs/namei.c:6184
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888166b09f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888166b09f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888166b0a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888166b0a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888166b0a100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


***

KASAN: use-after-free Write in ext4_xattr_block_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      eb71ab2bf72260054677e348498ba995a057c463
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fba2a0c2-e161-4ef9-a2c8-ddca4c80da09/config
C repro:   https://ci.syzbot.org/findings/64472648-05ba-4d64-b168-bb54f3f15702/c_repro
syz repro: https://ci.syzbot.org/findings/64472648-05ba-4d64-b168-bb54f3f15702/syz_repro

fscrypt: AES-256-CBC-CTS using implementation "cts(cbc(ecb(aes-lib)))"
fscrypt: AES-256-XTS using implementation "xts(ecb(aes-lib))"
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
Write of size 4096 at addr ffff8881ba262108 by task syz.0.17/5950

CPU: 1 UID: 0 PID: 5950 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_xattr_block_set+0x247e/0x2b00 fs/ext4/xattr.c:2163
 ext4_xattr_set_handle+0xe37/0x14d0 fs/ext4/xattr.c:2457
 ext4_xattr_set+0x255/0x340 fs/ext4/xattr.c:2559
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x163/0x360 fs/xattr.c:321
 ovl_do_setxattr fs/overlayfs/overlayfs.h:317 [inline]
 ovl_setxattr fs/overlayfs/overlayfs.h:329 [inline]
 ovl_verify_set_fh+0x136/0x200 fs/overlayfs/namei.c:556
 ovl_verify_origin_xattr+0x98/0x180 fs/overlayfs/namei.c:584
 ovl_verify_upper fs/overlayfs/overlayfs.h:757 [inline]
 ovl_get_indexdir+0x4aa/0x600 fs/overlayfs/super.c:898
 ovl_fill_super_creds fs/overlayfs/super.c:1478 [inline]
 ovl_fill_super+0x37f3/0x5e00 fs/overlayfs/super.c:1564
 vfs_get_super fs/super.c:1327 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1346
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffbced9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4392dda8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffbcf015fa0 RCX: 00007ffbced9c799
RDX: 0000200000000140 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007ffbcee32bd9 R08: 0000200000000180 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffbcf015fac R14: 00007ffbcf015fa0 R15: 00007ffbcf015fa0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:ffff888107834200 index:0xe0 pfn:0x1ba262
memcg:ffff88816c071b00
aops:def_blk_aops ino:700000 dentry name(?):""
flags: 0x57ff08000004004(referenced|private|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff08000004004 0000000000000000 dead000000000122 ffff888107834200
raw: 00000000000000e0 ffff8881bc57f658 00000003ffffffff ffff88816c071b00
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_MOVABLE|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL), pid 5950, tgid 5950 (syz.0.17), ts 65596023731, free_ts 65574666721
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2585
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
 __filemap_get_folio_mpol+0x3fc/0xb00 mm/filemap.c:2006
 __filemap_get_folio include/linux/pagemap.h:774 [inline]
 grow_dev_folio fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1113 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x1f6/0x6e0 fs/buffer.c:1458
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 ext4_xattr_block_set+0x1d9c/0x2b00 fs/ext4/xattr.c:2131
 ext4_xattr_set_handle+0xe37/0x14d0 fs/ext4/xattr.c:2457
 ext4_xattr_set+0x255/0x340 fs/ext4/xattr.c:2559
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x163/0x360 fs/xattr.c:321
 ovl_do_setxattr fs/overlayfs/overlayfs.h:317 [inline]
 ovl_setxattr fs/overlayfs/overlayfs.h:329 [inline]
 ovl_verify_set_fh+0x136/0x200 fs/overlayfs/namei.c:556
page last free pid 5959 tgid 5959 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 free_unref_folios+0xed5/0x16d0 mm/page_alloc.c:3040
 folios_put_refs+0x789/0x8d0 mm/swap.c:1002
 free_pages_and_swap_cache+0x537/0x5b0 mm/swap_state.c:426
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:398 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:405
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:530
 exit_mmap+0x498/0xa10 mm/mmap.c:1315
 __mmput+0x118/0x430 kernel/fork.c:1174
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2320 kernel/exit.c:959
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8881ba262f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881ba262f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881ba263000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8881ba263080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881ba263100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


***

WARNING in ext4_xattr_block_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      eb71ab2bf72260054677e348498ba995a057c463
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fba2a0c2-e161-4ef9-a2c8-ddca4c80da09/config
C repro:   https://ci.syzbot.org/findings/842bc2c4-3a27-4dcd-9ff1-64e538e1ea22/c_repro
syz repro: https://ci.syzbot.org/findings/842bc2c4-3a27-4dcd-9ff1-64e538e1ea22/syz_repro

EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): encrypted files will use data=ordered instead of data journaling mode
------------[ cut here ]------------
!PageLargeKmalloc(page)
WARNING: mm/slub.c:6371 at free_large_kmalloc+0xa3/0x140 mm/slub.c:6371, CPU#0: syz.0.17/5958
Modules linked in:
CPU: 0 UID: 0 PID: 5958 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:free_large_kmalloc+0xa3/0x140 mm/slub.c:6371
Code: f8 ff 74 17 25 00 00 00 ff 3d 00 00 00 f8 0f 85 a0 00 00 00 c7 43 30 ff ff ff ff 48 89 df 89 ee 5b 41 5e 5d e9 ee c7 fc ff 90 <0f> 0b 90 48 89 df 48 c7 c6 fb d9 f0 8d 5b 41 5e 5d e9 97 f2 03 ff
RSP: 0018:ffffc90005dff0e0 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea000599df00 RCX: ffff888173089d01
RDX: 0000000000000000 RSI: ffff88816677c508 RDI: ffffea000599df00
RBP: 0000000000000000 R08: ffff888108c77063 R09: 1ffff1102118ee0c
R10: dffffc0000000000 R11: ffffed102118ee0d R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88816677c508 R15: 0000000000000000
FS:  0000555583178500(0000) GS:ffff88818de63000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe5501a000 CR3: 000000017552a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ext4_xattr_block_set+0x2102/0x2b00 fs/ext4/xattr.c:2210
 ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
 ext4_expand_extra_isize_ea+0x12e6/0x1eb0 fs/ext4/xattr.c:2832
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6297
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6340 [inline]
 __ext4_mark_inode_dirty+0x45c/0x730 fs/ext4/inode.c:6418
 ext4_inline_data_truncate+0x76b/0xb40 fs/ext4/inline.c:1940
 ext4_truncate+0x3b5/0x13b0 fs/ext4/inode.c:4518
 ext4_process_orphan+0x1cb/0x300 fs/ext4/orphan.c:337
 ext4_orphan_cleanup+0xc38/0x1470 fs/ext4/orphan.c:472
 __ext4_fill_super fs/ext4/super.c:5668 [inline]
 ext4_fill_super+0x59ff/0x6320 fs/ext4/super.c:5791
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f59e879da0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe550193e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe55019470 RCX: 00007f59e879da0a
RDX: 0000200000000040 RSI: 00002000000001c0 RDI: 00007ffe55019430
RBP: 0000200000000040 R08: 00007ffe55019470 R09: 0000000000000404
R10: 0000000000000404 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffe55019430 R14: 0000000000000442 R15: 0000200000000300
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

