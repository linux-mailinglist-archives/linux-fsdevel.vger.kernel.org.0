Return-Path: <linux-fsdevel+bounces-31832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F499BFB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054EB282980
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751B13D25E;
	Mon, 14 Oct 2024 06:02:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F02535D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885752; cv=none; b=mbseUNVs17rk+j4j6auECMCVZXQWhFpvmV5dMaVWBvpxb7dTYzTre/YPKh8+pPjmAvjEia1r/yHvyWe8soiF4WpAVZEKXsKcZJKXGfUICJBTO39Bmw/i2lsC+RFl694qZs0KL+OImsWk80ojQWSff9cm+c6KG3it+n4pqbDNkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885752; c=relaxed/simple;
	bh=VTQjeEwXtfXioqisg6vo//72HypeLanuVOl2X8d02LY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aixDi/iq+ZkqvJCbTU6Nne+U6M6R3uuiYuCriN5d+pNjCHGeW9WhWiflbr2FIEw2dQ9yGoVjU+A3tsMuyC/M+KMAYFbYcphaVcDxLJNd3ogJucRo5QmZ5IXEVcpTRyFkrK2MU5ehi3i2LNmlRR4Lc+Wt8oe4ucZQljatU1kjytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so30580065ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 23:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728885750; x=1729490550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OEGnh+TLNzpab0Pk6rtPrbnmLbt2N4whgVYuchqjdQ=;
        b=bjoQycsdb0ZixtK2JIWYWrxdm91RHs7Pf1Gpg+cZ6r19iCbYZ4vuSRfRUXv7JaOWj6
         XYRqCKHxD/RfI7O0Mc8eSSsNFUwPh3InXD4Btv9FWGi+zXNWqaC4x8UW5WjgfMonZ17h
         GzrBnQgPYgzAZiG7izDYi19WVWklTQwizsI274Fok/WioLXuHVW0jfARuAMF8bX87Rd+
         j6iW0wWeIqtWkm87HUB8B+2z+K2Emw/xKgNyf6lh0zjs4GY+7Ev+VAHkQcwAtX+8/mZv
         jm5YyP5TE6qcTrqhC3+2cn248kHV541JtJ9/G4qcIH08KWKHYIwOmBwIi+8TDO3cQs3H
         eIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZWIoIzmfOgx4h9Jw3mVMyyQJsrKBMXdzxfGv8Fqbj14lVnw/WN0AlIhekQY351IF2fSKfY+Xww/Ew4tKk@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3rgzV5+Pxdhcmvz/UBNjwK2YbzGsOXMI0RxP8JSJfNYYd28c
	Ve0M1HTizhIY+llBokmZz12OnQH2jRjXYxC4D0cp3770uq0Vkc/hoahB6JiZorCiHCrXIeNXRqO
	5NPuAwfLSTS3s3EkH0MUTKaj6jrdF6RdLhba+7GLHlddFX0yCgSA0xuU=
X-Google-Smtp-Source: AGHT+IH2IAdfJfXQKMNzELnbbHtmHfDznY26Zbt7HsSorVqBYWNxIhnjpETIXkizIfPQQ5UnhXfhLDwcmU2KyC1oDXioq2tMYvP2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3a3:b4ec:b3ea with SMTP id
 e9e14a558f8ab-3a3b5fb2f8dmr65359865ab.16.1728885750161; Sun, 13 Oct 2024
 23:02:30 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in submit_bh_wbc (3)
From: syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6485cf5ea253 Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142f585f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=985ada84bf055a575c07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f39f2ba63ff0/disk-6485cf5e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b68f3c352ce/vmlinux-6485cf5e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38070176e828/bzImage-6485cf5e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:2785!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5968 Comm: syz.0.65 Not tainted 6.12.0-rc3-syzkaller-00007-g6485cf5ea253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
Code: 89 fa e8 dd d7 cb 02 e9 95 fe ff ff e8 63 9b 74 ff 90 0f 0b e8 5b 9b 74 ff 90 0f 0b e8 53 9b 74 ff 90 0f 0b e8 4b 9b 74 ff 90 <0f> 0b e8 43 9b 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000303e9f8 EFLAGS: 00010287
RAX: ffffffff82204bb5 RBX: 0000000000000154 RCX: 0000000000040000
RDX: ffffc900044b1000 RSI: 0000000000000a81 RDI: 0000000000000a82
RBP: 0000000000000100 R08: ffffffff82204779 R09: 1ffff1100ae83f79
R10: dffffc0000000000 R11: ffffed100ae83f7a R12: 0000000000000000
R13: ffff88805741fbc8 R14: 0000000000000000 R15: 1ffff1100ae83f79
FS:  00007fbfb2dcc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08b6361160 CR3: 000000005f354000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 submit_bh fs/buffer.c:2824 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
 do_mpage_readpage+0x1a73/0x1c80 fs/mpage.c:317
 mpage_read_folio+0x108/0x1e0 fs/mpage.c:392
 filemap_read_folio+0x14b/0x630 mm/filemap.c:2367
 do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 nilfs_get_folio+0x4b/0x240 fs/nilfs2/dir.c:190
 nilfs_find_entry+0x138/0x650 fs/nilfs2/dir.c:313
 nilfs_inode_by_name+0xa8/0x210 fs/nilfs2/dir.c:393
 nilfs_lookup+0x76/0x110 fs/nilfs2/namei.c:62
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1732
 lookup_slow fs/namei.c:1749 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2912
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0x5d8/0x2a60 fs/overlayfs/namei.c:1068
 lookup_open fs/namei.c:3573 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfb1f7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbfb2dcc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fbfb2135f80 RCX: 00007fbfb1f7dff9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fbfb1ff0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbfb2135f80 R15: 00007ffe859206a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
Code: 89 fa e8 dd d7 cb 02 e9 95 fe ff ff e8 63 9b 74 ff 90 0f 0b e8 5b 9b 74 ff 90 0f 0b e8 53 9b 74 ff 90 0f 0b e8 4b 9b 74 ff 90 <0f> 0b e8 43 9b 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000303e9f8 EFLAGS: 00010287
RAX: ffffffff82204bb5 RBX: 0000000000000154 RCX: 0000000000040000
RDX: ffffc900044b1000 RSI: 0000000000000a81 RDI: 0000000000000a82
RBP: 0000000000000100 R08: ffffffff82204779 R09: 1ffff1100ae83f79
R10: dffffc0000000000 R11: ffffed100ae83f7a R12: 0000000000000000
R13: ffff88805741fbc8 R14: 0000000000000000 R15: 1ffff1100ae83f79
FS:  00007fbfb2dcc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08b6361160 CR3: 000000005f354000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

