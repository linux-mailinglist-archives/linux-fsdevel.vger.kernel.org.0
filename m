Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFB43DA2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 06:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ1ERr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 00:17:47 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:58232 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1ERr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:17:47 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 17790FC73AF;
        Thu, 28 Oct 2021 15:15:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mfwor-001sv4-Eh; Thu, 28 Oct 2021 15:15:13 +1100
Date:   Thu, 28 Oct 2021 15:15:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] loop: don't print warnings if the underlying
 filesystem doesn't support discard
Message-ID: <20211028041513.GD4821@dread.disaster.area>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
 <20210924155822.GA10064@lst.de>
 <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com>
 <20211012062049.GB17407@lst.de>
 <alpine.LRH.2.02.2110121516440.21015@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2110130524220.16882@file01.intranet.prod.int.rdu2.redhat.com>
 <20211027050249.GC5111@dread.disaster.area>
 <alpine.LRH.2.02.2110270421380.10452@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2110270421380.10452@file01.intranet.prod.int.rdu2.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=617a23d5
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=a5nNtdR3IqEc3FIJ3gUA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:28:03AM -0400, Mikulas Patocka wrote:
> 
> 
> On Wed, 27 Oct 2021, Dave Chinner wrote:
> 
> > On Wed, Oct 13, 2021 at 05:28:36AM -0400, Mikulas Patocka wrote:
> > > Hi
> > > 
> > > Here I'm sending version 4 of the patch. It adds #include <linux/falloc.h> 
> > > to cifs and overlayfs to fix the bugs found out by the kernel test robot.
> > > 
> > > Mikulas
> > > 
> > > 
> > > 
> > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > The loop driver checks for the fallocate method and if it is present, it 
> > > assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and 
> > > FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or 
> > > tmpfs) have the fallocate method, but lack the capability to do 
> > > FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.
> > 
> > This seems like a loopback driver level problem, not something
> > filesystems need to solve. fallocate() is defined to return
> > -EOPNOTSUPP if a flag is passed that it does not support and that's
> > the mechanism used to inform callers that a fallocate function is
> > not supported by the underlying filesystem/storage.
> > 
> > Indeed, filesystems can support hole punching at the ->fallocate(),
> > but then return EOPNOTSUPP because certain dynamic conditions are
> > not met e.g. CIFS needs sparse file support on the server to support
> > hole punching, but we don't know this until we actually try to 
> > sparsify the file. IOWs, this patch doesn't address all the cases
> > where EOPNOTSUPP might actually get returned from filesystems and/or
> > storage.
> > 
> > > This results in syslog warnings "blk_update_request: operation not 
> > > supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800 
> > > phys_seg 0 prio class 0". The error can be reproduced with this command: 
> > > "truncate -s 1GiB /tmp/file; losetup /dev/loop0 /tmp/file; blkdiscard -z 
> > > /dev/loop0"
> > 
> > Which I'm assuming comes from this:
> > 
> > 	        if (unlikely(error && !blk_rq_is_passthrough(req) &&
> >                      !(req->rq_flags & RQF_QUIET)))
> >                 print_req_error(req, error, __func__);
> > 
> > Which means we could supress the error message quite easily in
> > lo_fallocate() by doing:
> > 
> > out:
> > 	if (ret == -EOPNOTSUPP)
> > 		rq->rq_flags |= RQF_QUIET;
> > 	return ret;
> 
> I did this (see 
> https://lore.kernel.org/all/alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com/ 

Ok, you need to keep a changelog with the patch so that it's clear
what the history of it is....

> ) and Christoph Hellwig asked for a flag in the file_operations structure 
> ( https://lore.kernel.org/all/20210924155822.GA10064@lst.de/ ).

Looking at the code that has resulted, I think Christoph's
suggestion is a poor one. Code duplication is bad enough, worse is
that it's duplicating the open coding of non-trivial flag
combinations. Given that it is only needed for a single calling
context and it is unnecessary to solve the unique problem at hand
(suppress warning and turn off discard support) this makes it seem
like a case of over-engineering.

Further, it doesn't avoid the need for the loop device to handle
EOPNOTSUPP from fallocate directly, either, because as I explained
above "filesystem type supports the FALLOC_FL_PUNCH_HOLE API flag"
is not the same as "filesystem and/or file instance can execute
FALLOC_FL_PUNCH_HOLE"....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
