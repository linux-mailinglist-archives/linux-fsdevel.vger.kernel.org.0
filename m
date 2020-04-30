Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F781BF3E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD3JNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 05:13:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:49608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgD3JNb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3943CAB7F;
        Thu, 30 Apr 2020 09:13:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7F9AD1E1295; Thu, 30 Apr 2020 11:13:29 +0200 (CEST)
Date:   Thu, 30 Apr 2020 11:13:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHv3 1/1] fibmap: Warn and return an error in case of block
 > INT_MAX
Message-ID: <20200430091329.GC12716@quack2.suse.cz>
References: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 30-04-20 10:25:18, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to pr_warn() all user of ioctl_fibmap() and return a proper
> error code rather than silently letting a FS corruption happen if the
> user tries to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Now iomap_bmap() could be called from either of these two paths.
> Either when a user is calling an ioctl_fibmap() interface to get
> the block mapping address or by some filesystem via use of bmap()
> internal kernel API.
> bmap() kernel API is well equipped with handling of u64 addresses.
> 
> WARN condition in iomap_bmap_actor() was mainly added to warn all
> the fibmap users. But now that we have directly added this warning
> for all fibmap users and also made sure to return 0 as block map address
> in case if addr > INT_MAX.
> So we can now remove this logic from iomap_bmap_actor().
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2 -> v3:
> 1. Added file path info using (%pD4)
> 2. Dropped Reviewed-by tags for reviewing this final version.
> 
>  fs/ioctl.c        | 8 ++++++++
>  fs/iomap/fiemap.c | 5 +----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f1d93263186c..6b8629fbe0fd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -55,6 +55,7 @@ EXPORT_SYMBOL(vfs_ioctl);
>  static int ioctl_fibmap(struct file *filp, int __user *p)
>  {
>  	struct inode *inode = file_inode(filp);
> +	struct super_block *sb = inode->i_sb;
>  	int error, ur_block;
>  	sector_t block;
>  
> @@ -71,6 +72,13 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	block = ur_block;
>  	error = bmap(inode, &block);
>  
> +	if (block > INT_MAX) {
> +		error = -ERANGE;
> +		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
> +				    current->comm, task_pid_nr(current),
> +				    sb->s_id, filp);
> +	}
> +
>  	if (error)
>  		ur_block = 0;
>  	else
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce..d55e8f491a5e 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (iomap->type == IOMAP_MAPPED) {
>  		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		if (addr > INT_MAX)
> -			WARN(1, "would truncate bmap result\n");
> -		else
> -			*bno = addr;
> +		*bno = addr;
>  	}
>  	return 0;
>  }
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
