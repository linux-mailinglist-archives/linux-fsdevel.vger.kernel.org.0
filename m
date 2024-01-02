Return-Path: <linux-fsdevel+bounces-7082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5216821A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D35B21B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C09DDBA;
	Tue,  2 Jan 2024 10:48:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D099D52C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bb582f9d5eso378075539f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 02:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192507; x=1704797307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4CtPSwPat2z45nJUvAmqy/UgHsZXuHsoz6P7tj1Uj0=;
        b=DLmZ/13fRcTZN16uKAdIENAjS7YWOHFhQpi0gDgwmiGG4i3tbkzztDCq9PSwZR2GW3
         YjwiOURoIzdJYN8ZSKHMMlp6/oFAigdpS9cHKuA12whiMClefU9TrpEMMaZezkUIYPKu
         SO2+W18gBxHMX8bblI4d4I0E1YHSL6HVRPKAPiN1fBOIAAH0nnnsgcEHUEA+JhlIJfhR
         cDBbOXYDx4GHMA08YcrpHTCZJ5iFavulUfqUiep220rkvUB6gmD4rTv7PwRYR0iUilkN
         OxsqbD3QSsfkdOVlOL0qSLPKsYJUVpHOE0+ZmwDhD2wmQDhJzG3kfGmINltkmQnLhw7R
         0JXQ==
X-Gm-Message-State: AOJu0Ywz2KZ5IQO42bu975d+CR7uZu2BnAd4SyKtaiBnyKv1HZfvDE2j
	tU578css3hGXHKKGAq4ymHjwO++d5yfegPiSqgu3gaAQHpwJ
X-Google-Smtp-Source: AGHT+IH/0Jj8MdFM6JkhOV64hzFB7quujrB1hcBHgbHM/+P853wj8JGYB+Rdq8kK+Yyxr6Ekb4C0JK7XGHgdyMwyvMrCbfbCj/0R
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:35f:f683:fa1c with SMTP id
 f12-20020a056e020b4c00b0035ff683fa1cmr1862047ilu.5.1704192507723; Tue, 02 Jan
 2024 02:48:27 -0800 (PST)
Date: Tue, 02 Jan 2024 02:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d480b060df43de5@google.com>
Subject: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
From: syzbot <syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e43009e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:224 [inline]
 nilfs_add_checksums_on_logs+0xbe4/0xf60 fs/nilfs2/segbuf.c:327
 nilfs_segctor_do_construct+0x9eff/0xe050 fs/nilfs2/segment.c:2112
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2415
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2523 [inline]
 nilfs_segctor_thread+0xc3f/0x11d0 fs/nilfs2/segment.c:2606
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
 pagecache_get_page+0x4a/0x1a0 mm/folio-compat.c:99
 grab_cache_page_write_begin+0x55/0x70 mm/folio-compat.c:109
 block_write_begin+0x4f/0x450 fs/buffer.c:2223
 nilfs_write_begin+0xfc/0x200 fs/nilfs2/inode.c:261
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4013
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4039
 __kernel_write_iter+0x329/0x930 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x593/0xcd0 fs/coredump.c:915
 elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
 do_coredump+0x32c9/0x4920 fs/coredump.c:764
 get_signal+0x2185/0x2d10 kernel/signal.c:2890
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
 irqentry_exit+0x16/0x40 kernel/entry/common.c:412
 exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570

CPU: 1 PID: 5307 Comm: segctord Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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

