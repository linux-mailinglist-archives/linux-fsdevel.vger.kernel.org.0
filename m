Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA1D0F93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfJINGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730858AbfJINGN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:06:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F941AE55;
        Wed,  9 Oct 2019 13:06:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B732B1E4851; Wed,  9 Oct 2019 15:06:09 +0200 (CEST)
Date:   Wed, 9 Oct 2019 15:06:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191009130609.GD5050@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008102709.GD5078@quack2.suse.cz>
 <20191009085721.GA1534@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009085721.GA1534@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-10-19 19:57:23, Matthew Bobrowski wrote:
> On Tue, Oct 08, 2019 at 12:27:09PM +0200, Jan Kara wrote:
> > On Thu 03-10-19 21:33:09, Matthew Bobrowski wrote:
> > > +static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
> > > +			  unsigned long first_block, struct ext4_map_blocks *map)
> > > +{
> > > +	u8 blkbits = inode->i_blkbits;
> > > +
> > > +	iomap->flags = 0;
> > > +	if (ext4_inode_datasync_dirty(inode))
> > > +		iomap->flags |= IOMAP_F_DIRTY;
> > > +	iomap->bdev = inode->i_sb->s_bdev;
> > > +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> > > +	iomap->offset = (u64) first_block << blkbits;
> > > +	iomap->length = (u64) map->m_len << blkbits;
> > > +
> > > +	if (type) {
> > > +		iomap->type = type;
> > > +		iomap->addr = IOMAP_NULL_ADDR;
> > > +	} else {
> > > +		if (map->m_flags & EXT4_MAP_MAPPED) {
> > > +			iomap->type = IOMAP_MAPPED;
> > > +		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> > > +			iomap->type = IOMAP_UNWRITTEN;
> > > +		} else {
> > > +			WARN_ON_ONCE(1);
> > > +			return -EIO;
> > > +		}
> > > +		iomap->addr = (u64) map->m_pblk << blkbits;
> > > +	}
> > 
> > Looking at this function now, the 'type' argument looks a bit weird. Can we
> > perhaps just remove the 'type' argument and change the above to:
> 
> We can, but refer to the point below.
>  
> > 	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> > 		if (map->m_flags & EXT4_MAP_MAPPED)
> > 			iomap->type = IOMAP_MAPPED;
> > 		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
> > 			iomap->type = IOMAP_UNWRITTEN;
> > 		iomap->addr = (u64) map->m_pblk << blkbits;
> > 	} else {
> > 		iomap->type = IOMAP_HOLE;
> > 		iomap->addr = IOMAP_NULL_ADDR;
> > 	}
> > 
> > And then in ext4_iomap_begin() we overwrite the type to:
> > 
> > 	if (delalloc && iomap->type == IOMAP_HOLE)
> > 		iomap->type = IOMAP_DELALLOC;
> > 
> > That would IMO make ext4_set_iomap() arguments harder to get wrong.
> 
> I was thinking about this while doing a bunch of other things at work
> today. I'm kind of aligned with what Christoph mentioned around
> possibly duplicating some of the post 'iomap->type' setting from both
> current and any future ext4_set_iomap() callers. In addition to this,
> my thought was that if we're populating the iomap structure with
> values respectively, then it would make most sense to encapsulate
> those routines, if possible, within the ext4_set_iomap() as that's the
> sole purpose of the function.

Well, what I dislike about 'type' argument is the inconsistency in it's
handling. It is useful only for HOLE/DELALLOC, anything else will just give
you invalid iomap and you have to be careful to pass 0 in that case.

I understand the concern about possible duplication but since only
IOMAP_REPORT cares about IOMAP_DELALLOC, I'm not much concerned about it.
But another sensible API would be to optionally pass 'struct extent_status
*es' argument to ext4_set_iomap() and if this argument is non-NULL,
ext4_set_iomap() will handle the intersection of ext4_map_blocks and
extent_status and deduce appropriate resulting type from that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
