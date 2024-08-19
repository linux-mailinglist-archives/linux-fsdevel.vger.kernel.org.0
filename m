Return-Path: <linux-fsdevel+bounces-26263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51560956B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28071F22001
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83916BE39;
	Mon, 19 Aug 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJPTWKBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1116B3BD;
	Mon, 19 Aug 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071863; cv=none; b=kgcDpHufJW1YzxI5wLlRJmWLrwTrwdfOo41g2ebijVMotiyJx0C+mWzFVcdv2YDnIuP1607zSLOD1qSzjMoWNjyj4Zv1Zg5mzkv2LfkC2m1+aUeK1Uuli6SyvAq5sos0hdRfukQJWV4EaQE56nTGhyPxZZkyUYeHFH7aNwkPqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071863; c=relaxed/simple;
	bh=FKl0KwX9kaYeqWKtVzU8B+3h3rVePRElk6v5fiEqfhI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KU7MNdCIJFFnLkQJ3v+HzmbkNiS7sXinQAnCh0x2lY2NvJi96RSRG8AF1ghORfMB77sgxcN+plJTQY9m2E1u0j7AVpCFFNdIyiQXCuSpmBJJosfw68RqEoajQWJX0edCOuUngMnRfTnqRYup8lKhNqvKDsC90h9EQwrZeqD07eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJPTWKBQ; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-4fc7bd8763cso638574e0c.2;
        Mon, 19 Aug 2024 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071860; x=1724676660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lnKuH6/Z7p+5tbY7/eWIdXLNca1WlHLa2FXE5gB5NJQ=;
        b=hJPTWKBQoEThCYBv7UBuvZZmk8yG+75MnpguYBLWNmGRoagsPjSOtFDwRYjtO3GAnn
         Z9jIr5JL7QChxga+CIoiWlqG9XVxXpS5Ny2K+nnBmPMUur19sMoGbjNHDqAwvShZzpPF
         3nZVWWX2xbHJbc6w+aGVQbFvGI8DfQFXVUJt/PzzJpIkdIsrNDaiQfr4XR0kYmEZhwR8
         wTQlAFXEEHVV3hhHy2WqI1M62s/WzZ2JQA6xKsdokAlG/skWoW3aFxs4ccREpB9Bd2jt
         B8PYtb6WxRcU9sQiYhxCNW79F7Eq5n6OAanaAHJeQIWau0K9RIsOppEvyMhTrUOUOuGp
         nh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071860; x=1724676660;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnKuH6/Z7p+5tbY7/eWIdXLNca1WlHLa2FXE5gB5NJQ=;
        b=Hvq22dAnQZVIgnA2hYllMnQoFLgiWaTo2r/9Nc12tDiD/emK99WjToyKExsrvjDnya
         VuFyQ5CFYuWDYJbmARAmJWQq2CuPORaWrQPC04AZQoPc4L/m3FDS2X+dPbz7Uifp6cvI
         0YJeFl96JgBnSfM+kl9+ckr7EG2Tg8XbRmRNmgiorRaza8YqdUpgEbQ2ge2+WbNiVnxW
         J1vTJJ7Ct29/gGLPpLgzUW5LVkTCXiUYlgpJtbhfrNI6S7MsunIBITZht7g7eiafudvp
         B9xo9c9hZziEAglmy1b+VnnoNMr/n3Wq8kiXxnDeG7ttYFR2q3qfEQFKIjhiDoh1nhMi
         Kglw==
X-Forwarded-Encrypted: i=1; AJvYcCUufdkRlJkthppwKOfXHzrqo9ECavzyQ/KFmRcxy0T8h1iIleBdOvIjQsRIpYKLtGeEUsqUw0MtlAhM8/1m6Cam1lxBrdEEyFYCixNk65b5NdGn9pwmtpqZFfC9UMywyLUh2oJ6KQZwqmMrDw==
X-Gm-Message-State: AOJu0YwFE1L7EWFcEyDhv4pf9EVbMjHGKzXb4diWx3h++gPlmxp3E5aE
	Wu/2Nc0PQ568iZlH0P1y6kaG51x6snELe+0gZKoxlpBzzDjU3v1wLMzG+q8j/CrxrSgEIizVktz
	bgmsc4CWz9oRlR1jFk46kUvd8Eag=
X-Google-Smtp-Source: AGHT+IG5OJo2tMUGG3n/2sHWnen1J1sR3PdX9e7ygyWCirUNsEsrW/hJKSAqpZLXIXZ9gTGqI2He3UFrt2zfLcwirJw=
X-Received: by 2002:a05:6122:2193:b0:4f6:b094:80b1 with SMTP id
 71dfb90a1353d-4fc6c9fff96mr8441137e0c.11.1724071859734; Mon, 19 Aug 2024
 05:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Mon, 19 Aug 2024 20:50:48 +0800
Message-ID: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>
Subject: KASAN: stack-out-of-bounds Write in end_buffer_read_sync
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Carlos Llamas <cmllamas@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Pankaj Raghav <p.raghav@samsung.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
Our tool found the following kernel bug "KASAN: stack-out-of-bounds
Write in end_buffer_read_sync" on:
HEAD Commit: 6b0f8db921abf0520081d779876d3a41069dab95 Merge tag
'execve-v6.11-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/.config
repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81/repro.log
syz repro: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81/repro.prog

Please let me know if there is anything I can help.

Best,
HuiGuo

====================================[cut
here]===========================================
BUG: KASAN: stack-out-of-bounds in instrument_atomic_read_write
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/instrumented.h:96
[inline]
BUG: KASAN: stack-out-of-bounds in atomic_dec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/atomic/atomic-instrumented.h:592
[inline]
BUG: KASAN: stack-out-of-bounds in put_bh
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/buffer_head.h:303
[inline]
BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0x93/0xe0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/buffer.c:161
Write of size 4 at addr ffffc90009c9f828 by task ksoftirqd/0/16

CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted
6.11.0-rc3-00013-g6b0f8db921ab #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:93
[inline]
 dump_stack_lvl+0x116/0x1b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:119
 print_address_description
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/report.c:377
[inline]
 print_report+0xc0/0x5e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/report.c:488
 kasan_report+0xbd/0xf0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/report.c:601
 check_region_inline
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/generic.c:183
[inline]
 kasan_check_range+0xf4/0x1a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/generic.c:189
 instrument_atomic_read_write
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/instrumented.h:96
[inline]
 atomic_dec data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/atomic/atomic-instrumented.h:592
[inline]
 put_bh data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/buffer_head.h:303
[inline]
 end_buffer_read_sync+0x93/0xe0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/buffer.c:161
 end_bio_bh_io_sync+0xe7/0x140
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/buffer.c:2776
 bio_endio+0x6d4/0x810
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/block/bio.c:1646
 blk_update_request+0x5cb/0x1780
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/block/blk-mq.c:925
 blk_mq_end_request+0x5d/0x610
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/block/blk-mq.c:1053
 lo_complete_rq+0x235/0x300
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/block/loop.c:386
 blk_complete_reqs+0xb2/0xf0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/block/blk-mq.c:1128
 handle_softirqs+0x1d7/0x870
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:554
 run_ksoftirqd data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:928
[inline]
 run_ksoftirqd+0x3a/0x60
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:920
 smpboot_thread_fn+0x63f/0x9f0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/smpboot.c:164
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90009c98000, ffffc90009ca1000) created by:
 kernel_clone+0xeb/0x910
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:2781

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x51cc1
memcg:ffff888000798d02
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000001ffffffff ffff888000798d02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 30926, tgid 30926
(syz-executor.10), ts 987852775054, free_ts 987008041304
 set_page_owner
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/page_owner.h:32
[inline]
 post_alloc_hook+0x2e7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:1493
 prep_new_page data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:1501
[inline]
 get_page_from_freelist+0xbf3/0x2850
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3442
 __alloc_pages_noprof+0x214/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4700
 alloc_pages_mpol_noprof+0x262/0x610
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/mempolicy.c:2263
 vm_area_alloc_pages
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:3584
[inline]
 __vmalloc_area_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:3660
[inline]
 __vmalloc_node_range_noprof+0xd32/0x1410
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:3841
 alloc_thread_stack_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:313
[inline]
 dup_task_struct
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1113
[inline]
 copy_process+0x304d/0x6f20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:2204
 kernel_clone+0xeb/0x910
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:2781
 __do_sys_clone3+0x1d7/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:3085
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 16 tgid 16 stack trace:
 reset_page_owner
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/page_owner.h:25
[inline]
 free_pages_prepare
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:1094
[inline]
 free_unref_page+0x655/0xe40
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:2612
 rcu_do_batch data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/rcu/tree.c:2569
[inline]
 rcu_core+0x829/0x16d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/rcu/tree.c:2843
 handle_softirqs+0x1d7/0x870
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:554
 run_ksoftirqd data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:928
[inline]
 run_ksoftirqd+0x3a/0x60
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:920
 smpboot_thread_fn+0x63f/0x9f0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/smpboot.c:164
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffffc90009c9f700: f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00
 ffffc90009c9f780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90009c9f800: 00 00 00 00 00 f1 f1 f1 f1 f1 f1 01 f2 00 f2 f2
                                  ^
 ffffc90009c9f880: f2 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 00 00 00
 ffffc90009c9f900: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3
==========================================================================================
This report is generated by reproducing the syz repro. It may contain errors.

