Return-Path: <linux-fsdevel+bounces-43574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24367A58FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CA16BD8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5422579F;
	Mon, 10 Mar 2025 09:40:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A222578C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599629; cv=none; b=UxnU4xVv7oM0kxGQwIFXnC21EqvfrTs31U5d9m/ndhfOpBOh7nGxDfMs1OWpWFcBlkVlG4QyH08KKNtzpgLkAwdL5KRihJQdkDXufhYU+xvyONpJgxOK1mzwH4ydgxgmnfQPnHG3oc+rq2o73TbkSmL/g8FkP/NAN23sDYtWiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599629; c=relaxed/simple;
	bh=lo+mgRRNQjvpOTF3c3mfILdt7OCcuqmpFl0MOtPCrC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HqploRXRHdLr7VjwL+lHxmjY/Le+h0M3l2l9OReVzDZ9IBqgFBGdzK+7e0gDB+Ny9FrdufYpKtGmhgMzENDY9SvPk2zBo8NC6gTDRDGmFw30PVUM2VfWx8330ma7Phaqs5dliBq+H7v5kYLcvo8w374z8SwCOXrYoJL2M/kJuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so66182595ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 02:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599627; x=1742204427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE/k1yN/gLjrNlDfMWfhJPadtzMdT1WCO7NFniN3tmA=;
        b=jvNA6yc32AUFRWUIlUsDWifU70L6J7eUDwZX6LZgMahZen3soegvqXLFWUnWsej7yz
         0wyVzVelQuE8ttuGc3MgGN3gcqi/zFfI5NGZ0mieXAOPhpsemO/8zK0uwg++wu9vA3dZ
         6chf6Y7O/zY7fkCcNMavh2rRp+Zz9iJWsAhdCWHeeBf5vNgYtUz4Wbc1kpqCbL9jx7CD
         wEvztHBx8dSPlOBURQ2BzI9Yu1S3wq4Co6Xuyv+3cm2nzli/yRhD5maxtN6Yw6qJrT4A
         pwzOic1ILoDbEO83tA4C1GFizyl8qUOgoqnAltthBa6GMDWpPXamMl3j2sOTCyruxhpP
         bDeA==
X-Forwarded-Encrypted: i=1; AJvYcCXKCVwpfGCoewzQnEpW065k+Zte6/LFsa7isayOrcwmj7mN/I9+WbxcI0SLU8SPgLGkpIo5amPDQMiKWmCZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tNTP5lbic7zqg1PM0ng9Y726+UjFOa9B1XZfe6P03Y+KNYVk
	GA4xkBUkkvtUpqMaA9UJ/C6rvG2scM4zIpbqUzWOx/51SiZt2iw7kHX3SX1Ji37/Eae+nYtuT5N
	v9jOubYpm1tVgaxvbD4iDhVd0ERlgc3tNAQderjfUgAPKuHyekyteNKw=
X-Google-Smtp-Source: AGHT+IFwfuahL2FdpG6q4fYGDj1OphYaUWZoo8mff8eTs9/Lt2LG1X3x7humY8uWcVcDb4A33QAji53ZHNKx8r4N2MQYNRASfR40
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198e:b0:3d4:36da:19a1 with SMTP id
 e9e14a558f8ab-3d44193ed4fmr179769775ab.21.1741599626800; Mon, 10 Mar 2025
 02:40:26 -0700 (PDT)
Date: Mon, 10 Mar 2025 02:40:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>
Subject: [syzbot] [mm?] [fs?] KCSAN: data-race in __filemap_add_folio /
 invalidate_bdev (8)
From: syzbot <syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80e54e84911a Linux 6.14-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1664a7a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=958433697845b9a6
dashboard link: https://syzkaller.appspot.com/bug?extid=f2aaf773187f5cae54f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e94728c052e3/disk-80e54e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/742f05e27746/vmlinux-80e54e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90d418e775f7/bzImage-80e54e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com

EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
==================================================================
BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev

read-write to 0xffff888100630570 of 8 bytes by task 3291 on cpu 0:
 __filemap_add_folio+0x430/0x6f0 mm/filemap.c:929
 filemap_add_folio+0x9c/0x1b0 mm/filemap.c:981
 page_cache_ra_unbounded+0x1c1/0x350 mm/readahead.c:276
 do_page_cache_ra mm/readahead.c:328 [inline]
 force_page_cache_ra mm/readahead.c:357 [inline]
 page_cache_sync_ra+0x252/0x680 mm/readahead.c:585
 filemap_get_pages+0x2ca/0x11a0 mm/filemap.c:2580
 filemap_read+0x230/0x8c0 mm/filemap.c:2691
 blkdev_read_iter+0x228/0x2d0 block/fops.c:796
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x5cc/0x6f0 fs/read_write.c:565
 ksys_read+0xe8/0x1b0 fs/read_write.c:708
 __do_sys_read fs/read_write.c:717 [inline]
 __se_sys_read fs/read_write.c:715 [inline]
 __x64_sys_read+0x42/0x50 fs/read_write.c:715
 x64_sys_call+0x2874/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100630570 of 8 bytes by task 3306 on cpu 1:
 invalidate_bdev+0x25/0x70 block/bdev.c:99
 ext4_put_super+0x571/0x810 fs/ext4/super.c:1356
 generic_shutdown_super+0xe5/0x220 fs/super.c:642
 kill_block_super+0x2a/0x70 fs/super.c:1710
 ext4_kill_sb+0x44/0x80 fs/ext4/super.c:7368
 deactivate_locked_super+0x7d/0x1c0 fs/super.c:473
 deactivate_super+0x9f/0xb0 fs/super.c:506
 cleanup_mnt+0x268/0x2e0 fs/namespace.c:1413
 __cleanup_mnt+0x19/0x20 fs/namespace.c:1420
 task_work_run+0x13a/0x1a0 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xa8/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x000000000000000d -> 0x000000000000000e

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3306 Comm: syz-executor Not tainted 6.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

