Return-Path: <linux-fsdevel+bounces-24256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A493C6C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C58AB237E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160819D89E;
	Thu, 25 Jul 2024 15:48:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE719B5BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922530; cv=none; b=crnzU0SWvKlAkC//4XPkA+qPWxblxCMkW9ku+mSBaxtbV0XFKU7pin7P7pPj236BmPUaWHDx2QkvMTfnROGQVFd2t/oj7iuSe3T54pf+XeFNUsG+vdGGh8nPPTSQ5LUHIPgXkLCMydkfaZp3Q+TP4lGkxnMW9XOurFdlLyFrke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922530; c=relaxed/simple;
	bh=9veYD6Cw20WWIP5a5rcYdQynxeXuIU3pwTIEVcyvAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0dc2DLgJTVg7zggdeie00RSuuMVKNAwTx+NA+cycYDK+UPBuG1Nh9qRRr/vqSc6BEBs0SSetrrrWARh+Qw3x1olBsP3DwjL7lz4pRXwfa+F9unib+jak0UHPkVmo5f3EiPrhCa4oO5Bd/VB1+5XrlfwqFIcuvxvqOl/7fJv8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78FD21476;
	Thu, 25 Jul 2024 08:49:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FA393F766;
	Thu, 25 Jul 2024 08:48:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:48:41 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 19/29] arm64: enable PKEY support for CPUs with S1POE
Message-ID: <ZqJz2S4MDjDmKzJE@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-20-joey.gouly@arm.com>
 <fe3ccf1e-4c57-4795-add3-1eb47f3bdcaa@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3ccf1e-4c57-4795-add3-1eb47f3bdcaa@arm.com>

On Tue, Jul 16, 2024 at 04:17:12PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/3/24 18:31, Joey Gouly wrote:
> > Now that PKEYs support has been implemented, enable it for CPUs that
> > support S1POE.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> > ---
> >  arch/arm64/include/asm/pkeys.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> > index a284508a4d02..3ea928ec94c0 100644
> > --- a/arch/arm64/include/asm/pkeys.h
> > +++ b/arch/arm64/include/asm/pkeys.h
> > @@ -17,7 +17,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> >  
> >  static inline bool arch_pkeys_enabled(void)
> >  {
> > -	return false;
> > +	return system_supports_poe();
> >  }
> >  
> >  static inline int vma_pkey(struct vm_area_struct *vma)
> 
> Small nit. Would it better to be consistently using system_supports_poe()
> helper rather than arch_pkeys_enabled() inside arch/arm64/ platform code
> like - during POE fault handling i.e inside fault_from_pkey().
> 

(FWIW, arch_pkeys_enabled() looks like the hook for the arch to tell
the pkeys generic code whether the arch support is there, so I guess
the proposed change looks sensible to me.

For the arch backend code that is agnostic to whether pkeys is actually
in use, system_supports_poe() seems to be the more appropriate check.)

Cheers
---Dave

