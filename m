Return-Path: <linux-fsdevel+bounces-23967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4F93709E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CC01F22751
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5199145356;
	Thu, 18 Jul 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk2Q67NW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F769D31
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341717; cv=none; b=bWrJv80MzDCVTUdyZuIAL3srPNaB/a025wD1Ic8WCM43uuyno6WDuHkDcDE2lY5FdXWOBMO6x6LIoIoyC1emzRpzPYG8yF42jlQToaNtQPSIoJKnsh+Ni4Tj/mCga7MQpOEbriZDbGFXdqkcT0UKKR23wE/S2uCRJpi16Ysez1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341717; c=relaxed/simple;
	bh=/dgDQ63gkEhY3dFzZwulJGUglg5Uq6j9k84TZuMsK6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bw52PZxiiZreyGAlv80DUK6XxTQcgDLj3Qd+9wRe8uGjlbVIND23LD9I4r5sUDxHfl1KaPHnnkXm6i/u3wSN3nY+HnHnhEaLmfAzWYtezJuI57G1qPcTb7dxTuCWIsUcYRsV1wxvhhgNO+9vBtfM+zaA17Dk8E+3YIivEznSukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yk2Q67NW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb1c69e936so9526885ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721341715; x=1721946515; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mAFp8cCYrsuMTkT1FWDyABYg4XKo158nqIj+Kj0+oyk=;
        b=yk2Q67NWa8+dTo4mtO8Hr+K0y59jhtjda+Etj0LK+A7/KWxNpCdi6KM5daPbWAT74Q
         alNN6uWfNHPUbIecqB1J6orraBztlI6k6/qrf8kxcciZ7zvUJLEBoZmVOVxitDawpNM0
         kFi5xSxUpcfBdrIVu0MR8s2/I6vBKV5LfRHmDtbDUue3UOg+3PvH3SfsOm14EwW0WFDL
         9DkQMOPqfEG5+kEht+pd9AJUclo8CjH0gxX81l3j4AzP3CJG06rS9wOESsPqYVW05wbW
         BWcy1W86HS3UJwJ81FNdysCSWK4ep8M3JPiAGFSA9cW36QnMqlfqu6sKleZPlOOJjGmk
         Qgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721341715; x=1721946515;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAFp8cCYrsuMTkT1FWDyABYg4XKo158nqIj+Kj0+oyk=;
        b=VjjQO/FXgot0aC8/B4W19MKdzPudXUQVMGHPxcohCB7pQnw6TsLKWvpPEzWYZmaz7e
         kZ3JYTdEuQO73lgDg/o6AC4ESh+4PaVPz5HJLHi4xKSOK3tdD5z8W0Llfwwyqgrn4hXc
         eimweafvq2TmRthmnUO++DGFtS3/LAw17qIRFBgEBfujsj0fmbdIfaZDjA1QvIuIB2lX
         K4sHKPKmRL7+tHHjGijmJ+1ZuyYlqyAO/qyaRcmSOl4vPyOGyhA1UITBdWHzLf93MzHi
         HqeB8EMHp28FTSseAHNgAFFB6a877EEn+4f6u7KvUDdoFaaTC02D486QO5//7d7rk/on
         XYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEfxLL8dDgm/KMcn8tf+pFLXC70ROWsKjkAcYEJhD2Q+7j5eiM1ZU1fXk276Lx8S51XDE1749AGbKp1pSQtmTaiYXg6/3bOjIqLfLO7A==
X-Gm-Message-State: AOJu0YzcB13wMsndoYacbC5JPlqTPrt//yPZxPpRy8/oxqr+PsNDmK9X
	h+7cDQzAFQX1mNK+Zw/Die4RyGbEca6jb8Fp3fohNwekZckKIoNs5CVnN3vBsOw=
X-Google-Smtp-Source: AGHT+IF+55vW6JaqSjwGQi3R1yuf8ZxKtUymaiTTvyr4EyfBefOjisnvw3P8CACe6QPfDEnW0zUgIw==
X-Received: by 2002:a17:902:f707:b0:1fb:37fa:fedb with SMTP id d9443c01a7336-1fc4e154856mr54520445ad.10.1721341714980;
        Thu, 18 Jul 2024 15:28:34 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:15c8:3512:f33c:2f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64b51aebsm849435ad.27.2024.07.18.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 15:28:34 -0700 (PDT)
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
Subject: Re: [PATCH v9 35/39] kselftest/arm64: Add a GCS test program built
 with the system libc
In-Reply-To: <a1ee93ab-2168-4228-a4e8-eab02c046bd3@sirena.org.uk> (Mark
	Brown's message of "Thu, 18 Jul 2024 17:16:39 +0100")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-35-0f634469b8f0@kernel.org>
	<87plray8we.fsf@linaro.org>
	<a1ee93ab-2168-4228-a4e8-eab02c046bd3@sirena.org.uk>
Date: Thu, 18 Jul 2024 19:28:32 -0300
Message-ID: <87ed7qxrlb.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> On Thu, Jul 18, 2024 at 01:14:41PM -0300, Thiago Jung Bauermann wrote:
>
>> In my FVP VM, this test gets a GCS SIGSEGV before running the first test:
>
> Do you have THP enabled?  That still doesn't work (I'm expecting it to
> be fixed with -rc1).

I did have it enabled. After turning it off in the kernel config, the
test does pass. But I see 30 lines of "INVALID GCS" in dmesg while
running it. Is it expected?

-- 
Thiago

