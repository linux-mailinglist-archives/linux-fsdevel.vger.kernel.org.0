Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28866D2619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfJJJSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 05:18:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387639AbfJJJSe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:18:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C55FDAFC6;
        Thu, 10 Oct 2019 09:18:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 310501E4810; Thu, 10 Oct 2019 11:18:31 +0200 (CEST)
Date:   Thu, 10 Oct 2019 11:18:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191010091831.GA25364@quack2.suse.cz>
References: <20191009202736.19227-1-jack@suse.cz>
 <20191009230227.GH16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009230227.GH16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-10-19 10:02:27, Dave Chinner wrote:
> On Wed, Oct 09, 2019 at 10:41:24PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > when doing the ext4 conversion of direct IO code to iomap, we found it very
> > difficult to handle inode extension with what iomap code currently provides.
> > Ext4 wants to do inode extension as sync IO (so that the whole duration of
> > IO is protected by inode->i_rwsem), also we need to truncate blocks beyond
> > end of file in case of error or short write. Now in ->end_io handler we don't
> > have the information how long originally the write was (to judge whether we
> > may have allocated more blocks than we actually used) and in ->write_iter
> > we don't know whether / how much of the IO actually succeeded in case of AIO.
> > 
> > Thinking about it for some time I think iomap code makes it unnecessarily
> > complex for the filesystem in case it decides it doesn't want to perform AIO
> > and wants to fall back to good old synchronous IO. In such case it is much
> > easier for the filesystem if it just gets normal error return from
> > iomap_dio_rw() and not just -EIOCBQUEUED.
> 
> Yeah, that'd be nice. :)
> 
> > The first patch in the series adds argument to iomap_dio_rw() to wait for IO
> > completion (internally iomap_dio_rw() already supports this!) and the second
> > patch converts XFS waiting for unaligned DIO write to this new API.
> > 
> > What do people think?
> 
> I've just caught up on the ext4 iomap dio thread where this came up,
> so I have some idea of what is going on now :)
> 
> My main issue is that I don't like the idea of a "force_wait"
> parameter to iomap_dio_rw() that overrides what the kiocb says to
> do inside iomap_dio_rw(). It just seems ... clunky.
> 
> I'd much prefer that the entire sync/async IO decision is done in
> one spot, and the result of that is passed into iomap_dio_rw(). i.e.
> the caller always determines the behaviour.
> 
> That would mean the callers need to do something like this by
> default:
> 
> 	ret = iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> 
> And filesystems like XFS will need to do:
> 
> 	ret = iomap_dio_rw(iocb, iter, ops, dops,
> 			is_sync_kiocb(iocb) || unaligned);

Yeah, I've considered that as well. I just didn't like repeating
is_sync_kiocb(iocb) in all the callers when all the callers actually have
to have something like (is_sync_kiocb(iocb) || (some special conditions))
to be correct. And in fact it is not a definitive decision either as
iomap_dio_rw() can decide to override caller's wish and do the IO
synchronously anyway (when it gets -ENOTBLK from the filesystem). That's why
I came up with 'force_wait' argument, which isn't exactly beautiful either, I
agree.

> and ext4 will calculate the parameter in whatever way it needs to.
> 
> In fact, it may be that a wrapper function is better for existing
> callers:
> 
> static inline ssize_t iomap_dio_rw()
> {
> 	return iomap_dio_rw_wait(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> }
> 
> And XFS/ext4 writes call iomap_dio_rw_wait() directly. That way we
> don't need to change the read code at all...

Yeah, this is similar to what I had in my previous version [1]. There I had
__iomap_dio_rw() with bool argument, iomap_dio_rw() passing is_sync_kiocb(iocb)
to __iomap_dio_rw() (i.e., fully backward compatible), and iomap_dio_rw_wait()
which executed IO synchronously. But Christoph didn't like the wrappers.

I can go with just one wrapper like you suggest if that's what people
prefer. I don't care much we just have to settle on something...

								Honza

[1] https://lore.kernel.org/linux-ext4/20191008151238.GK5078@quack2.suse.cz/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
