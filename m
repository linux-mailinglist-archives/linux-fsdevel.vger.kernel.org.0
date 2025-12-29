Return-Path: <linux-fsdevel+bounces-72164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B6CE675F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A72301AD08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2F2FBE00;
	Mon, 29 Dec 2025 11:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50C2F7AAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006564; cv=none; b=omcJpGMVmZt4ZzeY0H+qLSqpCh/CIx9Q5hUjxzgCar0Vfx5SoJp+B2dNcFYkflhzLmJiQw71dSV4xpS4tX5Pg7ZThLLHvGD5K11fQzJjmt3emNMSVvyGwmga7A56l5l8HEbcbBj9P3WzVTHlqKEMckCm/HD09NvvnxnyzGfJ1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006564; c=relaxed/simple;
	bh=pAuyDpU5oLWj9w9Cz+NjQIf9qoyI6EVxPrVuUOPMWSI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YzjF3O4/FbgtQsYBl/D99Q6UrPfaM6LhsxZ8LiVr31WvySsMEmsKBUj80J8NhPWqcB9L8dbi/+9M7+wEID6EGmaM3A+0xr3e4z3MWfL/KVeB9/HUu+XnVoao+EDgxNgO2V8GZbXyfKDVvVsnzq9Lgh1GU1+XtJsGZ/Q53TIrEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3fea6c3e817so2280813fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006561; x=1767611361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60Xyamx/h3ysjnvTktyovzErOYdK/RULB9LFjkm+8RA=;
        b=Xm45vgKGDOShyXdeHg2Zwi2pu0T6YbYx3Z4iGO0hpQOHEUCKLRV0BWlS/qRjd7+uYG
         k/+ZB6znw1Op0NLWyg3z0GylKkAndoCYqyFvU6MIDxsOPL4+PHI0KrRxy0i4JL5lfVcy
         V/th85jt2OQXS91caHcvE2ljaQ1Psi4a9rHj0QJefecW+oItlvOBA+IUPnqpTaKdNd+m
         CkDZHuXwjyk+kxHmlAehUPZICTalNcmvsPkbVx6EMe3TsQN1QcbDLQP4XOCOaTRcp54Q
         SPfaj1kH4Ia6lOvTlTZpAZgESnYx5rKgAY1ivnPSo07/ogFZkSSM1u1y+CH2fZK6A4s2
         NJrw==
X-Forwarded-Encrypted: i=1; AJvYcCVrRivkDOf+6/bl8p48qs0SfQz/mBLQXAJRUrcUIhCRSZfnMnEzo1h+ga+DhBft7rlwdTomeir9sETLetRh@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOmdWf0m6MyS0Qx+R2Jp400jgjR4A4UlNTYQlwajebaDBdwub
	HRRX8UBEvaITzQkdAl944m8vWDcnnMqzYmnGI+/RIvaiYbBV9yPnAvicx+++JsrGCp3oQbNOabT
	A83ndPUhx6rz9f1FbPfCk9Ll/zGu7uBOZAooJfDOa2G7xgUOZqu647u4AsrE=
X-Google-Smtp-Source: AGHT+IHUvuTKW6aL+r29nwMOlej4fRaox1OMiLU6rEO9bqqPpwqwJv4xa5pzZrmM9T0v3TgFjFyt9taUN+yrJwEqPYdOygQn6WUr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d744:0:b0:65c:f062:bdde with SMTP id
 006d021491bc7-65cfe799322mr11668000eaf.36.1767006560880; Mon, 29 Dec 2025
 03:09:20 -0800 (PST)
Date: Mon, 29 Dec 2025 03:09:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69526160.050a0220.3b1790.0007.GAE@google.com>
Subject: [syzbot] [fs?] BUG: corrupted list in vfs_setxattr
From: syzbot <syzbot+51930590c5ad85537daf@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40384c840ea1 Linux 6.13-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129395e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=51930590c5ad85537daf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92994d383dd8/disk-40384c84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5296b519dbbf/vmlinux-40384c84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/284141b3f7b6/bzImage-40384c84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51930590c5ad85537daf@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffffc90004bef8c0, but was ffff88805cd4d170. (prev=ffff88805cd4d170)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 12801 Comm: syz.4.1836 Not tainted 6.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0x11b/0x140 lib/list_debug.c:62
Code: 36 fc 90 0f 0b 48 c7 c7 20 67 5f 8c 4c 89 fe e8 db 67 36 fc 90 0f 0b 48 c7 c7 80 67 5f 8c 4c 89 fe 48 89 d9 e8 c6 67 36 fc 90 <0f> 0b 48 c7 c7 00 68 5f 8c 4c 89 fe 4c 89 f1 e8 b1 67 36 fc 90 0f
RSP: 0018:ffffc90004bef738 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff88805cd4d170 RCX: 1ea682c095ed3b00
RDX: ffffc9000ef54000 RSI: 00000000000051e2 RDI: 00000000000051e3
RBP: ffffc90004bef990 R08: ffffffff817f075c R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: dffffc0000000000
R13: ffffc90004bef8c0 R14: ffff88805cd4d170 R15: ffffc90004bef8c0
FS:  00007f75e3bba6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f75e3bb9fb8 CR3: 000000004d838000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 rwsem_try_write_lock kernel/locking/rwsem.c:661 [inline]
 rwsem_down_write_slowpath+0xf9b/0x13b0 kernel/locking/rwsem.c:1150
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:818 [inline]
 vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75e2d80849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75e3bba058 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f75e2f46080 RCX: 00007f75e2d80849
RDX: 0000000020001840 RSI: 0000000020000240 RDI: 0000000020000200
RBP: 00007f75e2df3986 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000002d6 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f75e2f46080 R15: 00007ffcc95a8aa8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x11b/0x140 lib/list_debug.c:62
Code: 36 fc 90 0f 0b 48 c7 c7 20 67 5f 8c 4c 89 fe e8 db 67 36 fc 90 0f 0b 48 c7 c7 80 67 5f 8c 4c 89 fe 48 89 d9 e8 c6 67 36 fc 90 <0f> 0b 48 c7 c7 00 68 5f 8c 4c 89 fe 4c 89 f1 e8 b1 67 36 fc 90 0f
RSP: 0018:ffffc90004bef738 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff88805cd4d170 RCX: 1ea682c095ed3b00
RDX: ffffc9000ef54000 RSI: 00000000000051e2 RDI: 00000000000051e3
RBP: ffffc90004bef990 R08: ffffffff817f075c R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: dffffc0000000000
R13: ffffc90004bef8c0 R14: ffff88805cd4d170 R15: ffffc90004bef8c0
FS:  00007f75e3bba6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f75e3bb9fb8 CR3: 000000004d838000 CR4: 0000000000350ef0


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

