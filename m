Return-Path: <linux-fsdevel+bounces-68949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BAC6A42E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2F4F554A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0750361DD5;
	Tue, 18 Nov 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVqLXxCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E92FF64A;
	Tue, 18 Nov 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478405; cv=none; b=kMnIXD06041B2eFVknQTSMD46MMtHxKgdP231+knztWhWVqR9Cv5dmaKfFwb3gsMwFbYnad2EJF7YZmIQQ11mZEZwkDeIvxzkoVdPVkXkC6ZvUcWwMukxIGQDyvVAGxbbEJejUfSFJ3sYZwyoHCJJUJBq/z6pGm80W4xfJR/y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478405; c=relaxed/simple;
	bh=76+2f+4hsDZ7pFzkCao+UBvMyvqOyAsPTXWZOrXZ64A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl28nCVHotxLs7UftShYkAy3FOTGfS+5tggF6Cb7oG0jkWTRR0nr3kY9a5oIvzFpHxQXDhc2qDsLOwsqCf6Zutjv25FlfHzSLM1qyu2UqVhZ8INy+ARHeSHWW5LB9AGtTBQ2fL2psgbgoXLUNqmZtJdj6rvJiUH0NNJeznCFYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVqLXxCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274F2C19421;
	Tue, 18 Nov 2025 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763478404;
	bh=76+2f+4hsDZ7pFzkCao+UBvMyvqOyAsPTXWZOrXZ64A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVqLXxCoHubWmmYGMBSppHz6v+K6gOlZuSYxfANkq1RKW8ckeEAIrlml2vKMxAe5L
	 3C8zjm11dqTah0Vkmy2M8q3igXZkmU+HXuX48hcaI8METAODITZD7cxnwl2IMKPiXP
	 otr7qxYH6DGeVFsBC2ronbizF4drLwhTO4cKnQUZC7lBlo0I2qlELAAZm/qaFIqsjG
	 HfRaIi6Y5JnNl3ZWxHIr/R7/kiqKBhKBd1W+81GC9ZMcqhlXX4EWL9wpc7TXvC/n65
	 fdY1qa4EgfHtTIYbz0kzbq1HE98C977U9Rl1R9Gg51/HhI1YNVY1YoDlShCZkuqVyr
	 rOJgoCOWRfH0g==
Date: Tue, 18 Nov 2025 17:06:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <aRyLbB8yoQwUJ3dh@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
 <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org>
 <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org>
 <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org>
 <20251118140300.GK10864@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118140300.GK10864@nvidia.com>

On Tue, Nov 18, 2025 at 10:03:00AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 18, 2025 at 01:21:34PM +0200, Mike Rapoport wrote:
> > On Mon, Nov 17, 2025 at 11:22:54PM -0500, Pasha Tatashin wrote:
> > > > You can avoid that complexity if you register the device with a different
> > > > fops, but that's technicality.
> > > >
> > > > Your point about treating the incoming FDT as an underlying resource that
> > > > failed to initialize makes sense, but nevertheless userspace needs a
> > > > reliable way to detect it and parsing dmesg is not something we should rely
> > > > on.
> > > 
> > > I see two solutions:
> > > 
> > > 1. LUO fails to retrieve the preserved data, the user gets informed by
> > > not finding /dev/liveupdate, and studying the dmesg for what has
> > > happened (in reality in fleets version mismatches should not be
> > > happening, those should be detected in quals).
> > > 2. Create a zombie device to return some errno on open, and still
> > > study dmesg to understand what really happened.
> > 
> > User should not study dmesg. We need another solution.
> > What's wrong with e.g. ioctl()?
> 
> It seems very dangerous to even boot at all if the next kernel doesn't
> understand the serialization information..
> 
> IMHO I think we should not even be thinking about this, it is up to
> the predecessor environment to prevent it from happening. The ideas to
> use ELF metadata/etc to allow a pre-flight validation are the right
> solution.
> 
> If we get into the next kernel and it receives information it cannot
> process it should just BUG_ON and die, or some broad equivalent. 
> It is a catastrophic orchestration error, and we don't need some fine
> grain recovery or userspace visibility. Crash dump the system and
> reboot it.

I was under impression Pasha wanted to get up to the userspace no matter
what.

panic() in liveupdate_early_init() makes perfect sense to me. Parsing dmesg
does not.
 
> IOW, I would not invest time in this.
> 
> Jason

-- 
Sincerely yours,
Mike.

