Return-Path: <linux-fsdevel+bounces-68621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 615ADC61E90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A65E64E2F99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956A2D8DCA;
	Sun, 16 Nov 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1D5YNTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAF1862A;
	Sun, 16 Nov 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763332341; cv=none; b=gr6YBUq2xHzQ40Yh8bIIG1caw3WRxHencDQoUoZUsdKN1P+ggcyWjjaqHDAiv4tMvwP+qeTGCiytHyqarP79wHaM0CJLSaX17LuYFNeMylHlhmXr8P+NF9/GcDfyfZUOQFD5Upivvq/7xpCFvIbGyM1cqX+YcV1+bxxS6uH1l2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763332341; c=relaxed/simple;
	bh=Vf+jWNqAJUwHVxpsKk8aEQStzPCnDfTwH8+8AJdCvmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnuCeZSuSjpgA5nGJb2zm3LrU7xqe9+fnumWLLTaHO33EdJU/HiQf0jzmRmg+4aInYj4YLoCxlJqVKjzkYyGn33ViFWYIhsvxVbzd4Yo5fS3QwV5ySb/Ou+YPPNnVD+L7+TNu7r433fIw5n3vQbA7cGv89ucLtolfqlabZW5wpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O1D5YNTP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4dFifphuT1Ey8DYPYtkHFgtfxrd367msl8AST4REB3E=; b=O1D5YNTPQJgIXJcZJEoln+5CeZ
	NNw8VuzPnK/fgPV/GdaodwrE7QkwJKzgVuTUVpOSZ5Hcze3ioQvn8Eap/jh5fuMkv6Z21FeI8+98w
	sq+LWdbYNvrpCuahvExYdYajTIqIGUxykHaClnbq9kgIHRZk6JigPgj67ELtfC8UdhLf1LxsoZdx6
	nDEhXmafcbvPTwxID3dqzHg1+5/Z4We4t3omUTrTL4FaEBkQMPe39A/VuQ5HXxzOiYOGap0cWWTUO
	PaoyOzwp+lcDrfuQjhY1Gu1dsHBAnipYtRoTvFW/yVE2OLZF8xtlJ2PUkRN04t7jCMlRPoc2Jhjmo
	awWIt6hg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKlI4-0000000CqfL-3Rel;
	Sun, 16 Nov 2025 22:32:12 +0000
Date: Sun, 16 Nov 2025 22:32:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, eddyz87@gmail.com,
	andrii@kernel.org, ast@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>

First, some process things ;-)

1. Thank you for working on this.  Andrii has been ignoring it since
August, which is bad.  So thank you for picking it up.

2. Sending a v2 while we're having a discussion is generally a bad idea.
It's fine to send a patch as a reply, but going as far as a v2 isn't
necessary.  If conversation has died down, then a v2 is definitely
warranted, but you and I are still having a discussion ;-)

3. When you do send a v2 (or, now that you've sent a v2, send a v3),
do it as a new thread rather then in reply to the v1 thread.  That plays
better with the tooling we have like b4 which will pull in all patches
in a thread.

With that over with, on to the fun technical stuff.

On Sun, Nov 16, 2025 at 11:13:42AM +0530, SHAURYA RANE wrote:
> On Sat, Nov 15, 2025 at 2:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> > > When read_cache_folio() is called with a NULL filler function on a
> > > mapping that does not implement read_folio, a NULL pointer
> > > dereference occurs in filemap_read_folio().
> > >
> > > The crash occurs when:
> > >
> > > build_id_parse() is called on a VMA backed by a file from a
> > > filesystem that does not implement ->read_folio() (e.g. procfs,
> > > sysfs, or other virtual filesystems).
> >
> > Not a fan of this approach, to be honest.  This should be caught at
> > a higher level.  In __build_id_parse(), there's already a check:
> >
> >         /* only works for page backed storage  */
> >         if (!vma->vm_file)
> >                 return -EINVAL;
> >
> > which is funny because the comment is correct, but the code is not.
> > I suspect the right answer is to add right after it:
> >
> > +       if (vma->vm_file->f_mapping->a_ops == &empty_aops)
> > +               return -EINVAL;
> >
> > Want to test that out?
> Thanks for the suggestion.
> Checking for
>     a_ops == &empty_aops
> is not enough. Certain filesystems for example XFS with DAX use
> their own a_ops table (not empty_aops) but still do not implement
> ->read_folio(). In those cases read_cache_folio() still ends up with
> filler = NULL and filemap_read_folio(NULL) crashes.

Ah, right.  I had assumed that the only problem was synthetic
filesystems like sysfs and procfs which can't have buildids because
buildids only exist in executables.  And neither procfs nor sysfs
contain executables.

But DAX is different.  You can absolutely put executables on a DAX
filesystem.  So we shouldn't filter out DAX here.  And we definitely
shouldn't *silently* fail for DAX.  Otherwise nobody will ever realise
that the buildid people just couldn't be bothered to make DAX work.

I don't think it's necessarily all that hard to make buildid work
for DAX.  It's probably something like:

	if (IS_DAX(file_inode(file)))
		kernel_read(file, buf, count, &pos);

but that's just off the top of my head.


I really don't want the check for filler being NULL in read_cache_folio().
I want it to crash noisily if callers are doing something stupid.

