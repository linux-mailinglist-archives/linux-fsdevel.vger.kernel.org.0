Return-Path: <linux-fsdevel+bounces-27999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9B965CC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0563F28144E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207B170A0B;
	Fri, 30 Aug 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8NjdEMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36652171E7C;
	Fri, 30 Aug 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009936; cv=none; b=XWA2/LSfvOICZOiwQ8hIfaZqhcjP8HVCARsYeMiihRt49EjAoPDAME2+Fh3iYG+olrbB0lN+mx5xDjDJBk/rALHJZC9LCjyrSnaixGuKWDBJbCog0FoibT9HMaanOL69FcbNb74aDSkZOLHXwDLS876ntVsw2KGSnZ/1WrBdI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009936; c=relaxed/simple;
	bh=4b/zMYknwobEnyHKkZkbn67H7Flf1WVrIa0s9HJwUG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8K0I42ky1kC2JirnoEAkpbRT9i4Zbh3kAyTPjN0MjmWn5w1Xkg5cSSji5uBH9RzvNZhs2lbLtJzr67eL70qA5zsJPhtO/Dabg224lt8RucPTDN2/rdd0wqGni04CvpOYy6auDpolxILeRql+VEuZlfc7xnK10qzAFDFz4RrvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8NjdEMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F71C4CEC2;
	Fri, 30 Aug 2024 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725009935;
	bh=4b/zMYknwobEnyHKkZkbn67H7Flf1WVrIa0s9HJwUG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8NjdEMu5r+VI7StBduEi/6GUvhVsXznHU1xpzq2XbPyWMKXKQBHllqIkcB0UaMND
	 ihsmQx9HE+JAExU2+qdjxM386lLDqSOkew7A5iaI42P88/kS3EgtmsCgdIWn5ckkpx
	 giMV7lxDe+9KBdksZOHR58U6pXP8zUQTQkS3P8M+kbYK2gWg4wCGoGjlxqpPYZ2yHq
	 OQKM5G1waKsz4liaBqLFJTafS1OL8sVz75X2YfdDeZE8l6s3wENoMymiwW2yaPXmxi
	 6Lm3i6DC34S6aqreSv8X9hZ8vDo+hmlE7pJR0SJSU5TSguPNtjj1GzlQMioJzqBBxI
	 rNmEZ24BSvxYw==
Date: Fri, 30 Aug 2024 10:25:27 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/30] KVM: arm64: make kvm_at() take an OP_AT_*
Message-ID: <20240830092527.GB7678@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-9-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822151113.1479789-9-joey.gouly@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 22, 2024 at 04:10:51PM +0100, Joey Gouly wrote:
> To allow using newer instructions that current assemblers don't know about,
> replace the `at` instruction with the underlying SYS instruction.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h       | 3 ++-
>  arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

> diff --git arch/arm64/include/asm/kvm_asm.h arch/arm64/include/asm/kvm_asm.h
> index 2181a11b9d92..38d7bfa3966a 100644
> --- arch/arm64/include/asm/kvm_asm.h
> +++ arch/arm64/include/asm/kvm_asm.h

FWIW (mainly for Marc): you seem to be missing the 'a/' and 'b/'
prefixes here, so my git would't accept the change when I tried to
apply locally for testing.

Will

