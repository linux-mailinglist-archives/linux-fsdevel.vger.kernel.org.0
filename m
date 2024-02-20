Return-Path: <linux-fsdevel+bounces-12191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2385CC4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8DF1C22814
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF41552E8;
	Tue, 20 Feb 2024 23:54:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178E154C19
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473243; cv=none; b=Hqo2PhUyUprbTWlp1mDRm8H3RiWFJwh7LIHDBbUnQ4n9/F4Ttg99pn548/M4xM+NwQkxzDoHsVVBAtqsoVmZLOT3bkKmjwe8+979xqCIa5wDHh7cf8sP/eNZ15NsfpcD6Qp7AkYgIO4cTGN5SQ4n+elr8BvcRZ8svMZMNNoXYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473243; c=relaxed/simple;
	bh=pv9M6nCH7P1FRo4VitsRtyecMjGHuwFYfQImuvaTZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzGnPJ70p3CUQvYF9Ic50c0lvuZvAxef8jODXWq/ShwqgiSLgIAAtA/wYtNo3UuoBJZmqIajyYRO7lVgdvAb144r2P1jdr4IBQDdBlXkPRUjgwnGzCQn8k600hR4kXpPTxl34RAxEWyyOKipQc2brimZ2KihNqBqp12Hcq/neks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Tue, 20 Feb 2024 18:54:16 -0500
From: "dalias@libc.org" <dalias@libc.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240220235415.GP4163@brightrain.aerifal.cx>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 20, 2024 at 11:30:22PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-02-20 at 13:57 -0500, Rich Felker wrote:
> > On Tue, Feb 20, 2024 at 06:41:05PM +0000, Edgecombe, Rick P wrote:
> > > Hmm, could the shadow stack underflow onto the real stack then? Not
> > > sure how bad that is. INCSSP (incrementing the SSP register on x86)
> > > loops are not rare so it seems like something that could happen.
> > 
> > Shadow stack underflow should fault on attempt to access
> > non-shadow-stack memory as shadow-stack, no?
> 
> Maybe I'm misunderstanding. I thought the proposal included allowing
> shadow stack access to convert normal address ranges to shadow stack,
> and normal writes to convert shadow stack to normal.

As I understood the original discussion of the proposal on IRC, it was
only one-way (from shadow to normal). Unless I'm missing something,
making it one-way is necessary to catch situations where the shadow
stack would become compromised.

> > > Shadow stacks currently have automatic guard gaps to try to prevent
> > > one
> > > thread from overflowing onto another thread's shadow stack. This
> > > would
> > > somewhat opens that up, as the stack guard gaps are usually
> > > maintained
> > > by userspace for new threads. It would have to be thought through
> > > if
> > > these could still be enforced with checking at additional spots.
> > 
> > I would think the existing guard pages would already do that if a
> > thread's shadow stack is contiguous with its own data stack.
> 
> The difference is that the kernel provides the guard gaps, where this
> would rely on userspace to do it. It is not a showstopper either.
> 
> I think my biggest question on this is how does it change the
> capability for two threads to share a shadow stack. It might require
> some special rules around the syscall that writes restore tokens. So
> I'm not sure. It probably needs a POC.

Why would they be sharing a shadow stack?

> > From the musl side, I have always looked at the entirely of shadow
> > stack stuff with very heavy skepticism, and anything that breaks
> > existing interface contracts, introduced places where apps can get
> > auto-killed because a late resource allocation fails, or requires
> > applications to code around the existence of something that should be
> > an implementation detail, is a non-starter. To even consider shadow
> > stack support, it must truely be fully non-breaking.
> 
> The manual assembly stack switching and JIT code in the apps needs to
> be updated. I don't think there is a way around it.

Indeed, I'm not talking about programs with JIT/manual stack-switching
asm, just anything using existing APIs for control of stack --
pthread_setstack, makecontext, sigaltstack, etc.

> I agree though that the late allocation failures are not great. Mark is
> working on clone3 support which should allow moving the shadow stack
> allocation to happen in userspace with the normal stack. Even for riscv
> though, doesn't it need to update a new register in stack switching?

If clone is called with signals masked, it's probably not necessary
for the kernel to set the shadow stack register as part of clone3.

> BTW, x86 shadow stack has a mode where the shadow stack is writable
> with a special instruction (WRSS). It enables the SSP to be set
> arbitrarily by writing restore tokens. We discussed this as an option
> to make the existing longjmp() and signal stuff work more transparently
> for glibc.
> 
> > 
> > > > _Without_ doing this, sigaltstack cannot be used to recover from
> > > > stack
> > > > overflows if the shadow stack limit is reached first, and
> > > > makecontext
> > > > cannot be supported without memory leaks and unreportable error
> > > > conditions.
> > > 
> > > FWIW, I think the makecontext() shadow stack leaking is a bad idea.
> > > I
> > > would prefer the existing makecontext() interface just didn't
> > > support
> > > shadow stack, rather than the leaking solution glibc does today.
> > 
> > AIUI the proposal by Stefan makes it non-leaking because it's just
> > using normal memory that reverts to normal usage on any
> > non-shadow-stack access.
> > 
> 
> Right, but does it break any existing apps anyway (because of small
> ucontext stack sizes)?
> 
> BTW, when I talk about "not supporting" I don't mean the app should
> crash. I mean it should instead run normally, just without shadow stack
> enabled. Not sure if that was clear. Since shadow stack is not
> essential for an application to function, it is only security hardening
> on top.
> 
> Although determining if an application supports shadow stack has turned
> out to be difficult in practice. Handling dlopen() is especially hard.

One reasonable thing to do, that might be preferable to overengineered
solutions, is to disable shadow-stack process-wide if an interface
incompatible with it is used (sigaltstack, pthread_create with an
attribute setup using pthread_attr_setstack, makecontext, etc.), as
well as if an incompatible library is is dlopened. This is much more
acceptable than continuing to run with shadow stacks managed sloppily
by the kernel and async killing the process on OOM, and is probably
*more compatible* with apps than changing the minimum stack size
requirements out from under them.

The place where it's really needed to be able to allocate the shadow
stack synchronously under userspace control, in order to harden normal
applications that aren't doing funny things, is in pthread_create
without a caller-provided stack.

Rich

