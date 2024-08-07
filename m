Return-Path: <linux-fsdevel+bounces-25363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0A94B31A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158152814AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CA1487CC;
	Wed,  7 Aug 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoagAPr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE412BF02
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070055; cv=none; b=EPFipjfKPosvlQ+dvsyoXrOIfrF0HLTql29czM0+yluF8PoNPdNeZzt440U8uVyTHA07NDLzqVDstbBMJceGaDAxFKRTvSXE4wMSg53p+G6Jb1DApboGeraqgRQwZez5w9FlqMOF7xYjnBRmcj5UnD8LN7GGbz6vxV1lSX0AhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070055; c=relaxed/simple;
	bh=Hnvwb4GsJ5xhBtc2iD024XC8qkygckvf+U3nq/Qf0EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYxttxji+79YkNbDCulFfbqWDt7XEFCjrvFBd0jPCxa78Xs3KXN+FPqwW0jB/dymB5mBTp29UPijkoOInVxwDyjNj2dFDijqyPjbiRbirsB/uw2GSL2iZPgwA3nG2nX998nsPy+rHmRhrqiwaBPbIIMXwVhoHL+v1332WF8u0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VoagAPr3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso291578a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723070054; x=1723674854; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfrHG1WH6erSaIaipwT8ciCPWYlneUqYmls1urpaYsI=;
        b=VoagAPr3LTpvMW/5oFp+Aq4x38SRbqHwYuvwty/A60pg7LqRAv80O2qA+NToFgyw2J
         8QxAGA+37onm6+2mr7idMTyRnUfC42r5TAPIs6PhipcMvz87sIFfdTnJIfmSCIkpXi8S
         w50Ehee+QA93nAcn7FuR52ryY0IQDgCWolKYAMQRyBLqFRfUoDBXDNvYxhssrOgLB9dw
         syAePxjF0c413lJPvPVrODmNw1R+wtsN94bLIf3u2OWCyWnP64NYyhxQiFXVHr1eZsu3
         3ag2MRZ3FQK9ilibwPGdfwbOYt1TbeWherfYSSWz1GRWX3A0kcww6HMBZpyRE4IHQzuN
         1C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723070054; x=1723674854;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfrHG1WH6erSaIaipwT8ciCPWYlneUqYmls1urpaYsI=;
        b=THYWibK8LMiIKXUNe2HVBap1HeNPu4wF0mgpc1uGbXHC/zw954eCcB7aKuEUOd2h0D
         +4izBWEOjWFMACXdRV7H5HWC3onzNdP3tNSW1f0H9C5cgHZvbqB8YxQjxmfRQ2lrceLu
         pMlZhZcBHhVhG0Wd80VsAvzd+eDsZgtaSxsbdQ+ccXmjwLKoy2EnVG0T2tlNa8H8y7In
         zaFuxlVKjxUjIFiGF+HlC0suyTpv+yokqOGWEmPgNNByXi4MSbEzN9gtKC5yn1zhlEc5
         MYPV0dALkV4rJPnlKst5vpMyvdMQGD1i03aVvaKeWWO8XwpsZTI2yGh9kcP62iyms7Jl
         eDOg==
X-Forwarded-Encrypted: i=1; AJvYcCUasuBGgSq1Zwb68XB7N5UuezciOw1cjegVb1HcuGBEz6pHJkV1/F4Tyu9vQkUOR4dLNYwuQSQT/OcVl6tUo5ZV6UCAm9WpSBj1LFHpwQ==
X-Gm-Message-State: AOJu0YzJcbLnLdGraWEgP4Z7lE/PutBxCh6JcPMsN2ygnAgF2O042cwx
	AVR47ObjCSHVFuMKS0MIH7AYQIxbljHJJRzUbYe+PjYyqJqMUKWZJxf9p0FPbI4=
X-Google-Smtp-Source: AGHT+IG39+No54Rw/miCMksXv5QcGuWzil+DCVtmW0Rz/pFwmk6IgrNbAr9fPsdspRzM1slcOMQVlg==
X-Received: by 2002:a05:6a20:c21:b0:1c2:912f:ca70 with SMTP id adf61e73a8af0-1c69966e0b6mr16020999637.42.1723070053844;
        Wed, 07 Aug 2024 15:34:13 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176eb6sm111615725ad.196.2024.08.07.15.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:34:13 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 36/40] kselftest/arm64: Add test coverage for GCS
 mode locking
In-Reply-To: <20240801-arm64-gcs-v10-36-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:03 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-36-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:34:11 -0300
Message-ID: <87frrgdkt8.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> Verify that we can lock individual GCS mode bits, that other modes
> aren't affected and as a side effect also that every combination of
> modes can be enabled.
>
> Normally the inability to reenable GCS after disabling it would be an
> issue with testing but fortunately the kselftest_harness runs each test
> within a fork()ed child.  This can be inconvenient for some kinds of
> testing but here it means that each test is in a separate thread and
> therefore won't be affected by other tests in the suite.
>
> Once we get toolchains with support for enabling GCS by default we will
> need to take care to not do that in the build system but there are no
> such toolchains yet so it is not yet an issue.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/gcs/.gitignore    |   1 +
>  tools/testing/selftests/arm64/gcs/Makefile      |   2 +-
>  tools/testing/selftests/arm64/gcs/gcs-locking.c | 200 ++++++++++++++++++++++++
>  3 files changed, 202 insertions(+), 1 deletion(-)

The gcs-locking test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

