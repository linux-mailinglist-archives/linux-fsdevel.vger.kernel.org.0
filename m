Return-Path: <linux-fsdevel+bounces-60736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A064FB50DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F4A1694F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E3305973;
	Wed, 10 Sep 2025 06:21:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1E24C676
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485290; cv=none; b=P+b/2EkFPeGHiNtOKvdZuKnnp8ofmIH6pk7F8q0bIumUfoW6lGP8TKkCjjRMN4JJRzEOLZgo8RShu9eP6tYYG7anRYsND+p1LBoqIk4yoZTio9zLgx99hyPA1/NHKNqzdnmf0BmTZAKiBnKGSAZBinyXDepkDY4YKMRXnYxHCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485290; c=relaxed/simple;
	bh=b5jd7CnC//BOgzAN0SVoaRy51JdXpgDn4rlx4t4QRIE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H6qIDhLeMnfMYOcozTmQ+0icZHONX9mzJcneeZscJ7zGS97RTDUCWTqgpWXErC4zqxxoQm+qzdcW7gwS749DS0PGIfwQtrazwsrMi3Z4o9N+Be1p1AquaqKKbUbbOmmEqMgzD9BYIiVYorBvlkBYAw8oQCyQsC95c0w5Htixk2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f6665a4754so172694305ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 23:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485288; x=1758090088;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYlqAamVvSnwGhSCVqIBJFh4zZ8HRHyuyjEn4nudeQ8=;
        b=Z7x8lz5GuZxiQ9vdOO6YswcnK0N5tyt10pELA5DyyQh3HCl66ZetEsXbz1XaCjo6JQ
         LDYosrZBwS0CRpxfXgJOicAb/s6MhJ+lI7p6xZSoPslVcVltqY6LZRn5st7auHVZGxPE
         1U1dpzKE2HHm7EvOmQfKUpy5e1jNR9kuu8zl65cAY4EycX+Fo4c9/tTxBh6cvTVvwJFN
         bGtEFvCIUzTyxAJFNatx0EbPcpJ2LkfaoYNPFHijfA6zz3EnzSla7S7nizAyCz6TOPEQ
         lAB2w7gjYzP2zJ9ueC/u+rY7pIu9I7gELDOlNJAKGlFilIiwFtlnJL+35VKaoqsfGsGa
         0Y8g==
X-Forwarded-Encrypted: i=1; AJvYcCVLpn/VJov24MZKqAO+J193qbT7ps0Hm3/vpY2DegiGu9F4j5IB6BiZCJRtFHdpralqqUmhgMrbUkjd9vLg@vger.kernel.org
X-Gm-Message-State: AOJu0YzgdTgmDIcII2JR7L7YNhnOaSmRi+QZKGXbMQKUavuc7Bf2Ww5f
	pNagataJ9bceFvFoN41bIpoW/HHo3eAUFU5zbo/il5UWqx6PfNYSPbVXQ3jmOB079n7y9/t9grQ
	9B2k7/IWxJdwcD0YDDBsV7R8yRZIiXmqTuWgw6llbMeZv+hWke3fA2QgEILA=
X-Google-Smtp-Source: AGHT+IFPmn6Qp7MQTCZLVIyLBVDY7pJq89ucHf0o8ZroR9Rk12oClpbBqyqjYRmhGzQA3fyX3/UDK1k9X/ldbig+CGZclB0eymT/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3f6:6035:652d with SMTP id
 e9e14a558f8ab-3fd877818admr186414655ab.23.1757485288290; Tue, 09 Sep 2025
 23:21:28 -0700 (PDT)
Date: Tue, 09 Sep 2025 23:21:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in sysfs_emit_at
From: syzbot <syzbot+b6445765657b5855e869@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c8ed9b5c02a5 Merge tag 'drm-fixes-2025-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112eba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba0962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e2a962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4da8d56aff3a/disk-c8ed9b5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1366baa37dbc/vmlinux-c8ed9b5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0674b31d870d/bzImage-c8ed9b5c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com

------------[ cut here ]------------
invalid sysfs_emit_at: buf:ffff88803234000a at:10
WARNING: CPU: 0 PID: 6027 at fs/sysfs/file.c:795 sysfs_emit_at+0xe6/0x1a0 fs/sysfs/file.c:795
Modules linked in:
CPU: 0 UID: 0 PID: 6027 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:sysfs_emit_at+0xe6/0x1a0 fs/sysfs/file.c:795
Code: ff 0f 00 00 4c 89 fe e8 28 e3 5a ff 4d 85 ff 74 68 e8 ae e7 5a ff 90 48 c7 c7 20 66 c3 8b 44 89 e2 48 89 de e8 2b de 19 ff 90 <0f> 0b 90 90 31 db e8 8f e7 5a ff 48 b8 00 00 00 00 00 fc ff df 49
RSP: 0018:ffffc90003d6f860 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803234000a RCX: ffffffff817a02f8
RDX: ffff888032578000 RSI: ffffffff817a0305 RDI: 0000000000000001
RBP: ffffc90003d6f938 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000a
R13: 1ffff920007adf0c R14: ffffffff8c742680 R15: 000000000000000a
FS:  000055556eb34500(0000) GS:ffff8881246bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000040 CR3: 0000000071308000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 usb_show_dynids+0x17e/0x220 drivers/usb/core/driver.c:126
 drv_attr_show+0x6c/0xa0 drivers/base/bus.c:113
 sysfs_kf_seq_show+0x213/0x3e0 fs/sysfs/file.c:65
 traverse.part.0.constprop.0+0x107/0x640 fs/seq_file.c:111
 traverse fs/seq_file.c:98 [inline]
 seq_read_iter+0x932/0x12c0 fs/seq_file.c:195
 kernfs_fop_read_iter+0x40f/0x5a0 fs/kernfs/file.c:279
 copy_splice_read+0x618/0xc20 fs/splice.c:363
 do_splice_read fs/splice.c:982 [inline]
 do_splice_read+0x282/0x370 fs/splice.c:956
 splice_file_to_pipe+0x109/0x120 fs/splice.c:1292
 do_sendfile+0x400/0xe50 fs/read_write.c:1376
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64 fs/read_write.c:1417 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f645838ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedc1827c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f64585c5fa0 RCX: 00007f645838ebe9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
RBP: 00007f6458411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f64585c5fa0 R14: 00007f64585c5fa0 R15: 0000000000000004
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

