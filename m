Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C517A78276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 01:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG1XmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 19:42:22 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46711 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfG1XmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:42:22 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 568CF820831;
        Mon, 29 Jul 2019 09:42:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hrsms-00005W-25; Mon, 29 Jul 2019 09:41:10 +1000
Date:   Mon, 29 Jul 2019 09:41:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Message-ID: <20190728234110.GH7777@dread.disaster.area>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area>
 <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=wVqCKi36-eQ2n_nKcFwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 27, 2019 at 02:59:59AM +0000, Damien Le Moal wrote:
> On 2019/07/27 7:55, Theodore Y. Ts'o wrote:
> > On Sat, Jul 27, 2019 at 08:44:23AM +1000, Dave Chinner wrote:
> >>>
> >>> This looks like something that could hit every file systems, so
> >>> shouldn't we fix this in common code?  We could also look into
> >>> just using memalloc_nofs_save for the page cache allocation path
> >>> instead of the per-mapping gfp_mask.
> >>
> >> I think it has to be the entire IO path - any allocation from the
> >> underlying filesystem could recurse into the top level filesystem
> >> and then deadlock if the memory reclaim submits IO or blocks on
> >> IO completion from the upper filesystem. That's a bloody big hammer
> >> for something that is only necessary when there are stacked
> >> filesystems like this....
> > 
> > Yeah.... that's why using memalloc_nofs_save() probably makes the most
> > sense, and dm_zoned should use that before it calls into ext4.
> 
> Unfortunately, with this particular setup, that will not solve the problem.
> dm-zoned submit BIOs to its backend drive in response to XFS activity. The
> requests for these BIOs are passed along to the kernel tcmu HBA and end up in
> that HBA command ring. The commands themselves are read from the ring and
> executed by the tcmu-runner user process which executes them doing
> pread()/pwrite() to the ext4 file. The tcmu-runner process being a different
> context than the dm-zoned worker thread issuing the BIO,
> memalloc_nofs_save/restore() calls in dm-zoned will have no effect.

Right, I'm talking about using memalloc_nofs_save() as a huge hammer
in the pread/pwrite() calling context, not the bio submission
context (which is typically GFP_NOFS above submit_bio() and GFP_NOIO
below).

> So back to Dave's point, we may be needing the big-hammer solution in the case
> of stacked file systems, while a non-stack setups do not necessarily need it
> (that is for the FS to decide). But I do not see how to implement this big
> hammer conditionally. How can a file system tell if it is at the top of the
> stack (big hammer not needed) or lower than the top level (big hammer needed) ?

Age old question - tracking arbitrary nesting through mount/fs/bdev
layers is ... difficult. There is no easy way to tell.

> One simple hack would be an fcntl() or mount option to tell the FS to use
> GFP_NOFS unconditionally, but avoiding the bug would mean making sure that the
> applications or system setup is correct. So not so safe.

Wasn't there discussion at some point in the past about an interface
for special processes to be able to mark themselves as PF_MEMALLOC
(some kind of prctl, I think) for things like FUSE daemons? That
would prevent direct reclaim recursion for these userspace daemons
that are in the kernel memory reclaim IO path. It's the same
situation there, isn't it? How does fuse deal with this problem?

Cheers,

Dave,
-- 
Dave Chinner
david@fromorbit.com
