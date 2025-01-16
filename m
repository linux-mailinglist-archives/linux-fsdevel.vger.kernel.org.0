Return-Path: <linux-fsdevel+bounces-39419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A51A13EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255091670A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2022C9F8;
	Thu, 16 Jan 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWM00q04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC691DDA17;
	Thu, 16 Jan 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043394; cv=none; b=KNMWOUwT6z0lQnsidj2vpZsjv+ZVxN45rIWI8xKxqSHvwwLBdp3amctWlJi0F3w5LcBGDQUSloO3p1zUyWGz5bi+2EpzddAg1mxOW50He9H8I1XS5YUq+SQsBJOLK2/kqeC/ut5H8tky0EX225UJOpcvtwP/ZPVNdtI8YvC+sA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043394; c=relaxed/simple;
	bh=B4WWrdfyPzyg6P/rCdLT+5maDG988Eap2meYPO8DJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVMJzThG9p016EdeWvQAaZ9FxL9zv9VGHDEyWL1XT8Xv8oGxSBxJ2QGZXUIzXpVTX8sWL03PXpiL4Tsxsb0plWVACryUvkLBngtf/H4ZdVjvC1TTG0oMgoC0HK8J3oyWG0fKLqo1jXhzz9luvr+mwhPMfrOE9rfPeyZDXX7ZZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWM00q04; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso1656139a91.1;
        Thu, 16 Jan 2025 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737043392; x=1737648192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cjc73vmr+6d+cCHK9LbHRlOgCeST+/z+cFsCcZAbtIY=;
        b=SWM00q04quWyxeq8COsiZVP/r2tbhuXHGCNjEREnex/riIUQOsuGCyGNnnPNRb8CKD
         LKfCZcUOJ8hPc9+cMEP5AdbY9FYCbSVbQQHl8OgGSiU+OBPTIsaUkrFBFOKu1Irjg9qP
         PmviodPVUDSBjR1KYSMcLJOczN3Qvyh30m9jR4PYV8ifqcyJ/pNAQoxhJpsZKBG8WLvU
         w7iVl+usCHTG+6P42hEobTlP/7+Ow7yoc/B37dRPcwNzUi9VR9W0r0E2dtn4oZZyBo0Q
         EMKDEsyLmNsj9kGXQYBY59CBJSigE5O/fRR+hhx7ecaVS+A9WbqHAURiC/C3Z7VO3LGH
         6DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043392; x=1737648192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjc73vmr+6d+cCHK9LbHRlOgCeST+/z+cFsCcZAbtIY=;
        b=qqQydczP4cmjOh3YpcLRYHarOg1e/nNLDnazuuBUdgN9E1G2G59oUmkRvjaXZD2tIX
         lB2cm9SolzznBY0BJ0sDIbXolY6LZObXscwMliHnY6VHqgg+RrjS0Z+I7HcBdOfhTiHz
         cq4247b9UkWGUmuImIVbIaGEbSx4bwXWx9TWOkfi/iybkxdMRMH3ykQkkOxee+wso05b
         dCTaMqtg+/QEDKPgE2phUek/orRn441W593UU+ih7aS+hZAmV7Ngi5hGS+OXEAU1t9ZC
         lArDusMbkiP9air+k52akMm9GQiuaaXGxXNtmb4BI8Z1dDLDFlwLfDxmK5ByLyyMDzLh
         0ZDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+RmrdfJBNMdYNOUg3+1kNaSkiJLSnjxdZM4R8R8smag9HwNjrzM3giWl3u5ivcWVrLD2qamG6QlW2O9bP@vger.kernel.org
X-Gm-Message-State: AOJu0YyJA0aR4jqb02VwsASNlDsSXMS3YLUJtlx3bZWTVXeAa8reOpyI
	15/6Ksctx+A1ZUDWMgm1tNnD4DRt8fRQ+Eg3vJfn7Oc8q/Slav5FEEu/Q7ywIl8JBXAv322dfB+
	1v2F5Tmk4R/37GXfCIqhfJyXND8SFd+fZ
X-Gm-Gg: ASbGncsmrjaNJrDtkEMDVj5ajIq07b6tiJ3P07jIY+bb91srh4rgpPvdOsFiyGVWsx9
	oJCu2WYw4KZwzI/rXhthxvIACWh0ATAfHeFiT4A==
X-Google-Smtp-Source: AGHT+IGP84bD9CTF6kPx+8wLEIpMXD7+53O1GsSDd5rKm2L7VnE2Am/C1MroPsE9RrnyzjhvwVQ6kUK17hwZv+wcSCA=
X-Received: by 2002:a17:90b:2f03:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2f548eb32ffmr50941646a91.15.1737043391517; Thu, 16 Jan 2025
 08:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <266c50167604c606c95a6efe575de5430c31168b.camel@ibm.com> <CAOi1vP-=8QLaQqYTrZpe6s=hkAmNm8Z-upOeQvTQYY-uosxg8A@mail.gmail.com>
In-Reply-To: <CAOi1vP-=8QLaQqYTrZpe6s=hkAmNm8Z-upOeQvTQYY-uosxg8A@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 17:03:00 +0100
X-Gm-Features: AbW1kvYp_rFSppx2BPYqRYGUo78bNh3gobwm-vZDdbm4-pfhmdMC2jspW3rNELM
Message-ID: <CAOi1vP9jKOuBetRPZCDeUAdiOmQTYLKSSgX4YYQFt72H-t_j6A@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: Fix kernel crash in generic/397 test
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, David Howells <dhowells@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 10:23=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> =
wrote:
>
> On Wed, Jan 15, 2025 at 1:49=E2=80=AFAM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >
> > Hello,
> >
> > The generic/397 test generate kernel crash for the case of
> > encrypted inode with unaligned file size (for example, 33K
> > or 1K):
> >
> > Jan 3 12:34:40 ceph-testing-0001 root: run xfstest generic/397
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.737811] run fstests
> > generic/397 at 2025-01-03 12:34:40
> > Jan 3 12:34:40 ceph-testing-0001 systemd1: Started /usr/bin/bash c test
> > -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj;
> > exec ./tests/generic/397.
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.875761] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.876130] libceph:
> > client4614 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.991965] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.992334] libceph:
> > client4617 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017234] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017594] libceph:
> > client4620 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.031394] xfs_io (pid
> > 18988) is setting deprecated v1 encryption policy; recommend upgrading
> > to v2.
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054528] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054892] libceph:
> > client4623 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070287] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070704] libceph:
> > client4626 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.264586] libceph: mon0
> > (2)127.0.0.1:40674 session established
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.265258] libceph:
> > client4629 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374578] -----------[ cut
> > here ]------------
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374586] kernel BUG at
> > net/ceph/messenger.c:1070!
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.375150] Oops: invalid
> > opcode: 0000 [#1] PREEMPT SMP NOPTI
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378145] CPU: 2 UID: 0
> > PID: 4759 Comm: kworker/2:9 Not tainted 6.13.0-rc5+ #1
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378969] Hardware name:
> > QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-
> > ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.380167] Workqueue: ceph-
> > msgr ceph_con_workfn
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.381639] RIP:
> > 0010:ceph_msg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.382152] Code: 89 17 48
> > 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d
> > 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f
> > 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.383928] RSP:
> > 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.384447] RAX:
> > ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385129] RDX:
> > 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385839] RBP:
> > ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.386539] R10:
> > 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387203] R13:
> > ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387877] FS:
> > 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.388663] CS: 0010 DS:
> > 0000 ES: 0000 CR0: 0000000080050033
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389212] CR2:
> > 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389921] DR0:
> > 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.390620] DR3:
> > 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391307] PKRU: 55555554
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391567] Call Trace:
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391807] <TASK>
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392021] ?
> > show_regs+0x71/0x90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392391] ? die+0x38/0xa0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392667] ?
> > do_trap+0xdb/0x100
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392981] ?
> > do_error_trap+0x75/0xb0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393372] ?
> > ceph_msg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393842] ?
> > exc_invalid_op+0x53/0x80
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394232] ?
> > ceph_msg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394694] ?
> > asm_exc_invalid_op+0x1b/0x20
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395099] ?
> > ceph_msg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395583] ?
> > ceph_con_v2_try_read+0xd16/0x2220
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396027] ?
> > _raw_spin_unlock+0xe/0x40
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396428] ?
> > raw_spin_rq_unlock+0x10/0x40
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396842] ?
> > finish_task_switch.isra.0+0x97/0x310
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397338] ?
> > __schedule+0x44b/0x16b0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397738]
> > ceph_con_workfn+0x326/0x750
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398121]
> > process_one_work+0x188/0x3d0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398522] ?
> > __pfx_worker_thread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398929]
> > worker_thread+0x2b5/0x3c0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399310] ?
> > __pfx_worker_thread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399727]
> > kthread+0xe1/0x120
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400031] ?
> > __pfx_kthread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400431]
> > ret_from_fork+0x43/0x70
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400771] ?
> > __pfx_kthread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401127]
> > ret_from_fork_asm+0x1a/0x30
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401543] </TASK>
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401760] Modules linked
> > in: hctr2 nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha_generic
> > chacha_x86_64 libchacha adiantum libpoly1305 essiv authenc mptcp_diag
> > xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag
> > netlink_diag intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency_common skx_edac_common nfit kvm_intel kvm
> > crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic
> > ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel joydev
> > crypto_simd cryptd rapl input_leds psmouse sch_fq_codel serio_raw bochs
> > i2c_piix4 floppy qemu_fw_cfg i2c_smbus mac_hid pata_acpi msr parport_pc
> > ppdev lp parport efi_pstore ip_tables x_tables
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407319] ---[ end trace
> > 0000000000000000 ]---
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407775] RIP:
> > 0010:ceph_msg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.408317] Code: 89 17 48
> > 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d
> > 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f
> > 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410087] RSP:
> > 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410609] RAX:
> > ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.411318] RDX:
> > 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412014] RBP:
> > ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412735] R10:
> > 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.413438] R13:
> > ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414121] FS:
> > 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414935] CS: 0010 DS:
> > 0000 ES: 0000 CR0: 0000000080050033
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.415516] CR2:
> > 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416211] DR0:
> > 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416907] DR3:
> > 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.417630] PKRU: 55555554
> >
> > BUG_ON(length > msg->data_length) triggers the issue:
> >
> > (gdb) l *ceph_msg_data_cursor_init+0x42
> > 0xffffffff823b45a2 is in ceph_msg_data_cursor_init
> > (net/ceph/messenger.c:1070).
> > 1065
> > 1066 void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor
> > *cursor,
> > 1067 struct ceph_msg *msg, size_t length)
> > 1068 {
> > 1069 BUG_ON(!length);
> > 1070 BUG_ON(length > msg->data_length);
> > 1071 BUG_ON(!msg->num_data_items);
> > 1072
> > 1073 cursor->total_resid =3D length;
> > 1074 cursor->data =3D msg->data;
> >
> > The issue takes place because of this:
> > Jan 6 14:59:24 ceph-testing-0001 kernel: [ 202.628853] libceph: pid
> > 144:net/ceph/messenger_v2.c:2034 prepare_sparse_read_data(): msg-
> > >data_length 33792, msg->sparse_read_total 36864
> > 1070 BUG_ON(length > msg->data_length);
> > msg->sparse_read_total 36864 > msg->data_length 33792
> >
> > The generic/397 test (xfstests) executes such steps:
> > (1) create encrypted files and directories;
> > (2) access the created files and folders with encryption key;
> > (3) access the created files and folders without encryption key.
> >
> > We have issue because there is alignment of length before calling
> > ceph_osdc_new_request():
> >
> > Jan 8 12:49:22 ceph-testing-0001 kernel: [ 301.522120] ceph: pid
> > 8931:fs/ceph/crypto.h:148 ceph_fscrypt_adjust_off_and_len(): ino
> > 0x100000009d5: encrypted 0x4000, len 33792
> > Jan 8 12:49:22 ceph-testing-0001 kernel: [ 301.523706] ceph: pid
> > 8931:fs/ceph/crypto.h:155 ceph_fscrypt_adjust_off_and_len(): ino
> > 0x100000009d5: encrypted 0x4000, len 36864
> >
> > This patch uses unaligned size for retrieving file's content
> > from OSD and, then, aligned the size of sparse extent in the
> > case if inode is encrypted.
>
> Hi Slava,
>
> This doesn't seem right to me because in the case where a file is
> accessed with encryption key the whole block needs to be read from the
> OSD, or decryption wouldn't work.  Do tests where fscrypt is fully
> engaged (i.e. encryption key and everything else is present) and
> encrypted file contents are checked pass with this patch?

I spent some time looking into this.  The fact that op->extent.length
is 36864 while msg->data_length is 33792 suggests that the issue is
with the (only) OSD data item added to the read request: the extent is
rounded to CEPH_FSCRYPT_BLOCK_SIZE, but the data item remains short.
Here is the code in question:

    if (IS_ENCRYPTED(inode)) {
            struct page **pages;
            size_t page_off;

            err =3D iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len=
,
                                            &page_off);
            if (err < 0) {
                    doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
                          ceph_vinop(inode), err);
                    goto out;
            }

            /* should always give us a page-aligned read */
            WARN_ON_ONCE(page_off);
            len =3D err;
            err =3D 0;

            osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false,
                                             false);

My guess is that iov_iter_get_pages_alloc2() ends up returning
33792 even though it's called with max_size set to 36864 (the value of
adjusted len prior to "len =3D err" assignment).  The reason for that is
likely that subreq->io_iter iterator is already truncated to 33792 at
that point because that must be value of subreq->len.  Then, following
"len =3D err" assignment osd_req_op_extent_osd_data_pages() is passed
33792 even though there is presumably a full page available.

This looks like a regression introduced with ee4cdf7ba857 ("netfs:
Speed up buffered reading") because prior to that commit CephFS had its
own iterator which was set up with adjusted len instead of subreq->len:

    iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
                    subreq->start, len);

I wonder if this would "magically" fix itself if we just comment out
"len =3D err" assignment.  Slava, can you try that?  It's not a proper
fix but it would nail down the root cause.

I'm not up to speed on netfslib, so adding David to keep me straight.

Thanks,

                Ilya

