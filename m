Return-Path: <linux-fsdevel+bounces-36379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D09E2ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B37B167A6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F31FCFD9;
	Tue,  3 Dec 2024 18:30:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF411FAC3B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250629; cv=none; b=hcSOW8uQjVVp2ZMTRhueOT1uFX5gWTWLjoHbxCf503R34QfpukdnIhytYkix8LJ8Zktte06czljxrCk2wd/qwFr0wgNLw7FW7cqKA3llgtmPlEJf6xFQO+hcv7jYr1Fxkog9QIFszoBR8w3RQF9AINUDnPgDbOvWaN+YfGCaIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250629; c=relaxed/simple;
	bh=BxqTgZ8DYcMuxGIHQF8207mN1Bw/kyEKETBG/wI9/QU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l9vabnMV+4UdcEAf+a0UT+/CR0hvfx7F0mkeYy+oV4XOMNfy1oYXrUbnERhl26Y4PA+uKIyJLj3BUwmMkM3pQU3VJb1C90bYqE/TIdMMWKnrXArJeZBSRMnfqPX/N2z4g0sx8An412IAaQrriisu8JNTb+5GbbkY/ATHJEsGYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7932544c4so55738415ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 10:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250627; x=1733855427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPSwDYSzv5BOLQJE1aVIaeyzWYq8dii3twSMxx62AzQ=;
        b=qIvsVnWN4PVqci+WBS4gmQGY8+EWkpRkWp7s/lVdWxX/cPZVrqiptZLSyIEnnM3v1B
         6QQ9BbYZgYeJI+DbajpE1bCyJbc1vEUOsdVs1oFwG1l/UV3ky0Rsb6YhCJBu+sJjggnQ
         h6pwmANIeL8moaGHqchEbLZXl/mPSN0KHifPDXg+EdNQdeAEXgG2pQdueJ1Fb8qfzj39
         55YgUY84gv6wAglQotjPennjbkHWNVOMU8/gBChKZHXhOxkWa7mV1Bqtkoh0ird8940a
         KUVc2W5JZf5HCCZnHNhfdbWS72XbtD0Mdv8My42Ep1kiE6SuGP9m5B4+tT4Qpc9fLPBN
         3pFw==
X-Forwarded-Encrypted: i=1; AJvYcCXl1+5ZCr582sNOE2R+rDFoKRz/tU35E0jbtF4VFdjbgpvDlI6Prz7sLAoZYfC/FmbPj+nBrVdVNYZx6Ofk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88+ZxYN4MGe8oL7NVTZeaDRQaPXvjbX+9CYAASVrPcP8qyZjZ
	QYV/sVHqyCLwFAQX3iAmj2AXOyAg2G2dPn052Nd8DWur4eyWHusBhGqfgPpUeV4iyMKI2COxmZ7
	bS9Bt9BncmXb7x2FZrXM6WdMLhT/rgPB1Ake8cn42FFQ6ExPYHLChhtU=
X-Google-Smtp-Source: AGHT+IH0dEbt2xIjnZ+uR8pkNYcCL9c/MaWU9jlZkBtlNFay+6dUatnai5fO4S9OZrJeX+XZFmbHfF0l+jX9qib5gvF2Ixtvw330
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:3a7:c5ca:5f58 with SMTP id
 e9e14a558f8ab-3a7f9a46486mr36929875ab.7.1733250627431; Tue, 03 Dec 2024
 10:30:27 -0800 (PST)
Date: Tue, 03 Dec 2024 10:30:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
Subject: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40384c840ea1 Linux 6.13-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1768d5e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad7dafcfaa48849c
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32ee9cd04555/disk-40384c84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7894cd1da27/vmlinux-40384c84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2129df5d769f/bzImage-40384c84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com

syz.2.96: attempt to access beyond end of device
loop2: rw=0, sector=161, nr_sectors = 1 limit=64
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 6259 Comm: syz.2.96 Not tainted 6.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:exfat_get_dentry_cached+0x11a/0x1b0 fs/exfat/dir.c:727
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 61 49 8d 7d 18 48 8b 43 28 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000bd8f378 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000009
RDX: 0000000000000005 RSI: ffffffff8270df36 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000009 R11: 0000000000000003 R12: ffffc9000bd8f4a0
R13: ffff88805919c000 R14: 0000000000000009 R15: 0000000000000010
FS:  00007f71995436c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3031cff8 CR3: 000000007b9ce000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 exfat_init_ext_entry+0x1b6/0x3b0 fs/exfat/dir.c:498
 exfat_add_entry+0x321/0x7a0 fs/exfat/namei.c:517
 exfat_create+0x1cf/0x5c0 fs/exfat/namei.c:565
 lookup_open.isra.0+0x1177/0x14c0 fs/namei.c:3649
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x904/0x2d60 fs/namei.c:3984
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7198780849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7199543058 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f7198946240 RCX: 00007f7198780849
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000e00
RBP: 00007f71987f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7198946240 R15: 00007ffd4aed7f08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_get_dentry_cached+0x11a/0x1b0 fs/exfat/dir.c:727
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 61 49 8d 7d 18 48 8b 43 28 48 ba 00 00 00 00 00 fc
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 89 da             	mov    %rbx,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 9d 00 00 00    	jne    0xae
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 1b             	mov    (%rbx),%rbx
  1e:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	75 61                	jne    0x90
  2f:	49 8d 7d 18          	lea    0x18(%r13),%rdi
  33:	48 8b 43 28          	mov    0x28(%rbx),%rax
  37:	48                   	rex.W
  38:	ba 00 00 00 00       	mov    $0x0,%edx
  3d:	00 fc                	add    %bh,%ah


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

