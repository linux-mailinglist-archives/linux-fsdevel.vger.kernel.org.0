Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC5D0A66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfJII5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 04:57:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44566 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJII5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:57:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so1173771pfn.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EKULkn0mMwEe4Xx6ZVvq+TugGXBB8oK4uiG0s1p/NI=;
        b=iV/y0sojSBbChVlBZiLZch0TQLGFeLZ1nu3NDlbuIbs5aYWTMkfWFUqzBp8Tma+obr
         Is6rLOQD3jnGUv29097G5YiGuvel4JJOR4wOcn9rDFOngO02hrwdHiJgJTVuXqt6flI6
         Fklg3F0ZXFnukjOYuXk+m1fjLnmarbRzM5RQOChZjcRwQMBz+uccs3lFpKm5kcrOTCNe
         jydDAWVhEyhRv52UOoBFkrlggyukF6ngDvK+HHwdLyj1WbfQAl4B2h3QpWWsDrWXB5c0
         oMZVCwbdg2p3NPuwWNYJuk5A4EjwXDyLSFdayh52lfvZn7fNT252hsoC4wUaOBy9THMc
         gsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EKULkn0mMwEe4Xx6ZVvq+TugGXBB8oK4uiG0s1p/NI=;
        b=CBaFdDZAV7fw1SwU+/Y3mZ0PNGQgKc6VRnqJHvMUaI1Hm5lDKMtWNFafkRQILWm13A
         8SG1+DyLxVArVOXbJKXGAfjRYdXt9md65B5Xuz3QPf3oFM1bRAvMuqbgGInKcHBjenqU
         CdDn4yo9BzqUPBTn3a70abHTAwcxcedV35CuBBVxbBGeXO87c58uu1ZYPi84hBMEM/Ol
         7utb8ck8lv/cobvjSrBNJsF1LJ1vtC8AiMDMK8+5jWOc7d8SlaBoYeR8xe3JcDgMfZ2s
         S+x5q9thF17gFhmnIIiKuSbnJjGBArjeXL63LAheZ+goYt9HZg3ywsU1/trFCBc9jkO8
         IN4A==
X-Gm-Message-State: APjAAAUaYkdjIqgokziEhf1589jsFawKtvi7qiMpx8osvm+zrzur/VkN
        wWKvArsn/USo6Ocm5MwHNsDqfAt4pJ5Q
X-Google-Smtp-Source: APXvYqwFaNgdeN87wdDlj053TR5ornG+FmdCq+/xm2yIr3VIXxSxcR+6uMSMh5GilJECsdaaw5Ao1A==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr431206pjn.39.1570611450353;
        Wed, 09 Oct 2019 01:57:30 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id g19sm1714151pgm.63.2019.10.09.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 01:57:29 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:57:23 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191009085721.GA1534@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008102709.GD5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008102709.GD5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 12:27:09PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:33:09, Matthew Bobrowski wrote:
> > +static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
> > +			  unsigned long first_block, struct ext4_map_blocks *map)
> > +{
> > +	u8 blkbits = inode->i_blkbits;
> > +
> > +	iomap->flags = 0;
> > +	if (ext4_inode_datasync_dirty(inode))
> > +		iomap->flags |= IOMAP_F_DIRTY;
> > +	iomap->bdev = inode->i_sb->s_bdev;
> > +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> > +	iomap->offset = (u64) first_block << blkbits;
> > +	iomap->length = (u64) map->m_len << blkbits;
> > +
> > +	if (type) {
> > +		iomap->type = type;
> > +		iomap->addr = IOMAP_NULL_ADDR;
> > +	} else {
> > +		if (map->m_flags & EXT4_MAP_MAPPED) {
> > +			iomap->type = IOMAP_MAPPED;
> > +		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> > +			iomap->type = IOMAP_UNWRITTEN;
> > +		} else {
> > +			WARN_ON_ONCE(1);
> > +			return -EIO;
> > +		}
> > +		iomap->addr = (u64) map->m_pblk << blkbits;
> > +	}
> 
> Looking at this function now, the 'type' argument looks a bit weird. Can we
> perhaps just remove the 'type' argument and change the above to:

We can, but refer to the point below.
 
> 	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> 		if (map->m_flags & EXT4_MAP_MAPPED)
> 			iomap->type = IOMAP_MAPPED;
> 		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
> 			iomap->type = IOMAP_UNWRITTEN;
> 		iomap->addr = (u64) map->m_pblk << blkbits;
> 	} else {
> 		iomap->type = IOMAP_HOLE;
> 		iomap->addr = IOMAP_NULL_ADDR;
> 	}
> 
> And then in ext4_iomap_begin() we overwrite the type to:
> 
> 	if (delalloc && iomap->type == IOMAP_HOLE)
> 		iomap->type = IOMAP_DELALLOC;
> 
> That would IMO make ext4_set_iomap() arguments harder to get wrong.

I was thinking about this while doing a bunch of other things at work
today. I'm kind of aligned with what Christoph mentioned around
possibly duplicating some of the post 'iomap->type' setting from both
current and any future ext4_set_iomap() callers. In addition to this,
my thought was that if we're populating the iomap structure with
values respectively, then it would make most sense to encapsulate
those routines, if possible, within the ext4_set_iomap() as that's the
sole purpose of the function.

However, no real strong objections for dropping 'type', but I just
wanted to share my thoughts.

Also, yes, we probably can drop 'first_block' from the list of
arguments here as we can derive that from 'map' and set 'iomap->type'
accordingly...

--<M>--


