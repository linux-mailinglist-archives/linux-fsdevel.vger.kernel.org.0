Return-Path: <linux-fsdevel+bounces-25364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073294B323
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7361F2375D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EF15530B;
	Wed,  7 Aug 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juMPo6WK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD400145B26
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070197; cv=none; b=RE7DcaWm4NFAc2xkiS+z/waMiDBUj/KKmnlKf5dYif/PWAa2OhiD4qkt7KbXB4fSssvJ6WHlBckt8nzRR8C4oCDyfAEwaN5g60kFZ2edzTeZMdO0DWIbBzZ7Q4e9UUhXqtvVsQOGlP2WYczkJHS6a8t6NwFAcZO/fRx2shy8sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070197; c=relaxed/simple;
	bh=a82BazRTsLV8O545SUtLHexI80RAcukz/terjjLKadM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7/8l5NHJ31D4B6YG2dFb/FPUZjapArr7/n/mm6TJFQucJIVrgVR5VRCbxW+mX0WOyTfSHfdo0+8cTajCi3GXqLLqa0SyK+DOtj7vGcekoDyL5p4/HgXOSbdR6mnHxQNsD7rrW0TZAOZMG42v/xCYDfXN6nEzm/CvbupVrVASo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=juMPo6WK; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093705c708so347265a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723070195; x=1723674995; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5xqVBE75uTakMohQNNM+Ob3mwTWILCE117tt64StnA=;
        b=juMPo6WK1oMZfx3SBHcJlSj3c0OAieioPg67K4fwY3TboNmdDxI6OxvWHaSwPXE0jH
         eK2kcYczUnXPkSp9r2nd3ZcPC0eO1UFirsKHaAQhfs4B3XsmiO2rgpN16/xRYst+zXch
         v1QZuNA2KHlX2wVjEfqlVlphsB12PFmbxgwSDRxJhxWO2YLxmhYaOUuRlWk7PcCjbk+y
         Fa1343O5HYV8WiUbUAj+4J+E3lqhYfnWQwuqjB8xYEROLCu+ASmt8BRrQ9DlieyXSFqw
         90DAPW35AVjyBWWyq9AGUFdftONiop8Zvy8vQgTvqIjRNXOYmRUtbEdFnGY13khRg5G+
         mnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723070195; x=1723674995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5xqVBE75uTakMohQNNM+Ob3mwTWILCE117tt64StnA=;
        b=WOWWWu1caR4pUCsM8N/eDIVQ3ht9CeypTk1jJZXBuFO7Bfj5IHhwwBczT3Sn7CCgzy
         zpskUEztdcdGiOmmi9s28TIYIVcWcTiK3u5dmTPq4dzgiKHS5zBT2IuhOgcIwKTG/brx
         Vmt90kviccxH52gyQLlcNv16/NmIOKbYjJ4Oh6GCyecdNxQ2K+25oEnrKL4hVQfUZdpr
         /RrV5h0OamRNTCwfrpUwutFDk/9lSzpKr/rLnGjcqoUVtdpic+CfPtlId0fM5nlV1KTE
         LTvLpHKG5AyVPo1XyAnCeujY2spWqsrhNInht2pBxSkQGXoTnNez2wHrx1qlXjQeZLIA
         KHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsBPx3KX3prw5uw1ftwCuMROyPZDv/KCAjJj/aPNWm+UsPnOgX1muKEI5FBu+wBYWRilXfuB7XHM5wLg5LXvpfmWzKsD3dVBiqQksSoQ==
X-Gm-Message-State: AOJu0YyzbS2jCCI6dNc+Z0gX7k3rMhgZkf9nhdnS5zv1vOcSlEr12Etk
	fZPFW5+xrM+qf2ve8SIpdxAXskR+iAGBxUgi7w2NSN9oOyoBsSm4poaNxQBa1aU=
X-Google-Smtp-Source: AGHT+IGTBDVQAm3GArH3otwegCgx4BHN1ZL2N8yxYA8F/kedHOZ4Afd+CPHaShh6RvNkbAtiESu5bQ==
X-Received: by 2002:a05:6358:70c1:b0:1aa:b860:f10e with SMTP id e5c5f4694b2df-1b15cf91432mr25702255d.15.1723070194758;
        Wed, 07 Aug 2024 15:36:34 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654be293sm7403332a12.91.2024.08.07.15.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:36:34 -0700 (PDT)
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
Subject: Re: [PATCH v10 37/40] kselftest/arm64: Add GCS signal tests
In-Reply-To: <20240801-arm64-gcs-v10-37-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:04 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-37-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:36:31 -0300
Message-ID: <87bk24dkpc.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> Do some testing of the signal handling for GCS, checking that a GCS
> frame has the expected information in it and that the expected signals
> are delivered with invalid operations.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/signal/.gitignore    |  1 +
>  .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
>  .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
>  .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
>  .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
>  5 files changed, 228 insertions(+)

The gcs_exception_fault, gcs_frame and gcs_write_fault tests pass on my
FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

