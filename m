Return-Path: <linux-fsdevel+bounces-26077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD895374F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF621C24813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD61AD40E;
	Thu, 15 Aug 2024 15:33:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ACF17623F;
	Thu, 15 Aug 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736017; cv=none; b=CC6IhH/uXeSfJ3R3cpZ9i/fbrBM2vQIiy3qJTA3dhudH5o4+p9qGBaMvXuAu8hGb917Uj7CyORmo6TuZRNXXjjKUCQ4BN8ZaasfXhnhHh5Cd4RZJMFF/3exc3OvPBjDFMbqMDiQxcAsFUf7ZYVhyFAx3oLJm20cYuviDqboM4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736017; c=relaxed/simple;
	bh=yuBSzO1VMf0OSwzUaS3tqSOGDhyIctJOS0rFSUhwvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ticij96BHpNDWmIHJ7YNqQqMG7YqWfP6BzqRLV1mYj/JantIm4b5V5AV1Yo+ByeuguaI8brt98+VpA064NPyLe8WTQZu437SeISREB0b9T3ohJ/wQlekmBu8xId7Tx7Ij2XsRLg4S4/mmQZrWCMuptwAmIEq25cbYKRR8vKNUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7948614BF;
	Thu, 15 Aug 2024 08:34:00 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555713F58B;
	Thu, 15 Aug 2024 08:33:28 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:33:25 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v10 24/40] arm64/signal: Expose GCS state in signal frames
Message-ID: <Zr4fxZ8wf+Wcey4E@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
 <ZrzIv3FWNgJizDc2@e133380.arm.com>
 <7433e3d2-996a-45a0-b917-666a340ad109@sirena.org.uk>
 <Zr4KMaBv4JXx8uBz@e133380.arm.com>
 <efe1d936-011d-49e3-a0ff-8f6276e4d782@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe1d936-011d-49e3-a0ff-8f6276e4d782@sirena.org.uk>

On Thu, Aug 15, 2024 at 04:05:32PM +0100, Mark Brown wrote:
> On Thu, Aug 15, 2024 at 03:01:21PM +0100, Dave Martin wrote:
> 
> > My thought was that if libc knows about shadow stacks, it is probably
> > going to be built to use them too and so would enable shadow stack
> > during startup to protect its own code.
> 
> > (Technically those would be independent decisions, but it seems a good
> > idea to use a hardening feature if you know about and it is present.)
> 
> > If so, shadow stacks might always get turned on before the main program
> > gets a look-in.
> 
> > Or is that not the expectation?
> 
> The expectation (at least for arm64) is that the main program will only
> have shadow stacks if everything says it can support them.  If the
> dynamic linker turns them on during startup prior to parsing the main
> executables this means that it should turn them off before actually
> starting the executable, taking care to consider any locking of features.

Hmm, so we really do get a clear "enable shadow stack" call to the
kernel, which we can reasonaly expect won't happen for ancient software?

If so, I think dumping the GCS state in the sigframe could be made
conditional on that without problems (?)

(We could always make it unconditional later if it turn out that that
approach breaks something.)

> 
> > > > Is there any scenario where it is legitimate for the signal handler to
> > > > change the shadow stack mode or to return with an altered GCSPR_EL0?
> 
> > > If userspace can rewrite the stack pointer on return (eg, to return to a
> > > different context as part of userspace threading) then it will need to
> 
> > Do we know if code that actually does that?  IIUC, trying to do this is
> > totally broken on most arches nowadays; making it work requires a
> > reentrant C library and/or logic to defer signals around critical
> > sections in userspace.
> 
> > "Real" threading makes this pretty pointless for the most part.
> 
> > Related question: does shadow stack work with ucontext-based coroutines?
> > Per-context stacks need to be allocated by the program for that.
> 
> Yes, ucontext based coroutines are the sort of thing I meant when I was
> talking about returning to a different context?  

Ah, right.  Doing this asynchronously on the back of a signal (instead
of doing a sigreturn) is the bad thing.  setcontext() officially
doesn't work for this any more, and doing it by hacking or rebuilding
the sigframe is extremely hairy and probably a terrible idea for the
reasons I gave.

> > > be able to also update GCSPR_EL0 to something consistent otherwise
> > > attempting to return from the interrupted context isn't going to go
> > > well.  Changing the mode is a bit more exotic, as it is in general.
> > > It's as much to provide information to the signal handler as anything
> > > else.

Note, the way sigcontext (a.k.a. mcontext).__reserved[] is used by
glibc for the ucontext API is inspired by the way the kernel uses it,
but not guaranteed to be compatible.  For the ucontext API glibc
doesn't try to store/restore asynchronous contexts (which is why
setcontext() from a signal handler is totally broken), so there is no
need to store SVE/SME state and hence lots of free space, so this
probably is supportable with shadow stacks -- if there's a way to
allocate them.  This series would be unaffected either way.

(IIRC, the contents of mcontext.__reserved[] is totally incompatible
with what the kernel puts in there, and doesn't have the same record
structure.)

> 
> > I'm not sure that we should always put information in the signal frame
> > that the signal handler can't obtain directly.
> 
> > I guess it's harmless to include this, though.
> 
> If we don't include it then if different ucontexts have different GCS
> features enabled we run into trouble on context switch.

As outlined above, nowadays you can only use setcontext() on a context
obtained from getcontext().  Using setcontext() on a context obtained
from a sigframe works by accident or not at all, but in any case
coroutines always switch synchronously and don't rely on doing this.

(See where setcontext deals with the FPSIMD regs:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/aarch64/setcontext.S;h=ba659438c564dc3bbbb8d6039030e2c492649534;hb=HEAD )

So, overall I think making ucontext coroutines with with GCS is purely
a libc matter that is "interesting" here, but we don't need to worry
about.

> > > > Is the guarded stack considered necessary (or at least beneficial) for
> > > > backtracing, or is the regular stack sufficient?
> 
> > > It's potentially beneficial, being less vulnerable to corruption and
> > > simpler to parse if all you're interested in is return addresses.
> > > Profiling in particular was mentioned, grabbing a linear block of memory
> > > will hopefully be less overhead than chasing down the stack.  The
> > > regular stack should generally be sufficient though.
> 
> > I guess we can't really argue that the shadow stack pointer is
> > redundant here though.  The whole point of shadow stacks is to make
> > things more robust...
> 
> > Just kicking the tyres on the question of whether we need it here, but
> > I guess it's hard to make a good case for saying "no".
> 
> Indeed.  The general model here is that we don't break userspace that
> relies on parses the normal stack (so the GCS is never *necessary*) but
> clearly you want to have it.

Agreed, but perhaps not in programs that haven't enabled shadow stack?

Cheers
---Dave

