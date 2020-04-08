Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1221A2BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDHW0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 18:26:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:54798 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDHW0j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:26:39 -0400
IronPort-SDR: 6pq+mChRpqA0WZFWT5H3wsSm4AAYwnhYuM2DQYwha+bofPAcWqj3NHJUCLRkY3+/zvz4g5nL99
 1FZFTvi+Qe5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 15:26:37 -0700
IronPort-SDR: S7w5tzhSIUMK1s0Evt+AKVNgzUL9c21YMfReFPfYHTUsV68lgWkEkFlNelu5tYpfqWc5BiUCib
 ekmJgdujvqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="275594942"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2020 15:26:37 -0700
Date:   Wed, 8 Apr 2020 15:26:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
 to xfs_ioctl_dax_check()
Message-ID: <20200408222636.GC664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-8-ira.weiny@intel.com>
 <20200408022318.GJ24067@dread.disaster.area>
 <20200408095803.GB30172@quack2.suse.cz>
 <20200408210950.GL24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408210950.GL24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:09:50AM +1000, Dave Chinner wrote:
> On Wed, Apr 08, 2020 at 11:58:03AM +0200, Jan Kara wrote:
> > On Wed 08-04-20 12:23:18, Dave Chinner wrote:
> > > On Tue, Apr 07, 2020 at 11:29:57AM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > We only support changing FS_XFLAG_DAX on directories.  Files get their
> > > > flag from the parent directory on creation only.  So no data
> > > > invalidation needs to happen.
> > > 
> > > Which leads me to ask: how are users and/or admins supposed to
> > > remove the flag from regular files once it is set in the filesystem?
> > > 
> > > Only being able to override the flag via the "dax=never" mount
> > > option means that once the flag is set, nobody can ever remove it
> > > and they can only globally turn off dax if it gets set incorrectly.
> > > It also means a global interrupt because all apps on the filesystem
> > > need to be stopped so the filesystem can be unmounted and mounted
> > > again with dax=never. This is highly unfriendly to admins and users.
> > > 
> > > IOWs, we _must_ be able to clear this inode flag on regular inodes
> > > in some way. I don't care if it doesn't change the current in-memory
> > > state, but we must be able to clear the flags so that the next time
> > > the inodes are instantiated DAX is not enabled for those files...
> > 
> > Well, there's one way to clear the flag: delete the file. If you still care
> > about the data, you can copy the data first. It isn't very convenient, I
> > agree, and effectively means restarting whatever application that is using
> > the file.
> 
> Restarting the application is fine. Having to backup/restore or copy
> the entire data set just to turn off an inode flag? That's not a
> viable management strategy. We could be talking about terabytes of
> data here.
> 
> I explained how we can safely remove the flag in the other branch of
> this thread...
> 
> > But it seems like more understandable API than letting user clear
> > the on-disk flag but the inode will still use DAX until kernel decides to
> > evict the inode
> 
> Certainly doesn't seem that way to me. "stop app, clear flags, drop
> caches, restart app" is a pretty simple, easy thing to do for an
> admin.

I want to be clear here: I think this is reasonable.  However, I don't see
consensus for that interface.

Christoph in particular said that a 'lazy change' is: "... straight from
the playbook for arcane and confusing API designs."

	"But returning an error and doing a lazy change anyway is straight from
	the playbook for arcane and confusing API designs."

	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/

Did I somehow misunderstand this?

Again for this patch set, 5.8, lets leave that alone for now.  I think if we
disable setting this on files right now we can still allow it in the future as
another step forward.

> 
> Especially compared to process that is effectively "stop app, backup
> data set, delete data set, clear flags, restore data set, restart
> app"
> 
> > - because that often means you need to restart the
> > application using the file anyway for the flag change to have any effect.
> 
> That's a trivial requirement compared to the downtime and resource
> cost of a data set backup/restore just to clear inode flags....
> 

I agree but others do not.  This still provides a baby step forward and some
granularity for those who plan out the creation of their files.

Ira

