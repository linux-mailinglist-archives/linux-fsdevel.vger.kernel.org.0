Return-Path: <linux-fsdevel+bounces-10066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50425847718
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA028D104
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527A14D445;
	Fri,  2 Feb 2024 18:08:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4E14C598;
	Fri,  2 Feb 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897286; cv=none; b=ImgoTBOYcQ3fG94ufq4GN5Ad2JBiPm/zz6YZtv1HURte4x1jKhIzecJCT7ekvvKXEK5xRQPlP1Wk1OcetbRupGZarBawFk6UnOqlwOK2kqMGJmXhZldrIQnJU1A07rPoRsXvqpzxfHwLxvxJIp524ZY6aIkoUU7mJkRvtCpZ4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897286; c=relaxed/simple;
	bh=9rwlNwy8wTSVXhT4XMjY34L+K/gYaFA32HXn/coWBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brlpoNJszZ5cpPiy1f/58GCmp3/WAQOsOyLEsR850sj1IvX3boKknCsna7ZsW/EIUSkWvtXZtvwh2DTdLyGn5IUDkadk5lwameNZy8AzqpO4rzkBg3CHyNpqGPw/+WJA+xrnxTODpVx0hLjln5gGPlwpXFioKZnPatrZjdt64Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748E119F0;
	Fri,  2 Feb 2024 10:08:41 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B2C3F762;
	Fri,  2 Feb 2024 10:07:57 -0800 (PST)
Date: Fri, 2 Feb 2024 18:07:54 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Doug Anderson <dianders@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <Zb0vem7KC28gmT5U@e133380.arm.com>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
 <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV>
 <20240202165524.GD2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202165524.GD2087318@ZenIV>

On Fri, Feb 02, 2024 at 04:55:24PM +0000, Al Viro wrote:
> On Fri, Feb 02, 2024 at 04:49:47PM +0000, Al Viro wrote:
> > > +folks from `./scripts/get_maintainer.pl -f arch/arm64/kernel/ptrace.c`
> > > 
> > > Trying to follow the macros to see where "n" comes from is a maze of
> > > twisty little passages, all alike. Hopefully someone from the ARM
> > > world can help tell if the value of 17474 for n here is correct or if
> > > something is wonky.

Nope, that's the "correct" answer...

> > 
> > It might be interesting to have it print the return value of __regset_get()
> > in those cases; if *that* is huge, we really have a problem.  If it ends up
> > small enough to fit into few pages, OTOH...
> > 
> > SVE_VQ_MAX is defined as 255; is that really in units of 128 bits?  IOW,
> > do we really expect to support 32Kbit registers?  That would drive the
> > size into that range, all right, but it would really suck on context
> > switches.
> > 
> > I could be misreading it, though - the macros in there are not easy to
> > follow and I've never dealt with SVE before, so take the above with
> > a cartload of salt.
> 
> Worse - it's SVE_VQ_MAX is 512; sorry about the confusion.  OK, that would
> certainly explain the size (header + 32 registers, each up to 512 * 16 bytes),
> but... ouch.

Mark Brown [+ Cc] has been taking care of SVE in my absence, but
from memory:

The SVE architecture has a really big maximum vector size (16 * 128 =
2048 bits), and there is a theoretical possibility of it getting bigger
in the future, though unlikely.

Real platforms to date have a much smaller limit, though Qemu can go up
to 2048 bits IIUC.

My aim when working on the ABI was to future-proof it against
foreseeable expansion on the architecture side, but this does mean that
we cannot statically determine a sane limit for the vector size.


I suppose we could have had a more sane limit built into the kernel or a
Kconfig option for it, but it seemed simpler just to determine the size
dynamically depending on the task's current state.  This is not so
important for coredumps, but for the the gdbstub wire protocol etc. it
seemed undesirable to have the regset larger than needed.

Hence the reason for adding ->get_size() in
27e64b4be4b8 ("regset: Add support for dynamically sized regsets").

What I guess was not so obvious from the commit message is the
expected relationship between the actual and maximum possible size
of the regset: for SVE the actual size is in practice going to be *much*
smaller than the max, while the max is crazy large because of being an
ABI design limit chosen for futureproofing purposes.



So, if the only reason for trying to migrate to vmalloc() is to cope
with an insanely sized regset on arm64, I think somehow or other we can
avoid that.

Options:

 a) bring back ->get_size() so that we can allocate the correct size
before generating the regset data;

 b) make aarch64_regsets[] __ro_after_init and set
aarch64_regsets[REGSET_SVE].n based on the boot-time probed maximum size
(which will be sane); or

 c) allow membufs to grow if needed (sounds fragile though, and may be
hard to justify just for one arch?).


Thoughts?

If people don't want to bring back get_size(), then (b) doesn't look
too bad.

Cheers
---Dave

