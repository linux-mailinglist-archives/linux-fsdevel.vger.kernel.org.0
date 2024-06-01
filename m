Return-Path: <linux-fsdevel+bounces-20706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C08D6F8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBB6283C42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B314F9C8;
	Sat,  1 Jun 2024 11:50:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63C1E4B0
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jun 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717242629; cv=none; b=gRaDzx5Vbx7Ctzb2hGdsJ8IYA2LHHQ7rswYK0QsyeKZOVQYWL2oBq4PAJBIGuAAbbVfPW5np4kZdP+JeDKO5+RMLg1cz9IRSZ4Cyc5/tIVzET8iikSzQjI/4F2EdFcFBd7VGLAmjsW2mMtK0XUnjNA/F5M+AJXhGFGJbS6VObbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717242629; c=relaxed/simple;
	bh=sz/Pny8FM86qTgj8n/lge9wgc8vp99x0ePnz29Ftf70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aRnPzmh0xU9mAqM/10/vb/d5FjDeNio1/mrrBC0vEIzPBgC1yr+I/7MgN38E2cBC7KvLRaZEMMaXGdNibJIvyHqys6jTvfkENDaRryBrlMl7HOniW5zfpUBKAkGMp3v/DZEZuAA59qSsEOdqVYlDCLcvpapWNJPdQaYgcG3Q9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso350369339f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jun 2024 04:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717242627; x=1717847427;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nhwM4GXqjdtOIKde8twxoOQTnsBpiNgrRNHNeDdmjk=;
        b=M/e1V+Di6EDmMnAEMWItjU11f/Fi03Vud3arOMJKN2oQcnqXhxyKHVg8sPZ40x4jCT
         834i5NpsEpvZGLFOt12maeXQ0AXXPHse9ruQxQp3dRpBGsMjxsi03IVMMnAM164fejCx
         SmJm5ZXKe9m59987GWBSYZvvF4fDl14oValb5LbZzlNdFOfH+5XgnX/6u26ZAtqzGIFJ
         wJxdRXqe2fproGX1quUChLoeKu9wu3Gan7+fS0YlhBRWOwKj0QM/+aT7EZaZYMCVFb2b
         7GiLEcerw+4fyP5jE1Q5WCplwnkQ86g2kan/ysDlco+lc3/xjb/NvkNXkqCP1+t3T7MS
         sxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhxp+Y/ua9NcJ4EYP4XDS2qs6OdcN0UcNPZ7AW2lfVrPZiGr6hCj+E9nO9kGkNeG/DheoudRkGqSaOqIkLQrgDh8/DqmXZVRCdKfH70w==
X-Gm-Message-State: AOJu0YywRi/uoKewQqvdDcJqvozAac+F0KM5CykHTCn7n7/G7Pl/V6hl
	zU+ABOiCZBrIbl9+nBgZwZ5nV0PxI2lDfOT/RJDzBdH0R68TDBiAR/5GVeevq0dHPebgUj7zG0d
	eTnaaQFESynG+AaV9dCYeoQ0BKHEmM7rIXeordPiaI3jp6s28OrSjqPw=
X-Google-Smtp-Source: AGHT+IH7wfe+za0EdvFAvcEtXmC3MHXDRTeOcLV3gfUwDXXTtb42zCMIid46qJeJcAgjoeKsgsH/gOnyLi9RzISxfD4A1MvMQC6M
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168c:b0:7e2:30a3:bd13 with SMTP id
 ca18e2360f4ac-7eafff67c45mr33191739f.4.1717242627670; Sat, 01 Jun 2024
 04:50:27 -0700 (PDT)
Date: Sat, 01 Jun 2024 04:50:27 -0700
In-Reply-To: <000000000000d103ce06174d7ec3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0d5e20619d2b486@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0e1980c40b6e Add linux-next specific files for 20240531
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146c33d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a9aabc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d86426980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44fb1d8b5978/disk-0e1980c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a66ce5caf0b2/vmlinux-0e1980c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8992fc8fe046/bzImage-0e1980c4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/72a0fa392581/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com

F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
------------[ cut here ]------------
kernel BUG at fs/f2fs/inline.c:258!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5090 Comm: syz-executor430 Not tainted 6.10.0-rc1-next-20240531-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 ff a4 09 fe e9 d6 fc ff ff e8 25 22 9a 07 e8 a0 b7 a3 fd 90 <0f> 0b e8 98 b7 a3 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000343eb00 EFLAGS: 00010293
RAX: ffffffff83f2c450 RBX: 0000000000000001 RCX: ffff88807f750000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000343ec30 R08: ffffffff83f2bf15 R09: 1ffff1100f0ed1ad
R10: dffffc0000000000 R11: ffffed100f0ed1ae R12: ffffc9000343eb88
R13: 1ffff1100f0ed1ad R14: ffffc9000343eb80 R15: ffffc9000343eb90
FS:  000055557674e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000001fb2e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2858
 f2fs_write_cache_pages fs/f2fs/data.c:3157 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3312 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3339
 do_writepages+0x35d/0x870 mm/page-writeback.c:2657
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
 f2fs_do_sync_file+0x68a/0x1b10 fs/f2fs/file.c:276
 generic_write_sync include/linux/fs.h:2810 [inline]
 f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4935
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd453a5f779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc94e03488 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffc94e03658 RCX: 00007fd453a5f779
RDX: 0000000000002000 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 00007fd453ad8610 R08: 00007ffc94e03658 R09: 00007ffc94e03658
R10: 00007ffc94e03658 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc94e03648 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 ff a4 09 fe e9 d6 fc ff ff e8 25 22 9a 07 e8 a0 b7 a3 fd 90 <0f> 0b e8 98 b7 a3 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000343eb00 EFLAGS: 00010293
RAX: ffffffff83f2c450 RBX: 0000000000000001 RCX: ffff88807f750000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000343ec30 R08: ffffffff83f2bf15 R09: 1ffff1100f0ed1ad
R10: dffffc0000000000 R11: ffffed100f0ed1ae R12: ffffc9000343eb88
R13: 1ffff1100f0ed1ad R14: ffffc9000343eb80 R15: ffffc9000343eb90
FS:  000055557674e380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056082271e438 CR3: 000000001fb2e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

