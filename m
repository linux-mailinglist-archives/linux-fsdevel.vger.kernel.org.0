Return-Path: <linux-fsdevel+bounces-30885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490898F0D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD1B22921
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8919CC2F;
	Thu,  3 Oct 2024 13:51:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183D186E3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963493; cv=none; b=J8S4t+Jupl2T6H0xqsPbp+XNU+SmXKXMUH+ssth6BcAbfNhronHijn8awuZPO2QmCGWC0NC8eD7NBoR1bzlJP/aB4/6zLrFq3GyvSJpoeXh0FZekt76KX9WmwiNPaWgsAs9mljDRA6NMLI02rSsbZaRpiucsJcbD0x8DswkqfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963493; c=relaxed/simple;
	bh=1ADzxu2OBA0VIRCOHkbscM+iCtwXCe9dARhDHr/xHDQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CoPqt9dkxQGBxc/nNzeWpknjDxliKikZuqQA6Z86gln3xM0APj+qutdTVjwxh+574WE/ZxlKoOmXS8AOMNgBpyx1OnkYa+0y4lFzGDFtDbRkf4KoPPanlNau5v3nL6B6eBbRfyMMrSBWdwK2TKMDY9z6RhXH+4eePBy8MdPQP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cdb4971b9so96795439f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963490; x=1728568290;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB1j0MrR34XgoaspLCqHmH56Fm6vQhBtOup8NTuwZhc=;
        b=vlicq0nDOuXF8BAiq8fY+ZtuA45aw7tjO5zqJsTVn9o+GIpKZECUVGp1R05h/3fSgn
         kjY95beoYgQU4g28QNlLNPJin7wPF9q6w7iPisUa7GFJ7grJYeblzfCWB1XaToNG8G+2
         E5SnKb7g35y8UuB1XhKs6xmUVz2ksd9ul2o9cQsTmYmIdD0NDO5kD0b4noisysVXxpyr
         QOvMVqMD8JhZuFhz+b3J6YhM+nmSZqtoJH+X4AfKwNytHFmlacnm4n3UlhB6MCjw3DvQ
         hFtgRqLNk03k2ySyiiEcHz22of3Dg7FniepIHe6alwVjQgfMf83GFNDqC2bCGbaV//Y6
         r15Q==
X-Gm-Message-State: AOJu0YxneGR5+3AYIph3fJmXRJkkpBqcrl7R+3nzzLJWMblfZdD5B3dy
	AghV4UZHOA40XNFXZqAxrdeWlgAQRxK1PJkZygSrukeJsCaL5zdfmwAjUE0B12HM896qcHK85OI
	woLCeZYCILZK7lFnEaeNZx5kjlsZ9fjgLHDKnvi9NG8wndp4FowlFAkQ=
X-Google-Smtp-Source: AGHT+IFMoW/0WzVswhR7l3puDOl3yWzQWgWZxLUB9Dy4O9Tjff8STIVqWDt9PyxWBDhfHVdCrp6OjbVmol0WOVcSdI8h/n5z8i9J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6009:b0:82c:fd13:271c with SMTP id
 ca18e2360f4ac-834d8410f96mr655381539f.4.1727963490480; Thu, 03 Oct 2024
 06:51:30 -0700 (PDT)
Date: Thu, 03 Oct 2024 06:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fea162.050a0220.9ec68.003d.GAE@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read_key (2)
From: syzbot <syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174b0ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10124b8b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11894c57980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0988c372a39/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8547f30d7e9d/bzImage-3efc5736.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7608c0ff0561/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102

CPU: 0 UID: 0 PID: 5102 Comm: syz-executor237 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:423 [inline]
 hfs_bnode_read fs/hfs/bnode.c:35 [inline]
 hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
 hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
 hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
 hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdir fs/namei.c:4300 [inline]
 __se_sys_mkdir fs/namei.c:4298 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdd6057a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2eb7e0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbdd6057a99
RDX: 00007fbdd6057a99 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 00007fbdd60cb5f0 R08: 00005555615064c0 R09: 00005555615064c0
R10: 00000000000002b3 R11: 0000000000000246 R12: 00007ffe2eb7e0e0
R13: 00007ffe2eb7e308 R14: 431bde82d7b634db R15: 00007fbdd60a003b
 </TASK>

Allocated by task 5102:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x90/0x1f0 fs/hfs/bfind.c:21
 hfs_cat_create+0x182/0xa50 fs/hfs/catalog.c:96
 hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdir fs/namei.c:4300 [inline]
 __se_sys_mkdir fs/namei.c:4298 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880123cd100
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 allocated 78-byte region [ffff8880123cd100, ffff8880123cd14e)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x123cd
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000498a00 dead000000000004
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4576, tgid 4576 (init), ts 31018946504, free_ts 31015095312
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_commit_ok+0x29/0x1d0 security/tomoyo/memory.c:76
 tomoyo_assign_domain+0x625/0x840 security/tomoyo/domain.c:576
 tomoyo_find_next_domain+0xe1c/0x1d40 security/tomoyo/domain.c:849
 tomoyo_bprm_check_security+0x114/0x180 security/tomoyo/hooks.h:76
 security_bprm_check+0x86/0x250 security/security.c:1296
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952
page last free pid 4575 tgid 4575 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1877
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880123cd000: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff8880123cd080: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff8880123cd100: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff8880123cd180: 00 00 00 00 00 00 00 00 00 00 00 06 fc fc fc fc
 ffff8880123cd200: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

