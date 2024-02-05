Return-Path: <linux-fsdevel+bounces-10332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E13849E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE06F1C221E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F1364CC;
	Mon,  5 Feb 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvvLnxe0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4B3CF63;
	Mon,  5 Feb 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147249; cv=none; b=q8nTOAYiCSASzKpB2goUAKuJ4eZ3nTBvfHifO7qdhxLwKa/rhKFtiSPIOWjsAmQBqRF2twfl13rAGGGB6kfZO1fmcZIYllufQ4wg2regc/QgfyYqw/VPExrbPnFgiGG7Km74ri7UlBsAc9jV/v1JmEgkkPi3rwsz6IoJxyBT8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147249; c=relaxed/simple;
	bh=SZ5lOaTcjPLax9RiPdWCg4niKcbES+E0uMPELi0RXuU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRslNkPnR8VIA6ZMJ2KwdpDZGSRoeAPE0IASsSnR8HmYZDPUdRVomxyiEXQLFN7m7B+mEzq1CUBXditCDceEAPaJJAp4kUWekMygG0FpmYnrp6lPJF2Q2lBHpI7oY+5o7bF+hvc8xmenPFpTcPygUW7ukzx8nSG6f1WtGLXQbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvvLnxe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213CBC433F1;
	Mon,  5 Feb 2024 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147249;
	bh=SZ5lOaTcjPLax9RiPdWCg4niKcbES+E0uMPELi0RXuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvvLnxe0P4S5yNRw5W2VY9jJ/E1A+shICsu1xDuV/gHmffvHBzURzsVRFJcvUJ8YE
	 6QBN55llvCBZnj2N7RqNyqqi9c7wb9DYeG2+9zjkVok4Da3nmMRjNTPGl+52PDgjhM
	 GsH1ZYh1DLMKySBZsxTWhaRwJPkUykxLG+W3eZkFdZ3mhXH9Sw0xcFypYfdPXfZBjP
	 sHZCaIf8sr9Lx503zRsqr0kqLGI0h6JzFx1tMKuSAoy5MXNktLQyNPGD6r8QxxINLm
	 5o0ggZ7xvpbbeoBwBLxqbCmkB97jAeDicbiBgGlpnPXzp92m19n0g6qQkAvnLQu4Iz
	 PpsszaLe4tw5Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rX0z0-000Su2-Bp;
	Mon, 05 Feb 2024 15:34:06 +0000
Date: Mon, 05 Feb 2024 15:34:05 +0000
Message-ID: <8634u76i36.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 13/38] KVM: arm64: Manage GCS registers for guests
In-Reply-To: <825d2b35-fa10-43ad-b3b3-b29a77f3fed0@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	<20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
	<868r3z6y6v.wl-maz@kernel.org>
	<825d2b35-fa10-43ad-b3b3-b29a77f3fed0@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, keescook@chromium.org, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 05 Feb 2024 12:35:53 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> On Mon, Feb 05, 2024 at 09:46:16AM +0000, Marc Zyngier wrote:
> > On Sat, 03 Feb 2024 12:25:39 +0000,
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > > @@ -25,6 +25,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> > >  {
> > >  	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
> > >  	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
> > > +	if (has_gcs())
> > > +		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
> 
> > We have had this discussion in the past. This must be based on the
> > VM's configuration. Guarding the check with the host capability is a
> > valuable optimisation, but that's nowhere near enough. See the series
> > that I have posted on this very subject (you're on Cc), but you are
> > welcome to invent your own mechanism in the meantime.
> 
> Right, which postdates the version you're replying to and isn't merged
> yet - the current code was what you were asking for at the time.

v1 and v2 predate it. And if the above is what I did ask, then I must
have done a very poor job of explaining what was required. For which I
apologise profusely.

> I'm
> expecting to update all these feature series to work with that once it
> gets finalised and merged but it's not there yet, I do see I forgot to
> put a note in v9 about that like I did for dpISA - sorry about that, I
> was too focused on the clone3() rework when rebasing onto the new
> kernel.
> 
> This particular series isn't going to get merged for a while yet anyway
> due to the time it'll take for userspace testing, I'm expecting your
> series to be in by the time it becomes an issue.

Right. Then I'll ignore it for the foreseeable future.

> 
> > > +	if (has_gcs()) {
> > > +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
> > > +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
> > > +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> > > +			       SYS_GCSCRE0_EL1);
> > > +	}
> 
> > For the benefit of the unsuspecting reviewers, and in the absence of a
> > public specification (which the XML drop isn't), it would be good to
> > have the commit message explaining the rationale of what gets saved
> > when.
> 
> What are you looking for in terms of rationale here?  The KVM house
> style is often very reliant on reader context so it would be good to
> know what considerations you'd like to see explicitly addressed.

Nothing to do with style, everything to do with substance: if nothing
in the host kernel makes any use of these registers, why are they
eagerly saved/restored on nVHE/hVHE? I'm sure you have a reason for
it, but it isn't that obvious. Because these two modes need all the
help they can get in terms of overhead reduction.

> These
> registers shouldn't do anything when we aren't running the guest so
> they're not terribly ordering sensitive, the EL2 ones will need a bit
> more consideration in the face of nested virt.

The EL2 registers should follow the exact same pattern, specially once
you fix the VNCR bugs I pointed out.

	M.

-- 
Without deviation from the norm, progress is not possible.

