Return-Path: <linux-fsdevel+bounces-34835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97A9C916C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C02818E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A22192D7D;
	Thu, 14 Nov 2024 18:08:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136018E029
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607705; cv=none; b=F0QQ5c3X0hxkOyjVz/yKn66RTwi8/KHqevhcfG5GBkwAm8XyUinrJRKdoD0Ovl+lE21cOSMVIikR68WhlXKJ+niksgYH9vfSshDFfF54rISZ+9WBqyZKrJ9yd8ZT6fDaDuFi2ZU/Otn1upO8TR5sippTDshfk9G69Vzk9GKew2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607705; c=relaxed/simple;
	bh=Fh546p/rbytnmnE4xmmXpNeC62ADBchoQwOLmebb6dg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BC/Z3BWMinLLzR6qP09PVVNm4Ift0Cu4AEAZgDe/9yQhp81APSpYioSXVV9SG8D5/JOaYodqgpMVzTi64eWRTKRwgtIP9rS2o4QpdO5asNF75xFn/3HtNxQRzcck8HaUezxQJUcS0PU0ZIRUwEo3CshjqsXbRvgwiLUPAAH5IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so10950225ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 10:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607703; x=1732212503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYUWis8KsVfXhccSEKlve2MsGBsC6w+q7AvNFF8Y2o8=;
        b=dIzFbhxnAptMim/cJ1UYaqgM9PZBMKNBdEZMeJg77xDbDmxN/hy6prQAcmImtl6wEs
         Zi78Pbvh6KKNGf7Kgze5SCVJ59FGM3ZI3Ft7KLUMV2LtLf/h2rTkzBEq0FtECsqAY6se
         RgOkWPibablIQuYfjG391KRGhA/qtWLSOGQsoHLr1jDD5MAv6B3xn9sl8AUo34XbQOxD
         62BvfcVfwxKEjsngpa4EaXcAckm8+ireyqbODzeN9TmysPL3Ghc337++Bfc8g3YZ9NYK
         jIeKihHBxE2Q/JSSlTqwmRwhMHXg4eSOlQsCUEdYQpIQPRBN5PNszLe2FPMF2AM+3/6n
         4+hg==
X-Forwarded-Encrypted: i=1; AJvYcCUTTkUJkPUruSNd3E9IwuPz2xDaf1J2W1QQ7doY7H/k+pouhuhmCYprN4/kwzEMNDiBxfs5FlFnmbrKXABZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11d5Dq+vW8pSmMZKIgtOTvgonaG9HWmqFOsEujFFq2MavbQjc
	/uEoRNnaOCJF7Tk34/FBqBvvbqPsLrABu23EOrs4+eRhtm/su4sUCLxNI1gTfrc4VFAW0mMm2TE
	bBtD4b8OLDUEmgNNJPQJjyQGX7oBgoOhEpI9ELK4Fan1kiWfUBR8T5Hw=
X-Google-Smtp-Source: AGHT+IFq6SFhWwnQ9PZNjtTiqyXxdVsTm550kHY7vQfZVeh6jyu86UqZI15Mqv0mQXXtG+siqPtRkkJDaKCTj9PI2KstP09Ca1xv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3a7:1e78:330b with SMTP id
 e9e14a558f8ab-3a71e78347dmr41965255ab.17.1731607702829; Thu, 14 Nov 2024
 10:08:22 -0800 (PST)
Date: Thu, 14 Nov 2024 10:08:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67363c96.050a0220.1324f8.009e.GAE@google.com>
Subject: [syzbot] [ntfs3?] general protection fault in pick_link
From: syzbot <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a9cda7c0ffed Merge tag 'irq_urgent_for_v6.12_rc7' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e55ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133fe35f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e93e30580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a9cda7c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29b6746965e0/vmlinux-a9cda7c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/455959afbe37/bzImage-a9cda7c0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d478326f6d12/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
ntfs3(loop0): ino=1b, "file0" attr_set_size
ntfs3(loop0): Mark volume as dirty due to NTFS errors
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5310 Comm: syz-executor255 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:pick_link+0x51c/0xd50 fs/namei.c:1864
Code: c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 fc 00 e9 ff 48 8b 2b 48 85 ed 0f 84 92 00 00 00 e8 7b 36 7f ff 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 a2 05 00 00 0f b6 5d 00 bf 2f 00 00 00
RSP: 0018:ffffc9000d147998 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88804558dec8 RCX: ffff88801ec7a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff8215a35f R09: 1ffffffff203a13d
R10: dffffc0000000000 R11: fffffbfff203a13e R12: 1ffff92001a28f93
R13: ffffc9000d147af8 R14: 1ffff92001a28f5f R15: dffffc0000000000
FS:  0000555577611380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc0a595ed8 CR3: 0000000035760000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 step_into+0xca9/0x1080 fs/namei.c:1923
 lookup_last fs/namei.c:2556 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2580
 filename_lookup+0x256/0x610 fs/namei.c:2609
 user_path_at+0x3a/0x60 fs/namei.c:3016
 do_mount fs/namespace.c:3844 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x297/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4b18ad5b19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2e486c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f4b18ad5b19
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007f4b18b685f0 R08: 0000000000000000 R09: 00005555776124c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc2e486c70
R13: 00007ffc2e486e98 R14: 431bde82d7b634db R15: 00007f4b18b1e03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pick_link+0x51c/0xd50 fs/namei.c:1864
Code: c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 fc 00 e9 ff 48 8b 2b 48 85 ed 0f 84 92 00 00 00 e8 7b 36 7f ff 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 a2 05 00 00 0f b6 5d 00 bf 2f 00 00 00
RSP: 0018:ffffc9000d147998 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88804558dec8 RCX: ffff88801ec7a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff8215a35f R09: 1ffffffff203a13d
R10: dffffc0000000000 R11: fffffbfff203a13e R12: 1ffff92001a28f93
R13: ffffc9000d147af8 R14: 1ffff92001a28f5f R15: dffffc0000000000
FS:  0000555577611380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc0a595ed8 CR3: 0000000035760000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   8:	74 08                	je     0x12
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 fc 00 e9 ff       	call   0xffe9010e
  12:	48 8b 2b             	mov    (%rbx),%rbp
  15:	48 85 ed             	test   %rbp,%rbp
  18:	0f 84 92 00 00 00    	je     0xb0
  1e:	e8 7b 36 7f ff       	call   0xff7f369e
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 a2 05 00 00    	jne    0x5d9
  37:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
  3b:	bf 2f 00 00 00       	mov    $0x2f,%edi


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

