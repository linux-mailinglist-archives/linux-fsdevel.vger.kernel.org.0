Return-Path: <linux-fsdevel+bounces-31908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD499D557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034AA1C23142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002D1C32FE;
	Mon, 14 Oct 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZuGXBvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E071C3043;
	Mon, 14 Oct 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925831; cv=none; b=jAWd9hWdu+nD6kkA8y+sjdu/zLMQSigvN5DsKDKq/uft6j60j8yXz7sZB6qwNYOkoEjwrx+ZChQUJ1R6w9wj5bYVXSwT+MPyF2P/Ivm0FW4J7ln7boxI5EQEbwToxOZfSkIFTl0Lnk+vw+rRM0YTJlEWFxB2ueIyRWmBjLEGLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925831; c=relaxed/simple;
	bh=iLl0lXkXeALAMr5KDjF+8vkYFyZnHpji9UAQw4I8NLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld6kisKV+KGqo+BXNqB61tMsmjXeGDPFYFW++iBXJGaGHqBmXaeCxahyFbsrpuffq/4Y5z9C9m2BHzrUs9SdlCdXPS8ug5Fy1/zMqG3lTZObZjZ1hmJCXOQNkEH/VKBaauVZaAJ6rlQcvq1cJC7Iy8CcZp7IV0ejFD3XUuu8yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZuGXBvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932D4C4CEC3;
	Mon, 14 Oct 2024 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925831;
	bh=iLl0lXkXeALAMr5KDjF+8vkYFyZnHpji9UAQw4I8NLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZuGXBvfqai+/3NsOa9W9cD3IlOY9aT3U0WbINyOpuWErGCK6ZB6IOUBzMOrcOcny
	 pu72RD2Q/eOijBUJKudsa5AgJol2pWXeoLojf4MNniYLbSJgH2kEtVhDGVb6Gm14Df
	 9EGatG41Z1BUkjfjmG1t0dtC3E9OVP/UsR4ZXtN7/cC9OYFti03Mmwc+YQYgMcx9FF
	 id1TyF5286pt2Y3czQbj/ZxkcUQEN2KJW1lxao1NLV3WYoMqD/KKpW+g9w8uWA2Aqn
	 /L7Px0nG8PKBofrF7r6MreT7d1B0i8Jz1iBY6w6RO2ZAzUeeOvYCehz+aQLkdHLfpI
	 KopOxy2RDs1Dw==
Date: Mon, 14 Oct 2024 18:10:23 +0100
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
Message-ID: <20241014171023.GA18295@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009144301.GA12453@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kevin, Joey,

On Wed, Oct 09, 2024 at 03:43:01PM +0100, Will Deacon wrote:
> On Tue, Sep 24, 2024 at 01:27:58PM +0200, Kevin Brodsky wrote:
> > On 22/08/2024 17:11, Joey Gouly wrote:
> > > @@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> > >  		sme_smstop();
> > >  	}
> > >  
> > > +	if (system_supports_poe())
> > > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> > 
> > At the point where setup_return() is called, the signal frame has
> > already been written to the user stack. In other words, we write to the
> > user stack first, and then reset POR_EL0. This may be problematic,
> > especially if we are using the alternate signal stack, which the
> > interrupted POR_EL0 may not grant access to. In that situation uaccess
> > will fail and we'll end up with a SIGSEGV.
> > 
> > This issue has already been discussed on the x86 side, and as it happens
> > patches to reset PKRU early [1] have just landed. I don't think this is
> > a blocker for getting this series landed, but we should try and align
> > with x86. If there's no objection, I'm planning to work on a counterpart
> > to the x86 series (resetting POR_EL0 early during signal delivery).
> 
> Did you get a chance to work on that? It would be great to land the
> fixes for 6.12, if possible, so that the first kernel release with POE
> support doesn't land with known issues.

Looking a little more at this, I think we have quite a weird behaviour
on arm64 as it stands. It looks like we rely on the signal frame to hold
the original POR_EL0 so, if for some reason we fail to allocate space
for the POR context, I think we'll return back from the signal with
POR_EL0_INIT. That seems bad?

Will

