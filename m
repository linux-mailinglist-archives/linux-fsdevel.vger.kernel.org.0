Return-Path: <linux-fsdevel+bounces-25360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2702F94B301
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B57283528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649115534E;
	Wed,  7 Aug 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cE0xkHI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E153808
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069608; cv=none; b=IBqm8mjZwZ1OEPKrndiSwXOhFk7W7tw9qAWW53QiRBTjfFF1UISVLdm7ejQCuoz22gCz4pS3djFjCFthf9u3MmAoK/esQ/ILfyLGSnxVuQluOglfuiXQ9zacHaqmjM1jK+WaeCCRuktzjgH2smXEi2C0fSeKo+S7HoPzeBf16/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069608; c=relaxed/simple;
	bh=32biW44HjRkMPGPPp6hzCLrqIC8l+yMka3jm4zZkurk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=heVRM+Q264YqErvcfoQfOnHOjakQZDhaXiVxtad/VOOHjRJXYf/Xe7jr2hyLmwUoqImPmYDcofnBn3/LRcdo/2649EyxO0WFqMgMI1GsnmelaaGlrEc9bJxeZDwn/z2USAJjIjU/UHccdNsK7s+nM2q8UOgTOmG1ogrsPldVl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cE0xkHI+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso326861a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069606; x=1723674406; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBIy/YIYmaABmQA3j9o1k99kZxl3FitdDB149roFRGk=;
        b=cE0xkHI+/npPWDdkm6Q6kWCcDYeLq5vNnDL4TP0x2OUlksSKfl/u0ozTCqB1oxPfPY
         NM1/ifGqgY6sQBWE8tkodH3bYsFw4dT+69wz0OIqmaTyMk9/0dmdBw5PjdY2aV3ui6He
         on86miM5Br1e9zyA31+lND+6TDkcjaltWzpchuNGmPd/xy6X3UtRZCIQiD9mMCWvd+0h
         RpsJoKv4UyBR3Xd44s9eILxiAjByUwDzqi+gA2G/cBzbUAqclyRq8gBwFNJAjk2qATni
         cM/hFdisY8wNTf8IZYPx3V2buK36CnrwvfnQRpP93UBSh4Kxc3XzKjNIh+EfeS4iAD6A
         v+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069606; x=1723674406;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBIy/YIYmaABmQA3j9o1k99kZxl3FitdDB149roFRGk=;
        b=oDsMbBQ8QeIGJwwEop6oiMlWXp/ThRUDyvlioAx3MAexeZHq8KCMOwFx7bvMpYk0wU
         UvQPMcIaPafw4s4E3zMJm5XpyxO+FPHBySw2gjYKcdnfIw188deMgHT2EKPcFtZJLVSj
         Q7hJtYm0tkFOxhl+ciUTQ/sMRpq7DDuPMrHL0qBZhWA4RJKWW6wK4J1X+S/t4UgsuVUn
         5LGEfcVtn7swNQ6mL8CaGf//f7X92HhPDYayPFig8qd6jjM1hEXjT+OJGt6nI2PwG8T9
         05Y6JDLRIc80eU6O4klc6nqYuxBrnyZVO4WoRQkbhgDLtHASp3/DxX5gMqLPgaN0HJgZ
         Lflg==
X-Forwarded-Encrypted: i=1; AJvYcCWh+6fcF68d+lZIwK7VUHkAcCjq1bVi4puXj4rp3iRxmx5T4LM27XVdlQIn5c2qaQQDArtd/ZGTU6PEAPs0Rx8LRU1R+2mp4xBXn2tfOw==
X-Gm-Message-State: AOJu0Yx9Fr+FljtOI/XPCO3e63mZDOtcWa5+qlLXQFkhhSkPAv1IwWwY
	RKakJFk3P0abvZPUSC085gKgNIUA/gjOqcOs6gWSCVuw3eg6bona7359rIYeLCU=
X-Google-Smtp-Source: AGHT+IGd6zBFgLdZrc5fpXn4Fk0DlJIehtL2v1U5+1wFJBUpqiMspCMgOYDP5uaNavgy/IJn72zPoA==
X-Received: by 2002:a17:90b:2350:b0:2c9:7aa6:e15d with SMTP id 98e67ed59e1d1-2d1c33d4a01mr27917a91.20.1723069605605;
        Wed, 07 Aug 2024 15:26:45 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b59ff2sm2100472a91.49.2024.08.07.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:26:45 -0700 (PDT)
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
Subject: Re: [PATCH v10 29/40] selftests/clone3: Enable arm64 shadow stack
 testing
In-Reply-To: <20240801-arm64-gcs-v10-29-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:06:56 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-29-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:26:42 -0300
Message-ID: <87sevgdl5p.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> In order to test shadow stack support in clone3() the clone3() selftests
> need to have a fully inline clone3() call, provide one for arm64.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/clone3/clone3_selftests.h | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

The clone3 test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

