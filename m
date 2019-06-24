Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05B51F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfFXXoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 19:44:16 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:45829 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbfFXXoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:44:16 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id E6EC03DBE31;
        Tue, 25 Jun 2019 09:44:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hfYc4-0000mA-Q2; Tue, 25 Jun 2019 09:43:04 +1000
Date:   Tue, 25 Jun 2019 09:43:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190624234304.GD7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-12-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=WnLPuD5yqiszFHSN9gAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:52AM +0200, Christoph Hellwig wrote:
> Takes the xfs writeback code and move it to iomap.c.  A new structure
> with three methods is added as the abstraction from the generic
> writeback code to the file system.  These methods are used to map
> blocks, submit an ioend, and cancel a page that encountered an error
> before it was added to an ioend.
> 
> Note that we temporarily lose the writepage tracing, but that will
> be added back soon.

I'm a little concerned this is going to limit what we can do
with the XFS IO path because now we can't change this code without
considering the direct impact on other filesystems. The QA burden of
changing the XFS writeback code goes through the roof with this
change (i.e. we can break multiple filesystems, not just XFS).

The writepage code is one of the areas that, historically speaking,
has one of the highest rates of modification in XFS - we've
substantially reworked this code from top to bottom 4 or 5 times in
a bit over ten years, and each time it's been removing abstraction
layers and getting the writeback code closer to the internal XFS
extent mapping infrastructure.

This steps the other way - it adds abstraction to move the XFS code
to be generic, and now we have to be concerned about how changes to
the XFS IO path affects other filesystems. While I can see the
desire to use this code in other filesystems, no other filesystem
does COW or delayed allocation like XFS and this functionality is
tightly tied into the iomap page writeback architecture.

As such, I'm not convinced that a wholesale lifting of this code
into the generic iomap code is going to make our life easier or
better. The stuff we've already got in fs/iomap.c is largely
uncontroversial and straight forward, but this writeback code is
anything but straight forward.....

Another issue this raises is that fs/iomap.c is already huge chunk
of code with lots of different functionality in it. Adding another
500+ lines of new functionality to it doesn't make it any easier to
navigate or find things.

If we are going to move this writeback code to the generic iomap
infrastructure, can we please split the iomap code up in to smaller
files first?  e.g. fs/iomap-dio.c for all the direct IO code,
fs/iomap-pageio.c for all the page-based IO, fs/iomap.c for all the
core functionality (like iomap_apply()) and fs/iomap-util.c for all
the miscellaneous one-off functions like fiemap, etc?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
