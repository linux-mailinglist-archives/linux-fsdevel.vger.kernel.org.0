Return-Path: <linux-fsdevel+bounces-26111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0679547B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0591C22782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA319EEC0;
	Fri, 16 Aug 2024 11:13:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5961991BB;
	Fri, 16 Aug 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806814; cv=none; b=J/kPfpRpDcmP/2ggP9Dq8T0vM0f3JrNcMq+igOhm+HMUpgYFN3rK1mzrd9Nabe0zwfu87/yR8eh4Arx1O0TLfijIa2YjsAnK2nNS7elcuhCQIhvfdFaCPNOj8flEh4hnzRyEkQ/mutnRbHTKs7Y8QA6Tt1nxzYvOlaJasapqZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806814; c=relaxed/simple;
	bh=64cM9bclDSiB1iWfcpkQfUsDnt/GE+0NUolbKcBVzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azNd8/O5ZXDXP288RafUh2Hki45an05vqYT0bE5t++IERAfbjbipYvBX98yTmhV9yzCkPWjuX8sxXR0vVBJqXHypRScZYCgvWyp9Pd+BaLZX+SlR92wS8Np/AZBeARa5GkuipH6ZeEyli8MAEqSpjI01p1JAGTXL9s7p6/hXKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2CEC32782;
	Fri, 16 Aug 2024 11:13:28 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:13:27 +0100
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
Subject: Re: [PATCH v10 09/40] arm64/gcs: Provide basic EL2 setup to allow
 GCS usage at EL0 and EL1
Message-ID: <Zr80V8zbb_C5pTGI@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-9-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-9-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:36PM +0100, Mark Brown wrote:
> There is a control HCRX_EL2.GCSEn which must be set to allow GCS
> features to take effect at lower ELs and also fine grained traps for GCS
> usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
> EL1.
> 
> We also initialise GCSCR_EL1 and GCSCRE0_EL1 to ensure that we can
> execute function call instructions without faulting regardless of the
> state when the kernel is started.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

