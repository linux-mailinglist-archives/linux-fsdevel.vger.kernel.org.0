Return-Path: <linux-fsdevel+bounces-35016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59789CFFF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B81E1F24199
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B62187FFA;
	Sat, 16 Nov 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yU6jiluY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510B57C9F
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775857; cv=none; b=lH1LEkIIeIsg7Rx6X31LoU9V2YKMaSZs346pGktG0txQEOoTrKPpK7VQLSsTP/pPOlsfdufsjoRfR/DXCeXzkbXELK2l+0RVe3EBHm1KkbsRtIXGSIe+lrEK1p4oDbSWuRd+xSJu2KZDSQBb7WpnuimYgbn04itDbXdEx/IhVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775857; c=relaxed/simple;
	bh=JxVQRUmXu/GR6DOZL4O8huHliPPvYC5bjH4b+yDupQ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qDs6LZsghGjlnB2/gLVN/GBBqbrDMgMs/8ZEIT6OpitrgysNUC/kN+WgMgs7DQgVq9tTbVNVIebAERkjqwYE+u2mD1XAtWhSVCxXRzsVD07ApzYNqHgYvcqNNkob0Edf4NvuNpSQ3/xteiB5/2E0yz3fKg14AVMvbeYu04qbQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yU6jiluY; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-856e98ad00bso233898241.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731775854; x=1732380654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AJbuq7ELapydlmshajvSeNG3RIacjhiudlwSv7Rgic=;
        b=yU6jiluYkdj1tOLAT9wtUgvASi5XtQAitq7sYOzTj7/+AwR+YuPR13AhliKtJ+BTF9
         VTDuBPHv6LWdAmwo56X0UY8RGOTg8DVOfzOePPXxXlvs0WdzoHWB/djYhzvtRDsIAC1C
         vmBiYFSfWMut/LcCzMk9FOBahHc/Qsv/lOq3rsksii/GyvpFQ4BTBag0LQXh+MhL9l8Q
         ul4TUpKTdaGvUoY+3lpt2OXjOF9jOm4SbNb/HupOPswWfFxqUbGDxa2KMm/IJVZeMN3M
         GB0fEcNnmlocXe5ssvWvN2qf2q67yDhSINk5kpb54z8HRU96d6Nxlxk17Fg4oISbZ9iR
         spaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731775854; x=1732380654;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AJbuq7ELapydlmshajvSeNG3RIacjhiudlwSv7Rgic=;
        b=RvqeAKgRfK9KR0rPFDL7EUNbCMbsNX6WvD3+uHpvtwJdRJvmvy38It5GChk29LkNsb
         OouQy0fGCB6yQG4Kl03ijx1WKIputMlE/9k9pIYnABbylPWhIY5bOpBuK9tbrFzgO+3/
         IZlIov2rdEh6t3KL5Op8yX6a+/2tBnJRAiaiWKfZ5xB42+d5RNXok4F2v8YEMupVEChi
         /p5gBFTPnr67WC+MgOIQhXImGQPEH1CnlFHgUDBuGTXRj1WicxxvYL0MQN/Z7ZB6q9JM
         PvH5L0f7GUKnyDuKf0pjusQGlldgSwdkCjn62PVi8Dnljy0Le1uwlldg1RX+cR12XRvD
         CWCA==
X-Forwarded-Encrypted: i=1; AJvYcCWVSxI+JrQ+W1iREEMm5A6q0scHhgTBmm+Xmkf76duQIpY/nDoAi+Bw6ryJG58r+d86/cOsL3ypRgEXmU+F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mNGiiistqQoIiw+SyqMWfRNx4nheVYnwyW00oovVFTgkej8v
	MGXdU2BW7usFeB/9wtMyvkG+zqa6Ic6CGt/lbZT8lTkSM7qHSXprvwt8n+eHSNia0WwphR9ueVP
	aL6lt+AtajN5Oa4owKJuC5sSLonXMC88E/KBlGg==
X-Google-Smtp-Source: AGHT+IGxwi/IVhPflsdG08C7ZbvkGxsHxai4iTgnUdrVuVk07lklbn089q1LGPkXwyBIKlKfDffXfQwU/VQ3TdNFYOg=
X-Received: by 2002:a05:6102:3f03:b0:4a3:db6a:dbbf with SMTP id
 ada2fe7eead31-4ad62bffe1amr7191005137.14.1731775854568; Sat, 16 Nov 2024
 08:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 22:20:43 +0530
Message-ID: <CA+G9fYvVAvEBbFzhQQ_UBf+PYMojtN1O4qHKXngu33AT8HqEnA@mail.gmail.com>
Subject: ltp-syscalls/ioctl04: sysfs: cannot create duplicate filename '/kernel/slab/:a-0000176'
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The LTP syscalls ioctl04 and sequence test cases reported failures due
to following
reasons in the test log on the following environments on
sashal/linus-next.git tree.
 - qemu-x86_64
 - qemu-x86_64-compat
 - testing still in progress

LTP test failed log:
---------------
<4>[   70.931891] sysfs: cannot create duplicate filename
'/kernel/slab/:a-0000176'
...
<0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
<3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
<3>[   70.977680] EXT4-fs (loop0): mount failed
ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)

First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
  Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
  Bad:  c12cd257292c0c29463aa305967e64fc31a514d8
  (not able to fetch these ^ commit ids now)

qemu-x86_64:
  * ltp-syscalls/fanotify14
  * ltp-syscalls/ioctl04
  * etc..

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---------
tst_tmpdir.c:316: TINFO: Using /scratch/ltp-8XkJXJek4F/LTP_iocSaDyQw
as tmpdir (ext2/ext3/ext4 filesystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
<6>[   70.394900] loop0: detected capacity change from 0 to 614400
tst_test.c:1158: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.1 (20-May-2024)
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.12.0-rc7 #1 SMP
PREEMPT_DYNAMIC @1731766491 x86_64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
ioctl04.c:29: TPASS: BLKROGET returned 0
<6>[   70.921794] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
ioctl04.c:42: TPASS: BLKROGET returned 1
ioctl04.c:53: TPASS: Mounting RO device RW failed: EACCES (13)
<4>[   70.931891] sysfs: cannot create duplicate filename
'/kernel/slab/:a-0000176'
<4>[   70.932354] CPU: 0 UID: 0 PID: 992 Comm: ioctl04 Not tainted 6.12.0-rc7 #1
<4>[   70.932936] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[   70.933433] Call Trace:
<4>[   70.933894]  <TASK>
<4>[   70.934161]  dump_stack_lvl+0x96/0xb0
<4>[   70.934608]  dump_stack+0x14/0x20
<4>[   70.934909]  sysfs_warn_dup+0x5f/0x80
<4>[   70.935215]  sysfs_create_dir_ns+0xd0/0xf0
<4>[   70.935521]  kobject_add_internal+0xa8/0x2e0
<4>[   70.935944]  kobject_init_and_add+0x8c/0xd0
<4>[   70.936265]  sysfs_slab_add+0x11a/0x1f0
<4>[   70.936446]  do_kmem_cache_create+0x433/0x500
<4>[   70.936622]  __kmem_cache_create_args+0x19c/0x250
<4>[   70.936827]  ext4_mb_init+0x690/0x7e0
<4>[   70.937180]  ext4_fill_super+0x1934/0x31e0
<4>[   70.937547]  ? sb_set_blocksize+0x21/0x70
<4>[   70.937911]  ? __pfx_ext4_fill_super+0x10/0x10
<4>[   70.938346]  get_tree_bdev_flags+0x13c/0x1d0
<4>[   70.938780]  get_tree_bdev+0x14/0x20
<4>[   70.939118]  ext4_get_tree+0x19/0x20
<4>[   70.939354]  vfs_get_tree+0x2e/0xe0
<4>[   70.939717]  path_mount+0x309/0xb00
<4>[   70.940025]  ? putname+0x5e/0x80
<4>[   70.940183]  __x64_sys_mount+0x11d/0x160
<4>[   70.940353]  x64_sys_call+0x1719/0x20b0
<4>[   70.940516]  do_syscall_64+0xb2/0x1d0
<4>[   70.940711]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
<4>[   70.941202] RIP: 0033:0x7f667d9dd4ea
<4>[   70.941527] Code: 48 8b 0d 39 39 0d 00 f7 d8 64 89 01 48 83 c8
ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 06 39 0d 00 f7 d8 64
89 01 48
<4>[   70.942905] RSP: 002b:00007ffe22faecf8 EFLAGS: 00000246
ORIG_RAX: 00000000000000a5
<4>[   70.943283] RAX: ffffffffffffffda RBX: 00007f667d8d26c8 RCX:
00007f667d9dd4ea
<4>[   70.943788] RDX: 00007ffe22fb0e59 RSI: 000055e50098e60b RDI:
000055e50099cca0
<4>[   70.944248] RBP: 000055e50098e5d8 R08: 0000000000000000 R09:
0000000000000000
<4>[   70.944479] R10: 0000000000000001 R11: 0000000000000246 R12:
00007ffe22faed0c
<4>[   70.944704] R13: 000055e50098e60b R14: 0000000000000000 R15:
0000000000000000
<4>[   70.945086]  </TASK>
<3>[   70.946069] kobject: kobject_add_internal failed for :a-0000176
with -EEXIST, don't try to register things with the same name in the
same directory.
<3>[   70.948453] SLUB: Unable to add cache ext4_groupinfo_1k to sysfs
<4>[   70.951178] __kmem_cache_create_args(ext4_groupinfo_1k) failed
with error -22
<4>[   70.952636] CPU: 0 UID: 0 PID: 992 Comm: ioctl04 Not tainted 6.12.0-rc7 #1
<4>[   70.953183] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[   70.953975] Call Trace:
<4>[   70.954215]  <TASK>
<4>[   70.954460]  dump_stack_lvl+0x96/0xb0
<4>[   70.954877]  dump_stack+0x14/0x20
<4>[   70.955079]  __kmem_cache_create_args+0x7d/0x250
<4>[   70.955331]  ext4_mb_init+0x690/0x7e0
<4>[   70.955698]  ext4_fill_super+0x1934/0x31e0
<4>[   70.956271]  ? sb_set_blocksize+0x21/0x70
<4>[   70.958236]  ? __pfx_ext4_fill_super+0x10/0x10
<4>[   70.958570]  get_tree_bdev_flags+0x13c/0x1d0
<4>[   70.958812]  get_tree_bdev+0x14/0x20
<4>[   70.958990]  ext4_get_tree+0x19/0x20
<4>[   70.959752]  vfs_get_tree+0x2e/0xe0
<4>[   70.960137]  path_mount+0x309/0xb00
<4>[   70.960340]  ? putname+0x5e/0x80
<4>[   70.960560]  __x64_sys_mount+0x11d/0x160
<4>[   70.961572]  x64_sys_call+0x1719/0x20b0
<4>[   70.961841]  do_syscall_64+0xb2/0x1d0
<4>[   70.962060]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
<4>[   70.963017] RIP: 0033:0x7f667d9dd4ea
<4>[   70.963229] Code: 48 8b 0d 39 39 0d 00 f7 d8 64 89 01 48 83 c8
ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 06 39 0d 00 f7 d8 64
89 01 48
<4>[   70.964889] RSP: 002b:00007ffe22faecf8 EFLAGS: 00000246
ORIG_RAX: 00000000000000a5
<4>[   70.965471] RAX: ffffffffffffffda RBX: 00007f667d8d26c8 RCX:
00007f667d9dd4ea
<4>[   70.965693] RDX: 00007ffe22fb0e59 RSI: 000055e50098e60b RDI:
000055e50099cca0
<4>[   70.965938] RBP: 000055e50098e5d8 R08: 0000000000000000 R09:
0000000000000000
<4>[   70.966152] R10: 0000000000000001 R11: 0000000000000246 R12:
00007ffe22faed0c
<4>[   70.966370] R13: 000055e50098e60b R14: 0000000000000000 R15:
0000000000000000
<4>[   70.966593]  </TASK>
<0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
<3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
<3>[   70.977680] EXT4-fs (loop0): mount failed
ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)

Summary:
passed   3
failed   1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15432-gac3274b9a6ec/testrun/25851045/suite/ltp-syscalls/test/ioctl04/log
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15430-gc12cd257292c/testrun/25848631/suite/ltp-syscalls/test/ioctl04/history/
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15432-gac3274b9a6ec/testrun/25851045/suite/ltp-syscalls/test/ioctl04/details/
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ow28dxrEwN5dFu4vChS2wgU93J

Steps to reproduce:
------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ow28dxrEwN5dFu4vChS2wgU93J/reproducer

metadata:
----
  Linux version: 6.12.0-rc7
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
  git sha: ac3274b9a6ec132398615faaa725c8fa23700219
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ow9ILyg8kMOGCJOc8VDIGOlz1h/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ow9ILyg8kMOGCJOc8VDIGOlz1h/
  toolchain: gcc-13
  config: gcc-13-lkftconfig
  arch: x86_64 and testing is in progress for other architectures

--
Linaro LKFT
https://lkft.linaro.org

