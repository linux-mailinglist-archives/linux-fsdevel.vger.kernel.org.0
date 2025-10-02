Return-Path: <linux-fsdevel+bounces-63202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA217BB21BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 02:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9A1922D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B70C2D1;
	Thu,  2 Oct 2025 00:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4DA55
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363836; cv=none; b=M/xW987ofERYhYEZ7CvHinPu6woVl2o0n/XpDnmKSTigsFTDljHmm55Nub9k9UDCkXrvm2k0JaJWxekCNQAUY+8qwkqoyCpOq1Q3XEmkPcg17bscq/4Mp8Q2Az0ATLWM4zPcuafywaBWOKVRax5OAw55BdUgDBFs6Q20Lg+cV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363836; c=relaxed/simple;
	bh=cyQPuwS82c3qKwDs1IXD5ItrhxNtnnwRc3Fgo/LjYOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jh515P1Yx5+Ru6hyh5kP+W5BxbWYwL8RJyX3+hZZPtPk8cL56ON3Q/CvcfjE2FOu2+7Cip8d4JZpqwjSbbn9JnU/9+bcpwxHCw/cWA3yzd31jvZjYdgBm7TrQGXbUAJF9K0KIhr6H+Pqht/lg6PBDcsSA9PGTnJnMoIyA9q6Y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8875a8663d0so50954639f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 17:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759363833; x=1759968633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+4I3VinM/g0IwZH7qpZY41xIHfXvj8Dn0TeRI7omzg=;
        b=WjLTAa3YiErOx5ID72f++zdbC0CJrr5h6QW4/i9umV4IomZo3efg4l5aH5ULs1C6IZ
         cEEzVoBIDJMKx/j2ZkZwwnw7JuDz9NdeLhUguk9BV5h5kfudriLb62mkkoH+M5oTVTvj
         WdPT4uiHxiExWXVh/G7OS/Td3K5LHKhaVHHKDMXjQThsfEtkJmaTZOU6PXiNUoKGdEKw
         VIWWv5bi5ZIICV/jN2e153S50MMsFRijwopg9Vje8bYMe/sw5ZwtxFCyeM4NUnO6vLK3
         OTTmafNEsd4rLraYtoC8LnLrRDaEJ3+/hjTu1eWpGXH2vVk/cRHWcR+4yNYaLb6c2kR3
         hkLA==
X-Forwarded-Encrypted: i=1; AJvYcCW1CFoy4R8VkO1/ichiSQoy35adQu+vkkKKEMPu/YtRmoA81TxFEFiFgArCfSettKJogVPilzsPqq7r01gr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7ssDstZfXFbhP2huWFOF5Kw35ymFYnbHGUUcFAosu0+vDV17
	O9hvyso3AOEEgUtXkWJvrAo2BEC8+TTC5B/igUQycafiwN8AivwgOPAnZ6WAmJHMX9R/1jmMQyX
	TvrqacgQmpLjvbHrLLos/wzjWpGWXviH3JQ9RMLjBCBRiaHA5Hmr7s6CW3H4=
X-Google-Smtp-Source: AGHT+IE1y4VBYe8gL4btTD/TP03j3wgZRy1gTrrLiuVEGEC0nLniFFbXaPWxl9JheO+7+RBWePTX/t1UdzDxprw4A+hTUHhJ+Q8n
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:42d:bb9d:5358 with SMTP id
 e9e14a558f8ab-42dbb9d5492mr5195145ab.27.1759363833558; Wed, 01 Oct 2025
 17:10:33 -0700 (PDT)
Date: Wed, 01 Oct 2025 17:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Subject: [syzbot] [erofs?] WARNING in dax_iomap_rw
From: syzbot <syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dan.j.williams@intel.com, 
	jack@suse.cz, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136ee6e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
dashboard link: https://syzkaller.appspot.com/bug?extid=47680984f2d4969027ea
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181036f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15875d04580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33a22a854fe0/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e68f79994eb8/bzImage-50c19e20.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/71839d8fa466/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17630a7c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs (device loop0): mounted with root inode @ nid 36.
process 'syz.0.17' launched './file2' with NULL argv: empty string added
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5507 at fs/dax.c:1756 dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
Modules linked in:
CPU: 0 UID: 0 PID: 5507 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
Code: ff ff 49 bd 00 00 00 00 00 fc ff df eb 84 e8 33 d7 6f ff 90 0f 0b 90 80 8c 24 c4 01 00 00 01 e9 b9 f4 ff ff e8 1d d7 6f ff 90 <0f> 0b 90 e9 ab f4 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 56 f3
RSP: 0018:ffffc9000296f840 EFLAGS: 00010293
RAX: ffffffff824eae63 RBX: ffffc9000296fc00 RCX: ffff88801f938000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000296fb30 R08: ffffc9000296fa9f R09: 0000000000000000
R10: ffffc9000296f9f8 R11: fffff5200052df54 R12: 1ffff9200052df80
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555575829500(0000) GS:ffff88808d967000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41f4179286 CR3: 0000000050011000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kernel_read+0x4cc/0x960 fs/read_write.c:530
 prepare_binprm fs/exec.c:1609 [inline]
 search_binary_handler fs/exec.c:1656 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x8ce/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
 do_execveat fs/exec.c:1945 [inline]
 __do_sys_execveat fs/exec.c:2019 [inline]
 __se_sys_execveat fs/exec.c:2013 [inline]
 __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2013
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7556f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3815728 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00007f75571e5fa0 RCX: 00007f7556f8eec9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f7557011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f75571e5fa0 R14: 00007f75571e5fa0 R15: 0000000000000005
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

