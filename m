Return-Path: <linux-fsdevel+bounces-13381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA186F324
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508471C20F7A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FC54725;
	Sat,  2 Mar 2024 23:34:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD544C85
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709422463; cv=none; b=d4atw66QG9vgL0H2JE+TAFUQlllX4xKb2QqYv9zlbL0dACNgXyUVpV1H6EJ///wEo+hNVxylDLyi4MeP0huZHn9rnPXcNTMdzLEPMYGSKWbZGJvOXny5kA2xdDqDlr6D7SxBtLLzuOIOO0CdMOJeaetuXnxUKuARGLJplqdWTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709422463; c=relaxed/simple;
	bh=6PZPyZuJdSMqkug1hsGSq24Xi//ToATAhXUILGMcENk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bMRsCThEnx/kCZMLHuqbrdvFDWvFMJaycpPifUUmzUxnNTPPplJB5/EN/KgcaUvEU+le5OgNrzF1tbdKoWx1UYN/mrRP/M96JxuSE6Y94tb0HQAdpu8eiM1M40hHWXx/LkUgWpAzcIrjWUvioCumJgL7RNNHrpvZmxwUeREtAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so455505739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 15:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422461; x=1710027261;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIzFmH0YBizjIO8ZRQOccZP2IZa33IlKny7K5qjbqrg=;
        b=Crh/7PSnZ2b88dhhpfBO3KRWL5uWh91odWY3Zz0vRWQ1Eq20C3rZ8YXAkza+RQiRLJ
         otHwMg04jE7E21gTUtpAseguVX+fUZvym2x6Avz7H8n464QyJ+jDoBMGPb+MDVVNzi6+
         6/P+gty06Z1iSdhunYyye+UyURnG3c6g4as9uRjceXoCO/x7y6GhB3HCU/mfpatB3McU
         5fQ9dZfLq5K5wK4Z9e7YRtKeH3RU1/LwmIqK5ELziOtZtOp9TVhRbFn30MmHYbNH7yPe
         5xbFKsE71kxyaYykm8tAUy4FP2+9pFIr4nBlm/+ql8aRQe+VYfxYT45DI9oZISf+NOiy
         7nFA==
X-Gm-Message-State: AOJu0YyvEAPqGMTfgQxsbIQ7TPNYV+lDkg6ZICvQ+0Xksul0D+V3I6Ms
	hQEUa9tkVUlJCCI+B0phObxQWs0HMwnzSVWU1n0sT1qufybbah0mhh1eJeUDuQ1IaiebsJWsRp0
	bHVC19nMRvAQKJxWDFR0WWn0EQS0gVFe+vrQ3jbz3+Y7n1HLoBjTPNtTANg==
X-Google-Smtp-Source: AGHT+IGh9LEyiTbPAqJx8bYBmip5EndG+8B/OVOYErXDx4fRGuIxR/mL5D39RcT04pgP+SqkaMaKui9KHcAFueUx1ZGJjnYhjQn9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:365:1f2b:7be8 with SMTP id
 w8-20020a056e021a6800b003651f2b7be8mr449997ilv.5.1709422461627; Sat, 02 Mar
 2024 15:34:21 -0800 (PST)
Date: Sat, 02 Mar 2024 15:34:21 -0800
In-Reply-To: <0000000000004d5e29060e94b998@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098b3700612b5ee0f@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_cat_keycmp (2)
From: syzbot <syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5ad3cb0ed525 Merge tag 'for-v6.8-rc2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fa7b8c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=04486d87f6240a004c85
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f5a6a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cb9306180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a148235ac5b1/disk-5ad3cb0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b06f4d02ad6/vmlinux-5ad3cb0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fff06beed25/bzImage-5ad3cb0e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0c762eef88b9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
hfs: filesystem is marked locked, mounting read-only.
=====================================================
BUG: KMSAN: uninit-value in hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 __hfs_brec_find+0x250/0x820 fs/hfs/bfind.c:75
 hfs_brec_find+0x436/0x970 fs/hfs/bfind.c:138
 hfs_brec_read+0x3f/0x1a0 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0xe6/0x400 fs/hfs/catalog.c:194
 hfs_fill_super+0x1f27/0x23c0 fs/hfs/super.c:419
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_fill_super+0x1eb9/0x23c0 fs/hfs/super.c:416
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5019 Comm: syz-executor380 Not tainted 6.8.0-rc6-syzkaller-00238-g5ad3cb0ed525 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

