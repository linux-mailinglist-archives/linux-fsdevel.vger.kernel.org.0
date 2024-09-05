Return-Path: <linux-fsdevel+bounces-28716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C696D62F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E74A287691
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE619882C;
	Thu,  5 Sep 2024 10:36:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531B1EBFEC;
	Thu,  5 Sep 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532577; cv=none; b=jOC86XcGcJ5O4HtMgZK8WW/ocb58+uorG0brTWulkME9awawQp7g8KXXSKfkm4VChrQ8LK3pWybWmzB/jJ89EWX5h32ryGFgGVJVr5NKv87IGyYujpOa3dvXQhwtOYVzYTH11JmTlpxv22crnPTXK31NLeD/8dQEDKBS9dhvlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532577; c=relaxed/simple;
	bh=ZcNd7kTC7a6o7YbVm/VC08zVoaIVFF/QxxTTlIEk7jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpKUXYidiaIqpKuYs1HBTMwYZ+BxB4WH8pXAvAKO0/At4H7SuUJyU3SnzRy99luSr1BUPbHjUJ+EvH5E2p7aIrKlD+1Xa1XsB1tE0BlIAERxdMcvf/4kxK3zkRSxgeKblJ0MMuGzPyYTWf4Kvtq7DYCMtYqcbOjkpAwFmwOsO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBFABFEC;
	Thu,  5 Sep 2024 03:36:41 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40AB93F73F;
	Thu,  5 Sep 2024 03:36:11 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:36:06 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <20240905103606.GA4063653@e124191.cambridge.arm.com>
References: <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
 <20240904102254.GA13280@willie-the-truck>
 <20240904113221.GA3891700@e124191.cambridge.arm.com>
 <20240904114301.GA13550@willie-the-truck>
 <20240904125503.GA3901671@e124191.cambridge.arm.com>
 <20240904161758.GA14323@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904161758.GA14323@willie-the-truck>

On Wed, Sep 04, 2024 at 05:17:58PM +0100, Will Deacon wrote:
> On Wed, Sep 04, 2024 at 01:55:03PM +0100, Joey Gouly wrote:
> > On Wed, Sep 04, 2024 at 12:43:02PM +0100, Will Deacon wrote:
> > > Right, there's quite a lot I need to do:
> > > 
> > > - Uncorrupt your patches
> > > - Fix the conflict in the kvm selftests
> > > - Drop the unnecessary ISBs
> > > - Fix the ESR checking
> > > - Fix the el2_setup labels
> > > - Reorder the patches
> > > - Drop the patch that is already in kvmarm
> > > 
> > > Working on it...
> > 
> > Sorry! I'm happy to rebase onto some arm64 branch if that will help, just let me know.
> 
> Please have a look at for-next/poe (also merged into for-next/core and
> for-kernelci) and let me know what I got wrong!

I pulled for-next/poe and ran the test and it works fine. Also looked at the
diff of my branch against your branch, and it looks fine too.

Thanks for your work to get this merged!

> 
> For Marc: I reordered the series so the KVM bits (and deps) are all the
> beginning, should you need them. The branch is based on a merge of the
> shared branch you created previously.
> 
> Cheers,
> 
> Will
> 

