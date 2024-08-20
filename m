Return-Path: <linux-fsdevel+bounces-26365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B7958855
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 15:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84902B2197F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36252190696;
	Tue, 20 Aug 2024 13:55:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E31917C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162101; cv=none; b=TKMiAFkJLvWH42g2iBw6BnRaZnEVK5Hpjiq5jhXo4ndLHXaXTWcvXDtHtwSWyCl15f8ZsaJfK7SvNvBYGOnhHk4VweEhCd595ENLOR1gIpg0hfV7D5lL3OMLLm/pF5OvD7NotGf453b4iyZlZq+DA6LZQuEy4YliALfG+HCy0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162101; c=relaxed/simple;
	bh=ZUM3Sw7j7/PudTQ/JnBeZRy7OldTJDX5aMa/HKx7QXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VecRh7sv49m46/I35DNZolMxDIVxIN6rJZppdazghx51WRgbsQ+zc9ZtaZz3rRTDB+5TJ++6DKAZovFDC72DsoB4vffBJl3g1NMucsD83fFZs9ctpz5C3pvdx4dlVbsLyj98CM2wtgzSP8dk1rldzKwH7qP1WrH/dEl1B4b9dfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A545DA7;
	Tue, 20 Aug 2024 06:55:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5460C3F66E;
	Tue, 20 Aug 2024 06:54:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:54:50 +0100
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
Message-ID: <ZsSgKl2JINjdpuW1@e133380.arm.com>
References: <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
 <ZrzHU9et8L_0Tv_B@arm.com>
 <20240815131815.GA3657684@e124191.cambridge.arm.com>
 <Zr4aJqc/ifRXJQAd@e133380.arm.com>
 <ZsN8MnSqIWEMh7Ma@arm.com>
 <20240820095441.GA688664@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820095441.GA688664@e124191.cambridge.arm.com>

On Tue, Aug 20, 2024 at 10:54:41AM +0100, Joey Gouly wrote:
> On Mon, Aug 19, 2024 at 06:09:06PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 15, 2024 at 04:09:26PM +0100, Dave P Martin wrote:
> > > On Thu, Aug 15, 2024 at 02:18:15PM +0100, Joey Gouly wrote:
> > > > That's a lot of words to say, or ask, do you agree with the approach of only
> > > > saving POR_EL0 in the signal frame if num_allocated_pkeys() > 1?
> > > > 
> > > > Thanks,
> > > > Joey
> > > 
> > > ...So..., given all the above, it is perhaps best to go back to
> > > dumping POR_EL0 unconditionally after all, unless we have a mechanism
> > > to determine whether pkeys are in use at all.
> > 
> > Ah, I can see why checking for POR_EL0_INIT is useful. Only checking for
> > the allocated keys gets confusing with pkey 0.
> > 
> > Not sure what the deal is with pkey 0. Is it considered allocated by
> > default or unallocatable? If the former, it implies that pkeys are
> > already in use (hence the additional check for POR_EL0_INIT). In
> > principle the hardware allows us to use permissions where the pkeys do
> > not apply but we'd run out of indices and PTE bits to encode them, so I
> > think by default we should assume that pkey 0 is pre-allocated.
> > 
> > 
> 
> You can consider pkey 0 allocated by default. You can actually pkey_free(0), there's nothing stopping that.

Is that intentional?

You're not supposed to free pkeys that are in use, and it's quasi-
impossible to know whether pkey 0 is in use: all binaries in the
process assume that pkey is available and use it by default for their
pages, plus the stack will be painted with pkey 0, and the vDSO has to
be painted with some pkey.

Actually, that's a good point, because of the vDSO I think that only
special bits of code with a private ABI (e.g., JITted code etc.) that
definitely don't call into the vDSO can block permissions on pkey 0...
otherwise, stuff will break.

> 
> > So I agree that it's probably best to save it unconditionally.
> 
> Alright, will leave it as is!

Ack, I think the whole discussion around this has shown that there
isn't a _simple_ argument for conditionally dumping POR_EL0... so I'm
prepared to admit defeat here.

We might still try to slow down the consumption of the remaining space
with a "misc registers" record, instead of dedicating a record to
POR_EL0.  I have some thoughts on that, but if nobody cares that much
then this probably isn't worth pursuing.

Cheers
---Dave

