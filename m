Return-Path: <linux-fsdevel+bounces-79287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGaeAKVfp2lvhAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:24:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9B1F7F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF4E30AD1BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8730238F629;
	Tue,  3 Mar 2026 22:24:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984E37C906
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576670; cv=none; b=KgX7Vl8pcX0149jcS4QdQc7SQDcBT9NYzmLJF/BZxd3fzED5guoShMKviZJrhtVo9Oea0z8X9xcb42pQRhVHD9alQV6oJjbVB8LRP/q8FBx1i8bGyj2KXv2FqPmwoE+5DK81ZyHjOTr1fhH8NQzlPWDTTCW3K3GcVjCugyINk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576670; c=relaxed/simple;
	bh=3b9YKKTpJU/ElBqrzypOKAK48gjvgekPkWxQ9sgFvr8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Buu1PkX6do7rJUlDuOnJ8A8yRn3Z5wPFboe9/SGH6U/+/TB/eTSnzILuKBqCUjURnrlOG71KHyF9+nxXa/lfJZx2NgCyhEZmCU+nfEYC3AfpgYFz/yw3+6Snnt4B/ZAKvPHfRsK6EJjXFy/LYBfXLP7l9X0NBdDu25voD6GT/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c5fde4c7so121087044eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 14:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772576667; x=1773181467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PI2tNxk+72k1E8YxyG5qHe8h2mUgtqdSyz1QeAv62c=;
        b=nFtHN3QMcyGKKxZTRUSZQuD9UjJxHK+UjsN3xHrRQKBC6l0Er3RHuWFOBouWeNbnYK
         U4+arVgNuRWptu/p6wwbbmvjJps4+OEi2tVCXb7RWZSML59tlAWCdqh/XPEXbpukEbl1
         /jImPQQ6PwWa4HA29fACcnQ5mNpPH9V2mzwgvtsxaiITDquOKl1G1LKSP84jLyjqQwH+
         Vt0iPBhKE5seJ5wI05Ba8LIj3IlSMPZ8LeMTdz202F2XZGZ1iImPi9sfw/xML787xdhi
         FBV+4/qwUce05tlNQhbYSc5d267bk6PDssjeBASA+rCSMsx9q5I1wBu1f4TX7GYX23C9
         xm0A==
X-Gm-Message-State: AOJu0YztiZ4s8i0N3oTsx46y4iulA6Txchz7tXt5DS11/o/mBJ1Xrfcx
	RCO1487uK6XdFZ4UKsmRTjaP0t5WGNXCGZYxWZ+CS4TuQtwsBFMvnSlDwNpreERVegMVZUCI3tt
	6DzQj1tKRW8bHOdZ8jM7/ilVz5fNxx/e/YgCnHlDdLtKR5MNXZej39RbQ3lg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:188a:b0:679:a560:cac7 with SMTP id
 006d021491bc7-67b176e95a5mr62315eaf.7.1772576667654; Tue, 03 Mar 2026
 14:24:27 -0800 (PST)
Date: Tue, 03 Mar 2026 14:24:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a75f9b.a70a0220.b118c.0013.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: use-after-free Write in fuse_copy_do
From: syzbot <syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 57F9B1F7F30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-79287-lists,linux-fsdevel=lfdr.de,23299dfcac137a96834a];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c025f6cf4209 Add linux-next specific files for 20260303
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=135770ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318
dashboard link: https://syzkaller.appspot.com/bug?extid=23299dfcac137a96834a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1671b006580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1166bb5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2497bde352d/disk-c025f6cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36827cb45429/vmlinux-c025f6cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ebf1ed6bb73/bzImage-c025f6cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in fuse_copy_do+0x193/0x380 fs/fuse/dev.c:-1
Write of size 2 at addr ffff888070528fff by task syz.0.17/6005

CPU: 0 UID: 0 PID: 6005 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 fuse_copy_do+0x193/0x380 fs/fuse/dev.c:-1
 fuse_copy_folio+0xefc/0x1b00 fs/fuse/dev.c:1166
 fuse_notify_store fs/fuse/dev.c:1821 [inline]
 fuse_notify fs/fuse/dev.c:2109 [inline]
 fuse_dev_do_write+0x2b9d/0x4060 fs/fuse/dev.c:2205
 fuse_dev_write+0x177/0x220 fs/fuse/dev.c:2289
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe8c659c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe8c7476028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe8c6815fa0 RCX: 00007fe8c659c799
RDX: 000000000000002a RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007fe8c6632bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe8c6816038 R14: 00007fe8c6815fa0 R15: 00007ffd95eaba38
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:ffff88805c1c4f20 index:0x7 pfn:0x70528
memcg:ffff88802ce3a880
aops:empty_aops ino:1 dentry name(?):"/"
flags: 0xfff00000000005(locked|referenced|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000005 0000000000000000 dead000000000122 ffff88805c1c4f20
raw: 0000000000000007 0000000000000000 00000003ffffffff ffff88802ce3a880
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 6005, tgid 6004 (syz.0.17), ts 103948279019, free_ts 103868818778
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1892
 prep_new_page mm/page_alloc.c:1900 [inline]
 get_page_from_freelist+0x23a1/0x2440 mm/page_alloc.c:3965
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5253
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2585
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
 __filemap_get_folio_mpol+0x3fc/0xb00 mm/filemap.c:2011
 __filemap_get_folio include/linux/pagemap.h:774 [inline]
 filemap_grab_folio include/linux/pagemap.h:854 [inline]
 fuse_notify_store fs/fuse/dev.c:1813 [inline]
 fuse_notify fs/fuse/dev.c:2109 [inline]
 fuse_dev_do_write+0x298b/0x4060 fs/fuse/dev.c:2205
 fuse_dev_write+0x177/0x220 fs/fuse/dev.c:2289
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6002 tgid 6002 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1436 [inline]
 free_unref_folios+0xd71/0x1530 mm/page_alloc.c:3043
 folios_put_refs+0x9ff/0xb40 mm/swap.c:1008
 free_pages_and_swap_cache+0x2e7/0x5b0 mm/swap_state.c:401
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:424
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
 exit_mmap+0x498/0xa10 mm/mmap.c:1315
 __mmput+0x118/0x430 kernel/fork.c:1179
 exit_mm+0x18e/0x250 kernel/exit.c:581
 do_exit+0x8b9/0x2580 kernel/exit.c:962
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1116
 __do_sys_exit_group kernel/exit.c:1127 [inline]
 __se_sys_exit_group kernel/exit.c:1125 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1125
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888070528f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888070528f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888070529000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888070529080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888070529100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

