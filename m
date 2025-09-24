Return-Path: <linux-fsdevel+bounces-62555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33AB99689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE5D19C6F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980C2DECDD;
	Wed, 24 Sep 2025 10:21:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0622DE719
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709300; cv=none; b=Vp4ESc3QAnCdhnhNOHReXbSTwBM/vJKg2Og2EXiW6JDlLniw5Ox9BoGpsF1zLlNq8pLTeGHsDq/VZD93hYCyxT1gL/rUpigHpNVV6UdJoXE3/p1DV+gG0DJ58VBDzrbvE1qx92JlUU6kdMCtv0/R6n78XHBZPrq4EWckrmq/prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709300; c=relaxed/simple;
	bh=GmnXGzOJVIb2WXEx3CGo6GpzydoF9S80js/+qq5ecyM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TzVFDE97pWY89IL6To3YE3rP95Fly5Y28jwa2lC/mRY4Vlxoleb9NoGBAd16wvhRtPn9CQCu/5wdiFSZOzd2VMC26ZpFaUuox4bSjoOedbwNDIUQcRwb5U4SHngulKpi85vMDKGDpa+8kPZhavjxD32Z99Eeis4Lh7QdT9xq73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4257ae42790so43574975ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 03:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709298; x=1759314098;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YW5FK+9Nxf2a1psstXqeD3lJ/i8saIm5oi9/QSnJhnQ=;
        b=oFN4FbkHSgJHp3aG9xVxwqM2yvar7dSXh5DPI9pGCsqXAEWvkU1v/gIQWkZEMlxgak
         NKJOVejBRYxpfgqubD+zIqPVZsoTJ1u3A8okgYy3aDIzTfmH28CXXkNkWCBPJpvBlR2I
         rUMny43WSV0r+x8oFgRjoUF35sodzeqYxpmZkZGRUWC2hgwTwXgNupOM+JjH4iorlPtZ
         MnC5vqjC5Z9wKowGuKKXyAF0JQaUw0EaASQ0tm/qmESXwfYqQZy+IX3/NA4qrsCuRp3D
         d1ZFYPohcSHGZVp02L6y5XyLmKxm9TiZcqT6/lryU2iD4nUVPbpGj6J9WYBIF4oGhT5B
         orUw==
X-Gm-Message-State: AOJu0Yza6P3bsFz3I9i79mz8RhnFaMMbNGxxVkHt4jjUs+d4ufRTViCf
	bjJ4oprPCC4IL4KupJ4hgpoLCQwc2EkPS8FoQbTEz6aOv8/Z54cN+AsVtlLH2+A63e/EhfKI/v7
	vWyLpQMxqX2jKD9V2j4AfwGjufZJz9XfuQiL2l9nU92cYS2jFPElRnH6/SGSHgQ==
X-Google-Smtp-Source: AGHT+IEDOKk+kz5ZVy9+diabv4h0WvsEwMoydrRk2RCg1gfQOQ6owEIvzTDTMOyUL49kzwmG7sUPSvLMGpfC+zpzTyKMDticTUxe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c89:b0:425:7974:fe21 with SMTP id
 e9e14a558f8ab-42581e98642mr88318565ab.22.1758709297779; Wed, 24 Sep 2025
 03:21:37 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:21:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3c631.a70a0220.4f78.001a.GAE@google.com>
Subject: [syzbot] [fuse?] KMSAN: uninit-value in fuse_dentry_revalidate
From: syzbot <syzbot+743e3f809752d6f7934f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1404f8e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=743e3f809752d6f7934f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da3c94d97543/disk-cec1e6e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e27bce00cc13/vmlinux-cec1e6e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f42a4c26986c/bzImage-cec1e6e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+743e3f809752d6f7934f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fuse_dentry_revalidate+0x150/0x13a0 fs/fuse/dir.c:208
 fuse_dentry_revalidate+0x150/0x13a0 fs/fuse/dir.c:208
 d_revalidate fs/namei.c:929 [inline]
 lookup_open fs/namei.c:3637 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0x13a9/0x6760 fs/namei.c:4043
 do_filp_open+0x280/0x660 fs/namei.c:4073
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_compat_sys_openat fs/open.c:1512 [inline]
 __se_compat_sys_openat fs/open.c:1510 [inline]
 __ia32_compat_sys_openat+0x238/0x300 fs/open.c:1510
 ia32_sys_call+0x3210/0x4310 arch/x86/include/generated/asm/syscalls_32.h:296
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4197 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_lru_noprof+0x822/0xed0 mm/slub.c:4259
 __d_alloc+0x66/0xa60 fs/dcache.c:1690
 d_alloc_parallel+0x98/0x2680 fs/dcache.c:2549
 __lookup_slow+0x138/0x760 fs/namei.c:1793
 lookup_slow+0x6a/0xd0 fs/namei.c:1825
 walk_component+0x444/0x650 fs/namei.c:2129
 lookup_last fs/namei.c:2630 [inline]
 path_lookupat+0x251/0x6b0 fs/namei.c:2654
 filename_lookup+0x2bd/0x800 fs/namei.c:2683
 do_linkat+0x14e/0x1040 fs/namei.c:4904
 __do_sys_link fs/namei.c:4958 [inline]
 __se_sys_link fs/namei.c:4956 [inline]
 __ia32_sys_link+0xd7/0x140 fs/namei.c:4956
 ia32_sys_call+0x3684/0x4310 arch/x86/include/generated/asm/syscalls_32.h:10
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 8754 Comm: syz.4.604 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
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

