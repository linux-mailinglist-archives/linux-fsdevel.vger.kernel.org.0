Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDBA4C7D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiB1WjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiB1WjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:39:14 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 823654A906;
        Mon, 28 Feb 2022 14:38:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9453F10E0F6C;
        Tue,  1 Mar 2022 09:38:31 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nOof0-0000NZ-C4; Tue, 01 Mar 2022 09:38:30 +1100
Date:   Tue, 1 Mar 2022 09:38:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fdmanana@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
        cluster-devel@redhat.com, agruenba@redhat.com,
        josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] iomap: fix incomplete async dio reads when using
 IOMAP_DIO_PARTIAL
Message-ID: <20220228223830.GR59715@dread.disaster.area>
References: <1f34c8435fed21e9583492661ceb20d642a75699.1646058596.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f34c8435fed21e9583492661ceb20d642a75699.1646058596.git.fdmanana@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=621d4ee8
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=7-415B0cAAAA:8 a=snENK0uE5OOyzlFrYM4A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:32:03PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some users recently reported that MariaDB was getting a read corruption
> when using io_uring on top of btrfs. This started to happen in 5.16,
> after commit 51bd9563b6783d ("btrfs: fix deadlock due to page faults
> during direct IO reads and writes"). That changed btrfs to use the new
> iomap flag IOMAP_DIO_PARTIAL and to disable page faults before calling
> iomap_dio_rw(). This was necessary to fix deadlocks when the iovector
> corresponds to a memory mapped file region. That type of scenario is
> exercised by test case generic/647 from fstests, and it also affected
> gfs2, which, besides btrfs, is the only user of IOMAP_DIO_PARTIAL.
> 
> For this MariaDB scenario, we attempt to read 16K from file offset X
> using IOCB_NOWAIT and io_uring. In that range we have 4 extents, each
> with a size of 4K, and what happens is the following:
> 
> 1) btrfs_direct_read() disables page faults and calls iomap_dio_rw();
> 
> 2) iomap creates a struct iomap_dio object, its reference count is
>    initialized to 1 and its ->size field is initialized to 0;
> 
> 3) iomap calls btrfs_iomap_begin() with file offset X, which finds the

You mean btrfs_dio_iomap_begin()?

>    first 4K extent, and setups an iomap for this extent consisting of
>    a single page;

So we have IOCB_NOWAIT, which means btrfs_dio_iomap_begin() is being
passed IOMAP_NOWAIT and so knows it is being asked
to map an extent for an IO that is on a non-blocking path.

btrfs_dio_iomap_begin() doesn't appear to support NOWAIT semantics
at all - it will block doing writeback IO, memory allocation, extent
locking, transaction reservations, extent allocation, etc....

That, to me, looks like the root cause of the problem here -
btrfs_dio_iomap_begin() is not guaranteeing non-blocking atomic IO
semantics for IOCB_NOWAIT IO.

In the case above, given that the extent lookup only found a 4kB
extent, we know that it doesn't span the entire requested IO range.
We also known that we cannot tell if we'll block on subsequent
mappings of the IO range, and hence no guarantee can be given that
IOCB_NOWAIT IO will not block when it is too late to back out with a
-EAGAIN error.

Hence this whole set of problems could be avoided if
btrfs_dio_iomap_begin() returns -EAGAIN if it can't map the entire
IO into a single extent without blocking when IOMAP_NOWAIT is set?
That's exactly what XFS does in xfs_direct_iomap_write_begin():

        /*
         * NOWAIT and OVERWRITE I/O needs to span the entire requested I/O with
         * a single map so that we avoid partial IO failures due to the rest of
         * the I/O range not covered by this map triggering an EAGAIN condition
         * when it is subsequently mapped and aborting the I/O.
         */
        if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY)) {
                error = -EAGAIN;
                if (!imap_spans_range(&imap, offset_fsb, end_fsb))
                        goto out_unlock;
        }

Basically, I'm thinking that IOMAP_NOWAIT and IOMAP_DIO_PARTIAL
should be exclusive functionality - if you are doing IOMAP_NOWAIT
then the entire IO must succeed without blocking, and if it doesn't
then we return -EAGAIN and the caller retries without IOCB_NOWAIT
set and so then we run with IOMAP_DIO_PARTIAL semantics in a thread
that can actually block....

.....

> 11) At iomap_dio_complete() we adjust the iocb->ki_pos from X to X + 4K
>     and return 4K (the amount of io done) to iomap_dio_complete_work();
> 
> 12) iomap_dio_complete_work() calls the iocb completion callback,
>     iocb->ki_complete() with a second argument value of 4K (total io
>     done) and the iocb with the adjust ki_pos of X + 4K. This results
>     in completing the read request for io_uring, leaving it with a
>     result of 4K bytes read, and only the first page of the buffer
>     filled in, while the remaining 3 pages, corresponding to the other
>     3 extents, were not filled;
> 
> 13) For the application, the result is unexpected because if we ask
>     to read N bytes, it expects to get N bytes read as long as those
>     N bytes don't cross the EOF (i_size).

Yeah, that's exactly the sort of problem we were having with XFS
with partial DIO completions due to needing multiple iomap iteration
loops to complete a single IO. Hence IOMAP_NOWAIT now triggers the
above range check and aborts before we start...

> 
> So fix this by making __iomap_dio_rw() assign true to the boolean variable
> 'wait_for_completion' when we have IOMAP_DIO_PARTIAL set, we did some
> progress for a read and we have not crossed the EOF boundary. Do this even
> if the read has IOCB_NOWAIT set, as it's the only way to avoid providing
> an unexpected result to an application.

That's highly specific and ultimately will be fragile, IMO. I'd much
prefer that *_iomap_begin_write() implementations simply follow
IOMAP_NOWAIT requirements to ensure that any DIO that needs multiple
mappings if punted to a context that can block...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
