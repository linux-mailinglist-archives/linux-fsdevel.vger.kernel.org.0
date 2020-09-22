Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4120D274787
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVReA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 13:34:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVReA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:34:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 283B4B040;
        Tue, 22 Sep 2020 17:34:35 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:33:55 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com
Subject: Re: [PATCH 11/15] btrfs: Use inode_lock_shared() for direct writes
 within EOF
Message-ID: <20200922173355.bxacigifg72zavep@fiona>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-12-rgoldwyn@suse.de>
 <f3a6965f-f3e2-9bef-3dc6-b53cdc715833@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a6965f-f3e2-9bef-3dc6-b53cdc715833@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10:52 22/09, Josef Bacik wrote:
> On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Direct writes within EOF are safe to be performed with inode shared lock
> > to improve parallelization with other direct writes or reads because EOF
> > is not changed and there is no race with truncate().
> > 
> > Direct reads are already performed under shared inode lock.
> > 
> > This patch is precursor to removing btrfs_inode->dio_sem.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >   fs/btrfs/file.c | 33 +++++++++++++++++++++------------
> >   1 file changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index d9c3be19d7b3..50092d24eee2 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1977,7 +1977,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >   	loff_t pos;
> >   	ssize_t written = 0;
> > -	bool relock = false;
> >   	ssize_t written_buffered;
> >   	loff_t endbyte;
> >   	int err;
> > @@ -1986,6 +1985,15 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >   	if (iocb->ki_flags & IOCB_NOWAIT)
> >   		ilock_flags |= BTRFS_ILOCK_TRY;
> > +	/*
> > +	 * If the write DIO within EOF,  use a shared lock
> > +	 */
> > +	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
> > +		ilock_flags |= BTRFS_ILOCK_SHARED;
> > +	else if (iocb->ki_flags & IOCB_NOWAIT)
> > +		return -EAGAIN;
> > +
> > +relock:
> 
> Huh?  Why are you making it so EOF extending NOWAIT writes now fail?  We are
> still using ILOCK_TRY here, so we may still not block, am I missing
> something? Thanks,
> 

Yes, this is incorrect. I had thought of this would block on disk space
allocations. But did not consider the prealloc case.

I am removing this check to match the previous behavior.

-- 
Goldwyn
