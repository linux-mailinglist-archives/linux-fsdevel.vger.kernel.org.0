Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C420A433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406845AbgFYRm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 13:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405282AbgFYRm7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:42:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35963AE43;
        Thu, 25 Jun 2020 17:42:57 +0000 (UTC)
Date:   Thu, 25 Jun 2020 12:42:55 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, dsterba@suse.cz,
        jthumshirn@suse.de, fdmanana@gmail.com
Subject: Re: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Message-ID: <20200625174255.j47fr3o47oxi453j@fiona>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
 <20200622152457.7118-2-rgoldwyn@suse.de>
 <20200623055748.GH2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623055748.GH2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15:57 23/06, Dave Chinner wrote:
> On Mon, Jun 22, 2020 at 10:24:52AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Convert wait_for_completion boolean to flags so we can pass more flags
> > to iomap_dio_rw()
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/ext4/file.c        | 11 +++++++++--
> >  fs/gfs2/file.c        |  7 ++++---
> >  fs/iomap/direct-io.c  |  3 ++-
> >  fs/xfs/xfs_file.c     | 10 ++++++----
> >  fs/zonefs/super.c     |  8 ++++++--
> >  include/linux/iomap.h |  9 ++++++++-
> >  6 files changed, 35 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 2a01e31a032c..d20120c4d833 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -53,6 +53,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  {
> >  	ssize_t ret;
> >  	struct inode *inode = file_inode(iocb->ki_filp);
> > +	int flags = 0;
> >  
> >  	if (iocb->ki_flags & IOCB_NOWAIT) {
> >  		if (!inode_trylock_shared(inode))
> > @@ -74,8 +75,11 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  		return generic_file_read_iter(iocb, to);
> >  	}
> >  
> > +	if (is_sync_kiocb(iocb))
> > +		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
> 
> The name of the flag conflates implementation with intent. "wait for
> completion" is the implementation, "synchronous IO" is the intent.
> 
> Can you name this <namespace>_SYNCIO, please? Read further below for
> comments on the flag namespace issues...

Yes, sure. I just hope it is not confused with RWF_SYNC.

> 
> >  		ext4_journal_stop(handle);
> >  	}
> >  
> > +	if (is_sync_kiocb(iocb) || unaligned_io || extend)
> > +		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
> 
> Then stuff like this is self documenting:
> 
> 	if (any of this is true)
> 		IO needs to be issued synchronously
> 
> > @@ -767,6 +767,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
> >  	size_t count = iov_iter_count(to);
> >  	struct gfs2_holder gh;
> >  	ssize_t ret;
> > +	int flags = is_sync_kiocb(iocb) ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0;
> >  
> >  	if (!count)
> >  		return 0; /* skip atime */
> > @@ -777,7 +778,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
> >  		goto out_uninit;
> >  
> >  	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> > -			   is_sync_kiocb(iocb));
> > +			   flags);
> 
> Why do we need a new flags variable here, but not for other
> conversions that are identical? 
> 
> Hmmm - you use 3 different methods of calculating flags to pass
> to iomap_dio_rw() in this patchset. Can you pick one method and use
> it for all the code? e.g. make all the code look like this:
> 
> 	int	flags = 0;
> 
> 
> 	....
> 	if (is_sync_kiocb(iocb)
> 		flags |= IOMAP_DIOF_SYNCIO;
> 	ret = iomap_dio_rw(....., flags);
> 	....
> 
> So the setting of the flags is right next to the iomap_dio_rw()
> call and we don't have to go searching for them?
> 

I agree. Will change this.

> 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index ec7b78e6feca..7ed857196a39 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -405,7 +405,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  ssize_t
> >  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> > -		bool wait_for_completion)
> > +		int dio_flags)
> >  {
> >  	struct address_space *mapping = iocb->ki_filp->f_mapping;
> >  	struct inode *inode = file_inode(iocb->ki_filp);
> > @@ -415,6 +415,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	unsigned int flags = IOMAP_DIRECT;
> >  	struct blk_plug plug;
> >  	struct iomap_dio *dio;
> > +	bool wait_for_completion = !!(dio_flags & IOMAP_DIOF_WAIT_FOR_COMPLETION);
> 
> 1. the compiler will squash (x & y) down to a boolean state
> correctly without needing to add double negatives.
> 

okay, will change this.

> 2. I don't like variable names shadowing core kernel API functions
> (i.e. wait_for_completion()). Especially as this has nothign to do
> with the completion API...

hmm, the change moves the wait_for_completion from function prototype to
a derived variable in the function. This should be a separate patch and
not combined with this change, if really required. wait_for_completion
is also a variable in struct iomap_dio as well.

> 
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 4d1d3c3469e9..f6230446b08d 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -255,9 +255,16 @@ struct iomap_dio_ops {
> >  			struct bio *bio, loff_t file_offset);
> >  };
> >  
> > +/*
> > + * Flags to pass iomap_dio_rw()
> > + */
> > +
> > +/* Wait for completion of DIO */
> > +#define IOMAP_DIOF_WAIT_FOR_COMPLETION 		0x1
> 
> Hmmm. Namespace issues. We already have a IOMAP_DIO_* flags defined
> for passing to ->end_io. It's going to be confusing having a set of
> flags with almost exactly the namespace but with an "F" for flags
> and no indication which iomap operation the flags actually belong to.
> 
> This is simples, though:
> 
> #define IOMAP_DIO_RWF_SYNCIO		(1 << 0)

Agree with this one.

> 
> And it might also be worthwhile renaming the ->endio flags to:
> 
> #define IOMAP_DIO_ENDIO_UNWRITTEN	(1 << 0)
> #define IOMAP_DIO_ENDIO_COW		(1 << 1)
> 
> So there's no confusion there either.
> 

This again should be a separate patch.
I will incorporate the changes relevant to this series.

-- 
Goldwyn
