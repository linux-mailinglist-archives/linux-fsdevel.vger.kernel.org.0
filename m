Return-Path: <linux-fsdevel+bounces-71372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE598CC00DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 22:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D763084292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7B328638;
	Mon, 15 Dec 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="SJ7JMdmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7EA288502
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835611; cv=none; b=cjx9KKoTKgTcD/+ySeu0BGNSBJ4+wRZxqtsSajYK4ZGyZX55pCquznmYOZDIcv/HSdD6sKekuyaksmm2zdh1gTltAQOU656d/BZj8XXWkJMoF6iope/nBEOI1jrdwUa2EgnRje4lavl8ktJqGxMVVrpZTvRR0uAdxjH6GCRZlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835611; c=relaxed/simple;
	bh=cODjO7/AmZtp7MUgEu3ofjcRw2KyHMDkaGFVBxvZ7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9RStQlbFqzq26L+JhGXaN8iocQOOavKcdAlqZmdfulWHrpC+Zf3xQcI0IulFlWGP4luDmyEoQbGM7pDHu+ssWJm/lItwghlbFHtZfbRrr312FTLcRyFejI+VFy9oOlCr+6bp6LV/7bwhR1W78orIeOYNp9LVbAIYjTp5IRuVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=SJ7JMdmE; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78c35dc5806so37152127b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 13:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1765835608; x=1766440408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWYgf837M5XKLrW9NPd0RjKt04PAK+Ls/nZZVHJ16Gw=;
        b=SJ7JMdmEmX/xCwr8lFrVfIqZ8PIdf111j+Uzr0rixOXldtKHH5OqVtXG3vpgoF5X/4
         1jbnN4z7rgWmT6KIApLUEj99q1URxXcB9wmYzC5MdD9y4DT1SnuQPt9zbl+vV3SwMglL
         bcNmVkvlSsUjGdXVxiDc7t17lUmba/o2l718Y5usXsmJgsl0gf1VdgC7qn23j18vWPnE
         msSz1aclWRIK15KyG7A2SHo96KC1fLdup5F5q/iIHzfnFqVYUOzVT/d6+Kv3YrJxiMsu
         8f/pDFPVHiFX2MPm0lQDhJJeL9QWgYUoCtG52hJqx+sikmHHLQ34Wg//YyQjhX4w0FvH
         +x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765835608; x=1766440408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWYgf837M5XKLrW9NPd0RjKt04PAK+Ls/nZZVHJ16Gw=;
        b=axZ2lmzvgAvUtbE7+oeaI0m9i0AwkENUI0YtHONLj89YYRWByzqizko+Tmwrc71Irs
         0Bdj/FnT49a0E8NuI+3YkjRLkVvSBsYNPB/AgWJxKMSux1FtIVemAylc/z04UbOXUPMZ
         7Xtu9PwOOTjncif9kqNLAGgqkMZHEjFGClgXbejrOnK9llKeC96yqpiB8g/nuIzVgFdo
         JcROrdpaQgZ7JdpOA1yXKOH9yMGbxMNNQDHt+ENAwVbpvtGXGZfDdTXcRh6mUsFZNG57
         cNxsnXN/hm9TYPoZvXPOMr8yjTFIUZE4UkUz7OeQfEpLusaM5+McEaTIUz3fOQT+flVz
         uWDw==
X-Forwarded-Encrypted: i=1; AJvYcCVyH2wUH/pV4KIxMFSnzMmTWWoExrU3m7mQhUc7NRXpIighCQoW7nWKi1aHgpfM8Ap6cQ5JMlT3MmWCbOu7@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrVIicfjE3kv1xiD5zQPeFgaE9iLyHxi5tPV9gFUJr7/dhFRP
	hlf/yFtX4vHMk+vyZG4qCdlk15xQUpCqb6HF4LkT4fyLB3L/rITB58ZxAJhCCIDs/Gg=
X-Gm-Gg: AY/fxX6zx8c/UY3mhrIUwxyDQffDsSZY50vbPDumCcg9Y8RrfKGwU0e0CyAMTpIo3Ol
	p/bQ6ovtfkqvGjjWBZSK6keTidSvFmRHOvXmTx6yx5R7D/82RZrygI35D7ibWF/DprbQNRY770m
	9dh0dhQd/AUR6KV2GW5/nwQXRZ+X660yMKabg5MdtGieu6FwfTpNZrN8moZA7JUCuH87KNklfho
	WQH/hDmddzKl0DfbiMZArfEy7Eo+bId0n7YSVF0xcuyZlo+GF6vRo5an+vioeoUIQK3jz41K9XM
	Ms6SlsEgBhtZBrkOwwvPDbjVnWyEGBHJiOmRBbnCJCOYcsbmE/4+hnfXa0ep64gOz5LATtjaB5e
	bluadkYOrj7IdmUHF6EYoAy7RJVPCoVRZtKCUb4jJB/6Ihk8gQlnnTSn4CzLKdhjDNLukSAxFaq
	zqA16rg1sc0tJ/aUcS2UGCR1cg3qao6pnIDMmk664=
X-Google-Smtp-Source: AGHT+IHyeewqt+vXK8dbVKz/yacjaLPPaaHa3Mxu7PQEIpjJxpFIWthsAySbBO1i5mvwhhAwqDbIAw==
X-Received: by 2002:a05:690c:c11:b0:788:bda:4895 with SMTP id 00721157ae682-78e66952a54mr101257857b3.3.1765835607882;
        Mon, 15 Dec 2025 13:53:27 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:877:a727:61cf:6a50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748ff32bsm32375557b3.24.2025.12.15.13.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:53:27 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	pdonnell@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	khiremat@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH v2] ceph: fix kernel crash in ceph_open()
Date: Mon, 15 Dec 2025 13:53:02 -0800
Message-ID: <20251215215301.10433-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The CephFS kernel client has regression starting from 6.18-rc1.

sudo ./check -g quick
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAMIC Fri
Nov 14 11:26:14 PST 2025
MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch
/mnt/cephfs/scratch

Killed

Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
(2)192.168.1.213:3300 session established
Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
dereference, address: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read access in
kernel mode
Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) - not-
present page
Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SMP KASAN
NOPTI
Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 Comm:
xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Standard PC
(i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 90 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
cc cc 31
Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875c0
EFLAGS: 00010246
Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RBX:
ffff888116003200 RCX: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff88810126c900
Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R08:
0000000000000000 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R14:
0000000000000000 R15: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(0000)
GS:ffff8882401a4000(0000) knlGS:0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR3:
0000000110ebd001 CR4: 0000000000772ef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
ceph_mds_check_access+0x348/0x1760
Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
__kasan_check_write+0x14/0x30
Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x170
Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
__pfx_apparmor_file_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
__ceph_caps_issued_mask_metric+0xd6/0x180
Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x10e0
Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
__pfx_stack_trace_save+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
stack_depot_save_flags+0x28/0x8f0
Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x450
Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
__pfx__raw_spin_lock_irqsave+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0x2b0
Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
__check_object_size+0x453/0x600
Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x180
Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
__pfx_do_sys_openat2+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/0x240
Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
__pfx___x64_sys_openat+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
__pfx___handle_mm_fault+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2350
Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd50
Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
fpregs_assert_state_consistent+0x5c/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0xd50
Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x11/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
count_memcg_events+0x25b/0x400
Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b/0x6a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x11/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
fpregs_assert_state_consistent+0x5c/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
irqentry_exit_to_user_mode+0x2e/0x2a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x50
Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d 00 00
41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff
b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48
2b 14 25
Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316d0
EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RBX:
0000000000000002 RCX: 000074a85bf145ab
Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RSI:
00007ffc77d32789 RDI: 00000000ffffff9c
Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R08:
00007ffc77d31980 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R14:
0000000000000180 R15: 0000000000000001
Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core
pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_intel
rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgastate
serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp
parport efi_pstore
Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000000000000
]---
Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 90 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
cc cc 31
Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875c0
EFLAGS: 00010246
Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RBX:
ffff888116003200 RCX: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff88810126c900
Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R08:
0000000000000000 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R14:
0000000000000000 R15: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(0000)
GS:ffff8882401a4000(0000) knlGS:0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR3:
0000000110ebd001 CR4: 0000000000772ef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554

We have issue here [1] if fs_name == NULL:

const char fs_name = mdsc->fsc->mount_options->mds_namespace;
    ...
    if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
            / fsname mismatch, try next one */
            return 0;
    }

v2
Patrick Donnelly suggested that: In summary, we should definitely start
decoding `fs_name` from the MDSMap and do strict authorizations checks
against it. Note that the `--mds_namespace` should only be used for
selecting the file system to mount and nothing else. It's possible
no mds_namespace is specified but the kernel will mount the only
file system that exists which may have name "foo".

This patch reworks ceph_mdsmap_decode() and namespace_equals() with
the goal of supporting the suggested concept. Now struct ceph_mdsmap
contains m_fs_name field that receives copy of extracted FS name
by ceph_extract_encoded_string(). For the case of "old" CephFS file systems,
it is used "cephfs" name. Also, namespace_equals() method has been
reworked with the goal of proper names comparison.

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.c#L5666

Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c         |  2 +-
 fs/ceph/mdsmap.c             | 26 ++++++++++++++++++++------
 fs/ceph/mdsmap.h             |  1 +
 fs/ceph/super.h              | 19 ++++++++++++++++---
 include/linux/ceph/ceph_fs.h |  6 ++++++
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7e4eab824dae..1c02f97c5b52 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
 	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
 	struct ceph_client *cl = mdsc->fsc->client;
-	const char *fs_name = mdsc->fsc->mount_options->mds_namespace;
+	const char *fs_name = mdsc->mdsmap->m_fs_name;
 	const char *spath = mdsc->fsc->mount_options->server_path;
 	bool gid_matched = false;
 	u32 gid, tlen, len;
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 2c7b151a7c95..b54a226510f1 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -353,22 +353,35 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		__decode_and_drop_type(p, end, u8, bad_ext);
 	}
 	if (mdsmap_ev >= 8) {
-		u32 fsname_len;
+		size_t fsname_len;
+
 		/* enabled */
 		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
+
 		/* fs_name */
-		ceph_decode_32_safe(p, end, fsname_len, bad_ext);
+		m->m_fs_name = ceph_extract_encoded_string(p, end,
+							   &fsname_len,
+							   GFP_NOFS);
+		if (IS_ERR(m->m_fs_name)) {
+			m->m_fs_name = NULL;
+			goto nomem;
+		}
 
 		/* validate fsname against mds_namespace */
-		if (!namespace_equals(mdsc->fsc->mount_options, *p,
+		if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs_name,
 				      fsname_len)) {
 			pr_warn_client(cl, "fsname %*pE doesn't match mds_namespace %s\n",
-				       (int)fsname_len, (char *)*p,
+				       (int)fsname_len, m->m_fs_name,
 				       mdsc->fsc->mount_options->mds_namespace);
 			goto bad;
 		}
-		/* skip fsname after validation */
-		ceph_decode_skip_n(p, end, fsname_len, bad);
+	} else {
+		m->m_enabled = false;
+		/*
+		 * name for "old" CephFS file systems,
+		 * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
+		 */
+		m->m_fs_name = kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
 	}
 	/* damaged */
 	if (mdsmap_ev >= 9) {
@@ -430,6 +443,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
 		kfree(m->m_info);
 	}
 	kfree(m->m_data_pg_pools);
+	kfree(m->m_fs_name);
 	kfree(m);
 }
 
diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
index 1f2171dd01bf..d48d07c3516d 100644
--- a/fs/ceph/mdsmap.h
+++ b/fs/ceph/mdsmap.h
@@ -45,6 +45,7 @@ struct ceph_mdsmap {
 	bool m_enabled;
 	bool m_damaged;
 	int m_num_laggy;
+	char *m_fs_name;
 };
 
 static inline struct ceph_entity_addr *
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a1f781c46b41..c53bec40ea69 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -104,6 +104,8 @@ struct ceph_mount_options {
 	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
+#define CEPH_NAMESPACE_WIDCARD		"*"
+
 /*
  * Check if the mds namespace in ceph_mount_options matches
  * the passed in namespace string. First time match (when
@@ -113,9 +115,20 @@ struct ceph_mount_options {
 static inline int namespace_equals(struct ceph_mount_options *fsopt,
 				   const char *namespace, size_t len)
 {
-	return !(fsopt->mds_namespace &&
-		 (strlen(fsopt->mds_namespace) != len ||
-		  strncmp(fsopt->mds_namespace, namespace, len)));
+	if (!fsopt->mds_namespace && !namespace)
+		return true;
+
+	if (!fsopt->mds_namespace)
+		return true;
+
+	if (strcmp(fsopt->mds_namespace, CEPH_NAMESPACE_WIDCARD) == 0)
+		return true;
+
+	if (!namespace)
+		return false;
+
+	return !(strlen(fsopt->mds_namespace) != len ||
+		  strncmp(fsopt->mds_namespace, namespace, len));
 }
 
 /* mount state */
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index c7f2c63b3bc3..08e5dbe15ca4 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -31,6 +31,12 @@
 #define CEPH_INO_CEPH   2            /* hidden .ceph dir */
 #define CEPH_INO_GLOBAL_SNAPREALM  3 /* global dummy snaprealm */
 
+/*
+ * name for "old" CephFS file systems,
+ * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
+ */
+#define CEPH_OLD_FS_NAME	"cephfs"
+
 /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
 #define CEPH_MAX_MON   31
 
-- 
2.52.0


