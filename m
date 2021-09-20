Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9B412608
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385952AbhITSww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 14:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384926AbhITSwh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CF7161390;
        Mon, 20 Sep 2021 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632161220;
        bh=VJ0HmeaO/6/9QHKiIPYhRp8tJEuffdfYSmx8pRQgz9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGBQ5Cz9v/fXix2Kq+QR/smWp5vYrQy+TdVGmTYU8rHmS6DrzWfOhY8zBiEKqSt7Q
         mn4IDy00H9DcjeA7y9z9IwFn9Qa6R53iuRocrAwXcEm5hoznsks9QZKSLBRO1/WaHu
         6FsEdqfBENUAPGG7e+O04lXelHx9izmvviJYI3o1NSxsPP+H6SflqMT5vB5qSudNya
         fyrc6rv0/BZHgZkbHvcp/FrXmU1KZwFDvD+5lYUn6j4YCBRsuq1z7YqCKTbeOAzp+q
         uBIG5A7YqztbUrPCdTnfubVrcylx7KlTZNdPqshxjCeZ2RqMf30uyScYLDvU/gtUn5
         fw6HMmZmnimQg==
Date:   Mon, 20 Sep 2021 11:06:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210920180659.GB570642@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <YUjKSclPPWFmZHwZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjKSclPPWFmZHwZ@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:52:09AM -0700, Eric Biggers wrote:
> On Fri, Sep 17, 2021 at 06:31:01PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new mode to fallocate to zero-initialize all the storage backing a
> > file.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/open.c                   |    5 +++++
> >  include/linux/falloc.h      |    1 +
> >  include/uapi/linux/falloc.h |    9 +++++++++
> >  3 files changed, 15 insertions(+)
> > 
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index daa324606a41..230220b8f67a 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >  	    (mode & ~FALLOC_FL_INSERT_RANGE))
> >  		return -EINVAL;
> >  
> > +	/* Zeroinit should only be used by itself and keep size must be set. */
> > +	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
> > +	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
> > +		return -EINVAL;
> > +
> >  	/* Unshare range should only be used with allocate mode. */
> >  	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
> >  	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > index f3f0b97b1675..4597b416667b 100644
> > --- a/include/linux/falloc.h
> > +++ b/include/linux/falloc.h
> > @@ -29,6 +29,7 @@ struct space_resv {
> >  					 FALLOC_FL_PUNCH_HOLE |		\
> >  					 FALLOC_FL_COLLAPSE_RANGE |	\
> >  					 FALLOC_FL_ZERO_RANGE |		\
> > +					 FALLOC_FL_ZEROINIT_RANGE |	\
> >  					 FALLOC_FL_INSERT_RANGE |	\
> >  					 FALLOC_FL_UNSHARE_RANGE)
> >  
> > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > index 51398fa57f6c..8144403b6102 100644
> > --- a/include/uapi/linux/falloc.h
> > +++ b/include/uapi/linux/falloc.h
> > @@ -77,4 +77,13 @@
> >   */
> >  #define FALLOC_FL_UNSHARE_RANGE		0x40
> >  
> > +/*
> > + * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
> > + * writing zeros to it.  Subsequent read and writes should not fail due to any
> > + * previous media errors.  Blocks must be not be shared or require copy on
> > + * write.  Holes and unwritten extents are left untouched.  This mode must be
> > + * used with FALLOC_FL_KEEP_SIZE.
> > + */
> > +#define FALLOC_FL_ZEROINIT_RANGE	0x80
> > +
> 
> How does this differ from ZERO_RANGE?  Especially when the above says that
> ZEROINIT_RANGE leaves unwritten extents untouched.  That implies that unwritten
> extents are still "allowed".  If that's the case, why not just use ZERO_RANGE?

(Note: I changed the second to last sentence to read "Holes are ignored,
and inline data regions are not supported.")

ZERO_RANGE only guarantees that a subsequent read returns all zeroes,
which means that implementations are allowed to play games with the file
mappings to make that happen with as little work as possible.

ZEROINIT_RANGE implies that the filesystem doesn't change the mappings
at all and actually writes/resets the mapped storage, though I didn't
want to exclude the possibility that the filesystem could change the
mapping as a last resort to guarantee that "subsequent read and writes
should not fail" if the media write fails.

I /could/ encode all that in the definition, but that feels like
overspecifying the implementation.

--D

> - Eric
