Return-Path: <linux-fsdevel+bounces-14553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A466E87D9DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72451B21425
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB071429B;
	Sat, 16 Mar 2024 11:15:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8C11733
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587735; cv=none; b=OTKOG3lyBCkBIXzVs9S4+vnYHubwiOs4BsvW18zeOS0y4UD0FejF/XLBBM4q/PUyGuEZxRz4JV77Ug3TkZw+XNz+6i/tmogksP4cIxwbwNT9RiWvDOz5uormbkMbJnbvzTH7+rDpL8qeaBJXJFOfOg6cji0pSLy+coopHRpXZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587735; c=relaxed/simple;
	bh=jLYr2i/eExX1w69iI+32GJyfadQtPjHg5todg3raew4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HzMZ0DfZ6QgkMW2xcQZdZzEngH4F10PO8Ly8U+CSzOdQ/a0LlkdOBx5MW596yeeawLXd7MVFKNsK7XxHgKHkOMrdQj8QCkh77gb9qJwbmdkNGMe01n0whone0Z9daEa857rh8oWsQst4OZCZ8yPagGIwEFciVCPfGuJZX06fqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so221249639f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 04:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710587732; x=1711192532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+okNbJx3i3eNfoL5sGRziMMrPFCXMARCoCGd9KzLbvw=;
        b=L9KpR4CbW+zcZGZ+ECtZ1jJ09VFDdjqzEWeQcRgP4NWMjpbw7Ux4xluyJYY8AH1nFC
         jg/0RsIsQj9+rgAA2qD0R/EYPa3WrV9tpNEXpUq6R8TYe0QJRP05qqXNTTaq4bH3eEIc
         GSgu/O95939DvVYfcz8TWwMsAhQlpmYu7IUFi4TDESDFijXoJCoycrLY/xjYGCpqBBCm
         LuFBBDUKcCfBzhPxtHLlkW98Js3kT43dCHm3n5CqIhE4M+m1ywntDPPDVCxw198kHsXu
         0qc+uZmhPWs1XS4VzaB6fUviZFioPMi+Dyjmx05gd9h1DHkYFRTVw7jUCEV26Vl29rEw
         wqUg==
X-Forwarded-Encrypted: i=1; AJvYcCUUAl0e310HtLltTo3OFhkZKU6p4HKA+rkJsQ9VDAqFEiZJ2vv3aUQB9BNz9FXUp8dZTUSvL6oxfLIgvGX4prWCg2BQZo4LuquzgAnZOA==
X-Gm-Message-State: AOJu0Ywv8l+sID8tpfrtwQqgV6UC2iYYv9IJ2UcyDsFdn9USC2U9T7Tp
	1tKC7+NGvTXY5I9lYZpRMyrfrYSip6oJBmbSWRSXC785+E8nWTMeqxEn6r7ke3uLhG0QwY7aCkf
	wn+0qDTX24p0/7t0gY12MrHnbtu/4GBPxFRWQ1vkbSJ2KRLtkj67bIVs=
X-Google-Smtp-Source: AGHT+IH0itGz+OK/Aa92L6bdf0sRjCQzNSEcu32+MOf5o16HWxSx92ZxJGO8h6eS7Gn6Wd+opi2JpAXm87GeOUhl5SPzU4PkFKjO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:a90b:0:b0:7cc:b79:c5cb with SMTP id
 c11-20020a5ea90b000000b007cc0b79c5cbmr9882iod.2.1710587732508; Sat, 16 Mar
 2024 04:15:32 -0700 (PDT)
Date: Sat, 16 Mar 2024 04:15:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002750950613c53e72@google.com>
Subject: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66a27abac311 Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147b32a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12598006180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105d8aa5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37968fa0451e/disk-66a27aba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b288c5c3088/vmlinux-66a27aba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/792ddbf8146d/bzImage-66a27aba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fscache_relinquish_cookie include/linux/fscache.h:307 [inline]
BUG: KMSAN: uninit-value in v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 fscache_relinquish_cookie include/linux/fscache.h:307 [inline]
 v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 evict+0x3ae/0xa60 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput+0x9ca/0xe10 fs/inode.c:1767
 iget_failed+0x15e/0x180 fs/bad_inode.c:248
 v9fs_fid_iget_dotl+0x375/0x570 fs/9p/vfs_inode_dotl.c:96
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3089 [inline]
 v9fs_alloc_inode+0x62/0x130 fs/9p/vfs_inode.c:228
 alloc_inode+0x86/0x460 fs/inode.c:261
 iget_locked+0x2bf/0xee0 fs/inode.c:1280
 v9fs_fid_iget_dotl+0x7f/0x570 fs/9p/vfs_inode_dotl.c:62
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5014 Comm: syz-executor406 Not tainted 6.8.0-syzkaller-11136-g66a27abac311 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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

