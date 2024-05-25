Return-Path: <linux-fsdevel+bounces-20147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44858CEDE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 06:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5108E1F21A91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 04:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088CA951;
	Sat, 25 May 2024 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxcN8Z+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7B4691;
	Sat, 25 May 2024 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611895; cv=none; b=Jsrobiv1/gOaxwaN1rC3odJalQQcXPIfjoSEW3otZxKFjADcPwSudvMe4Cjm/x73/8HydIl+2gw5qznOZ3oa31PU/w/7MFcIlHL5UA8uk5Y7PtUrhFvbVkLCPz0GksV+JgUd8sS8mL0eR8CnNtgwqlQ0lMrIqIKLIpfkpDxp2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611895; c=relaxed/simple;
	bh=ygi3KwrQbmFvRyvCTzW/j/rPVSMaVts9NBBE5ot04zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfTWx8Ygzy66/YPEd6AmxJdKEkpFxDYgQ9g42DSozvrNpgw+uOxatVXlqaO+XeRuVfu/BEy6FqPyx+thg2rkQ33jIpBp1GL3xEotMoS2xr9KY6B6EEc0ITu04OgN+0kuByrWJVDWsW6a5tpUrwaqIx//9a1BShMLxti8RG0Nfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxcN8Z+n; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so3598290e87.1;
        Fri, 24 May 2024 21:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716611892; x=1717216692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpa/U7JghcNpsn+qpJzea7q5OYNnmAkuecyejaHoCd4=;
        b=IxcN8Z+nofGSAVGZvZkI6OLXjOqxu5wreVTutPq1sOaTniDdeUwDK6Wi+MpX5sVi4O
         EKYRHwuGaAwztiL/1MYrqq0UxFd6EpKDbR7RR5x5nSe/OPjH2w1iqgsBz1oi3fxBfN7M
         VVQ1HbdQh/g6pX0h7789nsQgc5IWOqPD6qxzyzzD47SUe+oBNbYRMoSG6E2hSPOZRlx5
         +YPp+ZeMPs8Ri7GqbOLDRswN6upHmObYj7s4UiP+er1uVyjYyzTSWCEnpcskbCeDTXX6
         IaCejZMtU2eI83S+bte4hMk+5IepK0bgFR5Eeba3MiDN1qn6axBn6NsPvFyGnZzTPGA2
         0Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716611892; x=1717216692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpa/U7JghcNpsn+qpJzea7q5OYNnmAkuecyejaHoCd4=;
        b=eKqVH65Wr7BjurkeEexx+CpXIb/X9cKf0jMmnkyIYzzv6ozs12uWcYfoV+WekfD4u6
         QSq6xhs6jcAr8RRU+N+lWh4gZ2W0lCWfibXLWW4r1yqFfjxrOsGBBIVpJF7Hz4N/5kR2
         CrgSDeqhw3MN6IH5cRGWMYebJrHRIXgfIDSWuZYwLIExGqr3P/FpdsrGtaD5x3apP0p2
         y0mVPmKPRm+H84OzaPl+N6yURRyEbmZLrZfpSGWyyXhVLrEplU+ekVN+5MC0xWC7lkpd
         4Ry02Jjcx3Djji2A8F1lqlTUT2PSUel5xbadPZlwDfrQW1zQYHHGjSs7gyCCLA0AugJQ
         dskw==
X-Forwarded-Encrypted: i=1; AJvYcCVdCx4Ym8nxVeW/GLhWd48GqhsyvfZMkGu1/Xs99pLhoZwCxkzROwlu/Sl11qv1V8YTTVcxtnwgBCeJ5j+03o2AvbCxImXDFDRupA9seT35dczJHBDxEHbJXvLFxj8sBYRq4E+2O/V+UAiHzw==
X-Gm-Message-State: AOJu0Yy4TfKBuIFNAbE+FoGzwS+Skb0UKJIOnOud33Y+R4hRUqH7P9nu
	NYXPoPLOoE9yjOwJW+YTI8UUTo+Cz9LewLuTFKORq2uzfVLfWYONEq9CE/cvD/zLRrNneFSRqK2
	N++oGOuVyFyKdD2eW9SmQvBb7P0mHj2A1
X-Google-Smtp-Source: AGHT+IHp3iiFucD3eESbD2F4iLGJkvO3+UxacJCUUC4BUifXreeuECCB8wFyug22P8lyym01JzYnrfAm27paHYvGqYE=
X-Received: by 2002:a05:6512:210b:b0:51d:8c06:d662 with SMTP id
 2adb3069b0e04-527eee35c90mr2123572e87.5.1716611891973; Fri, 24 May 2024
 21:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000d480b060df43de5@google.com> <000000000000a8f1d606156b7ad9@google.com>
In-Reply-To: <000000000000a8f1d606156b7ad9@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 25 May 2024 13:37:55 +0900
Message-ID: <CAKFNMokh7p55gN0pC+=Lw=ZNEkfVyuzHr7dOisD-UMnncCBn=A@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
 (2)
To: syzbot <syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com>
Cc: linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 8:00=E2=80=AFPM syzbot
<syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    e8b0ccb2a787 Merge tag '9p-for-6.9-rc3' of https://github=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D115eb62318000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5112b3f484393=
436
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D47a017c46edb25e=
ff048
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D156679a1180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10f27ef618000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cf4b0d1e3b2d/dis=
k-e8b0ccb2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/422cac6cc940/vmlinu=
x-e8b0ccb2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a4df48e199b/b=
zImage-e8b0ccb2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/69e1e69e75=
22/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
> BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
> BUG: KMSAN: uninit-value in crc32_le_base+0x43c/0xd80 lib/crc32.c:197
>  crc32_body lib/crc32.c:110 [inline]
>  crc32_le_generic lib/crc32.c:179 [inline]
>  crc32_le_base+0x43c/0xd80 lib/crc32.c:197
>  nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:224 [inline]
>  nilfs_add_checksums_on_logs+0xb80/0xe40 fs/nilfs2/segbuf.c:327
>  nilfs_segctor_do_construct+0x9876/0xdeb0 fs/nilfs2/segment.c:2078
>  nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2381
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
>  nilfs_segctor_thread+0xc50/0x11e0 fs/nilfs2/segment.c:2573
>  kthread+0x3e2/0x540 kernel/kthread.c:388
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>
> Uninit was stored to memory at:
>  memcpy_from_iter lib/iov_iter.c:73 [inline]
>  iterate_bvec include/linux/iov_iter.h:122 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  __copy_from_iter lib/iov_iter.c:249 [inline]
>  copy_page_from_iter_atomic+0x12b7/0x2b60 lib/iov_iter.c:481
>  generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
>  __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4069
>  generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4095
>  __kernel_write_iter+0x68b/0xc40 fs/read_write.c:523
>  dump_emit_page fs/coredump.c:890 [inline]
>  dump_user_range+0x8dc/0xee0 fs/coredump.c:951
>  elf_core_dump+0x520f/0x59c0 fs/binfmt_elf.c:2077
>  do_coredump+0x32d5/0x4920 fs/coredump.c:764
>  get_signal+0x267e/0x2d00 kernel/signal.c:2896
>  arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
>  do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
>  dump_user_range+0x4a/0xee0 fs/coredump.c:935
>  elf_core_dump+0x520f/0x59c0 fs/binfmt_elf.c:2077
>  do_coredump+0x32d5/0x4920 fs/coredump.c:764
>  get_signal+0x267e/0x2d00 kernel/signal.c:2896
>  arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
>  do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> CPU: 0 PID: 5014 Comm: segctord Not tainted 6.9.0-rc2-syzkaller-00207-ge8=
b0ccb2a787 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz fix: x86: call instrumentation hooks from copy_mc.c

This is one of the false positive warnings that the memory dumped by
elf_core_dump() was mixed into the file system side via
copy_mc_to_kernel() of x86, which was called with the following call
path and did not support KMSAN until recently:

 elf_core_dump
   dump_user_range
      dump_page_copy
          copy_mc_to_kernel
      dump_emit_page
          ...

Given the syzbot CPU information, we can confirm that the x86 ERMS
feature flag is set, a condition that is affected by the issue.

The above commit, which was merged during the merge window for v6.10,
made copy_mc_to_kernel() on x86 KMSAN-compatible and should have fixed
this issue.

Ryusuke Konishi

