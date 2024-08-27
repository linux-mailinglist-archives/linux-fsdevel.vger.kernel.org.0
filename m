Return-Path: <linux-fsdevel+bounces-27421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D6961673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C486D1C234E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2B61D2799;
	Tue, 27 Aug 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgh7QaJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C41CE71E;
	Tue, 27 Aug 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782102; cv=none; b=qR1G/sJIS/U9is9DNB1dVlCLF/lBpYCF08NmPkag/hsF3SP1wEOR/4v7AhzmMuaDmmu6jg85LtnarO18pmgaQrX5wU1wQR9I/kMD/5gjnUDUADCNNGhf+nXbaFpHO3H6VKKN70MPySyv1F3vtincQ7u1CBKyvnVZG1Y4dImenXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782102; c=relaxed/simple;
	bh=6hBH/a+6Kb1AQJN1JkfkjXJwDxg0hGfZVyT/Iju2lR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc1+Ymrt9JNvaW+srw3HImSbxvh3agS+Ucu2cy1NVAtc4H7Krhw8napBECn5RNLwGdTbnu8Q/2fydt11IjG4yk0lqsJ2aBN0nb4lErvKKEWRm9GBmwYCA50P0WtYTkz7KbI2ijdy9Gn3W+wo0dPG+i7M0BZXBfY8c7RLVr8EiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgh7QaJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370C8C4AF10;
	Tue, 27 Aug 2024 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782102;
	bh=6hBH/a+6Kb1AQJN1JkfkjXJwDxg0hGfZVyT/Iju2lR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bgh7QaJ9At5jwNoKRhsGjGTLpqH2NoHSb2onT69lZKBrg6CFCpd9gW90r+2SgwoH1
	 0GNU4qRapNNxdtmhiz3gWa+ujq1IlqUkuBPyYN3ra/qXrZ51OrQfDbuWTOriF3MI3u
	 D/yRZfDOKHd3jb7eCXPIUIavEbn8irtpxQkNslY60M5/ftSYmc8YqwalTCS07pFCI3
	 hj06bAOcQeuQyIFdQ/UkeCFRVRQdnqRPRyQII4nQgYX/4hCQ0YgW5DKAY2h7ICJxTi
	 hD0WPmdZfDXifp12pn1RQcW0W7HncOytAz6KIA0c9HrIIszfZzaAXECJrebhNctsMW
	 /jqTscusJynDA==
Date: Tue, 27 Aug 2024 11:08:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <20240827180819.GB2049@sol.localdomain>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:13AM +0200, Christophe Leroy wrote:
> With the current implementation, __cvdso_getrandom_data() calls
> memset(), which is unexpected in the VDSO.
> 
> Rewrite opaque data initialisation to avoid memset().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  lib/vdso/getrandom.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index cab153c5f9be..4a56f45141b4 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/minmax.h>
> +#include <linux/array_size.h>
>  #include <vdso/datapage.h>
>  #include <vdso/getrandom.h>
>  #include <vdso/unaligned.h>
> @@ -74,11 +75,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
>  	u32 counter[2] = { 0 };
>  
>  	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
> -		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
> -			.size_of_opaque_state = sizeof(*state),
> -			.mmap_prot = PROT_READ | PROT_WRITE,
> -			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
> -		};
> +		struct vgetrandom_opaque_params *params = opaque_state;
> +		int i;
> +
> +		params->size_of_opaque_state = sizeof(*state);
> +		params->mmap_prot = PROT_READ | PROT_WRITE;
> +		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> +		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
> +			params->reserved[i] = 0;
> +
>  		return 0;
>  	}

Is there a compiler flag that could be used to disable the generation of calls
to memset?

- Eric

