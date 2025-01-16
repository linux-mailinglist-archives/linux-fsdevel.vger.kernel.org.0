Return-Path: <linux-fsdevel+bounces-39385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B5A13684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B59166786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAEA1DA100;
	Thu, 16 Jan 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8c2IuNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E1D90B9;
	Thu, 16 Jan 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019422; cv=none; b=oiY7D8wXIxhA5H3vpiDbyC+JLtmRyhBmCyrQxFXhI9+6ZtruebxF0j8ishEMXbJggxK/0I8iuIa7g6nxvdtF+1jaXVEr492WGeZON3dvkWL26WTRNRbPGDqe0XVXR437pgsIIis4yWMIeGTgIFhlxU8sdNstRgwB8khylXeJN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019422; c=relaxed/simple;
	bh=cUGkjXEFT/BYKVjsYwCMfMVNJm0q2y/0EIybchsBXQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP7wviDILtnv7U+vKJXace7xic8US8kJ855zv367tVZ7RNnGBsjwiMUVa60NU0DRfM+PegGuVXVi8dUSpLHRbbosmlAr52uoN/NAsAykvBNBNGZNe2AyfYOjEEHRUQkHEgh7PvHM562y2DYCVC+hCl+mnKfM/pRy+XEpBN57JVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8c2IuNZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166360285dso11437515ad.1;
        Thu, 16 Jan 2025 01:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737019420; x=1737624220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE77ATpi3kcM+nR6Ab0QCrlxXbcqP6yiXbywo8HF7f0=;
        b=U8c2IuNZSG+93PbJHtEWLKpn61qnSxx7MZmYD1FJvehFplLTV/hFieNOn90PAzPljJ
         AwGJy/jAocOAnbylE8wLROIY4jZfdG3deIqULxD8Sm5/WAiEJdplmbj9wzD6qFIiM/Z6
         bfjiBUvhp4rWdevuYZ2pa/GqY/F/jSWZ8KSdkYn8yBIl9e8B7uy3uo+XwJ2sE/n4vDtj
         TKWCtl3J6bors6SWjTK4eqFjqr+hv/QC7KNWye/LrVfiJkkXh6ofFAUM9JUxjjjW5fDN
         i4o3HphqGmqfaxdhasnU5uGRCIqh1U0VHZLeZv6j8fNacmwXf7VFaBCa5wrVSWYkCs+x
         fH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019420; x=1737624220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE77ATpi3kcM+nR6Ab0QCrlxXbcqP6yiXbywo8HF7f0=;
        b=eve2jeu3jWKi88J+bQb56d5pW11wb+CWj6bHKTJ/WpfYlXb6L+HDQArH+xLT6EC+b7
         6APmhvYX1v2o0vUoYZ6Pv4zQwSUEtEsdrg9QLCPOiSXWol9rhN1A82UvqiiS5gQurOxT
         6kfFTHAWsdOrm0nt4cTbkSLgMd3mRrX8w0txzEHdR229ACudu3eMJFuLCdOO0p4e7USn
         xq1unTnuue0MWRr8TltSccSMPYBJsxyTc839mAUZA4Am+7o5Pf6luJ84ZUaD1b/s5CB4
         WceXmKEeMZw8jtu8X+1NZOjd5jzaRwcfcW2VHtkFaJNLjiLc1VBTZYtC77RAArEPWh3X
         ggaA==
X-Forwarded-Encrypted: i=1; AJvYcCUgs88JfYLThlEBt4fQqkW1W2P4O9jsRUEi/h8rSZDS3rY97ZKXAgPRetAcwOY8XMg0nilUYO/yen3A137w@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JQ4tscr4zugtEmrPy0moFO90xi5nDf/tJbsWbNGCRQfFdZvq
	gNnZQkcnEJGKH4s1BdcPp+D/6eNrGN7Ao+06dVdnicsF6lFnuKijL3ALR/GCCIBcwuahfnLNs3C
	+MMKCPy243FpZFUl6mS+4O3zpva0=
X-Gm-Gg: ASbGncuTC1i6uJDwxTcHj24eJlgZtC5IPW5Pdf/sLi18S74XbNxCFGQ/WYZv4QIX5y6
	mFUQCn8/3qbHWJjnn1WN5HPMX8M9EsNHvp+byxQ==
X-Google-Smtp-Source: AGHT+IGISm1pz6yTGA+EyLK90gsXNWw5osVz4EZQO1H67mRBz3AqZCH2InAbQOFD+EnkKW7V4GWh1ckuY+PUj0vl1t8=
X-Received: by 2002:a17:90a:fc48:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2f548ee4bb4mr46692704a91.20.1737019419760; Thu, 16 Jan 2025
 01:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <266c50167604c606c95a6efe575de5430c31168b.camel@ibm.com>
In-Reply-To: <266c50167604c606c95a6efe575de5430c31168b.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 10:23:28 +0100
X-Gm-Features: AbW1kva_xms4F52a8mZ_fqIMJwmD7whUbnIjuiNKsDQg5XmGOPzP33_5PmmssXg
Message-ID: <CAOi1vP-=8QLaQqYTrZpe6s=hkAmNm8Z-upOeQvTQYY-uosxg8A@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: Fix kernel crash in generic/397 test
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:49=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hello,
>
> The generic/397 test generate kernel crash for the case of
> encrypted inode with unaligned file size (for example, 33K
> or 1K):
>
> Jan 3 12:34:40 ceph-testing-0001 root: run xfstest generic/397
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.737811] run fstests
> generic/397 at 2025-01-03 12:34:40
> Jan 3 12:34:40 ceph-testing-0001 systemd1: Started /usr/bin/bash c test
> -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj;
> exec ./tests/generic/397.
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.875761] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.876130] libceph:
> client4614 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.991965] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.992334] libceph:
> client4617 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017234] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017594] libceph:
> client4620 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.031394] xfs_io (pid
> 18988) is setting deprecated v1 encryption policy; recommend upgrading
> to v2.
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054528] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054892] libceph:
> client4623 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070287] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070704] libceph:
> client4626 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.264586] libceph: mon0
> (2)127.0.0.1:40674 session established
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.265258] libceph:
> client4629 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374578] -----------[ cut
> here ]------------
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374586] kernel BUG at
> net/ceph/messenger.c:1070!
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.375150] Oops: invalid
> opcode: 0000 [#1] PREEMPT SMP NOPTI
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378145] CPU: 2 UID: 0
> PID: 4759 Comm: kworker/2:9 Not tainted 6.13.0-rc5+ #1
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378969] Hardware name:
> QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-
> ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.380167] Workqueue: ceph-
> msgr ceph_con_workfn
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.381639] RIP:
> 0010:ceph_msg_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.382152] Code: 89 17 48
> 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d
> 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f
> 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.383928] RSP:
> 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.384447] RAX:
> ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385129] RDX:
> 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385839] RBP:
> ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.386539] R10:
> 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387203] R13:
> ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387877] FS:
> 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.388663] CS: 0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389212] CR2:
> 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389921] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.390620] DR3:
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391307] PKRU: 55555554
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391567] Call Trace:
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391807] <TASK>
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392021] ?
> show_regs+0x71/0x90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392391] ? die+0x38/0xa0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392667] ?
> do_trap+0xdb/0x100
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392981] ?
> do_error_trap+0x75/0xb0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393372] ?
> ceph_msg_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393842] ?
> exc_invalid_op+0x53/0x80
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394232] ?
> ceph_msg_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394694] ?
> asm_exc_invalid_op+0x1b/0x20
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395099] ?
> ceph_msg_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395583] ?
> ceph_con_v2_try_read+0xd16/0x2220
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396027] ?
> _raw_spin_unlock+0xe/0x40
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396428] ?
> raw_spin_rq_unlock+0x10/0x40
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396842] ?
> finish_task_switch.isra.0+0x97/0x310
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397338] ?
> __schedule+0x44b/0x16b0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397738]
> ceph_con_workfn+0x326/0x750
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398121]
> process_one_work+0x188/0x3d0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398522] ?
> __pfx_worker_thread+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398929]
> worker_thread+0x2b5/0x3c0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399310] ?
> __pfx_worker_thread+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399727]
> kthread+0xe1/0x120
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400031] ?
> __pfx_kthread+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400431]
> ret_from_fork+0x43/0x70
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400771] ?
> __pfx_kthread+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401127]
> ret_from_fork_asm+0x1a/0x30
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401543] </TASK>
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401760] Modules linked
> in: hctr2 nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha_generic
> chacha_x86_64 libchacha adiantum libpoly1305 essiv authenc mptcp_diag
> xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag
> netlink_diag intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common skx_edac_common nfit kvm_intel kvm
> crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic
> ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel joydev
> crypto_simd cryptd rapl input_leds psmouse sch_fq_codel serio_raw bochs
> i2c_piix4 floppy qemu_fw_cfg i2c_smbus mac_hid pata_acpi msr parport_pc
> ppdev lp parport efi_pstore ip_tables x_tables
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407319] ---[ end trace
> 0000000000000000 ]---
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407775] RIP:
> 0010:ceph_msg_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.408317] Code: 89 17 48
> 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d
> 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f
> 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410087] RSP:
> 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410609] RAX:
> ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.411318] RDX:
> 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412014] RBP:
> ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412735] R10:
> 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.413438] R13:
> ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414121] FS:
> 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414935] CS: 0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.415516] CR2:
> 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416211] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416907] DR3:
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.417630] PKRU: 55555554
>
> BUG_ON(length > msg->data_length) triggers the issue:
>
> (gdb) l *ceph_msg_data_cursor_init+0x42
> 0xffffffff823b45a2 is in ceph_msg_data_cursor_init
> (net/ceph/messenger.c:1070).
> 1065
> 1066 void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor
> *cursor,
> 1067 struct ceph_msg *msg, size_t length)
> 1068 {
> 1069 BUG_ON(!length);
> 1070 BUG_ON(length > msg->data_length);
> 1071 BUG_ON(!msg->num_data_items);
> 1072
> 1073 cursor->total_resid =3D length;
> 1074 cursor->data =3D msg->data;
>
> The issue takes place because of this:
> Jan 6 14:59:24 ceph-testing-0001 kernel: [ 202.628853] libceph: pid
> 144:net/ceph/messenger_v2.c:2034 prepare_sparse_read_data(): msg-
> >data_length 33792, msg->sparse_read_total 36864
> 1070 BUG_ON(length > msg->data_length);
> msg->sparse_read_total 36864 > msg->data_length 33792
>
> The generic/397 test (xfstests) executes such steps:
> (1) create encrypted files and directories;
> (2) access the created files and folders with encryption key;
> (3) access the created files and folders without encryption key.
>
> We have issue because there is alignment of length before calling
> ceph_osdc_new_request():
>
> Jan 8 12:49:22 ceph-testing-0001 kernel: [ 301.522120] ceph: pid
> 8931:fs/ceph/crypto.h:148 ceph_fscrypt_adjust_off_and_len(): ino
> 0x100000009d5: encrypted 0x4000, len 33792
> Jan 8 12:49:22 ceph-testing-0001 kernel: [ 301.523706] ceph: pid
> 8931:fs/ceph/crypto.h:155 ceph_fscrypt_adjust_off_and_len(): ino
> 0x100000009d5: encrypted 0x4000, len 36864
>
> This patch uses unaligned size for retrieving file's content
> from OSD and, then, aligned the size of sparse extent in the
> case if inode is encrypted.

Hi Slava,

This doesn't seem right to me because in the case where a file is
accessed with encryption key the whole block needs to be read from the
OSD, or decryption wouldn't work.  Do tests where fscrypt is fully
engaged (i.e. encryption key and everything else is present) and
encrypted file contents are checked pass with this patch?

BTW this and other recent patches sent from Slava.Dubeyko@ibm.com
appear to be mangled and don't apply:

$ git am --show-current-patch=3Ddiff
---
 fs/ceph/addr.c | 30 ++++++++++++++++++++++++------
 fs/ceph/file.c | 20 +++++++++++++++++---
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 85936f6d2bf7..5a7a698ad8e8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -235,6 +235,15 @@ static void finish_netfs_read(struct
ceph_osd_request *req)
                    subreq->rreq->origin !=3D NETFS_DIO_READ)
                        __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq-
>flags);

The diff hunk header line, __set_bit() line and many more are wrapped.

Thanks,

                Ilya

