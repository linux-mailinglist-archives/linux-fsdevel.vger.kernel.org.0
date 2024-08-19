Return-Path: <linux-fsdevel+bounces-26283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE8957197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131A51F22855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631B1741F8;
	Mon, 19 Aug 2024 17:09:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA33FEC;
	Mon, 19 Aug 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087353; cv=none; b=Q4Skk3B3OQbqoWYc7oLT3Lgo8M4MmC7VOfwe2my09rlPwOho/PfOpQLj4yvyn8AxeJCtUmoxxSiktaLAchNBMffg1B1BkX4V/LXNNVGYxE8k4nKNz3c4bXQ9r5Y3+lKTKz1su7OhPtcH4iTIPEq+Aai08vgiLKRxhP/itnYxiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087353; c=relaxed/simple;
	bh=tJD8iYqoav6OGFnS3050ksXE14pyLpasnKlZxgo6l90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNvprpHU33S+kueVnU5OxO035vICqRp2zoTS+b6vRmNaEzXtr+VMQKXNI0B+wE/PgLyckMQ8UM0EqDKhi6w9sN9bqsl+w0cQ3e1NE/QAt/LoRKYK7j0PgNXrPmg+72rV5QmMi51qD7lY6dz47/7mhoL/QcacwMmYUYicW5bD++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FABC4AF0E;
	Mon, 19 Aug 2024 17:09:09 +0000 (UTC)
Date: Mon, 19 Aug 2024 18:09:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <ZsN8MnSqIWEMh7Ma@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
 <ZrzHU9et8L_0Tv_B@arm.com>
 <20240815131815.GA3657684@e124191.cambridge.arm.com>
 <Zr4aJqc/ifRXJQAd@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr4aJqc/ifRXJQAd@e133380.arm.com>
X-TUID: jP0NMMmVUuyc

On Thu, Aug 15, 2024 at 04:09:26PM +0100, Dave P Martin wrote:
> On Thu, Aug 15, 2024 at 02:18:15PM +0100, Joey Gouly wrote:
> > That's a lot of words to say, or ask, do you agree with the approach of only
> > saving POR_EL0 in the signal frame if num_allocated_pkeys() > 1?
> > 
> > Thanks,
> > Joey
> 
> ...So..., given all the above, it is perhaps best to go back to
> dumping POR_EL0 unconditionally after all, unless we have a mechanism
> to determine whether pkeys are in use at all.

Ah, I can see why checking for POR_EL0_INIT is useful. Only checking for
the allocated keys gets confusing with pkey 0.

Not sure what the deal is with pkey 0. Is it considered allocated by
default or unallocatable? If the former, it implies that pkeys are
already in use (hence the additional check for POR_EL0_INIT). In
principle the hardware allows us to use permissions where the pkeys do
not apply but we'd run out of indices and PTE bits to encode them, so I
think by default we should assume that pkey 0 is pre-allocated.

So I agree that it's probably best to save it unconditionally.

-- 
Catalin

