Return-Path: <linux-fsdevel+bounces-77327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JB4DK22k2l17wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:30:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446C1484E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AAE7301ECC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204A238C36;
	Tue, 17 Feb 2026 00:30:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A3C2E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771288230; cv=none; b=c4qQh6DXwsQUTMehlQ0f0WaxligCj7rld1tJxkN5lggFNMTBcuy4nBEoqYT/F4l8ef3j0gClhHKArgWTHQDuz9uz59acqXnEzg3yNrKqq58zzUoF32oV0g9wAAwZJXi4ERYHYKE+himMMei33XZOYwlM1mcems00HaprlcrUbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771288230; c=relaxed/simple;
	bh=fA+PAPwqtgQVDnSTHzxOVSJe3IbBS3YkxXEFVMhqb2k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KR0C8vhuN5v22K4h+zIrEt0dxfDP+qaX/wDljjSasg2nZM62owcIQTnfh+TCIlZ5FcAkoHpCbsNQzN5JbpxEkpGKgwReB48rp1wkNgzUuBhDoL8xnPurEpgFPJNv2T4QDUPNwAgIPwDCaJNwJGlzyry++6utn4GmE8Qqi60mGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679943693c0so11662456eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 16:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771288227; x=1771893027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EogSuO0ftbI594l3InRmFgd5c8hh0uBqGBuQamWLThY=;
        b=kZgXvtUatVPKO98AUBAvcStXu3ZejwGPeL4KCVNCjEP8JNYyBvKJ+uQjX49BPHm6MO
         MlDv1/NaFYjwqJ+Xk/MmiyYqjaSBmOXGAigemzFOTlzjk9gcYxqDoWI2k4+edojf5Kk8
         YckNd4z3QJ3E0n3iDIBWk4ym6gU4pI6UaMEGcKJqX12BnQXVeTgW8UOJl36Rr/pvZYK/
         1/5CvyZ1OtT8QSZN21PeszXTMHiasSgGk3MQYSvVa81UxR1+r+9hB6PWsbnFFEzk+J0D
         9mGckBHxiuWU1mtCHCeC0T22BUGJhQuSsc74i0ymY1laEgAJ1Z2tDnyf60FTBFoaXVnz
         aH5A==
X-Forwarded-Encrypted: i=1; AJvYcCWFXQd/VxTpWe1IdJUCoHGWMwWa0bAkGk4jGsn1UNAQpCcQM/O+14NnDXDWPI29CCzz5tltSJ5BBiK9rcpv@vger.kernel.org
X-Gm-Message-State: AOJu0YwwK1bm/KaEk8ATQphkrciBEMCVeYqqw9bXdyqpI0mgb4oPbyvP
	2Gv+qbEeZAhNkxUSFJKgjaWPxQ1WrN533iuNU+hkkhPhS5v01aV6TntFaw3mSaDSf40MlNJv849
	MkY6ymWs/C7D9wriHPmDhFwl7u7TbNL+RB8u0T5KCVjVucLt7zl39/Q2kSg0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c15:b0:676:9ba8:e486 with SMTP id
 006d021491bc7-67767198f38mr7030847eaf.21.1771288227606; Mon, 16 Feb 2026
 16:30:27 -0800 (PST)
Date: Mon, 16 Feb 2026 16:30:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6993b6a3.050a0220.340abe.0775.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in filename_mkdirat
From: syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77327-lists,linux-fsdevel=lfdr.de,0ea5108a1f5fb4fcc2d8];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9446C1484E8
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15331c02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0
dashboard link: https://syzkaller.appspot.com/bug?extid=0ea5108a1f5fb4fcc2d8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146b295a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/vmlinux-0f2acd31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b18643058ceb/bzImage-0f2acd31.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfed09077d3/mount_1.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=106b295a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88804a18c9b8, owner = 0x0, curr 0xffff888000ec2480, list empty
WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#0: syz.0.53/5774
WARNING: kernel/locking/rwsem.c:1381 at up_write+0x2d6/0x410 kernel/locking/rwsem.c:1643, CPU#0: syz.0.53/5774
Modules linked in:
CPU: 0 UID: 0 PID: 5774 Comm: syz.0.53 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x388/0x410 kernel/locking/rwsem.c:1643
Code: cc 8b 49 c7 c2 c0 eb cc 8b 4c 0f 44 d0 48 8b 7c 24 08 48 c7 c6 20 ee cc 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 10 41 52 <67> 48 0f b9 3a 48 83 c4 08 e8 ea 60 0a 03 e9 67 fd ff ff 48 c7 c1
RSP: 0000:ffffc90006407d80 EFLAGS: 00010246
RAX: ffffffff8bcceba0 RBX: ffff88804a18c9b8 RCX: ffff88804a18c9b8
RDX: 0000000000000000 RSI: ffffffff8bccee20 RDI: ffffffff9014bf50
RBP: ffff88804a18ca10 R08: 0000000000000000 R09: ffff888000ec2480
R10: ffffffff8bcceba0 R11: ffffed1009431939 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88804a18c9b8 R15: 1ffff11009431938
FS:  00007f9e11bfe6c0(0000) GS:ffff88808ca62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000d54e20 CR3: 0000000041f2c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:1038 [inline]
 end_dirop fs/namei.c:2947 [inline]
 end_creating include/linux/namei.h:126 [inline]
 end_creating_path fs/namei.c:4962 [inline]
 filename_mkdirat+0x305/0x510 fs/namei.c:5271
 __do_sys_mkdirat fs/namei.c:5287 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5284
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e10d9bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e11bfe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f9e11016090 RCX: 00007f9e10d9bf79
RDX: 00000000000001c0 RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f9e10e327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9e11016128 R14: 00007f9e11016090 R15: 00007ffffd54f8b8
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	49 c7 c2 c0 eb cc 8b 	mov    $0xffffffff8bccebc0,%r10
   7:	4c 0f 44 d0          	cmove  %rax,%r10
   b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10:	48 c7 c6 20 ee cc 8b 	mov    $0xffffffff8bccee20,%rsi
  17:	48 8b 14 24          	mov    (%rsp),%rdx
  1b:	4c 89 f1             	mov    %r14,%rcx
  1e:	4d 89 e0             	mov    %r12,%r8
  21:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
  26:	41 52                	push   %r10
* 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2d:	48 83 c4 08          	add    $0x8,%rsp
  31:	e8 ea 60 0a 03       	call   0x30a6120
  36:	e9 67 fd ff ff       	jmp    0xfffffda2
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c1                   	.byte 0xc1


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

