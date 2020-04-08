Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861BF1A1E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgDHJ6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 05:58:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHJ6G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD924AC2C;
        Wed,  8 Apr 2020 09:58:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B04B41E1239; Wed,  8 Apr 2020 11:58:03 +0200 (CEST)
Date:   Wed, 8 Apr 2020 11:58:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
 to xfs_ioctl_dax_check()
Message-ID: <20200408095803.GB30172@quack2.suse.cz>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-8-ira.weiny@intel.com>
 <20200408022318.GJ24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408022318.GJ24067@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-04-20 12:23:18, Dave Chinner wrote:
> On Tue, Apr 07, 2020 at 11:29:57AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > We only support changing FS_XFLAG_DAX on directories.  Files get their
> > flag from the parent directory on creation only.  So no data
> > invalidation needs to happen.
> 
> Which leads me to ask: how are users and/or admins supposed to
> remove the flag from regular files once it is set in the filesystem?
> 
> Only being able to override the flag via the "dax=never" mount
> option means that once the flag is set, nobody can ever remove it
> and they can only globally turn off dax if it gets set incorrectly.
> It also means a global interrupt because all apps on the filesystem
> need to be stopped so the filesystem can be unmounted and mounted
> again with dax=never. This is highly unfriendly to admins and users.
> 
> IOWs, we _must_ be able to clear this inode flag on regular inodes
> in some way. I don't care if it doesn't change the current in-memory
> state, but we must be able to clear the flags so that the next time
> the inodes are instantiated DAX is not enabled for those files...

Well, there's one way to clear the flag: delete the file. If you still care
about the data, you can copy the data first. It isn't very convenient, I
agree, and effectively means restarting whatever application that is using
the file. But it seems like more understandable API than letting user clear
the on-disk flag but the inode will still use DAX until kernel decides to
evict the inode - because that often means you need to restart the
application using the file anyway for the flag change to have any effect.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
