Return-Path: <linux-fsdevel+bounces-29664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB5497BEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C231F225CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8951C3F3B;
	Wed, 18 Sep 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Lkfi3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621FD299;
	Wed, 18 Sep 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673579; cv=none; b=SZDzqPdCV6TWgdD+cS73I/XRII9EbS5xJ3ZkG375ecVFjR3eDqWvsAF/lTArMgQhB3+DHj/Ke0TfV/gjuetqoHdzsISN91VPyX8h5Aya9P/6hCRawyfx4MSP0UX7WMGZpzYaNLwH+mfj+aTnSwW62ptn+b3mRbtNTI9ZQh/ez8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673579; c=relaxed/simple;
	bh=JhMFgCyRE2KJsygDkKnL8ouO9rP8dH+5wF5gcuklGsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnPfzB5jtbyJ7+Hao0jUCizSZZiHkMaULTqF2iiRAkZnJr/BODWKIQCl/dLgC36os2slwTPZgWRLTvYzl/l9qOXYUbkVUZRtx58wgybPZ2GgOsTSpb4fgF04gcxbsq/FCgwP7Dw93UAWHcNKxQgWesKZjPCkce0jvfo+fuFrJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Lkfi3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0EAC4CEC3;
	Wed, 18 Sep 2024 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726673578;
	bh=JhMFgCyRE2KJsygDkKnL8ouO9rP8dH+5wF5gcuklGsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9Lkfi3mPJJlpc2ufLbTvGPnClz89I5jrJE5Y7TzmlWKiT8kWMUj/l6V/CtEhbfMp
	 uUatZtQnmxnHDe1Ur4BtOw4UZrxntgEnBpe4YglpPXG0vjHb1gZTv0SIW6EUIKvgc0
	 9E3y71aqtY4Iec3M0vcUp7rvqGPZbTlrBsGjWlu48Anzic1gW2FegvBjztacKYq/Gr
	 5XVH4UfsRR8MEFeIBFsHHbeCxYDS41s6Znmt3GqpczTGBAIuOIndBbfdLLSckn0LaO
	 dSs9cla2iKYE+lL0/Id+mQRQWU71kWgpIe42NVzD3eXkDT/Mj2wELSgwtm2i298Mea
	 HiT2jzNcmnVsg==
Date: Wed, 18 Sep 2024 08:32:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] iomap: zeroing already holds invalidate_lock
Message-ID: <20240918153258.GG182177@frogsfrogsfrogs>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-9-hch@lst.de>
 <20240917212935.GE182177@frogsfrogsfrogs>
 <20240918051523.GC31238@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918051523.GC31238@lst.de>

On Wed, Sep 18, 2024 at 07:15:23AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 02:29:35PM -0700, Darrick J. Wong wrote:
> > On Tue, Sep 10, 2024 at 07:39:10AM +0300, Christoph Hellwig wrote:
> > > All callers of iomap_zero_range already hold invalidate_lock, so we can't
> > > take it again in iomap_file_buffered_write_punch_delalloc.
> > > 
> > > Use the passed in flags argument to detect if we're called from a zeroing
> > > operation and don't take the lock again in this case.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/buffered-io.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 52f285ae4bddcb..3d7e69a542518a 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1188,8 +1188,13 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> > >  	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> > >  	 * cache and perform delalloc extent removal. Failing to do this can
> > >  	 * leave dirty pages with no space reservation in the cache.
> > > +	 *
> > > +	 * For zeroing operations the callers already hold invalidate_lock.
> > >  	 */
> > > -	filemap_invalidate_lock(inode->i_mapping);
> > > +	if (flags & IOMAP_ZERO)
> > > +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> > 
> > Does the other iomap_zero_range user (gfs2) take the invalidate lock?
> > AFAICT it doesn't.  Shouldn't we annotate iomap_zero_range to say that
> > callers have to hold i_rwsem and the invalidate_lock?
> 
> gfs2 does not hold invalidate_lock over iomap_zero_range.  But
> it also does not use iomap_file_buffered_write_punch_delalloc at
> all, which is what requires the lock (and asserts that it is held).

Aha, that's why it works.  Silly me, forgetting that gfs2 doesn't do
delalloc.  It was quite relaxing to let everything page out of my brain
these past two weeks... :)

--D

