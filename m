Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D0F2F679E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbhANR1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 12:27:36 -0500
Received: from verein.lst.de ([213.95.11.211]:36705 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbhANR1f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:27:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6BF468B02; Thu, 14 Jan 2021 18:26:50 +0100 (CET)
Date:   Thu, 14 Jan 2021 18:26:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: Re: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
Message-ID: <20210114172650.GA30826@lst.de>
References: <20210112162616.2003366-1-hch@lst.de> <20210112162616.2003366-10-hch@lst.de> <20210112232923.GD331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112232923.GD331610@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:29:23AM +1100, Dave Chinner wrote:
> On Tue, Jan 12, 2021 at 05:26:15PM +0100, Christoph Hellwig wrote:
> > Add a flag to request that the iomap instances do not allocate blocks
> > by translating it to another new IOMAP_NOALLOC flag.
> 
> Except "no allocation" that is not what XFS needs for concurrent
> sub-block DIO.

Well, this is just a quick draft.  I could not come up with a better
name, so I picked on that explains most but not all of what is going
on.

> If we're going to use a flag for this specific functionality, let's
> call it what it is: IOMAP_DIO_UNALIGNED/IOMAP_UNALIGNED and do two
> things with it.

Sounds fine with me.

> 
> 	1. Make unaligned IO a formal part of the iomap_dio_rw()
> 	behaviour so it can do the common checks to for things that
> 	need exclusive serialisation for unaligned IO (i.e. avoid IO
> 	spanning EOF, abort if there are cached pages over the
> 	range, etc).

Note that these all writes already fall back to buffered I/O if
invalidate_inode_pages2_range fails, so there must never be cached
pages for direct I/O these days.  This is different from NOWAIT
I/O where we simply give up if there are any cached pages and don't
even try to invalidate them.

> 	2. require the filesystem mapping callback do only allow
> 	unaligned IO into ranges that are contiguous and don't
> 	require mapping state changes or sub-block zeroing to be
> 	performed during the sub-block IO.

Yeah.
