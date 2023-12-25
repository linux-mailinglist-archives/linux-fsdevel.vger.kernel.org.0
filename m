Return-Path: <linux-fsdevel+bounces-6905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A077E81E251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 21:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467ECB2179F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2B53819;
	Mon, 25 Dec 2023 20:28:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AC53809
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc8389a58so50706285ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 12:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703536102; x=1704140902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fRKrD7CHZyW03bk3aSpJq2vu0NdTFDfPVJs4+ApOJI=;
        b=L/RMTXsHk4VxaNgfNUvbCYDtfhk9l1t7E80u7+lPHFgwX28duhtegELH1GHHWkA6rt
         2r2Ad8MvN6s6EcSYRqZKMyP4cs5IAMc3uF+0ElA7kDVtS5l6WEJm5pLG0lyNacbR/sQf
         gUTuVZaXO+Ok9VrGF+r0O7jeITY/r+VPk+nQburZqeRVzSl4cSfhWrVMjTJLHNMY6R/2
         r3ubWOyx8Fj+HyTkY66MrAGbSMMZD9cvIfcc55u1X0YBYeKP5DXdxbmw4GeJmy5Ehy4n
         lCjS222Gg/ugrz0w5g40NHkFQnp7gUmJ90LR1vyL9pj4Y/FBgphWRa0RPiPeXvS3XHNR
         SRHw==
X-Gm-Message-State: AOJu0YzW9Ok2GOGkW/kmSMFJhoAyG76TIcs1Y7oqtYJgV5DEvZ9MZBxd
	NNwMSgClb/7FGj5BXsXLv7Xtt0N4EkXk3nLtdyx1hYmswcTV
X-Google-Smtp-Source: AGHT+IFiqXWV6QzTYsZAA7yzqDNorN8tNKBhEZOjIolzPCnE/mnVZKGZhi0nDsMt8JGKHDqBb96ZdlJimsme/6rzcSsTOmCA+qfP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:d4dc:1b1e with SMTP id
 i12-20020a056e021d0c00b0035fd4dc1b1emr1074185ila.5.1703536102687; Mon, 25 Dec
 2023 12:28:22 -0800 (PST)
Date: Mon, 25 Dec 2023 12:28:22 -0800
In-Reply-To: <0000000000002d868805ec92cbf0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000434c71060d5b6808@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: slab-out-of-bounds Read in
 search_by_key (2)
From: syzbot <syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121f1609e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10557e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14206fd6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/445a7c3f980d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com

REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
=====================================================
BUG: KMSAN: uninit-value in comp_keys fs/reiserfs/stree.c:83 [inline]
BUG: KMSAN: uninit-value in bin_search fs/reiserfs/stree.c:173 [inline]
BUG: KMSAN: uninit-value in search_by_key+0x3293/0x6780 fs/reiserfs/stree.c:770
 comp_keys fs/reiserfs/stree.c:83 [inline]
 bin_search fs/reiserfs/stree.c:173 [inline]
 search_by_key+0x3293/0x6780 fs/reiserfs/stree.c:770
 reiserfs_delete_solid_item+0x4ec/0xe90 fs/reiserfs/stree.c:1419
 remove_save_link+0x2ed/0x420 fs/reiserfs/super.c:540
 reiserfs_truncate_file+0xd00/0x1b70 fs/reiserfs/inode.c:2314
 reiserfs_setattr+0x1b79/0x1ee0 fs/reiserfs/inode.c:3388
 notify_change+0x19fd/0x1af0 fs/attr.c:499
 do_truncate+0x22a/0x2a0 fs/open.c:66
 do_sys_ftruncate+0x81c/0xb30 fs/open.c:194
 __do_sys_ftruncate fs/open.c:205 [inline]
 __se_sys_ftruncate fs/open.c:203 [inline]
 __x64_sys_ftruncate+0x71/0xa0 fs/open.c:203
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable cpu_key created at:
 reiserfs_delete_solid_item+0xbf/0xe90 fs/reiserfs/stree.c:1410
 remove_save_link+0x2ed/0x420 fs/reiserfs/super.c:540

CPU: 0 PID: 5006 Comm: syz-executor429 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

