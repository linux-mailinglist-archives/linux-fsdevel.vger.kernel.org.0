Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4488BC852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405807AbfIXM52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 08:57:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395349AbfIXM52 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:57:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B9FBAC10;
        Tue, 24 Sep 2019 12:57:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03AA91E4215; Tue, 24 Sep 2019 12:57:31 +0200 (CEST)
Date:   Tue, 24 Sep 2019 12:57:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190924105730.GA11819@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
 <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-09-19 14:30:15, Ritesh Harjani wrote:
> On 9/17/19 4:07 AM, Matthew Bobrowski wrote:
> > On Mon, Sep 16, 2019 at 05:12:48AM -0700, Christoph Hellwig wrote:
> > > > +	if (offset + count > i_size_read(inode) ||
> > > > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > > > +		ext4_update_i_disksize(inode, inode->i_size);
> > > > +		extend = true;
> > > 
> > > Doesn't the ext4_update_i_disksize need to be under an open journal
> > > handle?
> > 
> > After all, it is a metadata update, which should go through an open journal
> > handle.
> 
> Hmmm, it seems like a race here. But I am not sure if this is just due to
> not updating i_disksize under open journal handle.
> 
> 
> So if we have a delayed buffered write to a file,
> in that case we first only update inode->i_size and update
> i_disksize at writeback time
> (i.e. during block allocation).
> In that case when we call for ext4_dio_write_iter
> since offset + len > i_disksize, we call for ext4_update_i_disksize().
> 
> Now if writeback for some reason failed. And the system crashes, during the
> DIO writes, after the blocks are allocated. Then during reboot we may have
> an inconsistent inode, since we did not add the inode into the
> orphan list before we updated the inode->i_disksize. And journal replay
> may not succeed.

OK, let me clear out some confusion here.

> 1. Can above actually happen? I am still not able to figure out the
>    race/inconsistency completely.
> 2. Can you please help explain under what other cases
>    it was necessary to call ext4_update_i_disksize() in DIO write paths?
> 3. When will i_disksize be out-of-sync with i_size during DIO writes?

So as I commented in my other reply to this patch, the code is definitely
wrong as is. The update of i_disksize in the original DIO code is connected
with the addition to the orphan list - we want to make sure orphan cleanup
in case of crash will truncate inode to the current i_size so we set
i_disksize to i_size. That being said I cannot find a reason why the update
would be actually necessary because at that point i_size should be equal to
i_disksize anyway. So the best theory I have is that it was added "just to
be sure" (the code got inherited from original ext3 codebase from before
git times).

To answer your other questions: If we decided to leave i_disksize update
in, the proper use would look like:

	handle = ext4_journal_start(...);
	if (ext4_update_i_disksize(inode))
		ext4_mark_inode_dirty(handle, inode);
	ext4_orphan_add(handle, inode);
	ext4_journal_stop();

Now the race you ask about in 1) can happen but it would be harmless.
As you mention buffered writeback does update i_disksize after submitting
IO to freshly allocated blocks (in the same transaction as block allocation
is) but stale data exposure is impossible because transaction commit will
wait for page writeback to complete.

To answer 3), i_disksize is not in sync with i_size either during truncate
(or similar operations generally protected by i_rwsem for writing) or
when there are pending delay allocated writes.

Now to answer 2) I don't think update of i_disksize is ever needed for DIO
path - once iomap_dio_rw() flushes pending dirty pages, i_disksize should
be equal to i_size since we hold i_rwsem at least for reading.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
