Return-Path: <linux-fsdevel+bounces-45152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0FCA737AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73EA17654B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206771AD3E0;
	Thu, 27 Mar 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxiKJVCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212A1DFF8;
	Thu, 27 Mar 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095106; cv=none; b=l14jVdW0OxdiQlSBDEXwkhY28lRAUC2UI1J+zgxYnfFJgrh33EuFjMiFXsWf4BS7agw87w3y87UJsOiPzomuHkwXEG9pomutTcyBTi8+0ZJT5RcimINOi7xe+ZaUir36J6J2GSN8nZl7/fCo87HYxJyi0pNMYbQEGEIGYnSBGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095106; c=relaxed/simple;
	bh=UCukrpff5csPN5PME//Bu0ltX0l7g8zKWFio8g/DdbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTX9/1VfD6phQoHhQx+yM4No9svbpYq3iZDKD26BHRSTZrSRU3dhB44ldAQNGyyGD9rTsEtyDlNaWeEA41JVFPjfV4TK4TJ7YEMjFo7t3050LULM+IFi7gznJ6dPgwiyfk9R81Znk1sqMAjlTYZfGFpafXLrNGIIxXKvDz0k3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxiKJVCT; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so1068808276.0;
        Thu, 27 Mar 2025 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743095104; x=1743699904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIMP4nmwgubN4Pys5aTU2WlwnqqvwCpJ2MLL4ep//RA=;
        b=YxiKJVCTbmMWGGZuNMlQEqbWHb9FNVxRXKeFy5ubU7oTK9uJwrlPNj9NSmmF+kO3VZ
         JK7JCFKiZ9+zIWTi3FfHGwzKSd2Mw++laRUzHd1tlI6hSEYncn7/q3U0cyyAYaqAY9lm
         UlIug5GZgAD9CILLlqNk4L73TYPTlYUGWghAw5wRR0UcPBj0oz4EGUyphdlaMUP4MxKc
         OvAXUn/v5zKMl2DwTWFvBdqDXJEH+v/p0po0fTGfCI+5DLOYfm3oFiPGn60qjVjXl7qd
         muBGXzQLhVMN8Zu29rWTtwqOOKz3PD2W/3GSuGbcWP91x2xDMxIhM2L2AoYYrFK8LtNq
         L2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743095104; x=1743699904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIMP4nmwgubN4Pys5aTU2WlwnqqvwCpJ2MLL4ep//RA=;
        b=MtUirJQH/p2iGyVu9F0RM44rnAepzX8pQYXdfsoNAev2N+ibizOiuYmItHN1jB7DT9
         /9iUxj2mXzBSLA2lwfek/mHNBHt9OoIcPWG9DOZzVPgLydyDEJ1wMIHbda4FhyK+p1qA
         xllOuXr+HawBBAIxMg8XHxoleizo1wqJ9At63rmYzV4F/SKuz9FzMD/8jANK9d/2X0xo
         fqwfth5lWPDBBOkFTrkpMpq9iCUI1stc6DzUVwRLJ+1PFOhLL0ayvznNikh/Rpz6eyPT
         8Rz8EJ6YM/ZndeYMmv2xQCy0Hb6eC48Sy+h01gZlCgAxUcRviXX3DREC/qZcyrBXbZxr
         d4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVGm8hDhbAt84eVVTi/gyU62fpLti0BlTYd2oFmvkZywUbm6KfJKRKBZ5AHzgWm5jO/asLhg5yGAnSY@vger.kernel.org, AJvYcCW+4QbNGNwXTL0GbOBJyYxHUiGv+eDGnrCQ3WDf2p/nvTEfVn/lOl+c8OvXSBlW8/5UwXc0yaOb@vger.kernel.org, AJvYcCWR5GA3ICUYUDVJ90RjwCTuMQY+QBoi8fWn0MPiGi421ZiHkO7JU4Rv6C3oPwC3wshuQGj1UnT0uPxaZmfd@vger.kernel.org, AJvYcCXZ0+NG9s5cK5kp7d/U6VhAWJGEIZosW0QlRVwpf2zfY8vPFfv/XD+SH0/KjpwHv1Ic1Jye22LzWBm6m6xs@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjIwoYcvzK5dvIpcOa/ra2//VbPW/nNVLsQz1CeXL2LLodhuH
	6ojqECDKJ4BIX2r8E4oOAaJwmgYZuBl0vZ46d87TZYwoWR23rHTibBM8wwt+tZBN0stF4ZoLX3c
	wF4TOQpNYIQWMTmvWXUAwZV5/Or4=
X-Gm-Gg: ASbGncvIEukiOXZXhF/tUnv01k/iqM17MzL6Op4rnrqx4vaeejgUYg/HhvuU4/IdW+f
	5kAGbPYIbueV+gPOFIk3Yzua/zZgXhKneZk5g/n0+uN6GE24+V3wF+7NqyzKE+qwKAQxyQK/TZU
	x+H5N/cp9xxmBri/HomCmkqBXvGRXuqIvteUScz4p11i4Yo0eXaF3PAMI=
X-Google-Smtp-Source: AGHT+IE0V4W9RPbFnppqS3nJN9J9jxtEhxV4mELuux5c5aERSjVw4aOfjObJ5DON3dZ9u7fr2lGONyc2RPHgBUOPdqI=
X-Received: by 2002:a05:6902:478b:b0:e58:aa00:ffd5 with SMTP id
 3f1490d57ef6-e69435eb3d5mr5861203276.4.1743095103548; Thu, 27 Mar 2025
 10:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154349.272647840@linuxfoundation.org> <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
In-Reply-To: <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 27 Mar 2025 10:04:52 -0700
X-Gm-Features: AQ5f1JoUWc8i3RgAxN3mjRbk-tD1j9a8iUSQkbDB7BjyLErxq3tg2jL0zFBfxIE
Message-ID: <CACzhbgQ=TU-C=MvU=fNRwZuFKBRgnrXzQZw15HVci_vT5w8O7Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is fixed by

https://lore.kernel.org/all/20250321010112.3386403-1-leah.rumancik@gmail.co=
m/T/

but I'm waiting on an ACK. Let me do some nagging :)

- leah



On Thu, Mar 27, 2025 at 5:50=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Wed, 26 Mar 2025 at 21:15, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.132 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.132-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regressions on arm, arm64, mips, powerpc builds failed with gcc-13 and
> clang the stable-rc 6.1.132-rc1 and 6.1.132-rc2.
>
> First seen on the 6.1.132-rc1
>  Good: v6.1.131
>  Bad: Linux 6.1.132-rc1 and Linux 6.1.132-rc2
>
> * arm, build
>   - clang-20-davinci_all_defconfig
>   - clang-nightly-davinci_all_defconfig
>   - gcc-13-davinci_all_defconfig
>   - gcc-8-davinci_all_defconfig
>
> * arm64, build
>   - gcc-12-lkftconfig-graviton4
>   - gcc-12-lkftconfig-graviton4-kselftest-frag
>   - gcc-12-lkftconfig-graviton4-no-kselftest-frag
>
> * mips, build
>   - gcc-12-malta_defconfig
>   - gcc-8-malta_defconfig
>
> * powerpc, build
>   - clang-20-defconfig
>   - clang-20-ppc64e_defconfig
>   - clang-nightly-defconfig
>   - clang-nightly-ppc64e_defconfig
>   - gcc-13-defconfig
>   - gcc-13-ppc64e_defconfig
>   - gcc-13-ppc6xx_defconfig
>   - gcc-8-defconfig
>   - gcc-8-ppc64e_defconfig
>   - gcc-8-ppc6xx_defconfig
>
> Regression Analysis:
>  - New regression? yes
>  - Reproducibility? Yes
>
> Build regression: arm arm64 mips powerpc xfs_alloc.c 'mp' undeclared
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build log
> fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
> fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use
> in this function); did you mean 'tp'?
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |                                                   ^~
>
>
> ## Source
> * Kernel version: 6.1.132-rc2
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git
> * Git sha: f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51
> * Git describe: v6.1.131-198-gf5ad54ef021f
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1=
.131-198-gf5ad54ef021f/
>
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1=
.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-1=
2-lkftconfig-graviton4-kselftest-frag/log
> * Build history:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1=
.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-=
graviton4-kselftest-frag/history/
> * Build details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1=
.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-=
graviton4-kselftest-frag/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2urS=
wNctsyhQzf1j7dvt6nHemP5/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7d=
vt6nHemP5/config
>
> ## Steps to reproduce
>  - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 \
>     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2urS=
wNctsyhQzf1j7dvt6nHemP5/config
> debugkernel dtbs dtbs-legacy headers kernel kselftest modules
>  - tuxmake --runtime podman --target-arch arm --toolchain clang-20
> --kconfig davinci_all_defconfig LLVM=3D1 LLVM_IAS=3D1
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org

