Return-Path: <linux-fsdevel+bounces-53082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91812AE9D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958CE3BACDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9C2E3384;
	Thu, 26 Jun 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nm3+NQf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206D2E2F1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941089; cv=none; b=qnKammVWooKfjn/i7AgwP7lrB5g/hO1Hw1qTWkUT24kn+pfODHURcgApU49W0h7784f1RdJAKTDTpDb/I9/TOGY1fxoMud8UZ4i0v0toxqN5AzbSRIFfHMrHu0cgqmTm23FQi31/Nb1IPNu4Lanu+KwPvXGVNtRlRpONHTBvtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941089; c=relaxed/simple;
	bh=ikAqrARMintdfzIAiwBkaBMZza4NhrCDSZUeSTVgGWs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LFYn5qyglSSjRID23w5nthINiVD3NWdREQiLJu5xpVYlCmG1e8byW1BETtPHZBWUSL1iH9e5O/eQSVEsEha1RoHCneEZ57IaX+v7EVmPaLRqwvtOIZGts4i6SGcxp3+tM+5j8NZMgbtn/jdJZyIjfzqZzxb+iXeWFSW4OejmrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nm3+NQf9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31329098ae8so927390a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750941087; x=1751545887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EIOkAUyi7+ujarkTFH99WxEnz3RnUsZ9Cfbw2lKPPMg=;
        b=nm3+NQf9udfxsZJejIAQPsJi5CxS+rYJHelMMKvkk7uOr4qoSpq5W9MI/jnDCjeARu
         oNF8HU5zr6dcWkINvognL0ywu7k8Vd/LfMu0ZvMN13c5IZnH2TTSyqnwor983BZw4jcO
         b/MmJbJqJmugTm1yUSTaRG8BnSJeGN7pfMD4c7Ect7ZMHgwyTwQKU5eKH4xIX4ZurHGh
         hpfNVwFA12JCSae/GY3urD75W7LoQ5sqb7kHIJs6jUWy5tctIerzmsnEa2735wLWZmMr
         arW9lV7mDsjQG3HHoIN1z4u1aPkAMJJbCaTL1y0GXoCrD6MBO4fnyIrPNG5OVJYTsE03
         33rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941087; x=1751545887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIOkAUyi7+ujarkTFH99WxEnz3RnUsZ9Cfbw2lKPPMg=;
        b=A50SpI/9Te08u0OrD2kvBDSGhAu1E6IQDEM6JpTsHPku2xCfJYG37WwVSw3rQWXItS
         fRnZeBKh1pcGVKQKAUMglkUxUwXeguKivIVou1MOQjqdcXxPDQSQYOJheWQbMLFrtn7h
         w+aspjkzv/xdX7I18vAEommK87udHocsnpy+Yuj7JHaKUjoeJvbQBiGK74lJ+cyJovmi
         6UX9sc/ccOciDsLRzGSpCJ3QjJNuxgLF/XW2gPydSbhSQF/mlBsYvGUWFNWHEcvZTuCu
         MoWZAqrzjHe5gFj7tyW3nPjRV/ZHhdxsqWWrwq03Kx6cgJr1odIZNU0PKZPJmxFxz4fR
         sBJg==
X-Forwarded-Encrypted: i=1; AJvYcCUu+Idoj8rWJxPeGGaFU/YdTmSJTuq1ljbeTeWQRgld/ArR2VbvRA/Uxuq5XhpeveqoR6pRl7gpLEXcx2op@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51mdG47LgO+xOVHpp1wL0Wy1oOmUBvlqEyMXFrbzRIa19qzTJ
	/z7lYf7e41RY6nMsqXza6i2ZWoLtR4vJsowQwjEJW1boGz4QP3d5h2IIT2ho/eRyslRmrv/W2mM
	SKDib6jNwzYgl3UV+GSxegihnN49vbv6ijtrJnli3Zg==
X-Gm-Gg: ASbGncs311WWuVHh03bS9A4MFlbeGrt3Lsyif1VRxOfrfzJD02O0zPPD5R7UW7kARPo
	p8bOn9kw1MhE6DoyDPqV/c4Biw+s8xzunh69pdM8nM735Dh1VcoNVz0sOJor9sjh+74vWwV8I+T
	fnRXq+eLRq5w/ttp4ZkU2S7ZfetHV3N86mP+CFsxfqSo5qqn4vXV6w0ZF35N6cGoimEBFLgUXzC
	EdGozjfhdjxRj0=
X-Google-Smtp-Source: AGHT+IGA5Lld9l17rfBeRi3J6RtVhUs8VMLhujLLvSb8uLda4du0G2dKBSQALBMM1VCCHZPZuj94xiQrzmJCa/zGAg8=
X-Received: by 2002:a17:90a:ec8f:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-316d69c8e39mr4270600a91.5.1750941087313; Thu, 26 Jun 2025
 05:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 18:01:16 +0530
X-Gm-Features: Ac12FXzu4alDLey0mZeuA43OiDuuxMWqb_ya1XrTviNkqYaW1clUM_UZCxNwuVM
Message-ID: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
Subject: next-20250626: WARNING fs jbd2 transaction.c start_this_handle with ARM64_64K_PAGES
To: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Regressions noticed on arm64 devices while running LTP syscalls mmap16
test case on the Linux next-20250616..next-20250626 with the extra build
config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.

Not reproducible with 4K page size.

Test environments:
- Dragonboard-410c
- Juno-r2
- rk3399-rock-pi-4b
- qemu-arm64

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
transaction.c start_this_handle

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
<6>[   89.498969] loop0: detected capacity change from 0 to 614400
<3>[   89.609561] operation not supported error, dev loop0, sector
20352 op 0x9:(WRITE_ZEROES) flags 0x20000800 phys_seg 0 prio class 0
<6>[   89.707795] EXT4-fs (loop0): mounted filesystem
6786a191-5e0d-472b-8bce-4714e1a4fb44 r/w with ordered data mode. Quota
mode: none.
<3>[   90.023985] JBD2: kworker/u8:2 wants too many credits
credits:416 rsv_credits:21 max:334
<4>[   90.024973] ------------[ cut here ]------------
<4>[ 90.025062] WARNING: fs/jbd2/transaction.c:334 at
start_this_handle+0x4c0/0x4e0, CPU#0: 2/42
<4>[   90.026661] Modules linked in: btrfs blake2b_generic xor
xor_neon raid6_pq zstd_compress sm3_ce sha3_ce fuse drm backlight
ip_tables x_tables
<4>[   90.027952] CPU: 0 UID: 0 PID: 42 Comm: kworker/u8:2 Not tainted
6.16.0-rc3-next-20250626 #1 PREEMPT
<4>[   90.029043] Hardware name: linux,dummy-virt (DT)
<4>[   90.029524] Workqueue: writeback wb_workfn (flush-7:0)
<4>[   90.030050] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 90.030311] pc : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
<4>[ 90.030481] lr : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
<4>[   90.030656] sp : ffffc000805cb650
<4>[   90.030785] x29: ffffc000805cb690 x28: fff00000dd1f5000 x27:
ffffde2ec0272000
<4>[   90.031097] x26: 00000000000001a0 x25: 0000000000000015 x24:
0000000000000002
<4>[   90.031360] x23: 0000000000000015 x22: 0000000000000c40 x21:
0000000000000008
<4>[   90.031618] x20: fff00000c231da78 x19: fff00000c231da78 x18:
0000000000000000
<4>[   90.031875] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[   90.032859] x14: 0000000000000000 x13: 00000000ffffffff x12:
0000000000000000
<4>[   90.033225] x11: 0000000000000000 x10: ffffde2ebfba8bd0 x9 :
ffffde2ebd34e944
<4>[   90.033607] x8 : ffffc000805cb278 x7 : 0000000000000000 x6 :
0000000000000001
<4>[   90.033971] x5 : ffffde2ebfb29000 x4 : ffffde2ebfb293d0 x3 :
0000000000000000
<4>[   90.034294] x2 : 0000000000000000 x1 : fff00000c04dc080 x0 :
000000000000004c
<4>[   90.034772] Call trace:
<4>[ 90.035068] start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1)) (P)
<4>[ 90.035366] jbd2__journal_start (fs/jbd2/transaction.c:501)
<4>[ 90.035586] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
<4>[ 90.035807] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242
fs/ext4/inode.c:2846)
<4>[ 90.036004] ext4_writepages (fs/ext4/inode.c:2953)
<4>[ 90.036233] do_writepages (mm/page-writeback.c:2636)
<4>[ 90.036406] __writeback_single_inode (fs/fs-writeback.c:1680)
<4>[ 90.036616] writeback_sb_inodes (fs/fs-writeback.c:1978)
<4>[ 90.036891] wb_writeback (fs/fs-writeback.c:2156)
<4>[ 90.037122] wb_workfn (fs/fs-writeback.c:2303 (discriminator 1)
fs/fs-writeback.c:2343 (discriminator 1))
<4>[ 90.037318] process_one_work (kernel/workqueue.c:3244)
<4>[ 90.037517] worker_thread (kernel/workqueue.c:3316 (discriminator
2) kernel/workqueue.c:3403 (discriminator 2))
<4>[ 90.037752] kthread (kernel/kthread.c:463)
<4>[ 90.037903] ret_from_fork (arch/arm64/kernel/entry.S:863)
<4>[   90.038217] ---[ end trace 0000000000000000 ]---
<2>[   90.039950] EXT4-fs (loop0): ext4_do_writepages: jbd2_start:
9223372036854775807 pages, ino 14; err -28
<3>[   90.040291] JBD2: kworker/u8:2 wants too many credits
credits:416 rsv_credits:21 max:334
<4>[   90.040374] ------------[ cut here ]------------
<4>[ 90.040386] WARNING: fs/jbd2/transaction.c:334 at
start_this_handle+0x4c0/0x4e0, CPU#1: 2/42


## Source
* Kernel version: 6.16.0-rc3-next-20250626
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: ecb259c4f70dd5c83907809f45bf4dc6869961d7
* Git describe: 6.16.0-rc3-next-20250626
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250626/
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: gcc-13-lkftconfig-64k_page_size

## Build arm64
* Test log: https://qa-reports.linaro.org/api/testruns/28894530/log_file/
* Test LAVA log 1:
https://lkft.validation.linaro.org/scheduler/job/8331353#L6841
* Test LAVA log 2:
https://lkft.validation.linaro.org/scheduler/job/8331352#L8854
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250626/log-parser-test/exception-warning-fsjbd2transaction-at-start_this_handle/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/config

--
Linaro LKFT
https://lkft.linaro.org

