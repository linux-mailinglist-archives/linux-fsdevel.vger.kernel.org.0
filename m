Return-Path: <linux-fsdevel+bounces-69138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA8C70DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6131350181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF13624C8;
	Wed, 19 Nov 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="hbm/+ty1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CC35E526
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581146; cv=none; b=tHrUuMfQ6hYd/ebRqj/tUWOoLGnNMmtNx//At87pATF81PDfMJ9rQ9NjwV9caC/d0yGxkS1Ma9Og0v7J8PWhwtazAoQCLSoSO4nq660aizngZOgeZWzkExsTWh/h76hzGL5lTf3LhNGrSB6A6ud6TolLwFSdSlppB91jAtRg2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581146; c=relaxed/simple;
	bh=zugOBYKPwxhsD1dsaZo5Blz8xBd4NQLbOLsJ1EgVCuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBfObAWBX1dBy9FKatCfJMHTdFBJ+B5aUGPJ3E93anO2WQStcClpqjTbO+x8KkoIVkNl0SegLyCh83lFOGzoV5yTaawENipeH+f0Kp8Viy2wQaE09BeSs0aVlkSE6NT1HBG8YUP5E37CUkSBsSH9Zpc8QGDM7L+UCZkkmvNwGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=hbm/+ty1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787e84ceaf7so1011797b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1763581138; x=1764185938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUkw48jdFzGsXPPwMnOrT4+DjlWoHMQhDny9+ftniU=;
        b=hbm/+ty1RLLwzr3/hAjnBk8krzPoX7vIwpJGzJ76MzdgvPZPDH/UlUPJMXbiwz7+s5
         tpC/WznSElViYz2Bj07XnITpfx777D166LUflwZk+HXhBZeTxHi7cgl2DJ0bqUCNSOsi
         NcTUz2B27aiDSrMh6QmRGheDuoRVwwSqGr5Vu3gmZuMs21LG1In+bARUxG9/GDJn+GpN
         Jqx098SjEokuZ7dtW2x0hHOGY1b8F/wcaG3eXMKXrxOy9LZyy9dpMnn2rgW8cquTHFTq
         AgWzI6ruSDBycBLvo1KE2+Zuqo/1AetYgX7L4n34Zn/TcCOKTGJPUMUifbG3KMV7Yz3O
         ARTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581138; x=1764185938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGUkw48jdFzGsXPPwMnOrT4+DjlWoHMQhDny9+ftniU=;
        b=XLOc8ET6y4Jp58sG+Y0g83kOREDaaXQQ4nwHU7JgohEQCdNaVf5sq2RV+7S0gyKsA9
         ApW0tIYGPyPifhFkJXqESbiLGKp0lP8WOa0dajOMbHYzWt6iOoeis6JEeeIV6MO2qAPt
         NPDTjOQ57pThx2MaFcWjAULUszTn8kXxaEDNu/afnUniefas6wr6R2crFKHRtfm48JYd
         adIFGlo/TOduOvVwMETBhSAgR3PGmoe/TeqtwKmzIz7jV3O9fOMLMxD30Qid5cDvE0oY
         YeQYpSU2MFoWBGJZigTILt8s8uRncvuz+/eqNDmjt028Rn9uOIZC143EUeUsCJJ9mP2+
         wgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFxmcYsAvbt2Z9TLpf09q2ZNxSoTU2zyzcxbM3R7SzXpjwrwHST+BT4m6eXgK1JyTaabaURyn6Hc3kJyL6@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcASFGtubBMnn8AwyC/akkz0chKcxQROahky7siIehgWqTBWt
	QQr530DcqLWzz7BA8YiribxNr1Uoi+GB8QMP11ASoiPUtXsL/j0MoprQjf0mJWLWsDQ=
X-Gm-Gg: ASbGncuHhBL+NyHQAQhib31+dmb0H1j97orsmCzNsw1xNR6Zb/H9r6+HgHL1NjI6dYs
	JKlWYnGZEo1hKnKFA5ldLzUhJ7lIGZR5Qhi8pqHrPjIJq8CpQfVd/s6CHLN9Opi2DZND6bwjgqf
	e/0kHTSeQjOZfam7Y4yWV6vIJEvDltOl1q2csqhCiQKKqzkX1lS/lIOimF6PG2/YHJjUe8tkIlP
	3UN0IrWG7kpJAhNRB67FNeTZqjB10ywT+ZB0FqgXaPOf5sfdPoS//DF5HZfjM8m5t3v0cqdqQnw
	Wj0o1oKTnCaUIvQePDtC1w9HvXdL5wWUaWZLA8KO1N4kSd9jNlCzOYntDQB7afLPynqSvBc/n0Q
	cL40Y3IO9EoT0/vQfz20FYsD0cvOkIW5g4dTnxxfF61t3UYF7jVoYUJxoi95odbKLVGzIoizx2k
	JLx5+BOqY1rW4qSG6Ila2eAoHq8oRHbymdZ1qzj47k
X-Google-Smtp-Source: AGHT+IGwWUDveYN7nCMXI2FPLoGjrTB2eBKwIRyaKtprZb0wQJR05shnKfEoLPOX4Ske8Nhtj8Vzxg==
X-Received: by 2002:a05:690c:9310:b0:788:1086:8843 with SMTP id 00721157ae682-78a79565fb3mr4812607b3.2.1763581138071;
        Wed, 19 Nov 2025 11:38:58 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:eca5:17ee:94de:e34a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a799278a3sm1069457b3.27.2025.11.19.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:38:57 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	khiremat@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH] ceph: fix kernel crash in ceph_open()
Date: Wed, 19 Nov 2025 11:37:46 -0800
Message-ID: <20251119193745.595930-2-slava@dubeyko.com>
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

The patch fixes the issue by introducing is_fsname_mismatch() method
that checks auth->match.fs_name and fs_name pointers validity, and
compares the file system names.

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.c#L5666

Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1740047aef0f..19c75e206300 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 	mutex_unlock(&s->s_mutex);
 }
 
+static inline
+bool is_fsname_mismatch(struct ceph_client *cl,
+			const char *fs_name1, const char *fs_name2)
+{
+	if (!fs_name1 || !fs_name2)
+		return false;
+
+	doutc(cl, "fsname check fs_name1=%s fs_name2=%s\n",
+	      fs_name1, fs_name2);
+
+	if (strcmp(fs_name1, fs_name2))
+		return true;
+
+	return false;
+}
+
 static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_cap_auth *auth,
 			       const struct cred *cred,
@@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 	u32 gid, tlen, len;
 	int i, j;
 
-	doutc(cl, "fsname check fs_name=%s  match.fs_name=%s\n",
-	      fs_name, auth->match.fs_name ? auth->match.fs_name : "");
-	if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
+	if (is_fsname_mismatch(cl, auth->match.fs_name, fs_name)) {
 		/* fsname mismatch, try next one */
 		return 0;
 	}
-- 
2.51.1


