Return-Path: <linux-fsdevel+bounces-21799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3C90A61B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 08:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8474B1F247C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02418734A;
	Mon, 17 Jun 2024 06:51:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647E18628B;
	Mon, 17 Jun 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607071; cv=none; b=F5DSccw7YPzSiqr8gAqBZ+izE1dvR2POUtUIRbdNH1Zc6Uj5ar9hlIELXwnSPxMT5EPp0W2lYsQdJnFdldmdDNR0D7UDrJDtJ0gK0oc68thjW6PvUTxfHsyp5lFYDt9ZmJWHx6Vw9dzOHhuKJaYLJrOJu+P4p3lI16qFBVL93Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607071; c=relaxed/simple;
	bh=FMRBqddaOq7uQyN1fG8UkeseTiVxjGQallMuh56qp1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq56pCbt+/Yg/v3S2LNYRlyHdVT1PJRnK1/b8dMvo4VF9QiraR9MSagz0wUwwiNn8hAOHxZO8sgk+7hutVYYy5Ma4QdwAqC0nXz938r5GusPo+Ssg9iQ1foQIuBbv4VPkXi+AFht8CdP6YA+3TyODAAdBUyA2gQgybdjOfaaVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91B8668B05; Mon, 17 Jun 2024 08:51:04 +0200 (CEST)
Date: Mon, 17 Jun 2024 08:51:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 11/11] xfs: enable block size larger than page size
 support
Message-ID: <20240617065104.GA18547@lst.de>
References: <20240607145902.1137853-1-kernel@pankajraghav.com> <20240607145902.1137853-12-kernel@pankajraghav.com> <20240613084725.GC23371@lst.de> <Zm+RhjG6DUoat7lO@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm+RhjG6DUoat7lO@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 17, 2024 at 11:29:42AM +1000, Dave Chinner wrote:
> > > +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > > +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> > > +	else
> > > +		igeo->min_folio_order = 0;
> > >  }
> > 
> > The minimum folio order isn't really part of the inode (allocation)
> > geometry, is it?
> 
> I suggested it last time around instead of calculating the same
> constant on every inode allocation. We're already storing in-memory
> strunct xfs_inode allocation init values in this structure. e.g. in
> xfs_inode_alloc() we see things like this:

While new_diflags2 isn't exactly inode geometry, it at least is part
of the inode allocation.  Folio min order for file data has nothing
to do with this at all.

> The only other place we might store it is the struct xfs_mount, but
> given all the inode allocation constants are already in the embedded
> mp->m_ino_geo structure, it just seems like a much better idea to
> put it will all the other inode allocation constants than dump it
> randomly into the struct xfs_mount....

Well, it is very closely elated to say the m_blockmask field in
struct xfs_mount.  The again modern CPUs tend to get a you simple
subtraction for free in most pipelines doing other things, so I'm
not really sure it's worth caching for use in inode allocation to
start with, but I don't care strongly about that.

