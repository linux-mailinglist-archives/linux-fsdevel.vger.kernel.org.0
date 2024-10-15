Return-Path: <linux-fsdevel+bounces-32003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237E99F091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1671C2346A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CD1CB9F0;
	Tue, 15 Oct 2024 15:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AB1CB9E0;
	Tue, 15 Oct 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004515; cv=none; b=Rfylwwrg0gykhH2hGVhkWUkj94GbZcDV8XJIcwiAOtpK73sQZVUoDhZ/UHVAIP3m0U8pya0fdSprYvytPty4DDEKgLiuNIVFlkVefhhzZ2AI/eGpzcaGFQMqXUaBFOYPairOD0e9klOGA4pi4PaSd8jErOBjDGVRysSlX/YBDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004515; c=relaxed/simple;
	bh=eJiYstpk1WK1R4lbmpBGfqhnbHP9qsBG/eF+PTVYAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDRFTKxwXGdrAp4Xf36luVQl8NtF+EcBuoN7G/P62IijEOoOJ5yRiL+wtDSHbz2PCJAxjRcvG7RIH1BuWnXo1u8b1mATlcsRtFcZCmEpDbRZGz7lE0OJOXPVH0BFSjljaPeqn3GkaqbKRmEDxregeBT26L+LjQdQx9gyg1Em3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18141C4CEC6;
	Tue, 15 Oct 2024 15:01:49 +0000 (UTC)
Date: Tue, 15 Oct 2024 16:01:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
Message-ID: <Zw6D2waVyIwYE7wd@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
 <20241015114116.GA19334@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015114116.GA19334@willie-the-truck>

On Tue, Oct 15, 2024 at 12:41:16PM +0100, Will Deacon wrote:
> On Tue, Oct 15, 2024 at 10:59:11AM +0100, Joey Gouly wrote:
> > On Mon, Oct 14, 2024 at 06:10:23PM +0100, Will Deacon wrote:
> > > Looking a little more at this, I think we have quite a weird behaviour
> > > on arm64 as it stands. It looks like we rely on the signal frame to hold
> > > the original POR_EL0 so, if for some reason we fail to allocate space
> > > for the POR context, I think we'll return back from the signal with
> > > POR_EL0_INIT. That seems bad?
> > 
> > If we don't allocate space for POR_EL0, I think the program recieves SIGSGEV?
> > 
> > setup_sigframe_layout()
> >         if (system_supports_poe()) {
> >                 err = sigframe_alloc(user, &user->poe_offset,
> >                                      sizeof(struct poe_context));
> >                 if (err)
> >                         return err;
> >         }
> > 
> > Through get_sigframe() and setup_rt_frame(), that eventually hets here:
> > 
> > handle_signal()
> > 	ret = setup_rt_frame(usig, ksig, oldset, regs);
> > 
> > 	[..]
> > 
> >         signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
> > 
> > void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
> > {
> >         if (failed)
> >                 force_sigsegv(ksig->sig);
> >         else
> >                 signal_delivered(ksig, stepping);
> > }  
> > 
> > So I think it's "fine"?
> 
> Ah, yes, sorry about that. I got confused by the conditional push in
> setup_sigframe():
> 
> 	if (system_supports_poe() && err == 0 && user->poe_offset) {
> 		...
> 
> which gives the wrong impression that the POR is somehow optional, even
> if the CPU supports POE. So we should drop that check of
> 'user->poe_offset' as it cannot be NULL here.

I agree, we should remove this check as it's confusing.

> We also still need to resolve Kevin's concern, which probably means
> keeping the thread's original POR around someplace.

If we fail to allocate context for POR_EL0 (or anything else), we'll
deliver a SIGSEGV. I think it's quite likely that the SIGSEGV will also
fail to allocate context we end up with a fatal SIGSEGV. Not sure the
user can affect the allocation/layout, though it can change stack
attributes where the frame is written.

Assuming that the user tricks the kernel into failing to write the
context but allows it to succeed on the resulting SIGSEGV, POR_EL0
wouldn't have been reset and the SIGSEGV context will still have the
original value. I don't think we need to do anything here for 6.12.

However, in for-next/core, we have gcs_signal_entry() called after
resetting POR_EL0. If this fails, we can end up with a new POR_EL0 on
sigreturn (subject to the above user toggling permissions). I think this
needs to be fixed, POR_EL0 only reset when we know we are going to
deliver the signal.

-- 
Catalin

