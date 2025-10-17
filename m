Return-Path: <linux-fsdevel+bounces-64507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BABEA989
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DF3E587C31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037426C3B0;
	Fri, 17 Oct 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyrJXv5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFF26AA91;
	Fri, 17 Oct 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716962; cv=none; b=gYX5GYdw8ZFiN4/yI4BIc+nXHM5EynQAPp+naJEWO8+3AL7WFoll3ivAx7RyNr5ngZ9pgYj2xAf9FLsrOjsWG1jzle3Aq+ZNmhb82bL52pt3XY6ip8vfip7UZxw2ZpMwO1zmuyvHgt8TExwRVRx5NxsNGale9oqz/ySWFAMeo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716962; c=relaxed/simple;
	bh=3mM1lWUTizz6VVL4elvU1BRGI2YzNN2VMRwTvXHMgBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX5abz7erciACySjDeK8TXsGlndCyqkNBEJXnNkVhtMegpD83sLgWqpKmi6Yv150oDJQMjeQIcKzKmsdRBDbg0eoSvxEmYNus8JSWBtUzs8+os2o35XbSBlqF7r8kiPJGq8f8fERIFTus6pprVWAxshLBTae2PE6URdM3KuJHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyrJXv5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8862C4CEFE;
	Fri, 17 Oct 2025 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760716961;
	bh=3mM1lWUTizz6VVL4elvU1BRGI2YzNN2VMRwTvXHMgBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyrJXv5ACeinmvzHl5wHECEdtIt9rBJrFJ8bp6CJbsqurAL0J4hn2Bcdw9CoKoChJ
	 ZKhv45UwKPRDAAvkpA2sA3k0CZiyyl17HSISQODpwPBsowr8SlXYv81OwnTwNbWb39
	 Ild3/43ULgbZf4M4dH8yq128Zg0srGNIFqcECBRnz2l2tBP/GH7FMa9PDd40dCtgHt
	 AGswEEmu67omIZ2IjK0ppEM6s2efJAjWI2/XU6+R1COfUi3OCmLytLzj4UZSXGC2y8
	 MLk5zuXafk0BRFgdIOIMg+FPBevs50BmAhTwdGW/wLJxao2ty0oQDdcuQG1NzqNa45
	 JowDMc74vEM+A==
Date: Fri, 17 Oct 2025 09:02:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>,
	akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <20251017160241.GF6174@frogsfrogsfrogs>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
 <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
 <aPFyqwdv1prLXw5I@dread.disaster.area>
 <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>

On Fri, Oct 17, 2025 at 03:28:32PM +0100, Kiryl Shutsemau wrote:
> On Fri, Oct 17, 2025 at 09:33:15AM +1100, Dave Chinner wrote:
> > On Thu, Oct 16, 2025 at 11:22:00AM +0100, Kiryl Shutsemau wrote:
> > > On Wed, Oct 15, 2025 at 10:57:26AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> > > > > On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > > > > > Hi there,
> > > > > > 
> > > > > > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > > > > > with the following:
> > > > > > 
> > > > > > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > > > > > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > > > > > @@ -1,2 +1,10 @@
> > > > > >  QA output created by 749
> > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > >  Silence is golden
> > > > > > 
> > > > > > This test creates small files of various sizes, maps the EOF block, and
> > > > > > checks that you can read and write to the mmap'd page up to (but not
> > > > > > beyond) the next page boundary.
> > > > > > 
> > > > > > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > > > > > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > > > > > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > > > > > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > > > > > to the second 4096 bytes should produce a SIGBUS.
> > > > > 
> > > > > Does anybody actually relies on this behaviour (beyond xfstests)?
> > > > 
> > > > Beats me, but the mmap manpage says:
> > > ...
> > > > POSIX 2024 says:
> > > ...
> > > > From both I would surmise that it's a reasonable expectation that you
> > > > can't map basepages beyond EOF and have page faults on those pages
> > > > succeed.
> > > 
> > > <Added folks form the commit that introduced generic/749>
> > > 
> > > Modern kernel with large folios blurs the line of what is the page.
> > > 
> > > I don't want play spec lawyer. Let's look at real workloads.
> > 
> > Or, more importantly, consider the security-related implications of
> > the change....
> > 
> > > If there's anything that actually relies on this SIGBUS corner case,
> > > let's see how we can fix the kernel. But it will cost some CPU cycles.
> > > 
> > > If it only broke syntactic test case, I'm inclined to say WONTFIX.
> > > 
> > > Any opinions?
> > 
> > Mapping beyond EOF ranges into userspace address spaces is a
> > potential security risk. If there is ever a zeroing-beyond-EOF bug
> > related to large folios (history tells us we are *guaranteed* to
> > screw this up somewhere in future), then allowing mapping all the
> > way to the end of the large folio could expose a -lot more- stale
> > kernel data to userspace than just what the tail of a PAGE_SIZE
> > faulted region would expose.
> 
> Could you point me to the details on a zeroing-beyond-EOF bug?
> I don't have context here.

Create a file whose size is neither aligned to PAGE_SIZE nor the fs
block size.  The pagecache only maps full folios, so the last folio in
the pagecache will have EOF in the middle of it.

So what do you put in the folio beyond EOF?  Most Linux filesystems
write zeroes to the post-EOF bytes at some point before writing the
block out to disk so that we don't persist random stale kernel memory.

Now you want to mmap that EOF folio into a userspace process.  It was
stupid to allow that because the contents of the folio beyond EOF are
undefined.  But we're stuck with this stupid API.

So now we need to zero the post-EOF folio contents before taking the
first fault on the mmap region, because we don't want the userspace
program to be able to load random stale kernel memory.

We also don't want programs to be able to store information in the mmap
region beyond EOF to prevent abuse, so writeback has to zero the post
EOF contents before writing the pagecache to disk.

> But if it is, as you saying, *guaranteed* to happen again, maybe we
> should slap __GFP_ZERO on page cache allocations? It will address the
> problem at the root.

Weren't you complaining upthread about spending CPU cycles?  GFP_ZERO
on every page loaded into the pagecache isn't free either.

> Although, I think you are being dramatic about "*guaranteed*"...

He's not, post-EOF folio zeroing has broken in weird subtle ways every
1-2 years for the nearly 20 years I've worked in filesystems.

> If we solved problem of zeroing upto PAGE_SIZE border, I don't see
> why zeroing upto folio_size() border any conceptually different.
> Might require some bug squeezing, sure.

We already do that, but that's not the issue here.

The issue here is that you are *breaking* XFS behavior that is
documented in the mmap manpage.  This worked as documented in 6.17, and
now it doesn't work.

--D

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

