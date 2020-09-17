Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE626D351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 07:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQF7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 01:59:41 -0400
Received: from verein.lst.de ([213.95.11.211]:54833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIQF7k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:59:40 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:59:39 EDT
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8744468B05; Thu, 17 Sep 2020 07:52:32 +0200 (CEST)
Date:   Thu, 17 Sep 2020 07:52:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap
 context
Message-ID: <20200917055232.GA31646@lst.de>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com> <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com> <20200903163236.GA26043@lst.de> <20200907000432.GM12096@dread.disaster.area> <20200915214853.iurg43dt52h5z2gp@fiona> <20200917030942.GU12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917030942.GU12096@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:09:42PM +1000, Dave Chinner wrote:
> > > iomap_dio_complete()
> > >   generic_write_sync()
> > >     btrfs_file_fsync()
> > >       inode_lock()
> > >       <deadlock>
> > 
> > Can inode_dio_end() be called before generic_write_sync(), as it is done
> > in fs/direct-io.c:dio_complete()?
> 
> Don't think so.  inode_dio_wait() is supposed to indicate that all
> DIO is complete, and having the "make it stable" parts of an O_DSYNC
> DIO still running after inode_dio_wait() returns means that we still
> have DIO running....
> 
> For some filesystems, ensuring the DIO data is stable may involve
> flushing other data (perhaps we did EOF zeroing before the file
> extending DIO) and/or metadata to the log, so we need to guarantee
> these DIO related operations are complete and stable before we say
> the DIO is done.

inode_dio_wait really just waits for active I/O that writes to or reads
from the file.  It does not imply that the I/O is stable, just like
i_rwsem itself doesn't.  Various file systems have historically called
the syncing outside i_rwsem and inode_dio_wait (in fact that is what the
fs/direct-io.c code does, so XFS did as well until a few years ago), and
that isn't a problem at all - we just can't return to userspace (or call
ki_complete for in-kernel users) before the data is stable on disk.
