Return-Path: <linux-fsdevel+bounces-33454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A59B8E30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE13F28256B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6515B971;
	Fri,  1 Nov 2024 09:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520815A85A
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454607; cv=none; b=sYdznRrCsl8gsT1ZbtWr286MIHumCBKxhQJxMuysLaSUzX3liRH9TsgqgoI+w9uQ3DkC+g758aRKT0ax7IvBqwxFhLwgKyjnwDkcQszyGv4BshJ12PmV84iL0iI6uUfaI8FSdHVfj6ATUmgUnAwePR9An6iwIlueOq9oid5Fh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454607; c=relaxed/simple;
	bh=kcM2EbvKLIfH4dHiElGR1ZKsPgnDpTgnQNxGBsxMk3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uk6bIgd6qxd49LgmjMEWjoHt621aQYVOdM3m/pLAZWaw9ERpPqPSh1303PW2rcRi3HKCjltMWFAklSDXaL4Z27aETNCHlwRiLJ5+k4zDyi4IL2C5LX79Xv9ndBA1cXKFJZPsL+OagRQWQAk3InYsIsdn8HZbR4KFyieZcvyR8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b7974696so1005555ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2024 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454604; x=1731059404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC8dvSTy/Po5Wp92GbZjqkWtERBTQKq319ujLKIqdOo=;
        b=ccBFLhwoLMAir/snuqXw08p7IWD7Vr4gRP/zFthRf+erzRXGo4GZiA3+9OWFEQ5VtK
         BrrvqNBvJakuY6ATaRTEIhjWcFFmtASGFMc56keiLE6CDBsxbY0gOfs1gAz0YZTZg31h
         HEtInbVIB+r2N1V3FoftKfNE1cIQTwpfqy6ADkLtO9QZSZA6lDnQlch7wSpXtlI8nlJd
         V6DOvCnsE1DBwAxp5QRHv6F26f6Vhf7D0CjaSnjA4GqjoFtojeKf+N4MAM69+xv5LFWc
         9ThZeu6jPbuZbpB0vkJgWT6VxY/26SUSaqxksp5VDQlBVSXC7vba6dxe6CIAIv5wsumY
         HP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFk4vyR3SQs9t6DFvfdTJiMHM+qdyCobLfPmn3ksLU6sMi/AnIUvF5oCgSMaP73viynJAm4EamasgttspA@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZHxWWDWBkaRutiWq97fKxZzceiZfhQ5XAToiQ52OcnBqjQxT
	/DeZa/Xggs1vc9V94u8tDZejr8NLXcNuFAiyUd0DNWBtG7GNfkgOUGDh9GQrEPH8UTTzmALgqrG
	tHgmmmCeh6aWN7db5xZJ4Wn/UthR/qFJEDvEB5cBY0swn7XuZbZH3aUo=
X-Google-Smtp-Source: AGHT+IF+X1z/WQ+QhtR9uluy/UsYLAbspUDvIzCLo5OodZV42QCiM9BBuTx6hda6oOOb+FA5d3pAo2CplE0NMTaPe6nrhCB+URHf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:3a4:e99a:bd41 with SMTP id
 e9e14a558f8ab-3a6b02be160mr34366115ab.12.1730454603912; Fri, 01 Nov 2024
 02:50:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 02:50:03 -0700
In-Reply-To: <73b917c76cff44f3085c79f251d958b1ec6c793a.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724a44b.050a0220.529b6.00d8.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-use-after-free Read in xfs_inode_item_push
From: syzbot <syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in xfs_inode_item_push

==================================================================
BUG: KASAN: slab-use-after-free in xfs_inode_item_push+0x293/0x2e0 fs/xfs/xfs_inode_item.c:775
Read of size 8 at addr ffff888061c9b698 by task xfsaild/loop2/7823

CPU: 1 UID: 0 PID: 7823 Comm: xfsaild/loop2 Not tainted 6.12.0-rc5-syzkaller-00181-g6c52d4da1c74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 xfs_inode_item_push+0x293/0x2e0 fs/xfs/xfs_inode_item.c:775
 xfsaild_push_item fs/xfs/xfs_trans_ail.c:395 [inline]
 xfsaild_push fs/xfs/xfs_trans_ail.c:523 [inline]
 xfsaild+0x112a/0x2e00 fs/xfs/xfs_trans_ail.c:705
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 7799:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
 xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_create+0x8a0/0xf60 fs/xfs/xfs_inode.c:720
 xfs_generic_create+0x5d5/0xf50 fs/xfs/xfs_iops.c:213
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6015:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 xfs_inode_free_callback+0x152/0x1d0 fs/xfs/xfs_icache.c:158
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff888061c9b668
 which belongs to the cache xfs_ili of size 264
The buggy address is located 48 bytes inside of
 freed 264-byte region [ffff888061c9b668, ffff888061c9b770)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61c9b
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801d3c8dc0 ffffea00017d0300 0000000000000004
raw: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x52c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE), pid 6527, tgid 6525 (syz.4.33), ts 123832632595, free_ts 120134322172
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3033/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
 xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_create+0x8a0/0xf60 fs/xfs/xfs_inode.c:720
 xfs_generic_create+0x5d5/0xf50 fs/xfs/xfs_iops.c:213
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
page last free pid 4674 tgid 4674 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888061c9b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888061c9b600: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
>ffff888061c9b680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888061c9b700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888061c9b780: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13345340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9b3366c241ed3c7
dashboard link: https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

