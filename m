Return-Path: <linux-fsdevel+bounces-31964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898A99E679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2ACB24EC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094691D5ACD;
	Tue, 15 Oct 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKWuWFQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F41D4154;
	Tue, 15 Oct 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992485; cv=none; b=ffiWF/RHW6p5IZuubCacQ3DAIo9X9Zt3YYWpeio4/IUDGH4Zms8XiDjBGb89yt15l3K80sYXp9I/I4qrD7jcEQwC6GOqreNyBm+U1v0QSmMIKQCTwyqbP9OciyGJqjkIVUoSKqpbEmK2MY8KSGADkn8eq+f09YeDyUGCYksh5Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992485; c=relaxed/simple;
	bh=MMLGYJ3ppH3zesWUxVBPsvLY3G0bLj+ulqZ3MXv+H+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5u9Mk1WZZEfV6tjt6pg+vJ2cPawlbKTVqRMxqPmDXAEeISK5CiCSebPuTGnmrcQrq6G6SiG1zpPeFswrq3t5nvy6MkTdTJaMGmHEB+SOYVoRTf2niJOdNUMarUFySeaSGg/NfVAnBwwYC0FQHMXPlChOstEfUBAILBbYXU/AdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKWuWFQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21911C4CECF;
	Tue, 15 Oct 2024 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992485;
	bh=MMLGYJ3ppH3zesWUxVBPsvLY3G0bLj+ulqZ3MXv+H+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKWuWFQqTVTJynGPE8DqW8n/xI73kLFPuoP5rh/c5kK1CSzjaiF8IYtd8kopRff3K
	 XzdLUQpCs229QH3XbN6uW7uDFcld9GU4lQqyeSLikLmD2AArAbPqViBkORonVwi/F1
	 meo0nTDrGhQM/7o0bBVbjaX75lXFKFGpwWTYxfaZ1Q51KRZgYksDHYD54yqRhojHGr
	 lKXOeOPfylHxDC0UYfMvK4LV2v0EDh5S3knmX5cyQ9SV2mj0M5ieWdUUod7sj74EvF
	 xwI17jNouAEf7oIY/BXMWY8jbY8LGd8gPfdfvjZD8Bwi29mydpctt42T4rNrYJkSng
	 80ZuatKj9mzjg==
Date: Tue, 15 Oct 2024 12:41:16 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
Message-ID: <20241015114116.GA19334@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015095911.GA3777204@e124191.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 15, 2024 at 10:59:11AM +0100, Joey Gouly wrote:
> On Mon, Oct 14, 2024 at 06:10:23PM +0100, Will Deacon wrote:
> > Kevin, Joey,
> > 
> > On Wed, Oct 09, 2024 at 03:43:01PM +0100, Will Deacon wrote:
> > > On Tue, Sep 24, 2024 at 01:27:58PM +0200, Kevin Brodsky wrote:
> > > > On 22/08/2024 17:11, Joey Gouly wrote:
> > > > > @@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> > > > >  		sme_smstop();
> > > > >  	}
> > > > >  
> > > > > +	if (system_supports_poe())
> > > > > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> > > > 
> > > > At the point where setup_return() is called, the signal frame has
> > > > already been written to the user stack. In other words, we write to the
> > > > user stack first, and then reset POR_EL0. This may be problematic,
> > > > especially if we are using the alternate signal stack, which the
> > > > interrupted POR_EL0 may not grant access to. In that situation uaccess
> > > > will fail and we'll end up with a SIGSEGV.
> > > > 
> > > > This issue has already been discussed on the x86 side, and as it happens
> > > > patches to reset PKRU early [1] have just landed. I don't think this is
> > > > a blocker for getting this series landed, but we should try and align
> > > > with x86. If there's no objection, I'm planning to work on a counterpart
> > > > to the x86 series (resetting POR_EL0 early during signal delivery).
> > > 
> > > Did you get a chance to work on that? It would be great to land the
> > > fixes for 6.12, if possible, so that the first kernel release with POE
> > > support doesn't land with known issues.
> > 
> > Looking a little more at this, I think we have quite a weird behaviour
> > on arm64 as it stands. It looks like we rely on the signal frame to hold
> > the original POR_EL0 so, if for some reason we fail to allocate space
> > for the POR context, I think we'll return back from the signal with
> > POR_EL0_INIT. That seems bad?
> 
> If we don't allocate space for POR_EL0, I think the program recieves SIGSGEV?
> 
> setup_sigframe_layout()
>         if (system_supports_poe()) {
>                 err = sigframe_alloc(user, &user->poe_offset,
>                                      sizeof(struct poe_context));
>                 if (err)
>                         return err;
>         }
> 
> Through get_sigframe() and setup_rt_frame(), that eventually hets here:
> 
> handle_signal()
> 	ret = setup_rt_frame(usig, ksig, oldset, regs);
> 
> 	[..]
> 
>         signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
> 
> void signal_setup_done(int failed, struct ksignal *ksig, int stepping)                                                                                                                         
> {                                                                                                                                                                                              
>         if (failed)                                                                                                                                                                            
>                 force_sigsegv(ksig->sig);                                                                                                                                                      
>         else                                                                                                                                                                                   
>                 signal_delivered(ksig, stepping);                                                                                                                                              
> }  
> 
> So I think it's "fine"?

Ah, yes, sorry about that. I got confused by the conditional push in
setup_sigframe():

	if (system_supports_poe() && err == 0 && user->poe_offset) {
		...

which gives the wrong impression that the POR is somehow optional, even
if the CPU supports POE. So we should drop that check of
'user->poe_offset' as it cannot be NULL here.

We also still need to resolve Kevin's concern, which probably means
keeping the thread's original POR around someplace.

Will

