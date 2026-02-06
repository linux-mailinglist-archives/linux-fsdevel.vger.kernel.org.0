Return-Path: <linux-fsdevel+bounces-76546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLfRJbmNhWmrDQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:44:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2ADFABA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4B23033AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209A5330322;
	Fri,  6 Feb 2026 06:43:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3832D837C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360204; cv=none; b=XnYW4ouxuCp5U8fsXWWFwYecfBCw8ot/mVeAuTdP7V7q/H7rUxnOCokeXiCSiRi1mrhLLHSNM+ZTSrVSKvSua5sUIf6NO7UZVpEFJr0vADgZmkwU8WZR2T69tDazodyQQOwAyrkatP+Al3NOyxKZkPPl3IejZMeMTKSATtIKJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360204; c=relaxed/simple;
	bh=+cO6t/lm9/k+28VlcTkIE9ZjzGYW1aFL5zWAsUWAWpY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jaVq44vSXnn3KCxxSZXhRCaYwxL71q7lJp0bdfT5WKRLpxd+37aWJDwCQ0/Yo1dNr5BDqdEsTAh9R4S9wF7GOzVGSvLATZ/SHKn3tUZlt7NFQeb9GhmfuUE4GVdm9zskqrxA5+yii+GgoxZhjeSCZ3HUkzDxkFPSQ9EmIEEcwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6630d58662aso8303234eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770360203; x=1770965003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1a5dRNKFJ6iLwot47+qs/BzICGmio9RFVJIwM5Coxo=;
        b=BUJPnUVBaoulVU+u5/+yqutaPY+T4AHWbKlwjlZUQW5gh3e4hvi4iudOHYRwLRDH0J
         JeX8bYivKD/vEbEh4yf66YTGf/gfn4bHaSf9+Jx+64UlkprEbOxfCaupkbtoGymCzSjf
         DJOfX/GKgXYsNU0ydnilDaW1vyCYIbbWtRQS5RBlzJ/PccMcWYixjtrpx0A2VFExtpLZ
         BOVd0uOxR+4h3S/xLKAMRQHdhtjLddbtnzHq9PsmaGwfK83NHdaTZ3WCVigZdVef420U
         w64ZFGDnZwcPLynvKO+fPGfbPDx3Xyn7XcPLjkwxtDUzNdX+kq8zcpBBWEgAFo3fLGF2
         syTA==
X-Forwarded-Encrypted: i=1; AJvYcCUtUz8rT8bkY5EMtXTn7d+eZCYHysBEacdb8/XYd8qMYqY92hs0309atnHdaVBAGD0/xrp1onIWDgY3VUpo@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzJet7swKAnCFUumC8laLAGO4jjKj8hbDztPtQjOmdzqMAcJl
	M1cfhHUuPOVeDsg8Y55BdJPcl2+M2QDhuYRbDxtVq4uTrJWoLe0FH6EOO0uVpgq2rPPcDY1XMI3
	MrUxPF7QmzVlhvv9Pve1JvNsU70LbM3udBVJB7Ha0jCeg5eYDTxX/g7M2rPk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:998:b0:65f:66c5:c6b with SMTP id
 006d021491bc7-66d099c57b9mr841928eaf.9.1770360203561; Thu, 05 Feb 2026
 22:43:23 -0800 (PST)
Date: Thu, 05 Feb 2026 22:43:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69858d8b.050a0220.3b3015.0031.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
From: syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76546-lists,linux-fsdevel=lfdr.de,51b4c65bb770155d058f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: AA2ADFABA2
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    de0674d9bc69 Merge tag 'for-6.19-rc8-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f240aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
dashboard link: https://syzkaller.appspot.com/bug?extid=51b4c65bb770155d058f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfedab2f6279/disk-de0674d9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f012a4cb8d82/vmlinux-de0674d9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/acb727c49110/bzImage-de0674d9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs

read-write to 0xffff888129151032 of 1 bytes by task 4937 on cpu 1:
 fat12_ent_put+0xc4/0x170 fs/fat/fatent.c:165
 fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:417
 fat_chain_add+0x16c/0x490 fs/fat/misc.c:136
 fat_add_cluster fs/fat/inode.c:113 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x46c/0x5e0 fs/fat/inode.c:190
 __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
 block_write_begin fs/buffer.c:2256 [inline]
 cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
 fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
 generic_perform_write+0x183/0x490 mm/filemap.c:4314
 __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
 generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5a6/0x9f0 fs/read_write.c:686
 ksys_write+0xdc/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888129151000 of 512 bytes by task 4940 on cpu 0:
 fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
 fat_alloc_clusters+0xb48/0xc50 fs/fat/fatent.c:543
 fat_add_cluster fs/fat/inode.c:108 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x258/0x5e0 fs/fat/inode.c:190
 __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
 block_write_begin fs/buffer.c:2256 [inline]
 cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
 fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
 generic_perform_write+0x183/0x490 mm/filemap.c:4314
 __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
 generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
 __kernel_write_iter+0x319/0x590 fs/read_write.c:619
 dump_emit_page fs/coredump.c:1298 [inline]
 dump_user_range+0xa7d/0xdb0 fs/coredump.c:1372
 elf_core_dump+0x21a2/0x2330 fs/binfmt_elf.c:2111
 coredump_write+0xacf/0xdf0 fs/coredump.c:1049
 do_coredump fs/coredump.c:1126 [inline]
 vfs_coredump+0x26bc/0x3120 fs/coredump.c:1200
 get_signal+0xd7b/0xf60 kernel/signal.c:3019
 arch_do_signal_or_restart+0x96/0x450 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0xf7/0x510 kernel/entry/common.c:196
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 4940 Comm: syz.3.398 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
==================================================================
syz.3.398 (4940) used greatest stack depth: 8696 bytes left


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

