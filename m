Return-Path: <linux-fsdevel+bounces-18721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEC8BBA70
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5DE282DE0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62517577;
	Sat,  4 May 2024 10:09:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85B11C83
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714817365; cv=none; b=AhrkDMvm+gbiMUfsMjGDvr0RcWUrw0KMPqljLKidkzYrMpjRq4W3WfK+30xNKSYjytYcBxr5xEZGYoVPiCkpSsV8kgStn4/go7+KBQ+fAw2Cnr01u8wyHmDdLEUm2TAs4dBw+eqFv9ScUeBn1sWtdYSZbODB1U+qRIff8rUzxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714817365; c=relaxed/simple;
	bh=bsWqH92bPTitnAvGPZChWKEcOUNC0cgs8ip0c9cpUvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iIghZLE5gku2aM6dYqlXyRhDuRQMVvz6GTzjCURsvtaMlkcRt233vYaUHPtm2batuVCEWO1CfQiFs4SfboFoKS7A0LdhNyU2u/ZmwwLRlPD3AB1lZD/8oFDq41UCAcnPYwFGslMtBQ4e0mMb0coA/YAFyn4G91XkthZceA47kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c8c30f0edso94635ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 03:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714817363; x=1715422163;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xwD+eQPjqq2z32jOpMV8mwhjWqPYjItKirZKpoaTh8=;
        b=V2Il0sw92Q8Mnty5X5E4ET+uCinriswqKXV7PoD4eWxt3HP45LIC56Fa8dFynudt/z
         2+jTo+5gTWJs2AQwLEClsUg6ovblCGQ4xlB5fFDQECG3t3LQm3pDzMXEZ9Qc5t3FKcsO
         WwoFAkA/Bvsi3jCRDpgcOB3gEdzzHOl+LdRNSymGvm0Vd6OK6/cXOZz6W7BvEKP2pkOF
         0Kph+9T4LdHdFwrc9ydHHahkSTU8r4er9Hlpuc69YTpG9rqWCEnZv6ml+dXUJkJp55Ea
         AXYvW4slH5GNL2S2ESWtTp0skXqa15PJ6hMnSbpy3goVteSAg3BUzRnbMP3lu+gTy/a2
         yEzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0YLhOBiqzVJ8hV5o2ywevIEtyfj00V6MBqKAAajT1E+oFGIRcVmKegV23CdL2sLI7S7pX3020Z3CmlJpNauLv+D6qmxoG/4Bt5YwZA==
X-Gm-Message-State: AOJu0YwOxF23ihPecT+1F4G3QxAZWSeC8LFmOqadwdl56AhR0BT42VJj
	9K1ssOrtGsPU3aTt8N9Bv78rwOmEPzefU9UfAfKdgml0Z16A1zyqboc8rSgkE4MNsaFsIEoHdZu
	sJApS8qPYiU1AHt67/lyKbNi4teTG1gibGETJcWJ7j4x6PMCGUtA5s5w=
X-Google-Smtp-Source: AGHT+IGNsiwyJnP5rz+204q10AYQvTIauChl7ZN6S8ctbnz1mUwCXjFTFgyJsxhfRLz8/KPiHuU1eNSgmwBjsFlYY07qxYsaDpvK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:36c:852:9dc with SMTP id
 h24-20020a056e021d9800b0036c085209dcmr271875ila.6.1714817363488; Sat, 04 May
 2024 03:09:23 -0700 (PDT)
Date: Sat, 04 May 2024 03:09:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce461b06179e07fb@google.com>
Subject: [syzbot] [bcachefs?] WARNING: kmalloc bug in bch2_dev_buckets_resize
From: syzbot <syzbot+b29f436493184ea42e2b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ddb4c3f25b7b Merge tag 'for-linus-6.9a-rc7-tag' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135a6250980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=b29f436493184ea42e2b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ae8a70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137cd2c0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5f22d23f04c/disk-ddb4c3f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/316aad0f5d86/vmlinux-ddb4c3f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5427a7af4284/bzImage-ddb4c3f2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8fe84d3b6e38/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b29f436493184ea42e2b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5073 at mm/util.c:649 kvmalloc_node+0x17a/0x190 mm/util.c:649
Modules linked in:
CPU: 1 PID: 5073 Comm: syz-executor199 Not tainted 6.9.0-rc6-syzkaller-00232-gddb4c3f25b7b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:kvmalloc_node+0x17a/0x190 mm/util.c:649
Code: cc 44 89 fe 81 e6 00 20 00 00 31 ff e8 ef b9 be ff 41 81 e7 00 20 00 00 74 0a e8 a1 b5 be ff e9 3b ff ff ff e8 97 b5 be ff 90 <0f> 0b 90 e9 2d ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
RSP: 0018:ffffc90003ccf0a8 EFLAGS: 00010293
RAX: ffffffff81d75a39 RBX: 00e60000000000a0 RCX: ffff888029583c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81d75a21 R09: 00000000ffffffff
R10: ffffc90003ccef20 R11: fffff52000799de9 R12: dffffc0000000000
R13: ffff888076880000 R14: 00000000ffffffff R15: 0000000000000000
FS:  0000555583854380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffee0b71c24 CR3: 000000007acca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvmalloc include/linux/slab.h:766 [inline]
 bch2_dev_buckets_resize+0x71/0x410 fs/bcachefs/buckets.c:1349
 __bch2_dev_alloc+0x7b4/0xa80 fs/bcachefs/super.c:1321
 bch2_dev_alloc+0xda/0x180 fs/bcachefs/super.c:1356
 bch2_fs_alloc+0x21fa/0x2330 fs/bcachefs/super.c:944
 bch2_fs_open+0x8cc/0xdf0 fs/bcachefs/super.c:2081
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7fb2d50d7a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe44855818 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe44855830 RCX: 00007f7fb2d50d7a
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007ffe44855830
RBP: 0000000000000004 R08: 00007ffe44855870 R09: 00000000000119fa
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffe44855870 R14: 0000000000000003 R15: 0000000001000000
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

