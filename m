Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9D13BE9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgAOLhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 06:37:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgAOLhT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:37:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10DC6AEEE;
        Wed, 15 Jan 2020 11:37:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B5171E0D08; Wed, 15 Jan 2020 12:37:15 +0100 (CET)
Date:   Wed, 15 Jan 2020 12:37:15 +0100
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
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200115113715.GB2595@quack2.suse.cz>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192942.25021-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order for users to determine if a file is currently operating in DAX
> mode (effective DAX).  Define a statx attribute value and set that
> attribute if the effective DAX flag is set.
> 
> To go along with this we propose the following addition to the statx man
> page:
> 
> STATX_ATTR_DAX
> 
> 	DAX (cpu direct access) is a file mode that attempts to minimize
> 	software cache effects for both I/O and memory mappings of this
> 	file.  It requires a capable device, a compatible filesystem
> 	block size, and filesystem opt-in. It generally assumes all
> 	accesses are via cpu load / store instructions which can
> 	minimize overhead for small accesses, but adversely affect cpu
> 	utilization for large transfers. File I/O is done directly
> 	to/from user-space buffers. While the DAX property tends to
> 	result in data being transferred synchronously it does not give
> 	the guarantees of synchronous I/O that data and necessary
> 	metadata are transferred. Memory mapped I/O may be performed
> 	with direct mappings that bypass system memory buffering. Again
> 	while memory-mapped I/O tends to result in data being
> 	transferred synchronously it does not guarantee synchronous
> 	metadata updates. A dax file may optionally support being mapped
> 	with the MAP_SYNC flag which does allow cpu store operations to
> 	be considered synchronous modulo cpu cache effects.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

This looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
