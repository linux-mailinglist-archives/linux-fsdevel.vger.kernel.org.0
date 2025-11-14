Return-Path: <linux-fsdevel+bounces-68538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09023C5EE10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11DD3B003F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BB2DAFD7;
	Fri, 14 Nov 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC56VMYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA152566DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145317; cv=none; b=OioBnGPg4J3ow3dG2kcKyOxfSOk6Xgx2vfCvdjTO5/+N9mBMFY9BJL/Uon6+dhxl+pO+X5KZpaxGmr6lJdI9ceCL3JWl6ww4ce3ZNG9GkqkmqR+MWLUsNU+3EmGvXBemJKBwIqGPAue2Eza3l99kmlQpniTD82mfT9F/CaI4mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145317; c=relaxed/simple;
	bh=KnvcI6ldSjtVZ45up7f3Vz6Q6Ri46Y3GsTUOj+p43yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcZtu91LwCiAlYyw1+WLrqqpMbh6bgAZZZda6xHCV95OtfKLStgK16afK7OIcX6rp8oWfPDHp1lp1bErgiAmuDLyka/jCMhzvIiN0IDoefWqlX/tpHnFUO/zGpGJdQTVSUs5ru9pX6YyiZaHMz+q+nj4fObX/gg39jl+hzhBq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC56VMYw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2041275b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763145314; x=1763750114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBzyctegrRMEtm4UcS/4+XPXGTIg7IDKhoKSpsjPYsA=;
        b=hC56VMYwF/8SkVzhG50/7rXVPwDhHPmkqtFPJ/RX7vmeG6Q94Ef9cSzL3fW0B1m79K
         P3i0kpUr0X2MAnDcqQnDcj9nYjzzgpb4pC5b/1UsdVYWH7CCcU+uMKyyRe/wyXfpJgMw
         O31HEnYp0YwZRtXjV7WmDssJ/x7S3OJbZOuhwZiCiMK2dvS++uIhVlak4sIH7ha5VWIl
         0gLd47SuCLtWfsR5QHnAmjuv/chP6hGGqGGTPooVoBufhJvxuFSik+PwHmo10kEtmSYR
         yqFAo5mpZBVJg5mLptLpP87xqTwyp0ewkAqGF0BsQUooDWldHXwnjMAXyUN7UvMDg4Qa
         p1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145314; x=1763750114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBzyctegrRMEtm4UcS/4+XPXGTIg7IDKhoKSpsjPYsA=;
        b=Wi9/WP0X4+v4xAb9ZZe/+w92H5mtRl5zO0h2M5SqC55c9Qst2JT0Rj9kRgnqpDHodx
         o/E1kZTnY7o0qwVnABx0x2DmIbnN7bauV5XOTFGgsr4t6cVDyJZPRy4lHuJ5k82Cpwkz
         hRaknt/LD62oIpPO6VGHL1eR59o0jarOq8sYkcUGP48Zg3hydYbW75tlQXqK8pSmgSNE
         hnu0gg2I2Lse3EpJSAPz0GeMh01JHJuyuZ2W1EPxkZKIcFr/yJ760liKCbWgcOeZH1b/
         5i63VZaCJGzNoHzZevc0fJV4VR4l4VSawkskqTQ5cY752JYLvM/4kFCJNqhxKZin014a
         YbuA==
X-Forwarded-Encrypted: i=1; AJvYcCVAMFkHzI69V/tWPq119CwKoH2zMbYfs5l+ng/RONOoU9Rhcwa4V8LhuppCmvEL1DCVPShzBfzHPKO9uce5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6PDRr3aljtbV0KggVjj01a6izOC4/s3bRn/avjlOa8L5TVhD
	KvOeKpB2qdydJaVFU1Rr1gBFM8H83ipmM6RgaVZ6jbvL/T88SCUi1M5TSMdAp+lxlA3ypUGMJso
	UYQWasR/9zUliwUGGN3aib3+Km6CXWUM=
X-Gm-Gg: ASbGncu6mTVRjA1GDJjuKv87oy+KzONvSLhpwPJqoTATjlyRXqTxaeIEU/jrXSFzEfG
	jP9FRaF6xC1/em65EWPjOSCM676sqs7iAKZ+spqH1ScO3c2kUeb2K6Vcg5fLQVswcUZI2DmZDnO
	s0V1aUK96anqtoYidjGGIUBay5ZhhsxOdNl3D5KbUtbt7vK2vbXi6CTiXe6Hh/j2RtJLdX8RtUk
	ZyHRThWLSNXgmtL+GCWgaLKtym948cPqJM7gq8i63d/LjjYLvKkgCAe3t10GRFvgc0PJro=
X-Google-Smtp-Source: AGHT+IHZoCO1KXIMfC12daGe+vq/OibKDfWiUL20ZQPYMIyc791roQrATp13s4p82a9PwRUtQEjUpVH1zxHxuXuPPOQ=
X-Received: by 2002:a05:7022:d41:b0:119:e56b:91e2 with SMTP id
 a92af1059eb24-11b411f0923mr809653c88.19.1763145313873; Fri, 14 Nov 2025
 10:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113223623.508000-2-slava@dubeyko.com>
In-Reply-To: <20251113223623.508000-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 14 Nov 2025 19:35:02 +0100
X-Gm-Features: AWmQ_bnbBkNY6l-IJN5wi-FHBte8ADJvPxltlHnlBqjvW01Hmphwwi9Vag4ue3k
Message-ID: <CAOi1vP-N6K1X=_6DJEisqyAugJQizSyWfC5DEiCtHnwCeVS0Og@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: fix crash in process_v2_sparse_read() for
 fscrypt-encrypted directories
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:36=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The crash in process_v2_sparse_read() for fscrypt-encrypted
> directories has been reported [1]. Issue takes place for
> Ceph msgr2 protocol. It can be reproduced by the steps:
>
> sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3D=
secure
>
> (1) mkdir /mnt/cephfs/fscrypt-test-3
> (2) cp area_decrypted.tar /mnt/cephfs/fscrypt-test-3
> (3) fscrypt encrypt --source=3Draw_key --key=3D./my.key /mnt/cephfs/fscry=
pt-test-3
> (4) fscrypt lock /mnt/cephfs/fscrypt-test-3
> (5) fscrypt unlock --key=3Dmy.key /mnt/cephfs/fscrypt-test-3
> (6) cat /mnt/cephfs/fscrypt-test-3/area_decrypted.tar
> (7) Issue has been triggered
>
> [  408.072247] ------------[ cut here ]------------
> [  408.072251] WARNING: CPU: 1 PID: 392 at net/ceph/messenger_v2.c:865
> ceph_con_v2_try_read+0x4b39/0x72f0
> [  408.072267] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irqby=
pass
> polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qemu_=
fw_cfg
> pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> [  408.072304] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Not tainted 6.17.=
0-rc7+
> [  408.072307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.17.0-5.fc42 04/01/2014
> [  408.072310] Workqueue: ceph-msgr ceph_con_workfn
> [  408.072314] RIP: 0010:ceph_con_v2_try_read+0x4b39/0x72f0
> [  408.072317] Code: c7 c1 20 f0 d4 ae 50 31 d2 48 c7 c6 60 27 d5 ae 48 c=
7 c7 f8
> 8e 6f b0 68 60 38 d5 ae e8 00 47 61 fe 48 83 c4 18 e9 ac fc ff ff <0f> 0b=
 e9 06
> fe ff ff 4c 8b 9d 98 fd ff ff 0f 84 64 e7 ff ff 89 85
> [  408.072319] RSP: 0018:ffff88811c3e7a30 EFLAGS: 00010246
> [  408.072322] RAX: ffffed1024874c6f RBX: ffffea00042c2b40 RCX: 000000000=
0000f38
> [  408.072324] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  408.072325] RBP: ffff88811c3e7ca8 R08: 0000000000000000 R09: 000000000=
00000c8
> [  408.072326] R10: 00000000000000c8 R11: 0000000000000000 R12: 000000000=
00000c8
> [  408.072327] R13: dffffc0000000000 R14: ffff8881243a6030 R15: 000000000=
0003000
> [  408.072329] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> knlGS:0000000000000000
> [  408.072331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  408.072332] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 000000000=
0772ef0
> [  408.072336] PKRU: 55555554
> [  408.072337] Call Trace:
> [  408.072338]  <TASK>
> [  408.072340]  ? sched_clock_noinstr+0x9/0x10
> [  408.072344]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> [  408.072347]  ? _raw_spin_unlock+0xe/0x40
> [  408.072349]  ? finish_task_switch.isra.0+0x15d/0x830
> [  408.072353]  ? __kasan_check_write+0x14/0x30
> [  408.072357]  ? mutex_lock+0x84/0xe0
> [  408.072359]  ? __pfx_mutex_lock+0x10/0x10
> [  408.072361]  ceph_con_workfn+0x27e/0x10e0
> [  408.072364]  ? metric_delayed_work+0x311/0x2c50
> [  408.072367]  process_one_work+0x611/0xe20
> [  408.072371]  ? __kasan_check_write+0x14/0x30
> [  408.072373]  worker_thread+0x7e3/0x1580
> [  408.072375]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  408.072378]  ? __pfx_worker_thread+0x10/0x10
> [  408.072381]  kthread+0x381/0x7a0
> [  408.072383]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  408.072385]  ? __pfx_kthread+0x10/0x10
> [  408.072387]  ? __kasan_check_write+0x14/0x30
> [  408.072389]  ? recalc_sigpending+0x160/0x220
> [  408.072392]  ? _raw_spin_unlock_irq+0xe/0x50
> [  408.072394]  ? calculate_sigpending+0x78/0xb0
> [  408.072395]  ? __pfx_kthread+0x10/0x10
> [  408.072397]  ret_from_fork+0x2b6/0x380
> [  408.072400]  ? __pfx_kthread+0x10/0x10
> [  408.072402]  ret_from_fork_asm+0x1a/0x30
> [  408.072406]  </TASK>
> [  408.072407] ---[ end trace 0000000000000000 ]---
> [  408.072418] Oops: general protection fault, probably for non-canonical
> address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> [  408.072984] KASAN: null-ptr-deref in range [0x0000000000000000-
> 0x0000000000000007]
> [  408.073350] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Tainted: G       =
 W
> 6.17.0-rc7+ #1 PREEMPT(voluntary)
> [  408.073886] Tainted: [W]=3DWARN
> [  408.074042] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.17.0-5.fc42 04/01/2014
> [  408.074468] Workqueue: ceph-msgr ceph_con_workfn
> [  408.074694] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> [  408.074976] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85 0=
7 11 00
> 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> b6=
 14 16
> 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> [  408.075884] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> [  408.076305] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 000000000=
0000000
> [  408.076909] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff88812=
43a6378
> [  408.077466] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 000000000=
00000c8
> [  408.078034] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed102=
4874c71
> [  408.078575] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff88812=
43a6378
> [  408.079159] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> knlGS:0000000000000000
> [  408.079736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  408.080039] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 000000000=
0772ef0
> [  408.080376] PKRU: 55555554
> [  408.080513] Call Trace:
> [  408.080630]  <TASK>
> [  408.080729]  ceph_con_v2_try_read+0x49b9/0x72f0
> [  408.081115]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> [  408.081348]  ? _raw_spin_unlock+0xe/0x40
> [  408.081538]  ? finish_task_switch.isra.0+0x15d/0x830
> [  408.081768]  ? __kasan_check_write+0x14/0x30
> [  408.081986]  ? mutex_lock+0x84/0xe0
> [  408.082160]  ? __pfx_mutex_lock+0x10/0x10
> [  408.082343]  ceph_con_workfn+0x27e/0x10e0
> [  408.082529]  ? metric_delayed_work+0x311/0x2c50
> [  408.082737]  process_one_work+0x611/0xe20
> [  408.082948]  ? __kasan_check_write+0x14/0x30
> [  408.083156]  worker_thread+0x7e3/0x1580
> [  408.083331]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  408.083557]  ? __pfx_worker_thread+0x10/0x10
> [  408.083751]  kthread+0x381/0x7a0
> [  408.083922]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  408.084139]  ? __pfx_kthread+0x10/0x10
> [  408.084310]  ? __kasan_check_write+0x14/0x30
> [  408.084510]  ? recalc_sigpending+0x160/0x220
> [  408.084708]  ? _raw_spin_unlock_irq+0xe/0x50
> [  408.084917]  ? calculate_sigpending+0x78/0xb0
> [  408.085138]  ? __pfx_kthread+0x10/0x10
> [  408.085335]  ret_from_fork+0x2b6/0x380
> [  408.085525]  ? __pfx_kthread+0x10/0x10
> [  408.085720]  ret_from_fork_asm+0x1a/0x30
> [  408.085922]  </TASK>
> [  408.086036] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irqby=
pass
> polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qemu_=
fw_cfg
> pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> [  408.087778] ---[ end trace 0000000000000000 ]---
> [  408.088007] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> [  408.088260] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85 0=
7 11 00
> 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> b6=
 14 16
> 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> [  408.089118] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> [  408.089357] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 000000000=
0000000
> [  408.089678] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff88812=
43a6378
> [  408.090020] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 000000000=
00000c8
> [  408.090360] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed102=
4874c71
> [  408.090687] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff88812=
43a6378
> [  408.091035] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> knlGS:0000000000000000
> [  408.091452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  408.092015] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 000000000=
0772ef0
> [  408.092530] PKRU: 55555554
> [  417.112915]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  417.113491] BUG: KASAN: slab-use-after-free in
> __mutex_lock.constprop.0+0x1522/0x1610
> [  417.114014] Read of size 4 at addr ffff888124870034 by task kworker/2:=
0/4951
>
> [  417.114587] CPU: 2 UID: 0 PID: 4951 Comm: kworker/2:0 Tainted: G      =
D W
> 6.17.0-rc7+ #1 PREEMPT(voluntary)
> [  417.114592] Tainted: [D]=3DDIE, [W]=3DWARN
> [  417.114593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.17.0-5.fc42 04/01/2014
> [  417.114596] Workqueue: events handle_timeout
> [  417.114601] Call Trace:
> [  417.114602]  <TASK>
> [  417.114604]  dump_stack_lvl+0x5c/0x90
> [  417.114610]  print_report+0x171/0x4dc
> [  417.114613]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  417.114617]  ? kasan_complete_mode_report_info+0x80/0x220
> [  417.114621]  kasan_report+0xbd/0x100
> [  417.114625]  ? __mutex_lock.constprop.0+0x1522/0x1610
> [  417.114628]  ? __mutex_lock.constprop.0+0x1522/0x1610
> [  417.114630]  __asan_report_load4_noabort+0x14/0x30
> [  417.114633]  __mutex_lock.constprop.0+0x1522/0x1610
> [  417.114635]  ? queue_con_delay+0x8d/0x200
> [  417.114638]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
> [  417.114641]  ? __send_subscribe+0x529/0xb20
> [  417.114644]  __mutex_lock_slowpath+0x13/0x20
> [  417.114646]  mutex_lock+0xd4/0xe0
> [  417.114649]  ? __pfx_mutex_lock+0x10/0x10
> [  417.114652]  ? ceph_monc_renew_subs+0x2a/0x40
> [  417.114654]  ceph_con_keepalive+0x22/0x110
> [  417.114656]  handle_timeout+0x6b3/0x11d0
> [  417.114659]  ? _raw_spin_unlock_irq+0xe/0x50
> [  417.114662]  ? __pfx_handle_timeout+0x10/0x10
> [  417.114664]  ? queue_delayed_work_on+0x8e/0xa0
> [  417.114669]  process_one_work+0x611/0xe20
> [  417.114672]  ? __kasan_check_write+0x14/0x30
> [  417.114676]  worker_thread+0x7e3/0x1580
> [  417.114678]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  417.114682]  ? __pfx_sched_setscheduler_nocheck+0x10/0x10
> [  417.114687]  ? __pfx_worker_thread+0x10/0x10
> [  417.114689]  kthread+0x381/0x7a0
> [  417.114692]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  417.114694]  ? __pfx_kthread+0x10/0x10
> [  417.114697]  ? __kasan_check_write+0x14/0x30
> [  417.114699]  ? recalc_sigpending+0x160/0x220
> [  417.114703]  ? _raw_spin_unlock_irq+0xe/0x50
> [  417.114705]  ? calculate_sigpending+0x78/0xb0
> [  417.114707]  ? __pfx_kthread+0x10/0x10
> [  417.114710]  ret_from_fork+0x2b6/0x380
> [  417.114713]  ? __pfx_kthread+0x10/0x10
> [  417.114715]  ret_from_fork_asm+0x1a/0x30
> [  417.114720]  </TASK>
>
> [  417.125171] Allocated by task 2:
> [  417.125333]  kasan_save_stack+0x26/0x60
> [  417.125522]  kasan_save_track+0x14/0x40
> [  417.125742]  kasan_save_alloc_info+0x39/0x60
> [  417.125945]  __kasan_slab_alloc+0x8b/0xb0
> [  417.126133]  kmem_cache_alloc_node_noprof+0x13b/0x460
> [  417.126381]  copy_process+0x320/0x6250
> [  417.126595]  kernel_clone+0xb7/0x840
> [  417.126792]  kernel_thread+0xd6/0x120
> [  417.126995]  kthreadd+0x85c/0xbe0
> [  417.127176]  ret_from_fork+0x2b6/0x380
> [  417.127378]  ret_from_fork_asm+0x1a/0x30
>
> [  417.127692] Freed by task 0:
> [  417.127851]  kasan_save_stack+0x26/0x60
> [  417.128057]  kasan_save_track+0x14/0x40
> [  417.128267]  kasan_save_free_info+0x3b/0x60
> [  417.128491]  __kasan_slab_free+0x6c/0xa0
> [  417.128708]  kmem_cache_free+0x182/0x550
> [  417.128906]  free_task+0xeb/0x140
> [  417.129070]  __put_task_struct+0x1d2/0x4f0
> [  417.129259]  __put_task_struct_rcu_cb+0x15/0x20
> [  417.129480]  rcu_do_batch+0x3d3/0xe70
> [  417.129681]  rcu_core+0x549/0xb30
> [  417.129839]  rcu_core_si+0xe/0x20
> [  417.130005]  handle_softirqs+0x160/0x570
> [  417.130190]  __irq_exit_rcu+0x189/0x1e0
> [  417.130369]  irq_exit_rcu+0xe/0x20
> [  417.130531]  sysvec_apic_timer_interrupt+0x9f/0xd0
> [  417.130768]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
>
> [  417.131082] Last potentially related work creation:
> [  417.131305]  kasan_save_stack+0x26/0x60
> [  417.131484]  kasan_record_aux_stack+0xae/0xd0
> [  417.131695]  __call_rcu_common+0xcd/0x14b0
> [  417.131909]  call_rcu+0x31/0x50
> [  417.132071]  delayed_put_task_struct+0x128/0x190
> [  417.132295]  rcu_do_batch+0x3d3/0xe70
> [  417.132478]  rcu_core+0x549/0xb30
> [  417.132658]  rcu_core_si+0xe/0x20
> [  417.132808]  handle_softirqs+0x160/0x570
> [  417.132993]  __irq_exit_rcu+0x189/0x1e0
> [  417.133181]  irq_exit_rcu+0xe/0x20
> [  417.133353]  sysvec_apic_timer_interrupt+0x9f/0xd0
> [  417.133584]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
>
> [  417.133921] Second to last potentially related work creation:
> [  417.134183]  kasan_save_stack+0x26/0x60
> [  417.134362]  kasan_record_aux_stack+0xae/0xd0
> [  417.134566]  __call_rcu_common+0xcd/0x14b0
> [  417.134782]  call_rcu+0x31/0x50
> [  417.134929]  put_task_struct_rcu_user+0x58/0xb0
> [  417.135143]  finish_task_switch.isra.0+0x5d3/0x830
> [  417.135366]  __schedule+0xd30/0x5100
> [  417.135534]  schedule_idle+0x5a/0x90
> [  417.135712]  do_idle+0x25f/0x410
> [  417.135871]  cpu_startup_entry+0x53/0x70
> [  417.136053]  start_secondary+0x216/0x2c0
> [  417.136233]  common_startup_64+0x13e/0x141
>
> [  417.136894] The buggy address belongs to the object at ffff88812487000=
0
>                 which belongs to the cache task_struct of size 10504
> [  417.138122] The buggy address is located 52 bytes inside of
>                 freed 10504-byte region [ffff888124870000, ffff8881248729=
08)
>
> [  417.139465] The buggy address belongs to the physical page:
> [  417.140016] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0
> pfn:0x124870
> [  417.140789] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped=
:0
> pincount:0
> [  417.141519] memcg:ffff88811aa20e01
> [  417.141874] anon flags:
> 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> [  417.142600] page_type: f5(slab)
> [  417.142922] raw: 0017ffffc0000040 ffff88810094f040 0000000000000000
> dead000000000001
> [  417.143554] raw: 0000000000000000 0000000000030003 00000000f5000000
> ffff88811aa20e01
> [  417.143954] head: 0017ffffc0000040 ffff88810094f040 0000000000000000
> dead000000000001
> [  417.144329] head: 0000000000000000 0000000000030003 00000000f5000000
> ffff88811aa20e01
> [  417.144710] head: 0017ffffc0000003 ffffea0004921c01 00000000ffffffff
> 00000000ffffffff
> [  417.145106] head: ffffffffffffffff 0000000000000000 00000000ffffffff
> 0000000000000008
> [  417.145485] page dumped because: kasan: bad access detected
>
> [  417.145859] Memory state around the buggy address:
> [  417.146094]  ffff88812486ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> fc
> [  417.146439]  ffff88812486ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> fc
> [  417.146791] >ffff888124870000: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb
> fb
> [  417.147145]                                      ^
> [  417.147387]  ffff888124870080: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb
> fb
> [  417.147751]  ffff888124870100: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb
> fb
> [  417.148123]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> First of all, we have warning in get_bvec_at() because
> cursor->total_resid contains zero value. And, finally,
> we have crash in ceph_msg_data_advance() because
> cursor->data is NULL. It means that get_bvec_at()
> receives not initialized ceph_msg_data_cursor structure
> because data is NULL and total_resid contains zero.
>
> Moreover, we don't have likewise issue for the case of
> Ceph msgr1 protocol because ceph_msg_data_cursor_init()
> has been called before reading sparse data.
>
> This patch adds calling of ceph_msg_data_cursor_init()
> in the beginning of process_v2_sparse_read() with
> the goal to guarantee that logic of reading sparse data
> works correctly for the case of Ceph msgr2 protocol.
>
> v2
> Ilya Dryomov suggested to rework cursor initialization
> logic, and to make additional minor cleanup.
>
> v3
> Ilya Dryomov suggested to use sparse_read_total instead of
> data_length here for consistency with other sparse read
> code paths.
>
> [1] https://tracker.ceph.com/issues/73152
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  net/ceph/messenger_v2.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 9e39378eda00..9e48623018a3 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -1061,13 +1061,16 @@ static int decrypt_control_remainder(struct ceph_=
connection *con)
>  static int process_v2_sparse_read(struct ceph_connection *con,
>                                   struct page **pages, int spos)
>  {
> -       struct ceph_msg_data_cursor *cursor =3D &con->v2.in_cursor;
> +       struct ceph_msg_data_cursor cursor;
>         int ret;
>
> +       ceph_msg_data_cursor_init(&cursor, con->in_msg,
> +                                 con->in_msg->sparse_read_total);
> +
>         for (;;) {
>                 char *buf =3D NULL;
>
> -               ret =3D con->ops->sparse_read(con, cursor, &buf);
> +               ret =3D con->ops->sparse_read(con, &cursor, &buf);
>                 if (ret <=3D 0)
>                         return ret;
>
> @@ -1085,11 +1088,11 @@ static int process_v2_sparse_read(struct ceph_con=
nection *con,
>                         } else {
>                                 struct bio_vec bv;
>
> -                               get_bvec_at(cursor, &bv);
> +                               get_bvec_at(&cursor, &bv);
>                                 len =3D min_t(int, len, bv.bv_len);
>                                 memcpy_page(bv.bv_page, bv.bv_offset,
>                                             spage, soff, len);
> -                               ceph_msg_data_advance(cursor, len);
> +                               ceph_msg_data_advance(&cursor, len);
>                         }
>                         spos +=3D len;
>                         ret -=3D len;
> --
> 2.51.1
>

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

