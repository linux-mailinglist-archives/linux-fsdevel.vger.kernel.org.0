Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A21A18C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGXr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 19:47:57 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46950 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgDGXr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:47:57 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D3CF43A34BE;
        Wed,  8 Apr 2020 09:47:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jLxwb-0005aM-BR; Wed, 08 Apr 2020 09:47:49 +1000
Date:   Wed, 8 Apr 2020 09:47:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 3/8] fs/stat: Define DAX statx attribute
Message-ID: <20200407234749.GE24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407182958.568475-4-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=luxjZY3Et4Z6tp6Ed88A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:29:53AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order for users to determine if a file is currently operating in DAX
> state (effective DAX).  Define a statx attribute value and set that
> attribute if the effective DAX flag is set.
> 
> To go along with this we propose the following addition to the statx man
> page:
> 
> STATX_ATTR_DAX
> 
> 	The file is in the DAX (cpu direct access) state.  DAX state
> 	attempts to minimize software cache effects for both I/O and
> 	memory mappings of this file.  It requires a file system which
> 	has been configured to support DAX.
> 
> 	DAX generally assumes all accesses are via cpu load / store
> 	instructions which can minimize overhead for small accesses, but
> 	may adversely affect cpu utilization for large transfers.
> 
> 	File I/O is done directly to/from user-space buffers and memory
> 	mapped I/O may be performed with direct memory mappings that
> 	bypass kernel page cache.
> 
> 	While the DAX property tends to result in data being transferred
> 	synchronously, it does not give the same guarantees of O_SYNC
> 	where data and the necessary metadata are transferred together.
> 
> 	A DAX file may support being mapped with the MAP_SYNC flag,
> 	which enables a program to use CPU cache flush instructions to
> 	persist CPU store operations without an explicit fsync(2).  See
> 	mmap(2) for more information.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2:
> 	Update man page text with comments from Darrick, Jan, Dan, and
> 	Dave.
> ---
>  fs/stat.c                 | 3 +++
>  include/uapi/linux/stat.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 030008796479..894699c74dde 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> +	if (IS_DAX(inode))
> +		stat->attributes |= STATX_ATTR_DAX;
> +
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
>  					    query_flags);
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index ad80a5c885d5..e5f9d5517f6b 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -169,6 +169,7 @@ struct statx {
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */

Looks fine. Man page text seems ok, too.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
