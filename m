Return-Path: <linux-fsdevel+bounces-28541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A288596BAEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D341289C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98B522F;
	Wed,  4 Sep 2024 11:38:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809D146A7A;
	Wed,  4 Sep 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449893; cv=none; b=CM9z+3ykBJRr+DfNkHiu7ssR+qX7YYI3uHwsTjhkLomaMFNq6hs8dVkvyOvynbwuHws93Djf/SixtS6J9BzaGR7JKqJIiGOArPOwtpvisuboI+OyYufKYI0dJmp4+Q/iapMhroL61k7+NiRGlEw/45JzDh0G9wSpneADrZFeqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449893; c=relaxed/simple;
	bh=dGZ5cpThAXtBsU03hSCLVoS4EpyGsm5b2NBao6fU/CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoRPzuIGoANGd03hLQ2XkuPMzwlSjWYj75uGJ4ISdvZQGSt+o5f69tGDcoSkkMuC4hMHBRCAvD4ktuxJYcdSq4f6SaMXbnmt7raKl7dcYrBMe7YtsLirmHuC0prsRgY4GG5ooCDDPypAajSctACqkNPfZTch/TT8p4XjWQj4Bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4212C4CEC2;
	Wed,  4 Sep 2024 11:38:07 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:38:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
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
Message-ID: <ZthGnTz8wlcy4ncK@arm.com>
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

Yes, that's a similar thing.

-- 
Catalin

