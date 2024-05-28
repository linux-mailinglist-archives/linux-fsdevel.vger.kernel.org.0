Return-Path: <linux-fsdevel+bounces-20377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD3A8D27D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 00:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB8A1C243D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AB13E025;
	Tue, 28 May 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHnOiUSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A513DDAC;
	Tue, 28 May 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934687; cv=none; b=epHq+aKb1p6ZeMHG7NONhoXVpvISUVjYUPoLxYmtcJaXLtLZO9HJ3v9Hn1KBh+MDAo+IYJB2Mco/5KF4fB7MuZg75odo+N2ii5LipaGLW7b0hUZmvh87p/Iza1z+JqiUXsUwuZyQuU9K2a0xaJL4M2x9Mp9Sh+sLvGvSgjRrweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934687; c=relaxed/simple;
	bh=aYqfC/oav3Dxx6nj+EL0nvP4OEdvuUFeY3OLYMBdOrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7cBLcO+HCAqPwhqngogWfo0CfBXAyAxJ2dKyvFD6rbZk5cpotcP01q2fIKJ6v1iSyTtBOZOHT+nIaCeNzRS7cVWQ3NqXRuFqLRbbKFRApLD3tKho5t9czg+dle1m/Bp9MZqiT5wyQf8HPxdvceeliu5kOsSaC/xQlc0gE8Pzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AHnOiUSk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vZOElQpuiaEqJ+AG1PBLgmWzbdI73uxou6h0r1JT0ks=; b=AHnOiUSkWSU4HKBy7vrDX/EvGv
	YkyxVRxAWfTW/nfZVF8/dVFazNj9PVaPddeFpEbtqXITNSGOzk9wSnPXnIlY6UwPdOlx8/GyErJ0A
	HecYU1rwk+MhPS1BebegwFDIbsdXvVmh4qeClzqWi0P5uYnFnkxYYTxkTr1I78yd2fRsgTBYMLF7S
	1yDnc/Vi5QCSl5peVNT0s6t/xtwQQ6MmWzK5kBNYvM+XiiTYvxOE2/TFcASrph1rRENoFTm4j2RL1
	6mF38fCR8CeG9e0RZoXfhAWmN6NwtxNpBQA0NGxedQvUCmdFbKqU1LLjg7objCQ8Hye8PNkD1NY7u
	0Dgycd8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC58t-00000002B1c-3x2y;
	Tue, 28 May 2024 22:18:03 +0000
Date: Tue, 28 May 2024 15:18:03 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, da.gomez@samsung.com
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-xfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <ZlZYG7-9-3NR4tdv@bombadil.infradead.org>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
 <20240415155825.GC11948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415155825.GC11948@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 15, 2024 at 08:58:25AM -0700, Darrick J. Wong wrote:
> On Mon, Apr 15, 2024 at 01:10:54AM -0700, Luis Chamberlain wrote:
> > +round_up_to_page_boundary()
> > +{
> > +	local n=$1
> > +	local page_size=$(_get_page_size)
> > +
> > +	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
> 
> Does iomap put a large folio into the pagecache that crosses EOF

When minorder is used care had to be taken to ensure the EOF is properly
respected.  Refer to the patch titled "filemap: cap PTE range to be
created to allowed zero fill in folio_map_range()", with that, we fix
that case to respect the EOF. But since minorder is used the folio is
there.

> > +mread()
> > +{
> > +	local file=$1
> > +	local map_len=$2
> > +	local offset=$3
> > +	local length=$4
> > +
> > +	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
> > +	# causing the shell to print "Bus error" to stderr.  To allow this
> > +	# message to be redirected, execute xfs_io in a new shell instance.
> > +	# However, for this to work reliably, we also need to prevent the new
> > +	# shell instance from optimizing out the fork and directly exec'ing
> > +	# xfs_io.  The easiest way to do that is to append 'true' to the
> > +	# commands, so that xfs_io is no longer the last command the shell sees.
> > +	bash -c "trap '' SIGBUS; $XFS_IO_PROG -r $file \
> > +		-c 'mmap -r 0 $map_len' \
> > +		-c 'mread $offset $length'; true"
> 
> Please hoist the mread() function with generic/574 to common; your copy
> is out of date with the original.

Sure thing! Shall we add _mwrite to common/rc too while at it or do we
wait to get a user for that?

> > +	# A couple of mmap() tests:
> > +	#
> > +	# We are allowed to mmap() up to the boundary of the page size of a
> > +	# data object, but there a few rules to follow we must check for:
> > +	#
> > +	# a) zero-fill test for the data: POSIX says we should zero fill any
> > +	#    partial page after the end of the object. Verify zero-fill.
> > +	# b) do not write this bogus data to disk: on Linux, if we write data
> > +	#    to a partially filled page, it will stay in the page cache even
> > +	#    after the file is closed and unmapped even if it never reaches the
> > +	#    file. Subsequent mappings *may* see the modified content, but it
> > +	#    also can get other data. Since the data read after the actual
> 
> What does "other data" mean?

That depends on the filesystem implementation, it just means we don't
provide a consistent behaviour or enforce a strategy for all filesystems.

> > +	#    object data can vary we just verify the filesize does not change.
> > +	#    This is not true for tmpfs.
> 
> Er... is this file size change a bug?

There is no filesize bug, the comment about tmpfs always ensuring seeing
the actual data since, well, there its kind of write-through. Since we
share the same filemap_map_pages() I'd expect the rest should behave the
same with tmpfs, but since I didn't test that the test skips it for now.

We'll test it, with all the patch "filemap: cap PTE range to be             
created to allowed zero fill in folio_map_range()" on tmpfs, and see if
we can just enable this test there too. Might as well as we're driving
by and sprinkling large folios there too.

  Luis

