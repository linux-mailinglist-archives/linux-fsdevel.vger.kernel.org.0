Return-Path: <linux-fsdevel+bounces-6954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E002081EECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F6CB21939
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7444C66;
	Wed, 27 Dec 2023 12:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FE30641
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ffb5723e9so31472265ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 04:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680285; x=1704285085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEQ4OJoMAkL68WzsnkzhcssQVG8oHv67sa72RlVtyng=;
        b=BUjPhZF3PoaZQYCkG3P3/YGCqxeeBI+noPlBoxMU5qJ1AYo/ApeTSB1blGpihPWi4h
         ewrpGxoXubFg6vhHNb3Xx81f9hdQYpRpXSp2ahDyWXBzHTdpn8FsbB7/xhd/Or4ZVkyV
         qrDfFAZz3URJb8/B+ov6KwzpimcFx72rCyvohkXW8GvbyWUFSUgNSKAL4SiS9+uhtP2u
         vgOxZI5NtsDWdCUBacqoX3IqU+o0S2pebfXWW8E57kzuoH6rZ4jNpTBGkO3dodQJfuGn
         ZS2Gm5E9LNqMnS6IMSfv6WAV2Ieb/JYcSX23vIFkMgQw3yhRO/DIWpJG1x2Q95lJ/XUh
         d2Jg==
X-Gm-Message-State: AOJu0YxgpsG1bZs+eFDQZWqbwmlhenm2YpJk0ZLf7JQmXlDtn4gtIWjQ
	zL1IHhIW9y1R6wLdmO79SgXqUZC/nTCsijaJj2BYEpHyLAdL
X-Google-Smtp-Source: AGHT+IG3QcHBucRp6fJ0eMJKQWSeRMf7Bo6Sb6k7FZV9SWOJsaaMs8xbYRczBh+K/d8ZgOc76cldXvVaDQDjxLvM5q6dr3IUFmTZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c8aa:b526 with SMTP id
 i12-20020a056e021d0c00b0035fc8aab526mr1144470ila.2.1703680284955; Wed, 27 Dec
 2023 04:31:24 -0800 (PST)
Date: Wed, 27 Dec 2023 04:31:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000321c24060d7cfa1c@google.com>
Subject: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b0a595e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169fac19e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aafc81e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fcf70b38bafb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs: (device loop0): mounted with root inode @ nid 36.
erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
 z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
 z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
 z_erofs_runqueue+0x36cd/0x3830
 z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
 filemap_read_folio+0xce/0x370 mm/filemap.c:2323
 do_read_cache_folio+0x3b4/0x11e0 mm/filemap.c:3691
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 do_read_cache_folio+0x163/0x11e0 mm/filemap.c:3655
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5006 Comm: syz-executor342 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
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

