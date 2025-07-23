Return-Path: <linux-fsdevel+bounces-55890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B2B0F8D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781E27A8192
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88B21ABA3;
	Wed, 23 Jul 2025 17:18:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD52153E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291113; cv=none; b=k+M8E2o5yuLy8/emi2uhaJ8mDpEAGE0tE6GqsBQCcACdsDrHvJxQY8Zu8IOpvZS0qEHPUKbe5Wpy5md/6TdJfJNFljCFiRORXTxtmIgagNc85NB8K1vIkNEAjYOMiyEVFdfJ+hSJbG1kKjFbSIWJNRo4qOFfuEAVOcPhQW73QDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291113; c=relaxed/simple;
	bh=AZwlVqhuvRKGgNehKvqBHIKxgnviIKuL1MrgZDbxDeI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jv1On0z1rnnxoWIeJ6K/wcxyRIRAten0RP0SnC83xy70UMioR7/S7MeB12XUUTmkh+ojfxtlVWjdPugtM8wpyTqiLxKq54L1lofFPwG2sZ4Ip427NVFzArRYuDsAt4Ie9O5HEh8WzhXTGOSzz2VbtDg7iNWKA8CFhAiqhetcgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86463467dddso9007039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 10:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291111; x=1753895911;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR3LA6tAIxJqUmqUW48dljikQflU1OVX+o4ME8EXujQ=;
        b=AlULUNwFE1KcVDUEODNJSIdhYLHxvkDKReNsNJ+pS4ZQ+DmNnl6ropxg/rJOQiihaJ
         dpCrMuaUt4NDbVGvnMm4LCN224NEN7/ZqrYzJIm3Ydll98fcgtN3lJqKPZ+ZKudhISIl
         JSMwjtG/M/te7Yd8gQxAAXHYFkWgz/ZbEiv/DnxdXXtiFZOTZvqInHUD0LL1XUo4jIvA
         PudmnRhgrY8IeUZ212uS1rVsooIXtIg/jyxx97YlS+JUFEn9i7860Ol732pjlpiQlNkw
         vprfmKkrLjH576UjzKFMx996J0hVOllkwtJiC4NMH7NB6w2RN3g7Gk36kYRAC1D15lit
         nCug==
X-Forwarded-Encrypted: i=1; AJvYcCVuRTQnoeeDDng7euG4ISE1IRdvTKOEhf44waove6fqdNS/vCRaHF6JCwr6vpGyxw2VKEXHl13YSBx48e4p@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPdULnYRESHxDZRpXzRjBESY8dBjB2L03F1Ug1FWucgza9dy3
	pvaDfnJYZDo9OYEQ24DSiUYNaFg6VYV+NiEnNeVjYjrgDxxP1JM/QabsuiumfeMaGjm+2iTb5Cv
	HMCRbHV+b9GKEfqfLbYefG/taonCWMXvNrpEeSmuYAk/ko4m3SrVcZK8Fy60=
X-Google-Smtp-Source: AGHT+IGweLyovhlyqubji/Qi7uhEMJXAkGSbXJF0/ZTNBzkVMUbYo8AV/ZwpmhUd4dbiVc4KzunpoBifa5kLyKwKtUOpiVCvpy1t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d1:b0:86d:d6:5687 with SMTP id
 ca18e2360f4ac-87c64fa0e51mr814500639f.6.1753291107701; Wed, 23 Jul 2025
 10:18:27 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68811963.050a0220.248954.0005.GAE@google.com>
Subject: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ac1b82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1771ef22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f764f0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3f5f507f252/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8f9b92c57a6/bzImage-89be9a83.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f02d92e4771f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: out-of-bounds in hfs_bnode_move+0xea/0x130 fs/hfs/bnode.c:143
Read of size 18446744073709486080 at addr ffff888000994400 by task syz.0.16/5547

CPU: 0 UID: 0 PID: 5547 Comm: syz.0.16 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 hfs_bnode_move+0xea/0x130 fs/hfs/bnode.c:143
 hfs_brec_remove+0x467/0x550 fs/hfs/brec.c:222
 hfs_cat_move+0x6fb/0x960 fs/hfs/catalog.c:364
 hfs_rename+0x1dc/0x2d0 fs/hfs/dir.c:299
 vfs_rename+0xb99/0xec0 fs/namei.c:5137
 do_renameat2+0x878/0xc50 fs/namei.c:5286
 __do_sys_rename fs/namei.c:5333 [inline]
 __se_sys_rename fs/namei.c:5331 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5331
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11db18e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd56ec9fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f11db3b5fa0 RCX: 00007f11db18e9a9
RDX: 0000000000000000 RSI: 0000200000000780 RDI: 00002000000003c0
RBP: 00007f11db210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f11db3b5fa0 R14: 00007f11db3b5fa0 R15: 0000000000000002
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x35 pfn:0x994
memcg:ffff888030a98000
anon flags: 0x7ff00000020908(uptodate|active|owner_2|swapbacked|node=0|zone=0|lastcpupid=0x7ff)
raw: 007ff00000020908 0000000000000000 dead000000000122 ffff888059a96cc1
raw: 0000000000000035 0000000000000000 00000001ffffffff ffff888030a98000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5548, tgid 5548 (dhcpcd-run-hook), ts 123108746961, free_ts 121368908469
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 folio_alloc_mpol_noprof mm/mempolicy.c:2438 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2473
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:3569 [inline]
 do_wp_page+0x1231/0x5800 mm/memory.c:4030
 handle_pte_fault mm/memory.c:6085 [inline]
 __handle_mm_fault+0x1144/0x5620 mm/memory.c:6212
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6381
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5509 tgid 5509 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xc66/0x14d0 mm/page_alloc.c:2763
 folios_put_refs+0x559/0x640 mm/swap.c:992
 free_pages_and_swap_cache+0x4be/0x520 mm/swap_state.c:267
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x44c/0xb50 mm/mmap.c:1297
 __mmput+0x118/0x420 kernel/fork.c:1121
 exit_mm+0x1da/0x2c0 kernel/exit.c:581
 do_exit+0x648/0x22e0 kernel/exit.c:952
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 __do_sys_exit_group kernel/exit.c:1116 [inline]
 __se_sys_exit_group kernel/exit.c:1114 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1114
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888000994300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888000994380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888000994400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff888000994480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888000994500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

