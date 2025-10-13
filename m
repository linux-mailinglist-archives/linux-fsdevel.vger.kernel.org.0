Return-Path: <linux-fsdevel+bounces-64051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226CBD68A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F9C425B00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB06308F28;
	Mon, 13 Oct 2025 21:57:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668492FB0BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392650; cv=none; b=mVTPr1l758i/IWeRKmRIyWKiplPG4gWdfimhrRynb760w5+3kKKn5uZ1OpQ5bm/+mgdG/Hakbn0eJsbRzKy7EcV4lUSXLljnG7PDV0W35+/Mk3BYeL/gbj0tR99963NMKdGaEUfs+pyUB08Ve6U1zHB9EfxrYmaR4qAtrFnIduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392650; c=relaxed/simple;
	bh=IGP1KIgfWmJRY4FWjG/kg0+unpoGwWJ3NrLAJVuhLTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bl75r6YRO3P4oQa06UHkrCtDMch1T20oKAPG+mtad6XuYnMq5D67OFmlCk7MD+oi7GX76+hbnQbPOKikqldEhkQ6FRscmfLHc0ubSprj+yvKgYWdXMWHqqqSuAb8DwqqZNkUUUiwC0+z6p7SoeWqLHCY9vs7JaJSyomAzdOK+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430929af37bso19705255ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392647; x=1760997447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLUVzXIkJevDexFppNeN5cM08yF5FbbmUuPnAILOBR8=;
        b=t7gb4ywsoma7ib98AvCIpB3PMSP1XWg2M2OMDxn+ksNtKZ3llPFWXX5OSwqk3TVocY
         tpcAU8y2ad+/RvLnhE24Zq/8Y7DzppmEGHzW1znNzbmaU4Rt13TRXVnBmv2phil3cT5Y
         qq1238/qQdwIilZPdqJbY4Tq3S2x4EcD0EwNcOrHcJJLYSuMknKI2duyWbuSNDZ2mFjT
         CbV/b0xfTnXe2+ZGjN4sHXDkt4zQlBWEtvlVFtlGCW7bptpQkSJ1aCnitA3jvDtCzg8y
         3jqsuWLvjol+fqGnACK755BNOwyl/gLhICQsjZRyl1EB9O9Y3CyiT8UsPgv7eep5H8Rk
         HSfw==
X-Forwarded-Encrypted: i=1; AJvYcCV9D9ep51jrSCUckY/5UOmSFhdgEV0VkhOOjpLjbYzUeFIH/Oq1dsYtDxctAoBl+b574lrCcvIiOSByiio+@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuB+JUeT6EtmjFO7xfEtxp5WLsn+b9FTVV+lF2llx0hl7GaCj
	9KWMWcZWxPEWOYqe21oyW/SDl46jsI3nKk1jNoaqqlr5XbEh+gr148tZPEXXXw+2C1Ii7i+yOKW
	GtC0IypaESb3W2k1cHy3EWXC2B/jJ7iDjpEFF1XQUj6ih6ghxxANFeWPa274=
X-Google-Smtp-Source: AGHT+IF59TPnsB+nGQvT/Q44OYaOO+VhM1abV2evI0Gssks4gS1oW5dNMSaa3C5qXAAPULqN3PbIh5luIIU6tdbBFgEMJttnUsS0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:424:7128:a06a with SMTP id
 e9e14a558f8ab-42f87417ff1mr270934375ab.7.1760392647572; Mon, 13 Oct 2025
 14:57:27 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
Subject: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_ucs2
From: syzbot <syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com>
To: ethan.ferguson@zetier.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67029a49db6c Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6e542580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1921939e847e6e87
dashboard link: https://syzkaller.appspot.com/bug?extid=29934710e7fb9cb71f33
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aa067c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ba29e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c68ec41538d2/disk-67029a49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/948793593b2d/vmlinux-67029a49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db3f32bee746/bzImage-67029a49.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b8b089d93a49/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=130839e2580000)

The issue was bisected to:

commit d01579d590f72d2d91405b708e96f6169f24775a
Author: Ethan Ferguson <ethan.ferguson@zetier.com>
Date:   Tue Sep 30 04:49:00 2025 +0000

    exfat: Add support for FS_IOC_{GET,SET}FSLABEL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a099e2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146099e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=106099e2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Fixes: d01579d590f7 ("exfat: Add support for FS_IOC_{GET,SET}FSLABEL")

loop0: detected capacity change from 0 to 256
exfat: Deprecated parameter 'namecase'
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x5441951d, utbl_chksum : 0xe619d30d)
==================================================================
BUG: KASAN: stack-out-of-bounds in exfat_nls_to_ucs2+0x706/0x730 fs/exfat/nls.c:619
Read of size 1 at addr ffffc9000383fcc8 by task syz.0.17/5984

CPU: 1 UID: 0 PID: 5984 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 exfat_nls_to_ucs2+0x706/0x730 fs/exfat/nls.c:619
 exfat_nls_to_utf16+0xa6/0xf0 fs/exfat/nls.c:647
 exfat_ioctl_set_volume_label+0x15d/0x230 fs/exfat/file.c:524
 exfat_ioctl+0x929/0x1630 fs/exfat/file.c:554
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf7418eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd30025cd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbf743e5fa0 RCX: 00007fbf7418eec9
RDX: 00002000000001c0 RSI: 0000000041009432 RDI: 0000000000000004
RBP: 00007fbf74211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbf743e5fa0 R14: 00007fbf743e5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to stack of task syz.0.17/5984
 and is located at offset 960 in frame:
 exfat_ioctl_set_volume_label+0x0/0x230 fs/exfat/file.c:507

This frame has 3 objects:
 [32, 36) 'lossy'
 [48, 568) 'uniname'
 [704, 960) 'label'

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888078e7c000 pfn:0x78e7c
memcg:ffff88803262e802
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888078e7c000 0000000000000000 00000001ffffffff ffff88803262e802
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 5950, tgid 5950 (dhcpcd-run-hook), ts 127646754846, free_ts 127600338916
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0x131/0x390 mm/mempolicy.c:2507
 vm_area_alloc_pages mm/vmalloc.c:3647 [inline]
 __vmalloc_area_node mm/vmalloc.c:3724 [inline]
 __vmalloc_node_range_noprof+0x6f8/0x1480 mm/vmalloc.c:3897
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:3960
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct kernel/fork.c:881 [inline]
 copy_process+0x2c77/0x76a0 kernel/fork.c:2012
 kernel_clone+0xfc/0x930 kernel/fork.c:2609
 __do_sys_clone+0xce/0x120 kernel/fork.c:2750
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 12 tgid 12 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
 sysvec_call_function_single+0xa4/0xc0 arch/x86/kernel/smp.c:266
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:704

Memory state around the buggy address:
 ffffc9000383fb80: f2 f2 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00
 ffffc9000383fc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000383fc80: 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3
                                              ^
 ffffc9000383fd00: f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000383fd80: 00 00 00 00 f1 f1 f1 f1 f1 f1 00 00 00 f2 f2 f2
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

