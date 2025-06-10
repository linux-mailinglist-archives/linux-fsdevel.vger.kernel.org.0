Return-Path: <linux-fsdevel+bounces-51097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F5AD2C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EF83A9019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AC25D546;
	Tue, 10 Jun 2025 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq0ePe08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349A184F;
	Tue, 10 Jun 2025 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528279; cv=none; b=thFCFOyVXFBce0lhLYNDW+WsnCCNzqtzS8ME0Pw01P2rBKiI4w2dqFD+DIFzBQWF75aFsphbgjbO4fcOVH1i5HJ397ZowYD8a7h0OyFR+VvMOIt3kI0RbXZ4a7h8iRHEetc4k4oKB3hL+duoo1g9sSISpdorJNmaLrgv7yWnM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528279; c=relaxed/simple;
	bh=aVnJbC3z4nwrmfypL0Oi6Gf1QoMq9GB7sy1Q0NerLR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XceUegN4JjqY+i2TvS/8HK23MZPCxmjr+L5QKFBrYXJlp+RJILQxrizOcCYHNpWFyY2qc1e6BeYRVm+sIi0A4F7GgeUNNJqHsPfxp6PA8Q0lgsfjQ8lVVN2wm6ePkehRuy90NKdFE2dWi/+8kRTCrQzb6kprokfT/ktZHFl8qqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq0ePe08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002EEC4CEEF;
	Tue, 10 Jun 2025 04:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749528277;
	bh=aVnJbC3z4nwrmfypL0Oi6Gf1QoMq9GB7sy1Q0NerLR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wq0ePe08BqT+ES0gpcmY92ykXFtKKa+HuUt26Kfn0ERlyV9OUGnJ2OQwKuqgxwF91
	 svtoihBgrR41xsCAkR6Dvec7dFKveCKHQN7PLYbhSFYXwu5DVXvnyjBU+8QlUJaOwP
	 YIdeFa5fUJe6aYmS1+i3bHM4TwB14sbrJj4fhZ6oKvjIleGvkgQW5ExV2OcncGpAMw
	 5rqkgEvOYu2joguoZgODKd85X3+DZmMQ8r3GtVopJ4zK5H46iOSqambHDDZFkPHl8s
	 IrPDeI4ygHtfTmEflaXVkKxDvnAJe6DnSDAH0KxNNnJwKoiSMy65z73dBQu5GtSO08
	 W2jLe8TPrOReg==
Date: Mon, 9 Jun 2025 21:04:36 -0700
From: Kees Cook <kees@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] binfmt_elf: use check_mul_overflow() for size calc
Message-ID: <202506092053.827AD89DC5@keescook>
References: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607082844.8779-1-pranav.tyagi03@gmail.com>

On Sat, Jun 07, 2025 at 01:58:44PM +0530, Pranav Tyagi wrote:
> Use check_mul_overflow() to safely compute the total size of ELF program
> headers instead of relying on direct multiplication.
> 
> Directly multiplying sizeof(struct elf_phdr) with e_phnum risks integer
> overflow, especially on 32-bit systems or with malformed ELF binaries
> crafted to trigger wrap-around. If an overflow occurs, kmalloc() could
> allocate insufficient memory, potentially leading to out-of-bound
> accesses, memory corruption or security vulnerabilities.
> 
> Using check_mul_overflow() ensures the multiplication is performed
> safely and detects overflows before memory allocation. This change makes
> the function more robust when handling untrusted or corrupted binaries.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Link: https://github.com/KSPP/linux/issues/92
> ---
>  fs/binfmt_elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43363d593e5..774e705798b8 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -518,7 +518,10 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
>  
>  	/* Sanity check the number of program headers... */
>  	/* ...and their total size. */
> -	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;

size is unsigned int, which has a maximum value of 4,294,967,295.

elf_ex->e_phnum is a u16 (2 bytes) and will not be changing:

$ pahole -C elf64_hdr */fs/binfmt_elf.o
struct elf64_hdr {
	...
        Elf64_Half                 e_phnum;              /*    56     2 */
	...
$ pahole -C Elf64_Half */fs/binfmt_elf.o
typedef __u16 Elf64_Half;

So it has a maximum value of 65,535.

sizeof(struct elf_phdr) is a fixed value, 56:

$ pahole -C elf64_phdr */fs/binfmt_elf.o
struct elf64_phdr {
	...
        /* size: 56, cachelines: 1, members: 8 */
        /* last cacheline: 56 bytes */
};

So the maximum product of the two is 3,669,960.

It is not possible for this calculation to overflow.

> +	
> +	if (check_mul_overflow(sizeof(struct elf_phdr), elf_ex->e_phnum, &size))
> +		goto out;
> +

You can even see that the entire check would be elided by the compiler:

#include <elf.h>

unsigned int unchecked(Elf64_Ehdr *elf_ex)
{
    unsigned int size;

    size = sizeof(Elf64_Phdr) * elf_ex->e_phnum;

    return size;
}

unsigned int checked(Elf64_Ehdr *elf_ex)
{
    unsigned int size;

    if (__builtin_mul_overflow(sizeof(Elf64_Phdr), elf_ex->e_phnum, &size))
        return 0;

    return size;
}

...produces this assembler, identical for both functions:

unchecked:
        movzx   eax, WORD PTR [rdi+56]
        imul    eax, eax, 56
        ret
checked:
        movzx   eax, WORD PTR [rdi+56]
        imul    eax, eax, 56
        ret


https://godbolt.org/z/hTEef8cT9

-Kees

-- 
Kees Cook

