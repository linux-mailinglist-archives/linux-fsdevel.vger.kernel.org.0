Return-Path: <linux-fsdevel+bounces-39489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1DA14EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 13:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB8188B265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE71FF1AF;
	Fri, 17 Jan 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/ggTUjL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D51FC7FA;
	Fri, 17 Jan 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115604; cv=none; b=ob9ZWN3wZyys1k2S5mMJXjWtpuiH+oRtjq+JQwKPszkaot7ZifCY96TTvp41Udbx1C35MA7eqZy/as6r6NLWKORDM8mXFrsOLPrVx1FJVVAmxJPngy0TdViGxuL/kn/Bx/ZG9jgSBGi991HV97ThZRJHDNcWlXjsqzYqUYIhznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115604; c=relaxed/simple;
	bh=j49ao7QV5+3H41o0KGWJFYHyB0qvGUR9dhXPS1VTM7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDsZk+rKPzTqpU3/tLlznvWIUD83mFqXZSM295QeaTd23WS1jTcj/MVWA1vi958J1iElFX4jcSj3FB1iL4sP5rAbYPCKttdccHgrOQRaM1vnx0JYkJpRRQQCipxhdcz2YBgUk7kd/oydCRbragQ7LMl+x4qhxXPhHvQR2D2mle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/ggTUjL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2833749a91.0;
        Fri, 17 Jan 2025 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737115602; x=1737720402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV8mv/YPl6pgHX/4ourdS6hzYAOsA1PyznHp/07gvFk=;
        b=g/ggTUjL1meT3j3IizfG/n9WaTW3yJI2k0V9bxBK3ScRMkKNeYgcVvPXvPe2l35pHe
         qLc+ZF1oItti5GT4p1mev0PLmFyqUvuSyEf28QOQlt0NJktJAzI9bZ8tvnnPv9+dnGg5
         6wCN5XnWeY969yITihIf+DS/8fAlMLGZmeyAWxrwNjfgG1XbsfjAW4zlPg5ZZEKDhW5Y
         02at7vpoDfUM0mwBC4LaT2YKBiaCH02rav5k+Yt56wRM53xFtmOQYoOl+Ilg5jm4dRjd
         es2/aIvhTdCKKxBOueTWUmce3uueoiB7aQkM0McjXH7NwOLeuXMLMr8Axl4i6DmtSaLm
         vNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737115602; x=1737720402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV8mv/YPl6pgHX/4ourdS6hzYAOsA1PyznHp/07gvFk=;
        b=ihWkMX+5JXr9KZeBcVjrimAtnqSTfgYw4Gxh/RjXrfNgku59MXsQHDyRTjQCqUCjNf
         5BAf/U6g5iopAOvnoKzIESF6o+8kIXXqosbb/dXWBkldsX1+a6L53o2HBIPO8yhcwc4v
         PX/Th7m+H5qbu58pbMnbXutELtFLR0WWn+A/HIIYlXB6xp4de3UtjVafbeDyZ6sjcPOw
         uwHLby3Y5rEsBo9bI3r11qSB8DuPaZl7jNPGzOeKrGMkvbpG8yJEPeqgHkGrAxcXtCfQ
         0wkIgkZigjMa1vQkv2gLn5vGIuZtrU1rp897frFl1+p4oB1V/32O/rkYM1s08fdunxaV
         bx2A==
X-Forwarded-Encrypted: i=1; AJvYcCUiL+PmBHB9rM99i1x5esgq+wYWFZllPc+RdIiaq9+Gw2e98rVmbAl6wSKtPGew/wvJuzO+pmkrR2SHU92z@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/6aJT/HLw2+6X6GzVqlN7KXLg6Ql/Ea6DHSHjR8U//CeXbvC
	j7o/NyKZxOHJXZau7jDMEFL5HaYQ8rJk7PyhyY7S+o84MrByOwI6+a8gmc+EmKJ3/06IBeJgqFq
	fhfiEKMYfU/s7D7BrrmjUJADAAXoWhkpb
X-Gm-Gg: ASbGncvuM0AsszsGqcM+kT2SVgR07f08qs3HuPHIlnD+KOwHaJ3BddWowr7EiRcmCaH
	pVURZRw7DvVsGCEZehsb8ce9/sBxUCxxD2FyhCrN0RdLIzx5zkYA=
X-Google-Smtp-Source: AGHT+IEi8fQxhF0PxMtXe6h0vpZ4sUKLTwlfhgpgMugjbESw9vuWwwKXIJavDWQGdbR7KfmLD+JIVBdiaNoeuoqXSU4=
X-Received: by 2002:a17:90b:3a05:b0:2ee:c9b6:4c42 with SMTP id
 98e67ed59e1d1-2f782cb68fbmr3788656a91.16.1737115602008; Fri, 17 Jan 2025
 04:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117035044.23309-1-slava@dubeyko.com>
In-Reply-To: <20250117035044.23309-1-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 17 Jan 2025 13:06:30 +0100
X-Gm-Features: AbW1kvZcVDrBauUJjUXw3P2a4qpehoZp-bNquA6JHxc-cy40PHlpfM04XXm5uB4
Message-ID: <CAOi1vP97xPyka60H=bMh3xyOtumO+WQfMYF8NG0V545oYnQG7Q@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	amarkuze@redhat.com, dhowells@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:51=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The generic/397 test generate kernel crash for the case of
> encrypted inode with unaligned file size (for example, 33K
> or 1K):
>
> Jan 3 12:34:40 ceph-testing-0001 root: run xfstest generic/397
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.737811] run fstests generi=
c/397 at 2025-01-03 12:34:40
> Jan 3 12:34:40 ceph-testing-0001 systemd1: Started /usr/bin/bash c test -=
w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./t=
ests/generic/397.
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.875761] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.876130] libceph: client461=
4 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.991965] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.992334] libceph: client461=
7 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017234] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017594] libceph: client462=
0 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.031394] xfs_io (pid 18988)=
 is setting deprecated v1 encryption policy; recommend upgrading to v2.
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054528] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054892] libceph: client462=
3 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070287] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070704] libceph: client462=
6 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.264586] libceph: mon0 (2)1=
27.0.0.1:40674 session established
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.265258] libceph: client462=
9 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374578] -----------[ cut h=
ere ]------------
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374586] kernel BUG at net/=
ceph/messenger.c:1070!
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.375150] Oops: invalid opco=
de: 0000 [#1] PREEMPT SMP NOPTI
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378145] CPU: 2 UID: 0 PID:=
 4759 Comm: kworker/2:9 Not tainted 6.13.0-rc5+ #1
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378969] Hardware name: QEM=
U Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebui=
lt.qemu.org 04/01/2014
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.380167] Workqueue: ceph-ms=
gr ceph_con_workfn
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.381639] RIP: 0010:ceph_msg=
_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.382152] Code: 89 17 48 8b =
46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c0 =
31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00 0=
0 00 00 90 90 90 90 90 90 90 90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.383928] RSP: 0018:ffffb4ff=
c7cbbd28 EFLAGS: 00010287
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.384447] RAX: ffffffff82bb9=
ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385129] RDX: 0000000000009=
000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385839] RBP: ffffb4ffc7cbb=
e18 R08: 0000000000000000 R09: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.386539] R10: 0000000000000=
000 R11: 0000000000000000 R12: ffff981390c2f030
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387203] R13: ffff981288232=
b58 R14: 0000000000000029 R15: 0000000000000001
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387877] FS: 00000000000000=
00(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.388663] CS: 0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389212] CR2: 00005e106a055=
4e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389921] DR0: 0000000000000=
000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.390620] DR3: 0000000000000=
000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391307] PKRU: 55555554
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391567] Call Trace:
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391807] <TASK>
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392021] ? show_regs+0x71/0=
x90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392391] ? die+0x38/0xa0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392667] ? do_trap+0xdb/0x1=
00
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392981] ? do_error_trap+0x=
75/0xb0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393372] ? ceph_msg_data_cu=
rsor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393842] ? exc_invalid_op+0=
x53/0x80
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394232] ? ceph_msg_data_cu=
rsor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394694] ? asm_exc_invalid_=
op+0x1b/0x20
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395099] ? ceph_msg_data_cu=
rsor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395583] ? ceph_con_v2_try_=
read+0xd16/0x2220
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396027] ? _raw_spin_unlock=
+0xe/0x40
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396428] ? raw_spin_rq_unlo=
ck+0x10/0x40
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396842] ? finish_task_swit=
ch.isra.0+0x97/0x310
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397338] ? __schedule+0x44b=
/0x16b0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397738] ceph_con_workfn+0x=
326/0x750
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398121] process_one_work+0=
x188/0x3d0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398522] ? __pfx_worker_thr=
ead+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398929] worker_thread+0x2b=
5/0x3c0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399310] ? __pfx_worker_thr=
ead+0x10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399727] kthread+0xe1/0x120
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400031] ? __pfx_kthread+0x=
10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400431] ret_from_fork+0x43=
/0x70
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400771] ? __pfx_kthread+0x=
10/0x10
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401127] ret_from_fork_asm+=
0x1a/0x30
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401543] </TASK>
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401760] Modules linked in:=
 hctr2 nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha_generic chacha_x86=
_64 libchacha adiantum libpoly1305 essiv authenc mptcp_diag xsk_diag tcp_di=
ag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag intel_=
rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nf=
it kvm_intel kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_gene=
ric ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel joydev crypto_s=
imd cryptd rapl input_leds psmouse sch_fq_codel serio_raw bochs i2c_piix4 f=
loppy qemu_fw_cfg i2c_smbus mac_hid pata_acpi msr parport_pc ppdev lp parpo=
rt efi_pstore ip_tables x_tables
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407319] ---[ end trace 000=
0000000000000 ]---
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407775] RIP: 0010:ceph_msg=
_data_cursor_init+0x42/0x50
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.408317] Code: 89 17 48 8b =
46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c0 =
31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00 0=
0 00 00 90 90 90 90 90 90 90 90
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410087] RSP: 0018:ffffb4ff=
c7cbbd28 EFLAGS: 00010287
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410609] RAX: ffffffff82bb9=
ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.411318] RDX: 0000000000009=
000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412014] RBP: ffffb4ffc7cbb=
e18 R08: 0000000000000000 R09: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412735] R10: 0000000000000=
000 R11: 0000000000000000 R12: ffff981390c2f030
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.413438] R13: ffff981288232=
b58 R14: 0000000000000029 R15: 0000000000000001
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414121] FS: 00000000000000=
00(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414935] CS: 0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.415516] CR2: 00005e106a055=
4e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416211] DR0: 0000000000000=
000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416907] DR3: 0000000000000=
000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.417630] PKRU: 55555554
>
> BUG_ON(length > msg->data_length) triggers the issue:
>
> (gdb) l *ceph_msg_data_cursor_init+0x42
> 0xffffffff823b45a2 is in ceph_msg_data_cursor_init (net/ceph/messenger.c:=
1070).
> 1065
> 1066 void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
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
> Jan 6 14:59:24 ceph-testing-0001 kernel: [ 202.628853] libceph: pid 144:n=
et/ceph/messenger_v2.c:2034 prepare_sparse_read_data(): msg->data_length 33=
792, msg->sparse_read_total 36864
> 1070 BUG_ON(length > msg->data_length);
> msg->sparse_read_total 36864 > msg->data_length 33792
>
> The generic/397 test (xfstests) executes such steps:
> (1) create encrypted files and directories;
> (2) access the created files and folders with encryption key;
> (3) access the created files and folders without encryption key.
>
> The issue takes place in this portion of code:
>
>     if (IS_ENCRYPTED(inode)) {
>             struct page **pages;
>             size_t page_off;
>
>             err =3D iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, l=
en,
>                                             &page_off);
>             if (err < 0) {
>                     doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
>                           ceph_vinop(inode), err);
>                     goto out;
>             }
>
>             /* should always give us a page-aligned read */
>             WARN_ON_ONCE(page_off);
>             len =3D err;
>             err =3D 0;
>
>             osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false=
,
>                                              false);
>
> The reason of the issue is that subreq->io_iter.count keeps
> unaligned value of length:
>
> Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.751182] pid 8059:lib/iov=
_iter.c:1185 __iov_iter_get_pages_alloc(): maxsize 36864, maxpages 42949672=
95, start 18446659367320516064
> Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.752808] pid 8059:lib/iov=
_iter.c:1196 __iov_iter_get_pages_alloc(): maxsize 33792, maxpages 42949672=
95, start 18446659367320516064
> Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.754394] pid 8059:lib/iov=
_iter.c:1015 iter_folioq_get_pages(): maxsize 33792, maxpages 4294967295, e=
xtracted 0, _start_offset 18446659367320516064
>
> This patch simply assigns the aligned value to
> subreq->io_iter.count before calling iov_iter_get_pages_alloc2().
>
> ./check generic/397
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.13.0-rc7+ #58 SMP PREEM=
PT_DYNAMIC Wed Jan 15 00:07:06 UTC 2025
> MKFS_OPTIONS  -- 127.0.0.1:40629:/scratch
> MOUNT_OPTIONS -- -o name=3Dfs,secret=3D<hidden>,ms_mode=3Dcrc,nowsync,cop=
yfrom 127.0.0.1:<port>:/scratch /mnt/scratch
>
> generic/397 1s ...  1s
> Ran: generic/397
> Passed all 1 tests
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/addr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 85936f6d2bf7..5e6ba92219f3 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -396,6 +396,15 @@ static void ceph_netfs_issue_read(struct netfs_io_su=
brequest *subreq)
>                 struct page **pages;
>                 size_t page_off;
>
> +               /*
> +                * The io_iter.count needs to be corrected to aligned len=
gth.
> +                * Otherwise, iov_iter_get_pages_alloc2() operates with
> +                * the initial unaligned length value. As a result,
> +                * ceph_msg_data_cursor_init() triggers BUG_ON() in the c=
ase
> +                * if msg->sparse_read_total > msg->data_length.
> +                */
> +               subreq->io_iter.count =3D len;

Hi Slava,

So I take it that my hunch that it's subreq->io_iter and commenting out
"len =3D err" assignment worked?  TBH munging the count this way feels as
much of an ugly workaround as ignoring iov_iter_get_pages_alloc2()
return value (unless it's an error) to me.

Since this confirms that we have a regression introduced in ee4cdf7ba857
("netfs: Speed up buffered reading"), let's wait for David to chime in.

Thanks,

                Ilya

