Return-Path: <linux-fsdevel+bounces-26072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30D9536CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1511B28A346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C21B9B53;
	Thu, 15 Aug 2024 15:12:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4B1AC44F;
	Thu, 15 Aug 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734727; cv=none; b=J3WdwwrEMRaxh+RvoGSi2teIdAJRUXl5yHa0ZV/lgjyKZGldCQwualB73Ywvt9KTWNK5pw+lTS+Kg+awX5f7TCydRemvz9s0GF1udha1sJoCEZLplYiuo2+4F8QqKaGbLal1HQy0oi1sAhJyeH3s7NsJ2P/GhyGPFg9W/nZEgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734727; c=relaxed/simple;
	bh=GEK7YaT6OW4cfX4QYGP7LUj6OHcEnMiGVE7bb/gMHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ7diHfwWRhQBSRU4kRRjwBRkuKNy6Cau8A9jPn/PHxs/RGq4fu/G/SOQkIxmcwszh+bUb1VPC0kxyvaq9VlfG5iwSsiEyFo5J27GDP8gZEZM6gPiraYR8xEu9bEDWGqS6FuQYCeKoR53kU2NgvK8jtauazgOx4IgbvqxefeSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AAE414BF;
	Thu, 15 Aug 2024 08:12:31 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5563F58B;
	Thu, 15 Aug 2024 08:11:59 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:11:56 +0100
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
Message-ID: <Zr4avB6+U4tLDy8E@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
 <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>
 <Zr4EkmtUKop9o9wu@e133380.arm.com>
 <c56fa974-88f7-4c1f-83bd-8c481fe0045d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56fa974-88f7-4c1f-83bd-8c481fe0045d@sirena.org.uk>

On Thu, Aug 15, 2024 at 03:45:45PM +0100, Mark Brown wrote:
> On Thu, Aug 15, 2024 at 02:37:22PM +0100, Dave Martin wrote:
> 
> > Is there a test for taking and returning from a signal on an alternate
> > (main) stack, when a shadow stack is in use?  Sounds like something
> > that would be good to check if not.
> 
> Not specifically for any of the architectures.

Can you see any reason why this shouldn't work?

Maybe I'll hacking up a test if I get around to it, but don't take this
as a promise!

Cheers
---Dave

