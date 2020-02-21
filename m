Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A4166C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 02:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgBUB0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 20:26:33 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59810 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729476AbgBUB0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:26:32 -0500
Received: from dread.disaster.area (pa49-195-185-106.pa.nsw.optusnet.com.au [49.195.185.106])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EF33682017D;
        Fri, 21 Feb 2020 12:26:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4x5F-000591-FM; Fri, 21 Feb 2020 12:26:25 +1100
Date:   Fri, 21 Feb 2020 12:26:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 01/13] fs/xfs: Remove unnecessary initialization of
 i_rwsem
Message-ID: <20200221012625.GT10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=bkRQb8bsQZKWSSj4M57YXw==:117 a=bkRQb8bsQZKWSSj4M57YXw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=V8yeCck6NC70EfR_wKwA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:22PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_reinit_inode() -> inode_init_always() already handles calling
> init_rwsem(i_rwsem).  Doing so again is unneeded.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Except that this inode has been destroyed and freed by the VFS, and
we are now recycling it back into the VFS before we actually
physically freed it.

Hence we have re-initialise the semaphore because the semaphore can
contain internal state that is specific to it's new life cycle (e.g.
the lockdep context) that will cause problems if we just assume that
the inode is the same inode as it was before we recycled it back
into the VFS caches.

So, yes, we actually do need to re-initialise the rwsem here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
