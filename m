Return-Path: <linux-fsdevel+bounces-38355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B8A004E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 08:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C9B3A15ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6831C5F38;
	Fri,  3 Jan 2025 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnVfDLoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6E199938;
	Fri,  3 Jan 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888918; cv=none; b=dIyfwM2lzowLgNOKRzI/qNGPIO2FXEmobQbnSUWmxq8eRh2F20uSO3+ssUve+IWfWt4mhytl8ao/tymbZMK6s1koQDNGdNivc8o6kKenCmu4QGgg0edoRyWRu2VmEEVm7k/T76pQAX8zVOIEzKorFEEC0hbdV2g2m8BtlZbe6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888918; c=relaxed/simple;
	bh=wZ6J7iTOi7wHO9jVuzd48Lemv0wClfvArL7Yf4nJyWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tGsZhIcTiAOv2v9ON2OAByVjuhglZYrTjlb5iysj5BdTYyLJzHS6KabjG3uv/5nik9h4bEKY+ssA4zCMq5+w0Md0MQb/6BF7AmncY2CVwzlTSSjj0xZMa9bbftrbxVOg/zxYdEQBQg79zY16TIQknb41WICwVmGdbpnb7LiG5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnVfDLoA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso17407154a12.0;
        Thu, 02 Jan 2025 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735888915; x=1736493715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wZ6J7iTOi7wHO9jVuzd48Lemv0wClfvArL7Yf4nJyWY=;
        b=GnVfDLoA1hUsfLxxu8pIN+35WnLkGBeFzr4Z+t9dvjSDpg+8zrEyWB+e7Mjxusopcj
         AVlsouSGMzKhn+Qf4RPr6moiBFFEIKc/S10b9SlvdxuUYQDc/hJdxla6D9uBgqtoWIa4
         JyuatmIcd8SFLlfZMq8C/qhUGinKdahyiwpOjNv+epDDsyx0X8B/bLU0JO9ErzxMOhcR
         VSXj+Rch+xpptqNxMxQc5MdYnjXURjlGffqjVkosKdXVuJDaWc4/V63PcxYh1TfxnSmx
         Hb0T/My4istbNfc5zobhSGyQs7DNmfq2oL0n7xOQfF7+ZOvFPA6Ydu0l9LI1gHrw4cdh
         rkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888915; x=1736493715;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZ6J7iTOi7wHO9jVuzd48Lemv0wClfvArL7Yf4nJyWY=;
        b=HfPUVdv/RVPqQV+NWX2DvDAUnGJdJelkrh7K96T85DDlHxBQTzgnGLgYQJFh2nUSji
         JNBV6XFj/jOE5d8mrYNcRVXHhoBQUagdxXtztRGNzMS/k+7fiGzlbcNRMTknF4GcBrHP
         9ujdiZwKDXPP8oxz2PoSg14yTZguOzuU3/RQImyCHrt3k6VEddaDh9Kdb8XKp+HtutSe
         Io5U5er/3uisl1pXaLcdvvxwBU0bsQfOFQjd6/9Lc54sTAZdhM2S02my6r9SlEMCKEm+
         bDq+Ls2zSZYi5roZJpk/yXaMpoVqAop+cVo/KTGX5Ie4L/Kz+kGXHq0xzcOomOmuBnRL
         GZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN7uKFQQJcD4VxcjyChQHgpQSZ1MhJiwbcye4BR/+5RZj/bmt97hmVxzxNSzYI0bDqAhwRRJ/UNTiJSaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4pvMyZT4RnyBT0Q3BcHtRy2m+9v583F3A9NaBi3fETR2iwLU
	I6iEFOanu9AIOlmQqpbf4WvbUczG/Tdu26Nl7MU/5JPUvNqkEXI9Jr7kBPUW+r4dsB4KRa6wrEt
	wzRBXkRjU+xf8hiDxuNAVTRrLcGU=
X-Gm-Gg: ASbGncu1WkJkTIGpzsOaKMLPCD4qutTUDQ+xS+qf9JEvzZ6wtWXU3KiGzRRQ8dah75N
	lGgvA5Vf2cWqMJYY5fpZxl8h4b6Iy73usvDtoQcg=
X-Google-Smtp-Source: AGHT+IEruaOHeQCrvWsGHgzwHnXeowXnmFz5TIhDWwxGTbAUb+hx2axoJArlQv8g+P30kwfWN2lwTQyoaC8vPn0M5to=
X-Received: by 2002:a05:6402:2087:b0:5d3:da65:ff26 with SMTP id
 4fb4d7f45d1cf-5d81de1c939mr103052756a12.31.1735888914715; Thu, 02 Jan 2025
 23:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:21:43 +0800
Message-ID: <CAKHoSAvOWKRXZaPd=rGc8crEiiFS+TC6GJoHT-gtRfaeusfv1Q@mail.gmail.com>
Subject: "divide error in bdi_set_max_bytes" in Linux kernel version 6.13.0-rc2
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Affected File: mm/page-writeback.c

File: mm/page-writeback.c

Function: bdi_set_max_bytes

Detailed Call Stack:

------------[ cut here begin]------------

RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
RIP: 0010:bdi_ratio_from_pages mm/page-writeback.c:695 [inline]
RIP: 0010:bdi_set_max_bytes+0xa8/0x210 mm/page-writeback.c:818
Code: ff 48 39 d8 0f 82 50 01 00 00 e8 a3 fa e7 ff 48 69 db 40 42 0f
00 48 8d 74 24 48 48 8d 7c 24 28 e8 bd ee ff ff 31 d2 48 89 d8 <48> f7
74 24 48 48 89 c3 3d 40 42 0f 00 0f 87 1d 01 00 00 e8 70 fa
loop6: detected capacity change from 0 to 1024
RSP: 0018:ffff888002287b58 EFLAGS: 00010246
RAX: 0000000000e4e1c0 RBX: 0000000000e4e1c0 RCX: ffffffff91bef057
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888002287ab0
RBP: 1ffff11000450f6c R08: 0000000000000000 R09: fffffbfff2ac1c7b
R10: ffffffff9560e3df R11: 0000000000032001 R12: ffff888105e59800
R13: dffffc0000000000 R14: ffff888105e59800 R15: ffff888105e5a000
FS: 00002ae5bb0df580(0000) GS:ffff88811b380000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562ba473e6b8 CR3: 0000000104c2e000 CR4: 0000000000350ef0
loop0: p1 p2 p3
Oops: divide error: 0000 [#2] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 72912 Comm: sh Tainted: G UD
6.13.0-rc2-00159-gf932fb9b4074 #1
Tainted: [U]=USER, [D]=DIE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
RIP: 0010:bdi_ratio_from_pages mm/page-writeback.c:695 [inline]
RIP: 0010:bdi_set_max_bytes+0xa8/0x210 mm/page-writeback.c:818
Code: ff 48 39 d8 0f 82 50 01 00 00 e8 a3 fa e7 ff 48 69 db 40 42 0f
00 48 8d 74 24 48 48 8d 7c 24 28 e8 bd ee ff ff 31 d2 48 89 d8 <48> f7
74 24 48 48 89 c3 3d 40 42 0f 00 0f 87 1d 01 00 00 e8 70 fa
RSP: 0018:ffff88810ff5fb58 EFLAGS: 00010246
RAX: 00000010e1d04700 RBX: 00000010e1d04700 RCX: ffffffff91bef057
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88810ff5fab0
RBP: 1ffff11021febf6c R08: 0000000000000000 R09: fffffbfff2ac1c7b
R10: ffffffff9560e3df R11: 0000000000032001 R12: ffff888105e59800
R13: dffffc0000000000 R14: ffff888105e59800 R15: ffff888105e5a000
FS: 00002ac2e58dc580(0000) GS:ffff88811b380000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056026cd446b8 CR3: 00000001111da000 CR4: 0000000000350ef0
Call Trace:
<TASK>
max_bytes_store+0xba/0x120 mm/backing-dev.c:413
dev_attr_store+0x58/0x80 drivers/base/core.c:2439
sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
new_sync_write fs/read_write.c:586 [inline]
vfs_write+0x51e/0xc80 fs/read_write.c:679
ksys_write+0x110/0x200 fs/read_write.c:731
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x2ac2e59c8513
Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffdacd3fb18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000056026cd426b0 RCX: 00002ac2e59c8513
RDX: 000000000000000a RSI: 000056026cd426b0 RDI: 0000000000000001
RBP: 000000000000000a R08: 000056026cd426b0 R09: 00002ac2e5aabbe0
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000a R14: 7fffffffffffffff R15: 0000000000000000
</TASK>

------------[ cut here end]------------

Root Cause:

The crash is caused by a division by zero error within the Linux
kernel's page-writeback subsystem. Specifically, the bdi_set_max_bytes
function attempts to calculate a ratio using bdi_ratio_from_pages,
which internally calls div64_u64. During this calculation, a
denominator value unexpectedly becomes zero, likely due to an improper
handling of a capacity change from 0 to 1024 bytes as indicated by the
log message "loop6: detected capacity change from 0 to 1024". This
erroneous zero value leads to the divide error exception when the
kernel tries to perform the division operation. The issue occurs while
processing a sysfs write operation (max_bytes_store), suggesting that
invalid or uninitialized data provided through the sysfs interface
triggers the faulty calculation, ultimately causing the kernel to
crash.

Thank you for your time and attention.

Best regards

Wall

