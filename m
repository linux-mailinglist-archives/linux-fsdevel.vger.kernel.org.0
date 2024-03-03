Return-Path: <linux-fsdevel+bounces-13395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D586F5F7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9731FB21DCE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FB67C61;
	Sun,  3 Mar 2024 15:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2767C52
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709481077; cv=none; b=eOVQS38cS41YkDhzOlvvCXXhu5vG8v5YO/fzI2a3ZNCLiBfiqwOUNNbVGTtQOdMqtOYZrz3/sdTA0JHBFHGSW6KLcInHsbNk2ffZUK0BNNLLOEfVJoKhJFNkB4cdgycEZBj6sFLxUpFPW3glLVsnr8P3J/KIgYgk4SsTKmp9Diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709481077; c=relaxed/simple;
	bh=8aYiyaGFXCLaXkhRzG6EvSN7OeV6ZdYdG/gRflj4/iQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOvKVrSOGOClaa+ZHvYpycmGKwmgdyauU3DU6itWUWCBcw5a31b2F6SqKnZeXB64WHQvZGy/Q3ILLZrAZUGexlfMrqxnz6HWLqd8N/ovVnN39NKeN2i5hKSkBwTW2xK3wCicw9aSDT3yGSVkrW9GYZUFJ0TTrj2tRuXMntYfq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-365761d483aso34189085ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 07:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709481075; x=1710085875;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0WfFVpCpCPboe1ePdcUuron3PP3a5v/P9we/dRVjCk=;
        b=kf+8ERxs+jHUePRMBFLYbug77rVM2O3BFXX48EYylMPx1AbOvzcRcO8zRVzDyb0c5q
         Rcn9+UgzzXmHy2Gy8fHTg8csyRau76NYfy92aTYlSidZuFNlB+WkMHgvI3ff/Yfjz31r
         9SM8bJ4ajTMzItW8WRmXAVyggABRzCGzaBwAX5XYhcRGgRr714tZ8i0X3Cqv0WpAu8Mj
         f2/PXlhmJVOlu9COv+nqKdBx0EzXyTgt11hzUBUFTlJtmtoi17be0kjG9cK+FGr7KEJv
         /6tZZIAIzdyNVJyRfM5vHCt22w5lwI0Yayntkw0Pb6trsfXi7ao81uJ8EAi3I5dGPfJU
         6fPg==
X-Forwarded-Encrypted: i=1; AJvYcCWjGCCb4znJQ8t117ECELikFx5RuiA0MmXsld//FTsbRnyMzBJ/ygQDT7WbK/zkouneom9uqWnUWKH2WWU+Lbzs2Wzk0iydHr2OF+kxgQ==
X-Gm-Message-State: AOJu0YxVMCTOJcJjZgIxC+wZAPW+FdiUxkD0oTD5eUa9vyWP75YYw6AB
	lCJMhIIV57c/sG3QSVyw0aGSsFBof/PlOaPL8uE2GKt5B91zPgKNOjalTsUb+CRd4z028cfknlZ
	jFC9XHl5yWaOG9e+innnt32gT56/A1bmZi1I0jA+XLMXTRlzDhQLuSvE=
X-Google-Smtp-Source: AGHT+IECP7/6+A28HKut/GL1QdQhF0UBY7K0TwrhxVRRN4e4e/LjpVswDvQ0TtG9NTUpBoJ3qPV4F9PKanHWbnQ6u3/3qg1KMV5J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:365:cbd9:ac92 with SMTP id
 i5-20020a056e02152500b00365cbd9ac92mr486466ilu.6.1709481074834; Sun, 03 Mar
 2024 07:51:14 -0800 (PST)
Date: Sun, 03 Mar 2024 07:51:14 -0800
In-Reply-To: <000000000000d60fa905ee84ff8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037444e0612c39434@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
From: syzbot <syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com>
To: glider@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175aa96a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173516ee180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fd7bba180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/111a30273774/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_attr_bin_cmp_key+0xf1/0x190 fs/hfsplus/attributes.c:42
 hfsplus_attr_bin_cmp_key+0xf1/0x190 fs/hfsplus/attributes.c:42
 hfs_find_rec_by_key+0xb0/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26b/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_find_attr+0x30c/0x390
 hfsplus_attr_exists+0x1c6/0x260 fs/hfsplus/attributes.c:182
 __hfsplus_setxattr+0x510/0x3580 fs/hfsplus/xattr.c:336
 hfsplus_setxattr+0x129/0x1e0 fs/hfsplus/xattr.c:434
 hfsplus_trusted_setxattr+0x55/0x70 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 path_setxattr+0x1f5/0x3c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xf7/0x180 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_attr_exists+0xde/0x260 fs/hfsplus/attributes.c:178
 __hfsplus_setxattr+0x510/0x3580 fs/hfsplus/xattr.c:336
 hfsplus_setxattr+0x129/0x1e0 fs/hfsplus/xattr.c:434
 hfsplus_trusted_setxattr+0x55/0x70 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 path_setxattr+0x1f5/0x3c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xf7/0x180 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5013 Comm: syz-executor247 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

