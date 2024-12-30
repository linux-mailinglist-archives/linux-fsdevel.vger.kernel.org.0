Return-Path: <linux-fsdevel+bounces-38279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1B9FEA7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E01883802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE219A2A2;
	Mon, 30 Dec 2024 19:55:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F232188713
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735588526; cv=none; b=fT/yhO+iymCPTS54kE/CLKpBZxac11KEYxk7tZjzjj+a3vlX7simx/vq/OJzC2fMjU8fCx1Qi0yIkJxR7PbiYe2g+2qiUDjHqQ2Sgazzk1VzGzOJj0jzI61Wx29bETC0ezKbXvJ7CIzS97GAv02378BlOH61hqEda/QHRIPntEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735588526; c=relaxed/simple;
	bh=kK01tdWMSJV+0aoQwG3vPjl5gZiEfQy4BCGS7MncYcw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=trIYy0wYtnA3+YxG38mVE58QOCQ7lqhVpzrdRV8QrY8TZevJIskHg9SMp/CHwYS2icSAP0mwWNPfGr2kSS8xgOxbB6qts2VdSWw45nvLlyJ2Z4pzZoYb0XqHDbIajNsc+DLEbz3Tje0nAX6GXcmY02ZDQM1vqIB4PXVX/zmhBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844dfe8dad5so1661604339f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 11:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735588524; x=1736193324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSDVVbPSZpUnsAZIalhUWq3X6IUTXDBjwuqjC00Jqfk=;
        b=ES4k1shzvDNxmUm5JMDZWpbwbEWBTZHvAHZilwM6JpKCTSr58lUoXQIw5ji28KEpAW
         wXZTPFqJo8WbN+bA+6vz8FHxIlQJ0F5f+H1lUdZO8lAZdcoarpdZT1mEYbZoMt6TW0PZ
         /MLr8jfedDGA93kQIKtJ21/XPBq83+PsUTZpZy+drkI9iAdQJzqZI2BFznQSrHcXBhfS
         8asvEsRacBKlTlkYbV9vAIGQLntXz+HQLmGdRxllvt5+om/CAqLGE8UyDTFXxKIJPZK2
         MsWcwUNu9Mkovf6jEbQ3/jvTa2H8CbvAgq+XUGVyzOqQM/eGEMF21w/a31QiTi1inxJq
         FpBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSbu5/dhX88ndFaA5oN2Ms+J5yd702Y8JzzRK3sSAgwpCBjakC6OH/24SB9L5iFE1qnbhR3IIdufsxW2fa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eTJTmkxCsw9fExjxgEVUjQj1YTfDdNoE+J2hvE5ynyrEMr8u
	WiEoAM+vLnxn31q4T7sqCL9G2e/5T6QRQz/RvVhtPHNB+KTuFhOGwqxkjziv8mRMlhPiwWlVXob
	bHuDPpCyPGrwsOFczzRyKJnCJMz5x2Pd36AR9VAsuONdPMRl0qhpl5CE=
X-Google-Smtp-Source: AGHT+IFAj8d5s1FQCHexXa9/rWx0cHI4egj3kUfMTPJkglnpXO7ZoSZ2+szrjZf6ICTAhfNwcdkLun+w7LAtmdM9yykKLaAHkgav
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcd:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3c2d524776fmr390222075ab.19.1735588524446; Mon, 30 Dec 2024
 11:55:24 -0800 (PST)
Date: Mon, 30 Dec 2024 11:55:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6772faac.050a0220.2f3838.04cc.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in page_cache_async_ra / page_cache_async_ra
From: syzbot <syzbot+76b1159c512497311db6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc033cf25e61 Linux 6.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1234550f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5e179f449c1ff36
dashboard link: https://syzkaller.appspot.com/bug?extid=76b1159c512497311db6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bd50a060c12/disk-fc033cf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eafcbf349907/vmlinux-fc033cf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/10046e750749/bzImage-fc033cf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76b1159c512497311db6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in page_cache_async_ra / page_cache_async_ra

read to 0xffff888104c41698 of 8 bytes by task 14613 on cpu 0:
 page_cache_async_ra+0x193/0x420 mm/readahead.c:645
 do_async_mmap_readahead mm/filemap.c:3231 [inline]
 filemap_fault+0x2d1/0xb30 mm/filemap.c:3330
 __do_fault+0xb6/0x200 mm/memory.c:4907
 do_read_fault mm/memory.c:5322 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0xe98/0x2ac0 mm/memory.c:6112
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0xf2c/0x2670 mm/gup.c:1494
 populate_vma_page_range mm/gup.c:1932 [inline]
 __mm_populate+0x25b/0x3b0 mm/gup.c:2035
 mm_populate include/linux/mm.h:3396 [inline]
 __do_sys_mlockall mm/mlock.c:769 [inline]
 __se_sys_mlockall+0x2c5/0x370 mm/mlock.c:745
 __x64_sys_mlockall+0x1f/0x30 mm/mlock.c:745
 x64_sys_call+0x2bf8/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:152
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff888104c41698 of 8 bytes by task 14560 on cpu 1:
 page_cache_async_ra+0x2b7/0x420 mm/readahead.c:667
 do_async_mmap_readahead mm/filemap.c:3231 [inline]
 filemap_fault+0x2d1/0xb30 mm/filemap.c:3330
 __do_fault+0xb6/0x200 mm/memory.c:4907
 do_read_fault mm/memory.c:5322 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0xe98/0x2ac0 mm/memory.c:6112
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0xf2c/0x2670 mm/gup.c:1494
 __get_user_pages_locked mm/gup.c:1760 [inline]
 get_dump_page+0xb8/0x1b0 mm/gup.c:2278
 dump_user_range+0xc6/0x550 fs/coredump.c:943
 elf_core_dump+0x1bdc/0x1ce0 fs/binfmt_elf.c:2129
 do_coredump+0x1898/0x1f40 fs/coredump.c:758
 get_signal+0xd4f/0x1000 kernel/signal.c:3002
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0xa7/0x120 kernel/entry/common.c:231
 irqentry_exit+0x12/0x50 kernel/entry/common.c:334
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

value changed: 0x000000000000056a -> 0x000000000000058a

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 14560 Comm: syz.1.4068 Not tainted 6.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

