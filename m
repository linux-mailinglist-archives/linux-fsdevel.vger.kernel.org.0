Return-Path: <linux-fsdevel+bounces-71991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8DCCDA649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF3E1302F699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D5296BD2;
	Tue, 23 Dec 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ySJm05FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1919199EAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519148; cv=none; b=lw37iCYMkTZL+Fn+4gA9oG9yl8J04CAzniIUZBiGsRQyyZWaReQeeozlkv71l8sGgtxgZ8NA3/8tyzJ/kO/2NLjL7eKgdde+i7bOPV5iVTycP+1zQUQW42jbR6JGZZmz13DIjgViiYCc8sJNYAMTcY4ejjekCoZBs9REOQYUHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519148; c=relaxed/simple;
	bh=RNw3+uzVTnaU4+ybKZn+Eus4mxuDSTUKNd2YQflqFds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkOZF4LD+0chCE0rmsf9wdCGnBHk6LLwkuHiUpWJA9+joOa/jugcj5bOgr7J3pNJbV0XcVyhVk9k9R2EzlLSPE/qs+XFotbJOcJ781uwNvdWZUsdU3OBuloxCYi3n3wy+Y5XLj6teBtDUKW+NYDHCEpVpVsLQXumWPy/mcmzQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ySJm05FF; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-786a822e73aso46940387b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 11:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766519145; x=1767123945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyAnAuv8TAO4bVutT1xgoxcJ8b/sjqaLxC950ViN6M8=;
        b=ySJm05FFdWZYEWxK7ESGMHfm0dVQZr5ytPVcGPWTI8WdDoEnF2lh1KvCvy+3M+7jba
         e+qS6OLq7nA9RGd96xoFD7/sz6OxNXppo9ajhmd/XdHRb3hZK2K9gk7+ZjCpJxa1ONU+
         aBe50kWWUsXgd6GblYNLSg8stATn3VZ7a4Kl+PrH5+1j3JRMKvl02OP3WZs/VC6BOIGP
         ObsIW8sQ37f1a/VUC6aHuIab/qNif6lDoEgk+VHMuIj12Fh2xlgMZWqDivIPq2SkI57l
         NZbCERn26egLwkKFUiUzZ7GR6ShI96UGrPP3v+jw55kKRKtI+IrKwzRg8EkM9j794PuW
         6Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766519145; x=1767123945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyAnAuv8TAO4bVutT1xgoxcJ8b/sjqaLxC950ViN6M8=;
        b=ngQM79NvmmCWlplHcTE1ZnHDjf+DZyeRD46w05V2361RYSWnsFdOKnWBv8vztn4a0j
         oqq0r0618rs9tY71tXSzLocJtElHGsEPJiiiFxC8q0EbLbcJ8E9qJwl77F/Qwddva38i
         Q5A3H3GWATjQGJCTWTAwK8VHz0VGWutbKsxuGfCN/BIviS7Y5urxz+XA6uYq09UkYpzJ
         1kZ2SqCszRhC09eHc8ZUwKZmHHF8UguOafCbsR3/eu8m4F9KB/cR10gjl8bMQahjdUM9
         N2jLRK/4I7CX8ODn0nPtoLgcn6EFXI4ucKp1nrkIIpdJeaYcATvjUvy2eAwcBON/D+3W
         T7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG9Uk8lAZ7i0fpaOlEn6YT891CpvxWfWp2vbMAoua8oxlWmRvl/dPu09+cgWoFHnzZEvDHmIsxChYbYxzp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/ZWkWryd54IKr3Iy35Fr1PV3AKeS4DMImjaEcU3hgnWjSoDx
	vr43Kwmh+XOKfcFoRuAE5YdeERUhmvZcUybp8ad3JOuyaNaQAHpeUV5OfOVncLbyXM4=
X-Gm-Gg: AY/fxX7DBVnL+6oXYmtwL539tjlBWtenhq4/f9xyf4zmzMe3grIoTUniVW0YmW8FlHY
	bTRKCim/Aq2L9MNYvoZFG6TgGbBss1W89PxX2yviIgIoBtDuWE2b9i6RCE00vwjFvCEPlAB7xB8
	Ncrm0H4lBv3XWvgMKKT73C740pp1tTYzyq/XFOKETz5t4HfgmIYh2F1SuUNzDP+rvy6JJXnqlvz
	lsD2bBMuOONe+Hip2UT8RBMXjVgpXDijGaKgQlHOTXk88xHyC1Ljw3smqFqDIUNuZJsWv3KF1kg
	wOb3dRc6q+3auuNFLRXdEtLVAaxYO0D/sdKmPDrw1rJX5zlJXy5lmQcg8pElArH0c956lu5pgy7
	xLhReDGSJHd5K6eruFyc2r+BmK8HNMjAc412QRK6GtL25WcnOUw9C2Tk+9lS6RseFbeo6sh8dn0
	KiSWiyjP6L//z8YCgRHsCgpwaV4745eVy+o6GTSiCPT9wJXesetYTQx6M4kAJn1CoqM6ynAGafE
	4u+detdwSCaB4E4QQ==
X-Google-Smtp-Source: AGHT+IENYOydq4I8WsECS+vyDuPCAhCdSVj5+yxkBVdwizao8NzM154fCSdMVlOtpFL+I2IU+8rXpQ==
X-Received: by 2002:a05:690c:6011:b0:786:5c6f:d242 with SMTP id 00721157ae682-78fb40b11bbmr115581747b3.69.1766519144577;
        Tue, 23 Dec 2025 11:45:44 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:9c0:b73a:26dd:817f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4376656sm57705337b3.9.2025.12.23.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:45:43 -0800 (PST)
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
Subject: [PATCH v3] ceph: fix kernel crash in ceph_open()
Date: Tue, 23 Dec 2025 11:45:38 -0800
Message-ID: <20251223194538.251829-1-slava@dubeyko.com>
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

v3
The namespace_equals() logic has been generalized into
__namespace_equals() with the goal of using it in
ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.

This patch reworks ceph_mdsmap_decode() and namespace_equals() with
the goal of supporting the suggested concept. Now struct ceph_mdsmap
contains m_fs_name field that receives copy of extracted FS name
by ceph_extract_encoded_string(). For the case of "old" CephFS file systems,
it is used "cephfs" name. Also, namespace_equals() method has been
reworked with the goal of proper names comparison.

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.c#L5666
[2] https://tracker.ceph.com/issues/73886

Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c         | 11 +++++------
 fs/ceph/mdsmap.c             | 22 ++++++++++++++++------
 fs/ceph/mdsmap.h             |  1 +
 fs/ceph/super.h              | 36 +++++++++++++++++++++++++++++++-----
 include/linux/ceph/ceph_fs.h |  6 ++++++
 5 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7e4eab824dae..dd0d2df9d452 100644
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
@@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "fsname check fs_name=%s  match.fs_name=%s\n",
 	      fs_name, auth->match.fs_name ? auth->match.fs_name : "");
-	if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
+
+	if (!__namespace_equals(auth->match.fs_name, fs_name, NAME_MAX)) {
 		/* fsname mismatch, try next one */
 		return 0;
 	}
@@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 {
 	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = fsc->client;
-	const char *mds_namespace = fsc->mount_options->mds_namespace;
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
 	u32 epoch;
@@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		namelen = ceph_decode_32(&info_p);
 		ceph_decode_need(&info_p, info_end, namelen, bad);
 
-		if (mds_namespace &&
-		    strlen(mds_namespace) == namelen &&
-		    !strncmp(mds_namespace, (char *)info_p, namelen)) {
+		if (namespace_equals(fsc->mount_options,
+				     (char *)info_p, namelen)) {
 			mount_fscid = fscid;
 			break;
 		}
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 2c7b151a7c95..9cadf811eb4b 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -353,22 +353,31 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
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
+		m->m_fs_name = kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
 	}
 	/* damaged */
 	if (mdsmap_ev >= 9) {
@@ -430,6 +439,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
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
index a1f781c46b41..5bfa873b5bcc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -104,18 +104,44 @@ struct ceph_mount_options {
 	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
+#define CEPH_NAMESPACE_WILDCARD		"*"
+
+static inline bool __namespace_equals(const char *name1, const char *name2,
+					size_t max_len)
+{
+	size_t len1, len2;
+
+	if (!name1 || !name2)
+		return true;
+
+	len1 = strnlen(name1, max_len);
+	len2 = strnlen(name2, max_len);
+
+	return !(len1 != len2 || strncmp(name1, name2, len1));
+}
+
 /*
  * Check if the mds namespace in ceph_mount_options matches
  * the passed in namespace string. First time match (when
  * ->mds_namespace is NULL) is treated specially, since
  * ->mds_namespace needs to be initialized by the caller.
  */
-static inline int namespace_equals(struct ceph_mount_options *fsopt,
-				   const char *namespace, size_t len)
+static inline bool namespace_equals(struct ceph_mount_options *fsopt,
+				    const char *namespace, size_t len)
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
+	if (strcmp(fsopt->mds_namespace, CEPH_NAMESPACE_WILDCARD) == 0)
+		return true;
+
+	if (!namespace)
+		return false;
+
+	return __namespace_equals(fsopt->mds_namespace, namespace, len);
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


