Return-Path: <linux-fsdevel+bounces-24158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090C93A94A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 00:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F0E1C22467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E8148FFA;
	Tue, 23 Jul 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWKlxAlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9C1422AB;
	Tue, 23 Jul 2024 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773564; cv=none; b=JT29VyPKfuQnrNhT8aiapARQsdrBRcgM6rODL+DBx5S7BejWMDblQeNLoxpmZQTSh6kielH7Niz99Xfy50/N1qtDMc8CCIg8qLxn5xedfiVU8CZZOT18oEJhetTA2F2rdWp7QsmzwQ5OBaWehjX7eMaJf92h4NTqP+/H0NLBqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773564; c=relaxed/simple;
	bh=BhZgnSGXK8BXEFbXfI+VVvx3DEH0lCNYXTkyl825K3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mImLZYbZDBhiHXrIVtm7wcqOP2s3vXr/NDgdER+tQ7mCZNIRGG2rEbaMri1osZ3Er+al+NyDybliBrfmC3s7iSX4HFCDPOp5i8KjH6+zpOgBg624NW8631x5fKBcsw+MLFQ2xcQHBnwRNZPuEqITmYPiL466CqI8izIhKlJ5NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWKlxAlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133B4C4AF09;
	Tue, 23 Jul 2024 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773564;
	bh=BhZgnSGXK8BXEFbXfI+VVvx3DEH0lCNYXTkyl825K3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWKlxAlTnSofuPsl+O1bPfHxh0J2B7xakdNILB60bjSnxUjM08PcOfQ09OlJBJcI7
	 UozqAakFcvVSnNESkfXCppd8Nf+higCA1XNquqxE2Xvj2p/+khxCxIhsS1FO0nLMq/
	 quflLjduLEIUAxFB6dhDxkB8YchB9LWI/OtjFRkqRpTmRwYOJtsJRRtoqVnKyMlur6
	 BWbNo99d0G2O1sfm8iVvnG8Z0kGkGJHvAIRKKKK5ttx0hBvLOwLgHzBV8SRaQDTnSw
	 hYK54a9xGcdPwfcaviZJ+u8j7dO/ZVGtc6DOkMljxzWhi94xRE5XeuTAftuJfCCus3
	 IqV7WKNtH7bTA==
Date: Tue, 23 Jul 2024 15:26:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	chandan.babu@oracle.com, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240723222603.GS612460@frogsfrogsfrogs>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
 <20240723144159.GB20891@lst.de>
 <2fd991cc-8f29-47ce-a78a-c11c79d74e07@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd991cc-8f29-47ce-a78a-c11c79d74e07@oracle.com>

On Tue, Jul 23, 2024 at 04:01:41PM +0100, John Garry wrote:
> On 23/07/2024 15:42, Christoph Hellwig wrote:
> > On Tue, Jul 23, 2024 at 11:11:28AM +0100, John Garry wrote:
> > > I am looking at something like this to implement read-only for those inodes:
> > 
> > Yikes.  Treating individual inodes in a file systems as read-only
> > is about the most confusing and harmful behavior we could do.
> 
> That was the suggestion which I was given earlier in this thread.

Well, Christoph and I suggested failing the mount /earlier/ in this
thread. ;)

> > 
> > Just treat it as any other rocompat feature please an mount the entire
> > file system read-only if not supported.
> > 
> > Or even better let this wait a little, and work with Darrick to work
> > on the rextsize > 1 reflіnk patches and just make the thing work.
> 
> I'll let Darrick comment on this.

COW with alloc_unit > fsblock is not currently possible, whether it's
forcealign or rtreflink because COW must happen at allocation unit
granularity.  Pure overwrites don't need all these twists and turns.

1. For COW to work, each write/page_mkwrite must mark dirty every
fsblock in the entire alloc unit.  Those fsblocks could be cached by
multiple folios, which means (in iomap terms) dirtying each block in
potentially multiple iomap_folio_state structures, as well as their
folios.

2. Similarly, writeback must then be able to issue IO in quantities that
are aligned to allocation units.  IOWs, for every dirty region in the
file, we'd have to find the folios for a given allocation unit, mark
them all for writeback, and issue bios for however much we managed to
do.  If it's not possible to grab a folio, then the entire allocation
unit can't be written out, which implies that writeback can fail to
fully clean folios.

3. Alternately I suppose we could track the number of folios undergoing
writeback for each allocation unit, issue the writeback ios whenever
we're ready, and only remap the allocation unit when the number of
folios undergoing writeback for that allocation unit reaches zero.

If we could get the mapping_set_folio_order patch merged, then we could
at least get partial support for power-of-two alloc_unit > fsblock
configurations by setting the minimum folio order to log2(alloc_unit).
For atomic writes this is probably a hard requirement because we must be
able to submit one bio with one memory region.

For everyone else this sucks because cranking up the min folio order
reduces the flexibility that the page cache can have in finding cache
memory... but until someone figures out how to make the batching work,
there's not much progress to be made.

For non power-of-two alloc_unit we can't just crank up the min folio
order because there will always be misalignments somewhere; we need a
full writeback batching implementation that can handle multiple folios
per alloc unit and partial folio writeback.

djwong-dev implements 1.  It partially handles 2 by enlarging the wbc
range to be aligned to allocation units, but it doesn't guarantee that
all the folios actually got tagged for the batch.  It can't do 3, which
means that it's probably broken if you press it hard enough.

Alternately we could disallow non power-of-two everywhere, which would
make the accounting simpler but that's a regression against ye olde xfs
which supports non power-of-two allocation units.

rtreflink is nowhere near ready to go -- it's still in djwong-wtf behind
metadata directories, rtgroups, realtime rmap, and (probably) hch's
zns patches.

> > > > So what about forcealign and RT?
> > > 
> > > Any opinion on this?
> > 
> > What about forcealign and RT?
> 
> In this series version I was mounting the whole FS as RO if
> XFS_FEAT_FORCEALIGN and XFS_FEAT_REFLINK was found in the SB. And so very
> different to how I was going to individual treat inodes which happen to be
> forcealign and reflink, above.
> 
> So I was asking guidance when whether that approach (for RT and forcealign)
> is sound.

I reiterate: don't allow mounting of (forcealign && reflink) or
(forcealign && rtextsize > 1) filesystems, and then you and I can work
on figuring out the rest.

--D

