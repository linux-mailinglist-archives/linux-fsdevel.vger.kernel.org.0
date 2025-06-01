Return-Path: <linux-fsdevel+bounces-50266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47224AC9F5E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D183B43A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11E1C8606;
	Sun,  1 Jun 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VktuK5xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8432A1CA;
	Sun,  1 Jun 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748795012; cv=none; b=j5Bc5oeYQgUxHcGci+FQauRjjkdU+a99OUdH1OziksQGWMmb+EBw1Jh9RnEXUSl9Ab0jblJmZJZpyP/H5WQU9nUyA2/zwY668q2K1UvshfEh+HMQBzfXEGuttTVlHqJaIL46nAhR4ICHBr2tmuILKj8g83nEQZiXt1W8oe5VciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748795012; c=relaxed/simple;
	bh=BX3D11AhhSVfcSpFBpfV7lzphuzxLzsrI9CNgfa+imM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVz8Z51DurxjZT7g/R/pBWHEXlWrsoT6e8vAiHAnROfpedujHk4M/KWALMTM2scPdtIafe03X4+k1usdW99VRZS9kXdwqC1o775vjzg3r+qr9kUJikKk1mnjwp5HMNOG/6l9pWDOhDesrASNNBqTbAEqChFozTQfH1b0UeD/XPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VktuK5xl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so3043273b3a.3;
        Sun, 01 Jun 2025 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748795010; x=1749399810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mUBueZWKYQxQLXSSdRyNMAOxmsqg2PRoyFrKefoLMM=;
        b=VktuK5xlIpQqtVBf2zkJQ9ZNjpWpDi7z1g44o3x14Hp1C7jJnPWDNxhUJ2FXyZn++1
         gK9MJp7G4YzzitrI5mOfRxTZCIwXTW92tBX4zSLeAcksJWiKw+F1yOUCMC/fSNtwLvD9
         NhzOwz3I7fmpW9w0iR1MXZP7FThGB1jhhRuEiH8wYf+ntehpumeltVwtlvJDeCsrxESj
         dFuKxcRvqCWhJX7xtHa5u6hIVjpt6CvVQxVBYI+yrvng7tBo73JmoCDtw3Olj92CPC6G
         GKoZGEqUu6AUnMzgWvLoke3sVNZ3ZvizlJg/Wxkd507gEc+tg/gK1gNlZxrrv9TexM9F
         f/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748795010; x=1749399810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mUBueZWKYQxQLXSSdRyNMAOxmsqg2PRoyFrKefoLMM=;
        b=PBvExSuRygqDa7nb2zLSCHVYEMYs5jZd8oRa5dKzjVYZtusz23fPt2fnqKOnyKcMKp
         m50w4CTRQ5hKuPfl0tH83s+d5LycNPqyXi2uN7EIGgsU2vCOn9zFbm83KU4DFNc910Cs
         EETygDlwoEeHX9hcv8MCyG5P+9yTusd2e1yi1LExku17H0klvYD7sYZv0YomONmLIi5X
         fKZ3klkUlMc2dCZavEe2DeCdnMgtuiGUPQht9Nohhq5F+8vf+1d/SCz0vjoYdfByzaiz
         RPHTcixs/LsPPEgmsEdS685wvdjPUMR2XhcY2khtmZ1Aqd93RbJos0CK8UFauVpPG46u
         0zhg==
X-Forwarded-Encrypted: i=1; AJvYcCU17JB084kNxOZ+mYwOxKE02EBmeD53+J5YyYSB+4ldEY/O/bR2Wvx4fd1A1xeaC6FYEo9wbwEcRKLsBtKj@vger.kernel.org
X-Gm-Message-State: AOJu0YwViH/5CDTiSYh90WSNjEQ94/b3zYO1zSFYPVomfjdNDiUsQaB/
	K0HirBOmSOim5mWMROm/sLdPj44zXXIgSn75CdiO89xzJAiiBFdmHc1AxLji42x6ELSRSati4lK
	QGUPBQPqdabG8Y7ZRJN/33vP60Xeuer8=
X-Gm-Gg: ASbGnctVVRpy0mxDzAOjQEWDVHw9Vs4XY4XOz/Y6ZswGShi9RdxJtaLEOu2Kp7+U5IO
	bl87CNRx12HJ8SfzIAGT93zeeWE3DFuv6IbNxQCy1mCnLfZoWBInR1RVpWKmbq9fGnNc6EUYYV3
	lwyRLNkiPnM91/YIWsk1jDPPc/vO1acp3XmvOLzwanlNQ=
X-Google-Smtp-Source: AGHT+IGVsl4Q9aD7SIAk5IZm7+RXND2ZCQB374vgg4b2WOs8lrsN9eMO2vZKgWO/zvayIRA1GytrXstpIZxkVykzWYU=
X-Received: by 2002:a17:903:194b:b0:234:ed31:fc98 with SMTP id
 d9443c01a7336-2355f7697d5mr77442255ad.37.1748795009765; Sun, 01 Jun 2025
 09:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117035044.23309-1-slava@dubeyko.com> <62668a6c0a9771878340793a48057f0b0d1b6626.camel@ibm.com>
In-Reply-To: <62668a6c0a9771878340793a48057f0b0d1b6626.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 1 Jun 2025 18:23:18 +0200
X-Gm-Features: AX0GCFvM9zKbTJCzmlCl-9Lw7xCUgBDabA3Xzyta47z57U0gykP2vOdcI4z2OeU
Message-ID: <CAOi1vP8=_=JyjYSpq0qDc_MCW-T7mrT0CWgwF_k9xN2cK_QDZQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:59=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi David,
>
> What do you think about this patch, finally?

Hi David,

I went ahead and applied this patch with minor tweaks to the commit
message and the comment [1] because this thread has been pending for
a long time and from the CephFS perspective it seems to be a reasonable
workaround for a regression introduced in commit ee4cdf7ba857 ("netfs:
Speed up buffered reading").  The hunch that is mentioned early in the
thread is [2] (you were CCed on that message).  If you have a proper
fix in mind/planned for netfslib, please let us know ;)

[1] https://github.com/ceph/ceph-client/commit/060909278cc0a91373a20726bd3d=
8ce085f480a9
[2] https://lore.kernel.org/all/CAOi1vP9jKOuBetRPZCDeUAdiOmQTYLKSSgX4YYQFt7=
2H-t_j6A@mail.gmail.com/

Thanks,

                Ilya

>
> Thanks,
> Slava.
>
> On Thu, 2025-01-16 at 19:50 -0800, Viacheslav Dubeyko wrote:
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The generic/397 test generate kernel crash for the case of
> > encrypted inode with unaligned file size (for example, 33K
> > or 1K):
> >
> > Jan 3 12:34:40 ceph-testing-0001 root: run xfstest generic/397
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.737811] run fstests gene=
ric/397 at 2025-01-03 12:34:40
> > Jan 3 12:34:40 ceph-testing-0001 systemd1: Started /usr/bin/bash c test=
 -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec .=
/tests/generic/397.
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.875761] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.876130] libceph: client4=
614 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.991965] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.992334] libceph: client4=
617 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017234] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017594] libceph: client4=
620 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.031394] xfs_io (pid 1898=
8) is setting deprecated v1 encryption policy; recommend upgrading to v2.
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054528] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054892] libceph: client4=
623 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070287] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070704] libceph: client4=
626 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.264586] libceph: mon0 (2=
)127.0.0.1:40674 session established
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.265258] libceph: client4=
629 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374578] -----------[ cut=
 here ]------------
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374586] kernel BUG at ne=
t/ceph/messenger.c:1070!
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.375150] Oops: invalid op=
code: 0000 [#1] PREEMPT SMP NOPTI
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378145] CPU: 2 UID: 0 PI=
D: 4759 Comm: kworker/2:9 Not tainted 6.13.0-rc5+ #1
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378969] Hardware name: Q=
EMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-preb=
uilt.qemu.org 04/01/2014
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.380167] Workqueue: ceph-=
msgr ceph_con_workfn
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.381639] RIP: 0010:ceph_m=
sg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.382152] Code: 89 17 48 8=
b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c=
0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00=
 00 00 00 90 90 90 90 90 90 90 90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.383928] RSP: 0018:ffffb4=
ffc7cbbd28 EFLAGS: 00010287
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.384447] RAX: ffffffff82b=
b9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385129] RDX: 00000000000=
09000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385839] RBP: ffffb4ffc7c=
bbe18 R08: 0000000000000000 R09: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.386539] R10: 00000000000=
00000 R11: 0000000000000000 R12: ffff981390c2f030
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387203] R13: ffff9812882=
32b58 R14: 0000000000000029 R15: 0000000000000001
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387877] FS: 000000000000=
0000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.388663] CS: 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389212] CR2: 00005e106a0=
554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389921] DR0: 00000000000=
00000 DR1: 0000000000000000 DR2: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.390620] DR3: 00000000000=
00000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391307] PKRU: 55555554
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391567] Call Trace:
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391807] <TASK>
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392021] ? show_regs+0x71=
/0x90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392391] ? die+0x38/0xa0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392667] ? do_trap+0xdb/0=
x100
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392981] ? do_error_trap+=
0x75/0xb0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393372] ? ceph_msg_data_=
cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393842] ? exc_invalid_op=
+0x53/0x80
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394232] ? ceph_msg_data_=
cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394694] ? asm_exc_invali=
d_op+0x1b/0x20
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395099] ? ceph_msg_data_=
cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395583] ? ceph_con_v2_tr=
y_read+0xd16/0x2220
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396027] ? _raw_spin_unlo=
ck+0xe/0x40
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396428] ? raw_spin_rq_un=
lock+0x10/0x40
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396842] ? finish_task_sw=
itch.isra.0+0x97/0x310
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397338] ? __schedule+0x4=
4b/0x16b0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397738] ceph_con_workfn+=
0x326/0x750
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398121] process_one_work=
+0x188/0x3d0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398522] ? __pfx_worker_t=
hread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398929] worker_thread+0x=
2b5/0x3c0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399310] ? __pfx_worker_t=
hread+0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399727] kthread+0xe1/0x1=
20
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400031] ? __pfx_kthread+=
0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400431] ret_from_fork+0x=
43/0x70
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400771] ? __pfx_kthread+=
0x10/0x10
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401127] ret_from_fork_as=
m+0x1a/0x30
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401543] </TASK>
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401760] Modules linked i=
n: hctr2 nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha_generic chacha_x=
86_64 libchacha adiantum libpoly1305 essiv authenc mptcp_diag xsk_diag tcp_=
diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag inte=
l_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common =
nfit kvm_intel kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_ge=
neric ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel joydev crypto=
_simd cryptd rapl input_leds psmouse sch_fq_codel serio_raw bochs i2c_piix4=
 floppy qemu_fw_cfg i2c_smbus mac_hid pata_acpi msr parport_pc ppdev lp par=
port efi_pstore ip_tables x_tables
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407319] ---[ end trace 0=
000000000000000 ]---
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407775] RIP: 0010:ceph_m=
sg_data_cursor_init+0x42/0x50
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.408317] Code: 89 17 48 8=
b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c=
0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00=
 00 00 00 90 90 90 90 90 90 90 90
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410087] RSP: 0018:ffffb4=
ffc7cbbd28 EFLAGS: 00010287
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410609] RAX: ffffffff82b=
b9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.411318] RDX: 00000000000=
09000 RSI: ffff981288232b58 RDI: ffff981390c2f378
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412014] RBP: ffffb4ffc7c=
bbe18 R08: 0000000000000000 R09: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412735] R10: 00000000000=
00000 R11: 0000000000000000 R12: ffff981390c2f030
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.413438] R13: ffff9812882=
32b58 R14: 0000000000000029 R15: 0000000000000001
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414121] FS: 000000000000=
0000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414935] CS: 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.415516] CR2: 00005e106a0=
554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416211] DR0: 00000000000=
00000 DR1: 0000000000000000 DR2: 0000000000000000
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416907] DR3: 00000000000=
00000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.417630] PKRU: 55555554
> >
> > BUG_ON(length > msg->data_length) triggers the issue:
> >
> > (gdb) l *ceph_msg_data_cursor_init+0x42
> > 0xffffffff823b45a2 is in ceph_msg_data_cursor_init (net/ceph/messenger.=
c:1070).
> > 1065
> > 1066 void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor=
,
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
> > Jan 6 14:59:24 ceph-testing-0001 kernel: [ 202.628853] libceph: pid 144=
:net/ceph/messenger_v2.c:2034 prepare_sparse_read_data(): msg->data_length =
33792, msg->sparse_read_total 36864
> > 1070 BUG_ON(length > msg->data_length);
> > msg->sparse_read_total 36864 > msg->data_length 33792
> >
> > The generic/397 test (xfstests) executes such steps:
> > (1) create encrypted files and directories;
> > (2) access the created files and folders with encryption key;
> > (3) access the created files and folders without encryption key.
> >
> > The issue takes place in this portion of code:
> >
> >     if (IS_ENCRYPTED(inode)) {
> >             struct page **pages;
> >             size_t page_off;
> >
> >             err =3D iov_iter_get_pages_alloc2(&subreq->io_iter, &pages,=
 len,
> >                                             &page_off);
> >             if (err < 0) {
> >                     doutc(cl, "%llx.%llx failed to allocate pages, %d\n=
",
> >                           ceph_vinop(inode), err);
> >                     goto out;
> >             }
> >
> >             /* should always give us a page-aligned read */
> >             WARN_ON_ONCE(page_off);
> >             len =3D err;
> >             err =3D 0;
> >
> >             osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, fal=
se,
> >                                              false);
> >
> > The reason of the issue is that subreq->io_iter.count keeps
> > unaligned value of length:
> >
> > Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.751182] pid 8059:lib/i=
ov_iter.c:1185 __iov_iter_get_pages_alloc(): maxsize 36864, maxpages 429496=
7295, start 18446659367320516064
> > Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.752808] pid 8059:lib/i=
ov_iter.c:1196 __iov_iter_get_pages_alloc(): maxsize 33792, maxpages 429496=
7295, start 18446659367320516064
> > Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.754394] pid 8059:lib/i=
ov_iter.c:1015 iter_folioq_get_pages(): maxsize 33792, maxpages 4294967295,=
 extracted 0, _start_offset 18446659367320516064
> >
> > This patch simply assigns the aligned value to
> > subreq->io_iter.count before calling iov_iter_get_pages_alloc2().
> >
> > ./check generic/397
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.13.0-rc7+ #58 SMP PRE=
EMPT_DYNAMIC Wed Jan 15 00:07:06 UTC 2025
> > MKFS_OPTIONS  -- 127.0.0.1:40629:/scratch
> > MOUNT_OPTIONS -- -o name=3Dfs,secret=3D<hidden>,ms_mode=3Dcrc,nowsync,c=
opyfrom 127.0.0.1:<port>:/scratch /mnt/scratch
> >
> > generic/397 1s ...  1s
> > Ran: generic/397
> > Passed all 1 tests
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> >  fs/ceph/addr.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 85936f6d2bf7..5e6ba92219f3 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -396,6 +396,15 @@ static void ceph_netfs_issue_read(struct netfs_io_=
subrequest *subreq)
> >               struct page **pages;
> >               size_t page_off;
> >
> > +             /*
> > +              * The io_iter.count needs to be corrected to aligned len=
gth.
> > +              * Otherwise, iov_iter_get_pages_alloc2() operates with
> > +              * the initial unaligned length value. As a result,
> > +              * ceph_msg_data_cursor_init() triggers BUG_ON() in the c=
ase
> > +              * if msg->sparse_read_total > msg->data_length.
> > +              */
> > +             subreq->io_iter.count =3D len;
> > +
> >               err =3D iov_iter_get_pages_alloc2(&subreq->io_iter, &page=
s, len, &page_off);
> >               if (err < 0) {
> >                       doutc(cl, "%llx.%llx failed to allocate pages, %d=
\n",
> > @@ -405,6 +414,7 @@ static void ceph_netfs_issue_read(struct netfs_io_s=
ubrequest *subreq)
> >
> >               /* should always give us a page-aligned read */
> >               WARN_ON_ONCE(page_off);
> > +
> >               len =3D err;
> >               err =3D 0;
> >
>

