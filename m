Return-Path: <linux-fsdevel+bounces-28910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BC9706F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0073228162C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAE157E91;
	Sun,  8 Sep 2024 11:34:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB5156F41
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Sep 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795265; cv=none; b=uxC+OJAAgnOVd3xCPuk6Bm3XxhR0jqEqeL8itLjHTxMB7MmLzKfLy1w89a1//ZC4G043LOBZbx2WOii3KKYScb4IHLdZe2Si9qm1vRHVn6rZNBFWgVCd/GKa73oS1idvVZqKXaVp1nDNBjVvj4SYqeMb9JAV5+Dt3FzmHJL5kaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795265; c=relaxed/simple;
	bh=/Xh8WI8DrM0WgcNjfV1N+w3yIHvEJX6uEl/GDnSjjgw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W2F+QiwVlbawXF0otRJPFIZNmPSuEltyZkWuzz2z4kcRblGfkc7FLNqtYkxcdhBWB7sR8rdekI9i3wH/lbOW2LoxcwL+2MnGHTh9eeQFe2vWwuNjp75QRFu2IZwL/o4R85S9FzLsX+NURgrdJWUgrtxNEi54DAtsBAzuFL4DIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so63378445ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2024 04:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795263; x=1726400063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQJqLe5gOilYbtWQRHW73MpTdXn87Rs1z9P3F3h4QoI=;
        b=ONgFFxrz6fzy59hHf/2p+eioSB7/iciQxlY1vAmeBWTA7GgrRcDXWcqw25Js2rnRvM
         MQAEIsvGLwl/ooU1fTNylpiW42HtPKiHueCkzzF8y8K4l4FvA6E0Vi85P0lSFQTsq5r5
         231xaY5HXmU8J7ypcNryQ9cwNx4Q8izggY07EgQn/OVeYk92T4OIf6aUoB8WW+3P0zIT
         364PKxHNjxLg7oYjEkg+cwY9WDEqWEAlDo2je6ZxSicm0/Px6mAAPrLl+Iioda0zfIR1
         YBnBnnUp5txSJh4h1SKKd6BuxouVw840jkqG9VO1zeMl68ONzkrFz2t/Ea/hjlzdbFWR
         HrxQ==
X-Gm-Message-State: AOJu0YwnWuQjNoKXFGBLoAGffIf/2Usg8UzwwZnCHCZJdk+O7Y8GJZDX
	NHayd+Vopf8YbS1FhRROXZaAbclN0sRhxKP8BqBQM6HvQUas9yIQvtH4yMnwLT/qp1JaGCHdatd
	cydBL0DaOrOhyjf5/94sQwIby6PpaPIvza3rfg2tvGDrHmnfRM5bMhls=
X-Google-Smtp-Source: AGHT+IFvxJJN0rABiEX4KHr1m4mvasQ48MP3SQX0gGl2Kz4p7SerANvHWedVKOxWJ0vGKx3d4B8uPz+4YVFwA8nWKcO1LPsCkFPp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c544:0:b0:39f:d6a9:a6b9 with SMTP id
 e9e14a558f8ab-3a0568ab181mr42470295ab.24.1725795262931; Sun, 08 Sep 2024
 04:34:22 -0700 (PDT)
Date: Sun, 08 Sep 2024 04:34:22 -0700
In-Reply-To: <00000000000047bf6a061d976fdb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a38c906219a056f@google.com>
Subject: Re: [syzbot] [hfs?] WARNING: ODEBUG bug in hfsplus_fill_super (3)
From: syzbot <syzbot+dd02382b022192737ea3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147f1ffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=dd02382b022192737ea3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b6589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127f1ffb980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b52ee4d6014/disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3409402d9dfd/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7da5cc92617b/bzImage-d1f2d51b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/73e23808204f/mount_3.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0d235c82b3b0/mount_19.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd02382b022192737ea3@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807c180238 object type: timer_list hint: delayed_sync_fs+0x0/0xf0
WARNING: CPU: 0 PID: 5700 at lib/debugobjects.c:518 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Modules linked in:
CPU: 0 UID: 0 PID: 5700 Comm: syz-executor651 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Code: e8 0b 84 40 fd 4c 8b 0b 48 c7 c7 40 98 60 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 fb 60 9b fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 ec 59 5e 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000324f5b8 EFLAGS: 00010286
RAX: 098b313f44a3ce00 RBX: ffffffff8c0cc1a0 RCX: ffff888027455a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c6099c0 R08: ffffffff8155b372 R09: fffffbfff1cfa0e0
R10: dffffc0000000000 R11: fffffbfff1cfa0e0 R12: 0000000000000000
R13: ffffffff8c6098d8 R14: dffffc0000000000 R15: ffff88807c180238
FS:  00007f7e074f76c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000680 CR3: 0000000024282000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:990 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1020
 slab_free_hook mm/slub.c:2223 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x10f/0x360 mm/slub.c:4598
 hfsplus_fill_super+0xf25/0x1ca0 fs/hfsplus/super.c:618
 mount_bdev+0x20c/0x2d0 fs/super.c:1679
 legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
 vfs_get_tree+0x92/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e0756d80a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 ee 08 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e074f6f98 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020002900 RCX: 00007f7e0756d80a
RDX: 0000000020000100 RSI: 0000000020002900 RDI: 00007f7e074f6ff0
RBP: 0000000020000100 R08: 00007f7e074f7030 R09: 00000000000006ca
R10: 0000000002000010 R11: 0000000000000286 R12: 00007f7e074f6ff0
R13: 00007f7e074f7030 R14: 00000000000006d0 R15: 00000000200022c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

