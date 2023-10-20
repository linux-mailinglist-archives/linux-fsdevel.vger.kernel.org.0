Return-Path: <linux-fsdevel+bounces-818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068597D0E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA08C2824EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD318B06;
	Fri, 20 Oct 2023 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUVpp1pl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B51804D;
	Fri, 20 Oct 2023 11:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6448DC433C8;
	Fri, 20 Oct 2023 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697799709;
	bh=4Rkb5V2D8bP++SzpqDTXV2hlkoc7FCRIfbSezE4goj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUVpp1plkdOHyyFAde2H/Cn0OKs1eY343jIXt+VEfhg6e25IqEkTenBDwlTD0kBf4
	 TWuJ/UbvrzK2VihpOsWF0IaSwXAEkxZ4Mzz2DsgwHWru0nD5lBn1fjiXdHcGHXS/0u
	 kRqudxzqp1lftoa+HgmsSm50bq/jgUdDmVpiy8M6qbT8i4SDa5r7+sYJkdh3z+VPS6
	 jud37U/LvIdCTy4HA4okQOhqwILpyrOY5fjP6r5tkZY3W2bUUTELVjRXnFigCX0Gnh
	 ng1HjGxAv3fRnlLxqYzqbear4pGhLpzjR/1x4O20u28EUXWfjyIjhOuw9eRcZFpeYK
	 kPQGWdgXjVZCg==
Date: Fri, 20 Oct 2023 13:01:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Hathaway <jesse@mbuki-mvuki.org>, Christoph Hellwig <hch@lst.de>,
	Florian Weimer <fweimer@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	giuseppe@scrivano.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
 <38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>

On Fri, Oct 20, 2023 at 10:34:36AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding Christian, the author of what appears to be the culprit]
> 
> On 18.10.23 20:49, Jesse Hathaway wrote:
> > On Wed, Oct 18, 2023 at 1:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> FWIW, this thread afaics was supposed to be in reply to this submission:
> 
> https://lore.kernel.org/all/20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org/
> 
> That patch later became 5d1f903f75a80d ("attr: block mode changes of
> symlinks") [v6.6-rc1, v6.5.5, v6.1.55, v5.4.257, v5.15.133, v5.10.197,
> v4.19.295, v4.14.326]
> 
> >>> Unfortunately, this has not held up in LTSes without causing
> >>> regressions, specifically in crun:
> >>>
> >>> Crun issue and patch
> >>>  1. https://github.com/containers/crun/issues/1308
> >>>  2. https://github.com/containers/crun/pull/1309
> >>
> >> So thre's a fix already for this, they agree that symlinks shouldn't
> >> have modes, so what's the issue?
> > 
> > The problem is that it breaks crun in Debian stable. They have fixed the
> > issue in crun, but that patch may not be backported to Debian's stable
> > version. In other words the patch seems to break existing software in
> > the wild.
> > 
> >> It needs to reverted in Linus's tree first, otherwise you will hit the
> >> same problem when moving to a new kernel.
> > 
> > Okay, I'll raise the issue on the linux kernel mailing list.
> 
> Did you do that? I could not find anything. Just wondering, as right now
> there is still some time to fix this regression before 6.6 is released
> (and then the fix can be backported to the stable trees, too).

I have not seen a report other than the crun fix I commented on.

The crun authors had agreed to fix this in crun. As symlink mode changes
are severly broken to the point that it's not even supported through the
official glibc and musl system call wrappers anymore not having to
revert this from mainline would be the ideal outcome.

So ideally, the crun bugfix would be backported to Debian stable just as
it was already backported to Fedora or crun make a new point release for
the 1.8.* series.

The other option to consider would be to revert the backport of the attr
changes to stable kernels. I'm not sure what Greg's stance on this is
but given that crun versions in -testing already include that fix that
means all future Debian releases will already have a fixed crun version.

That symlink stuff is so brittle and broken that we'd do more long-term
harm by letting it go on. Which is why we did this.

@Linus, this is ultimately your call of course.

