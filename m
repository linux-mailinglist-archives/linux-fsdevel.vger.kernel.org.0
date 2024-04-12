Return-Path: <linux-fsdevel+bounces-16808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF458A31A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3482840F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8095147C65;
	Fri, 12 Apr 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt4w8qTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17734146D5F;
	Fri, 12 Apr 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933832; cv=none; b=mSdT2+h+kWerK01iz1QKTN2v4H4hfZLZzECabDVR4wz26dnI5VeJzcU20b91OYZcItd2SXG/4209Bg14cQloMxhldCe7lQ2T4G1HOaLaNmnk8S1i0YWJQVr342ONvIOknbMsjZwFV/SJ4toLolRgC39m/AkIvqGjPd70bBSgyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933832; c=relaxed/simple;
	bh=DJu1ruU/2it86iiNywivAApRohuSOMQ8YBfr0G0U1I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3PUz5iEbBF4FmW9B1t2cdCU2ZlNGl+jFcoTOuYDEWvmPvdmi/LXRPy1qHbavNyJW6PYIckh8UE3TzLp5c2sgHw7RN+i14XnibMtTtsX98i6YbEb6ysiey6/03WeWvGy62++1NRuqnu6l6qIFedeCugujproIo+29Qgw6zXV0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt4w8qTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DF7C113CC;
	Fri, 12 Apr 2024 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933831;
	bh=DJu1ruU/2it86iiNywivAApRohuSOMQ8YBfr0G0U1I0=;
	h=From:To:Cc:Subject:Date:From;
	b=nt4w8qTilNtnTpj+xcg/r10zFAbZ06lS+wtFg87+RHnE3WtDCh8TGLMCaNTQikjYb
	 K89hammQ+9ArbQuNifV0ERov/6nTbmJ9lfWFoOvYUuz4GmQy4XAAJNPl95xB2XvSCf
	 PXi611njBptUD7MhZC0wSX8nf5yZB4/W2CBiuh6o7AMvOJAeMJa8fjnDLbtyYP1Kor
	 sFCXU2KeZDt/goItO7y2Ka65dfDl+vQr/PJFHwowE4a92VseemlxgStSzdVCzI4218
	 WwEY6gqJkcO746T5h1SBP3hH+TcsKP0gEvULkwGlsijEgVi1Rgyg/mNtsYltkuVJaw
	 uoIuTqwqHLmzQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, Conor Dooley
 <conor@kernel.org>
Subject: riscv32 EXT4 splat, 6.8 regression?
Date: Fri, 12 Apr 2024 16:57:08 +0200
Message-ID: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I've been looking at an EXT4 splat on riscv32, that LKFT found [1]:

  | EXT4-fs (vda): mounted filesystem 13697a42-d10e-4a9e-8e56-cb9083be92f9 =
ro with ordered data mode. Quota mode: disabled.
  | VFS: Mounted root (ext4 filesystem) readonly on device 254:0.
  | Unable to handle kernel NULL pointer dereference at virtual address 000=
00006
  | Oops [#1]
  | Modules linked in:
  | CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0 #41
  | Hardware name: riscv-virtio,qemu (DT)
  | epc : ext4_search_dir+0x52/0xe4
  |  ra : __ext4_find_entry+0x1d6/0x578
  | epc : c035b60e ra : c035b876 sp : c253fc10
  |  gp : c21a7380 tp : c25c8000 t0 : 44c0657f
  |  t1 : 0000000c t2 : 1de5b089 s0 : c253fc50
  |  s1 : 00000000 a0 : fffffffc a1 : fffff000
  |  a2 : 00000000 a3 : c29c04f8 a4 : c253fd00
  |  a5 : 00000000 a6 : c253fcfc a7 : fffffff3
  |  s2 : 00001000 s3 : 00000000 s4 : 00001000
  |  s5 : c29c04f8 s6 : c292db40 s7 : c253fcfc
  |  s8 : fffffff7 s9 : c253fd00 s10: fffff000
  |  s11: c292db40 t3 : 00000007 t4 : 5e8b4525
  |  t5 : 00000000 t6 : 00000000
  | status: 00000120 badaddr: 00000006 cause: 0000000d
  | [<c035b60e>] ext4_search_dir+0x52/0xe4
  | [<c035b876>] __ext4_find_entry+0x1d6/0x578
  | [<c035bcaa>] ext4_lookup+0x92/0x200
  | [<c0295c14>] __lookup_slow+0x8e/0x142
  | [<c029943a>] walk_component+0x104/0x174
  | [<c0299f18>] path_lookupat+0x78/0x182
  | [<c029b24c>] filename_lookup+0x96/0x158
  | [<c029b346>] kern_path+0x38/0x56
  | [<c0c1bee4>] init_mount+0x46/0x96
  | [<c0c2ae1c>] devtmpfs_mount+0x44/0x7a
  | [<c0c01c26>] prepare_namespace+0x226/0x27c
  | [<c0c01130>] kernel_init_freeable+0x27e/0x2a0
  | [<c0b78402>] kernel_init+0x2a/0x158
  | [<c0b82bf2>] ret_from_fork+0xe/0x20
  | Code: 84ae a809 d303 0044 949a 0f63 0603 991a fd63 0584 (c603) 0064=20
  | ---[ end trace 0000000000000000 ]---
  | Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000000=
0b

This was not present in 6.7. Bisection wasn't really helpful (to me at
least); I got it down to commit c604110e662a ("Merge tag 'vfs-6.8.misc'
of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"), and when I
revert the commits in the vfs merge the splat went away, but I *really*
struggle to see how those are related...

What I see in ext4_search_dir() is that search_buf is 0xfffff000, and at
some point the address wraps to zero, and boom. I doubt that 0xfffff000
is a sane address.

Maybe this is something the the fs folks can spot directly? In the
meantime I'll continue to dig...


Thanks, and have a nice weeked!
Bj=C3=B6rn


[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6=
.8.4-281-g6d08df6c401e/testrun/23369914/suite/log-parser-test/tests/

