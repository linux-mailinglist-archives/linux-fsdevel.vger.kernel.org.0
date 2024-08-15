Return-Path: <linux-fsdevel+bounces-26080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3C953843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229F31F2369A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D161B9B49;
	Thu, 15 Aug 2024 16:32:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389126AE4;
	Thu, 15 Aug 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739520; cv=none; b=gIM93NydbOVP9TkwhYCL+J2ZIhzCtQwN5Rwo12AGasw1G7+adZO/ZdU87v4YwJCyxRPtu7gBJuXKJktCf7AZ1P4GDssiwNQCDF/jwLNQcjPnCYp2OIxDimbJMQnGglbXAFlFmN6cnQjuvCud8eRiuHp3L9bCPRoRuS4513h7vtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739520; c=relaxed/simple;
	bh=v2DuIKDRYstSgnLhL+gVxytmZsWL98Xb4yRNcEnje9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmBs3P8UeX6Ynvz6tmGfKlRoWOwX+dfow9XdM/KjKg8maFXlPzsHonlcAfMrQvQfFgY2PWP2jGEZ3FAx2h98l1ACxqzq25I8msCbEo9KK6PcHNf28EfKuzvn/hyz7YeR4MIRTbL2l88hpM6REXU/nP8EVR4pddzR4MLu1/jHN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47EB014BF;
	Thu, 15 Aug 2024 09:32:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A073F6A8;
	Thu, 15 Aug 2024 09:31:52 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:31:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <Zr4tdcj8DF92GzVS@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
 <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>
 <Zr4EkmtUKop9o9wu@e133380.arm.com>
 <c56fa974-88f7-4c1f-83bd-8c481fe0045d@sirena.org.uk>
 <Zr4avB6+U4tLDy8E@e133380.arm.com>
 <7fa96f26-5bf6-490f-8986-258033fbfe0e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa96f26-5bf6-490f-8986-258033fbfe0e@sirena.org.uk>

On Thu, Aug 15, 2024 at 04:29:54PM +0100, Mark Brown wrote:
> On Thu, Aug 15, 2024 at 04:11:56PM +0100, Dave Martin wrote:
> > On Thu, Aug 15, 2024 at 03:45:45PM +0100, Mark Brown wrote:
> > > On Thu, Aug 15, 2024 at 02:37:22PM +0100, Dave Martin wrote:
> 
> > > > Is there a test for taking and returning from a signal on an alternate
> > > > (main) stack, when a shadow stack is in use?  Sounds like something
> > > > that would be good to check if not.
> 
> > > Not specifically for any of the architectures.
> 
> > Can you see any reason why this shouldn't work?
> 
> No, it's expected to work - I'm just not specifically aware of an
> explicit test for it.  Possibly some of the userspace bringup work
> might've covered it?  Any libc tests for altstack support should've
> exercised it for example.

That's true; if libc is built to use shadow stack, generic API tests
ought to cover this.

> > Maybe I'll hacking up a test if I get around to it, but don't take this
> > as a promise!
> 
> Thanks for your firm commitment!  :P

No problem...

Cheers
---Dave

