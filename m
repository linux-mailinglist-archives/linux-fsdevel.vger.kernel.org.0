Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E013F4CD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKHNMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 08:12:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:46874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbfKHNMl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:12:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15F75AE2A;
        Fri,  8 Nov 2019 13:12:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8C0061E3BE4; Fri,  8 Nov 2019 14:12:38 +0100 (CET)
Date:   Fri, 8 Nov 2019 14:12:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/xfs: Allow toggle of physical DAX flag
Message-ID: <20191108131238.GK20863@quack2.suse.cz>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
 <20191021004536.GD8015@dread.disaster.area>
 <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 15:49:31, Ira Weiny wrote:
> On Mon, Oct 21, 2019 at 11:45:36AM +1100, Dave Chinner wrote:
> > On Sun, Oct 20, 2019 at 08:59:35AM -0700, ira.weiny@intel.com wrote:
> > That, fundamentally, is the issue here - it's not setting/clearing
> > the DAX flag that is the issue, it's doing a swap of the
> > mapping->a_ops while there may be other code using that ops
> > structure.
> > 
> > IOWs, if there is any code anywhere in the kernel that
> > calls an address space op without holding one of the three locks we
> > hold here (i_rwsem, MMAPLOCK, ILOCK) then it can race with the swap
> > of the address space operations.
> > 
> > By limiting the address space swap to file sizes of zero, we rule
> > out the page fault path (mmap of a zero length file segv's with an
> > access beyond EOF on the first read/write page fault, right?).
> 
> Yes I checked that and thought we were safe here...
> 
> > However, other aops callers that might run unlocked and do the wrong
> > thing if the aops pointer is swapped between check of the aop method
> > existing and actually calling it even if the file size is zero?
> > 
> > A quick look shows that FIBMAP (ioctl_fibmap())) looks susceptible
> > to such a race condition with the current definitions of the XFS DAX
> > aops. I'm guessing there will be others, but I haven't looked
> > further than this...
> 
> I'll check for others and think on what to do about this.  ext4 will have the
> same problem I think.  :-(

Just as a datapoint, ext4 is bold and sets inode->i_mapping->a_ops on
existing inodes when switching journal data flag and so far it has not
blown up. What we did to deal with issues Dave describes is that we
introduced percpu rw-semaphore guarding switching of aops and then inside
problematic functions redirect callbacks in the right direction under this
semaphore. Somewhat ugly but it seems to work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
