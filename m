Return-Path: <linux-fsdevel+bounces-73273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A78D13CE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6533D305378D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F4364029;
	Mon, 12 Jan 2026 15:49:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261D34EF1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232970; cv=none; b=GITDkDiBTft4sszAV34inpEcfori6AZSdqhChVDd0r8UTFrFoN/cuxtKvvXDFgVyRbkG6ooZ8/xFWsVq7V3f4QWBt11NvFgVyZKd8Rar08dnZJY9TRLnJUdA2/ep1OIm5z+NrJAxOsy3x3fMInmhXbNwUYDEo/YfDpEecFtNYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232970; c=relaxed/simple;
	bh=N93ey8vVHcWsChIb+DblX69PWKUwcPurbNGXL80RcJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V7Yy8KTGha1fKtHWivy20myBZ9DjLQXaI9kG7Fvqdq7F73iljOsKj2o+vwBrv9IkpDaby6VQo5ZZz/+6hlFaGbXt2eb+iio2TD75FwF75ihUpVQNSEkrIYwlBy0pvUY05vx72bO6UwukJ1+XRpVLHVnURD2UPnehdrl3afB8poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656b7cf5c66so13525463eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 07:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232968; x=1768837768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oheAw3KMUyvNFulLpRmJc/EKq1G1fIdKBIMxKApk1N4=;
        b=P9Cy8MP4+2+c9/4vysx2aSfFS7RSkloDfRHTd4QbBk56iWZ6dgR5A1df4cIey4ttCY
         a1hTN/Tn9AcZk3TnIKFNKP38BgtCJGtTUKjZkIblWc2ANCPe96XgHytxxYqNd5+Ca4Bc
         UtMkKLH0cOIU2YOoF94YjjG7cnb3rqfsyNOvMov1atqu1Up6/jxCzMcUgb8NzSdZ1dBd
         brN4pWuUqiacZOWshoIgdRroexTFKGKGBnDSq4GomgvX7QZMNAW4p1/JHf+qZbKvJdkt
         oA2mTaOnAaEECKuwev1jiwRbJvHTArCYxirVtWP+EAQGjt64RAhy70FmKP6wtkdOf/T9
         jxOw==
X-Forwarded-Encrypted: i=1; AJvYcCX6DQAlCUrze5SqwgkEe/QvjcW6/wcgQB1Zq6iRERCbZG/N7JtNXxQHbh0kAVnrCnONqayLXPMFh3+4qm9A@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdTyuqXXEihRkT9//XI79gJdNvtGvCnnw9vnHlfKjsyDtja0A
	HmZT1eAWfQ1xI+C8MU40O1scyddrfiU+UDgGPi5f+3ahMp7fMtTW2f10RslS45FupHYb1N0VKCL
	nQMnUiy5UScxGHg+jQmv//eqvbem9V9EcuyhHBK3/z6jczL96c6vsjiirV50=
X-Google-Smtp-Source: AGHT+IFf6leUBJjbkBpsYvPoDY3o2f4osfp/aUN7ltsOOKhm/TmKzQ2xg51uGHEXChGoVsJURvaPRifE7CkONWEGA62NuQ9DTt4N
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d4c5:0:b0:65e:e8a0:3d74 with SMTP id
 006d021491bc7-65f550a5736mr7266291eaf.65.1768232968151; Mon, 12 Jan 2026
 07:49:28 -0800 (PST)
Date: Mon, 12 Jan 2026 07:49:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69651808.050a0220.eaf7.00b3.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in msdos_rmdir
From: syzbot <syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c7ef209cd0f Merge tag 'char-misc-6.19-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cfec3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
dashboard link: https://syzkaller.appspot.com/bug?extid=66d24939ab3817bd81d0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d50052580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16efd9fc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4fb19edb55d0/disk-9c7ef209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b4c89c27788/vmlinux-9c7ef209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a728d410d528/bzImage-9c7ef209.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/83e4f46f8575/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17550052580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/inode.c:417 at drop_nlink+0xc5/0x110 fs/inode.c:417, CPU#1: syz-executor/5973
Modules linked in:
CPU: 1 UID: 0 PID: 5973 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: c0 08 00 00 be 08 00 00 00 e8 67 f9 eb ff f0 48 ff 83 c0 08 00 00 5b 41 5c 41 5e 41 5f 5d e9 42 90 9f 08 cc e8 1c bd 89 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc90004877bf0 EFLAGS: 00010293
RAX: ffffffff8235efa4 RBX: ffff8880589f9d30 RCX: ffff8880274f3c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1db66cf R12: 1ffff1100b13f3af
R13: ffff8880589f9d30 R14: ffff8880589f9d78 R15: dffffc0000000000
FS:  000055559129d500(0000) GS:ffff888126dee000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555912d86c8 CR3: 0000000038956000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 msdos_rmdir+0x3ca/0x4e0 fs/fat/namei_msdos.c:328
 vfs_rmdir+0x51b/0x670 fs/namei.c:5245
 do_rmdir+0x27f/0x4a0 fs/namei.c:5300
 __do_sys_unlinkat fs/namei.c:5477 [inline]
 __se_sys_unlinkat fs/namei.c:5471 [inline]
 __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:5471
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0f8e67ed27
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff98601628 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f0f8e67ed27
RDX: 0000000000000200 RSI: 00007fff986027d0 RDI: 00000000ffffff9c
RBP: 00007f0f8e703d7d R08: 00005555912c86ab R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000207 R12: 00007fff986027d0
R13: 00007f0f8e703d7d R14: 000000000001a887 R15: 00007fff98605a80
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

