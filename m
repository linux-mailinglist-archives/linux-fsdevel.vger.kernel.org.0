Return-Path: <linux-fsdevel+bounces-30464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F27998B852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB701F2319A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C819F121;
	Tue,  1 Oct 2024 09:27:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858219ADBB
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774853; cv=none; b=Kwu9vrg/xhmfJJQE3zzUso6D94ztxARPO/v/kIW3y9w6Wp1WyjuwFoFaGvmey4Qj36xsShtGqie9Bk95Kt4Y6FfYnq0cGPr6dWfO6yKM48zCVgu35rdHOyFnqrlsIueeLpBHcSiPPX4/7w0mLf5hx/YPaZC1RccO4SLsfsm4xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774853; c=relaxed/simple;
	bh=QNWQjBqQHqR5XQkgIYYYN3RstCDf2QbAhqg+ZPRzke8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nm9WoLmnhd17sH53WSfVa8gfWYeOj8rLmGykkg0MXl3GD0G4wEaGzLLr22IXP4Bdu5eubLzOGmqdFwgrIO/xQNhDgX1bl8zDG75B649lOZ0XGr9aKFUguN+w/m81qHJll6Zpb/2Ey4e2VywBhmjAbIZ9m5rZm36achX7RIDQO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so43308305ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774849; x=1728379649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kc7ivSE9qCrYu3kXFK+RkmNV7+Tj1L1ACo/tudpxxoI=;
        b=UhCImAp8YVYel1jQCTZ3uaaCT81PYaVIDs0C1ovCxcUTAoHkOgzoURhrHHui5xDA5e
         2oFAdKgsRy74P64W2MsmGZ1n9vKIcSaeNC0Csuq81CfUCOwwuZ5e11z4vxyFaxeQr/0x
         Y+NAD7y+QWl1oFK6TsOd7X4S7+sublxkKgn7fKNC8mENKCqw7ryBvBmPqhI6KcD0atk+
         6IrG8CGYgIPqbqcvmMJl1+80PG8XrGjpgXBoffcVYvUkxXnBOKchUYjjdxES9GVA6mSp
         HnStEhKLIi3b7jRS3FxpZTzaO2vlUttdyuPgdRpYa24Dv2tvr+LfiLn0k1wTcggVQVmm
         OrHg==
X-Gm-Message-State: AOJu0YyvoQ6etPt609FGD8ycmvgmwrzdAOw/gcN4iderXhhGXE7YkaaX
	ELISReDO+VC9wDZgmYOpDXNfeccGcnV+oh1/9WeNatRFTPL06G4lmS5qNYCwGSf10hYSCl71qob
	HD03+wV9ePsZHBZ7zA4zyXET8VHskDhBuySvZieuhBSpMIfUPwHV8PDw=
X-Google-Smtp-Source: AGHT+IEJMLdbyn3J82EFux1eSZlQKw5vhPYG+pgEHcBA4mi2iNQHLQ2IYZUc64N4L+suY26peL98FbY7CoRHMsTK/Aot+5CW+Pyn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a35eb05072mr21855985ab.1.1727774849442; Tue, 01 Oct 2024
 02:27:29 -0700 (PDT)
Date: Tue, 01 Oct 2024 02:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b9be27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9be27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ddd507980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c19549ac916f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_get_block+0x68d/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5188 Comm: syz-executor246 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

