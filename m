Return-Path: <linux-fsdevel+bounces-31700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2B99A3F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14401F21620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D91CDFA6;
	Fri, 11 Oct 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBuRTnFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6720CCC5;
	Fri, 11 Oct 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649988; cv=none; b=DihE5o4aBvH3VOQCF0jdLiR6aM8fJWbcqbFlh34IsUiYoqiVbHdwlHPq9WWlpwEEq/JeWur1M5aYrL7SCIUA/vcBeNQD9oIjfEdQ3yLCfJf9/gO+e1VCUzeIzWA1T19QNgZWXtfTg9hiCYXmPfrEPtExTVqFzWLJrdjWP8ulDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649988; c=relaxed/simple;
	bh=6WlLSqQl5UgDYGtPwPNUpV33/lVuWnuZFTN12+K3zSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoCBpf6yhfKy2KV+4cHiWiuOHupLgoTZGUQ1t+0CWkr0xEdg8Omzqs2a574+REkYtCDWREOEVifcp1QpnAVZ6yBcgLjKDvBKzGv6gpTWCE8MkaVc0HJQP+pryzgcGrdOHavfTF99D2/qqsBkreW59jPW7j/OqB4D5KH6iPSxZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBuRTnFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D3C4CEC3;
	Fri, 11 Oct 2024 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649988;
	bh=6WlLSqQl5UgDYGtPwPNUpV33/lVuWnuZFTN12+K3zSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBuRTnFB7tRS+B52FfbK+aqz5vqrJKQLgUY6D1lgVXevJiQ9aOQiQ7jw7p8TXy9dY
	 a1JCpat1nH+oXyqCfZw1iSqjWRr4ISWRY/YY+0oEBhSxGWvQYLYaUuGPxiw0p25Nfq
	 +KL1EeZV2hifOBDc5TXTne7ReQ4gx8SyOoII2RaQoDc2guXhjhuWJ9+vcnTT4y02na
	 AndbSZ5lS+HRdx00pBh8feOWAF4CjGXByFgEPFTAjNWvxGztY5t7Q3p1RCRpXV6V49
	 yT4xjlGPyPucYd8zjCAX7+3OB9kLw7PC0p74wr9yLfcqjG+un85hRpgeHMWRU5vjsv
	 +4CMr6EyOHNFw==
Date: Fri, 11 Oct 2024 13:33:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT 3/3] kernel: converge common shadow stack flow
 agnostic to arch
Message-ID: <ZwkbAauYGhtldtW6@finisterre.sirena.org.uk>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-3-631beca676e7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SJuq1KBFwUpX1bg5"
Content-Disposition: inline
In-Reply-To: <20241010-shstk_converge-v1-3-631beca676e7@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--SJuq1KBFwUpX1bg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 05:32:05PM -0700, Deepak Gupta wrote:

> +unsigned long alloc_shstk(unsigned long addr, unsigned long size,
> +				 unsigned long token_offset, bool set_res_tok);
> +int shstk_setup(void);
> +int create_rstor_token(unsigned long ssp, unsigned long *token_addr);
> +bool cpu_supports_shadow_stack(void);

The cpu_ naming is confusing in an arm64 context, we use cpu_ for
functions that report if a feature is supported on the current CPU and
system_ for functions that report if a feature is enabled on the system.

> +void set_thread_shstk_status(bool enable);

It might be better if this took the flags that the prctl() takes?  It
feels like=20

> +/* Flags for map_shadow_stack(2) */
> +#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in =
the shadow stack */
> +

We've also got SHADOW_STACK_SET_MARKER now.

> +bool cpu_supports_shadow_stack(void)
> +{
> +	return arch_cpu_supports_shadow_stack();
> +}
> +
> +bool is_shstk_enabled(struct task_struct *task)
> +{
> +	return arch_is_shstk_enabled(task);
> +}

Do we need these wrappers (or could they just be static inlines in the
header)?

> +void set_thread_shstk_status(bool enable)
> +{
> +	arch_set_thread_shstk_status(enable);
> +}

arm64 can return an error here, we reject a bunch of conditions like 32
bit threads and locked enable status.

> +unsigned long adjust_shstk_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);
> +
> +	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G=
));
> +}

static?

> +/*
> + * VM_SHADOW_STACK will have a guard page. This helps userspace protect
> + * itself from attacks. The reasoning is as follows:
> + *
> + * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
> + * INCSSP instruction can increment the shadow stack pointer. It is the
> + * shadow stack analog of an instruction like:
> + *
> + *   addq $0x80, %rsp
> + *
> + * However, there is one important difference between an ADD on %rsp
> + * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
> + * memory of the first and last elements that were "popped". It can be
> + * thought of as acting like this:
> + *
> + * READ_ONCE(ssp);       // read+discard top element on stack
> + * ssp +=3D nr_to_pop * 8; // move the shadow stack
> + * READ_ONCE(ssp-8);     // read+discard last popped stack element
> + *
> + * The maximum distance INCSSP can move the SSP is 2040 bytes, before
> + * it would read the memory. Therefore a single page gap will be enough
> + * to prevent any operation from shifting the SSP to an adjacent stack,
> + * since it would have to land in the gap at least once, causing a
> + * fault.

This is all very x86 centric...

> +	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
> +		vm_munmap(mapped_addr, size);
> +		return -EINVAL;
> +	}

Bikeshedding but can we call the function create_shstk_token() instead?
The rstor means absolutely nothing in an arm64 context.

> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, si=
ze, unsigned int, flags)
> +{
> +	bool set_tok =3D flags & SHADOW_STACK_SET_TOKEN;
> +	unsigned long aligned_size;
> +
> +	if (!cpu_supports_shadow_stack())
> +		return -EOPNOTSUPP;
> +
> +	if (flags & ~SHADOW_STACK_SET_TOKEN)
> +		return -EINVAL;

This needs SHADOW_STACK_SET_MARKER for arm64.

> +	if (addr && (addr & (PAGE_SIZE - 1)))
> +		return -EINVAL;

	if (!PAGE_ALIGNED(addr))

> +int shstk_setup(void)
> +{

This is half of the implementation of the prctl() for enabling shadow
stacks.  Looking at the arm64 implementation this rafactoring feels a
bit awkward, we don't have the one flag at a time requiremet that x86
has and we structure things rather differently.  I'm not sure that the
arch_prctl() and prctl() are going to line up comfortably...

> +	struct thread_shstk *shstk =3D &current->thread.shstk;
> +	unsigned long addr, size;
> +
> +	/* Already enabled */
> +	if (is_shstk_enabled(current))
> +		return 0;
> +
> +	/* Also not supported for 32 bit */
> +	if (!cpu_supports_shadow_stack() ||
> +		(IS_ENABLED(CONFIG_X86_64) && in_ia32_syscall()))
> +		return -EOPNOTSUPP;

We probably need a thread_supports_shstk(), arm64 has a similar check
for not 32 bit threads and I noted an issue with needing this check
elsewhere.

> +	/*
> +	 * For CLONE_VFORK the child will share the parents shadow stack.
> +	 * Make sure to clear the internal tracking of the thread shadow
> +	 * stack so the freeing logic run for child knows to leave it alone.
> +	 */
> +	if (clone_flags & CLONE_VFORK) {
> +		set_shstk_base_size(tsk, 0, 0);
> +		return 0;
> +	}

On arm64 we set the new thread's shadow stack pointer here, the logic
around that can probably also be usefully factored out.

> +	/*
> +	 * For !CLONE_VM the child will use a copy of the parents shadow
> +	 * stack.
> +	 */
> +	if (!(clone_flags & CLONE_VM))
> +		return 0;

Here also.

--SJuq1KBFwUpX1bg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcJGwAACgkQJNaLcl1U
h9CbtAf8DH3tQWEmB0fJgCHXSmvsgdU8Z/4z+OUKw5cYTHGo1EsEBpfrOQCevbwL
LFr5TnnmBv5ZeYYXdjvi/jrtNJot6dN3s2PMHNoVk1HmIwWRKAnkqcwKnw2XJ2IY
65RBT1iAQHHPMw6IV5l6J9ipayRIXPrjuFQG+n9tj9CEprTMhRE13FpjagOk3Ncl
xpoyKXjjxJqu2rI3VKBoMnzjzs/5El7ru0de+ALqZOUvQDKdVt3fGERJQm0TrSeG
Y1rPvBCbqg6+J8+xIsPS7Ba/QJfgC1ZUj2eYEAJyVOJvwQ/C9NKHokV/vYlQZ1uD
0zR4iOT0Xj19R0+4TrBaAwdtbmXOgQ==
=z0Cu
-----END PGP SIGNATURE-----

--SJuq1KBFwUpX1bg5--

