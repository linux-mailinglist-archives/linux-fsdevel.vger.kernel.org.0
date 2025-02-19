Return-Path: <linux-fsdevel+bounces-42130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619CCA3CC5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB913B27A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C425A2C8;
	Wed, 19 Feb 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5O7EeM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE617CA12;
	Wed, 19 Feb 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004319; cv=none; b=QB7WVwcCBVYSwvYx2qmOtjEFxewfkHqupt6Qnl4KPrMyc3cNE/65OcItbwqy0LsIns9HiEwDOYOj5dvjuNNL0iYWdm8yYV1L936uUDAzyBdX/hKl+hjjadnLW2VV1ff3ATxiFRzcinN1qQAnDgCFEQD988HWu5olpMeN8Pa0flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004319; c=relaxed/simple;
	bh=GEUpahsgaTjUKu6d9vdqNrav7AuflItWoHWwzOj3LMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtCnJh3pBOJRNUUIRUCrph7BpWZmFgRhHSPdjGZieJT7mOScRvqlTF5UXOEaQz4mS0LzFHMyKZg3mo4RK/Q0cNEUCXIj8pxfp9n+82ObfrFlKERurJQ6sUF7/MWwZxHqB0D27gkmbcWtOI/icVXvKUVZ5EnODa/vxdK5dyWakh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5O7EeM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41657C4CED1;
	Wed, 19 Feb 2025 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004319;
	bh=GEUpahsgaTjUKu6d9vdqNrav7AuflItWoHWwzOj3LMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5O7EeM2zE3MHjqqYn9o//ukEl1Xl8tAf/8rf0L4666yDzXQDiW1tqjHLaAcO+RUt
	 uyT5k20tN4mknIhEgqtOiaRP99xHeUGWFTmIEzYs3FvVaGlghXRgheZ89a2c1bAU+O
	 ZOGfrDIb9Tc8ivNl7tOIg02pweKeHgA116Qwvo6I8Vhs2d6iQ35d9akvQUEBnx66Jo
	 giNRq8Yh2Vs/bayqoxutFwsQFtOV+OB+g+5/IjtkLi0FspqU1Hvz2IpkLZQ3tY67Jv
	 8PuiklEB3hpw45q9kM2LZhRQ25fe458f/CdMGb5kBDwTnVpq3dEUjARZcb06IKEpyS
	 fOWOIaJLIl56A==
Date: Wed, 19 Feb 2025 14:31:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 03/12] iomap: convert misc simple ops to incremental
 advance
Message-ID: <20250219223158.GI21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-4-bfoster@redhat.com>
 <20250219222428.GD21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219222428.GD21808@frogsfrogsfrogs>

On Wed, Feb 19, 2025 at 02:24:28PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 19, 2025 at 12:50:41PM -0500, Brian Foster wrote:
> > Update several of the remaining iomap operations to advance the iter
> > directly rather than via return value. This includes page faults,
> > fiemap, seek data/hole and swapfile activation.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c |  2 +-
> >  fs/iomap/fiemap.c      | 18 +++++++++---------
> >  fs/iomap/seek.c        | 12 ++++++------
> >  fs/iomap/swapfile.c    |  7 +++++--
> >  4 files changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 215866ba264d..ddc82dab6bb5 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1480,7 +1480,7 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
> >  		folio_mark_dirty(folio);
> >  	}
> >  
> > -	return length;
> > +	return iomap_iter_advance(iter, &length);
> 
> Same dorky question here -- doesn't iomap_iter_advance return int, so
> all these functions can now return int instead of loff_t?

Same dorky answer too!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> --D
> 
> >  }
> >  
> >  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> > diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> > index 610ca6f1ec9b..8a0d8b034218 100644
> > --- a/fs/iomap/fiemap.c
> > +++ b/fs/iomap/fiemap.c
> > @@ -39,24 +39,24 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
> >  			iomap->length, flags);
> >  }
> >  
> > -static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_fiemap_iter(struct iomap_iter *iter,
> >  		struct fiemap_extent_info *fi, struct iomap *prev)
> >  {
> > +	u64 length = iomap_length(iter);
> >  	int ret;
> >  
> >  	if (iter->iomap.type == IOMAP_HOLE)
> > -		return iomap_length(iter);
> > +		goto advance;
> >  
> >  	ret = iomap_to_fiemap(fi, prev, 0);
> >  	*prev = iter->iomap;
> > -	switch (ret) {
> > -	case 0:		/* success */
> > -		return iomap_length(iter);
> > -	case 1:		/* extent array full */
> > -		return 0;
> > -	default:	/* error */
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > +	if (ret == 1)	/* extent array full */
> > +		return 0;
> > +
> > +advance:
> > +	return iomap_iter_advance(iter, &length);
> >  }
> >  
> >  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> > diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> > index a845c012b50c..83c687d6ccc0 100644
> > --- a/fs/iomap/seek.c
> > +++ b/fs/iomap/seek.c
> > @@ -10,7 +10,7 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/pagevec.h>
> >  
> > -static loff_t iomap_seek_hole_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_seek_hole_iter(struct iomap_iter *iter,
> >  		loff_t *hole_pos)
> >  {
> >  	loff_t length = iomap_length(iter);
> > @@ -20,13 +20,13 @@ static loff_t iomap_seek_hole_iter(const struct iomap_iter *iter,
> >  		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
> >  				iter->pos, iter->pos + length, SEEK_HOLE);
> >  		if (*hole_pos == iter->pos + length)
> > -			return length;
> > +			return iomap_iter_advance(iter, &length);
> >  		return 0;
> >  	case IOMAP_HOLE:
> >  		*hole_pos = iter->pos;
> >  		return 0;
> >  	default:
> > -		return length;
> > +		return iomap_iter_advance(iter, &length);
> >  	}
> >  }
> >  
> > @@ -56,19 +56,19 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_seek_hole);
> >  
> > -static loff_t iomap_seek_data_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_seek_data_iter(struct iomap_iter *iter,
> >  		loff_t *hole_pos)
> >  {
> >  	loff_t length = iomap_length(iter);
> >  
> >  	switch (iter->iomap.type) {
> >  	case IOMAP_HOLE:
> > -		return length;
> > +		return iomap_iter_advance(iter, &length);
> >  	case IOMAP_UNWRITTEN:
> >  		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
> >  				iter->pos, iter->pos + length, SEEK_DATA);
> >  		if (*hole_pos < 0)
> > -			return length;
> > +			return iomap_iter_advance(iter, &length);
> >  		return 0;
> >  	default:
> >  		*hole_pos = iter->pos;
> > diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> > index b90d0eda9e51..4395e46a4dc7 100644
> > --- a/fs/iomap/swapfile.c
> > +++ b/fs/iomap/swapfile.c
> > @@ -94,9 +94,11 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
> >   * swap only cares about contiguous page-aligned physical extents and makes no
> >   * distinction between written and unwritten extents.
> >   */
> > -static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_swapfile_iter(struct iomap_iter *iter,
> >  		struct iomap *iomap, struct iomap_swapfile_info *isi)
> >  {
> > +	u64 length = iomap_length(iter);
> > +
> >  	switch (iomap->type) {
> >  	case IOMAP_MAPPED:
> >  	case IOMAP_UNWRITTEN:
> > @@ -132,7 +134,8 @@ static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
> >  			return error;
> >  		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
> >  	}
> > -	return iomap_length(iter);
> > +
> > +	return iomap_iter_advance(iter, &length);
> >  }
> >  
> >  /*
> > -- 
> > 2.48.1
> > 
> > 
> 

