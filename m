Return-Path: <linux-fsdevel+bounces-26484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31E95A182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4301C22236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206014EC5C;
	Wed, 21 Aug 2024 15:37:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D9149C42;
	Wed, 21 Aug 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254627; cv=none; b=XtKf+6C9+r7qxberNaorME+qrJl3BS5cEkKL2SzxmLhPCGQUlXYY00gQFkFJwzKYqXQr/oaIMgx2ChMtm0dlwTnPqqswV0OJGio2MWvaUl0Jnbf2obbbbWVzWkqZ15jgVFbVekqM+gGGtqrF4VwldaJRFoh6t1DAFhdoXr7S33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254627; c=relaxed/simple;
	bh=qK5SrM0kCFeg+U99f/EIhPZD9OS0OhmRTTyueuazCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzoXT1vImdaBwbElbc2tkuHTVHgJbFIizyeOjsnHpHj4ZuYL4P7qLuXYJOQf7cn0h696jI5XK1luPAkuXeeH2T4zJnfabjCLjKbMLNF2OTRjVLP4zaVY0eiNcDBN/qxpdzvlj0hN9+0tIny59d8+t1apDw9wrGvlBPzzmacu23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF4C4AF09;
	Wed, 21 Aug 2024 15:37:01 +0000 (UTC)
Date: Wed, 21 Aug 2024 16:36:59 +0100
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
Subject: Re: [PATCH v10 22/40] arm64/mm: Implement map_shadow_stack()
Message-ID: <ZsYJm51qLzkvtnMM@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-22-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-22-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:49PM +0100, Mark Brown wrote:
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> +{
> +	unsigned long alloc_size;
> +	unsigned long __user *cap_ptr;
> +	unsigned long cap_val;
> +	int ret = 0;
> +	int cap_offset;
> +
> +	if (!system_supports_gcs())
> +		return -EOPNOTSUPP;
> +
> +	if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER))
> +		return -EINVAL;
> +
> +	if (addr && (addr % PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (size == 8 || size % 8)
> +		return -EINVAL;

Nitpicks: use PAGE_ALIGNED and IS_ALIGNED(size, 8).

> +
> +	/*
> +	 * An overflow would result in attempting to write the restore token
> +	 * to the wrong location. Not catastrophic, but just return the right
> +	 * error code and block it.
> +	 */
> +	alloc_size = PAGE_ALIGN(size);
> +	if (alloc_size < size)
> +		return -EOVERFLOW;
> +
> +	addr = alloc_gcs(addr, alloc_size);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +
> +	/*
> +	 * Put a cap token at the end of the allocated region so it
> +	 * can be switched to.
> +	 */
> +	if (flags & SHADOW_STACK_SET_TOKEN) {
> +		/* Leave an extra empty frame as a top of stack marker? */
> +		if (flags & SHADOW_STACK_SET_MARKER)
> +			cap_offset = 2;
> +		else
> +			cap_offset = 1;
> +
> +		cap_ptr = (unsigned long __user *)(addr + size -
> +						   (cap_offset * sizeof(unsigned long)));
> +		cap_val = GCS_CAP(cap_ptr);
> +
> +		put_user_gcs(cap_val, cap_ptr, &ret);
> +		if (ret != 0) {
> +			vm_munmap(addr, size);
> +			return -EFAULT;
> +		}
> +
> +		/* Ensure the new cap is viaible for GCS */
> +		gcsb_dsync();

s/viaible/visible/

On the comment itself, the barrier does not ensure visibility in
absolute term, it's all about ordering relative to other accesses. It
might be good to clarify what we actually need in terms of ordering. One
aspect came up in an earlier patch was around thread creation. For the
current CPU, subsequent GCS accesses in program order will see this
token. Classic LDR/STR won't without the barrier. I think this matters
when we check the token in the clone3() implementation. Maybe write
something along the lines of "ensure the new cap is ordered before
standard memory accesses to the same location".

Anyway, the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

