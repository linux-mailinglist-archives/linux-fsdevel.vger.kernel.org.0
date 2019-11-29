Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2406F10D8D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 18:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK2RSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 12:18:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:55410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbfK2RSk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:18:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C71B6ABED;
        Fri, 29 Nov 2019 17:18:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02BAE1E0B7B; Fri, 29 Nov 2019 18:18:36 +0100 (CET)
Date:   Fri, 29 Nov 2019 18:18:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
Message-ID: <20191129171836.GB27588@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
 <20191120143257.GE9509@quack2.suse.cz>
 <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ritesh!

On Tue 26-11-19 16:21:15, Ritesh Harjani wrote:
> On 11/20/19 8:02 PM, Jan Kara wrote:
> > On Wed 20-11-19 10:30:24, Ritesh Harjani wrote:
> > > We were using shared locking only in case of dioread_nolock
> > > mount option in case of DIO overwrites. This mount condition
> > > is not needed anymore with current code, since:-
> > > 
> > > 1. No race between buffered writes & DIO overwrites.
> > > Since buffIO writes takes exclusive locks & DIO overwrites
> > > will take share locking. Also DIO path will make sure
> > > to flush and wait for any dirty page cache data.
> > > 
> > > 2. No race between buffered reads & DIO overwrites, since there
> > > is no block allocation that is possible with DIO overwrites.
> > > So no stale data exposure should happen. Same is the case
> > > between DIO reads & DIO overwrites.
> > > 
> > > 3. Also other paths like truncate is protected,
> > > since we wait there for any DIO in flight to be over.
> > > 
> > > 4. In case of buffIO writes followed by DIO reads:
> > > Since here also we take exclusive locks in ext4_write_begin/end().
> > > There is no risk of exposing any stale data in this case.
> > > Since after ext4_write_end, iomap_dio_rw() will wait to flush &
> > > wait for any dirty page cache data.
> > > 
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > 
> > There's one more case to consider here as I mentioned in [1]. There can be
> 
> Yes, I should have mentioned about this in cover letter and about my
> thoughts on that.
> I was of the opinion that since the race is already existing
> and it may not be caused due to this patch, so we should handle that in
> incremental fashion and as a separate patch series after this one.
> Let me know your thoughts on above.

Yes, I'm fine with that.

> Also, I wanted to have some more discussions on this race before
> making the changes.
> But nevertheless, it's the right time to discuss those changes here.
> 
> > mmap write instantiating dirty page and then someone starting writeback
> > against that page while DIO read is running still theoretically leading to
> > stale data exposure. Now this patch does not have influence on that race
> > but:
> 
> Yes, agreed.
> 
> > 
> > 1) We need to close the race mentioned above. Maybe we could do that by
> > proactively allocating unwritten blocks for a page being faulted when there
> > is direct IO running against the file - the one who fills holes through
> > mmap write while direct IO is running on the file deserves to suffer the
> > performance penalty...
> 
> I was giving this a thought. So even if we try to penalize mmap
> write as you mentioned above, what I am not sure about it, is that, how can
> we reliably detect that the DIO is in progress?
> 
> Say even if we try to check for atomic_read(&inode->i_dio_count) in mmap
> ext4_page_mkwrite path, it cannot be reliable unless there is some sort of a
> lock protection, no?
> Because after the check the DIO can still snoop in, right?

Yes, doing this reliably will need some code tweaking. Also thinking about
this in detail, doing a reliable check in ext4_page_mkwrite() is
somewhat difficult so it will be probably less error-prone to deal with the
race in the writeback path.

My preferred way of dealing with this would be to move inode_dio_begin()
call in iomap_dio_rw() a bit earlier before page cache invalidation and add
there smp_mb_after_atomic() (so that e.g. nrpages checks cannot get
reordered before the increment).  Then the check on i_dio_count in
ext4_writepages() will be reliable if we do it after gathering and locking
pages for writeback (i.e., in mpage_map_and_submit_extent()) - either we
see i_dio_count elevated and use the safe (but slower) writeback using
unwritten extents, or we see don't and then we are sure DIO will not start
until writeback of the pages we have locked has finished because of
filemap_write_and_wait() call in iomap_dio_rw().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
