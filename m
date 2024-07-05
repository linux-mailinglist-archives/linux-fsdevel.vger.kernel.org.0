Return-Path: <linux-fsdevel+bounces-23226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479F928C92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950C41C24825
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97016D4F6;
	Fri,  5 Jul 2024 17:00:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117A16D335
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198805; cv=none; b=Tt5PPwTIklLGk+VLZs0MbtIdAiMbW5PE7cCRHyxZ8gE0sMQvQhfKoS7nWGsEtLhzyUwTfBlcde/3bsDpyq5qGyrU3XoGigHcPD/6B2pXC/SNkoSc9YsC2y8hLqAna104vZe3FbO/QwUPdmUri0KYUt+dRah3GqRA140GCaOl1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198805; c=relaxed/simple;
	bh=k+tehCjGizrZ3p48OloAFBbe/VVxgMIyazVIufLISBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQH1xyKK5IOfAbmgSAyMhQSWlFzyL2Dr65LlBJmLGqZQa+DAkf/YnScrRxE08cN1KppYtYHyQUoC39FVpuy8Pse/bLEAkUvDZUWdQ5msX/9I+2PU9ZagM9mct81CGNblD58XZdzm2ZSJ9vVhDrv5hqcjhJAPXMU7CekqqMYtxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF3FDA7;
	Fri,  5 Jul 2024 10:00:26 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D913F762;
	Fri,  5 Jul 2024 09:59:57 -0700 (PDT)
Date: Fri, 5 Jul 2024 17:59:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <Zogmi1AogxHWlWWR@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-18-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:35PM +0100, Joey Gouly wrote:
> @@ -163,7 +182,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  #define pte_access_permitted_no_overlay(pte, write) \
>  	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
>  #define pte_access_permitted(pte, write) \
> -	pte_access_permitted_no_overlay(pte, write)
> +	(pte_access_permitted_no_overlay(pte, write) && \
> +	por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))

I'm still not entirely convinced on checking the keys during fast GUP
but that's what x86 and powerpc do already, so I guess we'll follow the
same ABI.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

