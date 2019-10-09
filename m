Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C505AD1064
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfJINl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:41:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:58886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731243AbfJINl0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:41:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15A07B186;
        Wed,  9 Oct 2019 13:41:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 727191E4851; Wed,  9 Oct 2019 15:41:23 +0200 (CEST)
Date:   Wed, 9 Oct 2019 15:41:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v4 8/8] ext4: introduce direct I/O write path using iomap
 infrastructure
Message-ID: <20191009134123.GE5050@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008151238.GK5078@quack2.suse.cz>
 <20191009071145.GB32281@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009071145.GB32281@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-10-19 00:11:45, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 05:12:38PM +0200, Jan Kara wrote:
> > Seeing how difficult it is when a filesystem wants to complete the iocb
> > synchronously (regardless whether it is async or sync) and have all the
> > information in one place for further processing, I think it would be the
> > easiest to provide iomap_dio_rw_wait() that forces waiting for the iocb to
> > complete *and* returns the appropriate return value instead of pretty
> > useless EIOCBQUEUED. It is actually pretty trivial (patch attached). With
> > this we can then just call iomap_dio_rw_sync() for the inode extension case
> > with ->end_io doing just the unwritten extent processing and then call
> > ext4_handle_inode_extension() from ext4_direct_write_iter() where we would
> > have all the information we need.
> > 
> > Christoph, Darrick, what do you think about extending iomap like in the
> > attached patch (plus sample use in XFS)?
> 
> I vaguely remember suggesting something like this but Brian or Dave
> convinced me it wasn't a good idea.  This will require a trip to the
> xfs or fsdevel archives from when the inode_dio_wait was added in XFS.

I think you refer to this [1] message from Brian:

It's not quite that simple..

FWIW, the discussion (between Dave and I) for how best to solve this
started offline prior to sending the patch and pretty much started with
the idea of changing the async I/O to sync as you suggest here. I backed
off from that because it's too subtle given the semantics between the
higher level aio code and lower level dio code for async I/O. By that I
mean either can be responsible for calling the ->ki_complete() callback
in the iocb on I/O completion.

IOW, if we receive an async direct I/O, clear ->ki_complete() as you
describe above and submit it, the dio code will wait on I/O and return
the size of the I/O on successful completion. It will not have called
->ki_complete(), however. Rather, the >0 return value indicates that
aio_rw_done() must call ->ki_complete() after xfs_file_write_iter()
returns, but we would have already cleared the function pointer.

I think it is technically possible to use this technique by clearing and
restoring ->ki_complete(), but in general we've visited this "change the
I/O type" approach twice now and we've (collectively) got it wrong both
times (the first error in thinking was that XFS would need to call
->ki_complete()). IMO, this demonstrates that it's not worth the
complexity to insert ourselves into this dependency chain when we can
accomplish the same thing with a simple dio wait call.

---

Which is fair enough. I've been looking at the same and arrived at similar
conclusion ;) (BTW, funnily enough ocfs2 seems to do this dance with
clearing and restoring ki_complete). But what I propose is something
different - just wait for IO in iomap_dio_rw() which avoids the need to
clear & restore ->ki_complete() while at the same time while providing
fully-sync IO experience to the caller. So Brians objection doesn't apply
here.

> But if we decide it actully works this time around please don't add the
> __ variant but just add the parameter to iomap_dio_rw directly.

Yeah, I was undecided on this one as well. Will change this and post the
patches to fsdevel & xfs lists.

								Honza

[1] https://lore.kernel.org/linux-xfs/20190325135124.GD52167@bfoster/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
