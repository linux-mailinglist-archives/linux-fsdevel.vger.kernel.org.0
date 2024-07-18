Return-Path: <linux-fsdevel+bounces-23978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D338937145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDC81C20C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 23:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67A145346;
	Thu, 18 Jul 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1SzmEo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E523B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346475; cv=none; b=Sd/nbcEyXhprO3+voc9OFGvTBDuY1E/XdSW5XwYtxAbu48XXkiRLlxRd3IpbKU5T87ABkEPBy2iv3qBcLO3Z+0sRadZviPBv6YLOvC7FNaizXNkEWrRHKevNc/cCpZiaKLcS4ZxljqJ5qF+6YmZyiuTYRQs5AyOL0ttFWJIi7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346475; c=relaxed/simple;
	bh=47h5NGaRPMcJoe2hZvUn4CFZamjTK9bMbPmVK25pOdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/wFIJh8z+FeuxBRmdbBgaHP/+dE6MyJatnDOX/VJs9HV0AXKSDzQlObSb0USItdTW9f4hgXldrkyqOX1E9aKP1SndWmujafZk1ly1plK+SNjKW2d1xU/nhd6s4V7OpTzPQew4hAMjc9H3ZHzoX2DSI/QfAoi7kTB5mWUPIT09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1SzmEo7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7037a208ff5so790909a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346473; x=1721951273; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wG4uwlbaV+J8vLwBombRfMb1OG6U151ykySFE5AhqQ=;
        b=p1SzmEo7q+9PQ8c7QhAIMu4kWat9zb4ARwGe8tXv7Rj81Wl7ET8BbeYzmoH762ehT/
         6mmcU7U9v5R7aW3hfehy99o7tKzBClOemAe/NvB7g5V7xJABdy4jCvkU16qhvNylF2Ht
         /VyZmzk+ez8Vb6qh9XKbWsJYMA5RDD6RUMK97lAeyvwkpwdjCH8l1DistobtAlsusBq2
         g94rt+Qfh3iYrweQbTLYC2pRuxvZbARMoUGGgvS2nP+DjU5pW8c2OyY1d/A9xH0pic4h
         4XgvPBSI9ej04EMaW/+eDnSi72wwMGucCWXKD0tiO4P8K9IM1U4WYZ/cGwMbMbu3Lj6h
         grAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346473; x=1721951273;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wG4uwlbaV+J8vLwBombRfMb1OG6U151ykySFE5AhqQ=;
        b=f1tN/OrEtvOZESrKhX377SHH9DtFLolZ/B4291kwUP4GSL8HGFX7hfL/U74No/lUcj
         XNF6idmH4mraMBJ9mOEVB/4IuleR2q8noQi43/CqKrMrJ85HUUg5GMNPSXXOlACjMH5U
         5TuFUJtH35cCKAVE7XVi6W27fwb8fW0AafS4hNm6ywY1w2N/LDziJ19MyojtaW5JT3pj
         QlQ6BZKs5k6zrB/4L5Te8ZJQOa8ICUuyIw2wwihFCkOubV3P+CI6BdTYp2dPiasTFgMV
         Z3xQBpVYv4JTDtBd5/qQg7k5oVT1JMKKHHvZy3pWPQBtN0VRV/tSUtXrUA3tF7mP1K6A
         f9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWi5fr+o0xZECp2We1CLo0X6JXtwYmHWa2mi5wIUTHwHOvyxAUYYa9cmxFFBysHTxWvfLLTYP0cO18zRi4XPDxVBgvt0g1fnoyYc9EmpQ==
X-Gm-Message-State: AOJu0Yx8430s1DruS5OQX/cLp+BO6tal7d21jqfqK5CTNj2WQoeU8IIN
	OXb5r/qhy41p6GQ9CNROIKJ9P0HLrbCcVguyltKPbsaHl723SX4/elUbuXG1DfM=
X-Google-Smtp-Source: AGHT+IGb5vwrvVRNc/Zru+u1tWaF5JoGONpNCNR6gfjZnBju8QrPRuYrwnUehHVlBaNSMasi1A3gpw==
X-Received: by 2002:a05:6830:700b:b0:702:1ea0:cfbb with SMTP id 46e09a7af769-708e37a48b4mr8654473a34.18.1721346472747;
        Thu, 18 Jul 2024 16:47:52 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:15c8:3512:f33c:2f80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79db5690a65sm142926a12.16.2024.07.18.16.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:47:52 -0700 (PDT)
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
Subject: Re: [PATCH v9 38/39] kselftest/arm64: Add a GCS stress test
In-Reply-To: <875xt2xojp.fsf@linaro.org> (Thiago Jung Bauermann's message of
	"Thu, 18 Jul 2024 20:34:18 -0300")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-38-0f634469b8f0@kernel.org>
	<875xt2xojp.fsf@linaro.org>
Date: Thu, 18 Jul 2024 20:47:49 -0300
Message-ID: <871q3qxnx6.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thiago Jung Bauermann <thiago.bauermann@linaro.org> writes:

> # # Finishing up...
> # # Thread-4030 exited with error code 255
> # not ok 1 Thread-4030
> # # Thread-4031 exited with error code 255
> # not ok 2 Thread-4031
> # # Thread-4032 exited with error code 255
> # not ok 3 Thread-4032
> # # Thread-4033 exited with error code 255
> # not ok 4 Thread-4033
> # # Thread-4034 exited with error code 255
> # not ok 5 Thread-4034
> # # Thread-4035 exited with error code 255
> # not ok 6 Thread-4035
> # # Thread-4036 exited with error code 255
> # not ok 7 Thread-4036
> # # Thread-4037 exited with error code 255
> # not ok 8 Thread-4037
> # # Thread-4038 exited with error code 255
> # not ok 9 Thread-4038
> # # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: arm64: gcs-stress

Also, Shouldn't the test report "not ok" at the end considering that
there were fails?
-- 
Thiago

