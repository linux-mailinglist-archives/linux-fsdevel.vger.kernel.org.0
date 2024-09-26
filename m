Return-Path: <linux-fsdevel+bounces-30202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E3987ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AC81F22AFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFA4188A1B;
	Thu, 26 Sep 2024 21:46:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7E4D8C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387186; cv=none; b=Gbek3r6qVK4PKq72/967/wYPHLrCX/w4ExBwfLc/doi/dv9tU2tX4wAPmddhSt3wLLMUHHFmn9jBCJtDtw6WQfw/tj2K27Za0hMa3cx6fYmJy9ht5dcj79N/yxg9iIQUhxCZgqbFN0fMne6HenspKdumZwH4h3jrlFpY1V9uDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387186; c=relaxed/simple;
	bh=muAc2f3ggDvfFdmGpZIpkJmvmZ6jlMxKr0TXVU1fA3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dllvMSjzwq+zEB8A8Onvn4dZH9aW/StOPbOLkkM5lLh6I1rRxG2fRSlY3s+dcTufYCTlgj2wS+/72mrz04sgyLt1I2P2KIi24LaCkJDyfHJzfOQYXZVtUiz3r/gIl1O31REVPN1TUKGeHmWmvEfzsunHgA0TEgmuPywRXuRJKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so15463035ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387184; x=1727991984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNgbayoTOzKBvWrjYumPyMvg/L25cqWyA8SYhwXXaDs=;
        b=lRfZU/ZoanzOlpHq1NhE2GoyJ3vmfyCS2SHLImPUwp5xw1rLXCSXXTZ9+lh8kmHYaL
         xC8ti08/qbAwqQXqnMcI4pXDkstI14MvBygd0YX1awzRdg+iuosDKr1BtGs8M6BCLFyk
         UYvBSdhH6uPHo5xQY/jauXszYehPl5Wl+QxyUSNDhCPojtyjznH2tstnlDItaPBn08iG
         /Br8Lfl+cpb9WPm+S3l0fUV+/UW19hljEKG7oElMGvC+LTH2eFVAqqG2EpoEsYxuVrAc
         +/RnYCt65/wyfsd70Ax6L9bE6+RxM3oTTZBYMs8ocN2cRmrNa/bfWkTGvREvmT/Bim0Y
         v1HA==
X-Forwarded-Encrypted: i=1; AJvYcCXgZyOK86oDILd+TtlF50g08lAFzl5mMTacfjZeiy9KY4X1Y8hoGInt7DPOttprRROaIXFiFadpu9GqvokW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3aF//xUbS1iKag8GhPySWX9DmcJV80jLaOe2/ZqKLa4Fmfmu
	tmjJAN5l7wA9us2T3G/xLORiXv4CHMeEuB+WtsN5mCtnk8RxhTPXkoWtG/A1H9KULwai4bC6zoo
	es++MSO7xsAxOgP2pBTxLMgcHW1tDHwvpFWDkqOmb2ELr4qSlwsKVUaE=
X-Google-Smtp-Source: AGHT+IFfrez6KMJIjDYgXUjVg12E6nXuskHGP9TO/HB6U+bF4bqJLYb1tnC/7E6DZ57EKzocqXlDJKZPBb3xy1Fn4Ox6BSfDLP2r
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a345169bd7mr9937715ab.10.1727387184517; Thu, 26 Sep 2024
 14:46:24 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:46:24 -0700
In-Reply-To: <0000000000002af6530615bd6932@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f5d630.050a0220.38ace9.0002.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-use-after-free Read in xfs_inode_item_push
From: syzbot <syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    11a299a7933e Merge tag 'for-6.12/block-20240925' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1378aaa9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31f49563bb05c4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f7627980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10923a80580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e97035004495/disk-11a299a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0be318a25b1d/vmlinux-11a299a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91f17271baa3/bzImage-11a299a7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/971400d21e6d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com

BUG: KASAN: slab-use-after-free in xfs_inode_item_push+0x293/0x2e0 fs/xfs/xfs_inode_item.c:775
Read of size 8 at addr ffff8880774cfa70 by task xfsaild/loop2/10928

CPU: 1 UID: 0 PID: 10928 Comm: xfsaild/loop2 Not tainted 6.11.0-syzkaller-10669-g11a299a7933e #0
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

Allocated by task 10907:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
 xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_create+0x8a0/0xf60 fs/xfs/xfs_inode.c:720
 xfs_generic_create+0x5d5/0xf50 fs/xfs/xfs_iops.c:213
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdir fs/namei.c:4300 [inline]
 __se_sys_mkdir fs/namei.c:4298 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5213:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4682
 xfs_inode_free_callback+0x152/0x1d0 fs/xfs/xfs_icache.c:158
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff8880774cfa40
 which belongs to the cache xfs_ili of size 264
The buggy address is located 48 bytes inside of
 freed 264-byte region [ffff8880774cfa40, ffff8880774cfb48)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x774cf
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff888142abe140 ffffea0001d56080 0000000000000007
raw: 0000000000000000 00000000000c000c 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x52c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE), pid 5289, tgid 5289 (syz-executor269), ts 76754520423, free_ts 21942205490
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4142
 xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
 xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_icreate+0x13a/0x1f0 fs/xfs/xfs_inode.c:593
 xfs_symlink+0xa74/0x1230 fs/xfs/xfs_symlink.c:170
 xfs_vn_symlink+0x1f5/0x740 fs/xfs/xfs_iops.c:443
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
 do_symlinkat+0x222/0x3a0 fs/namei.c:4641
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 free_contig_range+0x152/0x550 mm/page_alloc.c:6748
 destroy_args+0x8a/0x840 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880774cf900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880774cf980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880774cfa00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff8880774cfa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880774cfb00: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

