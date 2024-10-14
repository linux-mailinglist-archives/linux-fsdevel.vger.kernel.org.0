Return-Path: <linux-fsdevel+bounces-31834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB899BFCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50331C21F99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180413D893;
	Mon, 14 Oct 2024 06:09:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A917BCE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886168; cv=none; b=sjPjmf02zbAmAsco7c33U5rvwpuiYbRi/vB4HCfYoNRclzCNlQ52F0HrNJOOx2rKLPDRJC3ilOtgIDkmyVMXUQgvtWFbLl0qGtmmNW2rnp8VDxLOOxBkFES0IuKDmyS3l5y+kWf+YDtESov7fqbWhADJj5G9xOE4vJ6EzOvPifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886168; c=relaxed/simple;
	bh=IleWPMl4f2R84lOyvluflgeYB1LOZt+fD2PzHIvAJSU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ke1BoHkRrDON1Px4HX1Ct+7t5zyH8EKYCJS9QfFrERtseN4fbIkWSliobmIn0shSqBs0wJqqoaqFXBVi17UUGkvnyicw1eMRLgGPyrCxTIJ2eH+4s7CSyHlFYUx67JGfgROSGuPZ1AIPQ4U9jD+g3qBlAYTF0T0Uj60ijVZmzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bea901ffso28865325ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886165; x=1729490965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wQiWlq4yH2O6lhbszuVPwvf6IBAxvm5byuyLUfh3V4=;
        b=Z//DS/QOe4ujf/+ujNSVY3Lub65JD6/HzbPzBa/Y6Hp/l4wz6/etjDbLU6kdUC3tfp
         O0xQRPmmwTH3jAJ5LVwlJIL2eveDHd/xIXcWU/u3iNA++KEk6+GTgbxMdRwv7ZsQ07sN
         odXG35Hmhc+wakAcAbZS5MQDLe37bciiR125CiXcdfNdBLnwKUQaKdVvDUiqk0NwW470
         JCFT4xLCoBZcyNKGkI0oE/bywAZNBI4/T0HZlrEN1i0mkuwWsdih82d6QJi/lKj16xpZ
         ifbL8MH997dNymB8VdIP6bVFw43XFAbCApQTy4Ia5GpGsgLlPazvI184GMePpmZdkxtY
         D2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVY6yliZbanWLMxHNWvNlPI5Bv+CA+W/Ro2ORZnDWS/LHa+RahXoXwiW1hPVAvOkipPna26FQg5Utw637/v@vger.kernel.org
X-Gm-Message-State: AOJu0YziWK62/xsfiGyHTN3l6FbzPQHAQTMDAQUuDxuqJHKTO/BUJ6uj
	/P5cFb6t07tS8e5VwkuKYNw95uygxu0Rx9YkYVHX4qaohDHPl00bUbIGE1fFbBRdPMSjSaS3xrR
	4+IjcFk6kdMqBGm7J4KoXfUIUW0vnO0PVduLj7FGZTxMSkYKWBeVpT6s=
X-Google-Smtp-Source: AGHT+IH43XkxgpxH+6sUUzn6+IHpr7XAZI2ztetGzkU0CdO0qwlAvK9MvMPr9POKFDlnLCjNzqHz80lhpM7+2pkS7TbFrqFXZWOT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a3bce159bbmr56920315ab.25.1728886165301; Sun, 13 Oct 2024
 23:09:25 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb595.050a0220.4cbc0.0044.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in xas_find_marked /
 xas_init_marks (4)
From: syzbot <syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09f6b0c8904b Merge tag 'linux_kselftest-fixes-6.12-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1777705f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd28f0c6293cc87d462
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bab2dba03669/disk-09f6b0c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef90b6468079/vmlinux-09f6b0c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5674cb34660a/bzImage-09f6b0c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in xas_find_marked / xas_init_marks

read-write to 0xffff8881068ba480 of 8 bytes by task 7376 on cpu 0:
 instrument_read_write include/linux/instrumented.h:55 [inline]
 __instrument_read_write_bitop include/asm-generic/bitops/instrumented-non-atomic.h:84 [inline]
 ___test_and_clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:114 [inline]
 node_clear_mark lib/xarray.c:102 [inline]
 xas_clear_mark lib/xarray.c:915 [inline]
 xas_init_marks+0x17e/0x320 lib/xarray.c:948
 xas_store+0x213/0xc90 lib/xarray.c:810
 page_cache_delete_batch mm/filemap.c:322 [inline]
 delete_from_page_cache_batch+0x31c/0x700 mm/filemap.c:344
 truncate_inode_pages_range+0x1c5/0x6b0 mm/truncate.c:343
 truncate_inode_pages mm/truncate.c:423 [inline]
 truncate_pagecache mm/truncate.c:727 [inline]
 truncate_setsize+0x9b/0xc0 mm/truncate.c:752
 fat_setattr+0x720/0x840 fs/fat/file.c:550
 notify_change+0x85c/0x8e0 fs/attr.c:503
 do_truncate+0x116/0x160 fs/open.c:65
 handle_truncate fs/namei.c:3395 [inline]
 do_open fs/namei.c:3778 [inline]
 path_openat+0x1c03/0x1fa0 fs/namei.c:3933
 do_filp_open+0xf7/0x200 fs/namei.c:3960
 do_sys_openat2+0xab/0x120 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1441
 x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881068ba480 of 8 bytes by task 7358 on cpu 1:
 xas_find_chunk include/linux/xarray.h:1733 [inline]
 xas_find_marked+0x216/0x660 lib/xarray.c:1370
 find_get_entry+0x54/0x390 mm/filemap.c:1994
 filemap_get_folios_tag+0x136/0x210 mm/filemap.c:2261
 writeback_get_folio mm/page-writeback.c:2489 [inline]
 writeback_iter+0x4b0/0x830 mm/page-writeback.c:2590
 write_cache_pages+0xad/0x100 mm/page-writeback.c:2639
 mpage_writepages+0x72/0xf0 fs/mpage.c:666
 fat_writepages+0x24/0x30 fs/fat/inode.c:199
 do_writepages+0x1d8/0x480 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0xdb/0x100 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 file_write_and_wait_range+0xc4/0x250 mm/filemap.c:788
 __generic_file_fsync+0x46/0x140 fs/libfs.c:1528
 fat_file_fsync+0x46/0x100 fs/fat/file.c:191
 vfs_fsync_range+0x116/0x130 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2871 [inline]
 generic_file_write_iter+0x185/0x1c0 mm/filemap.c:4185
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0x76a/0x910 fs/read_write.c:683
 ksys_write+0xeb/0x1b0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:745
 x64_sys_call+0x27dd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffffffffffffff -> 0xfffffffffff00000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 7358 Comm: syz.0.1306 Not tainted 6.12.0-rc2-syzkaller-00291-g09f6b0c8904b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

