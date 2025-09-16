Return-Path: <linux-fsdevel+bounces-61832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1345B5A441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868E317B866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C430506C;
	Tue, 16 Sep 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+TrpXzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAC292B44;
	Tue, 16 Sep 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059417; cv=none; b=Lyq0Agmm48GES1XC+UFidB4G31XkjTC1+TWF4dVAVLl5RUWW0s19YUMxZfdLA6VdgUpQtMRWJnibf7HzwQFH61cjU2/4SpQSh6s6nK8v5vOqSxRjGYBF2Yues/PVtS4pfitb6fF0PQy24OrPyMn7isAVXB/hnAlXZQUhqZX+KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059417; c=relaxed/simple;
	bh=ZQ5vXZCra2+RwJM46CnghsruiNCvFvmuzVBMwnQAxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ8/3SoLTggNUB5tcboIfyE1Vo/WYrLqGPvvF9aoxlcRIA2tOEJdz/mM215LR2TsmoZ3X/dDF45qKOeOHqbSJYDSv19zWV0zmQSZwmHauESZiqx+eNfJItMa7jhIsS16bmAArCzJ/qRbNdS9Qlq4jx0b7ThsiTfd3LEdVaiKaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+TrpXzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7972C4CEEB;
	Tue, 16 Sep 2025 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059416;
	bh=ZQ5vXZCra2+RwJM46CnghsruiNCvFvmuzVBMwnQAxV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+TrpXzUl2eTgi4QAIadZ/pNqv4SSebpKU3um6A7/anUcuUGYZyj9EL6D0IGTRP7l
	 LGw9Vctspzd2wyYumY6+hlmE5QoNEyrVnAial2rZOdpr6lJ2kAfh0l4YBsjHEZPx75
	 uqyKE07qlPxAeISvNqNsGLvGISga6JTeIVmT4nBWYhNyE5eUDLXu9mmj2DrMmAyFg8
	 dkXAjw1NJS5PNR1FKKPpQBvzDmq2fVa4WxBysqzBwlYh8XiWX/MzgZVcNluuzMEW99
	 xRLj940q2hWbWyuSkN/iWBNliBKT3Sw5fBuGq+8+9IZt49pC1glVE13Dd7fnXFtJ+z
	 wx+sp4PwAsr6w==
Date: Tue, 16 Sep 2025 14:50:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang
 < version 17
Message-ID: <20250916215011.GA596283@ax162>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162>
 <87ikhi9lhg.ffs@tglx>
 <87frcm9kvv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frcm9kvv.ffs@tglx>

On Tue, Sep 16, 2025 at 10:56:36PM +0200, Thomas Gleixner wrote:
> clang < 17 fails to use scope local labels with CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y:
> 
>      {
>      	__label__ local_lbl;
> 	...
> 	unsafe_get_user(uval, uaddr, local_lbl);
> 	...
> 	return 0;
> 	local_lbl:
> 		return -EFAULT;
>      }
> 
> when two such scopes exist in the same function:
> 
>   error: cannot jump from this asm goto statement to one of its possible targets
> 
> There are other failure scenarios. Shuffling code around slightly makes it
> worse and fail even with one instance.
> 
> That issue prevents using local labels for a cleanup based user access
> mechanism.
> 
> After failed attempts to provide a simple enough test case for the 'depends
> on' test in Kconfig, the initial cure was to mark ASM goto broken on clang
> versions < 17 to get this road block out of the way.
> 
> But Nathan pointed out that this is a known clang issue and indeed affects
> clang < version 17 in combination with cleanup(). It's not even required to
> use local labels for that.
> 
> The clang issue tracker has a small enough test case, which can be used as
> a test in the 'depends on' section of CC_HAS_ASM_GOTO_OUTPUT:
> 
> void bar(void **);
> void* baz();

I would recommend

  void* baz(void);

here and in the actual test to preemptively harden against the
possibility of a future where -Wstrict-prototypes is turned on as an
error by default (as unlikely as this may be, it has been brought up
before [1]), as I would not want this to get silently disabled.

> int  foo (void) {
>     {
> 	    asm goto("jmp %l0"::::l0);
> 	    return 0;
> l0:
> 	    return 1;
>     }
>     void *x __attribute__((cleanup(bar))) = baz();
>     {
> 	    asm goto("jmp %l0"::::l1);
> 	    return 42;
> l1:
> 	    return 0xff;
>     }
> }
> 
> Add another dependency to config CC_HAS_ASM_GOTO_OUTPUT for it and use the
> clang issue tracker test case for detection by condensing it to obfuscated
> C-code contest format. This reliably catches the problem on clang < 17 and
> did not show any issues on the non known to be broken GCC versions.
> 
> That test might be sufficient to catch all issues and therefore could
> replace the existing test, but keeping that around does no harm either.
> 
> Thanks to Nathan for pointing to the relevant clang issue!
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1886
> Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> V2a: Use the reproducer from llvm
> V2: New patch
> ---
>  init/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
>  config CC_HAS_ASM_GOTO_OUTPUT
>  	def_bool y
>  	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
> +	# Find basic issues

Maybe "Detect basic support" or something like that? This is not really
an "issues" test, more of a "does the compiler support it at all?" test
if I understand correctly.

>  	depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
> +	# Detect buggy clang, fixed in clang-17
> +	depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
>  
>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
>  	depends on CC_HAS_ASM_GOTO_OUTPUT

