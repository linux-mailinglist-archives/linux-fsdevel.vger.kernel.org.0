Return-Path: <linux-fsdevel+bounces-28540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E603796BAC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B051C24599
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA21D04BC;
	Wed,  4 Sep 2024 11:32:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0D1CF7AC;
	Wed,  4 Sep 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449553; cv=none; b=tW6CZZ9dCoEbxNs+uEVnR7TrYsVdhUE3+MdyPWoDRXOjMwXq1bITIviStfRliXqk7vh8QfjhO7QwKcVa0NuEnSeisZ9A+05w27+ETRNtA7jbOrSo+0mTDMd1RgyJziicY8o5Wj2Anq0c9Y7Gq+l9yYWMWoGMKfGAif0h6iBA2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449553; c=relaxed/simple;
	bh=9Y3Nj71EHi/apUGvsPRSVi2+7S7GYrD1WP5eoRv0v5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpMNXFnLPzvT59pmkIUd4remP6AnBjAI7RmuK7GYbsfIdUEuzr7qVHLDyxh5z1ZikA7QzRZzzDTCMAB5DIcTeTvE4jIZOcmyF1wEIYF+VqioFwnwN3z3aZv6KCMwgHTFEV9x8uv1MMlwnWg5FbtNEWzYKWvdcD4NoBthJaR7IOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB9DFEC;
	Wed,  4 Sep 2024 04:32:56 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356413F73F;
	Wed,  4 Sep 2024 04:32:27 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:32:21 +0100
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
Message-ID: <20240904113221.GA3891700@e124191.cambridge.arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
 <20240904102254.GA13280@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102254.GA13280@willie-the-truck>

On Wed, Sep 04, 2024 at 11:22:54AM +0100, Will Deacon wrote:
> On Tue, Sep 03, 2024 at 03:54:13PM +0100, Joey Gouly wrote:
> > On Mon, Sep 02, 2024 at 08:08:08PM +0100, Catalin Marinas wrote:
> > > On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> > > > On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > > > > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > > > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > > > > +{
> > > > > > > > > +	if (!system_supports_poe())
> > > > > > > > > +		return;
> > > > > > > > > +
> > > > > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > > > >
> > > > > > > > nit: typo "chaning".
> > > > > > > >
> > > > > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > > > > context of a new thread using a stale value for POR_EL0?
> > > > > > >
> > > > > > > Not just prevent faults but enforce the permissions from the new
> > > > > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > > > > here, we can't tell.
> > > [...]
> > > > > > So what do we actually gain by having the uaccess routines honour this?
> > > > >
> > > > > I guess where it matters is more like not accidentally faulting because
> > > > > the previous thread had more restrictive permissions.
> > > >
> > > > That's what I wondered initially, but won't the fault handler retry in
> > > > that case?
> > >
> > > Yes, it will retry and this should be fine (I assume you are only
> > > talking about the dropping ISB in the context switch).
> > >
> > > For the case of running with a more permissive stale POR_EL0, arguably it's
> > > slightly more predictable for the user but, OTOH, some syscalls like
> > > readv() could be routed through GUP with no checks. As with MTE, we
> > > don't guarantee uaccesses honour the user permissions.
> > >
> > > That said, at some point we should sanitise this path anyway and have a
> > > single ISB at the end. In the meantime, I'm fine with dropping the ISB
> > > here.
> > >
> > 
> > commit 3141fb86bee8d48ae47cab1594dad54f974a8899
> > Author: Joey Gouly <joey.gouly@arm.com>
> > Date:   Tue Sep 3 15:47:26 2024 +0100
> > 
> >     fixup! arm64: context switch POR_EL0 register
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index a3a61ecdb165..c224b0955f1a 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -515,11 +515,8 @@ static void permission_overlay_switch(struct task_struct *next)
> >                 return;
> > 
> >         current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > -       if (current->thread.por_el0 != next->thread.por_el0) {
> > +       if (current->thread.por_el0 != next->thread.por_el0)
> >                 write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > -               /* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > -               isb();
> > -       }
> >  }
> 
> What about the one in flush_poe()? I'm inclined to drop that as well.

Yes I guess that one can be removed too. Catalin any comments?

> 
> > Will, do you want me to re-send the series with this and the permissions
> > diff from the other thread [1],
> > or you ok with applying them when you pull it in?
> 
> I'll have a crack now, but if it fails miserably then I'll let you know.

Thanks! Just to make sure, you should pick the patch up from

	https://lore.kernel.org/linux-arm-kernel/20240903152937.GA3768522@e124191.cambridge.arm.com/

Not the one I linked to in [1] in my previous e-mail.

Thanks,
Joey

