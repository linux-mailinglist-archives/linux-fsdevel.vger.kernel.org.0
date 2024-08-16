Return-Path: <linux-fsdevel+bounces-26113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F69547E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15A028492B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4671B32BF;
	Fri, 16 Aug 2024 11:16:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9ED1991D2;
	Fri, 16 Aug 2024 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806967; cv=none; b=FySkQT24kjhPyKLSrQHzHk2bYHvXFu9WGgVstKtqjqbc/VGIDW5PHHiCGOtEzCTV0jgiAOCGiPesw+hI8wmZVrUVoiRNTLMQUzBK66PLBmujo+003mkaAou82fbAxOUYTdDDFYObNH1BJeVTTIbhcJmArtYkpU5+hN0H0oG+9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806967; c=relaxed/simple;
	bh=BTTEUc56HwlcFetSO6s447R7NMhJy50d4LfBN4ZgD/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF0HiU1WFc06Gv6XhFkKGgXqAa5RydxMNyLUGCA1VHbg8tpAochY4pbPxwUKLT3xtAuhAYun1jUQ8PouC3tQSBBpzEm10Y5iew4zSLsByTEYjzPX/LSIw+f8LkC/KiWuOPRruZlJ/5nCUpMS4kjc5KaDSF8Y9sU0oCoZyhvhwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FA9C32782;
	Fri, 16 Aug 2024 11:16:01 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:15:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 10/40] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
Message-ID: <Zr807_K0y2UtvPWg@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-10-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-10-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:37PM +0100, Mark Brown wrote:
> @@ -2870,6 +2872,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_nv1,
>  		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
>  	},
> +	{
> +		.desc = "Guarded Control Stack (GCS)",
> +		.capability = ARM64_HAS_GCS,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,

Given that it's for user space only, system feature makes sense.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

