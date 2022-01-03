Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886294838AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiACWDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 17:03:16 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48828 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbiACWDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:03:15 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1FF4262BFF9;
        Tue,  4 Jan 2022 09:03:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n4VQ6-00B0CT-Tk; Tue, 04 Jan 2022 09:03:10 +1100
Date:   Tue, 4 Jan 2022 09:03:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220103220310.GG945095@dread.disaster.area>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61d372a1
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=XKqQFd1370Qps8Tql14A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 01, 2022 at 05:39:45PM +0000, Trond Myklebust wrote:
> On Sat, 2022-01-01 at 14:55 +1100, Dave Chinner wrote:
> > As it is, if you are getting soft lockups in this location, that's
> > an indication that the ioend chain that is being built by XFS is
> > way, way too long. IOWs, the completion latency problem is caused by
> > a lack of submit side ioend chain length bounding in combination
> > with unbound completion side merging in xfs_end_bio - it's not a
> > problem with the generic iomap code....
> > 
> > Let's try to address this in the XFS code, rather than hack
> > unnecessary band-aids over the problem in the generic code...
> > 
> > Cheers,
> > 
> > Dave.
> 
> Fair enough. As long as someone is working on a solution, then I'm
> happy. Just a couple of things:
> 
> Firstly, we've verified that the cond_resched() in the bio loop does
> suffice to resolve the issue with XFS, which would tend to confirm what
> you're saying above about the underlying issue being the ioend chain
> length.
> 
> Secondly, note that we've tested this issue with a variety of older
> kernels, including 4.18.x, 5.1.x and 5.15.x, so please bear in mind
> that it would be useful for any fix to be backward portable through the
> stable mechanism.

The infrastructure hasn't changed that much, so whatever the result
is it should be backportable.

As it is, is there a specific workload that triggers this issue? Or
a specific machine config (e.g. large memory, slow storage). Are
there large fragmented files in use (e.g. randomly written VM image
files)? There are a few factors that can exacerbate the ioend chain
lengths, so it would be handy to have some idea of what is actually
triggering this behaviour...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
