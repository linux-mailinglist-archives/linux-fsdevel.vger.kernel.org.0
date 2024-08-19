Return-Path: <linux-fsdevel+bounces-26246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D62956685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396A01C218A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E315D5C7;
	Mon, 19 Aug 2024 09:12:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9115C130;
	Mon, 19 Aug 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058773; cv=none; b=CY6vQQNCTzTQk0e4RQenWMAZgfEtGtUTzcJMOolDzR/nyVt+HMHkfdhV4azcwSFHijdlArXV7u8Wu1an0yGSMSC/3AOOiVQ1AccbOD2Ef5TagD7OAT28uYTg0WcaTD19MAG1Q/pp+kmbzTL11PMpWCm4GdGEzs6zW9YPEPHgTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058773; c=relaxed/simple;
	bh=hpYMTcA6SjADd7KCTx6Ra0u1mHg9s+ce/MZQiFd+y34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBCaz9yUC+dw07oG/SThtA0+I37Szb/7HUscITjEEsnNc8IBkjepKFARYdK1ymhy49fgchhRnbYR3oPCyBePYaxDq1R38mcrgW0oNfd6fR4Gfx1/eWQnXm2KMWDe4eh4E9aN/EGqVdvhgLfYve2BzSUKiKAWpxxIZvMls/vk0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB2BC4AF09;
	Mon, 19 Aug 2024 09:12:47 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:12:45 +0100
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
Subject: Re: [PATCH v10 17/40] arm64/traps: Handle GCS exceptions
Message-ID: <ZsMMjcvdf3IZditO@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-17-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-17-699e2bd2190b@kernel.org>
X-TUID: yZN9oqNLB5Zt

On Thu, Aug 01, 2024 at 01:06:44PM +0100, Mark Brown wrote:
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

