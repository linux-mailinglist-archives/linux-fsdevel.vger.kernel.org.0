Return-Path: <linux-fsdevel+bounces-20643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C68D65A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313AF28B10A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27962B9CE;
	Fri, 31 May 2024 15:21:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DB29A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168909; cv=none; b=JerJHSua33Hhk9F0ZjA/M2njwtW0j5skRuJPT14axGEN2EkYObPbORR+xkbpqkWZfdwiGbryxrArB7UYX2qAynUQIHWKxVBpvD+IrLSskqKrHRWpVinUAWljRLax/ffQ//0O/qKSKY0PpmrFUenJswDKRZlFYvZcZsDV2DER5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168909; c=relaxed/simple;
	bh=6tkFTIkMXaIqV5pXYi60ue+41zjgXhfYoh1WY9sqHTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjhC+b5tmCMWR+MeJSjbmyiLPsLPj7/NIF8pMIEf7LexRaundkOF1akq0RB55GpEHzGIS3kqfN6NOhEIPGS2EA7AMokbsdESMEutUWlDb8/DKYzLUoUyEPpXXI8HcD0MdAfLvzqWVaS0Fue7o3+Mu5/5gW3l6jEVYT3dAFfbv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4BD1424;
	Fri, 31 May 2024 08:22:11 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31AA63F641;
	Fri, 31 May 2024 08:21:44 -0700 (PDT)
Date: Fri, 31 May 2024 16:21:38 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>, dave.hansen@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <20240531152138.GA1805682@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <ZlnlQ/avUAuSum5R@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnlQ/avUAuSum5R@arm.com>

Hi Szabolcs,

On Fri, May 31, 2024 at 03:57:07PM +0100, Szabolcs Nagy wrote:
> The 05/03/2024 14:01, Joey Gouly wrote:
> > Implement the PKEYS interface, using the Permission Overlay Extension.
> ...
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
> > +{
> > +	u64 new_por = POE_RXW;
> > +	u64 old_por;
> > +	u64 pkey_shift;
> > +
> > +	if (!arch_pkeys_enabled())
> > +		return -ENOSPC;
> > +
> > +	/*
> > +	 * This code should only be called with valid 'pkey'
> > +	 * values originating from in-kernel users.  Complain
> > +	 * if a bad value is observed.
> > +	 */
> > +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> > +		return -EINVAL;
> > +
> > +	/* Set the bits we need in POR:  */
> > +	if (init_val & PKEY_DISABLE_ACCESS)
> > +		new_por = POE_X;
> > +	else if (init_val & PKEY_DISABLE_WRITE)
> > +		new_por = POE_RX;
> > +
> 
> given that the architecture allows r,w,x permissions to be
> set independently, should we have a 'PKEY_DISABLE_EXEC' or
> similar api flag?
> 
> (on other targets it can be some invalid value that fails)

I didn't think about the best way to do that yet. PowerPC has a PKEY_DISABLE_EXECUTE.

We could either make that generic, and X86 has to error if it sees that bit, or
we add a arch-specific PKEY_DISABLE_EXECUTE like PowerPC.

A user can still set it by interacting with the register directly, but I guess
we want something for the glibc interface..

Dave, any thoughts here?

> 
> > +	/* Shift the bits in to the correct place in POR for pkey: */
> > +	pkey_shift = pkey * POR_BITS_PER_PKEY;
> > +	new_por <<= pkey_shift;
> > +
> > +	/* Get old POR and mask off any old bits in place: */
> > +	old_por = read_sysreg_s(SYS_POR_EL0);
> > +	old_por &= ~(POE_MASK << pkey_shift);
> > +
> > +	/* Write old part along with new part: */
> > +	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
> > +
> > +	return 0;
> > +}
> > +#endif

Thanks,
Joey

