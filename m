Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E582B76D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKRHTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:19:48 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45490 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgKRHTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:19:47 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EE36F3C1E0B;
        Wed, 18 Nov 2020 18:19:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kfHkj-00CMxj-I2; Wed, 18 Nov 2020 18:19:41 +1100
Date:   Wed, 18 Nov 2020 18:19:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118071941.GN7391@dread.disaster.area>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=9cFcoMo6DJKMXVgSEfwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
> If we've successfully transferred some data in __iomap_dio_rw(),
> don't mark an error for a latter segment in the dio.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
> IO. If we do parts of an IO, then once that completes, we still
> return -EAGAIN if we ran into a problem later on. That seems wrong,
> normal convention would be to return the short IO instead. For the
> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
> and complete it successfully.

So you are getting a write IO that is split across an allocated
extent and a hole, and the second mapping is returning EAGAIN
because allocation would be required? This sort of split extent IO
is fairly common, so I'm not sure that splitting them into two
separate IOs may not be the best approach.

I'd kinda like to avoid have NOWAIT IO return different results to a
non-NOWAIT IO with exactly the same setup contexts i.e. either we
get -EAGAIN or the IO completes as a whole just like a non-NOWAIT IO
would.

So perhaps it would be better to fix the IOMAP_NOWAIT handling in XFS
to return EAGAIN if the mapping found doesn't span the entire range
of the IO. That way we avoid the potential "partial NOWAIT"
behaviour for IOs that span extent boundaries....

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
