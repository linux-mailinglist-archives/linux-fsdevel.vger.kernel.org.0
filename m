Return-Path: <linux-fsdevel+bounces-23757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D09327C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BE91F22E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473919B3F6;
	Tue, 16 Jul 2024 13:46:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1F19B3F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137595; cv=none; b=kYLkeuomwN6e9WjwHKJQw0AIi//ZVdwpYTmUKQIey87KU9wVrC2mKbcjAV9p4PlZ8Fj6WlvJLhAUh0IkiXCEOBtr+dJeFQsSgwWgUqZytKufxroyCn4A5kuFrMu1MnSb3c9565WO9vwOaGXgV3YceRs4THtjg0TYhzd+DvfJQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137595; c=relaxed/simple;
	bh=qYjW4Kn4qbkBleG/y2fdt93Mza45Gs5HV/WppfbUZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIEi61YEQAgAfn3fAWC4OIypsh4twMxI/3by4IZ/tNo1w3vMeuQdU/Y5VPZpUKmPNc2aMi4AWUw7Cg+39bPLF7qTvlGES69n/mCGnXh+UGqRExwxPTJGKO51wrSDxlGFtS3lL/76geq7btRMKNn9BdMuxR+ftAe6VCe3HGblcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E4D1063;
	Tue, 16 Jul 2024 06:46:57 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EB003F762;
	Tue, 16 Jul 2024 06:46:28 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:46:23 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 20/29] arm64: enable POE and PIE to coexist
Message-ID: <20240716134623.GA1570990@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-21-joey.gouly@arm.com>
 <de3cb762-88ee-4b69-a22c-2c5841c9e833@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3cb762-88ee-4b69-a22c-2c5841c9e833@arm.com>

On Tue, Jul 16, 2024 at 04:11:54PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/3/24 18:31, Joey Gouly wrote:
> > Set the EL0/userspace indirection encodings to be the overlay enabled
> > variants of the permissions.
> 
> Could you please explain the rationale for this ? Should POE variants for
> pte permissions be used (when available) instead of permission indirection
> ones.

POE and PIE can be enabled independently. When PIE is disabled, the POE is
applied on top of the permissions described in the PTE.
If PIE is enabled, then POE is applied on top of the indirect permissions.
However, the indirect permissions have the ability to control whether POE
actually applies or not. So this change makes POE apply if PIE is enabled or
not.

For example:
	Encoding of POE_EL0
	0001 	Read, Overlay applied
	...
	1000	Read, Overlay not applied. 


I will add something to the commit message.

> 
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> > index dd9ee67d1d87..4f9f85437d3d 100644
> > --- a/arch/arm64/include/asm/pgtable-prot.h
> > +++ b/arch/arm64/include/asm/pgtable-prot.h
> > @@ -147,10 +147,10 @@ static inline bool __pure lpa2_is_enabled(void)
> >  
> >  #define PIE_E0	( \
> >  	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
> > -	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
> > -	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
> > -	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R)   | \
> > -	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX_O)  | \
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX_O) | \
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R_O)   | \
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW_O))
> >  
> >  #define PIE_E1	( \
> >  	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
> 

