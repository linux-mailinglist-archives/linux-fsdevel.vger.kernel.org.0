Return-Path: <linux-fsdevel+bounces-26082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF6953874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A86B242C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE091BA879;
	Thu, 15 Aug 2024 16:40:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFB19E7E8;
	Thu, 15 Aug 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740039; cv=none; b=LuMRt+PnBobkX2hjA3WcaOeJCRvEwGcex1G3WIYE9JOcwRdNV0EKEwhlnyocT4MekUdwDYzuC0lYR8Ew9paobpgo4B3CNBzu5AwOXGouZo8JHcKCMxSX28IzuAM7/XrmggvuaQlgfoHiylWAmOxzz6qN9jrwfR5rZRGbgi8ydpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740039; c=relaxed/simple;
	bh=eYIgqeGdY4g3ZzqhHcIgoaFxFG4KBnsCfs2IN1/MCew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+1iyaSE6n3OHUHvhB1JvWwrxDBW4hcQ+TEhXiqt65qn1KpYPKcGc7QTnl653lhm39+kD4cRWi5P9fgGV1NSYPm8MtYDc1nNRkt7eXHFQEL9kvN6esW36Em4Kq4JQEW9APdWuzrl32YOY1u3zdJI+4CPoQTFdSr5Sw3OAXZuUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01FD014BF;
	Thu, 15 Aug 2024 09:41:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F48C3F6A8;
	Thu, 15 Aug 2024 09:40:30 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:40:27 +0100
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
Subject: Re: [PATCH v10 24/40] arm64/signal: Expose GCS state in signal frames
Message-ID: <Zr4ve+FX/Zd+E9zk@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
 <ZrzIv3FWNgJizDc2@e133380.arm.com>
 <7433e3d2-996a-45a0-b917-666a340ad109@sirena.org.uk>
 <Zr4KMaBv4JXx8uBz@e133380.arm.com>
 <efe1d936-011d-49e3-a0ff-8f6276e4d782@sirena.org.uk>
 <Zr4fxZ8wf+Wcey4E@e133380.arm.com>
 <280e4455-9cf7-40e1-9114-7bb3aa9de868@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280e4455-9cf7-40e1-9114-7bb3aa9de868@sirena.org.uk>

On Thu, Aug 15, 2024 at 04:46:04PM +0100, Mark Brown wrote:
> On Thu, Aug 15, 2024 at 04:33:25PM +0100, Dave Martin wrote:
> > On Thu, Aug 15, 2024 at 04:05:32PM +0100, Mark Brown wrote:
> 
> > > The expectation (at least for arm64) is that the main program will only
> > > have shadow stacks if everything says it can support them.  If the
> > > dynamic linker turns them on during startup prior to parsing the main
> > > executables this means that it should turn them off before actually
> > > starting the executable, taking care to consider any locking of features.
> 
> > Hmm, so we really do get a clear "enable shadow stack" call to the
> > kernel, which we can reasonaly expect won't happen for ancient software?
> 
> Yes, userspace always has to explicitly enable the GCS.
> 
> > If so, I think dumping the GCS state in the sigframe could be made
> > conditional on that without problems (?)
> 
> It is - we only allocate the sigframe if the task has GCS enabled.

OK, makes sense.

> > > > Related question: does shadow stack work with ucontext-based coroutines?
> > > > Per-context stacks need to be allocated by the program for that.
> 
> > > Yes, ucontext based coroutines are the sort of thing I meant when I was
> > > talking about returning to a different context?  
> 
> > Ah, right.  Doing this asynchronously on the back of a signal (instead
> > of doing a sigreturn) is the bad thing.  setcontext() officially
> > doesn't work for this any more, and doing it by hacking or rebuilding
> > the sigframe is extremely hairy and probably a terrible idea for the
> > reasons I gave.
> 
> I see.  I tend to view this as more adventurous than I personally would
> be when writing userspace code but equally I don't see a need to
> actively break things.  There's no *requirement* to use libc...
> 
> > So, overall I think making ucontext coroutines with with GCS is purely
> > a libc matter that is "interesting" here, but we don't need to worry
> > about.
> 
> Yes, it's not our problem so long as we don't get in the way somehow.

Sure.  "Hairy and probably a terrible idea" is not the same as
"impossible", but you need to know what you're doing and you get
exposed to all sorts of portability challenges.

There's a limit to how much we should attempt to smooth over all that.

Anyway, I think what the GCS patches are doing looks reasonable.

Cheers
---Dave

