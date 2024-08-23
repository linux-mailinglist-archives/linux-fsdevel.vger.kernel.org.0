Return-Path: <linux-fsdevel+bounces-26921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5F95D23B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582411F2543A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEEB18BB9D;
	Fri, 23 Aug 2024 15:59:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FB189535;
	Fri, 23 Aug 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428760; cv=none; b=Ha3sJI0A4EAEBlngAZBusI0R5miEhdRwj0ynJeVq3tZtP8dXS37jktwO9KMGqnR5FD06YDKN4DpJIrZwklmpI/U3EUfywb5AK6t1oyMGP1q9NrXAjjMki8AA0OP5GhyE/lPY5VZK8JyP/AjSCNzmN6F5KDsZ0eHi6nmtzIYkL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428760; c=relaxed/simple;
	bh=yTzD+B1z/7Em4lUy5BYRbkbEdL3Ho0yTaWOm/CmXCIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJMCOE2izDzMywFqc3DbRIF8HbFWhSd2S3sL1R/vtoV2S8ranaIPxMXOkwznXRYRAmXwEZZxuy+i9FIBZSQkaElZSidVXivOcMpBnQ15o/dmMZcKP3xIVBocsyLa1LvIUNHXgOf+jYDkWfV/85OmhOoggz/uFupLOnYW3yNq+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7C1C32786;
	Fri, 23 Aug 2024 15:59:14 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:59:11 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 25/39] arm64/signal: Expose GCS state in signal frames
Message-ID: <Zsixz6Y9xWxqaQaV@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
 <ZshYTyNbveD7WMyJ@arm.com>
 <ZshjmuYcejbhaSBg@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZshjmuYcejbhaSBg@finisterre.sirena.org.uk>

On Fri, Aug 23, 2024 at 11:25:30AM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2024 at 10:37:19AM +0100, Catalin Marinas wrote:
> > On Thu, Aug 22, 2024 at 02:15:28AM +0100, Mark Brown wrote:
> 
> > > +	gcs_preserve_current_state();
> > > +	gcspr = current->thread.gcspr_el0 - 8;
> 
> > > +	__put_user_error(gcspr, &ctx->gcspr, err);
> 
> > Do we actually need to store the gcspr value after the cap token has
> > been pushed or just the value of the interrupted context? If we at some
> > point get a sigaltshadowstack() syscall, the saved GCS wouldn't point to
> > the new stack but rather the original one. Unwinders should be able to
> > get the actual GCSPR_EL0 register, no need for the sigcontext to point
> > to the new shadow stack.
> 
> We could store either the cap token or the interrupted GCSPR_EL0 (the
> address below the cap token).  It felt more joined up to go with the cap
> token since notionally signal return is consuming the cap token but
> either way would work, we could just add an offset when looking at the
> pointer.

In a hypothetical sigaltshadowstack() scenario, would the cap go on the
new signal shadow stack or on the old one? I assume on the new one but
in sigcontext we'd save the original GCSPR_EL0. In such hypothetical
case, the original GCSPR_EL0 would not need 8 subtracted.

I need to think some more about this. The gcs_restore_signal() function
makes sense, it starts with the current GCSPR_EL0 on the signal stack
and consumes the token, adds 8 to the shadow stack pointer. The
restore_gcs_context() one is confusing as it happens before consuming
the cap token and assumes that the GCSPR_EL0 value actually points to
the signal stack. If we ever implement an alternative shadow stack, the
original GCSPR_EL0 of the interrupted context would be lost. I know it's
not planned for now but the principles should be the same. The
sigframe.uc should store the interrupted state.

To me the order for sigreturn should be first to consume the cap token,
validate it etc. and then restore GCSPR_EL0 to whatever was saved in the
sigframe.uc prior to the signal being delivered.

> > Also in gcs_signal_entry() in the previous patch, we seem to subtract 16
> > rather than 8.
> 
> We need to not only place a cap but also a GCS frame for the sigreturn
> trampoline, the sigreturn trampoline isn't part of the interrupted
> context so isn't included in the signal frame but it needs to have a
> record on the GCS so that the signal handler doesn't just generate a GCS
> fault if it tries to return to the trampoline.  This means that the
> GCSPR_EL0 that is set for the signal handler needs to move two entries,
> one for the cap token and one for the trampoline.

Yes, this makes sense.

> > What I find confusing is that both restore_gcs_context() and
> > gcs_restore_signal() seem to touch current->thread.gcspr_el0 and the
> > sysreg. Which one takes priority? I should probably check the branch out
> > to see the end result.
> 
> restore_gcs_context() is loading values from the signal frame in memory
> (which will only happen if a GCS context is present) then
> gcs_restore_signal() consumes the token at the top of the stack.  The
> split is because userspace can skip the restore_X_context() functions
> for the optional signal frame elements by removing them from the context
> but we want to ensure that we always consume a token.

I agree we should always consume a token but this should be done from
the actual hardware GCSPR_EL0 value on the sigreturn call rather than
the one restored from sigframe.uc. The restoring should be the last
step.

-- 
Catalin

