Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6ED2018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 07:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfJJFjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 01:39:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfJJFjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:39:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id i32so2910012pgl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 22:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQ8qLkYxE3s0aj/7O2LxSmHAT6SGLjMyMlog3ylNc2I=;
        b=nf3VoIshCTmDpZ0oex/t5ARoB3VgkbQuNWiDByqqqC//+0GDmW/7qKTuiv9Py8F8oO
         6+pdWDVOp1zrT9x99x1szhVN2H3SbfQMqRYIQBtK1XzYSy+z/znzKPP7edXgzcDSRNSO
         AO8CchB7kaot693N5W81/j3mqPT/bR4eqCV1McMLmWdvNsF4tkZ41xmMcWF5xiZkT7Y1
         KtTodBivEBrK2f7pehC8jAWkd/+jFVI9H7VF3YbLhrIsLj9pjUXNaWDNMfmgObVJ5W9D
         BA8yLQUR0AaflJVIpjTHybWJ4XC6bZX6lfVzcsvm+Y4z23r74p5/LzCsnAimeNKhXMAq
         ruUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQ8qLkYxE3s0aj/7O2LxSmHAT6SGLjMyMlog3ylNc2I=;
        b=NqxmL3UEvqoR6w4xbYb0u1XW+HPjB7t0qmceDszJuEuo5HGYE6usKJkrZqYogvdlbD
         xNXRGpmm4pT/oKJOlHa/hENXnIa1obwSjHUSd9INURG/uryVaEchBv5bzc82fmcH+ctY
         fhe4HFEMebw67wkydLgMB/CS4RSNk5kLk23lrxR2LcLepaudjAzH6jpvd33lmMZBK/CA
         Ne9jeDtPABrT/GL42QdS1AQbNdUFJCr5njzPOKReOWDD36BGO42R7MkaNOuftiVanw46
         pIKrhkAnbilpLIr2wgkF+zQxiHgdQ3IW1VOvjQW1D/t7x3VBetKmP5WA8a/HiJJqQYyG
         3pHg==
X-Gm-Message-State: APjAAAUXWnmAXSREsp/TZuEbMvMWvG9GwVvLDvuvdSm3fYDAJOIbh4PR
        VkLVrEvB9t0p2EilGMnXNJWs
X-Google-Smtp-Source: APXvYqzhWcEu9gXKSMHhfEBtAqyrEPhfXh8alzTCj23YWGqJxc1mi6M24/+aV0jumaZ3ueAU5FGzDA==
X-Received: by 2002:a65:67c8:: with SMTP id b8mr8956182pgs.121.1570685971380;
        Wed, 09 Oct 2019 22:39:31 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id u65sm5030390pfu.104.2019.10.09.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 22:39:30 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:39:24 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191010053924.GC19064@bobrowski>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008102709.GD5078@quack2.suse.cz>
 <20191009085721.GA1534@poseidon.bobrowski.net>
 <20191009130609.GD5050@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009130609.GD5050@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:06:09PM +0200, Jan Kara wrote:
> On Wed 09-10-19 19:57:23, Matthew Bobrowski wrote:
> > On Tue, Oct 08, 2019 at 12:27:09PM +0200, Jan Kara wrote:
> > > On Thu 03-10-19 21:33:09, Matthew Bobrowski wrote:
> > > > +static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
> > > > +			  unsigned long first_block, struct ext4_map_blocks *map)
> > > > +{
> > > > +	u8 blkbits = inode->i_blkbits;
> > > > +
> > > > +	iomap->flags = 0;
> > > > +	if (ext4_inode_datasync_dirty(inode))
> > > > +		iomap->flags |= IOMAP_F_DIRTY;
> > > > +	iomap->bdev = inode->i_sb->s_bdev;
> > > > +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> > > > +	iomap->offset = (u64) first_block << blkbits;
> > > > +	iomap->length = (u64) map->m_len << blkbits;
> > > > +
> > > > +	if (type) {
> > > > +		iomap->type = type;
> > > > +		iomap->addr = IOMAP_NULL_ADDR;
> > > > +	} else {
> > > > +		if (map->m_flags & EXT4_MAP_MAPPED) {
> > > > +			iomap->type = IOMAP_MAPPED;
> > > > +		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> > > > +			iomap->type = IOMAP_UNWRITTEN;
> > > > +		} else {
> > > > +			WARN_ON_ONCE(1);
> > > > +			return -EIO;
> > > > +		}
> > > > +		iomap->addr = (u64) map->m_pblk << blkbits;
> > > > +	}
> > > 
> > > Looking at this function now, the 'type' argument looks a bit weird. Can we
> > > perhaps just remove the 'type' argument and change the above to:
> > 
> > We can, but refer to the point below.
> >  
> > > 	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> > > 		if (map->m_flags & EXT4_MAP_MAPPED)
> > > 			iomap->type = IOMAP_MAPPED;
> > > 		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
> > > 			iomap->type = IOMAP_UNWRITTEN;
> > > 		iomap->addr = (u64) map->m_pblk << blkbits;
> > > 	} else {
> > > 		iomap->type = IOMAP_HOLE;
> > > 		iomap->addr = IOMAP_NULL_ADDR;
> > > 	}
> > > 
> > > And then in ext4_iomap_begin() we overwrite the type to:
> > > 
> > > 	if (delalloc && iomap->type == IOMAP_HOLE)
> > > 		iomap->type = IOMAP_DELALLOC;
> > > 
> > > That would IMO make ext4_set_iomap() arguments harder to get wrong.
> > 
> > I was thinking about this while doing a bunch of other things at work
> > today. I'm kind of aligned with what Christoph mentioned around
> > possibly duplicating some of the post 'iomap->type' setting from both
> > current and any future ext4_set_iomap() callers. In addition to this,
> > my thought was that if we're populating the iomap structure with
> > values respectively, then it would make most sense to encapsulate
> > those routines, if possible, within the ext4_set_iomap() as that's the
> > sole purpose of the function.
> 
> Well, what I dislike about 'type' argument is the inconsistency in it's
> handling. It is useful only for HOLE/DELALLOC, anything else will just give
> you invalid iomap and you have to be careful to pass 0 in that case.
> 
> I understand the concern about possible duplication but since only
> IOMAP_REPORT cares about IOMAP_DELALLOC, I'm not much concerned about it.
> But another sensible API would be to optionally pass 'struct extent_status
> *es' argument to ext4_set_iomap() and if this argument is non-NULL,
> ext4_set_iomap() will handle the intersection of ext4_map_blocks and
> extent_status and deduce appropriate resulting type from that.

I see and thank you for sharing your view point. Let's go with what you
originally proposed, which is dropping the 'type' argument and then handling
IOMAP_DELALLOC within ext4_set_iomap(). No real hard objections. :)

--<M>--
