Return-Path: <linux-fsdevel+bounces-14696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64787E2C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D24281854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1C208B6;
	Mon, 18 Mar 2024 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWCksGSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B54C84;
	Mon, 18 Mar 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736478; cv=none; b=I2IIf1HoofnVSu/lL92d2z61A134HraryNusPnzHGKKJQyUBrX0tUzc/jLwxPQXWasuFZoax2YVBfHJqGNhEMb3a+XB1SXx19I+NMEgvlkIGomyq8LGA0NBMCcgwXvF/mtU6SMWvCTvyXBGp2z3xt10VjGiIqEEvMPr/CTXSsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736478; c=relaxed/simple;
	bh=a/scYvZe8lH9BFMUG+m7SXK41ko6Ci8nCjZMGv34VsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArKizONCvybVA7okTFzOxvp0JjJiuhZj+eaTipWss5suKFNwMizvym9l2/J+jhqjfluSh3PIbnTbdzTp8NRqCzuv+BqjRuoSAQNA6zNhiV/3xlYd4DGbFplsjYB7hvUlbZmC6ea8iLjpP2KoTTca8up2gD+TMf7qUjsldfEYqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWCksGSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C0FC433F1;
	Mon, 18 Mar 2024 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710736477;
	bh=a/scYvZe8lH9BFMUG+m7SXK41ko6Ci8nCjZMGv34VsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWCksGSx99LFPH+kkksu+7VqvV6nvPr0SQdBbg41rwAfcG+tazR0WaIQRpPSZ5tjW
	 IsA2fbZ70FsHJMsxJ/WGcSI5yLqO1tX6iEP1IUZadCzAwnllXMbKkLUl5vvvHAt8pb
	 gtcLBAMPSsZ/q9fZ+h3zpkyUzvJzOXWSxOu2Dogs5+ZXSHbTFw/3GgnR5NHe2o4jH8
	 rrzdNu53MCgy6f4A7r3vv+rR6rFEK1xVuxmQ+8UzQqSjMDS+4ygpVDqHEa26kKx0H6
	 KVYv9m7KPe6B/Oe7bTIN2o+ws13EcLcPU3eKpzv/IV1BYoC9oJ1BJooQf7GVp9U5xy
	 RHSaggNhwRzwg==
Date: Sun, 17 Mar 2024 21:34:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ebiggers@kernel.org, aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/40] xfs: add fs-verity support
Message-ID: <20240318043436.GH1927156@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246327.2684506.14573441099126414062.stgit@frogsfrogsfrogs>
 <ZfecSzBoVDW5328l@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfecSzBoVDW5328l@infradead.org>

On Sun, Mar 17, 2024 at 06:43:39PM -0700, Christoph Hellwig wrote:
> Just skimming over the series from the little I've followed from the
> last rounds (sorry, to busy with various projects):
> 
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -92,6 +92,9 @@ typedef struct xfs_inode {
> >  	spinlock_t		i_ioend_lock;
> >  	struct work_struct	i_ioend_work;
> >  	struct list_head	i_ioend_list;
> > +#ifdef CONFIG_FS_VERITY
> > +	struct xarray		i_merkle_blocks;
> > +#endif
> 
> This looks like very much a blocker to me.  Adding a 16 byte field to
> struct inode that is used just for a few read-only-ish files on
> select few file systems doesn't seem very efficient.  Given that we
> very rarely update it and thus concurrency on the write side doesn't
> matter much, is there any way we could get a away with a fs-wide
> lookup data structure and avoid this?

Only if you can hand a 128-bit key to an xarray. ;)

But in all seriousness, we could have a per-AG xarray that maps
xfs_agino_t to this xarray of merkle blocks.  That would be nice in that
we don't have to touch xfs_icache.c for the shrinker at all.

--D

