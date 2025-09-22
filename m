Return-Path: <linux-fsdevel+bounces-62420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB76B92875
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F491896372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC73191C9;
	Mon, 22 Sep 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejNO6fyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A722259A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564009; cv=none; b=KzV2+UcjumuR7uRYV7q10SYpBVtMtrlu74U+3eV/BsnsW+O+jk2Ga0JKlmNnqIL3laX+9y9mJGx5pOv7YCRx9mCcJrb6MKIipZUeY2vLyvBY+IowPMh1QlDrkm3Pwi/FPf5QWXYcuacsjZ+Rkm46TMsn+cNTwgFcIZMblNsb7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564009; c=relaxed/simple;
	bh=LyFQcvfyyUbzuum2T68G+X8Y3wIlSo94RVd3tQx/fGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ljscv89xT/7pGlpCV0BGgRVHf1TKU7omDDFHtXCzEGrVNkwuxueRqEOR0+25vlp2aQ/JFyBl1PLhQK6A836/nzPNK6ztCaz+rN1NJfvj3LZmikpx+AmFeZUNGcBIx3EyC7uGAQ4DoYJKOklrvFt00+wLhXpDe/XktA2Js7vQER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ejNO6fyM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-273a0aeed57so19972605ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758564007; x=1759168807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tEHA5BGFi0qZLtSrmyzVuEmtCHCJP0b4IMQl2NugYg=;
        b=ejNO6fyMG1TefMeW+Yk1y+DvbznEVcCymeueZji9FlK//DthB9ujzXgA+iPi1G4zdg
         prasP8NzIOUOuLryCki+rKXTfGP9rnPYSM9pDsDM8qunf+6pgj2+QW83unbHsXapYzO1
         CqV68znemYb75p5ZOzSlZgM/L/4BL0IR9AC54zD3i82fCN/OOOHIQy2amNLgsp7N4ipZ
         WLPoDVgBXTt3fP0PB+aENNdpCoADQa9GIjl3yrl1w2sj3jwHWRoMU94jYRu3yZ0DXa1D
         brARYu2ZumvGb7WG42R8VF1UufuaUxnaz7UGJl49fFR/Na/pgXHCpP6Y7qmvASz49Eb5
         mt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564007; x=1759168807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tEHA5BGFi0qZLtSrmyzVuEmtCHCJP0b4IMQl2NugYg=;
        b=mUgpe0luJTXgXDG8orG8hBIfnThfN4dAIY5aqIpEhU0xXkYkrxKpVtaFhd9qxvUWiI
         ANcBzawVtjiqbdrT6gdMqnSp28KA5mI4gJUd9+xurAZwm1Aey/xSlcsznlGPIOtrCtPb
         FkXuwwqGluJm8X7cietaG0MhobA/8/y39MxBANgglYSGYzj9b2dl1fbw2ucihTGxwb+M
         iSfcpayuE7VaeIAtezdz70fg2jv0Zkuri9N3IXkOZMtWt+yf/J/Oiwi08/FK7vySRaaS
         PGCuI9PLk+I4eodG8yu2AXJBMiVdH63LmbRebNXEELjcABoAxRAqFp2llrpZ4NTh34B/
         fCZg==
X-Forwarded-Encrypted: i=1; AJvYcCXGT774iiaf+RarMd32QzhRV0MsgYcM/aiafSgeIE3GoUg3XzuO4TyKw6heQB9tTEmdiney/eRxfniHD3T+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1zQ7n/pWkdwaTsaUPjOl8i587IJVr7EtshC6Q/0oCrmcwZu+
	qqd1G5ztjNnEg4looZin8GLiC7y81GKMrF01lHcKYLLwUxoVGq/yt4TrUn2r7FS6/GDGnlywus0
	mhPZ3fBUXRnE4LzomqLZ0jZ1ol7guddt1RZV0lcLmLw==
X-Gm-Gg: ASbGncvhzxENKQzC91fJmqdfaNn/MV18swX4o/bEE+ZjnTfOh5JtUQhijrOiXfZR0xR
	xLFZeTRGXXrHNyhLivvSAaicOpBkkaHlSiXqj8QksVQJHksPvyLRk1Lxgcq+U8DjGFDQi1xQ6UC
	rr7zy1XKo3QI2maUsYSvVns8wwYN8s3LWIezf6KDkI6B7B/FVwHX2doaSHKwSOhUGDqfwGt97+B
	4oRaJRxzK1GPx36oPd0o7cv86SqNejs0BY7Vjs1
X-Google-Smtp-Source: AGHT+IHnq0rLb8m5TMIAGXGLN0gHFwtTPEoJOMo0Qxa07UPXisa8PfZthBdHiar633sbMLp+TiDunSqrb9HsyhZzMag=
X-Received: by 2002:a17:903:98d:b0:272:a227:245b with SMTP id
 d9443c01a7336-272a2274fc9mr102985765ad.17.1758564006785; Mon, 22 Sep 2025
 11:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 22 Sep 2025 23:29:53 +0530
X-Gm-Features: AS18NWDZwi1AO6kqN91ksL9x8G8Q2hcf5hfKdURyXPsi-NfZZp3RQHelXSAMyc8
Message-ID: <CA+G9fYvq732po6A=X=1Bm_zLZMAK50y+8sEToWVm38uQfOke1Q@mail.gmail.com>
Subject: next-20250922: arm riscv32 flexfilelayout.c:685:2: error:
 incompatible pointer types passing 'u32 *'
To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Jonathan Curley <jcurley@purestorage.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm and riscv32 builds failed on the Linux next-20250922 tag build due
to following build warnings / errors with clang toolchain.

First seen on next-20250922
Good: next-20250919
Bad: next-20250922

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250922: arm riscv32 flexfilelayout.c:685:2:
error: incompatible pointer types passing 'u32 *'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error

fs/nfs/flexfilelayout/flexfilelayout.c:685:2: error: incompatible
pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of
type 'uint64_t *' (aka 'unsigned long long *')
[-Wincompatible-pointer-types]
  685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/div64.h:199:22: note: expanded from macro 'do_div'
  199 |                 __rem = __div64_32(&(n), __base);       \
      |                                    ^~~~
arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
   24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
      |                                             ^


## Source
* Kernel version: 6.17.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250922
* Git commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
* Architectures: arm riscv32
* Toolchains: Debian clang version 20.1.8
* Kconfigs: lkftconfigs

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29967175/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250922/log-parser-build-clang/clang-compiler-fs_nfs_flexfilelayout_flexfilelayout_c-error-incompatible-pointer-types-passing-u-aka-unsigned-int-to-parameter-of-type-uint_t-aka-unsigned-long-long/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs/config

--
Linaro LKFT

