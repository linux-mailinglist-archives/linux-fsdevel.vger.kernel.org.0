Return-Path: <linux-fsdevel+bounces-68708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F845C63989
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 937053469A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39069320CCC;
	Mon, 17 Nov 2025 10:33:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063130F801
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375608; cv=none; b=tQYyPmQDFNbX78chQWMDfjMi6aluxn7BrxClKIU5Y4F0e13x7SUW1Dtrx7ZhASSQz3iseAEwqg0V3Pwaqhc4XMfKjnUGAR9jYaUiVCb5XLKy1SL5BSQkyUgIeXG73HOLPe0RuHR9l/dGw6bYNtxr7KjPROs/Qlr4iK0oJnA09RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375608; c=relaxed/simple;
	bh=gPeKj/VcopGvW2gZQI8tEj21uNi4nam3pHxcsOMxTXQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jllobQU9s0tnwRtRswc3uFzaAIomDTg0yySmEzB1HsJfYamsl1jUtoTEM6kuKJrjokiW3Hkw9Vf7bPerPcaSJ3CKV9KnHg8D+jbVQk9Zr06UB/zbspDUhtsgkrtOkYrBed4cm7gqCQuxZPbYXnhhNJZ7csEhD/yXy4ialKtq7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4330f62ef60so38256795ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 02:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375606; x=1763980406;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geOyUl5+j2wBQBzJwdT/dXbRi2B2vNPqsuG73v+4ZUc=;
        b=PhoIoAeeFeaO4OF1dgCqrQ262yZbN6DYVHdSPur+DZ3S8KcbQoQ9pUgl9c1zS8C9EY
         LILYCDPYgM/PQoYWxEQMyNeKmx8E+vDsJumv+ha4+wu36q7/eqrpZ1aWQ+aZ5U1khHwN
         HUyHpj4Enm9ZVYl8ZoqQ4KlG9+IzzN5c9cttbEtfT2XUyM+m15B0W6evkvYnec9+5UjI
         TFrC+jg1cTBNAcRHbt6Otj9QNickV+ON17V7uhUFK/dezwFJ5crJK9ttMEJ9q9pbEOu/
         2Ey8PDH2JHYfAa3R2wbjTQyVm0kCtgbsO0uiirxKx+IbVk8pPxCJQQXWZYLdTs0uqK8K
         z+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV01peV8l8Hwr5d8C5ixDMzJcMdoW55/pWj9qlGxYx+UdGFuCV4ckmKBnSQuYhFggkPiqPdaBUuKVZp80yB@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQXVNg66uRXnKTbMi+Gcg4AhEZhr5buhHe+YfrKP3YQPZx7l+
	x5d0sn4GNM0fyNvLUmWfiNRlCgs6y25Xknq+H+TjVI/lIeYzL5anEZ5soGbimdJ9zyMr0z/4W35
	1FhZ3nWczNhh6/KaOImZxw8tLXl3IyxjPVvVNxIo9efTlH+YYXiR/pyR/2Gc=
X-Google-Smtp-Source: AGHT+IHKdIUq357rH45TBKWOTBzfVseNE4HURYMw17nP26uf3Yyh0os5nR4aXk9/peiqY0UOn/BaIHhKmPGHTQB/iwulOyb9Pj4E
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2389:b0:433:330a:a572 with SMTP id
 e9e14a558f8ab-4348c8e3e5amr146999495ab.13.1763375606293; Mon, 17 Nov 2025
 02:33:26 -0800 (PST)
Date: Mon, 17 Nov 2025 02:33:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
Subject: [syzbot] [erofs?] WARNING in get_next_unlocked_entry
From: syzbot <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dan.j.williams@intel.com, 
	jack@suse.cz, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e927c520e1ba Merge tag 'loongarch-fixes-6.18-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129957cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=31b8fb02cb8a25bd5e78
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16994692580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d58d32580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e927c520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/924fb782edf1/vmlinux-e927c520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e6af189c28e/bzImage-e927c520.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a0aec9d15b8/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1740497c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5492 at fs/dax.c:224 get_next_unlocked_entry+0x329/0x340 fs/dax.c:224
Modules linked in:
CPU: 0 UID: 0 PID: 5492 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_next_unlocked_entry+0x329/0x340 fs/dax.c:224
Code: 45 1d 10 48 3b 84 24 c0 00 00 00 75 22 4c 89 e8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3e 8a f9 08 cc e8 08 59 6e ff 90 <0f> 0b 90 eb a0 e8 6d a6 f6 08 66 66 66 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ffffc90002b7e8a0 EFLAGS: 00010093
RAX: ffffffff8251ba68 RBX: 1ffff9200056fd9c RCX: ffff8880354e4900
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002b7e9b0 R08: ffffc90002b7e937 R09: 0000000000000000
R10: ffffc90002b7e900 R11: fffff5200056fd27 R12: ffffc90002b7e918
R13: ffffea00010af380 R14: ffffc90002b7e900 R15: dffffc0000000000
FS:  0000555581eb2500(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f23763138 CR3: 00000000424dd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 grab_mapping_entry+0x176/0x660 fs/dax.c:660
 dax_iomap_pte_fault fs/dax.c:1891 [inline]
 dax_iomap_fault+0x8ab/0x18d0 fs/dax.c:2080
 __do_fault+0x138/0x390 mm/memory.c:5281
 do_cow_fault mm/memory.c:5746 [inline]
 do_fault mm/memory.c:5852 [inline]
 do_pte_missing mm/memory.c:4362 [inline]
 handle_pte_fault mm/memory.c:6195 [inline]
 __handle_mm_fault+0x1719/0x5400 mm/memory.c:6336
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6505
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x165c/0x2a00 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1692 [inline]
 get_user_pages_remote+0x2f1/0xac0 mm/gup.c:2614
 uprobe_write+0x1b6/0x2160 kernel/events/uprobes.c:529
 uprobe_write_opcode+0xa8/0xf0 kernel/events/uprobes.c:493
 set_swbp+0x121/0x290 arch/x86/kernel/uprobes.c:1090
 install_breakpoint+0x451/0x5a0 kernel/events/uprobes.c:1170
 register_for_each_vma+0xabb/0xc30 kernel/events/uprobes.c:1315
 uprobe_apply+0xfb/0x270 kernel/events/uprobes.c:1459
 uprobe_perf_open kernel/trace/trace_uprobe.c:1371 [inline]
 trace_uprobe_register+0x4df/0x560 kernel/trace/trace_uprobe.c:1533
 perf_trace_event_open kernel/trace/trace_event_perf.c:184 [inline]
 perf_trace_event_init+0x19a/0x9d0 kernel/trace/trace_event_perf.c:206
 perf_uprobe_init+0x12e/0x1a0 kernel/trace/trace_event_perf.c:332
 perf_uprobe_event_init+0xe6/0x180 kernel/events/core.c:11170
 perf_try_init_event+0x17f/0x870 kernel/events/core.c:12615
 perf_init_event kernel/events/core.c:12713 [inline]
 perf_event_alloc+0x133e/0x2be0 kernel/events/core.c:12988
 __do_sys_perf_event_open kernel/events/core.c:13506 [inline]
 __se_sys_perf_event_open+0x772/0x1d70 kernel/events/core.c:13387
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe38998f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe19690378 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fe389be5fa0 RCX: 00007fe38998f6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000000c0
RBP: 00007fe389a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe389be5fa0 R14: 00007fe389be5fa0 R15: 0000000000000005
 </TASK>


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

