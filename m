Return-Path: <linux-fsdevel+bounces-28551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B496BD3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55070280E3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD011DB539;
	Wed,  4 Sep 2024 12:55:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461681DA0E1;
	Wed,  4 Sep 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454514; cv=none; b=pisRobpP/PCiYaBV2N5jXJi0rRYrsdHnb4jsfuqXlC1J83ExNS2yCY1641RJi9+be0D7Tuj7KU1TL5AIrHxf6gMJJp1h/K8/+zp09RGSijiPFiAFQFVOUJhBxB0/tPtMpuSRoR714zjgQbPHvDy6IB2LE8i/NjjZHykYI0r1elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454514; c=relaxed/simple;
	bh=qMejZA9PsIbPUUClShG+nT87oLFIDssyt2kEGog2XX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er2pdJWtC+ljxN7VLGmZQoEMDg1BaisJYArx2hXHAUXfXVGyV8ny0vRlix5JzAwR5SP9Opan5HtgIc5M3j2jjx22OgpKamAXgQ9WERnnaOZauiyU6yfEKpojMc7roPNqC3+h6z+j3f6GAEIZkezaBKR5TytfG8P7r8hNqN0jV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FBD8FEC;
	Wed,  4 Sep 2024 05:55:37 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 369393F73B;
	Wed,  4 Sep 2024 05:55:08 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:55:03 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <20240904125503.GA3901671@e124191.cambridge.arm.com>
References: <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
 <20240904102254.GA13280@willie-the-truck>
 <20240904113221.GA3891700@e124191.cambridge.arm.com>
 <20240904114301.GA13550@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904114301.GA13550@willie-the-truck>

On Wed, Sep 04, 2024 at 12:43:02PM +0100, Will Deacon wrote:
> On Wed, Sep 04, 2024 at 12:32:21PM +0100, Joey Gouly wrote:
> > On Wed, Sep 04, 2024 at 11:22:54AM +0100, Will Deacon wrote:
> > > On Tue, Sep 03, 2024 at 03:54:13PM +0100, Joey Gouly wrote:
> > > > On Mon, Sep 02, 2024 at 08:08:08PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> > > > > > On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > > > > > > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > > > > > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > > > > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > > > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > > > > > > +{
> > > > > > > > > > > +	if (!system_supports_poe())
> > > > > > > > > > > +		return;
> > > > > > > > > > > +
> > > > > > > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > > > > > >
> > > > > > > > > > nit: typo "chaning".
> > > > > > > > > >
> > > > > > > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > > > > > > context of a new thread using a stale value for POR_EL0?
> > > > > > > > >
> > > > > > > > > Not just prevent faults but enforce the permissions from the new
> > > > > > > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > > > > > > here, we can't tell.
> > > > > [...]
> > > > > > > > So what do we actually gain by having the uaccess routines honour this?
> > > > > > >
> > > > > > > I guess where it matters is more like not accidentally faulting because
> > > > > > > the previous thread had more restrictive permissions.
> > > > > >
> > > > > > That's what I wondered initially, but won't the fault handler retry in
> > > > > > that case?
> > > > >
> > > > > Yes, it will retry and this should be fine (I assume you are only
> > > > > talking about the dropping ISB in the context switch).
> > > > >
> > > > > For the case of running with a more permissive stale POR_EL0, arguably it's
> > > > > slightly more predictable for the user but, OTOH, some syscalls like
> > > > > readv() could be routed through GUP with no checks. As with MTE, we
> > > > > don't guarantee uaccesses honour the user permissions.
> > > > >
> > > > > That said, at some point we should sanitise this path anyway and have a
> > > > > single ISB at the end. In the meantime, I'm fine with dropping the ISB
> > > > > here.
> > > > >
> > > > 
> > > > commit 3141fb86bee8d48ae47cab1594dad54f974a8899
> > > > Author: Joey Gouly <joey.gouly@arm.com>
> > > > Date:   Tue Sep 3 15:47:26 2024 +0100
> > > > 
> > > >     fixup! arm64: context switch POR_EL0 register
> > > > 
> > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > index a3a61ecdb165..c224b0955f1a 100644
> > > > --- a/arch/arm64/kernel/process.c
> > > > +++ b/arch/arm64/kernel/process.c
> > > > @@ -515,11 +515,8 @@ static void permission_overlay_switch(struct task_struct *next)
> > > >                 return;
> > > > 
> > > >         current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > -       if (current->thread.por_el0 != next->thread.por_el0) {
> > > > +       if (current->thread.por_el0 != next->thread.por_el0)
> > > >                 write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > -               /* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > -               isb();
> > > > -       }
> > > >  }
> > > 
> > > What about the one in flush_poe()? I'm inclined to drop that as well.
> > 
> > Yes I guess that one can be removed too. Catalin any comments?
> > 
> > > 
> > > > Will, do you want me to re-send the series with this and the permissions
> > > > diff from the other thread [1],
> > > > or you ok with applying them when you pull it in?
> > > 
> > > I'll have a crack now, but if it fails miserably then I'll let you know.
> > 
> > Thanks! Just to make sure, you should pick the patch up from
> > 
> > 	https://lore.kernel.org/linux-arm-kernel/20240903152937.GA3768522@e124191.cambridge.arm.com/
> > 
> > Not the one I linked to in [1] in my previous e-mail.
> 
> Right, there's quite a lot I need to do:
> 
> - Uncorrupt your patches
> - Fix the conflict in the kvm selftests
> - Drop the unnecessary ISBs
> - Fix the ESR checking
> - Fix the el2_setup labels
> - Reorder the patches
> - Drop the patch that is already in kvmarm
> 
> Working on it...

Sorry! I'm happy to rebase onto some arm64 branch if that will help, just let me know.

> 
> Will
> 

