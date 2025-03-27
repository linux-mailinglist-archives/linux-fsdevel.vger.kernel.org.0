Return-Path: <linux-fsdevel+bounces-45180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEDA74179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 00:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61478189CCB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57F1E832B;
	Thu, 27 Mar 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4jZbGME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1611C4A0A;
	Thu, 27 Mar 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743117571; cv=none; b=GC/O2ul5W8vUbRYsWpmZSl6n/yy+CBaWJvE+z27iWtcS4k7MbmPaVwShW10S2gM5SGVfrCiwNTHIYuTmjstUnzsBMw2Am8Xcpmy++s1JxmGbPOJ8H6BYVrY0cI2qdZE/TXHWRjpyuxUMqrS1wxLM9dI/QJO6QNN6g6VcoMfFd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743117571; c=relaxed/simple;
	bh=JtHkof5Kn1s3OvzmD5FvCZbT7RpY4G+M3J77IZkSWJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Hn85tbHVWx44h39JO4IOj17/jQbq5yo6LyhAscny6uIeTJ3dkXt3eIxrC7LqYfgXPldPHr5mSgQ13hw5tCucZ06b2Z6CptW0aaACflCjKATnU7mDjqY5+hNo4ItrZ680apEurB5Pl1BhuvDb2I6COiCBhwJ/UzOr0E9Ur+8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4jZbGME; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e609cff9927so1178997276.3;
        Thu, 27 Mar 2025 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743117569; x=1743722369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMnF9vs8JB47IN/cDkEjD5+fBKENuY4T9JJxCznicyY=;
        b=L4jZbGMEITOymm16C+Z8c1uNRKNeJFqiRRwk2cP8sFnoz09h7D33CWSjEygrF+9z0h
         2ZYQHBv9YV0H1OeP2VIRfKNHNEJul3559tEPDLPHjB/vZPXFP49MnxknicjxASYyD6Nn
         gPedzanZsU94PQPswpdoqOLfqzAPY+E1d3MgJ7C94z6Of1ICGesAtE2XTuRaPTVlojwb
         8HVjRRlazMeKjBUa35GeWKpEEh3qh7b+Y/Uw5P8MFzjoEoIkOoRGrJtcArDFytx4fA2W
         ut85vjLZx/ldyz1HAM8Hxi6wtfoZm/n1Sx4jNniojDwoDaR8bhepar9nYKKtTNh/LpdF
         tPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743117569; x=1743722369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMnF9vs8JB47IN/cDkEjD5+fBKENuY4T9JJxCznicyY=;
        b=Tp0HkPERJ5uja6T2v+E/D2MssFHWZKCdagEEiZ2sgoRb5URpK1LcvGc7KHn3e9rFd1
         kceTWQ9X6nT7058se/48lPWPcY2/ekSJY+4XeHDTwPh0TJz6wFUqnPTZgBCMqknW4MK/
         HSqAUBhFrDVxsfAJKZl1CjKaaV+j2zYqAX95XmPlLtiLJjIexanw188E2dpZWq83iAc7
         zgCSP65qpcuy0J5eunmOFZinRWPTMSzPlxgoYk+X4ejvGE/g6WKaSHhIpdUhbfbulVMf
         tgccdSEe1EjEF1JyLc3m/Q+dZwQq4BcLoAzcSpWlRWUKWdoyL/Nky6/+/FZEk68In4KW
         M5eg==
X-Forwarded-Encrypted: i=1; AJvYcCUARRvJlVHUNIo9s7dQkD+1TFXAe4hzqU2/dUzxTHkfCD/fFfyp1uTy+WIWqu2499f+SQkVXWDvwoz6XCdh@vger.kernel.org, AJvYcCUeG6lEP7ZKYX6Yu35DI6+F6vXOmt1rXLqKNxb3EG/9oMLjD9kwcf4fcTM0GyPWCP471jvn7915V5EMCcsr@vger.kernel.org, AJvYcCXHr9C+ojLuthl2PwXgKPVJhJQm9PkV1ZCmeD2QdlRA565J5NWJXdgGY99z7AuyEY9PVk9stNeH@vger.kernel.org, AJvYcCXONnPjrl48rLVMA70nZ6uvTRCqaZCl6Y3xWzgoN14jp+SyRhl7nQQ+UDJTzcYMuWBOWCl7FjfCJktY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HNlmxPDF+btycOuTO57XhibkKnsxz02nPtHQdtMLD98POAzF
	D/aETSzoZvs6+4izgRTkNZ9I6ZeY7Oy8UfYKEEsaD128uDWKl7lz3luRMfYEhZCP5KCsLWbNRqu
	chq/KKG8fOTVibMQZXvIq6oo6QW4I8O3J
X-Gm-Gg: ASbGncvk1JnzuOu8Jn40n2r0v/Ni7WErpuv4w4Qc+nGLnudf+NDsksSqWhc2ixD1n/M
	TGpjkAh2qyxx77fz/GbaQx+PkcoZbxoY4ID17XaMDGSlXTVkIdxC7gMgVC1ncZoO9iLtHpW5yWL
	tBwGDjrf2qOBoeMKwp/ix9Hc/zuzASUVhPlNvA/EMTz/wXxx1QKLH+Rx0=
X-Google-Smtp-Source: AGHT+IFFzruC25MmRQ8O0m11e88aqMai4IgHeja7o6hpsDHutAEbLnqb6CJ+2QXVsTRPqdu8ITPVSGFdMHLnDsZUS7Q=
X-Received: by 2002:a05:6902:4a03:b0:e6b:769f:556b with SMTP id
 3f1490d57ef6-e6b769f5aa6mr107233276.35.1743117568538; Thu, 27 Mar 2025
 16:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154349.272647840@linuxfoundation.org> <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
 <CACzhbgQ=TU-C=MvU=fNRwZuFKBRgnrXzQZw15HVci_vT5w8O7Q@mail.gmail.com>
In-Reply-To: <CACzhbgQ=TU-C=MvU=fNRwZuFKBRgnrXzQZw15HVci_vT5w8O7Q@mail.gmail.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 27 Mar 2025 16:19:16 -0700
X-Gm-Features: AQ5f1Jp8lXbaNFjXv08hBRv1tfhk1348_npPOImkZqUQgUwZQdNGnYymj_B4y2o
Message-ID: <CACzhbgTQCuig6eqOJFshthQfT5-7cVkemY9VtO_vu4d+aTcU=Q@mail.gmail.com>
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

sent to stable:
https://lore.kernel.org/stable/20250327215925.3423507-1-leah.rumancik@gmail=
.com/


On Thu, Mar 27, 2025 at 10:04=E2=80=AFAM Leah Rumancik <leah.rumancik@gmail=
.com> wrote:
>
> This is fixed by
>
> https://lore.kernel.org/all/20250321010112.3386403-1-leah.rumancik@gmail.=
com/T/
>
> but I'm waiting on an ACK. Let me do some nagging :)
>
> - leah
>
>
>
> On Thu, Mar 27, 2025 at 5:50=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 26 Mar 2025 at 21:15, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.132 release.
> > > There are 197 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.1.132-rc2.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Regressions on arm, arm64, mips, powerpc builds failed with gcc-13 and
> > clang the stable-rc 6.1.132-rc1 and 6.1.132-rc2.
> >
> > First seen on the 6.1.132-rc1
> >  Good: v6.1.131
> >  Bad: Linux 6.1.132-rc1 and Linux 6.1.132-rc2
> >
> > * arm, build
> >   - clang-20-davinci_all_defconfig
> >   - clang-nightly-davinci_all_defconfig
> >   - gcc-13-davinci_all_defconfig
> >   - gcc-8-davinci_all_defconfig
> >
> > * arm64, build
> >   - gcc-12-lkftconfig-graviton4
> >   - gcc-12-lkftconfig-graviton4-kselftest-frag
> >   - gcc-12-lkftconfig-graviton4-no-kselftest-frag
> >
> > * mips, build
> >   - gcc-12-malta_defconfig
> >   - gcc-8-malta_defconfig
> >
> > * powerpc, build
> >   - clang-20-defconfig
> >   - clang-20-ppc64e_defconfig
> >   - clang-nightly-defconfig
> >   - clang-nightly-ppc64e_defconfig
> >   - gcc-13-defconfig
> >   - gcc-13-ppc64e_defconfig
> >   - gcc-13-ppc6xx_defconfig
> >   - gcc-8-defconfig
> >   - gcc-8-ppc64e_defconfig
> >   - gcc-8-ppc6xx_defconfig
> >
> > Regression Analysis:
> >  - New regression? yes
> >  - Reproducibility? Yes
> >
> > Build regression: arm arm64 mips powerpc xfs_alloc.c 'mp' undeclared
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build log
> > fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
> > fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use
> > in this function); did you mean 'tp'?
> >  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)=
))
> >       |                                                   ^~
> >
> >
> > ## Source
> > * Kernel version: 6.1.132-rc2
> > * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git
> > * Git sha: f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51
> > * Git describe: v6.1.131-198-gf5ad54ef021f
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6=
.1.131-198-gf5ad54ef021f/
> >
> > ## Build
> > * Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6=
.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc=
-12-lkftconfig-graviton4-kselftest-frag/log
> > * Build history:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6=
.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfi=
g-graviton4-kselftest-frag/history/
> > * Build details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6=
.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfi=
g-graviton4-kselftest-frag/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2u=
rSwNctsyhQzf1j7dvt6nHemP5/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j=
7dvt6nHemP5/config
> >
> > ## Steps to reproduce
> >  - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 \
> >     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2u=
rSwNctsyhQzf1j7dvt6nHemP5/config
> > debugkernel dtbs dtbs-legacy headers kernel kselftest modules
> >  - tuxmake --runtime podman --target-arch arm --toolchain clang-20
> > --kconfig davinci_all_defconfig LLVM=3D1 LLVM_IAS=3D1
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

