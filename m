Return-Path: <linux-fsdevel+bounces-26357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D5E958348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E345F285C9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875D18C01C;
	Tue, 20 Aug 2024 09:54:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8814A0A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147691; cv=none; b=t7N88J1/JPFzzp4ayX6Syer9OosMmFn+Ovq34SmViZgAkrdMbW3f2imIoqaTQfM4I1bx8l8MNeQf+sMoVQeZqv3V+N/3ISwNVdoca9wJuwH3GoUekP/OVn4EnGaxeyYQdEDktAO0X+tP3Wie3W5xMlf6gUpjR7jMHSGXyZhmgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147691; c=relaxed/simple;
	bh=Xsq0jN/Nr+6zUwRCip9WuKjFgEPV9fhR9Eb321ulRpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfENZBE7JrAJoxcHwqn9OE1cWhmsOGHMarYIBR2pDB+qciAolZrdudCAL/axYYKX7XNZgDSPioUM71H1azsfasiyStDr3yN5daQMR9kg32E5PJJrE/9UN7TrKJPfjck/Mcz2+4tnWDrB/eHD9P1yMXNBz2u/ElseUSAO2D0Y+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B44DA7;
	Tue, 20 Aug 2024 02:55:15 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 532323F66E;
	Tue, 20 Aug 2024 02:54:46 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:54:41 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <20240820095441.GA688664@e124191.cambridge.arm.com>
References: <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
 <ZrzHU9et8L_0Tv_B@arm.com>
 <20240815131815.GA3657684@e124191.cambridge.arm.com>
 <Zr4aJqc/ifRXJQAd@e133380.arm.com>
 <ZsN8MnSqIWEMh7Ma@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsN8MnSqIWEMh7Ma@arm.com>

On Mon, Aug 19, 2024 at 06:09:06PM +0100, Catalin Marinas wrote:
> On Thu, Aug 15, 2024 at 04:09:26PM +0100, Dave P Martin wrote:
> > On Thu, Aug 15, 2024 at 02:18:15PM +0100, Joey Gouly wrote:
> > > That's a lot of words to say, or ask, do you agree with the approach of only
> > > saving POR_EL0 in the signal frame if num_allocated_pkeys() > 1?
> > > 
> > > Thanks,
> > > Joey
> > 
> > ...So..., given all the above, it is perhaps best to go back to
> > dumping POR_EL0 unconditionally after all, unless we have a mechanism
> > to determine whether pkeys are in use at all.
> 
> Ah, I can see why checking for POR_EL0_INIT is useful. Only checking for
> the allocated keys gets confusing with pkey 0.
> 
> Not sure what the deal is with pkey 0. Is it considered allocated by
> default or unallocatable? If the former, it implies that pkeys are
> already in use (hence the additional check for POR_EL0_INIT). In
> principle the hardware allows us to use permissions where the pkeys do
> not apply but we'd run out of indices and PTE bits to encode them, so I
> think by default we should assume that pkey 0 is pre-allocated.
> 
> 

You can consider pkey 0 allocated by default. You can actually pkey_free(0), there's nothing stopping that.

> So I agree that it's probably best to save it unconditionally.

Alright, will leave it as is!

Thanks,
Joey

