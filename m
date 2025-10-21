Return-Path: <linux-fsdevel+bounces-64982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F6BF7CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E99F488A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6D346D9F;
	Tue, 21 Oct 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFZpdOFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8815D1;
	Tue, 21 Oct 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066139; cv=none; b=fbpLR9PNi2+o+GloSk2VijUL50OJTiHZyyV6wWFkIXQr3tdoOZ4EtLIXS8HAH/d8rMnACMeSH8t8xQsBK3HLcVb7Hr5srmnIrmKXFLdMmGDzX98fP5TyfjLG2Hif6UhOxL6dZmIXKpDG2kKVgg6ekmUgL6fjxwmY3v3fQ5gtWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066139; c=relaxed/simple;
	bh=iu0ee6tQWz7F3623BPsbyD2yb1AVcl3Gt5U8+FrbmwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8loIjhG1ITZdVSaI/swnjUJfJXogoC9RxYgsc8qco55pOq8Yr9rcaBVhAfgipFYvy0bWJ2hqiXqReyeoB004r7bFYVripP6iAgMhhigsEFeBUzKwhjbqkJ+2mUHogPa5hjDMblLj36WhhNKQr8uXJ1ym7mjG2yMJ+qrwSiSNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFZpdOFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AD6C4CEF1;
	Tue, 21 Oct 2025 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066139;
	bh=iu0ee6tQWz7F3623BPsbyD2yb1AVcl3Gt5U8+FrbmwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFZpdOFz9jzsZRE9vLqWl3Ln5iKvQfR4QtYtEMg+dsnTgczxpe+AsZcjAyd0Y8Zyq
	 se9VHHbyFK6YRc1tL5rQ+Co5e6RTsPRn8ylk+QfQrIoAYng3ZhtkHHJJFSWwcaIEtz
	 MZvy3lmwFs2DhlzjDObAlMkmQf2ansKd+DM6NQZJ5EC3Xya85lTQvpDrjL3hJ/fTiV
	 sD5vImOS83+nS/stwwPEUJra3WDFt2eUjMHaEY7xyMzrQuEwW9yYDuLtuMMzceVSRc
	 wVfkLIfX3HKaMbROR4bDGtUehwV9OrUz/cccLlvk1oD6XxEBe2hFs0wfBEFPN3tubX
	 r7vlMnqjtBj/A==
Date: Tue, 21 Oct 2025 10:02:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>,
	akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <aPe8merkg654_sVp@bombadil.infradead.org>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
 <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
 <aPFyqwdv1prLXw5I@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPFyqwdv1prLXw5I@dread.disaster.area>

On Fri, Oct 17, 2025 at 09:33:15AM +1100, Dave Chinner wrote:
> On Thu, Oct 16, 2025 at 11:22:00AM +0100, Kiryl Shutsemau wrote:
> > On Wed, Oct 15, 2025 at 10:57:26AM -0700, Darrick J. Wong wrote:
> > > On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > > > > Hi there,
> > > > > 
> > > > > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > > > > with the following:
> > > > > 
> > > > > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > > > > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > > > > @@ -1,2 +1,10 @@
> > > > >  QA output created by 749
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > >  Silence is golden
> > > > > 
> > > > > This test creates small files of various sizes, maps the EOF block, and
> > > > > checks that you can read and write to the mmap'd page up to (but not
> > > > > beyond) the next page boundary.
> > > > > 
> > > > > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > > > > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > > > > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > > > > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > > > > to the second 4096 bytes should produce a SIGBUS.
> > > > 
> > > > Does anybody actually relies on this behaviour (beyond xfstests)?
> > > 
> > > Beats me, but the mmap manpage says:
> > ...
> > > POSIX 2024 says:
> > ...
> > > From both I would surmise that it's a reasonable expectation that you
> > > can't map basepages beyond EOF and have page faults on those pages
> > > succeed.
> > 
> > <Added folks form the commit that introduced generic/749>
> > 
> > Modern kernel with large folios blurs the line of what is the page.
> > 
> > I don't want play spec lawyer. Let's look at real workloads.
> 
> Or, more importantly, consider the security-related implications of
> the change....
> 
> > If there's anything that actually relies on this SIGBUS corner case,
> > let's see how we can fix the kernel. But it will cost some CPU cycles.
> > 
> > If it only broke syntactic test case, I'm inclined to say WONTFIX.
> > 
> > Any opinions?
> 
> Mapping beyond EOF ranges into userspace address spaces is a
> potential security risk. If there is ever a zeroing-beyond-EOF bug
> related to large folios (history tells us we are *guaranteed* to
> screw this up somewhere in future), then allowing mapping all the
> way to the end of the large folio could expose a -lot more- stale
> kernel data to userspace than just what the tail of a PAGE_SIZE
> faulted region would expose.
> 
> Hence allowing applications to successfully fault a (unpredictable)
> distance far beyond EOF because the page cache used a large folio
> spanning EOF seems, to me, to be a very undesirable behaviour to
> expose to userspace.

I think in retrospect, having been involved in carefully crafting
this test, this was certainly an overlooked and clearly valuable use
case for the test which should be documented as otherwise others may
stumble upon it and easily fight it.

So extending the test docs to cover this concern is valuable.

  Luis

