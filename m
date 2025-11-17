Return-Path: <linux-fsdevel+bounces-68750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B36C65369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B9CB12917F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787242DF13F;
	Mon, 17 Nov 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BruVpwO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7A289374;
	Mon, 17 Nov 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397716; cv=none; b=iRdm4YREyoEMlKViKK6BS6EpOVGCZ0FFF9H88EvHVDXPfGbHp6Jx/OQ20o5gl9P63/kfEou/gPuCMgkdhqPbM/BEeOdDzu+VstTywUDmaGSb0Tm7L4uynVc3+dfZkUYeUnArxH6n1usuCqFDNKqHBVpY8PEhf5Lcl0cWuhxP97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397716; c=relaxed/simple;
	bh=dZ251Jd6bLrB7WwBSwgnKezSZ9PfbBw2z/HUXlRFHck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfaWovyAikNNLbXXe2j+1E2fpQzzAshTzki7+GRkVecebb4VbHISSWLL1C4qoEAKaxUA/rLok998qlemcVRkOOJTZKuuFE1QDQG8+JdbtGxEtv3GlwF7ksHrzSbPoibv8nHq88+NBKUewpF6vxERbipBefCrpu9AVPPfdd1n/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BruVpwO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E29C4CEF1;
	Mon, 17 Nov 2025 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763397716;
	bh=dZ251Jd6bLrB7WwBSwgnKezSZ9PfbBw2z/HUXlRFHck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BruVpwO/difzdwaljwe0afX7jV92ylBmozwdxiXCjvaF6TEIEG5ryBKnybz3fiGT5
	 I1OH4hkoVayKGLETjl491dwOdYOavboux+e7EUqEou8Jg8sYUgmfKJ/FmilBlMrS3D
	 gFGjNykzMWImAvhr3OGZ6uXUaGAEN8F4yY+UfU3uS4JHUF2fO8+rcCnLycChGRwdei
	 u/Ms5MCTO7G36cjNebz8mxWh23JNDqdeNVcacbdpJ26dofOzKHwtIT8k2JzXtdXWco
	 REQtZBARylVp5ozlrK1R6uXUWIptSeqXw7L682LwSLz46BP9qPHYv4P9l68nYe0baS
	 4ri6o4cLaXURg==
Date: Mon, 17 Nov 2025 08:41:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <20251117164155.GB196362@frogsfrogsfrogs>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>

On Sun, Nov 16, 2025 at 10:32:12PM +0000, Matthew Wilcox wrote:
> First, some process things ;-)
> 
> 1. Thank you for working on this.  Andrii has been ignoring it since
> August, which is bad.  So thank you for picking it up.
> 
> 2. Sending a v2 while we're having a discussion is generally a bad idea.
> It's fine to send a patch as a reply, but going as far as a v2 isn't
> necessary.  If conversation has died down, then a v2 is definitely
> warranted, but you and I are still having a discussion ;-)
> 
> 3. When you do send a v2 (or, now that you've sent a v2, send a v3),
> do it as a new thread rather then in reply to the v1 thread.  That plays
> better with the tooling we have like b4 which will pull in all patches
> in a thread.
> 
> With that over with, on to the fun technical stuff.
> 
> On Sun, Nov 16, 2025 at 11:13:42AM +0530, SHAURYA RANE wrote:
> > On Sat, Nov 15, 2025 at 2:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> > > > When read_cache_folio() is called with a NULL filler function on a
> > > > mapping that does not implement read_folio, a NULL pointer
> > > > dereference occurs in filemap_read_folio().
> > > >
> > > > The crash occurs when:
> > > >
> > > > build_id_parse() is called on a VMA backed by a file from a
> > > > filesystem that does not implement ->read_folio() (e.g. procfs,
> > > > sysfs, or other virtual filesystems).
> > >
> > > Not a fan of this approach, to be honest.  This should be caught at
> > > a higher level.  In __build_id_parse(), there's already a check:
> > >
> > >         /* only works for page backed storage  */
> > >         if (!vma->vm_file)
> > >                 return -EINVAL;
> > >
> > > which is funny because the comment is correct, but the code is not.
> > > I suspect the right answer is to add right after it:
> > >
> > > +       if (vma->vm_file->f_mapping->a_ops == &empty_aops)
> > > +               return -EINVAL;
> > >
> > > Want to test that out?
> > Thanks for the suggestion.
> > Checking for
> >     a_ops == &empty_aops
> > is not enough. Certain filesystems for example XFS with DAX use
> > their own a_ops table (not empty_aops) but still do not implement
> > ->read_folio(). In those cases read_cache_folio() still ends up with
> > filler = NULL and filemap_read_folio(NULL) crashes.
> 
> Ah, right.  I had assumed that the only problem was synthetic
> filesystems like sysfs and procfs which can't have buildids because
> buildids only exist in executables.  And neither procfs nor sysfs
> contain executables.
> 
> But DAX is different.  You can absolutely put executables on a DAX
> filesystem.  So we shouldn't filter out DAX here.  And we definitely
> shouldn't *silently* fail for DAX.  Otherwise nobody will ever realise
> that the buildid people just couldn't be bothered to make DAX work.
> 
> I don't think it's necessarily all that hard to make buildid work
> for DAX.  It's probably something like:
> 
> 	if (IS_DAX(file_inode(file)))
> 		kernel_read(file, buf, count, &pos);
> 
> but that's just off the top of my head.

I wondered why this whole thing opencodes kernel_read, but then I
noticed zero fstests for it and decid*******************************
*****.

--D

> 
> I really don't want the check for filler being NULL in read_cache_folio().
> I want it to crash noisily if callers are doing something stupid.
> 

