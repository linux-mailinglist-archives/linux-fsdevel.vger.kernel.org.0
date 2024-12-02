Return-Path: <linux-fsdevel+bounces-36222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869249DF9EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 05:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C491636F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8A1F8EE7;
	Mon,  2 Dec 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io4rCaaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C931D4326;
	Mon,  2 Dec 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113888; cv=none; b=HABIPHwFq35QVVrHhize9GvwY2mAfBT96oWiMCGvtkcPVYARtoFnZZnuaTFcwNBqzcZSJIqaLJ86OkxEyhmXYvQf4vUpxhATyBaWQ1T0nEd+Cg7hBl+42FXVt7ueMRiqi+E2wDpW2qT2LR2HqLSMIIL1G59XQFyUPsoGngfC4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113888; c=relaxed/simple;
	bh=OJ7h4bxuJd10+WWBwea+KJyKDstLd5j9ssunFxJhbEQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bRNh+RCcK+Pm6Z6YgFuiE8TUW4VLw5thJJLdPbZxKxBQaTOKJ7ePgFZHKXB4xV67j2sOveJnnFc3b03PbXrqca/kbftXyoCxHVw/f8n1q7Nleui8izsIS2ETmgqYDGCkWhrKNH3/m7dla0ekK9dxubtWyQ12/QigSLQT+cfpmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io4rCaaf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa530a94c0eso621646666b.2;
        Sun, 01 Dec 2024 20:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113885; x=1733718685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJ7h4bxuJd10+WWBwea+KJyKDstLd5j9ssunFxJhbEQ=;
        b=io4rCaafkH0TZ2K82FNlgl3tZHql7LnQeR0gG8M0FTZfd4yGEleQj5ngm6GcUc6/T2
         dX6cyWRo7ZbkKKUJ3d4DoNTxGwuxZx8UHHBrv6mC0ItMcrNSNfy08uQahK/Vu48cXyBh
         8uB+dhAsHEw/Fi3nLx8X6hlJ6BJbrOW37gYh8f3dvmiu9st0kG7rk3Hl6cJKhdOmMfI+
         37JOPMzQ6EbBe5SRyUB8BnDyA4/7SZyq2rTP6zyZ5qPWm8nbiATPa3i0Ogx9Iv0xzEgr
         oDihg6CZS/q8KbybgIO1Z5PWVdqmYnPZFKPfUy0ghg0f6o5KDIFUit7XHDW5xUqMoKfA
         L5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113885; x=1733718685;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJ7h4bxuJd10+WWBwea+KJyKDstLd5j9ssunFxJhbEQ=;
        b=T1/ntC8oR8gqwDLsJTt5UfQsfOTHoNs3dHI2SJqyLcXm8BBeLrgG4GUUaq1i3vRRLn
         DbVNOx0guqo196+PCiJCcbtAdeM279DAolDfwkHnLnh8ok8YlbPtzek1ev//GZuIy60G
         SFDiA3DzQHaWiV905fAOkVPsu/3HTgvPKhAySwvDwG42H1sjJz3AJd279VH3P81+Rh4K
         6j+PxOFnAym0iGt+6QQfTuBI7bxhaVdPmtT7XQfEQvusmHbJVra7y1eh0LTleA4lRlKd
         B74db3YysWFibt03JoEXV9T2lo28xC7qEfg40EGO1+InZeveMWVsZrKvua1w848leP7f
         7UTw==
X-Forwarded-Encrypted: i=1; AJvYcCV65coOrzSH5aZXjhLhAtXYJ1Oq9wW8jTVb4HGTd/rCTbSL0wvD31fkuhMSNG7QwmByJwHJtKGCZbdE6rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzidw4TMXDwQk/K6SQKobaCgbK/6YpmSmPshLPiY+I7UGLAPPH0
	LCoOd4vfPS+DucSth37eHSvD3Ts3zNEYrS6WHYbD1b2bjIUdHjFq1yDv6iv8Fo32e8J5R1aKs+R
	revax2XZsaQCHgI1CbKCr+C74WJaJdwof
X-Gm-Gg: ASbGncsP7KXo9GcNVEaSraBTqYFbEpjm3zCcF9fV2TN/SrWESUNgKbpAXSBCMrHZgiJ
	Kn3WerYeWezQ2M8qFt9YCcUJr/47UmH+r
X-Google-Smtp-Source: AGHT+IGxSmrW5rnADIiZb7qm8v3+TXMfOP1h2ntQjs/4b0rFITHhT5o5TfuPDgONT7+1QFeP8ot+yodl9vC/6WvxZhg=
X-Received: by 2002:a17:906:5a5f:b0:a9e:b471:8008 with SMTP id
 a640c23a62f3a-aa580f6add9mr1560739266b.34.1733113884451; Sun, 01 Dec 2024
 20:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:13 +0800
Message-ID: <CAKHoSAv+gLUmYioCQjKU46pEba6udNOLgTFxQ0MDVTKy_ehd=g@mail.gmail.com>
Subject: "KASAN: slab-out-of-bounds Read in load_misc_binary" in Linux Kernel
 Version 4.9
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 4.9
This issue was discovered using our custom vulnerability discovery
tool.

Affected File: fs/binfmt_misc.c

File: fs/binfmt_misc.c
Function: load_misc_binary

Detailed call trace:

BUG: KASAN: slab-out-of-bounds in check_file fs/binfmt_misc.c:118
[inline] at addr ffff88006a77bb00
BUG: KASAN: slab-out-of-bounds in load_misc_binary+0xe16/0xf90
fs/binfmt_misc.c:145 at addr ffff88006a77bb00
Read of size 1 by task udevd/5098
CPU: 1 PID: 5098 Comm: udevd Not tainted 4.9.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
ffff880060147b20 ffffffff81a9fc59 ffff88006cc013c0 ffff88006a77ba00
ffff88006a77bb00 dffffc0000000000 ffff880060147b48 ffffffff814a67ac
ffff880060147bd8 ffff88006a77ba00 ffff88006cc013c0 ffff880060147bc8
Call Trace:
[<ffffffff81a9fc59>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffffff81a9fc59>] dump_stack+0x83/0xba lib/dump_stack.c:51
[<ffffffff814a67ac>] kasan_object_err+0x1c/0x70 mm/kasan/report.c:159
[<ffffffff814a6a40>] print_address_description mm/kasan/report.c:197 [inline]
[<ffffffff814a6a40>] kasan_report_error+0x1f0/0x4f0 mm/kasan/report.c:286
[<ffffffff814a6d7e>] kasan_report mm/kasan/report.c:306 [inline]
[<ffffffff814a6d7e>] __asan_report_load1_noabort+0x3e/0x40 mm/kasan/report.c:324
[<ffffffff815bc916>] check_file fs/binfmt_misc.c:118 [inline]
[<ffffffff815bc916>] load_misc_binary+0xe16/0xf90 fs/binfmt_misc.c:145
[<ffffffff814ccf1d>] search_binary_handler+0x16d/0x480 fs/exec.c:1582
[<ffffffff814d161b>] exec_binprm fs/exec.c:1624 [inline]
[<ffffffff814d161b>] do_execveat_common.isra.41+0x124b/0x1b20 fs/exec.c:1744
[<ffffffff814d28f2>] do_execve fs/exec.c:1788 [inline]
[<ffffffff814d28f2>] SYSC_execve fs/exec.c:1869 [inline]
[<ffffffff814d28f2>] SyS_execve+0x42/0x50 fs/exec.c:1864
[<ffffffff81005fea>] do_syscall_64+0x18a/0x3b0 arch/x86/entry/common.c:280
[<ffffffff82f8f9eb>] entry_SYSCALL64_slow_path+0x25/0x25
Object at ffff88006a77ba00, in cache kmalloc-256 size: 256
Allocated:
PID = 5093
[ 55.023115] [<ffffffff810794e6>] save_stack_trace+0x16/0x20
arch/x86/kernel/stacktrace.c:57
[ 55.023748] [<ffffffff814a5b06>] save_stack+0x46/0xd0 mm/kasan/kasan.c:495
[ 55.024324] [<ffffffff814a5d8d>] set_track mm/kasan/kasan.c:507 [inline]
[ 55.024324] [<ffffffff814a5d8d>] kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:598
[ 55.024940] [<ffffffff814a1c7d>] kmem_cache_alloc_trace+0xcd/0x180
mm/slub.c:2735
[ 55.025623] [<ffffffff814d0676>] kmalloc include/linux/slab.h:490 [inline]
[ 55.025623] [<ffffffff814d0676>] kzalloc include/linux/slab.h:636 [inline]
[ 55.025623] [<ffffffff814d0676>]
do_execveat_common.isra.41+0x2a6/0x1b20 fs/exec.c:1673
[ 55.026362] [<ffffffff814d28f2>] do_execve fs/exec.c:1788 [inline]
[ 55.026362] [<ffffffff814d28f2>] SYSC_execve fs/exec.c:1869 [inline]
[ 55.026362] [<ffffffff814d28f2>] SyS_execve+0x42/0x50 fs/exec.c:1864
[ 55.026964] [<ffffffff81005fea>] do_syscall_64+0x18a/0x3b0
arch/x86/entry/common.c:280
[ 55.027579] [<ffffffff82f8f9eb>] return_from_SYSCALL_64+0x0/0x6a
Freed:
PID = 5093
[ 55.028625] [<ffffffff810794e6>] save_stack_trace+0x16/0x20
arch/x86/kernel/stacktrace.c:57
[ 55.029239] [<ffffffff814a5b06>] save_stack+0x46/0xd0 mm/kasan/kasan.c:495
[ 55.029823] [<ffffffff814a6373>] set_track mm/kasan/kasan.c:507 [inline]
[ 55.029823] [<ffffffff814a6373>] kasan_slab_free+0x73/0xc0 mm/kasan/kasan.c:571
[ 55.030437] [<ffffffff814a2fb0>] slab_free_hook mm/slub.c:1352 [inline]
[ 55.030437] [<ffffffff814a2fb0>] slab_free_freelist_hook
mm/slub.c:1374 [inline]
[ 55.030437] [<ffffffff814a2fb0>] slab_free mm/slub.c:2951 [inline]
[ 55.030437] [<ffffffff814a2fb0>] kfree+0x90/0x190 mm/slub.c:3871
[ 55.030995] [<ffffffff814cb92d>] free_bprm+0x19d/0x200 fs/exec.c:1355
[ 55.031589] [<ffffffff814d180c>]
do_execveat_common.isra.41+0x143c/0x1b20 fs/exec.c:1753
[ 55.032311] [<ffffffff814d28f2>] do_execve fs/exec.c:1788 [inline]
[ 55.032311] [<ffffffff814d28f2>] SYSC_execve fs/exec.c:1869 [inline]
[ 55.032311] [<ffffffff814d28f2>] SyS_execve+0x42/0x50 fs/exec.c:1864
[ 55.032891] [<ffffffff81005fea>] do_syscall_64+0x18a/0x3b0
arch/x86/entry/common.c:280
[ 55.033512] [<ffffffff82f8f9eb>] return_from_SYSCALL_64+0x0/0x6a
Memory state around the buggy address:
ffff88006a77ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88006a77ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88006a77bb00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
^
ffff88006a77bb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88006a77bc00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================

Root Cause:

The root cause appears to be improper memory handling when processing
file structures in the binfmt_misc module. Specifically, the system is
attempting to read beyond the allocated memory for the binary file
structure, leading to a slab-out-of-bounds error. This could be caused
by invalid pointer dereferencing, incorrect bounds checking, or memory
corruption.

We would appreciate it if the kernel maintainers could investigate
this issue further and suggest potential fixes.

Please let us know if you need any additional information or if
further steps are required to reproduce or analyze the issue.

Thank you for your time and attention.

Best regards

Wall

