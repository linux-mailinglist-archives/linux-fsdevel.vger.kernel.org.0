Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26911A1A35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH2Mi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:38:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2Mi2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:38:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F114AC67;
        Thu, 29 Aug 2019 12:38:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A8601E3BE6; Thu, 29 Aug 2019 14:38:25 +0200 (CEST)
Date:   Thu, 29 Aug 2019 14:38:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190829123825.GB22939@quack2.suse.cz>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828202619.GG22343@quack2.suse.cz>
 <20190829114515.GB2486@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829114515.GB2486@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-08-19 21:45:17, Matthew Bobrowski wrote:
> > > @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > >  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> > >  		iomap->addr = IOMAP_NULL_ADDR;
> > >  	} else {
> > > -		if (map.m_flags & EXT4_MAP_MAPPED) {
> > > -			iomap->type = IOMAP_MAPPED;
> > > -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > > +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > >  			iomap->type = IOMAP_UNWRITTEN;
> > > +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> > > +			iomap->type = IOMAP_MAPPED;
> > >  		} else {
> > >  			WARN_ON_ONCE(1);
> > >  			return -EIO;
> > 
> > Possibly this hunk should go into a separate patch (since this is not
> > directly related with iomap conversion) with a changelog / comment
> > explaining why we need to check EXT4_MAP_UNWRITTEN first.
> 
> But wouldn't doing so break bisection? Seeing as though we needed to
> change this statement specifically to accommodate for the weirdness
> being returned from ext4_map_blocks()? i.e. map.m_flags being set to
> either of the following:
> 
> 	- (EXT4_MAP_NEW | EXT4_MAP_MAPPED)
>         or
>         - (EXT4_MAP_NEW | EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)
> 
> So, if we left the statement in its original form, we'd allocate
> unwritten extents but never actually get around to converting them in
> ext4_dio_write_end_io() as IOMAP_DIO_UNWRITTEN would never be set?

By splitting into a separate patch, I meant that patch would go before this
one. Original code in ext4_iomap_begin() never called ext4_map_blocks()
with a set of flags that can return with both EXT4_MAP_MAPPED and
EXT4_MAP_UNWRITTEN set so that patch would be a no-op but would fix that
landmine you tripped over.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
