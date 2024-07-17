Return-Path: <linux-fsdevel+bounces-23796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA195933545
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 04:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156241C21225
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35D566A;
	Wed, 17 Jul 2024 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtNEV0IK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1824685
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181910; cv=none; b=HRJYxWFSpwSynb+DLdW5f5BuMdIINHrK7otSFXlxTayWe5Kupk2eBMvDi6ZeGntlGBvH6/5U/b+XGuY9jXaTrk8GE5kCUXFK05Vl+MU+Lek87MMOUOmhMIhLvvgsxvv6wqCcf291DdnVAKAVBHoZBkzo0uIEw/rwCX4yTtUEcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181910; c=relaxed/simple;
	bh=2aijUZqRvbSMAZJItNF8/iGr6po/mjEBfQUPAwaBiSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vf6ElFuae0vRNzuL8TK16eNk+A7dQu6mxVSF0tXdSadZSi4YoBFgF4kMXwNjFoQyjyWjzTxWG/gvUOPCO3daZNPLUk7bdU4yN4cK9RNp6txy/tTrSnwX/dUZ8hzwCnyC1MPTcPe79ApWxAymj9f6k7Tz0XpURMClbjEaVwGNbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtNEV0IK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4fcbb131so296815ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721181908; x=1721786708; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8QRegxtd6+FgIkF6diGK9DWIR0YDnVslVz04u7ogUM=;
        b=AtNEV0IKLNnfPx69+ffB+qmfk5Hu4GcwLj2b+r0/qr2Ivu1egHGr6BE7n3SPIleqT5
         /Qo8y0qzPWNZJqMkhmPrVidF2ECqHCv+KVZXNnzJ6x3OsrWyKQ9hP8ys5BbiEFjbrVFi
         xQzr4x+4XhE1STulSctGkDaM19KD57Fl8SoCgnySkijfy7+AZWISQYrcTykQI4Si6Bh9
         CErAAFQBH8EuBe7KZqSqUsADk4gTW/Krp/G/+67K1wfUbZVFVL4zV5WtuXMR6rwYvUca
         TtXI6GMJ6oyasb5HP6ETXN2BVsYIjgUgnxrzgrRS+z/yVOJvIrVSJB1tjgKRatQcUHYg
         0PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181908; x=1721786708;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8QRegxtd6+FgIkF6diGK9DWIR0YDnVslVz04u7ogUM=;
        b=sptU9xv16GEDrNfCOFuBWN1Do6BZi9e/nktUFGOjrGWlYC+t//pBVyx6u8lCXbTI+m
         XweAQRcj0kLjKXjz1j6cU43kOIEcIrtIQ7SfgMBFresk9DCcZHdSjeZOLGhQkb0quhej
         IzFtsBUCyteC/wEhKcXJF1itDPwx0XG5M+xOdkmu+Nawwkter+Vmj9Ypez+36z9//67V
         ec0DYWYUz8jdqX9NaOk7X34UL2822PsogawgeXoIZBzApW9NcjfULw3z9aBKusXOJ0Dh
         Kk07KUh0Usy1McXY7Z5aQ/m9PEIFlt2l9nouy+Gf/Ft9ujIT0Qvq3yBYWmMPE78RJ/ST
         SlKg==
X-Forwarded-Encrypted: i=1; AJvYcCUMKBr4+g8/N6KrdFn8i067PhUWngafHFApUvq5kLTu45UV2p58PMfXOvyy2QqdsVHBbvA+tHwJ4wlqLif0jA57tzZQKhzZtn/3xyHebw==
X-Gm-Message-State: AOJu0Yyz9eNm7cFQYb1esL5dt/prOdW1UNN8sOAD78kK2ksJdxIrPqGS
	dInE0jiUukrZlnxCad5sNDQRWjq+CTvRwdHYjN429z/gQugVFnFiFYdFkwkIz0I=
X-Google-Smtp-Source: AGHT+IE2KzNPcTth+gMo267NV2Jd+oHot7f6l6m3xb5YAhTJAAFsLZacsEiGAChpR0B8dRp+Zw50zg==
X-Received: by 2002:a05:6a21:710a:b0:1c2:8e3f:a49 with SMTP id adf61e73a8af0-1c3fdcc006fmr450858637.3.1721181907982;
        Tue, 16 Jul 2024 19:05:07 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:4ae3:bddc:48f7:36a0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedbf733esm7067534a91.20.2024.07.16.19.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:05:07 -0700 (PDT)
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
Subject: Re: [PATCH v9 20/39] arm64/gcs: Ensure that new threads have a GCS
In-Reply-To: <20240625-arm64-gcs-v9-20-0f634469b8f0@kernel.org> (Mark Brown's
	message of "Tue, 25 Jun 2024 15:57:48 +0100")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-20-0f634469b8f0@kernel.org>
Date: Tue, 16 Jul 2024 23:05:04 -0300
Message-ID: <87bk2wu627.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index b0a67efc522b..4a3ce8e3bdfb 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -8,6 +8,139 @@
>  #include <asm/cpufeature.h>
>  #include <asm/page.h>
>  
> +static unsigned long alloc_gcs(unsigned long addr, unsigned long size,
> +			       unsigned long token_offset, bool set_res_tok)

The token_offset and set_res_tok arguments aren't used in this function,
so they can be removed.

> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long mapped_addr, unused;
> +
> +	if (addr)
> +		flags |= MAP_FIXED_NOREPLACE;
> +
> +	mmap_write_lock(mm);
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ | PROT_WRITE, flags,
> +			      VM_SHADOW_STACK, 0, &unused, NULL);
> +	mmap_write_unlock(mm);
> +
> +	return mapped_addr;
> +}
> +
> +static unsigned long gcs_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);
> +
> +	/* Allocate RLIMIT_STACK/2 with limits of PAGE_SIZE..2G */
> +	size = PAGE_ALIGN(min_t(unsigned long long,
> +				rlimit(RLIMIT_STACK) / 2, SZ_2G));
> +	return max(PAGE_SIZE, size);
> +}
> +
> +static bool gcs_consume_token(struct mm_struct *mm, unsigned long user_addr)
> +{
> +	u64 expected = GCS_CAP(user_addr);
> +	u64 val;
> +	int ret;
> +
> +	/* This should really be an atomic cpmxchg.  It is not. */

s/cpmxchg/cmpxchg/

The same typo is also in arch/x86/kernel/shstk.c, from the "fork:
Support shadow stacks in clone3()" patch series.

> +	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
> +			       FOLL_FORCE);
> +	if (ret != sizeof(val))
> +		return false;
> +
> +	if (val != expected)
> +		return false;
> +
> +	val = 0;
> +	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
> +			       FOLL_FORCE | FOLL_WRITE);
> +	if (ret != sizeof(val))
> +		return false;
> +
> +	return true;
> +}

-- 
Thiago

