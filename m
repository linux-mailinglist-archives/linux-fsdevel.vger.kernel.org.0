Return-Path: <linux-fsdevel+bounces-26267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F081D956C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AE51C22AFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138716D9A6;
	Mon, 19 Aug 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3crnIcGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E802716C6B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074109; cv=none; b=YkfPYRCcfXsIsHDAyHDpUr8UQSNP2AMZd2+c0ASdGRtngp+Pg0ytFv0L/Vq28d5KkxoUFcy3JNDpTEXDnhQcvq1nlGnbzop0i0KVZGuveU3WcCe20slDsscZ09rTH0D0uZSTHy/unN3yvws+vyh7YOSnbdpbtMDw76NNEDt9bxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074109; c=relaxed/simple;
	bh=9Vmz1wyO8gLK7n95L40/NwyCmxGvIwfxvHFdhSkeau0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVRcKs/kSSwCCvxfNn8cWSVWKrcAa3Lroixt13oO2GQAaOoJbtG9GCz1BW4sLOjD3y7X7CeqYiH4oQocTkghUe/4KNQ1eVyQi9pNHTaR6OXdnwYIe/avyQrZbNWjg+jH3kiKI0xzYk5BcEhW9K13LgsbcubD7iMCK9zJbdcvZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3crnIcGF; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db145c8010so2787026b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724074106; x=1724678906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIA9XP3WDCL7a34SnaXxXexxut2nPkQfe5LUpC4P+Bw=;
        b=3crnIcGFMT8cfleLHChRt/2Dw3krzflA57wpBKDPyRX/yRKtN34ZUpm31/Jf5kRfUo
         iEBCxISgrO7RqEMJHEUzWbgymnt0Eab9UDZTSz3cMBfM2SgSgTzWNP+vCHavq1zD9uVg
         tjoGyvVVad/t6sdMQ3qnOvKrZJB7hDZkdvS1mkL/VJsPKcZ5rJFK6QHMLoJOaIT5Xp2h
         iq2JoR2llcrvuE8UgqQGUwk7+8x8ffkFAHl2NVcS3yt61HXwzKsBxkgCgNyrDm9ANzxR
         4gMikKdHrrsH6qKp51ZAdvObCBYSDDDKykepjW3ank3BmtkW7jn5IZIGFC4fwlIoEvu2
         wX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724074106; x=1724678906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIA9XP3WDCL7a34SnaXxXexxut2nPkQfe5LUpC4P+Bw=;
        b=TSx+I/EIzz038V/OfU/HU/QLznsgB3/Odl44Dgkr9zwOTD/lt6xUCJdRN7byC6qxya
         2T/UCd8W6YuyoVIfBtkMdJfUfuh1Mrn0N/1+9O7tx9X/4JNTT1lxy2Vk5aCwhl0rgFzu
         4SsOxRdS/yi5zvtKvf2HC6/4j+TnsRymBqQ+/KJpjPn5i3RJTxADAvqGQ7GcpWKSut1K
         nQs8lsIsnD5xOlf8iijqMBJH1llrehEjXb2sxbe9ocau9IcUgRpgN57n1af/0TpyB6CQ
         +uGBf+n1Jxnwr8lXmOcWBO1kN2h6/ezVcBnrd5x9hsgPsm+xdqlswIofDGJPyM3Tb2fq
         jacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu9WJBXmCyxRgCSoTT/0PhtbyzPFF/8eX4zKbTaju5U7itDgUrwfU6WtjHRcw4Z3xIvo9RA9pMnAryD/ZLjN/M4dbgIf2u6e565Pnd7g==
X-Gm-Message-State: AOJu0Yyht2qzhoDSTFi/3soc5lg6DRU63V6Flf8yZPmXTU5nhE2Ya569
	sKETJlFSKfOakljC+W+ws35sfKxt4097Erd7alvthMY2OSntsutNPFB3rsDHewQsRpgUtJfkptc
	RXv9iCRLTN324UkhoS/D6QLYXIhwQCufiXSeY
X-Google-Smtp-Source: AGHT+IGupYbtba93xyckiBxy20P+T7EnYjWW56mzFtb3U6MZ2yRBeGKqhXGVTqD5hHaRkc6NSFYkA9YL39seVHSBZiE=
X-Received: by 2002:a05:6808:1a23:b0:3da:4c28:6697 with SMTP id
 5614622812f47-3dd3adea07amr13456290b6e.38.1724074105811; Mon, 19 Aug 2024
 06:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>
In-Reply-To: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 19 Aug 2024 15:28:13 +0200
Message-ID: <CANp29Y4UGksKhXi3CG5F=E2JOTLAiW4MuHirWfLAs2WG4zygCw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Write in end_buffer_read_sync
To: Hui Guo <guohui.study@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Carlos Llamas <cmllamas@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Pankaj Raghav <p.raghav@samsung.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:54=E2=80=AFPM Hui Guo <guohui.study@gmail.com> wr=
ote:
>
> Hi Kernel Maintainers,
> Our tool found the following kernel bug "KASAN: stack-out-of-bounds
> Write in end_buffer_read_sync" on:

Please note that the bug was already reported by syzbot in 2022:
https://syzkaller.appspot.com/bug?extid=3D3f7f291a3d327486073c
https://lore.kernel.org/all/0000000000005b04fa05dd71e0e0@google.com/T/

--=20
Aleksandr

> HEAD Commit: 6b0f8db921abf0520081d779876d3a41069dab95 Merge tag
> 'execve-v6.11-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b=
0f8db921abf0520081d779876d3a41069dab95/.config
> repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8d=
b921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81=
/repro.log
> syz repro: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8d=
b921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81=
/repro.prog
>
> Please let me know if there is anything I can help.
>
> Best,
> HuiGuo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D[cut
> here]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: stack-out-of-bounds in instrument_atomic_read_write
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/instrumented.h:96
> [inline]
> BUG: KASAN: stack-out-of-bounds in atomic_dec
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/atomic/atomic-instrumented.h:592
> [inline]
> BUG: KASAN: stack-out-of-bounds in put_bh
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/buffer_head.h:303
> [inline]
> BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0x93/0xe0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/fs/buffer.c:161
> Write of size 4 at addr ffffc90009c9f828 by task ksoftirqd/0/16
>
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted
> 6.11.0-rc3-00013-g6b0f8db921ab #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf05=
20081d779876d3a41069dab95/lib/dump_stack.c:93
> [inline]
>  dump_stack_lvl+0x116/0x1b0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/lib/dump_stack.c:119
>  print_address_description
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/kasan/report.c:377
> [inline]
>  print_report+0xc0/0x5e0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/kasan/report.c:488
>  kasan_report+0xbd/0xf0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/kasan/report.c:601
>  check_region_inline
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/kasan/generic.c:183
> [inline]
>  kasan_check_range+0xf4/0x1a0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/kasan/generic.c:189
>  instrument_atomic_read_write
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/instrumented.h:96
> [inline]
>  atomic_dec data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520=
081d779876d3a41069dab95/./include/linux/atomic/atomic-instrumented.h:592
> [inline]
>  put_bh data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d=
779876d3a41069dab95/./include/linux/buffer_head.h:303
> [inline]
>  end_buffer_read_sync+0x93/0xe0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/fs/buffer.c:161
>  end_bio_bh_io_sync+0xe7/0x140
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/fs/buffer.c:2776
>  bio_endio+0x6d4/0x810
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/block/bio.c:1646
>  blk_update_request+0x5cb/0x1780
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/block/blk-mq.c:925
>  blk_mq_end_request+0x5d/0x610
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/block/blk-mq.c:1053
>  lo_complete_rq+0x235/0x300
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/drivers/block/loop.c:386
>  blk_complete_reqs+0xb2/0xf0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/block/blk-mq.c:1128
>  handle_softirqs+0x1d7/0x870
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/softirq.c:554
>  run_ksoftirqd data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0=
520081d779876d3a41069dab95/kernel/softirq.c:928
> [inline]
>  run_ksoftirqd+0x3a/0x60
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/softirq.c:920
>  smpboot_thread_fn+0x63f/0x9f0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/smpboot.c:164
>  kthread+0x2ca/0x3b0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/kthread.c:389
>  ret_from_fork+0x48/0x80
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/entry/entry_64.S:244
>  </TASK>
>
> The buggy address belongs to the virtual mapping at
>  [ffffc90009c98000, ffffc90009ca1000) created by:
>  kernel_clone+0xeb/0x910
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:2781
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x51cc=
1
> memcg:ffff888000798d02
> flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000001 0000000000000000 00000001ffffffff ffff888000798d02
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 30926, tgid 30926
> (syz-executor.10), ts 987852775054, free_ts 987008041304
>  set_page_owner
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/page_owner.h:32
> [inline]
>  post_alloc_hook+0x2e7/0x350
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/page_alloc.c:1493
>  prep_new_page data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0=
520081d779876d3a41069dab95/mm/page_alloc.c:1501
> [inline]
>  get_page_from_freelist+0xbf3/0x2850
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/page_alloc.c:3442
>  __alloc_pages_noprof+0x214/0x21e0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/page_alloc.c:4700
>  alloc_pages_mpol_noprof+0x262/0x610
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/mempolicy.c:2263
>  vm_area_alloc_pages
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/vmalloc.c:3584
> [inline]
>  __vmalloc_area_node
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/vmalloc.c:3660
> [inline]
>  __vmalloc_node_range_noprof+0xd32/0x1410
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/vmalloc.c:3841
>  alloc_thread_stack_node
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:313
> [inline]
>  dup_task_struct
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:1113
> [inline]
>  copy_process+0x304d/0x6f20
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:2204
>  kernel_clone+0xeb/0x910
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:2781
>  __do_sys_clone3+0x1d7/0x250
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/fork.c:3085
>  do_syscall_x64
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/entry/common.c:52
> [inline]
>  do_syscall_64+0xcb/0x250
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 16 tgid 16 stack trace:
>  reset_page_owner
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/./include/linux/page_owner.h:25
> [inline]
>  free_pages_prepare
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/page_alloc.c:1094
> [inline]
>  free_unref_page+0x655/0xe40
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/mm/page_alloc.c:2612
>  rcu_do_batch data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf05=
20081d779876d3a41069dab95/kernel/rcu/tree.c:2569
> [inline]
>  rcu_core+0x829/0x16d0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/rcu/tree.c:2843
>  handle_softirqs+0x1d7/0x870
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/softirq.c:554
>  run_ksoftirqd data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0=
520081d779876d3a41069dab95/kernel/softirq.c:928
> [inline]
>  run_ksoftirqd+0x3a/0x60
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/softirq.c:920
>  smpboot_thread_fn+0x63f/0x9f0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/smpboot.c:164
>  kthread+0x2ca/0x3b0
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/kernel/kthread.c:389
>  ret_from_fork+0x48/0x80
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30
> data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3=
a41069dab95/arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffffc90009c9f700: f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90009c9f780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90009c9f800: 00 00 00 00 00 f1 f1 f1 f1 f1 f1 01 f2 00 f2 f2
>                                   ^
>  ffffc90009c9f880: f2 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 00 00 00
>  ffffc90009c9f900: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This report is generated by reproducing the syz repro. It may contain err=
ors.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5%2BvN7Osiw%40ma=
il.gmail.com.

