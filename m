Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C943C1FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 07:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhJ0FFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 01:05:19 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:34955 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhJ0FFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:05:19 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 64CC786330D;
        Wed, 27 Oct 2021 16:02:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mfb5N-001VI9-R0; Wed, 27 Oct 2021 16:02:49 +1100
Date:   Wed, 27 Oct 2021 16:02:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] loop: don't print warnings if the underlying
 filesystem doesn't support discard
Message-ID: <20211027050249.GC5111@dread.disaster.area>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
 <20210924155822.GA10064@lst.de>
 <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com>
 <20211012062049.GB17407@lst.de>
 <alpine.LRH.2.02.2110121516440.21015@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2110130524220.16882@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2110130524220.16882@file01.intranet.prod.int.rdu2.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6178dd7d
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=nlNMiS1GOempI7xxVB0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:28:36AM -0400, Mikulas Patocka wrote:
> Hi
> 
> Here I'm sending version 4 of the patch. It adds #include <linux/falloc.h> 
> to cifs and overlayfs to fix the bugs found out by the kernel test robot.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> The loop driver checks for the fallocate method and if it is present, it 
> assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and 
> FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or 
> tmpfs) have the fallocate method, but lack the capability to do 
> FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.

This seems like a loopback driver level problem, not something
filesystems need to solve. fallocate() is defined to return
-EOPNOTSUPP if a flag is passed that it does not support and that's
the mechanism used to inform callers that a fallocate function is
not supported by the underlying filesystem/storage.

Indeed, filesystems can support hole punching at the ->fallocate(),
but then return EOPNOTSUPP because certain dynamic conditions are
not met e.g. CIFS needs sparse file support on the server to support
hole punching, but we don't know this until we actually try to 
sparsify the file. IOWs, this patch doesn't address all the cases
where EOPNOTSUPP might actually get returned from filesystems and/or
storage.

> This results in syslog warnings "blk_update_request: operation not 
> supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800 
> phys_seg 0 prio class 0". The error can be reproduced with this command: 
> "truncate -s 1GiB /tmp/file; losetup /dev/loop0 /tmp/file; blkdiscard -z 
> /dev/loop0"

Which I'm assuming comes from this:

	        if (unlikely(error && !blk_rq_is_passthrough(req) &&
                     !(req->rq_flags & RQF_QUIET)))
                print_req_error(req, error, __func__);

Which means we could supress the error message quite easily in
lo_fallocate() by doing:

out:
	if (ret == -EOPNOTSUPP)
		rq->rq_flags |= RQF_QUIET;
	return ret;

And then we can also run blk_queue_flag_clear(QUEUE_FLAG_DISCARD)
(and whatever else is needed to kill discards) to turn off future
discard attempts on that loopback device. This way the problem is
just quietly and correctly handled by the loop device and everything
is good...

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
