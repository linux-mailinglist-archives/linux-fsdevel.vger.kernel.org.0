Return-Path: <linux-fsdevel+bounces-26257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F4956A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AFB25190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4816CD10;
	Mon, 19 Aug 2024 12:04:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD116B3BD;
	Mon, 19 Aug 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069066; cv=none; b=ENeXTlbqBagGHKtmMV26Xtf+HppGMhU2r+UEr95OzF1X2wajo63aR+Ajxej1tUrtgcNfuEJlvZKilv7gfXWX9LyRyRE8J2p8ovcwmy4+JzB2ylYHTPVac5/56LZacbk4onAtIDOuL5UweR+b8o4sQ8S+I9RKdmQkwuzMqtYpj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069066; c=relaxed/simple;
	bh=aOsW0+lWbeQKqbvgTx+i39YwF3O+mmvE/GLBzRh1v3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9N0Za9c6vpOKaZG7ajess+6kN1mhbdDBTn7ueq2x/Uq+y7vn5BQ08iN7eaTRfdGtQ030Le/0+wMoi7UTL1thAP/om80Wy6eysTr1SohwsmZ7uEZJ+ci4IF9iXk0lxWdhldwg67xUqTl91aBU3pCjAVWcjqYjxMHXWidGDS+Ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949ABC32782;
	Mon, 19 Aug 2024 12:04:20 +0000 (UTC)
Date: Mon, 19 Aug 2024 13:04:18 +0100
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
Subject: Re: [PATCH v10 20/40] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <ZsM0wkRRguMchecK@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-20-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-20-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:47PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5f00cb0da9c3..d6d3a96cf2e4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -285,9 +285,32 @@ static void flush_gcs(void)
>  	write_sysreg_s(0, SYS_GCSPR_EL0);
>  }
>  
> +static int copy_thread_gcs(struct task_struct *p,
> +			   const struct kernel_clone_args *args)
> +{
> +	unsigned long gcs;
> +
> +	gcs = gcs_alloc_thread_stack(p, args);
> +	if (IS_ERR_VALUE(gcs))
> +		return PTR_ERR((void *)gcs);

Is 0 an ok value here? I can see further down that
gcs_alloc_thread_stack() may return 0.

> +
> +	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
> +	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
> +
> +	/* Ensure the current state of the GCS is seen by CoW */
> +	gcsb_dsync();

I don't get this barrier. What does it have to do with CoW, which memory
effects is it trying to order?

> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index b0a67efc522b..b71f6b408513 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -8,6 +8,138 @@
>  #include <asm/cpufeature.h>
>  #include <asm/page.h>
>  
> +static unsigned long alloc_gcs(unsigned long addr, unsigned long size)
> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long mapped_addr, unused;
> +
> +	if (addr)
> +		flags |= MAP_FIXED_NOREPLACE;
> +
> +	mmap_write_lock(mm);
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> +	mmap_write_unlock(mm);
> +
> +	return mapped_addr;
> +}
> +
> +static unsigned long gcs_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);
> +
> +	/* Allocate RLIMIT_STACK/2 with limits of PAGE_SIZE..2G */
> +	size = PAGE_ALIGN(min_t(unsigned long long,
> +				rlimit(RLIMIT_STACK) / 2, SZ_2G));
> +	return max(PAGE_SIZE, size);
> +}

So we still have RLIMIT_STACK/2. I thought we got rid of that and just
went with RLIMIT_STACK (or I misremember).

> +
> +static bool gcs_consume_token(struct mm_struct *mm, unsigned long user_addr)
> +{
> +	u64 expected = GCS_CAP(user_addr);
> +	u64 val;
> +	int ret;
> +
> +	/* This should really be an atomic cmpxchg.  It is not. */
> +	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
> +			       FOLL_FORCE);
> +	if (ret != sizeof(val))
> +		return false;
> +
> +	if (val != expected)
> +		return false;
> +
> +	val = 0;
> +	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
> +			       FOLL_FORCE | FOLL_WRITE);
> +	if (ret != sizeof(val))
> +		return false;
> +
> +	return true;
> +}

As per the clone3() thread, I think we should try to use
get_user_page_vma_remote() and do a cmpxchg() directly.

How does the user write the initial token? Do we need any barriers
before/after consuming the token?

-- 
Catalin

