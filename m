Return-Path: <linux-fsdevel+bounces-45131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E9A73291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A8C189BE65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0F14F9F4;
	Thu, 27 Mar 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7QQm62O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA244C9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079824; cv=none; b=j78jcyHQ7V+kn5NUxpz1Qdl64/I+xFXcZYrCiiyp78pglD7yvDr5faOuWNlMpkmdyXFwSdKT1ke8q5Zcx7KYp/ouAukaCNSguQka6ZUGQFkk1ri6PwhNC6ZE53rheoF/UC5yQTeJnUMyLB83TtXtJqSYqq0o9WOMztwX3O3n858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079824; c=relaxed/simple;
	bh=x0/E2M0F+EgLHnBAChfuUY4dPirGmTNiotD1PkORt9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmpIR8UIgV4WbpUEbIpLGLgl6BTAdGlJn2M+NfHa72ZAohbWOzxSJH0N6knc0/ep2xYEveckIIkFB56b68p8ejZeXWMa+oiwGsdp1aJETRW176rA7jacqgFZlbWs5ESwhJ+/CaKO2uJVGhPQ8caUX+qP04PMbK+RmEJgBPr6G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7QQm62O; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso363795241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743079822; x=1743684622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YxPf82X3yEknJZahIFwtaw08CtPbnq39I71FWEqVAf8=;
        b=F7QQm62OZHOUaeLPsRQHgemR1rBdyRwYLC/mzeib+x13U1Tb2asL6cwOBqmRZP3fD7
         tvQhPrhkzUSxf9Eij4gUGWkVEqKdqlZ9XWeu73FnEa9MAEu6PvBI2IPj8Ljc8kgQjl+K
         vVwjxC/ZBhVRayWt3slHX7er26mgZ8ilIWL3KnYAtt3g1HjZ3VQYSfYIyu3LhcJGSYQT
         IAftgDXu8sKVgCpBpQvatSFKcWCKgbzEcxuueE/KZtCV4dwdR0HSjwRVUxZglpUYYg6j
         mcAwmap5ttkX+T5POPhlgcHwzKHNnQO7RTW1BjUnPNr/TFFkMlqRd0sX0h9vbX2vt2WL
         8X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079822; x=1743684622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxPf82X3yEknJZahIFwtaw08CtPbnq39I71FWEqVAf8=;
        b=MaoLZM2spGroOTsYuz+E8pTQp2bntXBq/Qk6iCmEsdwe+9q0TSRZfRsh6qGsKogcNr
         hx6GsIfGb8nFkAypQmt8ZBGMLgVVnKwYRWT7Z7Kfb+uNBkWr/LYzmyLK6LVUX2HjP2nS
         6rj9692gjZU5pUwg8iwzhas/t9Tfw3fyogPRhqtjal++FZVlxUOy/ZONAeZBlkIR4nvD
         CeZSeisl8p0i9s1BxSrIo33vGAetUOBX2NUpfBe1UHLRo3pLar4f9YqIhQMD8JbNENpJ
         9V24pJYcsc8rDE+A/5LsE3oFJFy29U2amS5cHkZaWi1Kwa8R036K2yvxpEyViJk3JB6I
         SRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+DFJ0dyy3FqsuVYMnTpRr/Ga4Kb5ykSu3ZWd4y+vK9ZBTdAflIY1LzNPcuZRe8OiNzyHcE26aGCCjZDe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Srw78K5MvUovZsIG5Y20tiYyc9WEa2IHz0NodY/NleqCOGjt
	/TK9ORSb7RwOV0AWqqBHAy7dHz3lph7jzaTgi8sQ1aqm9QLaUav28PSjDppBrCfBCXLLysA3WQ4
	mCoLorwrdODzQB1nM5yZnDnhdraLmyFs3PfpxyA04rIcYuJNqp+s=
X-Gm-Gg: ASbGncsGaKSweXLivVVCcNLx++GykfkP3vkTV4RWrN0WqNk7K0IPaqbq3D3Ks4iVMmn
	jmrisR3dfllnG92LbjZ4KIwcaNpXOZ/I/J+tAkOmcdIq4jgO1zQCyAjLH9OOMa0dYupoYZ/32Ii
	FlRms4lbvdsPkudKbEFHMxptGhHT2BuFPHa7N41WZZ3qt1SvWFNcjhaV5W2+c=
X-Google-Smtp-Source: AGHT+IHJT4hKKSEUXlpmrmhxoV+NJpCfU27nTmRX+PSKGFNIOYp+YtuJN7H/mSdObFWYsi6xV1D2Xzz8lFMeeJw8D60=
X-Received: by 2002:a05:6102:1529:b0:4bb:b589:9d95 with SMTP id
 ada2fe7eead31-4c586ef2197mr3532762137.4.1743079821716; Thu, 27 Mar 2025
 05:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154349.272647840@linuxfoundation.org>
In-Reply-To: <20250326154349.272647840@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Mar 2025 18:20:10 +0530
X-Gm-Features: AQ5f1JqzxAAFsa6xfl6ahL538LTvEz_6T0WQuL-UCtRCOoqdpwdAR2e1PKOJHcs
Message-ID: <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Leah Rumancik <leah.rumancik@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm, arm64, mips, powerpc builds failed with gcc-13 and
clang the stable-rc 6.1.132-rc1 and 6.1.132-rc2.

First seen on the 6.1.132-rc1
 Good: v6.1.131
 Bad: Linux 6.1.132-rc1 and Linux 6.1.132-rc2

* arm, build
  - clang-20-davinci_all_defconfig
  - clang-nightly-davinci_all_defconfig
  - gcc-13-davinci_all_defconfig
  - gcc-8-davinci_all_defconfig

* arm64, build
  - gcc-12-lkftconfig-graviton4
  - gcc-12-lkftconfig-graviton4-kselftest-frag
  - gcc-12-lkftconfig-graviton4-no-kselftest-frag

* mips, build
  - gcc-12-malta_defconfig
  - gcc-8-malta_defconfig

* powerpc, build
  - clang-20-defconfig
  - clang-20-ppc64e_defconfig
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-defconfig
  - gcc-13-ppc64e_defconfig
  - gcc-13-ppc6xx_defconfig
  - gcc-8-defconfig
  - gcc-8-ppc64e_defconfig
  - gcc-8-ppc6xx_defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

Build regression: arm arm64 mips powerpc xfs_alloc.c 'mp' undeclared
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use
in this function); did you mean 'tp'?
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~


## Source
* Kernel version: 6.1.132-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51
* Git describe: v6.1.131-198-gf5ad54ef021f
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 \
    --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/config
debugkernel dtbs dtbs-legacy headers kernel kselftest modules
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig davinci_all_defconfig LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org

