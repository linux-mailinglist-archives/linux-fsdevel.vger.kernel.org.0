Return-Path: <linux-fsdevel+bounces-28532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C196B848
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2330F1F21450
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70191CF5DB;
	Wed,  4 Sep 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFuWolvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2031CF5C3;
	Wed,  4 Sep 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445383; cv=none; b=gmqrYjuWSRgiLiUx07PDSs8ZWy1zUIH76bUNraqXt3vjNYoLbIJpnqNK19s63BmKJgpXl8nlEl8X+p9ENa4J5nMkyKE3vH569Ef5Vr6SYowIcqKdFrVZdRfB98hiiPlpFctccZqy55BI3CbXc6cdU/9UE7gSdmEvsoEiiZqF9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445383; c=relaxed/simple;
	bh=x6g+EMj9hEE7gJBznAvd51VhitMf4AGn6YNEwakOXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJxgnYI4acjk65mV/L8gHpuQ+EwBudAvI7GlTUTYff+T5DkA5XyUMvEOwyAY2hKVFuLDfY+IvpKsCfozoXj0On4kz18F0Hbqz6Qyou2daupbQEkhKX8Nh3EgFEVV1vx7Cs3RG6fYKj7gOs6r2WfqqokdC3wOyluXwF5TrVZS+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFuWolvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FEC4CEC6;
	Wed,  4 Sep 2024 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445382;
	bh=x6g+EMj9hEE7gJBznAvd51VhitMf4AGn6YNEwakOXnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFuWolvohOrzFjBimZJsYPU40a03g6/+mE8Mf5MyAP+BtHCQ04YOEk3qScOLHFauH
	 LHvXml9pB5vCkZObjlHtsowepQgfnDM0ZXqIYnHwqg+RVtgRYP0PCfrbaEsNTbu9Nf
	 LklDAmkyWdjN4wkHFRPAcV7LSz7OKTnxR4MAvSHC0x1f8PBWRcwOlhLJ2k0w14koAs
	 86Fgnm5u0+u999x7MXvWytZryAmoTWHrymaEp+DTUrlT1oUzsmEaY8g7A2F/gyuSgW
	 0TSCRY37gyHXmyfic0kLPzDjGO4QFwgv25bixlW6H66a5BOAIPiZ0AZR+kAufu8J+E
	 maWhiRUgAL2EA==
Date: Wed, 4 Sep 2024 11:22:54 +0100
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
Message-ID: <20240904102254.GA13280@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903145413.GB3669886@e124191.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Sep 03, 2024 at 03:54:13PM +0100, Joey Gouly wrote:
> On Mon, Sep 02, 2024 at 08:08:08PM +0100, Catalin Marinas wrote:
> > On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> > > On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > > > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > > > +{
> > > > > > > > +	if (!system_supports_poe())
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > > >
> > > > > > > nit: typo "chaning".
> > > > > > >
> > > > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > > > context of a new thread using a stale value for POR_EL0?
> > > > > >
> > > > > > Not just prevent faults but enforce the permissions from the new
> > > > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > > > here, we can't tell.
> > [...]
> > > > > So what do we actually gain by having the uaccess routines honour this?
> > > >
> > > > I guess where it matters is more like not accidentally faulting because
> > > > the previous thread had more restrictive permissions.
> > >
> > > That's what I wondered initially, but won't the fault handler retry in
> > > that case?
> >
> > Yes, it will retry and this should be fine (I assume you are only
> > talking about the dropping ISB in the context switch).
> >
> > For the case of running with a more permissive stale POR_EL0, arguably it's
> > slightly more predictable for the user but, OTOH, some syscalls like
> > readv() could be routed through GUP with no checks. As with MTE, we
> > don't guarantee uaccesses honour the user permissions.
> >
> > That said, at some point we should sanitise this path anyway and have a
> > single ISB at the end. In the meantime, I'm fine with dropping the ISB
> > here.
> >
> 
> commit 3141fb86bee8d48ae47cab1594dad54f974a8899
> Author: Joey Gouly <joey.gouly@arm.com>
> Date:   Tue Sep 3 15:47:26 2024 +0100
> 
>     fixup! arm64: context switch POR_EL0 register
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a3a61ecdb165..c224b0955f1a 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -515,11 +515,8 @@ static void permission_overlay_switch(struct task_struct *next)
>                 return;
> 
>         current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> -       if (current->thread.por_el0 != next->thread.por_el0) {
> +       if (current->thread.por_el0 != next->thread.por_el0)
>                 write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> -               /* ISB required for kernel uaccess routines when chaning POR_EL0 */
> -               isb();
> -       }
>  }

What about the one in flush_poe()? I'm inclined to drop that as well.

> Will, do you want me to re-send the series with this and the permissions
> diff from the other thread [1],
> or you ok with applying them when you pull it in?

I'll have a crack now, but if it fails miserably then I'll let you know.

Will

