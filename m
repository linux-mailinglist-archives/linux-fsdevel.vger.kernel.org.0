Return-Path: <linux-fsdevel+bounces-28586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A910496C3D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A91F26D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96841DEFDC;
	Wed,  4 Sep 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKFvAnS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE817FD;
	Wed,  4 Sep 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466687; cv=none; b=mlrsApggNnqwVouldleV94qhs+yR/pj/6kooORQnpALqEnZOAstidps7VDrFyGX6E92Oe7xp9AYPvR9I5pFbAzR/0cTOZhs0eeYILZfzNoSMoMjHyGeebOsUrwqeDimqYd8zQQQQn96U/q71B9sZSIjxNvRWpycPKSp7EyxLcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466687; c=relaxed/simple;
	bh=DWcEOGL96hUD6X+485HhnxfMINMh+YmkfVOIwpbbpYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEzBesD4da6MjhKEk09zvgt2oNDYUO1UNQb9LLZFNZVRVp69Ks3UMFhEn/f2HJw6bN70SUn/zAK+FvURXZjSFtUpGGJwjVMS9nwmnvNk2qYgwNF0mBvnUPlGwiwj5I/52UAthPU9egTj4qBeUJmyfQbKCcPY7wDATH8XpeyadbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKFvAnS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC5C4CEC5;
	Wed,  4 Sep 2024 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466686;
	bh=DWcEOGL96hUD6X+485HhnxfMINMh+YmkfVOIwpbbpYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKFvAnS4VzVPVcU0kTh73wMC4toZ01I4tyglrkwgCzoFCMyaU94FmsNPifaeDTq/e
	 /S9R4xJgHIzXEVb0dN86Z3aQS7irvg749YZlYq8JOFAF/GznaVa5Q3h8zP0BjAWTb+
	 S/dKvplcQ1CIJZbyFNY3IwgngrcKjH8xrR8+HzIRsr2gxTsDWGKLGAmXxZXHY9i47J
	 ugMn7HhA4o5dtzevsYYMhsnKNl/qLFMhf6V9y8FdJUr6Tyd6V/udO1l07rxZuaRtcg
	 SBRjqfWbZWJL4fgF6Pi4WYENijZrH6NFX7AGuT0PeGN9VILf5Xpdb5kRDldsz2EOGt
	 y4578KvQYJzFA==
Date: Wed, 4 Sep 2024 17:17:58 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
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
Message-ID: <20240904161758.GA14323@willie-the-truck>
References: <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
 <20240903145413.GB3669886@e124191.cambridge.arm.com>
 <20240904102254.GA13280@willie-the-truck>
 <20240904113221.GA3891700@e124191.cambridge.arm.com>
 <20240904114301.GA13550@willie-the-truck>
 <20240904125503.GA3901671@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904125503.GA3901671@e124191.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 04, 2024 at 01:55:03PM +0100, Joey Gouly wrote:
> On Wed, Sep 04, 2024 at 12:43:02PM +0100, Will Deacon wrote:
> > Right, there's quite a lot I need to do:
> > 
> > - Uncorrupt your patches
> > - Fix the conflict in the kvm selftests
> > - Drop the unnecessary ISBs
> > - Fix the ESR checking
> > - Fix the el2_setup labels
> > - Reorder the patches
> > - Drop the patch that is already in kvmarm
> > 
> > Working on it...
> 
> Sorry! I'm happy to rebase onto some arm64 branch if that will help, just let me know.

Please have a look at for-next/poe (also merged into for-next/core and
for-kernelci) and let me know what I got wrong!

For Marc: I reordered the series so the KVM bits (and deps) are all the
beginning, should you need them. The branch is based on a merge of the
shared branch you created previously.

Cheers,

Will

