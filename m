Return-Path: <linux-fsdevel+bounces-26071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90C9536B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9A1F25342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFE1A76C0;
	Thu, 15 Aug 2024 15:09:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6B6FBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734576; cv=none; b=vCXWVS6cy38KanrKwlgAPKCJGxUThmwnW2inXxD+XaNK37vdFeAwe/QjtTQPFWOhAOosZtz/Jlut7e14PZVI0/EBb8+1DLuy4UOaNoZu3nD8CV/DgxMPz8EhYK1pfzYEHymetup3eCYm6A8zlRbIjxIMUJk1pvgKRMm4Z2yR/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734576; c=relaxed/simple;
	bh=j3zE/chshOnC4Oq5Tcw/F31kD11HYP1IM/o+V49tylw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPBO//zskXm1l7xba2OkHrBJBLsQz34RdnnVopMcHVN4Vb9W0J/Xhc+CtSNcwbg9MDUOIN+CZL9UIvLknrOlZQJmzOPxcOcy59rXcUd+LkgZAM1o9DcEzLBOjZusuONmWowZbP6bNFz0IT6W+8eaToHptQIoaVCNR2sRMaWJhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0DCB14BF;
	Thu, 15 Aug 2024 08:09:59 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5142B3F58B;
	Thu, 15 Aug 2024 08:09:29 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:09:26 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <Zr4aJqc/ifRXJQAd@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
 <ZrzHU9et8L_0Tv_B@arm.com>
 <20240815131815.GA3657684@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131815.GA3657684@e124191.cambridge.arm.com>

On Thu, Aug 15, 2024 at 02:18:15PM +0100, Joey Gouly wrote:
> Hi Catalin,
> 
> On Wed, Aug 14, 2024 at 04:03:47PM +0100, Catalin Marinas wrote:
> > Hi Joey,
> > 
> > On Tue, Aug 06, 2024 at 03:31:03PM +0100, Joey Gouly wrote:
> > > diff --git arch/arm64/kernel/signal.c arch/arm64/kernel/signal.c
> > > index 561986947530..ca7d4e0be275 100644
> > > --- arch/arm64/kernel/signal.c
> > > +++ arch/arm64/kernel/signal.c
> > > @@ -1024,7 +1025,10 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> > >                         return err;
> > >         }
> > >  
> > > -       if (system_supports_poe()) {
> > > +       if (system_supports_poe() &&
> > > +                       (add_all ||
> > > +                        mm_pkey_allocation_map(current->mm) != 0x1 ||
> > > +                        read_sysreg_s(SYS_POR_EL0) != POR_EL0_INIT)) {
> > >                 err = sigframe_alloc(user, &user->poe_offset,
> > >                                      sizeof(struct poe_context));
> > >                 if (err)
> > > 
> > > 
> > > That is, we only save the POR_EL0 value if any pkeys have been allocated (other
> > > than pkey 0) *or* if POR_EL0 is a non-default value.
> > 
> > I had a chat with Dave as well on this and, in principle, we don't want
> > to add stuff to the signal frame unnecessarily, especially for old
> > binaries that have no clue of pkeys. OTOH, it looks like too complicated
> > for just 16 bytes. Also POR_EL0 all RWX is a valid combination, I don't
> > think we should exclude it.

Unfortunately, this is always going to be the obviously simpler and
more robust option for dealing with any new register state.

In effect, the policy will be to push back on unconditional additions
to the signal frame, except for 100% of proposed additions...


I'm coming round to the view that trying to provide absolute guarantees
about the signal frame size is unsustainable.  x86 didn't, and got away
with it for some time...  Maybe we should just get rid of the relevant
comments in headers, and water down guarantees in the SVE/SME
documentation to recommendations with no promise attached?

I can propose a patch for that.

> > 
> > If no pkey has been allocated, I guess we could skip this and it also
> > matches the x86 description of the PKRU being guaranteed to be preserved
> > only for the allocated keys. Do we reserve pkey 0 for arm64? I thought
> > that's only an x86 thing to emulate execute-only mappings.

It's not clear whether pkey 0 is reserved in the sense of being
permanently allocated, or in the sense of being unavailable for
allocation.

Since userspace gets pages with pkey 0 by default and can fiddle with
the permissions on POR_EL0 and set this pkey onto pages using
pkey_mprotect(), I'd say pkey 0 counts as always allocated; and the
value of the POR_EL0 bits for pkey 0 needs to be maintained.

> 
> To make it less complicated, I could drop the POR_EL0 check and just do:
> 
> -       if (system_supports_poe()) {
> +       if (system_supports_poe() &&
> +                       (add_all ||
> +                        mm_pkey_allocation_map(current->mm) != 0x1) {
> 
> This wouldn't preserve the value of POR_EL0 if no pkeys had been allocated, but
> that is fine, as you said / the man pages say.
> 
> We don't preserve pkey 0, but it is the default for mappings and defaults to
> RWX. So changing it probably will lead to unexpected things.
> 
> > 
> > Another corner case would be the signal handler doing a pkey_alloc() and
> > willing to populate POR_EL0 on sigreturn. It will have to find room in
> > the signal handler, though I don't think that's a problem.
> 
> pkey_alloc() doesn't appear in the signal safety man page, but that might just
> be an omission due to permission keys being newer, than actually saying
> pkey_alloc() can't be used.

In practice this is likely to be a thin syscall wrapper; those are
async-signal-safe in practice on Linux (but documentation tends to take
a while to catch up).  (Exceptions exists where "safe" calls are used
in ways that interfere with the internal operation of libc... but those
cases are mostly at least semi-obvious and rarely documented.)

Using pkey_alloc() in a signal handler doesn't seem a great idea for
more straightforward reasons, though:  pkeys are a scarce, per-process
resource, and allocating them asynchronously in the presence of other
threads etc., doesn't seem like a recipe for success.

I haven't looked, but I'd be surprised if there's any code doing this!

Generally, it's too late to allocate any non-trivial kind of resource
one you're in a signal handler... you need to plan ahead.

> 
> If POR_EL0 isn't in the sig context, I think the signal handler could just
> write the POR_EL0 system register directly? The kernel wouldn't restore POR_EL0
> in that case, so the value set in the signal handler would just be preserved.
> 
> The reason that trying to preserve the value of POR_EL0 without any pkeys
> allocated (like in the patch in my previous e-mail had) doesn't really make
> sense, is that when you do pkey_alloc() you have to pass an initial value for
> the pkey, so that will overwite what you may have manually written into
> POR_EL0. Also you can't pass an unallocated pkey value to pkey_mprotect().

My argument here was that from the signal handler's point of view, the
POR_EL0 value of the interrupted context lives in the sigframe if it's
there (and will then be restored from there), and directly in POR_EL0
otherwise.  Parsing the sigframe determine where the image of POR_EL0 is.

I see two potential problems.

1) (probably not a big deal in practice)

If the signal handler wants to withdraw a permission from pkey 0 for
the interrupted context, and the interrupted context had no permission
on any other pkey (so POR_EL0 is not dumped and the handler must update
POR_EL0 directly before returning).

In this scenario, the interrupted code would explode on return unless
it can cope with globally execute-only or execute-read-only permissions.
(no-execute is obviously dead on arrival).

If a signal handler really really wanted to do this, it could return
through an asm trampoline that is able to cope with the reduced
permissions.  This seems like a highly contrived scenario though, and I
can't see how it could be useful...

2) (possibly a bigger deal) pkeys(7) does say explicitly (well, sort of)
that the PKRU bits are restored on sigreturn.

Since there are generic APIs to manipulate pkeys, it might cause
problems if sigreturn restores the pkey permissions on some arches
but not on others.  Some non-x86-specific software might already be 
relying on the restoration of the permissions.


> That's a lot of words to say, or ask, do you agree with the approach of only
> saving POR_EL0 in the signal frame if num_allocated_pkeys() > 1?
> 
> Thanks,
> Joey

...So..., given all the above, it is perhaps best to go back to
dumping POR_EL0 unconditionally after all, unless we have a mechanism
to determine whether pkeys are in use at all.

If we initially trapped POR_EL0, and set a flag the first time it is
accessed or one of the pkeys syscalls is used, then we could dump
POR_EL0 conditionally based on that: once the flag is set, we always
dump it for that process.  If the first POR_EL0 access or pkeys API
interaction is in a signal handler, and that handler modifies POR_EL0,
then it wouldn't get restored (or at least, not automatically).  Not
sure if this would ever matter in practice.

It's potentially fiddly to make it work 100% consistently though (does
a sigreturn count as a write?  What if the first access to POR_EL0 is
through ptrace, etc.?)

Cheers
---Dave

