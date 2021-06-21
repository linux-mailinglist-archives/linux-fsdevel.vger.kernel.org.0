Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB93AEB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUOfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:35:03 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A85C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 07:32:49 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKyk-00ArF0-Jw; Mon, 21 Jun 2021 14:32:46 +0000
Date:   Mon, 21 Jun 2021 14:32:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
 <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
 <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621142235.GA2391@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:22:35PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 03:16:50PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 21, 2021 at 04:09:56PM +0200, Christoph Hellwig wrote:
> > > On Mon, Jun 21, 2021 at 03:03:07PM +0100, Matthew Wilcox wrote:
> > > > i suggested that to viro last night, and he pointed out that ioctl(S_SYNC)
> > > 
> > > Where would that S_SYNC ioctl be implemented?
> > 
> > xfs_diflags_to_iflags(
> >         if (xflags & FS_XFLAG_SYNC)
> >                 flags |= S_SYNC;
> > 
> > (mutatis mutandi per filesystem)
> 
> 
> Ok, your description above wasn't very exact.

Sorry - the relevant part of conversation went

< viro> willy: that's the part that can't be done at open() time
< willy> because we might mount -o remount,sync after open()?
< viro> ... as well as setting S_SYNC via ioctl

Should've been phrased better...

> Anyway, that at least doesn't go out to the superblock.  But if Al
> dislikes it we can also make generic_sync_file and friends check
> IS_SYNC() again.  Having a single flag is kinda nice as it avoids
> stupid errors, but if we actually have a performance problem here
> (do we have any data on that?) just going back to the old way would
> seem like the simplest fix.

	IIRC, there had been profiling data posted with init_sync_kiocb()
responsible for large part of new_sync_write()/new_sync_read() overhead.
Remember the threads about the use of ->read_iter()/->write_iter() being
slower than having ->read()/->write()?  Back in December or so, I think;
one surprising part had been that large chunk of overhead sat not in
suboptimal iov_iter primitives, but right in new_sync_read()/new_sync_write()
with init_sync_kiocb() being the source of it,

	I'd rather have a single helper for those checks, rather than
open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...
