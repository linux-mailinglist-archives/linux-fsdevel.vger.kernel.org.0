Return-Path: <linux-fsdevel+bounces-31450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DAB996E75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450E21C2335F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031E1A2541;
	Wed,  9 Oct 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxAi7gMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EC19AD86;
	Wed,  9 Oct 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484991; cv=none; b=dbJ3PKSMffEWprAIMpiu1FJ5F/tLqlnBGmnbSne6Nc74CZ7jNj5GgCSfsvcm3sFRBmpO2YqS1bb//FAXB3yhxaLBABKWwM2AHAJR9WiQlHMwYKV8VRQc6zJchnmK8j12nvTSZymJzXpJewy0962ZkgmxnEkYD4cgNoL7d1wvkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484991; c=relaxed/simple;
	bh=ghDXhJ8N/Fq5uvX13sqCHmKOKO+si/SzPYqkee2gkCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbwVcWmEyWsTGU6TwRh7rkeBcCn9IYPZFKTXBX1UAYIFHk/vfdQu1W7tVyYCj1GrXDxljGDA2Q5qprfEh34c7tPMYn+CNr3mIbN0acaRmrNZV4NFEqYtlgwuOtFbNaPn2Koitla3G1xxZPWV8cj+xqyH432AZAB2KLziHYA+Z3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxAi7gMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DCBC4CEC3;
	Wed,  9 Oct 2024 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728484990;
	bh=ghDXhJ8N/Fq5uvX13sqCHmKOKO+si/SzPYqkee2gkCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxAi7gMooCiJGqGzS0LWH7kBxoZwHJn5xIZ5q0R7f2JFhjQ8vFEszC3neoypcep6A
	 T04nDesXSfu08Vf9+sA3K4h/yiH8T7lKmbtsmltNb0rLX7hIshVw4gzVgAfVGilHON
	 T0lVRGhKcASYRRGMfUFMkMr67ctpsruVmTf/b0/87df+LAofBUCNmmbLqvjK7vPZ2k
	 kspRbAd1hTXLUznLCT2elteYkVFC35t8ffslqZHPDDQVxJc3HWCIAs7chSvJU/deEg
	 YmHhdQwxG3GwSOPLrsvvcQZQ+tHMwtBNb7AHKPREGF1DC1YOwPzF+LLL9SFcA8W16M
	 a061/KbZx2orA==
Date: Wed, 9 Oct 2024 15:43:02 +0100
From: Will Deacon <will@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
Message-ID: <20241009144301.GA12453@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Kevin,

On Tue, Sep 24, 2024 at 01:27:58PM +0200, Kevin Brodsky wrote:
> On 22/08/2024 17:11, Joey Gouly wrote:
> > @@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >  		sme_smstop();
> >  	}
> >  
> > +	if (system_supports_poe())
> > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> 
> At the point where setup_return() is called, the signal frame has
> already been written to the user stack. In other words, we write to the
> user stack first, and then reset POR_EL0. This may be problematic,
> especially if we are using the alternate signal stack, which the
> interrupted POR_EL0 may not grant access to. In that situation uaccess
> will fail and we'll end up with a SIGSEGV.
> 
> This issue has already been discussed on the x86 side, and as it happens
> patches to reset PKRU early [1] have just landed. I don't think this is
> a blocker for getting this series landed, but we should try and align
> with x86. If there's no objection, I'm planning to work on a counterpart
> to the x86 series (resetting POR_EL0 early during signal delivery).

Did you get a chance to work on that? It would be great to land the
fixes for 6.12, if possible, so that the first kernel release with POE
support doesn't land with known issues.

Cheers,

Will

