Return-Path: <linux-fsdevel+bounces-54357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA0AFEAAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D40F3AF4B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DCC2E541F;
	Wed,  9 Jul 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnG91yrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFD2E0B7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068948; cv=none; b=MhILlmzRP5OFBZhnqPxPbx3+3bTTGz6o97rE/Vk0T1/vxAEMqW5ck+9dxB4sEVxM3pRaRTYS5qCKkLaynhO2D3RvC8r2Yx2pRxXYhkX9urv0MHSz0s3TixUtFynFIa3CoUjOA3TAEdpjDLK3BizgaMNPbHokGB6QODAHuwNRlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068948; c=relaxed/simple;
	bh=u6pIaYjMS3IKe3laU0ihfZ43XKRHDXUnACjtbvu0k1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppXx3W09/0TJ3InnLIAhdWEVrTWQu6NRYXJLwbZcvBIv310ASzeIc2uk50cZHf/VJ4XY5B84V57G4gZVkQHWk0upyeJOowZg+DzucllxhuuQmXAp43iOwRq9iiEzLilGaaLHBKCkE/ITSxleO9Y7A+gKNZAcSYkwxjP+n4dbX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnG91yrP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5853472a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752068945; x=1752673745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ateKzkbCHc5sIaL8yEpNYKQqvJ9cJ8N1E9YOvRIl00=;
        b=qnG91yrPubh+SjqXBl0yhKECCHcvQ3L5KOP65eVW9mLs8XpxgrQ4oBlrnsKzu7FB6v
         pdumAAFqWsoRbsFESJOuNBziNl84Pzsg/svYcjY4m8ueDUfhMZnUUwUYrti4gi4MyFCD
         +rGmdJLvniMRV16HubPLExGkGLTHjlnOstKe2RN3EdcCNfuJ/Lv+w9YoncCsa2hQUqjl
         3J6La3svcJqreKV4GAjC3wfQQeqUBks2sEbKTf2WL+NvcH+ZutgsqjrczOxvzXxvPq+A
         L34CaSA2H8KJmVfHaxd0KNfGb2BStuNPqau6bEQ1ewOiEAjpI6/t0qCSHnde1dUghy1/
         8F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068945; x=1752673745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ateKzkbCHc5sIaL8yEpNYKQqvJ9cJ8N1E9YOvRIl00=;
        b=GQG/fiPkvf2+dWmdb8DbT6VdrhzcoqBnnLda4uz/dlFS8NncH3nLWTHLhKTOT8EKiX
         91dy73x/3VUZXd2CyM1ZKf1aBbpJ77ZegUKCvGiQTXGxn9MDP9LUOao9wIiECCkp9a5S
         A9sBqcZCCSXP+iRoZrVFHw/98yJkb8DReWiLhhTQAkf1dXEd043aAZy3Cl8uILAxVdt6
         xnd0Yf6zWfs058XU2o4QCKjm5H9ipx+8fuBRvNLjxlxcXIwrpVfg6JAb4zF8NwDI+QAc
         ygfx/3J4dqzFkMqj1Uq19ypkHU4+laAr/ANSGWKRUyxHjk7NrsZHnd8r0xQUM4bsyiSa
         kCiw==
X-Forwarded-Encrypted: i=1; AJvYcCW2HqIFvIGCosEDtihwTwKfPfmjnjU2whKJL//0h1F43Bbd/Rww3mtbov91/KxAbSK+mMdnQnSy83DlPm52@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhK2vNqljqaTo383LCfytsugzgiF39J7Q+ahsavHb2O/dAmTL
	jZ1xzKk6g49zbk4AStnHbTzIGGCSpojtfWypG6Zp1bJ6QkosurLLF2Dot/NPYcGUbN8ha8WQFsN
	2dIxmBy4y/sJM1fxnT4i/zg9ttc94mXcSlJpYrBCO2g==
X-Gm-Gg: ASbGncvC7JfCMvfv2j+owtVxWkA7WYvKV+SD9kdnmDqxsweoFwLWPXiKCtPsPOWAOoT
	O8ja841fSOj2186e5+4RTeyyhhTjrOfWzk+KYdZkboxVlSHWBTD3eFuWUyOfX8u8ghfdyuBTXfF
	FnP7mcwW27zoVv3Zz7RE6/YXqDLEbXXmuttQRPofO6tsbw8kteBZ+/p0pjUV0Rf802w8XFyiDWh
	UNq
X-Google-Smtp-Source: AGHT+IEQhV/nQ/B4d0iM22W5NrME2JaC25s+7CHkU0EidyyHVczc0JiUB1Lee+thAVIgRRGr45oEj47FGwEV1HtC4tQ=
X-Received: by 2002:a17:90b:1c83:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-31c2fda93a0mr4025868a91.20.1752068945122; Wed, 09 Jul 2025
 06:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 19:18:53 +0530
X-Gm-Features: Ac12FXzgk6k00MV94kKXG4l_JDYuhQNs3d5XgUxk-gImCMO8BtDoIe_cQgiLU2U
Message-ID: <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
Subject: Re: LTP: syscalls: TWARN ioctl(/dev/loop0, LOOP_SET_STATUS,
 test_dev.img) failed EOPNOTSUPP (95)
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Petr Vorel <pvorel@suse.cz>, chrubis <chrubis@suse.cz>, rbm@suse.com, 
	Jens Axboe <axboe@kernel.dk>, willy@infradead.org, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 18:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regressions were observed while testing LTP syscalls cachestat01 and
> other related tests on the next-20250702 Linux kernel across several devices.
>
> The issue appears to be related to the inability to configure /dev/loop0
> via the LOOP_SET_STATUS ioctl, which returned EOPNOTSUPP
> (Operation not supported). This results in a TBROK condition,
> causing the test to fail.

Anders, bisected this down to this commit id,
   # first bad commit:
       [9eb22f7fedfc9eb1b7f431a5359abd4d15b0b0cd]
       fs: add ioctl to query metadata and protection info capabilities

> Test environments:
> - arm64
> - qemu-x86_64
> - qemu-riscv
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
>
> Regressions started from next-20250702 ( next-20250708)
> Good: next-20250701
> Bad: next-20250702
>
> Test regression: Linux next-20250702 TWARN ioctl(/dev/loop0,
> LOOP_SET_STATUS, test_dev.img) failed EOPNOTSUPP (95) TBROK Failed to
> acquire device
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test log
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_cacQ9AfS0 as tmpdir (tmpfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_device.c:190: TWARN: ioctl(/dev/loop0, LOOP_SET_STATUS,
> test_dev.img) failed: EOPNOTSUPP (95)
> tst_device.c:362: TBROK: Failed to acquire device

Lore link,
* https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/

>
> ## Source
> * Kernel version: 6.16.0-rc4-next-20250702
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 50c8770a42faf8b1c7abe93e7c114337f580a97d
> * Git describe: next-20250702
> * Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637
> * Architectures: arm64, x86_64, riscv64.
> * Toolchains: gcc-13 and clang-20
> * Kconfigs: defconfig+ltp
>
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/28986655/log_file/
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250702/ltp-syscalls/cachestat01/
> * Test history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637/suite/ltp-syscalls/test/cachestat01/history/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/config
>
> ## List of tests
>   - cachestat01
>   - cachestat04
>   - chdir01
>   - chmod09
>   - close_range01
>   - copy_file_range01
>   - copy_file_range02
>   - creat09
>   - fallocate04
>   - fallocate05
>   - fallocate06
>   - fanotify01
>   - fanotify05
>   - fanotify06
>   - fanotify10
>   - fanotify13
>   - fanotify14
>   - fanotify15
>   - fanotify16
>   - fanotify17
>   - fanotify18
>   - fanotify19
>   - fanotify20
>   - fanotify21
>   - fanotify22
>   - fanotify23
>   - fchmodat2_01
>   - fdatasync03
>   - fgetxattr01
>   - fremovexattr01
>   - fremovexattr02
>   - fsetxattr01
>   - fsmount01
>   - fsmount02
>   - fsopen01
>   - fsopen02
>   - fspick01
>   - fspick02
>   - fsskipig01
>   - fsskipig02
>   - fsskipig03
>   - fstatfs01
>   - fstatfs01_64
>   - fsync01
>   - fsync04
>   - getdents01
>   - getdents02
>   - getxattr02
>   - getxattr03
>   - inotify03
>   - ioctl04
>   - ioctl05
>   - ioctl06
>   - ioctl_ficlone02
>   - ioctl_fiemap01
>   - ioctl_loop01
>   - lchown03
>   - linkat02
>   - listmount01
>   - listmount02
>   - lremovexattr01
>   - lstat03
>   - lstat03_64
>   - mkdir09
>   - mknodat02
>   - mmap16
>   - mount01
>   - mount02
>   - mount03
>   - mount04
>   - mount05
>   - mount06
>   - mount07
>   - mount_setattr01
>   - move_mount01
>   - move_mount02
>   - msync04
>   - open_tree01
>   - open_tree02
>   - prctl06
>   - preadv03
>   - preadv03_64
>   - preadv203
>   - preadv203_64
>   - pwritev03
>   - pwritev03_64
>   - quotactl01
>   - quotactl04
>   - quotactl06
>   - quotactl08
>   - quotactl09
>   - readahead02
>   - readdir01
>   - rename01
>   - rename03
>   - rename04
>   - rename05
>   - rename06
>   - rename07
>   - rename08
>   - rename10
>   - rename11
>   - rename12
>   - rename13
>   - rename15
>   - renameat01
>   - setxattr01
>   - stat04
>   - stat04_64
>   - statfs01
>   - statfs01_64
>   - statmount01
>   - statmount02
>   - statmount04
>   - statmount05
>   - statmount06
>   - statmount07
>   - statvfs01
>   - statx06
>   - statx08
>   - statx10
>   - statx11
>   - statx12
>   - sync01
>   - syncfs01
>   - umount01
>   - umount02
>   - umount03
>   - umount2_01
>   - umount2_02
>   - unlink09
>   - utime01
>   - utime02
>   - utime03
>   - utime04
>   - utime05
>   - utimensat01
>   - writev03
>

--
Linaro LKFT
https://lkft.linaro.org

