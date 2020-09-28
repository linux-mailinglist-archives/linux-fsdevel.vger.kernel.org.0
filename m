Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C763327B081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1PFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 11:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1PFj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDD19ACB7;
        Mon, 28 Sep 2020 15:05:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27A8DDA701; Mon, 28 Sep 2020 17:04:19 +0200 (CEST)
Date:   Mon, 28 Sep 2020 17:04:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/14] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200928150418.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-5-rgoldwyn@suse.de>
 <20200926015108.GQ7964@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926015108.GQ7964@magnolia>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:51:08PM -0700, Darrick J. Wong wrote:
> On Thu, Sep 24, 2020 at 11:39:11AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > iomap complete routine can deadlock with btrfs_fallocate because of the
> > call to generic_write_sync().
> > 
> > P0                      P1
> > inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> > __iomap_dio_rw()        inode_lock()
> >                         <block>
> > <submits IO>
> > <completes IO>
> > inode_unlock()
> >                         <gets inode_lock()>
> >                         inode_dio_wait()
> > iomap_dio_complete()
> >   generic_write_sync()
> >     btrfs_file_fsync()
> >       inode_lock()
> >       <deadlock>
> > 
> > inode_dio_end() is used to notify the end of DIO data in order
> > to synchronize with truncate. Call inode_dio_end() before calling
> > generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> > 
> > This matches the way it is done in fs/direct-io.c:dio_complete().
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Looks ok (at least with the fses that use either iomap or ye olde
> directio) to me...
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> So, uh, do you want me to pull these two iomap patches in for 5.10?

That would be great, thanks. Once they land in 5.10-rc we'll be able to
base the rest on some master snapshot and target 5.11 for release.
