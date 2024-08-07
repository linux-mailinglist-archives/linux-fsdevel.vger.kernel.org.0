Return-Path: <linux-fsdevel+bounces-25361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8694B30F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB61F230E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89B155337;
	Wed,  7 Aug 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgxVvvtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439D146A72
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069914; cv=none; b=ew7Y49GEsNIXTWY7nimyghv+BQPcVaRfMuxzIhuYmt2lls/8FxrdIEkWQDZfG32gy2L3ERHLIxTiaZuCtsP8o58nh61EFuy0ceK8ftty+4bcpY/oQGM0vl0wTqfrO8Tzk3ntpzy5cdlUtY8OqlN9Pnfe9ehPHvFNQaWxTe90FwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069914; c=relaxed/simple;
	bh=lt01zfKu7+RvwlQbSg6i9IaxHABXiXlAJBTgnDtOuJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZoXisWR6YJtHVlbTR4Wjhjq1/hYMs+1muLvS86QkMCc0JFt7uypdmMtqGpMHkXGQ59K7D6W3LdiR21x4rv8pjzsRhILQHsnwK6afvqQLcT5H7XQJZNyMxlno2XhRp6CSsmQuN5mviQNwhWguC3SNtS2MkQgu4+SrvcjVZcjpyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgxVvvtU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc611a0f8cso3772985ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069912; x=1723674712; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqn3LooEfKQSn1SPZrgXd7kK5ryU/WoLiCmXsEwtkWo=;
        b=vgxVvvtUH0GL2i4YA/K/6AaixhH9nFt+pWVkN+ef33SwutiHrBshkQcr7n5Zh1q6b5
         DtECo+GD9SprJCDLeJ2i/ADw0aX/mdTITg5B3bwIOSXdCyTqYo8h0qBj1fXrtNXvHnRL
         hXrVYZ8M3AXAZx6mSQuseQB8L96fKYi61WyPRShdzgUFp8LAytEbdXX2hL1FG14URqcT
         mcEapnhbw8Aq+1jydyd63OM1h9jM4FBQQxeoSWpoGbfWf4DFWyyrqUlCIOPh10o2L8fe
         77BlO48zY9KHPJ5JCZS/xxK+cCAfbTHgDFz5cUurltl6XiA3eQl0nyAWkNB0/6cg40i/
         f08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069912; x=1723674712;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqn3LooEfKQSn1SPZrgXd7kK5ryU/WoLiCmXsEwtkWo=;
        b=Ft9zmk9WMcKM5oCbfkh/2MDC6C3L0GC2HK0/JRgjh1lPkYSDqwzAloNzc+01oKWCqe
         J8GMaS6ypkWOtTSlp3hoPoqmVBYpPDozfkzHiUD0/dbPewqk9OrptxAfhDVtbeFCnp+z
         0StBbWjev0bZrW8J7RjRcH3tyLJezNqv23+zQj+s2ocFq0apy15L0LliyUVUXsOX5hYa
         IvuhfaoMuwkT9JOeWfjRiZnfdvZpEGNwWikS6cscAmRFeLg8TmBVuGaRPUxePS9v1f7W
         kUMNHwbAc4udBUeysKfl1By3DtCXyj4zqZMxsA8mMswx1k3T/lj5K9Hh1RhLkrLMpftX
         b0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVEvgplMtmSPQl6XPw+so9U9QwejoqW96P0WenvsLFRgoLvEbDY5H4kvEOMZ2Uj2QLQCWzRuoCXpUACjfjivkRFApAOwdpkdUgmzY1tA==
X-Gm-Message-State: AOJu0YxJdUo5ScWzlnRsohB7pXgQpOkGdX5VEUqqvXPE0yzyLvH1k5F0
	V9goJ3crNPO/Jw+9TEMnH5Fywja7iGEtWkd8mxGWvAbYbt0G8HsxjzFBD2iEG24=
X-Google-Smtp-Source: AGHT+IHHjhsk2z4q9vmLjR7LsBMy2oppwwN+j14R3XW5fxPpM7oxaFufcdUW3gDCZ50Rjxk+EmoCcA==
X-Received: by 2002:a17:902:d2cc:b0:1fd:6a00:582e with SMTP id d9443c01a7336-200952641bemr1402985ad.30.1723069911749;
        Wed, 07 Aug 2024 15:31:51 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917767fsm111712115ad.183.2024.08.07.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:31:51 -0700 (PDT)
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
Subject: Re: [PATCH v10 34/40] kselftest/arm64: Add very basic GCS test program
In-Reply-To: <20240801-arm64-gcs-v10-34-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:01 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-34-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:31:49 -0300
Message-ID: <87o764dkx6.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> This test program just covers the basic GCS ABI, covering aspects of the
> ABI as standalone features without attempting to integrate things.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/Makefile        |   2 +-
>  tools/testing/selftests/arm64/gcs/.gitignore  |   1 +
>  tools/testing/selftests/arm64/gcs/Makefile    |  18 ++
>  tools/testing/selftests/arm64/gcs/basic-gcs.c | 357 ++++++++++++++++++++++++++
>  tools/testing/selftests/arm64/gcs/gcs-util.h  |  90 +++++++
>  5 files changed, 467 insertions(+), 1 deletion(-)

The basic-gcs test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

