Return-Path: <linux-fsdevel+bounces-24260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC493C6E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133DF283F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A819DF70;
	Thu, 25 Jul 2024 15:58:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D419D8AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923115; cv=none; b=hRQUAVNuTW3burNuHR/8gNqFXhO1i3+AWLjCfxTBjoHD5ywPzU5udIuvKuxPfhfePzoHe+tWlr9JfwccOixHtXZ6LwxR9JzcZejKTjAtDKoxNARKVOwMLRTeGCq/vw/ozAn1z01s42lCbu/im1wasuTHtPFF/wdjnJKnnmAXpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923115; c=relaxed/simple;
	bh=0EOVQ1Enp2kJ0L8ED7eMM4ocYyUktmXH/A9vPVfLbMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOhE5CbUCRTDo2r60tJZUR4NSjAHm1IIcKEHhgYglIvAg6qEi8w+oodq2XGM9zal9W4OBpjRPllUNrp1NVeGfqLNVuJ0aZ/XTP+uugmYi4rSUulaOdrRxpREBOpJKfECDdwnWR0AQd6WD2QRu29OqZTojBF7U2r/BEZQNV5X67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22CF21007;
	Thu, 25 Jul 2024 08:58:59 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07A83F5A1;
	Thu, 25 Jul 2024 08:58:29 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:58:27 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>

On Mon, Jun 03, 2024 at 02:51:46PM +0530, Amit Daniel Kachhap wrote:
> 
> 
> On 5/31/24 22:09, Mark Brown wrote:
> > On Tue, May 28, 2024 at 12:26:54PM +0530, Amit Daniel Kachhap wrote:
> > > On 5/3/24 18:31, Joey Gouly wrote:
> > 
> > > > +#define POE_MAGIC	0x504f4530
> > > > +struct poe_context {
> > > > +	struct _aarch64_ctx head;
> > > > +	__u64 por_el0;
> > > > +};
> > 
> > > There is a comment section in the beginning which mentions the size
> > > of the context frame structure and subsequent reduction in the
> > > reserved range. So this new context description can be added there.
> > > Although looks like it is broken for za, zt and fpmr context.
> > 
> > Could you be more specific about how you think these existing contexts
> > are broken?  The above looks perfectly good and standard and the
> > existing contexts do a reasonable simulation of working.  Note that the
> > ZA and ZT contexts don't generate data payload unless userspace has set
> > PSTATE.ZA.
> 
> Sorry for not being clear on this as I was only referring to the
> comments in file arch/arm64/include/uapi/asm/sigcontext.h and no code
> as such is broken.
> 
>  * Allocation of __reserved[]:
>  * (Note: records do not necessarily occur in the order shown here.)
>  *
>  *      size            description
>  *
>  *      0x210           fpsimd_context
>  *       0x10           esr_context
>  *      0x8a0           sve_context (vl <= 64) (optional)
>  *       0x20           extra_context (optional)
>  *       0x10           terminator (null _aarch64_ctx)
>  *
>  *      0x510           (reserved for future allocation)
> 
> Here I think that optional context like za, zt, fpmr and poe should have
> size mentioned here to make the description consistent.As you said ZA
> and ZT context are enabled by userspace so some extra details can be
> added for them too.

Regarding this, __reserved[] is looking very full now.

I'll post a draft patch separately, since I think the update could
benefit from separate discussion, but my back-of-the-envelope
calculation suggests that (before this patch) we are down to 0x90
bytes of free space (i.e., over 96% full).


I wonder whether it is time to start pushing back on adding a new
_foo_context for every individual register, though?

Maybe we could add some kind of _misc_context for miscellaneous 64-bit
regs.

[...]

Cheers
---Dave

