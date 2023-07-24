Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F475F4DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGXLXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGXLXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:23:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE37E4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 04:23:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so5317791e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690197823; x=1690802623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yxGlgzdsxLBh0rx/cWrHIlgPo5k0x+Rge375kz94M8=;
        b=EVbuiE/EnWUiNYXBm+IRKIw35PNOGwKoTbFhEsMhLRdfgtw59ytxMf9Z6QkBf4Zv7A
         gLKRtelqlbQ4WLYSu2JSq3/hZQqSpWyMuXFaoUaZKXxpKfUrSTufP3vicnZq99LM1hpE
         ayam1Plq5dQKWCOOZgI7uxOrgxuRLjYpMEUiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690197823; x=1690802623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yxGlgzdsxLBh0rx/cWrHIlgPo5k0x+Rge375kz94M8=;
        b=TcAHyG0+vCgd12MR/lCMmrh0wjLWOQO/EQoL2KXAPzWQid3zClb7ZPwRHJmLUhGT/U
         VZrFbFOsi4N4mqcNZKj9rZnWgxPGIgHRMkGR8gTGUw7Q5DqrBRmdc70bpywhdNdRWySj
         hDKP3AS+kBShxAZdI/b0UcdUt41K3vAqfq1o8XwM4aZrD3vsUrZb+j/USJhgx9ZjVMhs
         jAiZbMLlUU0ZjDz0Tk5pipBnrZ9jzhtH3IXUrZ+iIw0Jn0eLMCHhyZXkrsGV20SoAxkD
         Tmyjj9Hhbntj9dAY+RIMv/jSx1U+twi0wbVEnj6bXBJ7Rg3DkDw8JXZlwzc53KsNIbeJ
         fgOQ==
X-Gm-Message-State: ABy/qLZ6jEn6KR1nEnBfV7IzQLfDpgrlmphilKF7pwc+7M2c00rM1k7x
        H0qd+VbW4eBZnQB3ChdqeUyaHH/knEzyWNaIad6RyKcla71hikVXFrc=
X-Google-Smtp-Source: APBJJlFT8IOnygEYJUCbHugnj8CQA1XMTtT8J1hLVH4vPWA3aacXD1BtYf2FrOvbhJ6OdiQlB9L50M8Szb5zl2M/OEg=
X-Received: by 2002:a05:6512:250f:b0:4f3:b18a:6494 with SMTP id
 be15-20020a056512250f00b004f3b18a6494mr3579212lfb.22.1690197822529; Mon, 24
 Jul 2023 04:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
In-Reply-To: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Mon, 24 Jul 2023 12:23:31 +0100
Message-ID: <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
To:     linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi again,

We had another example of xarray corruption involving xfs and zsmalloc. We =
are
running zram as swap. We have 2 tasks deadlock waiting for page to be relea=
sed

The following backtrace is from zsmalloc task
  #0  context_switch (/cfsetup_build/build/linux/kernel/sched/core.c:5241:2=
)
  #1  __schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6554:8)
  #2  schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6630:3)
  #3  io_schedule (/cfsetup_build/build/linux/kernel/sched/core.c:8774:2)
  #4  folio_wait_bit_common (/cfsetup_build/build/linux/mm/filemap.c:1296:4=
)
  #5  folio_wait_locked
(/cfsetup_build/build/linux/include/linux/pagemap.h:1022:3)
  #6  wait_on_page_locked
(/cfsetup_build/build/linux/include/linux/pagemap.h:1034:2)
  #7  lock_zspage (/cfsetup_build/build/linux/mm/zsmalloc.c:1736:3)
  #8  async_free_zspage (/cfsetup_build/build/linux/mm/zsmalloc.c:1974:3)
  #9  process_one_work (/cfsetup_build/build/linux/kernel/workqueue.c:2289:=
2)
  #10 worker_thread (/cfsetup_build/build/linux/kernel/workqueue.c:2436:4)
  #11 kthread (/cfsetup_build/build/linux/kernel/kthread.c:376:9)
  #12 ret_from_fork+0x22/0x2d
(/cfsetup_build/build/linux/arch/x86/entry/entry_64.S:306)

The following backtrace is from a userspace task
  #0  context_switch (/cfsetup_build/build/linux/kernel/sched/core.c:5241:2=
)
  #1  __schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6554:8)
  #2  schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6630:3)
  #3  io_schedule (/cfsetup_build/build/linux/kernel/sched/core.c:8774:2)
  #4  folio_wait_bit_common (/cfsetup_build/build/linux/mm/filemap.c:1296:4=
)
  #5  folio_put_wait_locked (/cfsetup_build/build/linux/mm/filemap.c:1465:9=
)
  #6  filemap_update_page (/cfsetup_build/build/linux/mm/filemap.c:2472:4)
  #7  filemap_get_pages (/cfsetup_build/build/linux/mm/filemap.c:2606:9)
  #8  filemap_read (/cfsetup_build/build/linux/mm/filemap.c:2676:11)
  #9  xfs_file_buffered_read
(/cfsetup_build/build/linux/fs/xfs/xfs_file.c:277:8)
  #10 xfs_file_read_iter (/cfsetup_build/build/linux/fs/xfs/xfs_file.c:302:=
9)
  #11 call_read_iter (/cfsetup_build/build/linux/include/linux/fs.h:2199:9)
  #12 new_sync_read (/cfsetup_build/build/linux/fs/read_write.c:389:8)
  #13 vfs_read (/cfsetup_build/build/linux/fs/read_write.c:470:9)
  #14 ksys_read (/cfsetup_build/build/linux/fs/read_write.c:613:9)
  #15 do_syscall_x64 (/cfsetup_build/build/linux/arch/x86/entry/common.c:50=
:14)
  #16 do_syscall_64 (/cfsetup_build/build/linux/arch/x86/entry/common.c:80:=
7)
  #17 entry_SYSCALL_64+0x83/0x164
(/cfsetup_build/build/linux/arch/x86/entry/entry_64.S:120)

The folio in question has .mapping =3D (struct address_space
*)zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332
and flag 'PG_locked|PG_waiters|PG_private|PG_slob_free'. In fact, the
file's i_pages
mapping has a node full of these pages. The following are entries we
get from mapping
in #6 at 0xffffffffa4e1c586 (filemap_get_pages+0x5d6/0x624) in
filemap_update_page at /cfsetup_build/build/linux/mm/filemap.c:2472:4
(inlined)

  > for index, entry in xa_for_each(trace[6]['mapping'].i_pages.address_of_=
()):
      print(index, entry, cast('struct folio *',
entry).page.mapping.address_of_())

  2936 (void *)0xffffe53ab6454f00 *(struct address_space
**)0xffffe53ab6454f18 =3D 0xffff9ffc9ded16b0
  2940 (void *)0xffffe53ab6454300 *(struct address_space
**)0xffffe53ab6454318 =3D 0xffff9ffc9ded16b0
  2944 (void *)0xffffe53a02696000 *(struct address_space
**)0xffffe53a02696018 =3D zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332 <=3D=3D
index
  2945 (void *)0xffffe53a02696000 *(struct address_space
**)0xffffe53a02696018 =3D zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332
  2946 (void *)0xffffe53a02696000 *(struct address_space
**)0xffffe53a02696018 =3D zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332
  ...
  2976 (void *)0xffffe53a02696000 *(struct address_space
**)0xffffe53a02696018 =3D zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332 <=3D=3D
last_index
  ...
  3006 (void *)0xffffe53a02696000 *(struct address_space
**)0xffffe53a02696018 =3D zsmalloc_mops+0x2 =3D 0xffffffffc1a9f332
  3007 (void *)0xffffe53ad71c37c0 *(struct address_space
**)0xffffe53ad71c37d8 =3D 0xffff9ffc9ded16b0

On Fri, Jul 21, 2023 at 11:49=E2=80=AFAM Daniel Dao <dqminh@cloudflare.com>=
 wrote:
>
> Hi,
>
> In the past, we reported some corruptions on xfs/iomap/xarray combination=
s on
> kernel 6.1. This happened very rarely ( once a week for every 10000 hosts=
), and
> the host exhibited symptoms such as: rcu_preempt self-detected stalls,
> NULL pointer
> dereferences or deadlock when reading a particular file.
>
> We do not have a reproducer yet, but we now have more debugging data
> which hopefully
> should help narrow this down. Details as followed:
>
> 1. Kernel NULL pointer deferencences in __filemap_get_folio
>
> This happened on a few different hosts, with a few different repeated add=
resses.
> The addresses are 0000000000000036, 0000000000000076,
> 00000000000000f6. This looks
> like the xarray is corrupted and we were trying to do some work on a
> sibling entry.
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000036
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 18806c5067 P4D 18806c5067 PUD 188ed48067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 73 PID: 3579408 Comm: prometheus Tainted: G           O
> 6.1.34-cloudflare-2023.6.7 #1
>     Hardware name: GIGABYTE R162-Z12-CD1/MZ12-HD4-CD, BIOS M03 11/19/2021
>     RIP: 0010:__filemap_get_folio (arch/x86/include/asm/atomic.h:29
> include/linux/atomic/atomic-arch-fallback.h:1242
> include/linux/atomic/atomic-arch-fallback.h:1267
> include/linux/atomic/atomic-instrumented.h:608
> include/linux/page_ref.h:238 include/linux/page_ref.h:247
> include/linux/page_ref.h:280 include/linux/page_ref.h:313
> mm/filemap.c:1863 mm/filemap.c:1915)
>     Code: 10 e8 99 ac 84 00 48 3d 06 04 00 00 49 89 c4 74 e2 48 3d 02
> 04 00 00 74 da 48 85 c0 0f 84 2e 02 00 00 a8 01 0f 85 e3 00 00 00 <8b>
> 40 34 85 c0 74 c2 8d 50 01 4d 8d 7c 24 34 f0 41 0f b1 54 24 34
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       0: 10 e8                adc    %ch,%al
>       2: 99                    cltd
>       3: ac                    lods   %ds:(%rsi),%al
>       4: 84 00                test   %al,(%rax)
>       6: 48 3d 06 04 00 00    cmp    $0x406,%rax
>       c: 49 89 c4              mov    %rax,%r12
>       f: 74 e2                je     0xfffffffffffffff3
>       11: 48 3d 02 04 00 00    cmp    $0x402,%rax
>       17: 74 da                je     0xfffffffffffffff3
>       19: 48 85 c0              test   %rax,%rax
>       1c: 0f 84 2e 02 00 00    je     0x250
>       22: a8 01                test   $0x1,%al
>       24: 0f 85 e3 00 00 00    jne    0x10d
>       2a:* 8b 40 34              mov    0x34(%rax),%eax <-- trapping inst=
ruction
>       2d: 85 c0                test   %eax,%eax
>       2f: 74 c2                je     0xfffffffffffffff3
>       31: 8d 50 01              lea    0x1(%rax),%edx
>       34: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       39: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       0: 8b 40 34              mov    0x34(%rax),%eax
>       3: 85 c0                test   %eax,%eax
>       5: 74 c2                je     0xffffffffffffffc9
>       7: 8d 50 01              lea    0x1(%rax),%edx
>       a: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       f: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>     RSP: 0000:ffffaf5587cdfc60 EFLAGS: 00010246
>     RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000002
>     RDX: 0000000000000008 RSI: ffffa45181fa8000 RDI: ffffaf5587cdfc70
>     RBP: 0000000000000000 R08: 0000000000000402 R09: 000000000006e44f
>     R10: 000000000006e450 R11: 000000000006e448 R12: 0000000000000002
>     R13: ffffa3fff6fdfeb0 R14: 000000000006e44a R15: 00000000000000d1
>     FS:  000000c9e385ac90(0000) GS:ffffa4153fc40000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000036 CR3: 000000296a1bc002 CR4: 0000000000770ee0
>     PKRU: 55555554
>     Call Trace:
>     <TASK>
>     ? __die_body.cold (arch/x86/kernel/dumpstack.c:478
> arch/x86/kernel/dumpstack.c:465 arch/x86/kernel/dumpstack.c:420)
>     ? page_fault_oops (arch/x86/mm/fault.c:727)
>     ? migrate_task_rq_fair (include/linux/sched.h:1921
> kernel/sched/fair.c:3932 kernel/sched/fair.c:7497)
>     ? do_user_addr_fault (include/linux/kprobes.h:404
> include/linux/kprobes.h:597 arch/x86/mm/fault.c:1280)
>     ? ttwu_queue_wakelist (kernel/sched/core.c:3880)
>     ? exc_page_fault (arch/x86/include/asm/irqflags.h:40
> arch/x86/include/asm/irqflags.h:75 arch/x86/mm/fault.c:1527
> arch/x86/mm/fault.c:1575)
>     ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
>     ? __filemap_get_folio (arch/x86/include/asm/atomic.h:29
> include/linux/atomic/atomic-arch-fallback.h:1242
> include/linux/atomic/atomic-arch-fallback.h:1267
> include/linux/atomic/atomic-instrumented.h:608
> include/linux/page_ref.h:238 include/linux/page_ref.h:247
> include/linux/page_ref.h:280 include/linux/page_ref.h:313
> mm/filemap.c:1863 mm/filemap.c:1915)
>     filemap_fault (mm/filemap.c:3120)
>     ? preempt_count_add (include/linux/ftrace.h:950
> kernel/sched/core.c:5685 kernel/sched/core.c:5682
> kernel/sched/core.c:5710)
>     __do_fault (mm/memory.c:4234)
>     do_fault (mm/memory.c:4564 mm/memory.c:4692)
>     __handle_mm_fault (mm/memory.c:4964 mm/memory.c:5106)
>     handle_mm_fault (mm/memory.c:5227)
>     do_user_addr_fault (include/linux/sched/signal.h:433
> arch/x86/mm/fault.c:1430)
>     exc_page_fault (arch/x86/include/asm/irqflags.h:40
> arch/x86/include/asm/irqflags.h:75 arch/x86/mm/fault.c:1527
> arch/x86/mm/fault.c:1575)
>     asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
>     RIP: 0033:0x268b8b9
>     Code: 70 48 89 4c 24 78 48 8b 94 24 b8 00 00 00 0f 1f 00 48 85 d2
> 74 3f 48 89 ce 48 29 d9 4c 8d 49 04 49 f7 d9 49 c1 f9 3f 49 21 f9 <46>
> 8b 0c 08 44 89 4c 24 34 90 90 48 89 d3 48 89 c1 41 b8 01 00 00
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       0: 70 48                jo     0x4a
>       2: 89 4c 24 78          mov    %ecx,0x78(%rsp)
>       6: 48 8b 94 24 b8 00 00 mov    0xb8(%rsp),%rdx
>       d: 00
>       e: 0f 1f 00              nopl   (%rax)
>       11: 48 85 d2              test   %rdx,%rdx
>       14: 74 3f                je     0x55
>       16: 48 89 ce              mov    %rcx,%rsi
>       19: 48 29 d9              sub    %rbx,%rcx
>       1c: 4c 8d 49 04          lea    0x4(%rcx),%r9
>       20: 49 f7 d9              neg    %r9
>       23: 49 c1 f9 3f          sar    $0x3f,%r9
>       27: 49 21 f9              and    %rdi,%r9
>       2a:* 46 8b 0c 08          mov    (%rax,%r9,1),%r9d <-- trapping
> instruction
>       2e: 44 89 4c 24 34        mov    %r9d,0x34(%rsp)
>       33: 90                    nop
>       34: 90                    nop
>       35: 48 89 d3              mov    %rdx,%rbx
>       38: 48 89 c1              mov    %rax,%rcx
>       3b: 41                    rex.B
>       3c: b8                    .byte 0xb8
>       3d: 01 00                add    %eax,(%rax)
>       ...
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       0: 46 8b 0c 08          mov    (%rax,%r9,1),%r9d
>       4: 44 89 4c 24 34        mov    %r9d,0x34(%rsp)
>       9: 90                    nop
>       a: 90                    nop
>       b: 48 89 d3              mov    %rdx,%rbx
>       e: 48 89 c1              mov    %rax,%rcx
>       11: 41                    rex.B
>       12: b8                    .byte 0xb8
>       13: 01 00                add    %eax,(%rax)
>       ...
>     RSP: 002b:000000cbc509f520 EFLAGS: 00010202
>     RAX: 00007e81cf427e0c RBX: 00000000000222cc RCX: 00000000123817b2
>     RDX: 000000c00001ac00 RSI: 00000000123a3a7e RDI: 00000000000222c8
>     RBP: 000000cbc509f5b0 R08: 0000000003cb5910 R09: 00000000000222c8
>     R10: 000000c4de3dea00 R11: 0000000000000123 R12: 0000000000000000
>     R13: 0000000000000005 R14: 000000c83bad2340 R15: 0000010000000000
>     </TASK>
>     Modules linked in: xt_connlabel xt_MASQUERADE nf_conntrack_netlink
> xfrm_user xfrm_algo xt_addrtype br_netfilter bridge overlay zstd
> zstd_compress zram zsmalloc tun tcp_diag inet_diag raid0 md_mod essiv
> dm_crypt trusted asn1_encoder tee ip6table_filter ip6table_mangle
> ip6table_raw ip6table_security ip6table_nat ip6_tables xt_bpf
> xt_conntrack xt_multiport xt_set iptable_filter xt_NFLOG nfnetlink_log
> xt_connbytes xt_comment xt_connmark xt_statistic iptable_mangle xt_nat
> xt_tcpudp iptable_nat nf_nat xt_CT iptable_raw ip_set_hash_ip
> ip_set_hash_net ip_set nfnetlink sch_fq nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 8021q garp mrp stp llc bonding nvme_fabrics amd64_edac
> kvm_amd ipmi_ssif kvm irqbypass crc32_pclmul crc32c_intel sha512_ssse3
> acpi_ipmi mlx5_core aesni_intel ipmi_si mlxfw rapl xhci_pci nvme tls
> ipmi_devintf tiny_power_button psample nvme_core xhci_hcd i2c_piix4
> ccp ipmi_msghandler button fuse dm_mod dax efivarfs ip_tables x_tables
> bcmcrypt(O)
>     crypto_simd cryptd
>     CR2: 0000000000000036
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:__filemap_get_folio (arch/x86/include/asm/atomic.h:29
> include/linux/atomic/atomic-arch-fallback.h:1242
> include/linux/atomic/atomic-arch-fallback.h:1267
> include/linux/atomic/atomic-instrumented.h:608
> include/linux/page_ref.h:238 include/linux/page_ref.h:247
> include/linux/page_ref.h:280 include/linux/page_ref.h:313
> mm/filemap.c:1863 mm/filemap.c:1915)
>     Code: 10 e8 99 ac 84 00 48 3d 06 04 00 00 49 89 c4 74 e2 48 3d 02
> 04 00 00 74 da 48 85 c0 0f 84 2e 02 00 00 a8 01 0f 85 e3 00 00 00 <8b>
> 40 34 85 c0 74 c2 8d 50 01 4d 8d 7c 24 34 f0 41 0f b1 54 24 34
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       0: 10 e8                adc    %ch,%al
>       2: 99                    cltd
>       3: ac                    lods   %ds:(%rsi),%al
>       4: 84 00                test   %al,(%rax)
>       6: 48 3d 06 04 00 00    cmp    $0x406,%rax
>       c: 49 89 c4              mov    %rax,%r12
>       f: 74 e2                je     0xfffffffffffffff3
>       11: 48 3d 02 04 00 00    cmp    $0x402,%rax
>       17: 74 da                je     0xfffffffffffffff3
>       19: 48 85 c0              test   %rax,%rax
>       1c: 0f 84 2e 02 00 00    je     0x250
>       22: a8 01                test   $0x1,%al
>       24: 0f 85 e3 00 00 00    jne    0x10d
>       2a:* 8b 40 34              mov    0x34(%rax),%eax <-- trapping inst=
ruction
>       2d: 85 c0                test   %eax,%eax
>       2f: 74 c2                je     0xfffffffffffffff3
>       31: 8d 50 01              lea    0x1(%rax),%edx
>       34: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       39: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       0: 8b 40 34              mov    0x34(%rax),%eax
>       3: 85 c0                test   %eax,%eax
>       5: 74 c2                je     0xffffffffffffffc9
>       7: 8d 50 01              lea    0x1(%rax),%edx
>       a: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       f: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>     RSP: 0000:ffffaf5587cdfc60 EFLAGS: 00010246
>     RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000002
>     RDX: 0000000000000008 RSI: ffffa45181fa8000 RDI: ffffaf5587cdfc70
>     RBP: 0000000000000000 R08: 0000000000000402 R09: 000000000006e44f
>     R10: 000000000006e450 R11: 000000000006e448 R12: 0000000000000002
>     R13: ffffa3fff6fdfeb0 R14: 000000000006e44a R15: 00000000000000d1
>     FS:  000000c9e385ac90(0000) GS:ffffa4153fc40000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000036 CR3: 000000296a1bc002 CR4: 0000000000770ee0
>     PKRU: 55555554
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000076
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 7acd78067 P4D 7acd78067 PUD 7acd79067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 93 PID: 3784417 Comm: prometheus Tainted: G           O
> 6.1.20-cloudflare-2023.3.18 #1
>     Hardware name: GIGABYTE R162-Z13-CD/MZ12-HD2-CD, BIOS R13 07/17/2020
>     RIP: 0010:__filemap_get_folio (arch/x86/include/asm/atomic.h:29
> include/linux/atomic/atomic-arch-fallback.h:1242
> include/linux/atomic/atomic-arch-fallback.h:1267
> include/linux/atomic/atomic-instrumented.h:608
> include/linux/page_ref.h:238 include/linux/page_ref.h:247
> include/linux/page_ref.h:280 include/linux/page_ref.h:313
> mm/filemap.c:1863 mm/filemap.c:1915)
>     Code: 10 e8 b9 a4 84 00 48 3d 06 04 00 00 49 89 c4 74 e2 48 3d 02
> 04 00 00 74 da 48 85 c0 0f 84 2e 02 00 00 a8 01 0f 85 e3 00 00 00 <8b>
> 40 34 85 c0 74 c2 8d 50 01 4d 8d 7c 24 34 f0 41 0f b1 54 24 34
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>        0: 10 e8                adc    %ch,%al
>        2: b9 a4 84 00 48        mov    $0x480084a4,%ecx
>        7: 3d 06 04 00 00        cmp    $0x406,%eax
>        c: 49 89 c4              mov    %rax,%r12
>        f: 74 e2                je     0xfffffffffffffff3
>       11: 48 3d 02 04 00 00    cmp    $0x402,%rax
>       17: 74 da                je     0xfffffffffffffff3
>       19: 48 85 c0              test   %rax,%rax
>       1c: 0f 84 2e 02 00 00    je     0x250
>       22: a8 01                test   $0x1,%al
>       24: 0f 85 e3 00 00 00    jne    0x10d
>       2a:* 8b 40 34              mov    0x34(%rax),%eax <-- trapping inst=
ruction
>       2d: 85 c0                test   %eax,%eax
>       2f: 74 c2                je     0xfffffffffffffff3
>       31: 8d 50 01              lea    0x1(%rax),%edx
>       34: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       39: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>        0: 8b 40 34              mov    0x34(%rax),%eax
>        3: 85 c0                test   %eax,%eax
>        5: 74 c2                je     0xffffffffffffffc9
>        7: 8d 50 01              lea    0x1(%rax),%edx
>        a: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>        f: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>     RSP: 0000:ffffb15106683c60 EFLAGS: 00010246
>     RAX: 0000000000000042 RBX: 0000000000000000 RCX: 0000000000000002
>     RDX: 0000000000000018 RSI: ffff934b0029efc8 RDI: ffffb15106683c70
>     RBP: 0000000000000000 R08: 0000000000000402 R09: 00000000000cbe5f
>     R10: 00000000000cbe60 R11: 00000000000cbe5c R12: 0000000000000042
>     R13: ffff93449c251eb0 R14: 00000000000cbe59 R15: 00000000000000d1
>     FS:  000000c000300090(0000) GS:ffff937e6ed40000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000076 CR3: 0000000a6528e000 CR4: 0000000000350ee0
>     Call Trace:
>      <TASK>
>     filemap_fault (mm/filemap.c:3120)
>     ? preempt_count_add (include/linux/ftrace.h:950
> kernel/sched/core.c:5685 kernel/sched/core.c:5682
> kernel/sched/core.c:5710)
>     __do_fault (mm/memory.c:4234)
>     do_fault (mm/memory.c:4564 mm/memory.c:4692)
>     __handle_mm_fault (mm/memory.c:4964 mm/memory.c:5106)
>     handle_mm_fault (mm/memory.c:5227)
>     do_user_addr_fault (include/linux/sched/signal.h:433
> arch/x86/mm/fault.c:1430)
>     exc_page_fault (arch/x86/include/asm/irqflags.h:40
> arch/x86/include/asm/irqflags.h:75 arch/x86/mm/fault.c:1527
> arch/x86/mm/fault.c:1575)
>     asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
>     RIP: 0033:0x268b8b9
>     Code: 70 48 89 4c 24 78 48 8b 94 24 b8 00 00 00 0f 1f 00 48 85 d2
> 74 3f 48 89 ce 48 29 d9 4c 8d 49 04 49 f7 d9 49 c1 f9 3f 49 21 f9 <46>
> 8b 0c 08 44 89 4c 24 34 90 90 48 89 d3 48 89 c1 41 b8 01 00 00
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>        0: 70 48                jo     0x4a
>        2: 89 4c 24 78          mov    %ecx,0x78(%rsp)
>        6: 48 8b 94 24 b8 00 00 mov    0xb8(%rsp),%rdx
>        d: 00
>        e: 0f 1f 00              nopl   (%rax)
>       11: 48 85 d2              test   %rdx,%rdx
>       14: 74 3f                je     0x55
>       16: 48 89 ce              mov    %rcx,%rsi
>       19: 48 29 d9              sub    %rbx,%rcx
>       1c: 4c 8d 49 04          lea    0x4(%rcx),%r9
>       20: 49 f7 d9              neg    %r9
>       23: 49 c1 f9 3f          sar    $0x3f,%r9
>       27: 49 21 f9              and    %rdi,%r9
>       2a:* 46 8b 0c 08          mov    (%rax,%r9,1),%r9d <-- trapping
> instruction
>       2e: 44 89 4c 24 34        mov    %r9d,0x34(%rsp)
>       33: 90                    nop
>       34: 90                    nop
>       35: 48 89 d3              mov    %rdx,%rbx
>       38: 48 89 c1              mov    %rax,%rcx
>       3b: 41                    rex.B
>       3c: b8                    .byte 0xb8
>       3d: 01 00                add    %eax,(%rax)
>     ...
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>        0: 46 8b 0c 08          mov    (%rax,%r9,1),%r9d
>        4: 44 89 4c 24 34        mov    %r9d,0x34(%rsp)
>        9: 90                    nop
>        a: 90                    nop
>        b: 48 89 d3              mov    %rdx,%rbx
>        e: 48 89 c1              mov    %rax,%rcx
>       11: 41                    rex.B
>       12: b8                    .byte 0xb8
>       13: 01 00                add    %eax,(%rax)
>     ...
>     RSP: 002b:000000d735bb3558 EFLAGS: 00010206
>     RAX: 00007c018402dad8 RBX: 000000000002c3d8 RCX: 0000000037f9be1c
>     RDX: 000000c000222c00 RSI: 0000000037fc81f4 RDI: 000000000002c3d4
>     RBP: 000000d735bb35e8 R08: 0000000003cb5910 R09: 000000000002c3d4
>     R10: 000000c385d2a000 R11: 0000000000000021 R12: 0000000000000000
>     R13: 000000000000000b R14: 000000d1bb70e340 R15: 0000000001000000
>      </TASK>
>     Modules linked in: veth xt_MASQUERADE nf_conntrack_netlink
> xfrm_user xfrm_algo xt_addrtype br_netfilter bridge overlay raid1
> md_mod essiv dm_crypt trusted tee asn1_encoder xt_hl ip6table_filter
> ip6table_mangle ip6table_raw ip6table_security ip6table_nat ip6_tables
> xt_tcpudp xt_conntrack xt_comment xt_multiport xt_set iptable_filter
> iptable_mangle iptable_nat nf_nat xt_CT iptable_raw ip_set_hash_ip
> ip_set_hash_net ip_set nfnetlink tcp_bbr sch_fq nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 8021q mrp garp stp llc bonding
> amd64_edac kvm_amd ipmi_ssif kvm irqbypass crc32_pclmul crc32c_intel
> mlx5_core sha512_ssse3 psample acpi_ipmi aesni_intel xhci_pci nvme
> ipmi_si rapl tls ipmi_devintf tiny_power_button nvme_core mlxfw
> xhci_hcd i2c_piix4 ccp ipmi_msghandler button fuse dm_mod dax efivarfs
> ip_tables x_tables bcmcrypt(O) crypto_simd cryptd
>     CR2: 0000000000000076
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:__filemap_get_folio (arch/x86/include/asm/atomic.h:29
> include/linux/atomic/atomic-arch-fallback.h:1242
> include/linux/atomic/atomic-arch-fallback.h:1267
> include/linux/atomic/atomic-instrumented.h:608
> include/linux/page_ref.h:238 include/linux/page_ref.h:247
> include/linux/page_ref.h:280 include/linux/page_ref.h:313
> mm/filemap.c:1863 mm/filemap.c:1915)
>     Code: 10 e8 b9 a4 84 00 48 3d 06 04 00 00 49 89 c4 74 e2 48 3d 02
> 04 00 00 74 da 48 85 c0 0f 84 2e 02 00 00 a8 01 0f 85 e3 00 00 00 <8b>
> 40 34 85 c0 74 c2 8d 50 01 4d 8d 7c 24 34 f0 41 0f b1 54 24 34
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>        0: 10 e8                adc    %ch,%al
>        2: b9 a4 84 00 48        mov    $0x480084a4,%ecx
>        7: 3d 06 04 00 00        cmp    $0x406,%eax
>        c: 49 89 c4              mov    %rax,%r12
>        f: 74 e2                je     0xfffffffffffffff3
>       11: 48 3d 02 04 00 00    cmp    $0x402,%rax
>       17: 74 da                je     0xfffffffffffffff3
>       19: 48 85 c0              test   %rax,%rax
>       1c: 0f 84 2e 02 00 00    je     0x250
>       22: a8 01                test   $0x1,%al
>       24: 0f 85 e3 00 00 00    jne    0x10d
>       2a:* 8b 40 34              mov    0x34(%rax),%eax <-- trapping inst=
ruction
>       2d: 85 c0                test   %eax,%eax
>       2f: 74 c2                je     0xfffffffffffffff3
>       31: 8d 50 01              lea    0x1(%rax),%edx
>       34: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>       39: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>        0: 8b 40 34              mov    0x34(%rax),%eax
>        3: 85 c0                test   %eax,%eax
>        5: 74 c2                je     0xffffffffffffffc9
>        7: 8d 50 01              lea    0x1(%rax),%edx
>        a: 4d 8d 7c 24 34        lea    0x34(%r12),%r15
>        f: f0 41 0f b1 54 24 34 lock cmpxchg %edx,0x34(%r12)
>     RSP: 0000:ffffb15106683c60 EFLAGS: 00010246
>     RAX: 0000000000000042 RBX: 0000000000000000 RCX: 0000000000000002
>     RDX: 0000000000000018 RSI: ffff934b0029efc8 RDI: ffffb15106683c70
>     RBP: 0000000000000000 R08: 0000000000000402 R09: 00000000000cbe5f
>     R10: 00000000000cbe60 R11: 00000000000cbe5c R12: 0000000000000042
>     R13: ffff93449c251eb0 R14: 00000000000cbe59 R15: 00000000000000d1
>     FS:  000000c000300090(0000) GS:ffff937e6ed40000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000076 CR3: 0000000a6528e000 CR4: 0000000000350ee0
>     note: prometheus[3784417] exited with irqs disabled
>
> 2. Kernel NULL pointer deferencences in xfs_read_iomap_begin
>
>     BUG: unable to handle page fault for address: 0000000000034668
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 11cfd37067 P4D 11cfd37067 PUD b88086067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 124 PID: 3831226 Comm: rocksdb:low Kdump: loaded Tainted: G
>      W  O L     6.1.27-cloudflare-2023.5.0 #1
>     Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_Lite, BIOS V0.11-sig 12/=
23/2022
>     RIP: 0010:xfs_read_iomap_begin (fs/xfs/xfs_iomap.c:1200)
>     Code: 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 50 48
> 89 14 24 4c 89 44 24 08 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 <48>
> 8b 87 >
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       0:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>       5:   41 57                   push   %r15
>       7:   41 56                   push   %r14
>       9:   41 55                   push   %r13
>       b:   41 54                   push   %r12
>       d:   55                      push   %rbp
>       e:   53                      push   %rbx
>       f:   48 83 ec 50             sub    $0x50,%rsp
>       13:   48 89 14 24             mov    %rdx,(%rsp)
>       17:   4c 89 44 24 08          mov    %r8,0x8(%rsp)
>       1c:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>       23:   00 00
>       25:   48 89 44 24 48          mov    %rax,0x48(%rsp)
>       2a:*  48                      rex.W           <-- trapping instruct=
ion
>       2b:   8b                      .byte 0x8b
>       2c:   87 00                   xchg   %eax,(%rax)
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       0:   48                      rex.W
>       1:   8b                      .byte 0x8b
>       2:   87 00                   xchg   %eax,(%rax)
>     RSP: 0018:ffffa63810733a70 EFLAGS: 00010282
>     RAX: 78ac714f0997e100 RBX: ffffa63810733b40 RCX: 0000000000000000
>     RDX: 0000000000004000 RSI: 0000000000000000 RDI: 00000000000347a0
>     RBP: ffffffff8664d950 R08: ffffa63810733b68 R09: ffffa63810733bb0
>     R10: 000000000001f627 R11: 0000000000000000 R12: ffffa63810733b68
>     R13: ffffa63810733bb0 R14: 00000000000019c1 R15: 00000000fffffff5
>     FS:  00007f48d8504700(0000) GS:ffffa2fe5ef00000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000034668 CR3: 00000013037ec001 CR4: 0000000000770ee0
>     PKRU: 55555554
>     Call Trace:
>     <TASK>
>     ? __mod_memcg_lruvec_state (mm/memcontrol.c:613 mm/memcontrol.c:799)
>     iomap_iter (fs/iomap/iter.c:76)
>     iomap_read_folio (fs/iomap/buffered-io.c:342)
>     ? xfs_end_bio (fs/xfs/xfs_aops.c:542)
>     filemap_read_folio (mm/filemap.c:2407)
>     filemap_get_pages (mm/filemap.c:2492 mm/filemap.c:2606)
>     filemap_read (mm/filemap.c:2677)
>     xfs_file_buffered_read (fs/xfs/xfs_file.c:278)
>     xfs_file_read_iter (fs/xfs/xfs_file.c:304)
>     vfs_read (fs/read_write.c:390 fs/read_write.c:470)
>     __x64_sys_pread64 (include/linux/file.h:44 fs/read_write.c:666
> fs/read_write.c:675 fs/read_write.c:672 fs/read_write.c:672)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>     RIP: 0033:0x7f49061ca917
>     Code: 08 89 3c 24 48 89 4c 24 18 e8 05 f4 ff ff 4c 8b 54 24 18 48
> 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48>
> 3d 00 >
>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       0:   08 89 3c 24 48 89       or     %cl,-0x76b7dbc4(%rcx)
>       6:   4c 24 18                rex.WR and $0x18,%al
>       9:   e8 05 f4 ff ff          call   0xfffffffffffff413
>       e:   4c 8b 54 24 18          mov    0x18(%rsp),%r10
>       13:   48 8b 54 24 10          mov    0x10(%rsp),%rdx
>       18:   41 89 c0                mov    %eax,%r8d
>       1b:   48 8b 74 24 08          mov    0x8(%rsp),%rsi
>       20:   8b 3c 24                mov    (%rsp),%edi
>       23:   b8 11 00 00 00          mov    $0x11,%eax
>       28:   0f 05                   syscall
>       2a:*  48                      rex.W           <-- trapping instruct=
ion
>       2b:   3d                      .byte 0x3d
>             ...
>
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       0:   48                      rex.W
>       1:   3d                      .byte 0x3d
>             ...
>     RSP: 002b:00007f48d84ffc70 EFLAGS: 00000293 ORIG_RAX: 000000000000001=
1
>     RAX: ffffffffffffffda RBX: 00000000018a0c90 RCX: 00007f49061ca917
>     RDX: 00000000000c294f RSI: 000000002265e000 RDI: 000000000000003c
>     RBP: 00007f48d84ffda0 R08: 0000000000000000 R09: 00007f48d84ffe60
>     R10: 000000000191dcd8 R11: 0000000000000293 R12: 0000000007c3c6c0
>     R13: 00000000000c294f R14: 00000000000c294f R15: 000000000191dcd8
>     </TASK>
>     Modules linked in: xt_connlabel overlay nft_compat esp4
> xt_hashlimit ip_set_hash_netport xt_length nf_conntrack_netlink
> mpls_gso mpls_iptunnel >
>     tcp_bbr sch_fq nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 8021q
> garp mrp stp llc ipmi_ssif amd64_edac kvm_amd kvm irqbypass
> crc32_pclmul crc32>
>     CR2: 0000000000034668
>     ---[ end trace 0000000000000000 ]---
>
> We also have a deadlock reading a very specific file on this host. We man=
aged to
> do a kdump on this host and extracted out the state of the mapping.
>
>
>     >>> trace
>     #0  context_switch (/cfsetup_build/build/linux/kernel/sched/core.c:52=
41:2)
>     #1  __schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6554:8=
)
>     #2  schedule (/cfsetup_build/build/linux/kernel/sched/core.c:6630:3)
>     #3  io_schedule (/cfsetup_build/build/linux/kernel/sched/core.c:8774:=
2)
>     #4  folio_wait_bit_common (/cfsetup_build/build/linux/mm/filemap.c:12=
96:4)
>     #5  folio_put_wait_locked (/cfsetup_build/build/linux/mm/filemap.c:14=
65:9)
>     #6  filemap_update_page (/cfsetup_build/build/linux/mm/filemap.c:2472=
:4)
>     #7  filemap_get_pages (/cfsetup_build/build/linux/mm/filemap.c:2606:9=
)
>     #8  filemap_read (/cfsetup_build/build/linux/mm/filemap.c:2676:11)
>     #9  xfs_file_buffered_read
> (/cfsetup_build/build/linux/fs/xfs/xfs_file.c:277:8)
>     #10 xfs_file_read_iter (/cfsetup_build/build/linux/fs/xfs/xfs_file.c:=
302:9)
>     #11 call_read_iter (/cfsetup_build/build/linux/include/linux/fs.h:219=
9:9)
>     #12 new_sync_read (/cfsetup_build/build/linux/fs/read_write.c:389:8)
>     #13 vfs_read (/cfsetup_build/build/linux/fs/read_write.c:470:9)
>     #14 ksys_read (/cfsetup_build/build/linux/fs/read_write.c:613:9)
>     #15 do_syscall_x64
> (/cfsetup_build/build/linux/arch/x86/entry/common.c:50:14)
>     #16 do_syscall_64 (/cfsetup_build/build/linux/arch/x86/entry/common.c=
:80:7)
>     #17 entry_SYSCALL_64+0x83/0x164
> (/cfsetup_build/build/linux/arch/x86/entry/entry_64.S:120)
>     #18 0x7f05f0b093ce
>     >>> folio =3D trace[6]['folio']
>     >>> decode_page_flags(folio)
>     'PG_locked|PG_waiters|PG_head'
>     >>> folio
>     *(struct folio *)0xffffd67406346000 =3D {
>             .flags =3D (unsigned long)13510764522438785,
>             .lru =3D (struct list_head){
>                     .next =3D (struct list_head *)0xdead000000000100,
>                     .prev =3D (struct list_head *)0xdead000000000122,
>             },
>             .__filler =3D (void *)0xdead000000000100,
>             .mlock_count =3D (unsigned int)290,
>             .mapping =3D (struct address_space *)0x0,
>             .index =3D (unsigned long)18446641474676726016,
>             .private =3D (void *)0x400000,
>             ._mapcount =3D (atomic_t){
>                     .counter =3D (int)-1,
>             },
>             ._refcount =3D (atomic_t){
>                     .counter =3D (int)1,
>             },
>             .memcg_data =3D (unsigned long)0,
>             .page =3D (struct page){
>                     .flags =3D (unsigned long)13510764522438785,
>                     .lru =3D (struct list_head){
>                             .next =3D (struct list_head *)0xdead000000000=
100,
>                             .prev =3D (struct list_head *)0xdead000000000=
122,
>                     },
>                     .__filler =3D (void *)0xdead000000000100,
>                     .mlock_count =3D (unsigned int)290,
>                     .buddy_list =3D (struct list_head){
>                             .next =3D (struct list_head *)0xdead000000000=
100,
>                             .prev =3D (struct list_head *)0xdead000000000=
122,
>                     },
>                     .pcp_list =3D (struct list_head){
>                             .next =3D (struct list_head *)0xdead000000000=
100,
>                             .prev =3D (struct list_head *)0xdead000000000=
122,
>                     },
>                     .mapping =3D (struct address_space *)0x0,
>                     .index =3D (unsigned long)18446641474676726016,
>                     .private =3D (unsigned long)4194304,
>                     .pp_magic =3D (unsigned long)16045481047390945536,
>                     .pp =3D (struct page_pool *)0xdead000000000122,
>                     ._pp_mapping_pad =3D (unsigned long)0,
>                     .dma_addr =3D (unsigned long)18446641474676726016,
>                     .dma_addr_upper =3D (unsigned long)4194304,
>                     .pp_frag_count =3D (atomic_long_t){
>                             .counter =3D (s64)4194304,
>                     },
>                     .compound_head =3D (unsigned long)1604548104739094553=
6,
>                     .compound_dtor =3D (unsigned char)34,
>                     .compound_order =3D (unsigned char)1,
>                     .compound_mapcount =3D (atomic_t){
>                             .counter =3D (int)-559087616,
>                     },
>                     .compound_pincount =3D (atomic_t){
>                             .counter =3D (int)0,
>                     },
>                     .compound_nr =3D (unsigned int)0,
>                     ._compound_pad_1 =3D (unsigned long)16045481047390945=
536,
>                     ._compound_pad_2 =3D (unsigned long)16045481047390945=
570,
>                     .deferred_list =3D (struct list_head){
>                             .next =3D (struct list_head *)0x0,
>                             .prev =3D (struct list_head *)0xffffa2afcd181=
900,
>                     },
>                     ._pt_pad_1 =3D (unsigned long)16045481047390945536,
>                     .pmd_huge_pte =3D (pgtable_t)0xdead000000000122,
>                     ._pt_pad_2 =3D (unsigned long)0,
>                     .pt_mm =3D (struct mm_struct *)0xffffa2afcd181900,
>                     .pt_frag_refcount =3D (atomic_t){
>                             .counter =3D (int)-854058752,
>                     },
>                     .ptl =3D (spinlock_t){
>                             .rlock =3D (struct raw_spinlock){
>                                     .raw_lock =3D (arch_spinlock_t){
>                                             .val =3D (atomic_t){
>                                                     .counter =3D (int)419=
4304,
>                                             },
>                                             .locked =3D (u8)0,
>                                             .pending =3D (u8)0,
>                                             .locked_pending =3D (u16)0,
>                                             .tail =3D (u16)64,
>                                     },
>                             },
>                     },
>                     .pgmap =3D (struct dev_pagemap *)0xdead000000000100,
>                     .zone_device_data =3D (void *)0xdead000000000122,
>                     .callback_head =3D (struct callback_head){
>                             .next =3D (struct callback_head *)0xdead00000=
0000100,
>                             .func =3D (void (*)(struct callback_head
> *))0xdead000000000122,
>                     },
>                     ._mapcount =3D (atomic_t){
>                             .counter =3D (int)-1,
>                     },
>                     .page_type =3D (unsigned int)4294967295,
>                     ._refcount =3D (atomic_t){
>                             .counter =3D (int)1,
>                     },
>                     .memcg_data =3D (unsigned long)0,
>             },
>             ._flags_1 =3D (unsigned long)13510764522373120,
>             .__head =3D (unsigned long)18446698392541487105,
>             ._folio_dtor =3D (unsigned char)1,
>             ._folio_order =3D (unsigned char)2,
>             ._total_mapcount =3D (atomic_t){
>                     .counter =3D (int)-1,
>             },
>             ._pincount =3D (atomic_t){
>                     .counter =3D (int)0,
>             },
>             ._folio_nr_pages =3D (unsigned int)4,
>     }
>     >>> for index, entry in
> xa_for_each(trace[7]['mapping'].i_pages.address_of_()):
>             print(index, entry, cast('struct folio *',
> entry).page.mapping.address_of_())
>     ....
>     6464 (void *)0xffffd674c130a000 *(struct address_space
> **)0xffffd674c130a018 =3D 0xffffa2b30e93b2b0
>     6528 (void *)0xffffd674beb22000 *(struct address_space
> **)0xffffd674beb22018 =3D 0xffffa2b30e93b2b0
>     6592 (void *)0xffffd67406346000 *(struct address_space
> **)0xffffd67406346018 =3D 0x0 <=3D=3D=3D=3D=3D our folio
>     6624 (void *)0x7037e8d8000100d (struct address_space **)0x7037e8d8000=
1025
>     6625 (void *)0x7037e047000100d (struct address_space **)0x7037e047000=
1025
>     ....
>
> This looks like the xarray is corrupted, and for some reason we have a
> locked folio
> in the mapping with a page with no mapping.
>
> Any suggestions on narrowing this down to a hypothesis to try to reproduc=
e this,
> or potential fixes are very much appreciated. We are also trying some
> different kernels
> configurations on different set of hosts to see if the problems go
> away for them, such as:
> - 6.1.36 without xfs: Support large folios
> 6795801366da0cd3d99e27c37f020a8f16714886
> - 6.1.36 without THP
> - 6.1.37 with the following series backported xfs, iomap: fix data
> corruption due to stale cached iomaps
> https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disa=
ster.area/
>
> Best,
> Daniel.
