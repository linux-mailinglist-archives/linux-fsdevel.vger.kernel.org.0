Return-Path: <linux-fsdevel+bounces-26715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBA95B3E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8F283A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54941C93CF;
	Thu, 22 Aug 2024 11:32:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295E17DE06;
	Thu, 22 Aug 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326323; cv=none; b=DGiCw51+SC5f5FylkrsuaVQ4o1V5LC4hfNf32jSu7TVV3hyxXveJlT2GBea7wPXncFVnDh3HfBlaPznoze3V1xLIGkGStPFsVz53obdE87ElmKQ2x56u50Jr2masHmHd3H6Ul8pTUdypS5Z/QDeS5jp3WFJWipCF/JDBfHJ2KH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326323; c=relaxed/simple;
	bh=ahYQxnZlDKF67DiooDXeohmk++gTfdE7lJjaYpBT67Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVvTAjIPLxySkIKyp3iITiHnm7P3BBE6aH1RmXTwQBNq4B18v4jghgNP4gh91JZRfCsvI8duDGKxoAa27zyALAkULCnB9Oa5g6lNtE4s+Ozn1uihPi+/lgtzgbFhF8qKqB36Y9GorFHnsY0r3cqtB4wyNQPVWGh9iutSYUGlUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3579BC32782;
	Thu, 22 Aug 2024 11:31:57 +0000 (UTC)
Date: Thu, 22 Aug 2024 12:31:55 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 18/39] arm64/traps: Handle GCS exceptions
Message-ID: <Zschq9JbvIRjmXVR@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-18-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-18-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:21AM +0100, Mark Brown wrote:
> A new exception code is defined for GCS specific faults other than
> standard load/store faults, for example GCS token validation failures,
> add handling for this. These faults are reported to userspace as
> segfaults with code SEGV_CPERR (protection error), mirroring the
> reporting for x86 shadow stack errors.
> 
> GCS faults due to memory load/store operations generate data aborts with
> a flag set, these will be handled separately as part of the data abort
> handling.
> 
> Since we do not currently enable GCS for EL1 we should not get any faults
> there but while we're at it we wire things up there, treating any GCS
> fault as fatal.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

