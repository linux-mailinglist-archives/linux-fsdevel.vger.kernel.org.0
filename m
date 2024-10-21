Return-Path: <linux-fsdevel+bounces-32459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7C9A5EB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D22A1C21454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50091E1C07;
	Mon, 21 Oct 2024 08:34:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823871D278D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499671; cv=none; b=rKY9QJYLd/0GTtx2mNhN1f0qWRZKe6tw27rn2Evmpb+YOmA7NTicjk1W7Ax6flhH5KReO6s4JrqZGXrMI99LUQsqlRFRPEhMRUQe4kyIqMo9LWpxCd6za341HCVfrMcEJYbZa2uOolwKG8TktxGqKnirQBtpF2wDLp0baTNziJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499671; c=relaxed/simple;
	bh=XU8o2WZZZAB7gSPAv2O20qXXZQ9Z1te3GzZRn0W0oTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dvQRk9GWedCIDcodv3WKpeYJElQHLEexhxGCs4aX3rvahkKzdOJf1snuv6Wt55iXNjUafJ7kRhrj726Gt87gvSlq7JfQ7xdsnSqKlYwFj01XGvA16pPOJLGF6UZtqKGhywkBLADWlKr/Yvy6jmhzLhUVOrD83h3sEMKDcNvRnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so36063055ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 01:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499668; x=1730104468;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMjfFkhxpj6Tyr8/Ow2y3KJJJ/7bNVau0WrSqtwkCAs=;
        b=JPxCedJwi4KG5c4/OkNCNuAWrCmuUUZojWlDRf1hjUwMAcM76sKNeM08rlVT3c8HD7
         otezEAOwo3IxfdqvF0IPfDBDZzhUvYki9xgpyKkuwB1qXb9fmZ6xHoYq8ZJQeuz0a8dp
         Is5CLT0r+jciKapDy7N2RW0OF73B2Kot2IRK6JzN+4Gg6XAeW1n02kJ9IS15+w0e6Grf
         WKhL8oxwvlB/vyBnvladt+4Ie0NaFPsK9UJFUSrLo3mBsJ8czpy9CchyQ7Q18i91HtY8
         RPCo3L+JCSYS7VNx9/J7sHlfoyPmr7NUTirkAGGADWmiWJJKj+RJxFreqp9MvWaqkEti
         1sCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65k1Y4TtRv2mMOzCuD0PC9URyzYjNNLvuJC2awQ+DrgYulfIWGuMzqhGGQIbSAYe0uS8C74M/tzGYGsCX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhc4r4QyfbRx+BLai1XmzMsOhY/j1CXQV4KcqCqNGpUEDp+qxQ
	nLBn7mbqc46TnDdsfvl1LAeh3MtKyqjYajtURi5qOCH5IA8WgjY7IDr4QOHSWeGZWzUdQJX+0Vp
	YzDDePhNkLdtK3g0hlZP+veRcNf7rC+mMxLMbXosmEe7YO8OPg5l3X1k=
X-Google-Smtp-Source: AGHT+IH6pKUvJqlfItRP5S/8YUn7NiAOX/hauIj9Fm5rYracYxmLjFpilAeCZkIN0Rc3usLGK9IJUFvoijf17MWeWA+F99Rbq4mJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a3f409feb5mr76220495ab.17.1729499668417; Mon, 21 Oct 2024
 01:34:28 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:34:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67161214.050a0220.1e4b4d.0051.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in vfs_set_acl
From: syzbot <syzbot+0ec57cf5875fb74b1749@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1d227fcc7222 Merge tag 'net-6.12-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142b1fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=0ec57cf5875fb74b1749
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3858ef614f2/disk-1d227fcc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c3bc0a9537f9/vmlinux-1d227fcc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50778a472926/bzImage-1d227fcc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ec57cf5875fb74b1749@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88805ac19b98, owner = 0x0, curr 0xffff888028243c00, list empty
WARNING: CPU: 1 PID: 6279 at kernel/locking/rwsem.c:1368 __up_write kernel/locking/rwsem.c:1367 [inline]
WARNING: CPU: 1 PID: 6279 at kernel/locking/rwsem.c:1368 up_write+0x502/0x590 kernel/locking/rwsem.c:1630
Modules linked in:
CPU: 1 UID: 0 PID: 6279 Comm: syz.5.261 Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__up_write kernel/locking/rwsem.c:1367 [inline]
RIP: 0010:up_write+0x502/0x590 kernel/locking/rwsem.c:1630
Code: c7 c7 00 be 0a 8c 48 c7 c6 80 c0 0a 8c 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 d3 42 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6a fd ff ff 48 c7 c1 00 25 1d 90 80 e1 07 80 c1 03
RSP: 0018:ffffc900032efb20 EFLAGS: 00010292
RAX: 220090bc865dbe00 RBX: ffffffff8c0abee0 RCX: 0000000000040000
RDX: ffffc9000b6b1000 RSI: 000000000000a04b RDI: 000000000000a04c
RBP: ffffc900032efc00 R08: ffffffff8155e402 R09: fffffbfff1cf9fd8
R10: dffffc0000000000 R11: fffffbfff1cf9fd8 R12: 0000000000000000
R13: ffff88805ac19b98 R14: 1ffff9200065df6c R15: dffffc0000000000
FS:  00007fbdc01a26c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94b6826920 CR3: 0000000063cca000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:820 [inline]
 vfs_set_acl+0x9c8/0xa60 fs/posix_acl.c:1143
 do_setxattr fs/xattr.c:626 [inline]
 path_setxattr+0x3bd/0x4d0 fs/xattr.c:658
 __do_sys_setxattr fs/xattr.c:676 [inline]
 __se_sys_setxattr fs/xattr.c:672 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdbf37dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdc01a2038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fbdbf536058 RCX: 00007fbdbf37dff9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000100
RBP: 00007fbdbf3f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbdbf536058 R15: 00007ffc82e49b58
 </TASK>


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

