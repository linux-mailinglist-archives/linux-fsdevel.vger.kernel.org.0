Return-Path: <linux-fsdevel+bounces-53771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B53AF6B80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 09:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF345253C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6269299944;
	Thu,  3 Jul 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loK8ogUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FF298CC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527581; cv=none; b=NIc34dQZkOr547robhBsTibDjp0HJGxhUooHBH0hxr9nbEt1TjlHxs1uzhE8r6BZmzJB6vOlyt5QqJ0XEvkPmv88G9SagMo6Vsx9Gm3yUan3AMbAMtA+9SHHy1ZnGf3BWuFOxm8YVkO0ZYm4nVn7UnvFbFHv1egts6axXh3Go+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527581; c=relaxed/simple;
	bh=eXG7L6apoeVaPxa6zg1mVdlH+teKsLNGl93S/Tr0PoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js47uhg8rDiZ6+41755jnm5IUgNXh/75k13ihtEauva0umSkk19x+f7iG+y32igR70matnHGSwNYfAMGKRgNT/PMxBByKuq/Xicx8cSEi7wrdshofFW4k5z/lYSupMjJGvtW1X0k0AMffnoquOpwI2QOcjQ5JmSdw2Bb+F9OB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loK8ogUX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23633a6ac50so96845265ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751527578; x=1752132378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GAMKSN1cf/DpMVRo6gFlykOi6cd+hJQyMWIE0kM7p2Y=;
        b=loK8ogUXGIhVB3sCRdTnY+ZaQcbBbNZ8gwXBetgvlP2tHI/us/8hlTnH/9052phb26
         WmCZZJn0yQ0J7tm9S+2yEFnwXPI6npur7zgiK4xs78t8NE6iHf3OeZq82lyPse60dxZy
         lSM4oqTQxoBJQnCkO3WYRV5p7m45KNfyO0RrsALiGOTRGSeXrTP3PzuceVG/AwXvxNcT
         RnhC4RtL9G6m7Fhg5x0D1z5NEC7eEoTfKX9N2ceYuQC4CtMLv5WPZxDhrCNPz/RZDfI6
         dWrRKw/Buh/5uBCTkhLDh2p1dFgNCFkfqs3hFx5CtyFrHRAUAWfv9oitckfv+uTKbuLN
         7mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751527578; x=1752132378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAMKSN1cf/DpMVRo6gFlykOi6cd+hJQyMWIE0kM7p2Y=;
        b=mIstdveqXzW0k88SdN8p0iKPu70b/LBMQ6okaTwJr8mzwT59mocXRpnbJm/4fR1xB2
         U8e1O1+zUJxlbVKplLszOd5Rw4e9jO5FWwjw6cJpNRQJ8LO7VgtDTFw2HvS/bh9mZI6P
         IRDt7c4ZwGG9z+Qe0IQZFmcvlpymJQFy9bpOW9vLyfOwqSbbsLCtmPUoZpoE5m+RRe74
         ByfgiSbDtbtjOJK3IPaYnZLn0noftUzMN0m1CVDq5hzFBINobI5BV+fw1poLqIyEKenW
         wyIMHUswZfWZ1tjOr+96P1T1auYwxyg7drAbqsE2mZHt2m981LOMEvvFmt8Gv3UYtuxL
         h4dw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc2+N6ZfFGu+2j8KxxQ0JxNFRne96BFFVRENfA7uQ7JqGmm3/szwmWNeyz/sjJliHB8AuHf7zbAtBTWlz@vger.kernel.org
X-Gm-Message-State: AOJu0YzfloGoXstttmHjWV2SPF7R4SdZOBacCqtnnrJdQkjugBzPd7Ds
	AwAUiHh66VQdebZw/ku6KXjAuQ1x6yG9MQZGwLDxUcF9IQS776zJukUB8meR97GTEtSNpHsR37d
	l9TOYDbA2/cJGwIj3WrBNlri+d0JFD1WBCWlh0WiP7g==
X-Gm-Gg: ASbGncv1E4PRumWHASLbfcbp9TYiw3TmKgK1oV1zR/Y7RotGBFh/lsSb+cmrmjmvWJS
	HTEvlpF4Pc49vbY5xdo6u4RBEIB6jK4nWuuNNjmWZ5K4TjzFzk8uDJkh4z32WQTMFkmN7gCmxAc
	vVHaeJIyCek4s+2Zo3Q9QM6cIOMbB9+4UpzRrK+oT8bLYtsoY7bHpUwyC3o0DspmacL9ta1r6dR
	5+Q2LN3p3VBvA==
X-Google-Smtp-Source: AGHT+IFBtroNhRgT2smI4MTW+nF7Q1k9nWSGPUagsoi7hbtQlf2pdM4tjmPERmB0KQXgaKAhNH2kWUgg6ohVrZtxleU=
X-Received: by 2002:a17:90a:d60c:b0:313:1a8c:c2c6 with SMTP id
 98e67ed59e1d1-31a90bc9850mr9100678a91.16.1751527578511; Thu, 03 Jul 2025
 00:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
In-Reply-To: <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Jul 2025 12:56:06 +0530
X-Gm-Features: Ac12FXzBgwMwFGfOkzvJ_EzX-plndvQT1fRe69w5kV27SFg1-zbk8bDaXp-Lnc4
Message-ID: <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
Subject: Re: next-20250626: WARNING fs jbd2 transaction.c start_this_handle
 with ARM64_64K_PAGES
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>
> Hi, Naresh!
>
> On 2025/6/26 20:31, Naresh Kamboju wrote:
> > Regressions noticed on arm64 devices while running LTP syscalls mmap16
> > test case on the Linux next-20250616..next-20250626 with the extra build
> > config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
> >
> > Not reproducible with 4K page size.
> >
> > Test environments:
> > - Dragonboard-410c
> > - Juno-r2
> > - rk3399-rock-pi-4b
> > - qemu-arm64
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
> > transaction.c start_this_handle
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you for the report. The block size for this test is 1 KB, so I
> suspect this is the issue with insufficient journal credits that we
> are going to resolve.

I have applied your patch set [1] and tested and the reported
regressions did not fix.
Am I missing anything ?

[1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/

>
> Thanks,
> Yi.

- Naresh

> >
> > ## Test log
> > <6>[   89.498969] loop0: detected capacity change from 0 to 614400
> > <3>[   89.609561] operation not supported error, dev loop0, sector
> > 20352 op 0x9:(WRITE_ZEROES) flags 0x20000800 phys_seg 0 prio class 0
> > <6>[   89.707795] EXT4-fs (loop0): mounted filesystem
> > 6786a191-5e0d-472b-8bce-4714e1a4fb44 r/w with ordered data mode. Quota
> > mode: none.
> > <3>[   90.023985] JBD2: kworker/u8:2 wants too many credits
> > credits:416 rsv_credits:21 max:334
> > <4>[   90.024973] ------------[ cut here ]------------
> > <4>[ 90.025062] WARNING: fs/jbd2/transaction.c:334 at
> > start_this_handle+0x4c0/0x4e0, CPU#0: 2/42
> > <4>[   90.026661] Modules linked in: btrfs blake2b_generic xor
> > xor_neon raid6_pq zstd_compress sm3_ce sha3_ce fuse drm backlight
> > ip_tables x_tables
> > <4>[   90.027952] CPU: 0 UID: 0 PID: 42 Comm: kworker/u8:2 Not tainted
> > 6.16.0-rc3-next-20250626 #1 PREEMPT
> > <4>[   90.029043] Hardware name: linux,dummy-virt (DT)
> > <4>[   90.029524] Workqueue: writeback wb_workfn (flush-7:0)
> > <4>[   90.030050] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
> > -SSBS BTYPE=--)
> > <4>[ 90.030311] pc : start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1))
> > <4>[ 90.030481] lr : start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1))
> > <4>[   90.030656] sp : ffffc000805cb650
> > <4>[   90.030785] x29: ffffc000805cb690 x28: fff00000dd1f5000 x27:
> > ffffde2ec0272000
> > <4>[   90.031097] x26: 00000000000001a0 x25: 0000000000000015 x24:
> > 0000000000000002
> > <4>[   90.031360] x23: 0000000000000015 x22: 0000000000000c40 x21:
> > 0000000000000008
> > <4>[   90.031618] x20: fff00000c231da78 x19: fff00000c231da78 x18:
> > 0000000000000000
> > <4>[   90.031875] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > <4>[   90.032859] x14: 0000000000000000 x13: 00000000ffffffff x12:
> > 0000000000000000
> > <4>[   90.033225] x11: 0000000000000000 x10: ffffde2ebfba8bd0 x9 :
> > ffffde2ebd34e944
> > <4>[   90.033607] x8 : ffffc000805cb278 x7 : 0000000000000000 x6 :
> > 0000000000000001
> > <4>[   90.033971] x5 : ffffde2ebfb29000 x4 : ffffde2ebfb293d0 x3 :
> > 0000000000000000
> > <4>[   90.034294] x2 : 0000000000000000 x1 : fff00000c04dc080 x0 :
> > 000000000000004c
> > <4>[   90.034772] Call trace:
> > <4>[ 90.035068] start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1)) (P)
> > <4>[ 90.035366] jbd2__journal_start (fs/jbd2/transaction.c:501)
> > <4>[ 90.035586] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
> > <4>[ 90.035807] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242
> > fs/ext4/inode.c:2846)
> > <4>[ 90.036004] ext4_writepages (fs/ext4/inode.c:2953)
> > <4>[ 90.036233] do_writepages (mm/page-writeback.c:2636)
> > <4>[ 90.036406] __writeback_single_inode (fs/fs-writeback.c:1680)
> > <4>[ 90.036616] writeback_sb_inodes (fs/fs-writeback.c:1978)
> > <4>[ 90.036891] wb_writeback (fs/fs-writeback.c:2156)
> > <4>[ 90.037122] wb_workfn (fs/fs-writeback.c:2303 (discriminator 1)
> > fs/fs-writeback.c:2343 (discriminator 1))
> > <4>[ 90.037318] process_one_work (kernel/workqueue.c:3244)
> > <4>[ 90.037517] worker_thread (kernel/workqueue.c:3316 (discriminator
> > 2) kernel/workqueue.c:3403 (discriminator 2))
> > <4>[ 90.037752] kthread (kernel/kthread.c:463)
> > <4>[ 90.037903] ret_from_fork (arch/arm64/kernel/entry.S:863)
> > <4>[   90.038217] ---[ end trace 0000000000000000 ]---
> > <2>[   90.039950] EXT4-fs (loop0): ext4_do_writepages: jbd2_start:
> > 9223372036854775807 pages, ino 14; err -28
> > <3>[   90.040291] JBD2: kworker/u8:2 wants too many credits
> > credits:416 rsv_credits:21 max:334
> > <4>[   90.040374] ------------[ cut here ]------------
> > <4>[ 90.040386] WARNING: fs/jbd2/transaction.c:334 at
> > start_this_handle+0x4c0/0x4e0, CPU#1: 2/42
> >
> >
> > ## Source
> > * Kernel version: 6.16.0-rc3-next-20250626
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git sha: ecb259c4f70dd5c83907809f45bf4dc6869961d7
> > * Git describe: 6.16.0-rc3-next-20250626
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250626/
> > * Architectures: arm64
> > * Toolchains: gcc-13
> > * Kconfigs: gcc-13-lkftconfig-64k_page_size
> >
> > ## Build arm64
> > * Test log: https://qa-reports.linaro.org/api/testruns/28894530/log_file/
> > * Test LAVA log 1:
> > https://lkft.validation.linaro.org/scheduler/job/8331353#L6841
> > * Test LAVA log 2:
> > https://lkft.validation.linaro.org/scheduler/job/8331352#L8854
> > * Test details:
> > https://regressions.linaro.org/lkft/linux-next-master/next-20250626/log-parser-test/exception-warning-fsjbd2transaction-at-start_this_handle/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/config
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
>

