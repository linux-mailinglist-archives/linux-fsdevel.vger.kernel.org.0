Return-Path: <linux-fsdevel+bounces-39462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E05A1489E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 04:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1203E7A33DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 03:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B171F63DA;
	Fri, 17 Jan 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="r5LfO0wc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228FD1DE2D7
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085871; cv=none; b=TEhb2pCUVBblnBhtUKf8Gd9VbvW2WAuPwB726FH5GdXAKssOq/fhex80vg1OS9F8ZSHwPFnx3SJoJJLBWCOqbzi9qyhdwi8NSuMpNNRYYRNwEnkcG0nTu8NxILlaJRbvf7EoCa08a6OEftLMoyWFBPpLeStlTuw4KwZ+cCCzb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085871; c=relaxed/simple;
	bh=AtRhsmLZHisi86BMoYiI+Dw5GzKD/XnXuiKzQUv+JuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RApB3Mu292nnex/fx5NEcQGm1Doc+ASVB9n1E7GwkgBBSGzvmT3IXN6+rj5uDJr7Jquz0/+41MrCn9tPOcRfVvG0gVxhOIrLCMeX8bNK4wstCF2Z7tog2+U3BtOtg8wwPG8Mj2piR7m3uGJMnn4N5KdxIaTlTP1QwPsSzpCMAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=r5LfO0wc; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3eb8559b6b0so1018615b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1737085865; x=1737690665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvRjCVZbCMqEuOac3xUXEvODXzaqLwUYNnWGGG01b48=;
        b=r5LfO0wcMWmWW/Y2C39Gk17k/wNtb/hf+9pS4x8ge82Zbx5VgeMSUE36AGJ8ExEOJG
         NvLn/ptGMw16YqZxLMFA43hcRHdgrh8LCiMRxm/aBVZNhi3XG5OA700UlBQfPYFOJBVe
         ds30A+Iyd5Zx12BD13mGzLPVpylF/Hz8529wlRphGIriLlUIIqjMzl4IsxsMaXard2mP
         aJvo7wLdjFgSkBzD0HzFQFofzjb4bNKss/vhtU54+OEVib/HzbvuOBcGV1JQcpQ48LYy
         akiTspMG034hJSCtczC5JwqFIeonNOjGaTCnSeXWK99X4uGwm8TEUjcrDBcrcBixZ1Yi
         p48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737085865; x=1737690665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvRjCVZbCMqEuOac3xUXEvODXzaqLwUYNnWGGG01b48=;
        b=f5ia/XsEXZScGcQDjocq6VtDdBSGjGmYMZ3KvGXz+zBbc83GszcH5HHLUXzpxvx9Ok
         iWCg7u+P0dRJs/J/HU5PgOVeXJ48q1xcXWq/OPiQTb0FNKJc2yLfUDs0HPQAV0amez63
         FBgxizIQpZVVbupGYvmy5nAVaRHeNz7lrFxXduM7Wef0eH9wtYqQVLfyZq6Tttodr7js
         Y3qRAIf3hDPbLs4woGhnrTEWYu4UAPsgffstOFqvT7dROutT6cNNfZ3/aPc8dvKyIUMI
         U0AupCmbSpXajeAR8F941bCFqNHJy+UGEjG9kro9g8mymyU6OqiJLfIumVMGAvo1D5/Y
         eEEA==
X-Gm-Message-State: AOJu0YxrWAn80nALVl5UjfvfifSECcXwfvbP1hRyaYRP/hsq3o1XH1sQ
	f8UvDnifziKP9Z6IezYSPRr5s5qcKAvom5vW0vxhGaTCfPgN7paM4mvF+E4oVjo=
X-Gm-Gg: ASbGncuCQAUaCjVjPdpe6htJjw0R56ChuI1FdqynR5l8JGCsi6w7t1ZxHXt/Ol2+Ed0
	dy66MqLHuJAk3JCBsOGWt8Wy3Ax/7aHrcGVeTO4HQY6IFshXaOjLOHXXZgPJDtgPghsV2PPswvb
	rxQhuPeaDuepyT3u2WNSVbS6gEKmovVFTcv0CPGNPgB0RYpjpJjwrauh135FClxsg5fFNSXHEMW
	sgOrPjhXzX8nTSkNlk+NLehhpAlL+427zs6NGMDAY5ides8vNcHcDpTlxYcDe37fYA+QTHwU8Q=
X-Google-Smtp-Source: AGHT+IEtdRWd1to576bYQZx0e21EPyuI/wOGhnIGOBB/TbR68l/85ohBNtmkVuzowFPr001ZrEVzZw==
X-Received: by 2002:a05:6808:3206:b0:3eb:7973:1120 with SMTP id 5614622812f47-3f19fc4ceb3mr845439b6e.3.1737085865504;
        Thu, 16 Jan 2025 19:51:05 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:ab8a:afb3:8646:80f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19db783edsm585977b6e.40.2025.01.16.19.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 19:51:04 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	idryomov@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	dhowells@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Date: Thu, 16 Jan 2025 19:50:44 -0800
Message-ID: <20250117035044.23309-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/397 test generate kernel crash for the case of
encrypted inode with unaligned file size (for example, 33K
or 1K):

Jan 3 12:34:40 ceph-testing-0001 root: run xfstest generic/397
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.737811] run fstests generic/397 at 2025-01-03 12:34:40
Jan 3 12:34:40 ceph-testing-0001 systemd1: Started /usr/bin/bash c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/397.
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.875761] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.876130] libceph: client4614 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.991965] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 877.992334] libceph: client4617 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017234] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.017594] libceph: client4620 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.031394] xfs_io (pid 18988) is setting deprecated v1 encryption policy; recommend upgrading to v2.
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054528] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.054892] libceph: client4623 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070287] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:40 ceph-testing-0001 kernel: [ 878.070704] libceph: client4626 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.264586] libceph: mon0 (2)127.0.0.1:40674 session established
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.265258] libceph: client4629 fsid 19b90bca-f1ae-47a6-93dd-0b03ee637949
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374578] -----------[ cut here ]------------
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.374586] kernel BUG at net/ceph/messenger.c:1070!
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.375150] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378145] CPU: 2 UID: 0 PID: 4759 Comm: kworker/2:9 Not tainted 6.13.0-rc5+ #1
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.378969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.380167] Workqueue: ceph-msgr ceph_con_workfn
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.381639] RIP: 0010:ceph_msg_data_cursor_init+0x42/0x50
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.382152] Code: 89 17 48 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.383928] RSP: 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.384447] RAX: ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385129] RDX: 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.385839] RBP: ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.386539] R10: 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387203] R13: ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.387877] FS: 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.388663] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389212] CR2: 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.389921] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.390620] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391307] PKRU: 55555554
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391567] Call Trace:
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.391807] <TASK>
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392021] ? show_regs+0x71/0x90
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392391] ? die+0x38/0xa0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392667] ? do_trap+0xdb/0x100
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.392981] ? do_error_trap+0x75/0xb0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393372] ? ceph_msg_data_cursor_init+0x42/0x50
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.393842] ? exc_invalid_op+0x53/0x80
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394232] ? ceph_msg_data_cursor_init+0x42/0x50
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.394694] ? asm_exc_invalid_op+0x1b/0x20
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395099] ? ceph_msg_data_cursor_init+0x42/0x50
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.395583] ? ceph_con_v2_try_read+0xd16/0x2220
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396027] ? _raw_spin_unlock+0xe/0x40
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396428] ? raw_spin_rq_unlock+0x10/0x40
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.396842] ? finish_task_switch.isra.0+0x97/0x310
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397338] ? __schedule+0x44b/0x16b0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.397738] ceph_con_workfn+0x326/0x750
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398121] process_one_work+0x188/0x3d0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398522] ? __pfx_worker_thread+0x10/0x10
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.398929] worker_thread+0x2b5/0x3c0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399310] ? __pfx_worker_thread+0x10/0x10
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.399727] kthread+0xe1/0x120
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400031] ? __pfx_kthread+0x10/0x10
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400431] ret_from_fork+0x43/0x70
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.400771] ? __pfx_kthread+0x10/0x10
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401127] ret_from_fork_asm+0x1a/0x30
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401543] </TASK>
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.401760] Modules linked in: hctr2 nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha_generic chacha_x86_64 libchacha adiantum libpoly1305 essiv authenc mptcp_diag xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag intel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit kvm_intel kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel joydev crypto_simd cryptd rapl input_leds psmouse sch_fq_codel serio_raw bochs i2c_piix4 floppy qemu_fw_cfg i2c_smbus mac_hid pata_acpi msr parport_pc ppdev lp parport efi_pstore ip_tables x_tables
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407319] ---[ end trace 0000000000000000 ]---
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.407775] RIP: 0010:ceph_msg_data_cursor_init+0x42/0x50
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.408317] Code: 89 17 48 8b 46 70 55 48 89 47 08 c7 47 18 00 00 00 00 48 89 e5 e8 de cc ff ff 5d 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 0b <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410087] RSP: 0018:ffffb4ffc7cbbd28 EFLAGS: 00010287
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.410609] RAX: ffffffff82bb9ac0 RBX: ffff981390c2f1f8 RCX: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.411318] RDX: 0000000000009000 RSI: ffff981288232b58 RDI: ffff981390c2f378
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412014] RBP: ffffb4ffc7cbbe18 R08: 0000000000000000 R09: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.412735] R10: 0000000000000000 R11: 0000000000000000 R12: ffff981390c2f030
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.413438] R13: ffff981288232b58 R14: 0000000000000029 R15: 0000000000000001
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414121] FS: 0000000000000000(0000) GS:ffff9814b7900000(0000) knlGS:0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.414935] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.415516] CR2: 00005e106a0554e0 CR3: 0000000112bf0001 CR4: 0000000000772ef0
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.416907] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jan 3 12:34:41 ceph-testing-0001 kernel: [ 878.417630] PKRU: 55555554

BUG_ON(length > msg->data_length) triggers the issue:

(gdb) l *ceph_msg_data_cursor_init+0x42
0xffffffff823b45a2 is in ceph_msg_data_cursor_init (net/ceph/messenger.c:1070).
1065
1066 void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
1067 struct ceph_msg *msg, size_t length)
1068 {
1069 BUG_ON(!length);
1070 BUG_ON(length > msg->data_length);
1071 BUG_ON(!msg->num_data_items);
1072
1073 cursor->total_resid = length;
1074 cursor->data = msg->data;

The issue takes place because of this:
Jan 6 14:59:24 ceph-testing-0001 kernel: [ 202.628853] libceph: pid 144:net/ceph/messenger_v2.c:2034 prepare_sparse_read_data(): msg->data_length 33792, msg->sparse_read_total 36864
1070 BUG_ON(length > msg->data_length);
msg->sparse_read_total 36864 > msg->data_length 33792

The generic/397 test (xfstests) executes such steps:
(1) create encrypted files and directories;
(2) access the created files and folders with encryption key;
(3) access the created files and folders without encryption key.

The issue takes place in this portion of code:

    if (IS_ENCRYPTED(inode)) {
            struct page **pages;
            size_t page_off;

            err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len,
                                            &page_off);
            if (err < 0) {
                    doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
                          ceph_vinop(inode), err);
                    goto out;
            }

            /* should always give us a page-aligned read */
            WARN_ON_ONCE(page_off);
            len = err;
            err = 0;

            osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false,
                                             false);

The reason of the issue is that subreq->io_iter.count keeps
unaligned value of length:

Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.751182] pid 8059:lib/iov_iter.c:1185 __iov_iter_get_pages_alloc(): maxsize 36864, maxpages 4294967295, start 18446659367320516064
Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.752808] pid 8059:lib/iov_iter.c:1196 __iov_iter_get_pages_alloc(): maxsize 33792, maxpages 4294967295, start 18446659367320516064
Jan 16 12:46:56 ceph-testing-0001 kernel: [  347.754394] pid 8059:lib/iov_iter.c:1015 iter_folioq_get_pages(): maxsize 33792, maxpages 4294967295, extracted 0, _start_offset 18446659367320516064

This patch simply assigns the aligned value to
subreq->io_iter.count before calling iov_iter_get_pages_alloc2().

./check generic/397
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.13.0-rc7+ #58 SMP PREEMPT_DYNAMIC Wed Jan 15 00:07:06 UTC 2025
MKFS_OPTIONS  -- 127.0.0.1:40629:/scratch
MOUNT_OPTIONS -- -o name=fs,secret=<hidden>,ms_mode=crc,nowsync,copyfrom 127.0.0.1:<port>:/scratch /mnt/scratch

generic/397 1s ...  1s
Ran: generic/397
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 85936f6d2bf7..5e6ba92219f3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -396,6 +396,15 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		struct page **pages;
 		size_t page_off;
 
+		/*
+		 * The io_iter.count needs to be corrected to aligned length.
+		 * Otherwise, iov_iter_get_pages_alloc2() operates with
+		 * the initial unaligned length value. As a result,
+		 * ceph_msg_data_cursor_init() triggers BUG_ON() in the case
+		 * if msg->sparse_read_total > msg->data_length.
+		 */
+		subreq->io_iter.count = len;
+
 		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
@@ -405,6 +414,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 
 		/* should always give us a page-aligned read */
 		WARN_ON_ONCE(page_off);
+
 		len = err;
 		err = 0;
 
-- 
2.47.1


