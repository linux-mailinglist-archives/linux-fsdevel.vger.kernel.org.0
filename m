Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55F1A2CAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgDHX6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 19:58:40 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59055 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbgDHX6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:58:40 -0400
Received: from dread.disaster.area (pa49-180-167-53.pa.nsw.optusnet.com.au [49.180.167.53])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D79627EC8C5;
        Thu,  9 Apr 2020 09:58:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMKaa-0005sK-6b; Thu, 09 Apr 2020 09:58:36 +1000
Date:   Thu, 9 Apr 2020 09:58:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200408235836.GQ24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=2xmR08VVv0jSFCMMkhec0Q==:117 a=2xmR08VVv0jSFCMMkhec0Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=7-415B0cAAAA:8 a=g6yMfty2fWIsApY3Z_YA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:28:30PM -0700, Dan Williams wrote:
> On Wed, Apr 8, 2020 at 2:02 PM Dave Chinner <david@fromorbit.com> wrote:
> > THis leads to an obvious conclusion: if we never clear the in memory
> > S_DAX flag, we can actually clear the on-disk flag safely, so that
> > next time the inode cycles into memory it won't be using DAX. IOWs,
> > admins can stop the applications, clear the DAX flag and drop
> > caches. This should result in the inode being recycled and when the
> > app is restarted it will run without DAX. No ned for deleting files,
> > copying large data sets, etc just to turn off an inode flag.
> 
> Makes sense, but is that sufficient? I recall you saying there might
> be a multitude of other reasons that the inode is not evicted, not the
> least of which is races [1]. Does this need another flag, lets call it
> "dax toggle" to track the "I requested the inode to clear the flag,
> but on cache-flush + restart the inode never got evicted" case.

You mean something like XFS_IDONTCACHE?

i.e. the functionality already exists in XFS to selectively evict an
inode from cache when the last reference to it is dropped rather
than let it go to the LRUs and hang around in memory.

That flag can be set when changing the on disk DAX flag, and we can
tweak how it works so new cache hits don't clear it (as happens
now). Hence the only thing that can prevent eviction are active
references.

That means we'll still need to stop the application and drop_caches,
because we need to close all the files and purge the dentries that
hold references to the inode before it can be evicted.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
