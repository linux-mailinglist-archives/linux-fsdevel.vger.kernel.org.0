Return-Path: <linux-fsdevel+bounces-25359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDD94B2FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3601628396C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81D1553A2;
	Wed,  7 Aug 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owfKrhbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3A14EC47
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069363; cv=none; b=sfc8Dran1nfq7TLZ9/tt+gLYkDyVGjy5sccxs5xXiEV1HOKrG/8PzXeu5kdYSk+FRhk5rmbOYgMjK7X5jTu23Eta0qvWL5XTQChZTVFVI2O2JbxAUe0HYsu0cOrpKn38zvYUF4YWwijCvPOBbgXUhDHRHh4tflz+3s7gMkBlOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069363; c=relaxed/simple;
	bh=3btizCSSAKzA1J+IVvS5w27hk1nP/wRY5h7VZDI2y8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DCjsz3eoAOURzpxlbYw1Mt2w3Wzi+akRHQTyhD0Ep8KV8YC3G6tSNjDFkYdhrEYADp6k29HqrecJ+BgYm8qnjC7EQgDlq1TAJrsXeIHj4k7fnVTX9MIl6sSc905uhAuf+BWaKBrRSPi9MAKe8PBGxozW8MG7YqQccZJKqbMeCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owfKrhbk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso359399b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069360; x=1723674160; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZVO8jPYcIWWyL3ex1mes3d5ZlFCIJ9T4CxX0DBumqo=;
        b=owfKrhbky9m4wOA4iJYhNPOT8hpdnh0vXsYiWFMNRqec7cuddz13AdKo+iK3CFaX7x
         O4fSycWbVugnKBX3A/n7SVdDKLh3/F6LFroNUYHBByUcEIb/oAKgj1Ebv2iFg1zoVd+b
         DcBxRvX8P1g30qq/CZ7P/ljAR9LlOO0diMeR1Xg6QJXwS8bwpbkTTjGg/UBu7/udjD/u
         TrS3ZrYerB1D02O7m/Wynl0Z1QKqDBDri8ZgBjMljikUxr3VVABWl7CWbknJnqMSXi+7
         Ua6FyGUDb+F4bRajQ4G5Kqe4jGv6eNwIEiCiOYZFbyir3xySUYpaUZlaLB3eJHD35X8W
         /NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069360; x=1723674160;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZVO8jPYcIWWyL3ex1mes3d5ZlFCIJ9T4CxX0DBumqo=;
        b=w4T9nAuF29lthCnP3NS6KfbxdEqmjsRUeTqrpr2omRop1u7k20eeWVNRtfiDNJBGil
         ZYqJ1jMmv4FGyE6ByO9ISh4+8NrqV+vXrcom9ymcLjb1BqWfWc1RQwJvxE8v5lU1n771
         GnjjS7MGAL7VcUinlc2C8tz7xc1PQNrW9C3Cd5ndDIBSrM9aMRgh67xHXzZjkXzxIuyc
         23SzLbYBrDFIJT5VSK+yrJX0te1j5Ot5bfbYm5lk9RxGmX8KWLX3Rj7dACMcwBYXD1z6
         1ksy2y8C3wbomvq3/XLZiMnnBf96nV5KxC2Ip43Vhue2TQLVflvO57YqgOuO5dzTgThc
         yF6g==
X-Forwarded-Encrypted: i=1; AJvYcCVk+PLlDLUPdVhvSlOXqzbXSmKOgT69Q7jMAOAmvdqPLEqh6Iy1IrIWPOyWIMikcl/+ejdotTyDXknAaJxfiIcwCHdVLogBrsxVm9Wd4A==
X-Gm-Message-State: AOJu0Yze8mq+Q5xTQS0ttULYAGylUe8wjYolcomG+55oTBm2g+kQhS3k
	wBOSOsei8eHi9RKq8aXhsQzhCxLIjWE0MLDiDEbkfCOhT+2Xo2BIKiZyGlFh6Ys=
X-Google-Smtp-Source: AGHT+IH2Cc0g0B6ra70L5cg48YZJx7srHh+PqfLxpX9PDwnG8XSpUfpqxIf7dyUyWUuyhSQCs84ohw==
X-Received: by 2002:a05:6a00:1302:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-710cad5a30emr137306b3a.8.1723069360049;
        Wed, 07 Aug 2024 15:22:40 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb228d37sm5911b3a.46.2024.08.07.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:22:39 -0700 (PDT)
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
Subject: Re: [PATCH v10 27/40] kselftest/arm64: Verify the GCS hwcap
In-Reply-To: <20240801-arm64-gcs-v10-27-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:06:54 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-27-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:22:37 -0300
Message-ID: <87zfpodlci.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

Mark Brown <broonie@kernel.org> writes:

> Add coverage of the GCS hwcap to the hwcap selftest, using a read of
> GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

The hwcap test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

