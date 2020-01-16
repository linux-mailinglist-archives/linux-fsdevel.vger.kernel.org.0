Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B057C13D6CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 10:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgAPJYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 04:24:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:55526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgAPJYt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:24:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEE2FAE95;
        Thu, 16 Jan 2020 09:24:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 517A11E0CBC; Thu, 16 Jan 2020 10:24:46 +0100 (CET)
Date:   Thu, 16 Jan 2020 10:24:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Message-ID: <20200116092446.GA8446@quack2.suse.cz>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192942.25021-9-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-01-20 11:29:38, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> XFS requires regular files to be locked while changing to/from DAX mode.
> 
> Define a new DAX lock type and implement the [un]lock_mode() inode
> operation callbacks.
> 
> We define a new XFS_DAX_* lock type to carry the lock through the
> transaction because we don't want to use IOLOCK as that would cause
> performance issues with locking of the inode itself.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
...
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 492e53992fa9..693ca66bd89b 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -67,6 +67,9 @@ typedef struct xfs_inode {
>  	spinlock_t		i_ioend_lock;
>  	struct work_struct	i_ioend_work;
>  	struct list_head	i_ioend_list;
> +
> +	/* protect changing the mode to/from DAX */
> +	struct percpu_rw_semaphore i_dax_sem;
>  } xfs_inode_t;

This adds overhead of ~32k per inode for typical distro kernel. That's not
going to fly. That's why ext4 has similar kind of lock in the superblock
shared by all inodes. For read side it does not matter because that's
per-cpu and shared lock. For write side we don't care as changing inode
access mode should be rare.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
