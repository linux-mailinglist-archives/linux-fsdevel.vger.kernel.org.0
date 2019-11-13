Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB7FB3A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfKMPZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 10:25:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:53214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbfKMPZY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:25:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A799B483;
        Wed, 13 Nov 2019 15:25:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 966E7DA7E8; Wed, 13 Nov 2019 16:25:22 +0100 (CET)
Date:   Wed, 13 Nov 2019 16:25:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2 2/2] fs: Move swap_[de]activate to file_operations
Message-ID: <20191113152522.GF3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
References: <20191113004244.9981-1-ira.weiny@intel.com>
 <20191113004244.9981-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113004244.9981-3-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:42:44PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> swap_activate() and swap_deactivate() have nothing to do with address
> spaces.  We want to be able to change the address space operations on
> the fly to allow changing inode flags dynamically.
> 
> Switching address space operations can be difficult to do reliably.[1]
> Therefore, to simplify switching address space operations we reduce the
> number of functions in those operations by moving swap_activate() and
> swap_deactivate() out of the address space operations.
> 
> No functionality is changed with this patch.
> 
> This has been tested with XFS but not NFS, f2fs, or btrfs.
> 
> Also note we move some functions to facilitate compilation.  But there
> are no functional changes are contained within those diffs.
> 
> [1] https://lkml.org/lkml/2019/11/11/572
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V0:
> 	Update cover letter.
> 	fix btrfs as per Andrew's comments
> 	change xfs_iomap_swapfile_activate() to xfs_file_swap_activate()
> 
> Changes from V1:
> 	Update recipients list
> 
> 
>  fs/btrfs/file.c    | 341 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c   | 340 --------------------------------------------

For the btrfs part

Acked-by: David Sterba <dsterba@suse.com>

There's going to be a minor conflict with current 5.5 queue, the
resolution is simple rename of btrfs_block_group_cache to btrfs_block_group.
