Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D367741F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfGZWpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 18:45:35 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59677 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbfGZWpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:45:35 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7730543BE65;
        Sat, 27 Jul 2019 08:45:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hr8wp-0007Jx-2T; Sat, 27 Jul 2019 08:44:23 +1000
Date:   Sat, 27 Jul 2019 08:44:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Message-ID: <20190726224423.GE7777@dread.disaster.area>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725115442.GA15733@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=zFaflo0CMpuWMedRxgwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:54:42AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 06:33:58PM +0900, Damien Le Moal wrote:
> > +	gfp_t gfp_mask;
> > +
> >  	switch (ext4_inode_journal_mode(inode)) {
> >  	case EXT4_INODE_ORDERED_DATA_MODE:
> >  	case EXT4_INODE_WRITEBACK_DATA_MODE:
> > @@ -4019,6 +4019,14 @@ void ext4_set_aops(struct inode *inode)
> >  		inode->i_mapping->a_ops = &ext4_da_aops;
> >  	else
> >  		inode->i_mapping->a_ops = &ext4_aops;
> > +
> > +	/*
> > +	 * Ensure all page cache allocations are done from GFP_NOFS context to
> > +	 * prevent direct reclaim recursion back into the filesystem and blowing
> > +	 * stacks or deadlocking.
> > +	 */
> > +	gfp_mask = mapping_gfp_mask(inode->i_mapping);
> > +	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
> 
> This looks like something that could hit every file systems, so
> shouldn't we fix this in common code?  We could also look into
> just using memalloc_nofs_save for the page cache allocation path
> instead of the per-mapping gfp_mask.

I think it has to be the entire IO path - any allocation from the
underlying filesystem could recurse into the top level filesystem
and then deadlock if the memory reclaim submits IO or blocks on
IO completion from the upper filesystem. That's a bloody big hammer
for something that is only necessary when there are stacked
filesystems like this....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
