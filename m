Return-Path: <linux-fsdevel+bounces-26913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8B95CE57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241981C21AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE6188596;
	Fri, 23 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kziks+te"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1342AAE;
	Fri, 23 Aug 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420899; cv=none; b=PSbuK7bCU/ELp6yOXQabRha3mgq4SpQzIoCOctVgVC0cj3pwe0zeLmsM6+B9+gRXFyL0ouhP8ppBKaXAu/fHM/+2GLrWpTu77a0cvzkhyM/Td07ynxsMdjLCIvKhm8FxEjra65njIBKnExWfgF8MGQ0qg6VZdNjj46LiPZF5Ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420899; c=relaxed/simple;
	bh=JIkqMCgIebwRUTuIcinW21G7FY3x6MY5j3ti9QJWUpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhPWSmy29jsc1tnBEm20SSryW/qUmiquprDlVtZpcnghtBf3K0GI1eO555Zt2mIxluw97j4T+grCzCRskGpqWJD+UuI3eN2rDEvBCH1rHf2bH85nVVJK3g+KHyIHAygj+ayfpZd4UTb7pnjRj52MGBm83TH5tBcBIHmgeWvOtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kziks+te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F9DC4AF0B;
	Fri, 23 Aug 2024 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420899;
	bh=JIkqMCgIebwRUTuIcinW21G7FY3x6MY5j3ti9QJWUpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kziks+te/BuykzKTqMKMAm8i1ejDZAh27QGp5y9Zp2y11SGWyfr3X8tN39n9705Nz
	 Ljop4jG7EJLldMweAoE56RJb57K0QKg1VWxx1ebf7wk2dLTgyVsyElBdUfhAC4xUiy
	 kBKTq+gnA9SnPglbx3k46c4LBIQ6bLE4Bvt9c2pBbn/8akTqSnBMymof4qK9lLM3LJ
	 xRC1X+6/eiVKwk5rwintXkbQe8/4CxeFwNSYoyzwD7LVStbyk4KOxJzFnkVehoLR6/
	 +BNzmHEjHiE/jgWwxjDsxDULSH/KDFq/t/ZOR+y/EFKqmRjZyBG5KHBtl0FBNj2LUR
	 sa+5r/DHUAV0w==
Date: Fri, 23 Aug 2024 14:48:11 +0100
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
Message-ID: <20240823134811.GG32156@willie-the-truck>
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

Marc -- what would you like to do with this patch? I think the POE series
is really close now, so ideally I'd queue the lot on a branch in arm64
and you could pull the first ~10 patches into kvmarm if you need 'em.

Would what work for you, or did you have something else in mind (since
this one is also included in your series adding nv support for AT).

Cheers,

Will

