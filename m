Return-Path: <linux-fsdevel+bounces-31923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14099DA46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 01:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447291F234A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 23:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06271C302E;
	Mon, 14 Oct 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3BPhbdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49321D9A72;
	Mon, 14 Oct 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949298; cv=none; b=W3T58psZ4tFM1WDAH2Yj1a6CKgz7loh2vHNGYRa19TF+V10dQy8L4OZBsHTwDa1Lg7Oof8zzKmpnCngt2RbdCMu/I3oG1KJCF3YJV+7DHEjSiW1e9zPOmyo8iYRxW0WAPPk2g0ZVYkDV05JyFCr2uj70XsxLfy7dQtRmh9pqj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949298; c=relaxed/simple;
	bh=cLUPw0Bz7x/nGX/d2z/uMfeiTBz40vEKx7ZRUMDCIXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdxkD3hG0E47nPQhf/4CGoghlMUz7zOYpGP6QbvuvvMolCaJXjr4O1z+IuFjL9ctLgGIDN+RT4jW9qzSHbtBWMCqSykWA7o/odefy2BEBbFJgIr4UbKP3Sipm05xXuSQWBDijNWwBukf1i74G/74Oep2FbMYY4+OHVNu7NR0nIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3BPhbdB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e7086c231so580133b3a.0;
        Mon, 14 Oct 2024 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728949296; x=1729554096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK52o27K/sxt9HmES53yJ6IXLDUKoQtM4kWshgQf9a4=;
        b=f3BPhbdBCkOKap25qa6qVgfibs17k4O9i4PBS1HBNiwL+THx3v/ctXtrJficIRmGJn
         lZpthln/PwGhN4xJYCOCYcBdIQTG/TLSw02L4GEyt1aJAnEAO5bSVAMKU1tYytyDurPx
         t5jScleRvhdRAAKYLFgXzZ0A6UfkJoUj6ietlB3O33MeRnmfP0P2fPNRonYHxxwONCY7
         V+FwDb7m1sHxQNQxae3BWBL59mGf5Lbh6CZ7n/LBx9zgXCbjTN68lmazKEvyCRQ/F/Rw
         q21o4ald7I/Y5g4VUniuw72xUYQv2BfxbuKbNAfau2hH1FbQ/yk7gEXh4jZe52MXIOeI
         pC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949296; x=1729554096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bK52o27K/sxt9HmES53yJ6IXLDUKoQtM4kWshgQf9a4=;
        b=r61CxouDWYfoPhxiOBLiyERDCFijZ3QxmXCn6QJQWvSXEB9Zl56OYhXRO60bS8kuM0
         NoGjpFTDG7nzWTGVnag/bF7+alUyL0iNsE3HrFrT4/Vd7doh6u/mSBUOmEC6bjIGatMi
         SI+Apj1EnuE+M6lcvZyUAIwW0nOMSkzhUcFeXASXYYHAxOWoGdzqKM94iF1qF4qgJYX4
         3/blwdeKvvkGBFZGkWX3FwtcBKPlWPABXMg5FF2WlsNDN1SheUkEi85l6pyq1Yu8XSdC
         lbID/JeUoiHTqoEgSqz/01LCMS5qWfSp8UKJc3HNFoPVMORUvxKTszywB0GuqrDIOCRm
         T+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmmCfVybk+WoDb6umj3d3dG94zbHkfFAc8vAMmzBqV9nx2avIsqZU6spwHwQLSKVVifG0=@vger.kernel.org, AJvYcCVvdYbuXKg9J20xcvsNvIPwsjnG31QfL/w+BUr4ELeXEsj8ilpNYx8bXZ7SJ7iviV3S/LLZK7JrR2wR3pTD0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT1XRi699hVqXaRX7gl1Uve4xIjH3UY6Ol9XbV7kiCjX2kVka
	LveSDoiAg6padAmdZNHP1bQXgukyHofjKCCXYunFZJSiHRkxiDixfjxXz+KP1jMImQ9hdH1/t1r
	CG35XuTswJBvcL2zKtYQ7k9xLIeehbw==
X-Google-Smtp-Source: AGHT+IGHFa1V22MLVRYcRiiXB0DFIYqasAQr00M5QX3r/+G7CJO1LHeIByP4GF1F4OSYMedSo+2A/WzhQZbDCMnLGY4=
X-Received: by 2002:a05:6a00:1256:b0:71e:58be:3604 with SMTP id
 d2e1a72fcca58-71e58be513dmr12072639b3a.4.1728949295897; Mon, 14 Oct 2024
 16:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org> <20240829174232.3133883-6-andrii@kernel.org>
 <ZwyG8Uro/SyTXAni@ly-workstation>
In-Reply-To: <ZwyG8Uro/SyTXAni@ly-workstation>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Oct 2024 16:41:23 -0700
Message-ID: <CAEf4Bzak_+LzFZxRu-OvJrjgHgF81KMyF0S4nx1haoaQkAdnDg@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 05/10] lib/buildid: rename build_id_parse()
 into build_id_parse_nofault()
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Eduard Zingerman <eddyz87@gmail.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 7:51=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> Hi Andrii Nakryiko,
>
> Greetings!
>
> I used Syzkaller and found that there is BUG: unable to handle kernel pag=
ing request in build_id_parse_nofault
>

This is a memfd_secret() file, which needs a special treatment, I'll
post a fix soon, thanks for reporting!

> After bisection and the first bad commit is:
> "
> 45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nof=
ault()
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build=
_id_parse_nofault/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241012_22=
5717_build_id_parse_nofault/bzImage_8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7=
b
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241012_225717_build=
_id_parse_nofault/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b_dmesg.log
>
> "
> [   26.168603]  ? __pfx___build_id_parse.isra.0+0x10/0x10
> [   26.169447]  ? __pfx_d_path+0x10/0x10
> [   26.170068]  ? __kasan_kmalloc+0x88/0xa0
> [   26.170743]  build_id_parse_nofault+0x4d/0x60
> [   26.171473]  perf_event_mmap+0xb44/0xd90
> [   26.172134]  ? __pfx_perf_event_mmap+0x10/0x10
> [   26.172895]  mmap_region+0x4e7/0x29d0
> [   26.173526]  ? __pfx_mmap_region+0x10/0x10
> [   26.174210]  ? lockdep_hardirqs_on+0x89/0x110
> [   26.174956]  ? __kasan_check_read+0x15/0x20
> [   26.175655]  ? mark_lock.part.0+0xf3/0x17b0
> [   26.176369]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   26.177277]  ? arch_get_unmapped_area_topdown+0x3d6/0x710
> [   26.178195]  ? rcu_read_unlock+0x3b/0xc0
> [   26.178879]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   26.179808]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
> [   26.180634]  ? cap_mmap_addr+0x60/0x330
> [   26.181300]  ? security_mmap_addr+0x63/0x1b0
> [   26.182029]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   26.182930]  ? __get_unmapped_area+0x1a9/0x3b0
> [   26.183705]  do_mmap+0xd9b/0x11f0
> [   26.184291]  ? __pfx_do_mmap+0x10/0x10
> [   26.184938]  ? __pfx_down_write_killable+0x10/0x10
> [   26.185758]  vm_mmap_pgoff+0x1ea/0x390
> [   26.186413]  ? __pfx_vm_mmap_pgoff+0x10/0x10
> [   26.187129]  ? __fget_files+0x23c/0x4b0
> [   26.187803]  ksys_mmap_pgoff+0x3dc/0x520
> [   26.188490]  __x64_sys_mmap+0x139/0x1d0
> [   26.189143]  x64_sys_call+0x18c6/0x20d0
> [   26.189805]  do_syscall_64+0x6d/0x140
> [   26.190425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   26.191238] RIP: 0033:0x7fb10be3ee5d
> [   26.191837] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   26.194753] RSP: 002b:00007ffe95b14e28 EFLAGS: 00000212 ORIG_RAX: 0000=
000000000009
> [   26.195976] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb10=
be3ee5d
> [   26.197126] RDX: 0000000000000001 RSI: 0000000000002000 RDI: 000000002=
0000000
> [   26.198282] RBP: 00007ffe95b14f50 R08: 0000000000000004 R09: 000000000=
0000000
> [   26.199471] R10: 0000000000000011 R11: 0000000000000212 R12: 00007ffe9=
5b150a8
> [   26.200606] R13: 0000000000402eb7 R14: 0000000000404e08 R15: 00007fb10=
c078000
> [   26.201757]  </TASK>
> [   26.202132] Modules linked in:
> [   26.202663] CR2: ffff888010a44000
> [   26.203219] ---[ end trace 0000000000000000 ]---
> [   26.204002] RIP: 0010:memcmp+0x32/0x50
> [   26.204685] Code: 06 48 39 07 75 17 48 83 c7 08 48 83 c6 08 48 83 ea 0=
8 48 83 fa 07 77 e6 48 85 d2 74 20 31 c9 eb 09 48 83 c1 01 48 39 ca 74 0e <=
0f> b6 04 0f 44 0f b6 04 0e 44 29 c0 74 e9 c3 cc cc cc cc 31 c0 c3
> [   26.207669] RSP: 0018:ffff88801fa675f0 EFLAGS: 00010246
> [   26.208529] RAX: 0000000000000000 RBX: ffff88801fa67728 RCX: 000000000=
0000000
> [   26.209655] RDX: 0000000000000004 RSI: ffffffff86583240 RDI: ffff88801=
0a44000
> [   26.210801] RBP: ffff88801fa67750 R08: 0000000000000000 R09: fffff9400=
0085220
> [   26.211929] R10: 0000000000000012 R11: 0000000000000001 R12: ffff88801=
0a17c00
> [   26.213053] R13: ffff888010a44000 R14: dffffc0000000000 R15: 000000000=
0000000
> [   26.214186] FS:  00007fb10c02d800(0000) GS:ffff88806c500000(0000) knlG=
S:0000000000000000
> [   26.215467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.216393] CR2: ffff888010a44000 CR3: 00000000124e8000 CR4: 000000000=
0750ef0
> [   26.217533] PKRU: 55555554
> [   26.217989] note: repro[728] exited with irqs disabled
> "
>
> I hope you find it useful.
>
> Regards,
> Yi Lai
>
> ---
>

[...]

