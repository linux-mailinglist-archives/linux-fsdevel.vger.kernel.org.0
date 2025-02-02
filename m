Return-Path: <linux-fsdevel+bounces-40546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E4A24E39
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CC97A2B6E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4C1D88AD;
	Sun,  2 Feb 2025 13:28:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C352746D
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738502905; cv=none; b=MhMRJff+TxJpWoxIdtlxfahUhNSHHDIp1yUFaNHMCf4vSFRTwW2ujME9nSasJK5MHn5Q06DtL1sG4hmTB8iPl0Zz7EXg0aL/9RqWWAEeqOQJYm/swzYozkutvOcL+nQLG3mnd8LNmJ7Mb8Oaol9TRjqEBJMcJLbWIIfAHTh+Ebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738502905; c=relaxed/simple;
	bh=kn5l0gneVe0zZ4DXhnKMCH24+iWF9D+5+910z3Zc9k0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ROjKNBeoo5P3z/MDSlAcVLwjYoX7KR1tEe/Or/p/GZZzo4hzP1cp+eyXhqGr7+yHGWav0iK0Sx52g5DogjQ59V5IlGI9GMSvM7mYUxzr2EhpZGXkz7CZIbcdgg6+psjgtVqtCjw/nUWGtLEQxQHhR2b4pgK2l+/3NbME/1Jk1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3cf6c83560fso22793025ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 05:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738502903; x=1739107703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xl0sMhaXbmbPfjz2HyGqC5RKbLWo5pn7Jnp6FlIBrXo=;
        b=wBYo6YMKpeY9vXzKJ+gu5QABvvCq9od+KuiQq2iAXNeSI39DqAIIfL++4+BRuOj8nV
         4ecvR8zdd4Keex/+5Sh3T6j+EYVvDCp1f4LA5U+SWq7BfcucU7VHHbI2Z6Zk1HO+etJq
         FBhj9ADOGvgUzA/6aIdhaNpdUwn2vLqMpC53twWkK03bjuONhC1p2QGHzVuSNoRYLzuG
         8weUmfUruEfRI6/LsQdneO1H1DjbIQVPVmdwiccYhzZP7J60CvKwMlkhgrMyR4VPcoVW
         F0gTgpbK3jVeyTSjsaA0/wlHg5AWBlqv4/1Pv2LUP7RZP4EJXVTo/7XvFbK1R3ZpfZuj
         phMA==
X-Forwarded-Encrypted: i=1; AJvYcCVEnJdDGaMN7S/p4rNxpmf3QzXazB5QNouN+ELUzYtOgZV5BwHFL7fc2wZM6bCuiB+Wu7Xq+CeSc0DK3gct@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKGXtzGVTTxqM6mdxi4t2p7xyQHMuMc9XghnPetobNexfRa53
	3Eg0nAAfPBJiyGmKtC8pehx9xwc0rank7bh0aIYOn9gUh73i0uF8bMvfX1YaHNTFNLA9aNyBD16
	EksCTDxdEQsSAzlG4PvuJEyswnr5DwC8YJTER1gI7yDcJFNzWLoJiqqA=
X-Google-Smtp-Source: AGHT+IGKHUofiWZx7kOlo+t+3SRSBumGMhohFTD+bwMXwlcEURTikGPPzATSuFsgfUIUfHQhj9VVZZ2woJGgBuRf9p7pFFrzfpEm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d0124da53emr81455305ab.13.1738502902902; Sun, 02 Feb 2025
 05:28:22 -0800 (PST)
Date: Sun, 02 Feb 2025 05:28:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679f72f6.050a0220.48cbc.000d.GAE@google.com>
Subject: [syzbot] [fs?] KMSAN: uninit-value in full_proxy_unlocked_ioctl
From: syzbot <syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4b0881156fb Merge tag 'docs-6.14-2' of git://git.lwn.net/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a04518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d0bb5e08cf54aa2
dashboard link: https://syzkaller.appspot.com/bug?extid=8928e473a91452caca2f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150776b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aaab64580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4dbe3cd3dcb8/disk-b4b08811.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/592d90859f86/vmlinux-b4b08811.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cfde2b63c7f/bzImage-b4b08811.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
 full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
 x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
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

CPU: 1 UID: 0 PID: 5781 Comm: syz-executor325 Not tainted 6.13.0-syzkaller-09585-gb4b0881156fb #0
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

