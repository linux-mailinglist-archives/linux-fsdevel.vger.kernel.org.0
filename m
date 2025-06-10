Return-Path: <linux-fsdevel+bounces-51171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E00AD3A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 16:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155A01884AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066A298CC0;
	Tue, 10 Jun 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiVAdDjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AE28D8D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564168; cv=none; b=BsGnYs2N83tRb8/gfNBstjZqpHJ0/Bx5CaPOaj/BkwY0MiuDiY4HbuhvTtiwgQ5FOrgB0veeiJtXRId40ZbJNcXKy/zNlxmucTkenLX2hurz38lfInf8z/l/XMtjXttmuw0n0IcxR5cUiHzpoPPiZR5XNz4GKG12Kz7eCsXdhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564168; c=relaxed/simple;
	bh=tsjl021jJnlE1ZCQka0Oiy51tyGZa8TwQTly5lS+HCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9PeU0z4M9wkd97nUXz2PybjdRMHCaxUQOgvhhj5Nf373UOetr0iQ8cMesGTWIz16Zf0Uc2n7Y66/NU1HeXfAhKb+zgfa3KMbOf/OSKij80tF5MV5M2yO7umbbAeKj+ZEvPEfYmIbvLsRqjw4t7EHBr8Ejlq4Im4/Holzl/GObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiVAdDjC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5ac8fae12so333751cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749564165; x=1750168965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnLW18B8VsUBcQd/NXoAjFrz3PGRU9t04032/fVuU6Q=;
        b=oiVAdDjCkrnUDZwYj6kYUUCgTNR3CMDV01wzHOPhDCq7MT4g8eX7Zk3ruXizlakE8U
         1eG6wetCEpUUeqegNzZm579v0MAA5ZjkiudxeySutYvny6kNGm4fvSQ2zmCIvc63FYLH
         qrKIAtpWT2y+OrMFbp7/vVwgHw6Mod2uQa+12nFGSHoSFORnTlJgxgYqlRCe0M8QqoYJ
         UygLbV6AFVy3B0EctQe0MaVI7kUThyWNKUVcSV1tJ94u2gdH1i2sHLwFbqKyteBhAVy4
         4grDVMQWzSoNf48LVcsvWO0zdHouhLEOkQm43MN31iZzLk1RMUcmUaXcMK5FK2NHrrsT
         gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564165; x=1750168965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnLW18B8VsUBcQd/NXoAjFrz3PGRU9t04032/fVuU6Q=;
        b=mEl6JYgwrBFOXgHblTGMim026V1r7SxzG59AuZhyeYqa3WiZMGBhXpLQwMPzw4tbCQ
         zCgll5ceixRHsOa/hQguZoO8HpJ8vhtTnT1Bk4DPKKJgPF3Sa/gtAvb9PJSFVurHQXTb
         Xdv1M2+j4Sku9JNjDPmNqNu27FhOTu9cWaCGoRCzcKQGxnBvMqVPqnacBGbSepNkQ9OB
         cope+OmG7N3anPeatq0jEYFuYsZtZhqSz5nDjBtRtFvrAo7US74wbL4oZNxpiTYLOw2I
         Y+S9+uufXF1w/hAXLJEvJALNOkrpUduF/4J7gOgS9VHLUQFr/EbpCB4CUmrr6Bnny5ol
         tOaw==
X-Forwarded-Encrypted: i=1; AJvYcCU+iKRpKzOq4W7vgU84U9C3mL0gpP94NPqbQmnll1Rw6lDumlAcrxekinwxImK2+I4Pkq3kl0XB2RJfcEQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YypPzAcK8dnKTLbu3p8m2hVDRwGPqjncx5c1cx5JUQH7cjkSLk2
	1g1j7WvU9/lX4a66GS2bzqSSaU+Fs2Kr7Y7Kjrlyr6NnyXoRn29VODXg7BvyvX3LM5DkvANTxv/
	NrFqqWTncsMy1G9xqr3vXniStr2xdP8HxVlghLhtp
X-Gm-Gg: ASbGncuE0tI0X07N9lQNddVKMT9LVXZ9oUJOJ6dbc4+GZhGqFo1o+17EQr8hyl4AHN+
	NpRaiHLtxwZsxIhadaNOgTigbSM3xEjxGfOpfKJKfFT0tcXJsl6cqLkRLPO0SvyNkiR8qenlVjd
	9ZR/1wroq/zvPHfDKY8r2dCVvkyvr9zoVEjffyifxZd0a1nAe27Bxg20u9BpdZ8Sk8IfuVOcosK
	g==
X-Google-Smtp-Source: AGHT+IH9W21i1lf1LPmBXfLyUlPi/x4oZv22z/b9mfxCvBkRAicllB6O2cpJ6DFG7C2utnNZCFFnjFAEFZvvprI0igM=
X-Received: by 2002:a05:622a:348:b0:498:e884:7ca9 with SMTP id
 d75a77b69052e-4a6f0717bcdmr11509161cf.13.1749564164409; Tue, 10 Jun 2025
 07:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604231151.799834-7-surenb@google.com> <202506101503.903c6ffa-lkp@intel.com>
In-Reply-To: <202506101503.903c6ffa-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Jun 2025 07:02:28 -0700
X-Gm-Features: AX0GCFsjl4D8Uc5rVjy3-RnObOmTy76OWHF5IchL3CLBhnl5Vrn-JPvaGcHt4lA
Message-ID: <CAJuCfpGZuHFbm0Yd90vsj1B5BxVSTswci-SWZPLzsRU1hwzKmw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 12:51=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_include/linux/rwsem.h:#anon_vma_nam=
e" on:
>
> commit: 5c3ce17006c6188d249bc07bfa639f2d76bbd8ac ("[PATCH v4 6/7] mm/maps=
: read proc/pid/maps under per-vma lock")
> url: https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/se=
lftests-proc-add-proc-pid-maps-tearing-from-vma-split-test/20250605-071433
> patch link: https://lore.kernel.org/all/20250604231151.799834-7-surenb@go=
ogle.com/
> patch subject: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma l=
ock

Ah, I'll need to change anon_vma_name() to allow for only VMA to be
locked instead of doing mmap_assert_locked().

>
> in testcase: locktorture
> version:
> with following parameters:
>
>         runtime: 300s
>         test: cpuhotplug
>
>
>
> config: x86_64-randconfig-005-20250606
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------------------------------------=
-------+------------+------------+
> |                                                                        =
       | fa0f347301 | 5c3ce17006 |
> +------------------------------------------------------------------------=
-------+------------+------------+
> | WARNING:at_include/linux/rwsem.h:#anon_vma_name                        =
       | 0          | 10         |
> | RIP:anon_vma_name                                                      =
       | 0          | 10         |
> +------------------------------------------------------------------------=
-------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202506101503.903c6ffa-lkp@intel.=
com
>
>
> [   41.709983][  T353] ------------[ cut here ]------------
> [ 41.710541][ T353] WARNING: CPU: 1 PID: 353 at include/linux/rwsem.h:195=
 anon_vma_name (include/linux/rwsem.h:195)
> [   41.711251][  T353] Modules linked in:
> [   41.711616][  T353] CPU: 1 UID: 0 PID: 353 Comm: grep Tainted: G      =
          T   6.15.0-11198-g5c3ce17006c6 #1 PREEMPT  ce6b47a049c5ee6720891b=
d644c96f2c3c349eba
> [   41.712738][  T353] Tainted: [T]=3DRANDSTRUCT
> [   41.713101][  T353] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 41.713902][ T353] RIP: 0010:anon_vma_name (include/linux/rwsem.h:195)
> [ 41.714327][ T353] Code: 74 28 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c=
 38 00 74 08 48 89 df e8 ac 4b 02 00 48 8b 03 5b 41 5e 41 5f c3 cc cc cc cc=
 cc <0f> 0b eb d4 48 c7 c1 74 46 b4 89 80 e1 07 80 c1 03 38 c1 7c 87 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   74 28                   je     0x2a
>    2:   48 83 c3 40             add    $0x40,%rbx
>    6:   48 89 d8                mov    %rbx,%rax
>    9:   48 c1 e8 03             shr    $0x3,%rax
>    d:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
>   12:   74 08                   je     0x1c
>   14:   48 89 df                mov    %rbx,%rdi
>   17:   e8 ac 4b 02 00          call   0x24bc8
>   1c:   48 8b 03                mov    (%rbx),%rax
>   1f:   5b                      pop    %rbx
>   20:   41 5e                   pop    %r14
>   22:   41 5f                   pop    %r15
>   24:   c3                      ret
>   25:   cc                      int3
>   26:   cc                      int3
>   27:   cc                      int3
>   28:   cc                      int3
>   29:   cc                      int3
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   eb d4                   jmp    0x2
>   2e:   48 c7 c1 74 46 b4 89    mov    $0xffffffff89b44674,%rcx
>   35:   80 e1 07                and    $0x7,%cl
>   38:   80 c1 03                add    $0x3,%cl
>   3b:   38 c1                   cmp    %al,%cl
>   3d:   7c 87                   jl     0xffffffffffffffc6
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   eb d4                   jmp    0xffffffffffffffd8
>    4:   48 c7 c1 74 46 b4 89    mov    $0xffffffff89b44674,%rcx
>    b:   80 e1 07                and    $0x7,%cl
>    e:   80 c1 03                add    $0x3,%cl
>   11:   38 c1                   cmp    %al,%cl
>   13:   7c 87                   jl     0xffffffffffffff9c
>   15:   48                      rex.W
> [   41.715798][  T353] RSP: 0018:ffffc90002dcf9d8 EFLAGS: 00010246
> [   41.716286][  T353] RAX: 0000000000000000 RBX: ffff888135319c40 RCX: f=
fffc90002dcfa78
> [   41.716889][  T353] RDX: ffffc90002dcfa70 RSI: ffff88816ea2bc30 RDI: f=
fff88816d7485a8
> [   41.717509][  T353] RBP: ffffc90002dcfa80 R08: 0000000000000000 R09: 0=
000000000000002
> [   41.718117][  T353] R10: 0000000000000000 R11: ffffffff81ebd610 R12: d=
ffffc0000000000
> [   41.718710][  T353] R13: ffff888135319d10 R14: ffff888135319d10 R15: d=
ffffc0000000000
> [   41.719318][  T353] FS:  00007f17e7a81740(0000) GS:ffff88842312b000(00=
00) knlGS:0000000000000000
> [   41.719998][  T353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.720503][  T353] CR2: 000055c5de49dc78 CR3: 0000000135bcc000 CR4: 0=
0000000000406b0
> [   41.721114][  T353] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   41.721717][  T353] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   41.722373][  T353] Call Trace:
> [   41.722640][  T353]  <TASK>
> [ 41.722881][ T353] get_vma_name (fs/proc/task_mmu.c:?)
> [ 41.723253][ T353] show_map_vma (fs/proc/task_mmu.c:509)
> [ 41.723617][ T353] show_map (fs/proc/task_mmu.c:525)
> [ 41.723922][ T353] seq_read_iter (fs/seq_file.c:231)
> [ 41.724311][ T353] seq_read (fs/seq_file.c:162)
> [ 41.724653][ T353] vfs_read (fs/read_write.c:570)
> [ 41.724981][ T353] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> [ 41.725384][ T353] ksys_read (fs/read_write.c:715)
> [ 41.725703][ T353] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> [ 41.726174][ T353] do_syscall_64 (arch/x86/entry/syscall_64.c:?)
> [ 41.726538][ T353] ? find_held_lock (kernel/locking/lockdep.c:5353)
> [ 41.726900][ T353] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 =
arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 arc=
h/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532)
> [ 41.727288][ T353] ? do_user_addr_fault (arch/x86/include/asm/atomic.h:9=
3 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atom=
ic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h=
:432 include/linux/mmap_lock.h:142 include/linux/mmap_lock.h:237 arch/x86/m=
m/fault.c:1338)
> [ 41.727706][ T353] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep=
.c:473)
> [ 41.728190][ T353] ? exc_page_fault (arch/x86/mm/fault.c:1536)
> [ 41.728590][ T353] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:130)
> [   41.729073][  T353] RIP: 0033:0x7f17e7b7c19d
> [ 41.729432][ T353] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 54 0a 00 e8=
 49 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 24 0e 00 00 74 17 31 c0 0f=
 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   31 c0                   xor    %eax,%eax
>    2:   e9 c6 fe ff ff          jmp    0xfffffffffffffecd
>    7:   50                      push   %rax
>    8:   48 8d 3d 66 54 0a 00    lea    0xa5466(%rip),%rdi        # 0xa547=
5
>    f:   e8 49 ff 01 00          call   0x1ff5d
>   14:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>   1b:   00 00
>   1d:   80 3d 41 24 0e 00 00    cmpb   $0x0,0xe2441(%rip)        # 0xe246=
5
>   24:   74 17                   je     0x3d
>   26:   31 c0                   xor    %eax,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <=
-- trapping instruction
>   30:   77 5b                   ja     0x8d
>   32:   c3                      ret
>   33:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>   3a:   00 00 00
>   3d:   48                      rex.W
>   3e:   83                      .byte 0x83
>   3f:   ec                      in     (%dx),%al
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 5b                   ja     0x63
>    8:   c3                      ret
>    9:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>   10:   00 00 00
>   13:   48                      rex.W
>   14:   83                      .byte 0x83
>   15:   ec                      in     (%dx),%al
> [   41.730862][  T353] RSP: 002b:00007fffc13c12e8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000000
> [   41.731448][  T353] RAX: ffffffffffffffda RBX: 00007fffc13c138c RCX: 0=
0007f17e7b7c19d
> [   41.732038][  T353] RDX: 0000000000002000 RSI: 00007f17e7a20000 RDI: 0=
000000000000003
> [   41.732635][  T353] RBP: 00007fffc13c1390 R08: 00000000ffffffff R09: 0=
000000000000000
> [   41.733252][  T353] R10: 0000000000000022 R11: 0000000000000246 R12: 0=
000000000000003
> [   41.733850][  T353] R13: 0000000000001000 R14: 000055c5de485951 R15: 0=
000000000002000
> [   41.734481][  T353]  </TASK>
> [   41.734719][  T353] irq event stamp: 3793
> [ 41.735058][ T353] hardirqs last enabled at (3805): __console_unlock (ar=
ch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x=
86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/prin=
tk.c:2885)
> [ 41.735754][ T353] hardirqs last disabled at (3814): __console_unlock (k=
ernel/printk/printk.c:342)
> [ 41.736478][ T353] softirqs last enabled at (3488): handle_softirqs (arc=
h/x86/include/asm/preempt.h:27 kernel/softirq.c:426 kernel/softirq.c:607)
> [ 41.737219][ T353] softirqs last disabled at (3835): __irq_exit_rcu (arc=
h/x86/include/asm/atomic.h:23)
> [   41.737925][  T353] ---[ end trace 0000000000000000 ]---
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250610/202506101503.903c6ffa-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

