Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B732ED5DF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKCV0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 16:26:55 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57966 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727501AbfKCV0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 16:26:55 -0500
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 539D743F213;
        Mon,  4 Nov 2019 08:26:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iRNOc-0006Rt-MU; Mon, 04 Nov 2019 08:26:50 +1100
Date:   Mon, 4 Nov 2019 08:26:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191103212650.GA4614@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191030172517.GO15222@magnolia>
 <20191030214335.GQ4614@dread.disaster.area>
 <20191031030658.GW15222@magnolia>
 <20191031205049.GS4614@dread.disaster.area>
 <20191031210551.GK15221@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031210551.GK15221@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=HdJPOkImENtfvV1LZcUA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:05:51PM -0700, Darrick J. Wong wrote:
> On Fri, Nov 01, 2019 at 07:50:49AM +1100, Dave Chinner wrote:
> > On Wed, Oct 30, 2019 at 08:06:58PM -0700, Darrick J. Wong wrote:
> > > > In the case of the xfs_bufs, I've been running workloads recently
> > > > that cache several million xfs_bufs and only a handful of inodes
> > > > rather than the other way around. If we spread inodes because
> > > > caching millions on a single node can cause problems on large NUMA
> > > > machines, then we also need to spread xfs_bufs...
> > > 
> > > Hmm, could we capture this as a comment somewhere?
> > 
> > Sure, but where? We're planning on getting rid of the KM_ZONE flags
> > in the near future, and most of this is specific to the impacts on
> > XFS. I could put it in xfs-super.c above where we initialise all the
> > slabs, I guess. Probably a separate patch, though....
> 
> Sounds like a reasonable place (to me) to record the fact that we want
> inodes and metadata buffers not to end up concentrating on a single node.

Ok. I'll add yet another patch to the preliminary part of the
series. Any plans to take any of these first few patches in this
cycle?

> At least until we start having NUMA systems with a separate "IO node" in
> which to confine all the IO threads and whatnot <shudder>. :P

Been there, done that, got the t-shirt and wore it out years ago.

IO-only nodes (either via software configuration, or real
cpu/memory-less IO nodes) are one of the reasons we don't want
node-local allocation behaviour for large NUMA configs...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
