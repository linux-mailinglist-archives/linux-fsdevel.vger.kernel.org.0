Return-Path: <linux-fsdevel+bounces-39831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC9A191F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8211658AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA2212FA6;
	Wed, 22 Jan 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUCNwC3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35D211A18;
	Wed, 22 Jan 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550780; cv=none; b=hL35+7SpRqAfeQaUgBbtljPVrH1270MIiD1/hsiNgVy3t9g1v7AaLkhn37UQvhCH6meF6vGaINtm2e+PYZW8+J6xiDVFy1MVcQH98Y5JV8HSmyngs76OgFAQUPwDZP9iZzYGmTkJ1ncR7V2TvU/klMO2aiwTgFP4ba+gca0LqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550780; c=relaxed/simple;
	bh=1O7EjoRi0846T1wB/xCHnXnCV0yisP9eHE9Wd/n21TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/Vt6LJzBfLxIwbcSsOjZw/B4ESuvYPq9ikYp3rDJRzcoWiNIM5kQw4LB5wEziy/Q5dDuJ1m3KJ3nD4o0OOis1eC2XpgLrJ8kY0cPl1IN4M8/Z8QIX8yPe1hzsG00C4lQKIlkjwNfdEl2/JtcGYd1XN++B+UlSQAifAFiz/bwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUCNwC3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF56C4CED6;
	Wed, 22 Jan 2025 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737550780;
	bh=1O7EjoRi0846T1wB/xCHnXnCV0yisP9eHE9Wd/n21TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUCNwC3od4iDd3W1bJWmIdrRBnggFd1cAG0nRXhKvP88WXWPW54fSQjpH82E08Ltj
	 Ukb0gr5Y6gkYkqzCRXZB86NkRuDqsgjX/Yr5eqC09T87m1N7yNl05mEIqmAQ4OhSlJ
	 8cck40kthlsp8r5MDUibtrlwOh0fJ1q9SMUZZSfdY8zMMnqE2AXwTmCvhN8buQhCrD
	 8VdkBN+Dj0xUlna+oNwACJ7nBnWA8/kr7WKCXYPEXVMziL+QWrJREHHH5CJa/YOz18
	 96O3EpUC/57gfoOKg72l7P6FRxCfJs3+mLL/w94w/g+fcG6Ms/86DbnioCShDMP++b
	 Dh+pNuKqwCpLw==
Date: Wed, 22 Jan 2025 13:59:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250122-juckreiz-weiden-ee15107fd277@brauner>
References: <20250116043226.GA23137@lst.de>
 <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com>
 <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
 <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>

On Mon, Jan 20, 2025 at 04:44:59PM +0100, Andreas Gruenbacher wrote:
> On Mon, Jan 20, 2025 at 4:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> > > On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > > > Well, if you can fix it to start with 1 we could start out with 1
> > > > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > > > because it initialize the lock in the slab init_once callback and
> > > > the count on every initialization.
> > >
> > > Sure, can you add the below patch before the lockref_init conversion?
> > >
> > > Thanks,
> > > Andreas
> > >
> > > --
> > >
> > > gfs2: Prepare for converting to lockref_init
> > >
> > > First, move initializing the glock lockref spin lock from
> > > gfs2_init_glock_once() to gfs2_glock_get().
> > >
> > > Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> > > common case.  Compensate for that in gfs2_quota_init() by adjusting the
> > > count back down to 0; this case occurs only when mounting the filesystem
> > > rw.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> >
> > Can you send this as a proper separae patch, please?
> 
> Do you want this particular version which applies before Christoph's
> patches or something that applies on top of Christoph's patches?

On top, if you don't mind. Thank you!

