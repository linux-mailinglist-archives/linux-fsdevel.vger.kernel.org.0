Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD19274760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIVRZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 13:25:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:46722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRZi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:25:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D68F0ADAD;
        Tue, 22 Sep 2020 17:26:13 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:25:33 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200922172533.kyg7flcfv4cpaebn@fiona>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
 <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
 <20200922163156.GD7949@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922163156.GD7949@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:31 22/09, Darrick J. Wong wrote:
> On Tue, Sep 22, 2020 at 10:20:11AM -0400, Josef Bacik wrote:
> > On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > iomap complete routine can deadlock with btrfs_fallocate because of the
> > > call to generic_write_sync().
> > > 
> > > P0                      P1
> > > inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> > > __iomap_dio_rw()        inode_lock()
> > >                          <block>
> > > <submits IO>
> > > <completes IO>
> > > inode_unlock()
> > >                          <gets inode_lock()>
> > >                          inode_dio_wait()
> > > iomap_dio_complete()
> > >    generic_write_sync()
> > >      btrfs_file_fsync()
> > >        inode_lock()
> > >        <deadlock>
> > > 
> > > inode_dio_end() is used to notify the end of DIO data in order
> > > to synchronize with truncate. Call inode_dio_end() before calling
> > > generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> > > 
> > > ---
> > >   fs/iomap/direct-io.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index d970c6bbbe11..e01f81e7b76f 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > >   			dio_warn_stale_pagecache(iocb->ki_filp);
> > >   	}
> > > +	inode_dio_end(file_inode(iocb->ki_filp));
> > >   	/*
> > >   	 * If this is a DSYNC write, make sure we push it to stable storage now
> > >   	 * that we've written data.
> > > @@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > >   	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> > >   		ret = generic_write_sync(iocb, ret);
> > > -	inode_dio_end(file_inode(iocb->ki_filp));
> > >   	kfree(dio);
> > >   	return ret;
> > > 
> > 
> > Did you verify that xfs or ext4 don't rely on the inode_dio_end() happening
> > before the generic_write_sync()?  I wouldn't expect that they would, but
> > we've already run into problems making those kind of assumptions.  If it's
> > fine you can add
> 
> I was gonna ask the same question, but as there's no SoB on this patch I
> hadn't really looked at it yet. ;)
> 
> Operations that rely on inode_dio_wait to have blocked until all the
> directios are complete could get tripped up by iomap not having done the
> generic_write_sync to stabilise the metadata, but I /think/ most
> operations that do that also themselves flush the file.  But I don't
> really know if there's a subtlety there if the inode_dio_wait thread
> manages to grab the ILOCK before the generic_write_sync thread does.
> 

I ran xfstests and it was successful. I am testing ext4 now.

-- 
Goldwyn
