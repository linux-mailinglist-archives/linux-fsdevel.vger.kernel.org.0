Return-Path: <linux-fsdevel+bounces-28543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A0396BB23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A86C282D56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52E1D3658;
	Wed,  4 Sep 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDOCm13e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BE1D2237;
	Wed,  4 Sep 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450190; cv=none; b=giMzWq4ewh2p1WL+vwmbw8rtla9WscZVticSGjvydjYARzziElMS4oN36nuXMadQxAaBpnrgSbkiMwCAG4r13wTyoJ48GgMwVBcP6dDi560BhscZ0mlHjFAGWOE2g5yB924AIZCQHKCffoDWwOUJuwVPwplV0/yWAR4wDrhwJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450190; c=relaxed/simple;
	bh=1R47JLECqfMcUivgiQR6XDvQF6Jb0RlGzKzhZ5bCKsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTThaGy3eXkcnipP0ChqXd+RxjWvYdYTB17y5CiFyiEHdOAp7IHLxo5e7IxmIi2oK+Bg8QWQMRLcfKymUsyD3XrwgXcZT3KRPK5fjUUZEdVUOTFxe9xcG2VJS54B9HVt9+7Hb/0Zx3PKFmy+xySZdQqAxBi4Su4p3xKQtjhYzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDOCm13e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2318C4CEC2;
	Wed,  4 Sep 2024 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725450190;
	bh=1R47JLECqfMcUivgiQR6XDvQF6Jb0RlGzKzhZ5bCKsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDOCm13euF7DxBt8JcfDA8RsjG4MZJhZ27+NJPvRYOHFOIFVEJc0l6JGicavkhqFp
	 ocM/Hc7Ei/JeuUSqdamuIxsSmM5JmLH2Z52OgD5iztKVCIjp7sX8PLLUEu9j6MPmCH
	 BYX7tb0KyzLaSS647l0ocymi+ZWWv+J7JXsEwNWQp+rJTW0T0DXaaa93jW3QN9FGLb
	 biQUrzgmKdTHsim1RB78jWVNvmDQb4gv4JOoem65A64jZ/hpremFoloDb9L+1PbLXL
	 pOr5XcN9nzcv5FCk0AbNAEX4DfKr02w9IdPgHqDsgUC/Z58ctJv9XU8IOftgkkb4Yv
	 RQfwAY8aQDCkA==
Date: Wed, 4 Sep 2024 12:43:02 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
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
Message-ID: <20240904114301.GA13550@willie-the-truck>
References: <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
 <20240904102254.GA13280@willie-the-truck>
 <20240904113221.GA3891700@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904113221.GA3891700@e124191.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 04, 2024 at 12:32:21PM +0100, Joey Gouly wrote:
> On Wed, Sep 04, 2024 at 11:22:54AM +0100, Will Deacon wrote:
> > On Tue, Sep 03, 2024 at 03:54:13PM +0100, Joey Gouly wrote:
> > > On Mon, Sep 02, 2024 at 08:08:08PM +0100, Catalin Marinas wrote:
> > > > On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> > > > > On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > > > > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > > > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > > > > > +{
> > > > > > > > > > +	if (!system_supports_poe())
> > > > > > > > > > +		return;
> > > > > > > > > > +
> > > > > > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > > > > >
> > > > > > > > > nit: typo "chaning".
> > > > > > > > >
> > > > > > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > > > > > context of a new thread using a stale value for POR_EL0?
> > > > > > > >
> > > > > > > > Not just prevent faults but enforce the permissions from the new
> > > > > > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > > > > > here, we can't tell.
> > > > [...]
> > > > > > > So what do we actually gain by having the uaccess routines honour this?
> > > > > >
> > > > > > I guess where it matters is more like not accidentally faulting because
> > > > > > the previous thread had more restrictive permissions.
> > > > >
> > > > > That's what I wondered initially, but won't the fault handler retry in
> > > > > that case?
> > > >
> > > > Yes, it will retry and this should be fine (I assume you are only
> > > > talking about the dropping ISB in the context switch).
> > > >
> > > > For the case of running with a more permissive stale POR_EL0, arguably it's
> > > > slightly more predictable for the user but, OTOH, some syscalls like
> > > > readv() could be routed through GUP with no checks. As with MTE, we
> > > > don't guarantee uaccesses honour the user permissions.
> > > >
> > > > That said, at some point we should sanitise this path anyway and have a
> > > > single ISB at the end. In the meantime, I'm fine with dropping the ISB
> > > > here.
> > > >
> > > 
> > > commit 3141fb86bee8d48ae47cab1594dad54f974a8899
> > > Author: Joey Gouly <joey.gouly@arm.com>
> > > Date:   Tue Sep 3 15:47:26 2024 +0100
> > > 
> > >     fixup! arm64: context switch POR_EL0 register
> > > 
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index a3a61ecdb165..c224b0955f1a 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -515,11 +515,8 @@ static void permission_overlay_switch(struct task_struct *next)
> > >                 return;
> > > 
> > >         current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > -       if (current->thread.por_el0 != next->thread.por_el0) {
> > > +       if (current->thread.por_el0 != next->thread.por_el0)
> > >                 write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > -               /* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > -               isb();
> > > -       }
> > >  }
> > 
> > What about the one in flush_poe()? I'm inclined to drop that as well.
> 
> Yes I guess that one can be removed too. Catalin any comments?
> 
> > 
> > > Will, do you want me to re-send the series with this and the permissions
> > > diff from the other thread [1],
> > > or you ok with applying them when you pull it in?
> > 
> > I'll have a crack now, but if it fails miserably then I'll let you know.
> 
> Thanks! Just to make sure, you should pick the patch up from
> 
> 	https://lore.kernel.org/linux-arm-kernel/20240903152937.GA3768522@e124191.cambridge.arm.com/
> 
> Not the one I linked to in [1] in my previous e-mail.

Right, there's quite a lot I need to do:

- Uncorrupt your patches
- Fix the conflict in the kvm selftests
- Drop the unnecessary ISBs
- Fix the ESR checking
- Fix the el2_setup labels
- Reorder the patches
- Drop the patch that is already in kvmarm

Working on it...

Will

