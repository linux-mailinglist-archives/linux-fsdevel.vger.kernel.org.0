Return-Path: <linux-fsdevel+bounces-29620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44997B759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 07:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9391C2295A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4E137C2A;
	Wed, 18 Sep 2024 05:15:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85313A3EC;
	Wed, 18 Sep 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636529; cv=none; b=COinpf9IY/koBZcS8/mWcUeL1HDL/DPqheXesavkkBxY+jCZMO7E1woa8DgBXzdS2AMfOqx9RuI/6C1NyVBHpGAOmRQTdKn9egbbi9wsavqGl0qP3YcrC103YGxc4loNRZ4MlH+0YIGaVYU0b61Zkl5duL1NGCjGDq9FZf3/BHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636529; c=relaxed/simple;
	bh=CwxHztH+gWBZMyLxch/dTrF/ZYXcuboyr07EfNJR1ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOiQ4aVjvZg1aVA4UY83U9dVuH5Puy3UYK5gYjIYuXHxJ7D3Pm/w47WtiThMcibgVdda7FNrmyivPIB5fd0DJeivoJYW24M6LEENMgBebl08g3dGNuKfYFr3BuPwp/poS2Y2gRpz1hAfGh/AlywJhYgMLS6Cm4S9u0oUAud3lfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64C66227AB6; Wed, 18 Sep 2024 07:15:23 +0200 (CEST)
Date: Wed, 18 Sep 2024 07:15:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] iomap: zeroing already holds invalidate_lock
Message-ID: <20240918051523.GC31238@lst.de>
References: <20240910043949.3481298-1-hch@lst.de> <20240910043949.3481298-9-hch@lst.de> <20240917212935.GE182177@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917212935.GE182177@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 02:29:35PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 10, 2024 at 07:39:10AM +0300, Christoph Hellwig wrote:
> > All callers of iomap_zero_range already hold invalidate_lock, so we can't
> > take it again in iomap_file_buffered_write_punch_delalloc.
> > 
> > Use the passed in flags argument to detect if we're called from a zeroing
> > operation and don't take the lock again in this case.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/buffered-io.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 52f285ae4bddcb..3d7e69a542518a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1188,8 +1188,13 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> >  	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> >  	 * cache and perform delalloc extent removal. Failing to do this can
> >  	 * leave dirty pages with no space reservation in the cache.
> > +	 *
> > +	 * For zeroing operations the callers already hold invalidate_lock.
> >  	 */
> > -	filemap_invalidate_lock(inode->i_mapping);
> > +	if (flags & IOMAP_ZERO)
> > +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> 
> Does the other iomap_zero_range user (gfs2) take the invalidate lock?
> AFAICT it doesn't.  Shouldn't we annotate iomap_zero_range to say that
> callers have to hold i_rwsem and the invalidate_lock?

gfs2 does not hold invalidate_lock over iomap_zero_range.  But
it also does not use iomap_file_buffered_write_punch_delalloc at
all, which is what requires the lock (and asserts that it is held).


