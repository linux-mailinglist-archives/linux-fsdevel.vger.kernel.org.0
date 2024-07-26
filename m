Return-Path: <linux-fsdevel+bounces-24334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB593D6BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E932B220C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50517C225;
	Fri, 26 Jul 2024 16:14:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161817B4E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010452; cv=none; b=o8E14V+Y4GV7ouLT1I/HgwYkT5PMB2TRNwj5MjUf6Rtk36w2zREgBe6v7tzf7Vt/n3Tm104+iXJMxP6R5Qh95VAtjCQynQnNZgHvDvWTT1pjWsYWhazdvdnIzEEhsl2JheTGqfWm01hV4ijAtrSM+jWlbJubvasifSrRNqMxOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010452; c=relaxed/simple;
	bh=tCDver3MNrltrPETi9z05thLEBA350sjUjwIIO4/xFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuTxQWavZvuTn8MoJvev5RafC5gYEKGxmLf1mWfcfQsX55WCrUwLMWluUm/6yhPxJNzfsHBEdgyMTzl5c/ScBP9B7C8s9o5r+NiupUqvAFi7Qfwu0PnnJ/LnkbWtBRj4o1HPQpNY0ibQbLhuIipo/1u5sIyOrx2iMDNnmbbjZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C1E1007;
	Fri, 26 Jul 2024 09:14:35 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E7AB3F766;
	Fri, 26 Jul 2024 09:14:07 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:14:01 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <ZqPLSRjjE+SRoGAQ@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
 <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
 <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>

On Thu, Jul 25, 2024 at 07:11:41PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2024 at 04:58:27PM +0100, Dave Martin wrote:
> 
> > I'll post a draft patch separately, since I think the update could
> > benefit from separate discussion, but my back-of-the-envelope
> > calculation suggests that (before this patch) we are down to 0x90
> > bytes of free space (i.e., over 96% full).
> 
> > I wonder whether it is time to start pushing back on adding a new
> > _foo_context for every individual register, though?
> 
> > Maybe we could add some kind of _misc_context for miscellaneous 64-bit
> > regs.
> 
> That'd have to be a variably sized structure with pairs of sysreg
> ID/value items in it I think which would be a bit of a pain to implement
> but doable.  The per-record header is 64 bits, we'd get maximal saving
> by allocating a byte for the IDs.

Or possibly the regs could be identified positionally, avoiding the
need for IDs.  Space would be at a premium, and we would have to think
carefully about what should and should not be allowed in there.

> It would be very unfortunate timing to start gating things on such a
> change though (I'm particularly worried about GCS here, at this point
> the kernel changes are blocking the entire ecosystem).

For GCS, I wonder whether it should be made a strictly opt-in feature:
i.e., if you use it then you must tolerate large sigframes, and if it
is turned off then its state is neither dumped nor restored.  Since GCS
requires an explict prctl to turn it on, the mechanism seems partly
there already in your series.

I guess the GCS thread is the better place to discuss that, though.

Cheers
---Dave

