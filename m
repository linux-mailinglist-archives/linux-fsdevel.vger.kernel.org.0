Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9DED1C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfJIXCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 19:02:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:32940 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730815AbfJIXCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:02:32 -0400
Received: from dread.disaster.area (pa49-195-199-207.pa.nsw.optusnet.com.au [49.195.199.207])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id AF593363877;
        Thu, 10 Oct 2019 10:02:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iIKyR-0006cx-LW; Thu, 10 Oct 2019 10:02:27 +1100
Date:   Thu, 10 Oct 2019 10:02:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191009230227.GH16973@dread.disaster.area>
References: <20191009202736.19227-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009202736.19227-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=U3CgBz6+VuTzJ8lMfNbwVQ==:117 a=U3CgBz6+VuTzJ8lMfNbwVQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=Nb0Mfos4mOhxgEr3ClsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:41:24PM +0200, Jan Kara wrote:
> Hello,
> 
> when doing the ext4 conversion of direct IO code to iomap, we found it very
> difficult to handle inode extension with what iomap code currently provides.
> Ext4 wants to do inode extension as sync IO (so that the whole duration of
> IO is protected by inode->i_rwsem), also we need to truncate blocks beyond
> end of file in case of error or short write. Now in ->end_io handler we don't
> have the information how long originally the write was (to judge whether we
> may have allocated more blocks than we actually used) and in ->write_iter
> we don't know whether / how much of the IO actually succeeded in case of AIO.
> 
> Thinking about it for some time I think iomap code makes it unnecessarily
> complex for the filesystem in case it decides it doesn't want to perform AIO
> and wants to fall back to good old synchronous IO. In such case it is much
> easier for the filesystem if it just gets normal error return from
> iomap_dio_rw() and not just -EIOCBQUEUED.

Yeah, that'd be nice. :)

> The first patch in the series adds argument to iomap_dio_rw() to wait for IO
> completion (internally iomap_dio_rw() already supports this!) and the second
> patch converts XFS waiting for unaligned DIO write to this new API.
> 
> What do people think?

I've just caught up on the ext4 iomap dio thread where this came up,
so I have some idea of what is going on now :)

My main issue is that I don't like the idea of a "force_wait"
parameter to iomap_dio_rw() that overrides what the kiocb says to
do inside iomap_dio_rw(). It just seems ... clunky.

I'd much prefer that the entire sync/async IO decision is done in
one spot, and the result of that is passed into iomap_dio_rw(). i.e.
the caller always determines the behaviour.

That would mean the callers need to do something like this by
default:

	ret = iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));

And filesystems like XFS will need to do:

	ret = iomap_dio_rw(iocb, iter, ops, dops,
			is_sync_kiocb(iocb) || unaligned);

and ext4 will calculate the parameter in whatever way it needs to.

In fact, it may be that a wrapper function is better for existing
callers:

static inline ssize_t iomap_dio_rw()
{
	return iomap_dio_rw_wait(iocb, iter, ops, dops, is_sync_kiocb(iocb));
}

And XFS/ext4 writes call iomap_dio_rw_wait() directly. That way we
don't need to change the read code at all...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
