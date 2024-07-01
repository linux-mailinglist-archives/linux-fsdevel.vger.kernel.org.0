Return-Path: <linux-fsdevel+bounces-22854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E989491DC40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10BD1F21EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939A12F365;
	Mon,  1 Jul 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnAM7ysf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587618289A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829165; cv=none; b=Fw9ppxBw5bQJtEZgHpsRNSOdNdkax1P4rGqbH02sg7RysqHmSd4EoTLTS9y5w5R4HRHEwEjImQn/vqPrB/EHe5V9E1x7M4r/IUVtL57n4LtERcLfrJcUajhF1QATqVwl3h/jcWRA0gesnc06luT3Lotj0KRIAkg01RQJXje6464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829165; c=relaxed/simple;
	bh=stQCQxg3iYHa7ZaMB1TA68tGpQvchZy636OSaRuUH/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=snZ+lEiQBALGs5RBwoFXZO0hqdLvrTQSGws0bEoSVyYh9fwHTdS9yrhahb40xCjxAY0PjvtHZrRSgTvUJsxIy9Fudr723J7GlWPI3fGhTH/qu/aW/FIL4mnlGiIjPM5w0s92vWibHCNGRnst+YGvL4R0/DWY4Vqli9pjpbTZ6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnAM7ysf; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48f68565fe0so771849137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719829163; x=1720433963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=loIUXWsvnq2yo7+EGoHAffb6gdvh8EF6LMqQfzim+RU=;
        b=HnAM7ysfFE7Dn+x6pm89LicAVB0msRBhtDvh3eKJI1zzw+Qjl4j12xYUJSQ99a9ATI
         aOaprwc2DxLgAON8jnSCYRUqga82jj9WLs32a9qlKOTeuo1Dt16yZDCLEshDShlvadw/
         2H27w+akRyOr28PFHJbs3Ifq3UP9kd1na1FIBDlkQyvqENKotmHzG78jtydYI3e6pefg
         OaazMcftJKk0+8IBSsKR/dSkDW0rhKztNUAWMcQEPQ0mTEmegio3okxNVT3n/UB9jgGp
         W8YsVLNqEeZ8r5X8QcZLkL+PXi4PSeHy2jSOtKunLF9aC04KvXMfcYEZzv9hwEanVT80
         R2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829163; x=1720433963;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loIUXWsvnq2yo7+EGoHAffb6gdvh8EF6LMqQfzim+RU=;
        b=swLnrGA+bEXpFvTIdYgkEr4Dbe2wS94AUZdRN9o+1i8YqLYgNTCrTn7uEJ4jyPS/Vv
         t6BkIQ3AeJyfjYzzxaNZ/tEaAJecUHsTWLZW+FgwWiygQBXcQ4YuTZcQ+lT56FBxzy1t
         X/ABBcw6yQAMlt29mM33XKGvI1kFgOZOuq7BLUc+H1QPKU7LVkWT+TVcqASwcHYJwCPT
         SyGIj+Hrx88pczOaB0r5OX7uXnCsUV9HE5V9W7H9BUwR66TrOEfCxuObhlWnL1C0q1o5
         wEt2nhBKgW7ibYR8nHYjB07S5ayDC0OHcdmUF16QI2uKN9zxXB8SEBh2q7iSF30rgeal
         +bGg==
X-Forwarded-Encrypted: i=1; AJvYcCWVrH23lcxUZf8v4cQwocvwtJwOqvGagpmfpFuaKPqnQQywbzTXqHoA8k8BbAmrOtek2QKg5H7U5n9KDZTVKPi0lg7VVS+i5Up6gPqzWg==
X-Gm-Message-State: AOJu0YyYjHQWR22eYM1GP6uiReoRHFcGFMR9kbHLiUvyEBheehZLMBsy
	06wHaMlmPzrFpKBWNEogPsQp//h8jrWAF+sQPlR8ZC3l3iyWaCWgIPKLjEfGsqcR/b8so6PEHem
	Kbcl6CZEuy7ljElOLNnGWAU2PKbmudvbYS8jKkw==
X-Google-Smtp-Source: AGHT+IHsCQzeHxHwgdBEVzHHr4zQVqrsCo7FWNtGkFgflR7Q+Sy7JIhUtzqPEJeINk1wTXKgxnHKA65it2kLKRVvFfE=
X-Received: by 2002:a05:6102:3a13:b0:48f:2afe:88f1 with SMTP id
 ada2fe7eead31-48faf0cf479mr7159638137.16.1719829163172; Mon, 01 Jul 2024
 03:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 15:49:12 +0530
Message-ID: <CA+G9fYsk85UOsa0ijXcYRvvZLXEMQKe4phWhND+0qSNP36N5Tw@mail.gmail.com>
Subject: fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
 different size
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The i386 build failures are noticed on Linux next-20240627 and next-20240628
tag. But the clang-18 builds pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on i386:

 - gcc-8-i386_defconfig
 - gcc-13-defconfig

Build log:
-------
fs/proc/task_mmu.c: In function 'do_procmap_query':
fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  598 |         if (karg.vma_name_size && copy_to_user((void __user
*)karg.vma_name_addr,
      |                                                ^
fs/proc/task_mmu.c:605:48: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  605 |         if (karg.build_id_size && copy_to_user((void __user
*)karg.build_id_addr,
      |                                                ^
cc1: all warnings being treated as errors

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch i386 --toolchain gcc-13
--kconfig defconfig

metadata:
----
 git_describe: next-20240628
 git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
 git_short_log: 1eb586a9782c ("Add linux-next specific files for 20240628")
 arch: i386
 toolchain: gcc-13

Links:
---
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iWYcW0sQJ6j62u46MNgQ3FagUd/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/log

--
Linaro LKFT
https://lkft.linaro.org

