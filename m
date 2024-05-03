Return-Path: <linux-fsdevel+bounces-18655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC68BAFD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC6C1F23084
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6046153BD2;
	Fri,  3 May 2024 15:30:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270681514E5
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750234; cv=none; b=sk8ILLOcV7Xj/mQeGwoPchmHMxUsAwWut4O98oscl7k8Eh1K1PDg+vJs/GM9Xfv++XAoK79VQLOVaVdZe2SH3sHvHiqSuJYYAx/iUI7QFugGQMWfwGU7jCrIptIdgxk35KG3IISceGX4IhtI90jMDm65m3+++gpiIBgyndPlF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750234; c=relaxed/simple;
	bh=kyrVC4J9Vz6z/FduOGDJDpnwitp8VpXFgJDjIHnTBRw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HbpNzsAc3bepBc8fVZAsW7Y1Y1bXLTKLT5XFVL8t9FaIekpU1YLiPg5XHHUDbxZc4c7rHXq2ZTlQK+f3eqApaQAqNu/MpqqlYZ1pN2UMuvktwQJ4HLq3LzSSJ8EePmU0PEP5bJTZdXB2ibaFMcx95NytN61NojfI3uhEVPV0cnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec4e29827so622629639f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 08:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750232; x=1715355032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhz7DHtOSMsZMwSUUcoIINLpsdvrcVbqiM74fDm/9ds=;
        b=qOCAigBvpy1HwdJ+BqK0i4A/GHjqx+1VR6PbRYqhQUjN1HVqChdV50DNQrcRGQiCFL
         tP5EA8WKZ0ancB5sQSLdkTkpPmJNUWfAKe9X1DztAismEkFH5Ow757N3/z15s1FxrjyE
         BYEynyD2+kUnQo+YGnPBI8JQ5VVIqurKodSB27m3hBaTQAyLxvrHIjkfmUWta82KlqU8
         yjAzma+91TI+lX+Fe4pokd6pYD6UMwFKxwFMH3/D47Bd4kLm/23+MrBEzUBZ4G+eSPxs
         RQ+n/aHFsM6gT8m1MNV+1/kiXTc16ZmZw5hEkexk0UcWT1Cn22nY7IMuffdo95Z9AFcM
         GMkw==
X-Forwarded-Encrypted: i=1; AJvYcCWxa/06HkMPzmVn6FMNCv7oufn1OHVwbhvN7hjTfC0WNlDnEZThNjKAEn/CSvOutzv3DY2uMxLPsdBIxhOv6Mp5/kke/HQQgO18eoEhFA==
X-Gm-Message-State: AOJu0YxAZmGzcjJ9we/SgP44UWNA9hvPqnwNiTQvCbeZ6pX8TwhYU40E
	zMMr4lMLWdBGdWmv/3P4Gw5rjZH3W+J5FwPLL2dgEnarV8jQlsGkf8QwgQ6JbOUinkdbZDoR5a7
	DEqxbnMI+f+iIpGcRg5VA59qk4nIZdfQ6EVXiWAmWbRrw0xl7QOULpeA=
X-Google-Smtp-Source: AGHT+IGTgCq9tXwTAcBv0XkMyEOkCP2eIv3Y5VNOhHWc1xhZeAZrHPNWS3QFPeWNq1lSuslJ+IMDkNjaHFvEgqynGXgZZ9zfKE0F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:368:c9e2:b372 with SMTP id
 i2-20020a056e02152200b00368c9e2b372mr124577ilu.0.1714750232241; Fri, 03 May
 2024 08:30:32 -0700 (PDT)
Date: Fri, 03 May 2024 08:30:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078baec06178e6601@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f82450980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3ee5200440e/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c651e70b4ae3/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/196f43b316ad/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com

------------[ cut here ]------------
btree trans held srcu lock (delaying memory reclaim) for 28 seconds
WARNING: CPU: 1 PID: 5195 at fs/bcachefs/btree_iter.c:2873 check_srcu_held_too_long fs/bcachefs/btree_iter.c:2871 [inline]
WARNING: CPU: 1 PID: 5195 at fs/bcachefs/btree_iter.c:2873 bch2_trans_srcu_unlock+0x4f1/0x600 fs/bcachefs/btree_iter.c:2887
Modules linked in:
CPU: 1 PID: 5195 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:check_srcu_held_too_long fs/bcachefs/btree_iter.c:2871 [inline]
RIP: 0010:bch2_trans_srcu_unlock+0x4f1/0x600 fs/bcachefs/btree_iter.c:2887
Code: 2b 1f 48 c1 eb 02 48 b9 c3 f5 28 5c 8f c2 f5 28 48 89 d8 48 f7 e1 48 c1 ea 02 48 c7 c7 40 26 11 8c 48 89 d6 e8 e0 a5 49 fd 90 <0f> 0b 90 90 e9 c0 fe ff ff 44 89 f9 80 e1 07 38 c1 0f 8c 38 fb ff
RSP: 0018:ffffc900042ff1b0 EFLAGS: 00010246
RAX: e963e25abba3d100 RBX: 00000000000002c5 RCX: 0000000000040000
RDX: ffffc9000ade7000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 00000000ffffaff9 R08: ffffffff81588e32 R09: 1ffff110172a519a
R10: dffffc0000000000 R11: ffffed10172a519b R12: dffffc0000000000
R13: 1ffff1100fe0000d R14: 1ffff1100fe00008 R15: ffff88807f000068
FS:  00007f85a17656c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5df13ff000 CR3: 000000007841e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_trans_begin+0x1482/0x1920 fs/bcachefs/btree_iter.c:2963
 __bchfs_fallocate fs/bcachefs/fs-io.c:608 [inline]
 bchfs_fallocate fs/bcachefs/fs-io.c:733 [inline]
 bch2_fallocate_dispatch+0x1181/0x3810 fs/bcachefs/fs-io.c:780
 vfs_fallocate+0x564/0x6c0 fs/open.c:330
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:883
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f85a0a7dd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f85a17650c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f85a0babf80 RCX: 00007f85a0a7dd29
RDX: 0000000020000000 RSI: 0000000040305828 RDI: 000000000000000a
RBP: 00007f85a0aca47e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f85a0babf80 R15: 00007fff348b2c78
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

