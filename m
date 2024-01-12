Return-Path: <linux-fsdevel+bounces-7870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3682BFA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 13:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F7C286E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F836A332;
	Fri, 12 Jan 2024 12:15:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300336A328
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3608452488eso47817445ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 04:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061727; x=1705666527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLyu8OYx/lgkSTUNcQotYLzdGR9H05vFzQRSe8WTCWk=;
        b=CjhX61HXQZoZGMUVCT4KwpGWKUAeStnaqAz/jxPAmHgaBuLGY4jxAtlJl12/g24oqh
         t3yLTmpsJQCPcxnhisE1MTcw2r9EJswWjeF+BiaattWZOF0wfyVFdf0Qg8OA2mk+xOUE
         8rDhwWuf23+40CYTdy2zysIrKo50IK+b+BhMTo4qtvN8rmSIfj235ANd3xVB5tYTEQQs
         /pTLDr8ZZhauWvbhKfw1xz4umQf+QvKxhu49bycxvM6tmc5DoY8LOjFftlcA/BblmTT6
         ZVyYlVOLICV4YBuMUuVSyaI8dh1il13QKeoMTuT8dlGsM5JkVrGjJ3rXXl3CfiA3bfBf
         N8aQ==
X-Gm-Message-State: AOJu0YzaQ9trGwWH0+zzbqPU+BhQi903CK65G9n74ob56NoQnC6bgNAv
	0tY14vBRyrkWaMg+zaa6f6CRsklmRHifF4df2uWrqzolH8kO
X-Google-Smtp-Source: AGHT+IGVmbojMl3LokJ51c6iy6WQPvmLDcJTQpm0IDa4+SxEd/g8bbr0TPYSZgc/wJbeiwD71j8JZzJJRQU5+qSp4tLAoTZVyIvH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:35d:61b6:c776 with SMTP id
 h7-20020a056e021d8700b0035d61b6c776mr119716ila.0.1705061727448; Fri, 12 Jan
 2024 04:15:27 -0800 (PST)
Date: Fri, 12 Jan 2024 04:15:27 -0800
In-Reply-To: <0000000000007337c705fa1060e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095bce3060ebe9e97@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dvyukov@google.com, hughd@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e391f5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31b069fcee8f481d
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147a56a3e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4446464b507c/disk-70d201a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/578f39e16cac/vmlinux-70d201a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fffd404e095/bzImage-70d201a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in generic_fillattr / shmem_mknod

write to 0xffff88810427aa10 of 8 bytes by task 3467 on cpu 1:
 inode_set_mtime_to_ts include/linux/fs.h:1571 [inline]
 shmem_mknod+0x132/0x180 mm/shmem.c:3259
 shmem_create+0x34/0x40 mm/shmem.c:3313
 lookup_open fs/namei.c:3486 [inline]
 open_last_lookups fs/namei.c:3555 [inline]
 path_openat+0xdc2/0x1d30 fs/namei.c:3785
 do_filp_open+0xf6/0x200 fs/namei.c:3815
 do_sys_openat2+0xab/0x110 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88810427aa10 of 8 bytes by task 3068 on cpu 0:
 inode_get_mtime include/linux/fs.h:1565 [inline]
 generic_fillattr+0x1a6/0x2f0 fs/stat.c:61
 shmem_getattr+0x17b/0x200 mm/shmem.c:1139
 vfs_getattr_nosec fs/stat.c:135 [inline]
 vfs_getattr+0x198/0x1e0 fs/stat.c:176
 vfs_statx+0x140/0x320 fs/stat.c:248
 vfs_fstatat+0xcd/0x100 fs/stat.c:304
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:462
 __x64_sys_newfstatat+0x55/0x60 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x00000000366f1c62 -> 0x000000003707b2e3

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 3068 Comm: udevd Not tainted 6.7.0-syzkaller-06264-g70d201a40823 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

