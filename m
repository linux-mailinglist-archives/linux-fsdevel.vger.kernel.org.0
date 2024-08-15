Return-Path: <linux-fsdevel+bounces-26063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24994952FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB5F1C24C3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DECD1A01B6;
	Thu, 15 Aug 2024 13:37:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8EE1A00D2;
	Thu, 15 Aug 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729055; cv=none; b=WIAKeMf5AjRB1cViM7d6HGmVUNLhNvxwJlKHczo7TxLX5yx+2qBnHpmOo7/EHDmeenUmNOX9cEcPCrWIBS03K7cnVmyTW6kCVEk+SHVgcypPTlfAcdhl0HBy72GcRwdjoojInHhmsYQjmqXS+//9ZncF+xbjm3HOBTD2FWDrccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729055; c=relaxed/simple;
	bh=S55pv2tvhOplbIrUC4DKqA+mD14R5cLIsvDmthqKVzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6s4WctyvMiO2fCofrup8ORU8b4kLe+uPPOLUZRz1N99GVUhJa6eJQV/bTKHii9Tvl9VZvHwuLcoBApH24C5WE6OZhUY5vGMiv2SPRjouoZJ+VvQvrZTgKYebNlB3h5CgS4pE5dk56uWLrwj0B7HzYnKEs1TwLf/9njGwLJGChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D46EC14BF;
	Thu, 15 Aug 2024 06:37:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AA023F6A8;
	Thu, 15 Aug 2024 06:37:28 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:37:22 +0100
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
Message-ID: <Zr4EkmtUKop9o9wu@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
 <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>

On Wed, Aug 14, 2024 at 05:00:23PM +0100, Mark Brown wrote:
> On Wed, Aug 14, 2024 at 03:51:42PM +0100, Dave Martin wrote:
> > On Thu, Aug 01, 2024 at 01:06:50PM +0100, Mark Brown wrote:
> 
> > > +	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
> > > +	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
> > > +	if (ret != 0)
> > > +		return ret;
> 
> > What happens if we went wrong here, or if the signal we are delivering
> > was caused by a GCS overrun or bad GCSPR_EL0 in the first place?
> 
> > It feels like a program has no way to rescue itself from excessive
> > recursion in some thread.  Is there something equivalent to
> > sigaltstack()?
> 
> > Or is the shadow stack always supposed to be big enough to cope with
> > recursion that exhausts the main stack and alternate signal stack (and
> > if so, how is this ensured)?
> 
> There's no sigaltstack() for GCS, this is also the ABI with the existing
> shadow stack on x86 and should be addressed in a cross architecture
> fashion.  There have been some discussions about providing a shadow alt
> stack but they've generally been circular and inconclusive, there were a
> bunch of tradeoffs for corner cases and nobody had a clear sense as to
> what a good solution should be.  It was a bit unclear that actively
> doing anything was worthwhile.  The issues were IIRC around unwinders
> and disjoint shadow stacks, compatibility with non-shadow stacks and
> behaviour when we overflow the shadow stack.  I think there were also
> some applications trying to be very clever with alt stacks that needed
> to be interacted with and complicated everything but I could be
> misremembering there.
> 
> Practically speaking since we're only storing return addresses the
> default GCS should be extremely large so it's unlikely to come up
> without first encountering and handling issues on the normal stack.
> Users allocating their own shadow stacks should be careful.  This isn't
> really satisfying but is probably fine in practice, there's certainly
> not been any pressure yet from the existing x86 deployments (though at
> present nobody can explicitly select their own shadow stack size,
> perhaps it'll become more of an issue when the clone3() stuff is in).

Ack, if this is a known limitation then I guess it makes sense just to
follow other arches.

I see that we default the shadow stack size to half the main stack size,
which should indeed count as "huge".  I guess this makes shadow stack
overrun unlikely at least (at least, not before the main stack
overruns).


Hopping to an alternate (main) stack while continuing to push on the
same shadow stack doesn't sound broken in principle.

Is there a test for taking and returning from a signal on an alternate
(main) stack, when a shadow stack is in use?  Sounds like something
that would be good to check if not.

Cheers
---Dave

