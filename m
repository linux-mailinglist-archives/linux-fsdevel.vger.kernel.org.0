Return-Path: <linux-fsdevel+bounces-24451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D893F837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14F1B24002
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B6187858;
	Mon, 29 Jul 2024 14:27:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA7187853
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263243; cv=none; b=VTBU18gu2tIGh85TD9ccnJTEX/DpKT8CNqb/3bGNVTatJr2THST6k5QR12d2kK3P5XCoCh7OIUEfBAc1+QrN16Rj86AgkWQScI5Us7QLY3xOHzWEUaRZlMRZbUwng+T6Rab6XbW8SfKKrKQO24LvJCou1yRRVKswZLolDHo8ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263243; c=relaxed/simple;
	bh=FI0SZtq1fJLkD6eYgak6HSBpiN7qQvZbSjMTOy9yP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF4Z/c5mhXuvfaG6VeVWFpxcaA3gwmdB39J2ORPdZFRoZ8+KF+qaLWpSU4Npn/UHFILvtBwDhVGax2CokTU+k4j/b0/aXB1Z84FBmHPgydRch/0o/L9N0vcAq9d+MVsPCvuD/AZZEE25gyZ4CJbNSdRwMh6N/lkrmjAgTZyCMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AA21007;
	Mon, 29 Jul 2024 07:27:46 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7413F64C;
	Mon, 29 Jul 2024 07:27:16 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:27:11 +0100
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
Message-ID: <Zqemv4YUSM0gouYO@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
 <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
 <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>
 <ZqPLSRjjE+SRoGAQ@e133380.arm.com>
 <a52f1762-afd4-4527-88ac-76cdd8a59d5d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52f1762-afd4-4527-88ac-76cdd8a59d5d@sirena.org.uk>

On Fri, Jul 26, 2024 at 06:39:27PM +0100, Mark Brown wrote:
> On Fri, Jul 26, 2024 at 05:14:01PM +0100, Dave Martin wrote:
> > On Thu, Jul 25, 2024 at 07:11:41PM +0100, Mark Brown wrote:
> 
> > > That'd have to be a variably sized structure with pairs of sysreg
> > > ID/value items in it I think which would be a bit of a pain to implement
> > > but doable.  The per-record header is 64 bits, we'd get maximal saving
> > > by allocating a byte for the IDs.
> 
> > Or possibly the regs could be identified positionally, avoiding the
> > need for IDs.  Space would be at a premium, and we would have to think
> > carefully about what should and should not be allowed in there.
> 
> Yes, though that would mean if we had to generate any register in there
> we'd always have to generate at least as many entries as whatever number
> it got assigned which depending on how much optionality ends up getting
> used might be unfortunate.

Ack, though it's only 150 bytes or so at most, so just zeroing it all
(or as much as we know about) doesn't feel like a big cost.

It depends how determined we are to squeeze the most out of the
remaining space.


> > > It would be very unfortunate timing to start gating things on such a
> > > change though (I'm particularly worried about GCS here, at this point
> > > the kernel changes are blocking the entire ecosystem).
> 
> > For GCS, I wonder whether it should be made a strictly opt-in feature:
> > i.e., if you use it then you must tolerate large sigframes, and if it
> > is turned off then its state is neither dumped nor restored.  Since GCS
> > requires an explict prctl to turn it on, the mechanism seems partly
> > there already in your series.
> 
> Yeah, that's what the current code does actually.  In any case it's not
> just a single register - there's also the GCS mode in there.

Agreed -- I'll ping the GCS series, but this sounds like a reasonable
starting point.

Cheers
---Dave

