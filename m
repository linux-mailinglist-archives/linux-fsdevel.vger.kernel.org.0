Return-Path: <linux-fsdevel+bounces-20406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95278D2DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BEE1C21B99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815B16192F;
	Wed, 29 May 2024 07:06:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123015B14B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966385; cv=none; b=GoIuFaud0n//5rK1I4NTvaloY+KiQPx0v7DJIYiESPNv19+f7pdlOgSXnHY0B5yyFFXTEXm+FTm74Yw/RluRKBr59j0/wt8AxShy5SYY2kzipP83B9ahHZnsJXvWHndQg/hMMMajci/D+4BgRFN70gYWg85Cf+Iz7Qnp+9D9Pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966385; c=relaxed/simple;
	bh=IagwluD925SdelzHNX7QWN2Q+2QA6HlovV0JutT8uM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lDIf1b5/4kU/M7CL35Eq4ptcLe8YecDalOq7dnDvCtEZEu5i/RbZ1fidRkpK39FZg0GZZINbazVd5zkusec5kZA/dsAe3IL+UGSoOD4xni0IJdrKyjBcodtsScFu+RzLU3DLypjlU/X3BTbRYRBp4hxltMYyHXGZxunVLJr53hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so199720939f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 00:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966383; x=1717571183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpeARKsh3J1nnJW40BruIL9buJo4U0ODQr+zgsCGAks=;
        b=ixzK6SL4v3bMkgRyQzBaL3zeS2ENuby5hb+bOb8YfkMqwJQoUKUZRUI34+YEwUsTcC
         3V+ej7Rth5pm3DY+FyCUOPQhXovUSsvbb070lNJyvrvj2f89c64LtL/xg/RG4g7X3heD
         +WeeQ4syiI2dJL8e+h+IbwKkCTeGhiOw1NFaKG7TtIedydZzxz9cjzszHofTytLBQ669
         h1ZGpkS04EjfzV8i1PExoZC4hpji6c9r/TRwEEiHco25qB2mhjuZ1rTuZ+b6fRByRmaq
         HDUjlnXe7ZCmV6zkw3XW7qRc9xobyKfpajm8dgVjm+M95qTbmqkAoWIfasfY7vC72rN1
         /B4A==
X-Gm-Message-State: AOJu0Yw91Vq4dnx3U7fEc7fR65SHPBInzTmFvKe2p0t4rUbYMVh/xGjb
	ww/ahayvn/moBvRN4Te5IeK2m/+dnVatq4FdvY7yuLkDbqZKqOnGB2w4BjoMhkYjjtUM5nsBsiT
	0wkkUEHXXRPTjlj0V8xG5sJv5/kJSb/zV4l9RhpwlMGi1GY2Jkt1n7ggt3Q==
X-Google-Smtp-Source: AGHT+IFq0eWP3fkAZhbL7BDWkqnfxo3MTtThHrFzEgToA4znYAMVJq00YnPC+xesUqmGExURrKKKhiidclwzTu/oBeNyPahuWYMw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2205:b0:488:8256:987d with SMTP id
 8926c6da1cb9f-4b03fcc5a67mr219425173.6.1716966383487; Wed, 29 May 2024
 00:06:23 -0700 (PDT)
Date: Wed, 29 May 2024 00:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061213e0619926313@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent
From: syzbot <syzbot+ca5e77364a05ff2d8c8b@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1701d634980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=ca5e77364a05ff2d8c8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca5e77364a05ff2d8c8b@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 hfs_file_truncate+0x769/0xd30 fs/hfs/extent.c:526
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:652
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x8d3/0xc00 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x133/0x280 fs/open.c:205
 x64_sys_call+0x247a/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:78
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 __do_kmalloc_node mm/slub.c:4038 [inline]
 __kmalloc+0x6e4/0x1060 mm/slub.c:4052
 kmalloc include/linux/slab.h:632 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_file_truncate+0x3c5/0xd30 fs/hfs/extent.c:512
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:652
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x8d3/0xc00 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x133/0x280 fs/open.c:205
 x64_sys_call+0x247a/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:78
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 8137 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

