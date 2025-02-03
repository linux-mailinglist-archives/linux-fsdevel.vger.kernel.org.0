Return-Path: <linux-fsdevel+bounces-40555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DBA25109
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A07A15D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8706FC0E;
	Mon,  3 Feb 2025 01:14:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D32EEB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738545268; cv=none; b=iTzaJJTt4gU9WOZW5LFKOyKMaOXcZhTifjKyYSHQXQfpLN86O1jVqn1J3L2oZGP8ZAjXQFAU6dH04/lBugyTHJ3RblSxmdmJtV3FBti1qDZFopRMIyerj1sk5udzmXlgC7AEvdXIU39MYwRhqO1VpvCfghFGDgIwtgZqv/rB4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738545268; c=relaxed/simple;
	bh=7C6aZiOjkJMNbWW86XPFHFzkm5BO3AM9qJCo7hC1kF8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=towt+Uy0Zc6NmebXQxo2WqITIOK1YeCIRCZqRRHEeenVDklVDC6/yrCJ5r6ZxTu5wPKR9OGAK2bivAdMJdrg7ii3XZV9y3XPe68t6umFksRDrHB6tuI5q1HovdtwcY9YyGFKX9YHD75f9bL3q0kCKwlc+uL/vY6D6MLaDzPAL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-84730592e44so259140239f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 17:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738545266; x=1739150066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3U/vo0rAmOJFD7fReCHJuGGTPXG4g3RIEc673RAyRs=;
        b=UlE5egyenrr6DoAlJZju3LXDgfKvHgSIn/mB/eggS9fsPAe4A7s/FnhBdFogCpPS+l
         EQP/UV7S7kdU/Lug9MbhLqlxQEqDgHDuogDShcckd7oU6doB06YiGYEBEYF4oymnd1Pe
         VFbi17NCrAEf60rGwj79UkntVfMqyJi+fXJNsEYTQQBrTUy+Omb/vK4tN+waTiLXUwVV
         fv1Jr6v8fVAkd00aCCiDJgbMla3+Y1CCSXTFJO2i8ZpRIEw9VTQIve1WaEewG4VFBA0s
         k/TmvBnCTSRoP3ftGjOMdxnXW7E2iiR9LlNrtK9i7teYwCytEdiKzMk7/P4yueqljOBY
         Djug==
X-Forwarded-Encrypted: i=1; AJvYcCV7F+SLaXfltxx6xYN6TYXVyFbdo+2phESaEwh8Cu979UFVmfpJa7rIWRWOrVnm2y5b0071J1Kt7A2Q+pNL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54LH1cNtrTuufy7F5AKKBoPfOxItAMKnUiAFidH/WGw1btqIf
	GAZ9g4oduS4kSUzvi/evLIqhdF+zpgDWSZLTVgJL1Z4m+LhJlK72lk0fPZ5ANs5ArGnJkK8Ih2c
	GE0pF3JzSV2QKjwk1bPuOI/m5cEdgRCmqttji5giGpsfk3vSLt8S1k28=
X-Google-Smtp-Source: AGHT+IHf4wRVucgy2K1rID2uMUXSz432zb8Dm1TszfL2Dyu7/iRKgxbm6N7YeYcfQk71c+gt/JbRit8DJMi5EZH8gUGEPuAeNs42
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3cffe3f6221mr149843195ab.13.1738545265901; Sun, 02 Feb 2025
 17:14:25 -0800 (PST)
Date: Sun, 02 Feb 2025 17:14:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a01871.050a0220.d7c5a.007b.GAE@google.com>
Subject: [syzbot] [fs?] KMSAN: uninit-value in full_proxy_poll
From: syzbot <syzbot+a84ce0b8e1f3da037bf7@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4b0881156fb Merge tag 'docs-6.14-2' of git://git.lwn.net/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146c5ddf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d0bb5e08cf54aa2
dashboard link: https://syzkaller.appspot.com/bug?extid=a84ce0b8e1f3da037bf7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cb8518580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122a0b24580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4dbe3cd3dcb8/disk-b4b08811.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/592d90859f86/vmlinux-b4b08811.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cfde2b63c7f/bzImage-b4b08811.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a84ce0b8e1f3da037bf7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in full_proxy_poll+0xdf/0x3b0 fs/debugfs/file.c:411
 full_proxy_poll+0xdf/0x3b0 fs/debugfs/file.c:411
 vfs_poll include/linux/poll.h:82 [inline]
 ep_item_poll fs/eventpoll.c:1060 [inline]
 ep_insert+0x19c7/0x2740 fs/eventpoll.c:1736
 do_epoll_ctl+0xd83/0x17f0 fs/eventpoll.c:2394
 __do_sys_epoll_ctl fs/eventpoll.c:2445 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2436 [inline]
 __x64_sys_epoll_ctl+0x1b5/0x210 fs/eventpoll.c:2436
 x64_sys_call+0x1658/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:234
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __debugfs_file_get+0xe86/0xef0 fs/debugfs/file.c:122
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __debugfs_file_get+0xe59/0xef0 fs/debugfs/file.c:120
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __debugfs_file_get+0xdff/0xef0 fs/debugfs/file.c:118
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 __debugfs_file_get+0x31d/0xef0 fs/debugfs/file.c:101
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5778 Comm: syz-executor303 Not tainted 6.13.0-syzkaller-09585-gb4b0881156fb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


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

