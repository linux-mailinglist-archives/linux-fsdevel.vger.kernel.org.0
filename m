Return-Path: <linux-fsdevel+bounces-41173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CBFA2BF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22159188C9BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176261DE2D8;
	Fri,  7 Feb 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j5zTF9dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BA1C5F3A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920908; cv=none; b=BMU421mAjhPTm3qSosmWBlfdqGEZvDF1L6EEhmbbVn1yN11ESLQX4hjLq4w1g56sILGGMCdGGI8L2EKpew8m1prlggDLRqXS+RySlYmg8xtFSx1y2+Q/BKWo6tMsofMvcOSmpiO/IeW0feD/3j6cN+rhvXSWFuwcI9X/XLzEuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920908; c=relaxed/simple;
	bh=UXaSdhotgp828FkV8VVijuarNF2vY6vMLjTJJ3aScmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uht/Ivwm5F5e+iyY555EIAFhWKemRMdu9KOurxgpPOx+MOmGu2jn5IW1StlWj5C7JFMIlfOVulNhFclSBPN6GT2O1xOalz6l/kV/8748cEb84walKgqaSqw5+x5d/fxTTmcC1kWSq8jEbvCwnbMRRyuyJcW9Mmu366tYI2rs13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=j5zTF9dy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46c7855df10so32463801cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738920904; x=1739525704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvBAIkDO9QOvBU7NqegthW7XZqRlWaaFP1O+j150KSk=;
        b=j5zTF9dyq4uEGdJ+PQG6ZEXLjW3paTD93uVRJQfGBjuIMrUsjIISx4tWRRNiGlzLzf
         VHrZUrXxFctUGnsxv+4y69cE1T2aYApSqS1BwL/lgYuoKzCKvEXhbmA1omFOwgt6zt/w
         wJofU8IftyKqauXXBMTdBjxjEiS+taV456r5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920904; x=1739525704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvBAIkDO9QOvBU7NqegthW7XZqRlWaaFP1O+j150KSk=;
        b=hDxI9M+aiJNIN2xVpheFeLszyh+EpmrD1VdMOfX15D4ifoTdCXjAaKmtu0Kx+1J7iH
         ls2mvwPo+nm4owrfJ8lnTxTrEe9Wgy5PeozlSPVjtoliI+S6vKcAj4C3VyzmrHvV+sUC
         4qm6YfuguEQxbc2BD+Fft44fHVdX46c4TD1AZ0pFqGT/gRYZVRqSoSytIExghf7oQL0Z
         sbtIbkNwNKhjFqXbXjxN+mldYQxbPbV+8ypcKV1e5JomBXD2LYjGvMq61dV8WrkeGgqq
         jIhzkrEVUufg9pnSFMRtdPxZJNN4gAGBGBoJ35A8nWAoalfcuxSvsk5kCJNLmLY31sB3
         RWBA==
X-Forwarded-Encrypted: i=1; AJvYcCWa1EnxUGYc97tFSl4h9EHEyrVLWyfK4KG3+hmbA/rMOZ1w9lkaQHkAdHzoa9oZUHER5KfPX9dcyPW5Psmj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VNQTuJMyCOeUeLIHHHUsuuk+uH8bfpTagz8ezHMV4wKZ3h32
	jziRBGzeb8VlAz4ifJxLQMzjZm0TCW0qkn8QbTr65PN3L+I85GQ9hB5X0julTL3J/KeSxLbFqpG
	sI811O95SuAoHFyhanFqtCGYRgPWtltagr8MFzg==
X-Gm-Gg: ASbGncsNyfb4eRdR8+zzu4JlJkz/bONG1yt16ycRobKC6RkZqUyxq3XpTUyj+YbDYLU
	pVGR5VPwpCR13Cs2ifKrwQxyiuizAJatrTlDs84Qsh0kGKJiOS35I2/l7kdcl1yi7lOUkfg==
X-Google-Smtp-Source: AGHT+IEycv01hTqmGyNZ/5TGV/0qOQvuhChK5kqtEgpVS/PZou46s9T+Sebd8iZKxA1n4s2RWtmS6vVs5dieHHAI7s4=
X-Received: by 2002:a05:622a:130c:b0:46c:7197:7001 with SMTP id
 d75a77b69052e-47167ae273dmr34695651cf.34.1738920904174; Fri, 07 Feb 2025
 01:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
In-Reply-To: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 7 Feb 2025 10:34:52 +0100
X-Gm-Features: AWEUYZmUfJOwgJrh2uRzF4CV6Dm9DiedOgUKc14Gb6F3A4USokJoky8zA1AZnJw
Message-ID: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Christian Heusel <christian@heusel.eu>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Adding Joanne, Willy and linux-mm].


On Thu, 6 Feb 2025 at 11:54, Christian Heusel <christian@heusel.eu> wrote:
>
> Hello everyone,
>
> we have recently received [a report][0] on the Arch Linux Gitlab about
> multiple users having system crashes when using Flatpak programs and
> related FUSE errors in their dmesg logs.
>
> We have subsequently bisected the issue within the mainline kernel tree
> to the following commit:
>
>     3eab9d7bc2f4 ("fuse: convert readahead to use folios")
>
> The error is still present in the latest mainline release 6.14-rc1 and
> sadly testing a revert is not trivially possible due to conflicts.
>
> I have attached a dmesg output from a boot where the failure occurs and
> I'm happy to test any debug patches with the help of the other reporters
> on our GitLab.
>
> We also noticed that there already was [a discussion][1] about a related
> commit but the fix for the issue back then 7a4f54187373 ("fuse: fix
> direct io folio offset and length calculation") was already included in
> the revisions we have tested.
>
> Cheers,
> Christian
>
> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/is=
sues/110
> [1]: https://lore.kernel.org/all/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbew=
vo674f7f3y@cwnwffjqltzw/

Thanks for the report.

Seems like page allocation gets an inconsistent page (mapcount !=3D -1)
in the report below.

Any ideas why this could be happening?

Thanks,
Miklos

> Feb 06 08:54:47 archvm kernel: BUG: Bad page state in process rnote  pfn:=
67587
> Feb 06 08:54:47 archvm kernel: page: refcount:-1 mapcount:0 mapping:00000=
00000000000 index:0x0 pfn:0x67587
> Feb 06 08:54:47 archvm kernel: flags: 0xfffffc8000020(lru|node=3D0|zone=
=3D1|lastcpupid=3D0x1fffff)
> Feb 06 08:54:47 archvm kernel: raw: 000fffffc8000020 dead000000000100 dea=
d000000000122 0000000000000000
> Feb 06 08:54:47 archvm kernel: raw: 0000000000000000 0000000000000000 fff=
fffffffffffff 0000000000000000
> Feb 06 08:54:47 archvm kernel: page dumped because: PAGE_FLAGS_CHECK_AT_P=
REP flag(s) set
> Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common =
kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_inte=
l_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core =
polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_p=
mc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer=
 aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus sound=
core lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vso=
ck_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsoc=
k vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau d=
rm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec=
 atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fa=
ilover cec intel_agp virtio_input virtio_rng virtio_console failover virtio=
_blk i8042 intel_gtt serio
> Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote Not=
 tainted 6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef3209cee42e97ae1c
> Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS unknown 02/02/2022
> Feb 06 08:54:47 archvm kernel: Call Trace:
> Feb 06 08:54:47 archvm kernel:
> Feb 06 08:54:47 archvm kernel:  dump_stack_lvl+0x5d/0x80
> Feb 06 08:54:47 archvm kernel:  bad_page.cold+0x7a/0x91
> Feb 06 08:54:47 archvm kernel:  __rmqueue_pcplist+0x200/0xc50
> Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
> Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
> Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
> Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
> Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
> Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
> Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
> Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
> Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
> Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
> Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
> Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f 95 =
c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca =
01 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 62 c3 f=
f ff 48
> Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 0001020=
6
> Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 000000000000014=
0 RCX: 000056541d491ff0
> Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d49212=
0 RDI: 0000000000000000
> Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 000000000000014=
0 R09: 0000000000000001
> Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 000056541956748=
8 R12: 00007fcfc3308ac0
> Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc3308b2=
0 R15: 0000000000000140
> Feb 06 08:54:47 archvm kernel:
> Feb 06 08:54:47 archvm kernel: Disabling lock debugging due to kernel tai=
nt
> Feb 06 08:54:47 archvm kernel: Oops: general protection fault, probably f=
or non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote Tai=
nted: G    B              6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
> Feb 06 08:54:47 archvm kernel: Tainted: [B]=3DBAD_PAGE
> Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS unknown 02/02/2022
> Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
> Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 44 =
24 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 48 8b =
0a 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f be ff 4=
8 89 41
> Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 0001029=
7
> Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d61c=
0 RCX: dead000000000100
> Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd2218c=
0 RDI: ffff9b31fd2218c0
> Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 000000000000000=
0 R09: ffffab3b84a2f920
> Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 000000000000000=
3 R12: ffff9b31fd23d4b0
> Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef2198=
0 R15: ffff9b31fd23d480
> Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31fd2=
00000(0000) knlGS:0000000000000000
> Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed9400=
0 CR4: 00000000003506f0
> Feb 06 08:54:47 archvm kernel: Call Trace:
> Feb 06 08:54:47 archvm kernel:
> Feb 06 08:54:47 archvm kernel:  ? __die_body.cold+0x19/0x27
> Feb 06 08:54:47 archvm kernel:  ? die_addr+0x3c/0x60
> Feb 06 08:54:47 archvm kernel:  ? exc_general_protection+0x17d/0x400
> Feb 06 08:54:47 archvm kernel:  ? asm_exc_general_protection+0x26/0x30
> Feb 06 08:54:47 archvm kernel:  ? __rmqueue_pcplist+0xb0/0xc50
> Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
> Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
> Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
> Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
> Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
> Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
> Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
> Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
> Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
> Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
> Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
> Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f 95 =
c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca =
01 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 62 c3 f=
f ff 48
> Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 0001020=
6
> Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 000000000000014=
0 RCX: 000056541d491ff0
> Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d49212=
0 RDI: 0000000000000000
> Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 000000000000014=
0 R09: 0000000000000001
> Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 000056541956748=
8 R12: 00007fcfc3308ac0
> Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc3308b2=
0 R15: 0000000000000140
> Feb 06 08:54:47 archvm kernel:
> Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common =
kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_inte=
l_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core =
polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_p=
mc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer=
 aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus sound=
core lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vso=
ck_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsoc=
k vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau d=
rm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec=
 atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fa=
ilover cec intel_agp virtio_input virtio_rng virtio_console failover virtio=
_blk i8042 intel_gtt serio
> Feb 06 08:54:47 archvm kernel: ---[ end trace 0000000000000000 ]---
> Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
> Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 44 =
24 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 48 8b =
0a 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f be ff 4=
8 89 41
> Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 0001029=
7
> Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d61c=
0 RCX: dead000000000100
> Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd2218c=
0 RDI: ffff9b31fd2218c0
> Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 000000000000000=
0 R09: ffffab3b84a2f920
> Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 000000000000000=
3 R12: ffff9b31fd23d4b0
> Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef2198=
0 R15: ffff9b31fd23d480
> Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31fd2=
00000(0000) knlGS:0000000000000000
> Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed9400=
0 CR4: 00000000003506f0
> Feb 06 08:54:47 archvm kernel: note: rnote[1962] exited with preempt_coun=
t 2
> Feb 06 08:54:50 archvm geoclue[844]: Service not used for 60 seconds. Shu=
tting down..
> Feb 06 08:55:01 archvm systemd[990]: Starting Virtual filesystem metadata=
 service...
> Feb 06 08:55:14 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuck f=
or 26s! [kworker/0:3:370]
> Feb 06 08:55:14 archvm kernel: CPU#0 Utilization every 4s during lockup:
> Feb 06 08:55:14 archvm kernel:         #1: 100% system,          0% softi=
rq,          1% hardirq,          0% idle
> Feb 06 08:55:14 archvm kernel:         #2: 100% system,          0% softi=
rq,          1% hardirq,          0% idle
> Feb 06 08:55:14 archvm kernel:         #3: 100% system,          0% softi=
rq,          1% hardirq,          0% idle
> Feb 06 08:55:14 archvm kernel:         #4: 100% system,          0% softi=
rq,          1% hardirq,          0% idle
> Feb 06 08:55:14 archvm kernel:         #5: 100% system,          0% softi=
rq,          1% hardirq,          0% idle
> Feb 06 08:55:14 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common =
kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_inte=
l_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core =
polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_p=
mc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer=
 aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus sound=
core lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vso=
ck_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsoc=
k vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau d=
rm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec=
 atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fa=
ilover cec intel_agp virtio_input virtio_rng virtio_console failover virtio=
_blk i8042 intel_gtt serio
> Feb 06 08:55:14 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 T=
ainted: G    B D            6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178=
ef3209cee42e97ae1c
> Feb 06 08:55:14 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE
> Feb 06 08:55:14 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS unknown 02/02/2022
> Feb 06 08:55:14 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
> Feb 06 08:55:14 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0=
x267/0x490
> Feb 06 08:55:14 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 =
4c 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 =
f6 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 0=
0 00 41
> Feb 06 08:55:14 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 0000020=
6
> Feb 06 08:55:14 archvm kernel: RAX: 0000000000000003 RBX: 000000000004000=
0 RCX: 0000000000000008
> Feb 06 08:55:14 archvm kernel: RDX: 00000000000053b7 RSI: 000000000000000=
3 RDI: ffff9b31fd23d480
> Feb 06 08:55:14 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc=
0 R09: 0000000000000000
> Feb 06 08:55:14 archvm kernel: R10: 0000000000000000 R11: fefefefefefefef=
f R12: 0000000000000100
> Feb 06 08:55:14 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc=
0 R15: 0000000000000000
> Feb 06 08:55:14 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd2=
00000(0000) knlGS:0000000000000000
> Feb 06 08:55:14 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Feb 06 08:55:14 archvm kernel: CR2: 00007fa8ba718100 CR3: 000000001602200=
0 CR4: 00000000003506f0
> Feb 06 08:55:14 archvm kernel: Call Trace:
> Feb 06 08:55:14 archvm kernel:
> Feb 06 08:55:14 archvm kernel:  ? watchdog_timer_fn.cold+0x226/0x22b
> Feb 06 08:55:14 archvm kernel:  ? srso_return_thunk+0x5/0x5f
> Feb 06 08:55:14 archvm kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
> Feb 06 08:55:14 archvm kernel:  ? __hrtimer_run_queues+0x132/0x2a0
> Feb 06 08:55:14 archvm kernel:  ? hrtimer_interrupt+0xff/0x230
> Feb 06 08:55:14 archvm kernel:  ? __sysvec_apic_timer_interrupt+0x55/0x10=
0
> Feb 06 08:55:14 archvm kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x90
> Feb 06 08:55:14 archvm kernel:
> Feb 06 08:55:14 archvm kernel:
> Feb 06 08:55:14 archvm kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a/0x=
20
> Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x=
490
> Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x2be/0x=
490
> Feb 06 08:55:14 archvm kernel:  _raw_spin_lock+0x29/0x30
> Feb 06 08:55:14 archvm kernel:  decay_pcp_high+0x63/0x90
> Feb 06 08:55:14 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
> Feb 06 08:55:14 archvm kernel:  vmstat_update+0x13/0x50
> Feb 06 08:55:14 archvm kernel:  process_one_work+0x17e/0x330
> Feb 06 08:55:14 archvm kernel:  worker_thread+0x2ce/0x3f0
> Feb 06 08:55:14 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
> Feb 06 08:55:14 archvm kernel:  kthread+0xef/0x230
> Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
> Feb 06 08:55:14 archvm kernel:  ret_from_fork+0x34/0x50
> Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
> Feb 06 08:55:14 archvm kernel:  ret_from_fork_asm+0x1a/0x30
> Feb 06 08:55:14 archvm kernel:

