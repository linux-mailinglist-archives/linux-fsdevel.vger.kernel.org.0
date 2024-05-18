Return-Path: <linux-fsdevel+bounces-19707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4E8C9022
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CD11C20E8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBC9168C4;
	Sat, 18 May 2024 09:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E94DDA6
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716024090; cv=none; b=BXGg1wJ1XrgTGZ4yrpFw4InNgCtzZZGw2Qb4BAl9yLQKYRIw8DF9lLO5ERR1BDrnCC/QlAJJ4D+ja9iqfUdQUrc5MdmuNcVzk9qdQcinVb05zYNG+VEWgZm5f+6aFYgZXDJWlyppQjPS2i7y5+PKdPnS4zLDZ/itka/RvduV8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716024090; c=relaxed/simple;
	bh=ueENnLy6R1i73rLrw474/Wjb06OfO9OYMrw3+qQzOJM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ha/1a7BDXLZc2CvArYM0i8NX1WjnmKsspHUpSLl1nRofSkOJ5pX+HkS4NalcEGQrFbDPUiqK7Dgxo/p/9Jamka3CyU4K34Iu4/RYHe8WeU/QC98XmsdPTdH1i+Nfh+UjGG944Z1iubMNx+LmJeEOknEvkzs64bXESk9NFMiaxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso633926439f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 02:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716024088; x=1716628888;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7u2sykXclLAuHjZeOQu7w1/FZzOCnzTGbTdJDxNLL/U=;
        b=MWD0RNBZuIixT1fuDp42kKe3XjXKbmfXbP5DLJSyzB0/LP9sQq02/FWJzG4EDi4nWV
         JUo95uk4tWGzfcSzmNCe1r6F5dZoH+6fCNWwImw2D6phWwB7HejNciSkFyolYDfsxeJZ
         hos8MztnUtu2xRnLqP1iLr4NzKMr6V4B9dVzdnbxkOLofAlB4rkQvKaIf18KAJ/D6b+y
         5JzRkZCDE8yfX+EVWhoz/L1wjwQxCVXIiWWYcBsMwoAG37R1dYa+xSZS7rLeOIBywe7z
         O+hmO6iDZm4ZCbP5Xm2C/Vp+ZQyvd1m6BXE907a0AfTv0cm/JUFvQt/ruY83b6x84//w
         Z2NA==
X-Gm-Message-State: AOJu0YyezRz9BZnT/Go9OJ2H2Y7tWgPsqDvDbd/lyxqnwgTwxQxrwF0V
	a/j8ptLpZSNIcwYkPcuPzW9kdV3+oh0kkt5b2CjMTIf/HDuDLmx9fW7FY5tVZ63WOhDXdg2LjN3
	Mo2axUuDi+dGZgrnp2NwiZj+HISGBayKx8uZTSOZfsiI2jA7lGFyiYaFG9A==
X-Google-Smtp-Source: AGHT+IHjizWcP8MG9wxRuuBdba2WI1gcMyvUyfIgNCs8Sh48sJfXSchzsHoJfI/ii4Vx1kkGq+pS4+EwPoM8vBhnTbJ5YutdpVTY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-48957cb32aemr1631403173.0.1716024088396; Sat, 18 May 2024
 02:21:28 -0700 (PDT)
Date: Sat, 18 May 2024 02:21:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037162f0618b6fefb@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
From: syzbot <syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16035b70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e100d74625a6a5
dashboard link: https://syzkaller.appspot.com/bug?extid=efde959319469ff8d4d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10314fbc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f47248980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81edac548743/disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42f67aa888e5/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e5cf5b3704d/bzImage-a5131c3f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/08efa6c23198/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
 sized_strscpy+0xc4/0x160
 copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
 hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 5047 Comm: syz-executor429 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

