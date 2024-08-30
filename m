Return-Path: <linux-fsdevel+bounces-27996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71449965C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9032B21F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D516EC1A;
	Fri, 30 Aug 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HChw5GwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA7BA3D;
	Fri, 30 Aug 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008731; cv=none; b=MDY2bwehzhY6mTVdffRljlTf/g2awMp39Ia1Q0/n4/rNmDRHWwvBwUrpZcLYp/sC94tRDeyfhGL7S/m18qdXCNW+wu8/D5ag7zmz3zV5wCMdtg8BzvDs00pemNurzvcpib7uQGeqr2L8G4s0hRNRNemjMpilHA4ZstU1Virf018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008731; c=relaxed/simple;
	bh=jTLffhohIxJnzY99/Hvodz5uFraK2Vu7f7rbBUb7RL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBW84OHi174JI89N6XIOTG89Gi7M5tluH5T/FC7EIwkn0iNiicF8oxadOyIXv89Ej3mRzJ5cwsnTzXglBonmFmxRu6g1IzPtCOVMrO0igwRdjZ+fzO00zpi5w3IeO/mTU6C1AYqyZUybFHiRS9+lRl5ySNkXB7o8JkVYnklUGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HChw5GwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2380EC4CECB;
	Fri, 30 Aug 2024 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725008730;
	bh=jTLffhohIxJnzY99/Hvodz5uFraK2Vu7f7rbBUb7RL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HChw5GwJcaBYA0YWU51Sq8KSuPRh1Qzu2RJlo+RjnG0gnt6HvvXNGLSnEMo6bhu/H
	 5KrS2WWo3ASz7iPKCdmLMbHD8svscNsJSIlxe7BKaZ4/wxEo9tBOBvXzSkgz0AJYpn
	 iHC4GnKqRIowewoJ+Jl/A96N/ImKtYszoY7j8nx3Xg6o9Kmj8UKSQgscBCyDkI3LH2
	 P5lw6WAkGEBegKDF3l0Omf7fHJhs7x7k4zNj2od0bzeSzhVPYASLGC6AXSGeMbjI1Q
	 CBpXqgx/gO299Yfg1XbGUPFWO3WG6aNjElKht3dNb51IQpPfhsZ1FGLfLJCkinw1uO
	 g59V4OZV0AImQ==
Date: Fri, 30 Aug 2024 10:05:22 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/30] KVM: arm64: make kvm_at() take an OP_AT_*
Message-ID: <20240830090522.GA7678@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-9-joey.gouly@arm.com>
 <20240823134811.GG32156@willie-the-truck>
 <86cylqwib5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cylqwib5.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Marc,

On Fri, Aug 30, 2024 at 09:01:18AM +0100, Marc Zyngier wrote:
> On Fri, 23 Aug 2024 14:48:11 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Thu, Aug 22, 2024 at 04:10:51PM +0100, Joey Gouly wrote:
> > > To allow using newer instructions that current assemblers don't know about,
> > > replace the `at` instruction with the underlying SYS instruction.
> > > 
> > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Oliver Upton <oliver.upton@linux.dev>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/kvm_asm.h       | 3 ++-
> > >  arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > Marc -- what would you like to do with this patch? I think the POE series
> > is really close now, so ideally I'd queue the lot on a branch in arm64
> > and you could pull the first ~10 patches into kvmarm if you need 'em.
> > 
> > Would what work for you, or did you have something else in mind (since
> > this one is also included in your series adding nv support for AT).
> 
> Is there any progress on this front? I am quite eager to queue the AT
> series, but the dependency on this patch is preventing me to do so.
> 
> I can see there are outstanding questions on the POE series, so I was
> wondering if we should consider reversing the dependency: I can create
> a stable branch with this single patch, which you can pull as a prefix
> of the POE series.

That sounds like a good idea. The uaccess discussion seems to have
stalled and I don't really want to merge the series without concluding
that.

So please go ahead with this single patch and I'll pull it in if things
start moving again.

Will

