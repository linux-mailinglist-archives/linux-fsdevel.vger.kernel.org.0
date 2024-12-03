Return-Path: <linux-fsdevel+bounces-36298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2869E1129
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFE61647E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B5558BB;
	Tue,  3 Dec 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Lv1YjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5B33CFC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192130; cv=none; b=mfH1UhkK7gqKxdL4yl05N7cjKedcQHNgRhoyR0/exs59WiOi4hEKDc7ox15j5kHF4kWMtVF0mB/iCIcDjUXhOjklfCX+jd/gnOndXGNEAroEoWFaSbousR3FMHvGY+Zw2S+r7hz41o5J2dRAGxcvznHuCwCrhvfYUblwMGzWvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192130; c=relaxed/simple;
	bh=hSIw31BHDv5TDglVjAhNL9kAbbpjGpqfBEq/VofFTIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf0w1k658+7KS+Ppft06AAUGpRNHWAHrtnHxin3q2TnvwyZDW4Le4UGj1BHFzxv+AvidRoGTBi5S0AjaMBv2OrwNgObFuNcLnw3uicnMS4hsDCcoWpECQf/aDAiSy4/0r1vV5k+Av9QsGYZXUnqoNq7BzH8hRmRntfebRLKggKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Lv1YjY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b68e73188cso258573385a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733192127; x=1733796927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfSMydoRR81hJZsdUfsBGe1AdHbNuc2ffXIxCy0+80c=;
        b=O6Lv1YjYww0kskIlE+X3cA4m8QViunsqBZBBVdwa2JiLiyruB1iUpRHbNLuSVrhh3n
         19ixhhrh5GvQnPp+iV+82PUbPyiA4VjMfuShTpocHi0AZ0oKLywu5v5EttvxSjt1gz8w
         7v7zzeXuyM+YllLW2LO8LMttX2DaRDjCar4Szzy3b57Jd6/lwUlaInzdDj1aYxH4o3Ri
         phIyFXWJa9cn599/SM+sekjLaCVCGNTEDd1In5UpXKC+SbpNyKEwt5Rnz4SrKSW6IDV1
         3tAdexczoFZE7fKAEPpD2uIMyTwhPls48mKBXFPkdRlaB4cCORZgEMMpQmH1XKf66s0w
         zqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192127; x=1733796927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfSMydoRR81hJZsdUfsBGe1AdHbNuc2ffXIxCy0+80c=;
        b=CGMbxT2UDnXqIzcVqxEa5L/U2MHwHGxbfH9alHtEbt+h4/WB1UQGL94GMX3SsF39c7
         xCykUw/QYhdjkBfDWF61bECE7z2S0P1QKbIwNaKl7om5Zp6Hj/fkXFAp0ctLx1ynbOBr
         AHiEY+643zBG535hyQpCjm928MbSIreArfE/Zx4WZbjwFLguNync9sftX8i+cvJ9rErU
         ElrWOqeWc8qyWsEncIv+26TbBXEz9yge5F0RmawzrfWupZ2zDW8gQfVcuVLK17fMf1X3
         RH2lHZutp09DpwapontUVWro8PRbyeZ/q53sdzohscXXGV3CCbpPUvvqYGc2zjGwE1d/
         a97g==
X-Forwarded-Encrypted: i=1; AJvYcCXt72I2kBjArAM4jF0M82n0V9o+ko4Bl91DTOvapxL7kqnMc6dFG+RYISDpIw9i03MEer4r4CXB/44U7sQn@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtagybEabWGeYTIr563AyGhysQuhxdK1K+JxzrPiBpS/v+XTW
	TRgY4Rqg7u81+wyfYO5WAjFbq3rZM0sWws1eGctnPm5IbKN41sUrhQZGNur7ucjDCuMqCRAzsIS
	Il950j8K/qIiAVO68lZXrfbY6S86jmL3LBSgFM6AZ
X-Gm-Gg: ASbGncth76iKu9ECzkPoURErM+UjYO9z59iEkfeoWJiI8jU7G7iU2HuRqfySPISx0zb
	sm6FIHlKDkN6OG3sf7XuAz1kuSSkOow3nKg==
X-Google-Smtp-Source: AGHT+IFR60pEpkbdMDdZM7tLfYiB/vuUYepSXg1KltBZZ1T8gRqBdXDal4Z77VibByzkK5V7O3cfMfwFbTFQxWTzFCo=
X-Received: by 2002:ad4:5f85:0:b0:6d4:142d:8119 with SMTP id
 6a1803df08f44-6d8b7423a21mr15525506d6.42.1733192126691; Mon, 02 Dec 2024
 18:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411292300.61edbd37-lkp@intel.com>
In-Reply-To: <202411292300.61edbd37-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Dec 2024 10:14:50 +0800
Message-ID: <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9: BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:19=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#]" o=
n:
>
> commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix larg=
e folio support in async readahead")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba133d34=
1]
>
> in testcase: vm-scalability
> version: vm-scalability-x86_64-6f4ef16-0_20241103
> with following parameters:
>
>         runtime: 300s
>         test: mmap-xread-seq-mt
>         cpufreq_governor: performance
>
>
>
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @=
 2.90GHz (Cooper Lake) with 192G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@intel.=
com
>
>
> [  133.054592][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! =
[usemem:5463]
> [  133.062611][    C1] Modules linked in: xfs intel_rapl_msr intel_rapl_c=
ommon intel_uncore_frequency intel_uncore_frequency_common isst_if_mbox_msr=
 isst_if_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_therma=
l coretemp btrfs blake2b_generic xor kvm_intel raid6_pq libcrc32c kvm crct1=
0dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sd_mod rapl sg in=
tel_cstate ipmi_ssif acpi_power_meter binfmt_misc snd_pcm dax_hmem cxl_acpi=
 snd_timer cxl_port snd ast ahci mei_me cxl_core libahci soundcore drm_shme=
m_helper ioatdma i2c_i801 intel_uncore einj pcspkr libata megaraid_sas drm_=
kms_helper mei ipmi_si acpi_ipmi i2c_smbus dca intel_pch_thermal wmi ipmi_d=
evintf ipmi_msghandler joydev drm fuse loop dm_mod ip_tables
> [  133.127927][    C1] CPU: 1 UID: 0 PID: 5463 Comm: usemem Not tainted 6=
.12.0-rc6-00041-g13da30d6f915 #1
> [  133.137519][    C1] Hardware name: Inspur NF8260M6/NF8260M6, BIOS 06.0=
0.01 04/22/2022
> [ 133.145595][ C1] RIP: 0010:memset_orig (arch/x86/lib/memset_64.S:71)
> [ 133.150781][ C1] Code: c1 41 89 f9 41 83 e1 07 75 70 48 89 d1 48 c1 e9 =
06 74 35 0f 1f 44 00 00 48 ff c9 48 89 07 48 89 47 08 48 89 47 10 48 89 47 =
18 <48> 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d8
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c1 41 89 f9             roll   $0xf9,-0x77(%rcx)
>    4:   41 83 e1 07             and    $0x7,%r9d
>    8:   75 70                   jne    0x7a
>    a:   48 89 d1                mov    %rdx,%rcx
>    d:   48 c1 e9 06             shr    $0x6,%rcx
>   11:   74 35                   je     0x48
>   13:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   18:   48 ff c9                dec    %rcx
>   1b:   48 89 07                mov    %rax,(%rdi)
>   1e:   48 89 47 08             mov    %rax,0x8(%rdi)
>   22:   48 89 47 10             mov    %rax,0x10(%rdi)
>   26:   48 89 47 18             mov    %rax,0x18(%rdi)
>   2a:*  48 89 47 20             mov    %rax,0x20(%rdi)          <-- trapp=
ing instruction
>   2e:   48 89 47 28             mov    %rax,0x28(%rdi)
>   32:   48 89 47 30             mov    %rax,0x30(%rdi)
>   36:   48 89 47 38             mov    %rax,0x38(%rdi)
>   3a:   48 8d 7f 40             lea    0x40(%rdi),%rdi
>   3e:   75 d8                   jne    0x18
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 89 47 20             mov    %rax,0x20(%rdi)
>    4:   48 89 47 28             mov    %rax,0x28(%rdi)
>    8:   48 89 47 30             mov    %rax,0x30(%rdi)
>    c:   48 89 47 38             mov    %rax,0x38(%rdi)
>   10:   48 8d 7f 40             lea    0x40(%rdi),%rdi
>   14:   75 d8                   jne    0xffffffffffffffee
> [  133.170775][    C1] RSP: 0018:ffffc900126efa20 EFLAGS: 00000206
> [  133.177015][    C1] RAX: 0000000000000000 RBX: ffffea00a7c878c0 RCX: 0=
000000000000030
> [  133.185139][    C1] RDX: 0000000000001000 RSI: 0000000000000000 RDI: f=
fff88a9f21e33c0
> [  133.193229][    C1] RBP: ffff88a9f21e3000 R08: 0000000000000000 R09: 0=
000000000000000
> [  133.201373][    C1] R10: ffff88a9f21e3000 R11: 0000000000001000 R12: 0=
000000000000000
> [  133.209522][    C1] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
0000026b5fdf000
> [  133.217642][    C1] FS:  00007f21a47e86c0(0000) GS:ffff888c0f680000(00=
00) knlGS:0000000000000000
> [  133.226703][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  133.233410][    C1] CR2: 00005641d476a000 CR3: 0000000c4b6b6003 CR4: 0=
0000000007726f0
> [  133.241514][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  133.249679][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  133.257776][    C1] PKRU: 55555554
> [  133.261446][    C1] Call Trace:
> [  133.264848][    C1]  <IRQ>
> [ 133.267875][ C1] ? watchdog_timer_fn (kernel/watchdog.c:762)
> [ 133.273139][ C1] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:677)
> [ 133.278704][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1691 ker=
nel/time/hrtimer.c:1755)
> [ 133.284250][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1820)
> [ 133.289443][ C1] ? __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/=
apic.c:1038 arch/x86/kernel/apic/apic.c:1055)
> [ 133.295587][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/ap=
ic.c:1049 arch/x86/kernel/apic/apic.c:1049)
> [  133.301543][    C1]  </IRQ>
> [  133.304608][    C1]  <TASK>
> [ 133.307641][ C1] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/as=
m/idtentry.h:702)
> [ 133.313886][ C1] ? memset_orig (arch/x86/lib/memset_64.S:71)
> [ 133.318457][ C1] zero_user_segments (include/linux/highmem.h:280)
> [ 133.323465][ C1] iomap_readpage_iter (fs/iomap/buffered-io.c:392)
> [ 133.328698][ C1] ? xas_load (include/linux/xarray.h:175 include/linux/x=
array.h:1264 lib/xarray.c:240)
> [ 133.332919][ C1] iomap_readahead (fs/iomap/buffered-io.c:514 fs/iomap/b=
uffered-io.c:550)
> [ 133.337765][ C1] read_pages (mm/readahead.c:160)
> [ 133.342137][ C1] ? alloc_pages_mpol_noprof (mm/mempolicy.c:2267)
> [ 133.347774][ C1] page_cache_ra_unbounded (include/linux/fs.h:882 mm/rea=
dahead.c:291)
> [ 133.353303][ C1] filemap_fault (mm/filemap.c:3230 mm/filemap.c:3329)
> [ 133.357982][ C1] __do_fault (mm/memory.c:4882)
> [ 133.362292][ C1] do_read_fault (mm/memory.c:5297)
> [ 133.366985][ C1] do_pte_missing (mm/memory.c:5431 mm/memory.c:3965)
> [ 133.371754][ C1] __handle_mm_fault (mm/memory.c:5909)
> [ 133.376818][ C1] handle_mm_fault (mm/memory.c:6077)
> [ 133.381717][ C1] do_user_addr_fault (arch/x86/mm/fault.c:1339)
> [ 133.386820][ C1] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arc=
h/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.=
c:1539)
> [ 133.391500][ C1] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:62=
3)
> [  133.396396][    C1] RIP: 0033:0x55578aeb9acc
> [ 133.400849][ C1] Code: 00 00 e8 b7 f8 ff ff bf 01 00 00 00 e8 0d f9 ff =
ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 fc f8 ff ff 85 d2 74 08 48 8d 04 =
f7 <48> 8b 00 c3 48 8d 04 f7 48 89 30 b8 00 00 00 00 c3 41 54 55 53 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 00                   add    %al,(%rax)
>    2:   e8 b7 f8 ff ff          call   0xfffffffffffff8be
>    7:   bf 01 00 00 00          mov    $0x1,%edi
>    c:   e8 0d f9 ff ff          call   0xfffffffffffff91e
>   11:   89 c7                   mov    %eax,%edi
>   13:   e8 6c ff ff ff          call   0xffffffffffffff84
>   18:   bf 00 00 00 00          mov    $0x0,%edi
>   1d:   e8 fc f8 ff ff          call   0xfffffffffffff91e
>   22:   85 d2                   test   %edx,%edx
>   24:   74 08                   je     0x2e
>   26:   48 8d 04 f7             lea    (%rdi,%rsi,8),%rax
>   2a:*  48 8b 00                mov    (%rax),%rax              <-- trapp=
ing instruction
>   2d:   c3                      ret
>   2e:   48 8d 04 f7             lea    (%rdi,%rsi,8),%rax
>   32:   48 89 30                mov    %rsi,(%rax)
>   35:   b8 00 00 00 00          mov    $0x0,%eax
>   3a:   c3                      ret
>   3b:   41 54                   push   %r12
>   3d:   55                      push   %rbp
>   3e:   53                      push   %rbx
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 8b 00                mov    (%rax),%rax
>    3:   c3                      ret
>    4:   48 8d 04 f7             lea    (%rdi,%rsi,8),%rax
>    8:   48 89 30                mov    %rsi,(%rax)
>    b:   b8 00 00 00 00          mov    $0x0,%eax
>   10:   c3                      ret
>   11:   41 54                   push   %r12
>   13:   55                      push   %rbp
>   14:   53                      push   %rbx
>   15:   48                      rex.W

Is this issue consistently reproducible?
I attempted to reproduce it using the mmap-xread-seq-mt test case but
was unsuccessful.

--
Regards
Yafang

