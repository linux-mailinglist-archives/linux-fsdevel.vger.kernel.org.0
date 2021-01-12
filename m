Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EBD2F404A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbhALXaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 18:30:07 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:56436 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391531AbhALXaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:30:07 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 4B879D34B;
        Wed, 13 Jan 2021 10:29:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzT6J-005qcX-HX; Wed, 13 Jan 2021 10:29:23 +1100
Date:   Wed, 13 Jan 2021 10:29:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
Message-ID: <20210112232923.GD331610@dread.disaster.area>
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112162616.2003366-10-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=CEeBnLg5Jiu_aP6BM1AA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 05:26:15PM +0100, Christoph Hellwig wrote:
> Add a flag to request that the iomap instances do not allocate blocks
> by translating it to another new IOMAP_NOALLOC flag.

Except "no allocation" that is not what XFS needs for concurrent
sub-block DIO.

We are trying to avoid external sub-block IO outside the range of
the user data IO (COW, sub-block zeroing, etc) so that we don't
trash adjacent sub-block IO in flight. This means we can't do
sub-block zeroing and that then means we can't map unwritten extents
or allocate new extents for the sub-block IO.  It also means the IO
range cannot span EOF because that triggers unconditional sub-block
zeroing in iomap_dio_rw_actor().

And because we may have to map multiple extents to fully span an IO
range, we have to guarantee that subsequent extents for the IO are
also written otherwise we have a partial write abort case. Hence we
have single extent limitations as well.

So "no allocation" really doesn't describe what we want this flag to
at all.

If we're going to use a flag for this specific functionality, let's
call it what it is: IOMAP_DIO_UNALIGNED/IOMAP_UNALIGNED and do two
things with it.

	1. Make unaligned IO a formal part of the iomap_dio_rw()
	behaviour so it can do the common checks to for things that
	need exclusive serialisation for unaligned IO (i.e. avoid IO
	spanning EOF, abort if there are cached pages over the
	range, etc).

	2. require the filesystem mapping callback do only allow
	unaligned IO into ranges that are contiguous and don't
	require mapping state changes or sub-block zeroing to be
	performed during the sub-block IO.


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
