Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A575717908F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgCDMmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 07:42:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388023AbgCDMmP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:42:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96B46B360;
        Wed,  4 Mar 2020 12:42:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C735B1E0E99; Wed,  4 Mar 2020 13:42:11 +0100 (CET)
Date:   Wed, 4 Mar 2020 13:42:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200304124211.GC21048@quack2.suse.cz>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
 <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
 <20200303154709.GB8037@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303154709.GB8037@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-03-20 07:47:09, Darrick J. Wong wrote:
> On Mon, Mar 02, 2020 at 02:28:39PM +0530, Ritesh Harjani wrote:
> > 
> > 
> > On 2/28/20 8:55 PM, Darrick J. Wong wrote:
> > > On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
> > > > ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> > > > so just move the API from generic_block_bmap to iomap_bmap for iomap
> > > > conversion.
> > > > 
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >   fs/ext4/inode.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index 6cf3b969dc86..81fccbae0aea 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> > > >   			return 0;
> > > >   	}
> > > > -	return generic_block_bmap(mapping, block, ext4_get_block);
> > > > +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> > > 
> > > /me notes that iomap_bmap will filemap_write_and_wait for you, so one
> > > could optimize ext4_bmap to avoid the double-flush by moving the
> > > filemap_write_and_wait at the top of the function into the JDATA state
> > > clearing block.
> > 
> > IIUC, delalloc and data=journal mode are both mutually exclusive.
> > So we could get rid of calling filemap_write_and_wait() all together
> > from ext4_bmap().
> > And as you pointed filemap_write_and_wait() is called by default in
> > iomap_bmap which should cover for delalloc case.
> > 
> > 
> > @Jan/Darrick,
> > Could you check if the attached patch looks good. If yes then
> > will add your Reviewed-by and send a v6.
> > 
> > Thanks for the review!!
> > 
> > -ritesh
> > 
> > 
> 
> > From 93f560d9a483b4f389056e543012d0941734a8f4 Mon Sep 17 00:00:00 2001
> > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > Date: Tue, 20 Aug 2019 18:36:33 +0530
> > Subject: [PATCH 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
> > 
> > ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> > so just move the API from generic_block_bmap to iomap_bmap for iomap
> > conversion.
> > 
> > Also no need to call for filemap_write_and_wait() any more in ext4_bmap
> > since data=journal mode anyway doesn't support delalloc and for all other
> > cases iomap_bmap() anyway calls the same function, so no need for doing
> > it twice.
> > 
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Hmmm.  I don't recall how jdata actually works, but I get the impression
> here that we're trying to flush dirty data out to the journal and then
> out to disk, and then drop the JDATA state from the inode.  This
> mechanism exists (I guess?) so that dirty file pages get checkpointed
> out of jbd2 back into the filesystem so that bmap() returns meaningful
> results to lilo.

Exactly. E.g. when we are journalling data, we fill hole through mmap, we will
have block allocated as unwritten and we need to write it out so that the
data gets to the journal and then do journal flush to get the data to disk
so that lilo can read it from the devices. So removing
filemap_write_and_wait() when journalling data is wrong.

> This makes me wonder if you still need the filemap_write_and_wait in the
> JDATA case because otherwise the journal flush won't have the effect of
> writing all the dirty pagecache back to the filesystem?  OTOH I suppose
> the implicit write-and-wait call after we clear JDATA will not be
> writing to the journal.
> 
> Even more weirdly, the FIEMAP code doesn't drop JDATA at all...?

Yeah, it should do that but that's only performance optimization so that we
bother with journal flushing only when someone uses block mapping call on
a file with journalled dirty data. So you can hardly notice the bug by
testing...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
