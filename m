Return-Path: <linux-fsdevel+bounces-29182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C6976CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E51C23AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01515D5D9;
	Thu, 12 Sep 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LBw+kaYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791244C6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153329; cv=none; b=PrsZnbaqJcQAXw4j9QRltL98tWmrSc2D6tQgPq1PdcIa3nSdj+fC7W5NrZ+uiCh/j0KY+yT0aDCMag2TeDGaaryO6cMCf1TuPGZU1Z0FHm5AozCgC9zXynPZM0n+/siNc0goqYqjh/IW7+2K8VyOunwldWU7/53taM0gqh2nVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153329; c=relaxed/simple;
	bh=mJhjQdgdH0j7pwfwgqWDhWfsffY4Z/IG9O71Qr8zOCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja2ENXAVLIGCZIcWvqicmpAy8yMFCWmtwEdfpnl27pG6Wr3DnK1P7k4GYjKeCfqVHy0pbjd9fjsus1QAXUNT2a9mLWl9SrPUjnrkJWlnUaBRFihjSVMNjndJyWvgklnPvqz/iklnz7jPtnMlkXhtKhBz94459qFrBN0D3nQBPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LBw+kaYV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7457B3F690
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726153323;
	bh=ZgG32sKkreFj1n7hMxJourYUMwNkUztFE3WQL5muXOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LBw+kaYVSdzqilAfeCgj2B2Af1LE+e6uEGaG7vgxCpYnNZXdKv2R+Ci9KDPxeNN6w
	 Ucs9C51kn9YYlyT7gTJUF8Nxoe+MOal4xBwvPdrA5QFfJIqCUuhebdMSzGvyJ+xPcv
	 Cz4whLhTFotZXsUxY4c5sdJP4ZTK6zvnO57IiiYP3glmjQ0ZuuLhILSnO8iNlKxjON
	 STDQhyRoIwYoElzCHkM3RhkhQnii+tfRc++iXS7YqlJVfKZZToUp84F/GwAUs8GcKv
	 fQpuEXN5FmbXB0N94VZqk2oWrWwkwWLsMPD7osrpW0PWsSdVHIozmwlUQ6ikKpshBw
	 R0nwc1fTpTKNA==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e04ea9d6b4so885788b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153322; x=1726758122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgG32sKkreFj1n7hMxJourYUMwNkUztFE3WQL5muXOo=;
        b=XXLsEebJGYWK2cyden/EDAUGbo+vuKLfnPMHef8byFszXXKk5Cwb+5N0wiIvp71B9o
         2X9s3ghTuL8PKfli6Z0NpymzsgwryYYStV5Ia0Gj7BMc6V/rG3gXR9aFBGEypY78aT0v
         h4GsHjxLsvQRD9bwcBu8TCBE2nZwbRwisgTXo9hU9fnXu17QkDroTyWXOW7iuWDwCgiO
         i2G10ATMoG5eZlUUFlxvFYURnHgdNdGwVHiVvcAPn2tmsOQIim1z8YOX/FnPr+FzH+Cm
         /Qw5g01+JY6Oi9tOv4oxX8z3OlntdFZrXZNpbdHYjP+jYwC7ljASvXRITEkL+h/Sf69z
         4+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWCGv0oRXHBmlY9RFJnVt4ZLycRzE0dKI7Gz79mlHp6tsx8g0ZN6rONycGwpigLopCIPPknPd0vlzvb/Lbv@vger.kernel.org
X-Gm-Message-State: AOJu0YwIznUH+sPSXr8OXeXGs35SapBmSmMiNgMr4cq0zov++a3YuxOJ
	QYcMPpEVeKv/ryefLJbPUWGUrNzDvO7xhh3asEpV0KpYvAkSL5oVGo3fRJyzNmu+HAlRx++UtLC
	/9/fWQWspJMTu9ECGz7cN9IFrwNhY/CB7FnJhPLr4bz61X6o5mHEddKKr/Oxf8VwngCvp5W/YCg
	m1EyUMuTbEhMCYJEyGXOe5EClTXhC43/Kvam5mZOUtmNmIFUlSkjg5PSREpYnrurL5
X-Received: by 2002:a05:6808:30a0:b0:3e0:6b72:f324 with SMTP id 5614622812f47-3e071aa0548mr1947602b6e.20.1726153321902;
        Thu, 12 Sep 2024 08:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwfEP9u2QQ+JrVyIfCQ/xTUKBoFFdUed6JHwQxw/tKq1Xx6yTOl2WUAj6OsnNqzRkfcTa/gXNj/0gdu35ZH0=
X-Received: by 2002:a05:6808:30a0:b0:3e0:6b72:f324 with SMTP id
 5614622812f47-3e071aa0548mr1947546b6e.20.1726153321378; Thu, 12 Sep 2024
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912145824.187768-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240912145824.187768-1-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 12 Sep 2024 17:01:50 +0200
Message-ID: <CAEivzxcpMb-Whu4dLbcDAqx+CNaCNtyA+O=QEEy2XYMkPPLC5w@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: fix null-ptr-deref when checking SB_I_NOIDMAP flag
To: mszeredi@redhat.com
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Chandan Babu R <chandanbabu@kernel.org>, linux-kernel@vger.kernel.org, 
	syzbot+20c7e20cc8f5296dca12@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear colleagues,

This commit is supposed to be applied after a
https://lore.kernel.org/linux-fsdevel/20240906143453.179506-1-aleksandr.mik=
halitsyn@canonical.com/#r
series.

Kind regards,
Alex

On Thu, Sep 12, 2024 at 4:58=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> It was reported [1] that on linux-next/fs-next the following crash
> is reproducible:
>
> [   42.659136] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   42.660501] fbcon: Taking over console
> [   42.660930] KASAN: null-ptr-deref in range [0x0000000000000058-0x00000=
0000000005f]
> [   42.661752] CPU: 1 UID: 0 PID: 1589 Comm: dtprobed Not tainted 6.11.0-=
rc6+ #1
> [   42.662565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.6.6 08/22/2023
> [   42.663472] RIP: 0010:fuse_get_req+0x36b/0x990 [fuse]
> [   42.664046] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8c 05 00 00 4=
8 b8 00 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d 58 48 89 fa 48 c1 ea 03 <=
80> 3c 02 00 0f 85 4d 05 00 00 f6 45 59 20 0f 85 06 03 00 00 48 83
> [   42.666945] RSP: 0018:ffffc900009a7730 EFLAGS: 00010212
> [   42.668837] RAX: dffffc0000000000 RBX: 1ffff92000134eed RCX: ffffffffc=
20dec9a
> [   42.670122] RDX: 000000000000000b RSI: 0000000000000008 RDI: 000000000=
0000058
> [   42.672154] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102=
2110172
> [   42.672160] R10: ffff888110880b97 R11: ffffc900009a737a R12: 000000000=
0000001
> [   42.672179] R13: ffff888110880b60 R14: ffff888110880b90 R15: ffff88816=
9973840
> [   42.672186] FS:  00007f28cd21d7c0(0000) GS:ffff8883ef280000(0000) knlG=
S:0000000000000000
> [   42.672191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.[ CR02: ;32m00007f3237366208 CR3: 0  OK  79e001 CR4: 0000000000770=
ef0
> [   42.672214] PKRU: 55555554
> [   42.672218] Call Trace:
> [   42.672223]  <TASK>
> [   42.672226]  ? die_addr+0x41/0xa0
> [   42.672238]  ? exc_general_protection+0x14c/0x230
> [   42.672250]  ? asm_exc_general_protection+0x26/0x30
> [   42.672260]  ? fuse_get_req+0x77a/0x990 [fuse]
> [   42.672281]  ? fuse_get_req+0x36b/0x990 [fuse]
> [   42.672300]  ? kasan_unpoison+0x27/0x60
> [   42.672310]  ? __pfx_fuse_get_req+0x10/0x10 [fuse]
> [   42.672327]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672333]  ? alloc_pages_mpol_noprof+0x195/0x440
> [   42.672340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672345]  ? kasan_unpoison+0x27/0x60
> [   42.672350]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672355]  ? __kasan_slab_alloc+0x4d/0x90
> [   42.672362]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672367]  ? __kmalloc_cache_noprof+0x134/0x350
> [   42.672376]  fuse_simple_background+0xe7/0x180 [fuse]
> [   42.672406]  cuse_channel_open+0x540/0x710 [cuse]
> [   42.672415]  misc_open+0x2a7/0x3a0
> [   42.672424]  chrdev_open+0x1ef/0x5f0
> [   42.672432]  ? __pfx_chrdev_open+0x10/0x10
> [   42.672439]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672443]  ? security_file_open+0x3bb/0x720
> [   42.672451]  do_dentry_open+0x43d/0x1200
> [   42.672459]  ? __pfx_chrdev_open+0x10/0x10
> [   42.672468]  vfs_open+0x79/0x340
> [   42.672475]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672482]  do_open+0x68c/0x11e0
> [   42.672489]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672495]  ? __pfx_do_open+0x10/0x10
> [   42.672501]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.672506]  ? open_last_lookups+0x2a2/0x1370
> [   42.672515]  path_openat+0x24f/0x640
> [   42.672522]  ? __pfx_path_openat+0x10/0x10
> [   42.723972]  ? stack_depot_save_flags+0x45/0x4b0
> [   42.724787]  ? __fput+0x43c/0xa70
> [   42.725100]  do_filp_open+0x1b3/0x3e0
> [   42.725710]  ? poison_slab_object+0x10d/0x190
> [   42.726145]  ? __kasan_slab_free+0x33/0x50
> [   42.726570]  ? __pfx_do_filp_open+0x10/0x10
> [   42.726981]  ? do_syscall_64+0x64/0x170
> [   42.727418]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   42.728018]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.728505]  ? do_raw_spin_lock+0x131/0x270
> [   42.728922]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   42.729494]  ? do_raw_spin_unlock+0x14c/0x1f0
> [   42.729992]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.730889]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.732178]  ? alloc_fd+0x176/0x5e0
> [   42.732585]  do_sys_openat2+0x122/0x160
> [   42.732929]  ? __pfx_do_sys_openat2+0x10/0x10
> [   42.733448]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.734013]  ? __pfx_map_id_up+0x10/0x10
> [   42.734482]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.735529]  ? __memcg_slab_free_hook+0x292/0x500
> [   42.736131]  __x64_sys_openat+0x123/0x1e0
> [   42.736526]  ? __pfx___x64_sys_openat+0x10/0x10
> [   42.737369]  ? __x64_sys_close+0x7c/0xd0
> [   42.737717]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   42.738192]  ? syscall_trace_enter+0x11e/0x1b0
> [   42.738739]  do_syscall_64+0x64/0x170
> [   42.739113]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   42.739638] RIP: 0033:0x7f28cd13e87b
> [   42.740038] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 0=
0 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <=
48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
> [   42.741943] RSP: 002b:00007ffc992546c0 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000101
> [   42.742951] RAX: ffffffffffffffda RBX: 00007f28cd44f1ee RCX: 00007f28c=
d13e87b
> [   42.743660] RDX: 0000000000000002 RSI: 00007f28cd44f2fa RDI: 00000000f=
fffff9c
> [   42.744518] RBP: 00007f28cd44f2fa R08: 0000000000000000 R09: 000000000=
0000001
> [   42.745211] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000002
> [   42.745920] R13: 00007f28cd44f2fa R14: 0000000000000000 R15: 000000000=
0000003
> [   42.746708]  </TASK>
> [   42.746937] Modules linked in: cuse vfat fat ext4 mbcache jbd2 intel_r=
apl_msr intel_rapl_common kvm_amd ccp bochs drm_vram_helper kvm drm_ttm_hel=
per ttm pcspkr i2c_piix4 drm_kms_helper i2c_smbus pvpanic_mmio pvpanic joyd=
ev sch_fq_codel drm fuse xfs nvme_tcp nvme_fabrics nvme_core sd_mod sg virt=
io_net net_failover virtio_scsi failover crct10dif_pclmul crc32_pclmul ata_=
generic pata_acpi ata_piix ghash_clmulni_intel virtio_pci sha512_ssse3 virt=
io_pci_legacy_dev sha256_ssse3 virtio_pci_modern_dev sha1_ssse3 libata seri=
o_raw dm_multipath btrfs blake2b_generic xor zstd_compress raid6_pq sunrpc =
dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4=
 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp =
libiscsi_tcp libiscsi scsi_transport_iscsi qemu_fw_cfg aesni_intel crypto_s=
imd cryptd
> [   42.754333] ---[ end trace 0000000000000000 ]---
> [   42.756899] RIP: 0010:fuse_get_req+0x36b/0x990 [fuse]
> [   42.757851] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8c 05 00 00 4=
8 b8 00 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d 58 48 89 fa 48 c1 ea 03 <=
80> 3c 02 00 0f 85 4d 05 00 00 f6 45 59 20 0f 85 06 03 00 00 48 83
> [   42.760334] RSP: 0018:ffffc900009a7730 EFLAGS: 00010212
> [   42.760940] RAX: dffffc0000000000 RBX: 1ffff92000134eed RCX: ffffffffc=
20dec9a
> [   42.761697] RDX: 000000000000000b RSI: 0000000000000008 RDI: 000000000=
0000058
> [   42.763009] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102=
2110172
> [   42.763920] R10: ffff888110880b97 R11: ffffc900009a737a R12: 000000000=
0000001
> [   42.764839] R13: ffff888110880b60 R14: ffff888110880b90 R15: ffff88816=
9973840
> [   42.765716] FS:  00007f28cd21d7c0(0000) GS:ffff8883ef280000(0000) knlG=
S:0000000000000000
> [   42.766890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.767828] CR2: 00007f3237366208 CR3: 000000012c79e001 CR4: 000000000=
0770ef0
> [   42.768730] PKRU: 55555554
> [   42.769022] Kernel panic - not syncing: Fatal exception
> [   42.770758] Kernel Offset: 0x7200000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   42.771947] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> It's obviously CUSE related callstack. For CUSE case, we don't have super=
block and
> our checks for SB_I_NOIDMAP flag does not make any sense. Let's handle th=
is case gracefully.
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Chandan Babu R <chandanbabu@kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Fixes: aa16880d9f13 ("fuse: add basic infrastructure to support idmapping=
s")
> Link: https://lore.kernel.org/linux-next/87v7z586py.fsf@debian-BULLSEYE-l=
ive-builder-AMD64/ [1]
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Reported-by: syzbot+20c7e20cc8f5296dca12@syzkaller.appspotmail.com
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  fs/fuse/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e42b2f38d35f..84226bffc419 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -114,7 +114,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap=
 *idmap,
>  {
>         struct fuse_conn *fc =3D fm->fc;
>         struct fuse_req *req;
> -       bool no_idmap =3D (fm->sb->s_iflags & SB_I_NOIDMAP);
> +       bool no_idmap =3D (!fm->sb || fm->sb->s_iflags & SB_I_NOIDMAP);
>         kuid_t fsuid;
>         kgid_t fsgid;
>         int err;
> @@ -516,7 +516,7 @@ static void fuse_force_creds(struct fuse_req *req)
>  {
>         struct fuse_conn *fc =3D req->fm->fc;
>
> -       if (req->fm->sb->s_iflags & SB_I_NOIDMAP) {
> +       if (!req->fm->sb || req->fm->sb->s_iflags & SB_I_NOIDMAP) {
>                 req->in.h.uid =3D from_kuid_munged(fc->user_ns, current_f=
suid());
>                 req->in.h.gid =3D from_kgid_munged(fc->user_ns, current_f=
sgid());
>         } else {
> --
> 2.34.1
>

