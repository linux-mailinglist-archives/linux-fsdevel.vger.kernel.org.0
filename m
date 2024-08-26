Return-Path: <linux-fsdevel+bounces-27133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8795EDED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F0F1F22BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A11474B2;
	Mon, 26 Aug 2024 10:00:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA7148316;
	Mon, 26 Aug 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666409; cv=none; b=DYySPwe9fbyQpEgiFNfvOQb4dYCbLMe+EbN3VfKrqC78BG2plOySqIYj70AExHwxqZMzyRlFuDhB2boNn/ettt19LGZDAp9daBe4tv6d90b/SH6BE5osK18VRy4oo47KUM/avP35+ruQwrll/NEHNqeQNA05iq/CDhmrdRPVFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666409; c=relaxed/simple;
	bh=DbkPxyn548cggFykDNg5a3YB22zz+j3MIZKKt0agUMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJuPn+PAMQ4iImjcMYgOuxnFlxZu5n2V/NgdsXLTTRanLUP/wRgJn4qOq0qk1V6S78uQUjXnkyYGyHTf2zOSUHSGVlkozN2sHCv5lyd1nEDpQ+VnfsmiIEAv6JZJU7VCMjl4Fdh1vJ4BG1hlxQU9WRUo9v4uqwgkreA2xpirCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF28C51400;
	Mon, 26 Aug 2024 10:00:01 +0000 (UTC)
Date: Mon, 26 Aug 2024 13:00:09 +0300
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
Message-ID: <ZsxSKVAOHQq12YfB@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
 <ZshYTyNbveD7WMyJ@arm.com>
 <ZshjmuYcejbhaSBg@finisterre.sirena.org.uk>
 <Zsixz6Y9xWxqaQaV@arm.com>
 <ZskGqU8BSvR01W30@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZskGqU8BSvR01W30@finisterre.sirena.org.uk>
X-TUID: eW4byJ2kTpsL

On Fri, Aug 23, 2024 at 11:01:13PM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2024 at 04:59:11PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 23, 2024 at 11:25:30AM +0100, Mark Brown wrote:
> 
> > > We could store either the cap token or the interrupted GCSPR_EL0 (the
> > > address below the cap token).  It felt more joined up to go with the cap
> > > token since notionally signal return is consuming the cap token but
> > > either way would work, we could just add an offset when looking at the
> > > pointer.
> 
> > In a hypothetical sigaltshadowstack() scenario, would the cap go on the
> > new signal shadow stack or on the old one? I assume on the new one but
> > in sigcontext we'd save the original GCSPR_EL0. In such hypothetical
> > case, the original GCSPR_EL0 would not need 8 subtracted.
> 
> I would have put the token on the old stack since that's what we'd be
> returning to.

After some more spec reading, your approach makes sense as it matches
the GCSSS[12] instructions where the outgoing, rather than incoming,
shadow stack is capped. So all good I think. However, a bit more below
on the restore order (it's ok but a bit confusing).

> This raises interesting questions about what happens if
> the reason for the signal is that we just overflowed the normal stack
> (which are among the issues that have got in the way of working out if
> or how we do something with sigaltshadowstack).

That's not that different from the classic case where we get an error
trying to setup the frame. signal_setup_done() handles it by forcing a
SIGSEGV. I'd say we do the same here.

> I'm not clear what the
> purpose of the token would be on the new stack, the token basically says
> "this is somewhere we can sigreturn to", that's not the case for the
> alternative stack.

Yeah, I thought we have to somehow mark the top of the stack with this
token. But looking at the architecture stack switching, it caps the
outgoing stack (in our case this would be the interrupted one). So
that's settled.

On the patch itself, I think there are some small inconsistencies on how
it reads the GCSPR_EL0: preserve_gcs_context() does a
gcs_preserve_current_state() and subsequently reads the value from the
thread structure. A bit later, gcs_signal_entry() goes for the sysreg
directly. I don't think that's a problem even if the thread gets
preempted but it would be nice to be consistent. Maybe leave the
gcs_preserve_current_state() only a context switch thing. Would it work
if we don't touch the thread structure at all in the signal code? We
wouldn't deliver a signal in the middle of the switch_to() code. So any
value we write in thread struct would be overridden at the next switch.

If GCS is disabled for a guest, we save the GCSPR_EL0 with the cap size
subtracted but there's no cap written. In restore_gcs_context() it
doesn't look like we add the cap size back when writing GCSPR_EL0. If
GCS is enabled, we do consume the cap and add 8 but otherwise it looks
that we keep decreasing GCSPR_EL0. I think we should always subtract the
cap size if GCS is enabled. This could could do with some refactoring as
I find it hard to follow (not sure exactly how, maybe just comments will
do).

I'd also keep a single write to GCSPR_EL0 on the return path but I'm ok
with two if we need to cope with GCS being disabled but the GCSPR_EL0
still being saved/restored.

Another aspect for gcs_restore_signal(), I think it makes more sense for
the cap to be consumed _after_ restoring the sigcontext since this has
the actual gcspr_el0 where we stored the cap and represents the original
stack. If we'll get an alternative shadow stack, current GCSPR_EL0 on
sigreturn points to that alternative shadow stack rather than the
original one. That's what confused me when reviewing the patch and I
thought the cap goes to the top of the signal stack.

-- 
Catalin

