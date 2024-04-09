Return-Path: <linux-fsdevel+bounces-16417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3489D4A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531931C21224
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D68593C;
	Tue,  9 Apr 2024 08:31:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E61C0DD7
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651480; cv=none; b=dA64Jf4+QghYFBEhP+KPYlhgiVJCEFwJTLJT+w1/XQoLwR5u261ILGR95j68nZa9WYmbgGSyClLFHI6A++ofrVVTw4XRzUeRofcoJ1wBhMhwPZrDr7fp1btBMmH5iSOYnXVz0VYjU8IlmbXoXRh9v8fCMEla829qncwik8tZUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651480; c=relaxed/simple;
	bh=0mZxuIDQSzRSza17q/ZWihKXaW6gfz61Dd5U4XNqUNU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kCjNcrYq/WQDgCB1f03IiKPbgF5oqZNPGv0hKGrClBwthcxZAO0xGdCr8hXOQwzjVDmXVS0ZSokcWlEx3AZK/tBz47geQ9ny+PRRV2UnSirm7LbnmD5SUraN38/Ys0vp79YfQb1YekcGocV3kL4nY7ZHU0PHJPiRwcWdXdjA0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1ab65a52so25888775ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 01:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651478; x=1713256278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcGKM4YCl59TPh5E0Hi3BGbO70QQph4kXRIDBwCS8SA=;
        b=wKqHt9U7cAdMTH6VVuM5xSeR6cz6olsIahs6HXiMyWtGBqWkNLyNPUoLDJYSoZ4Y+D
         1z3wO90BWZ0LKDyeG1dwCbkUut4O4xwcrNlJZU/v3Nfb9b72sP09hiOf+g24MzhuCGbc
         SAh3o722ryexdanS3YDS9KjJfn5nemCwGLb5VhBGle2pYBK4cySiPhMgBv/0ocHGR2rw
         4mjvJi8EsSG5nu03HqGk+k41ktwS/dpxgIv5GBG0vb0RiYKF8PLqTMirMwNxxcjBUv6c
         yaDy3+YPhYFtg67kLB2VicbdvprC0todnyY2FIkPkR4O48ZxyIolpdDgvWyT3aOVcAAt
         +A3g==
X-Gm-Message-State: AOJu0YyAWwSIpysAl5jbPbK56CBKcqo9M3pw3DKTO465PjUqT8yNtpf6
	+qMbklWZ/6hnLUnzmpJvnjngCXxBBQ9WjKwbmuSPBIUjngYvZJvTZcmFl8BsbW3IvFBqyO/CVw+
	Lw+CLJ0cqXp2WPAbRn1CSNbLUyovCeGudmmUnj6wTXSVfO/71S/YnPmfOPw==
X-Google-Smtp-Source: AGHT+IFpVfhC2FHJufjWY36+DFOb9NUOz5Xw+KtO/Scs6jnc4hLJ0pdRIuKQ/WhOLMgxw2glaAIew7qsEOdKna8zVuJAhM8d/+v2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1386:b0:369:aa95:a632 with SMTP id
 d6-20020a056e02138600b00369aa95a632mr879757ilo.2.1712651478427; Tue, 09 Apr
 2024 01:31:18 -0700 (PDT)
Date: Tue, 09 Apr 2024 01:31:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fefd040615a5bef6@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr (2)
From: syzbot <syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec50db7033e Linux 6.9-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1467098d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=01ade747b16e9c8030e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138f4d8d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15763da9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc/disk-fec50db7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vmlinux-fec50db7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d02/bzImage-fec50db7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4dff8cc527ea/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in strncmp+0x11e/0x180 lib/string.c:291
 strncmp+0x11e/0x180 lib/string.c:291
 hfsplus_listxattr+0x97d/0x1a60
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmalloc_trace+0x578/0xba0 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4cc/0x1a60 fs/hfsplus/xattr.c:701
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 0 PID: 5019 Comm: syz-executor940 Not tainted 6.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

