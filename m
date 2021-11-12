Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E088044DF2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 01:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhKLAfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 19:35:50 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:38136 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234182AbhKLAft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 19:35:49 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 4E1DFA1DD1;
        Fri, 12 Nov 2021 11:32:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mlKUr-007jrt-Ty; Fri, 12 Nov 2021 11:32:49 +1100
Date:   Fri, 12 Nov 2021 11:32:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211112003249.GL449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=618db635
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=jUFqNg-nAAAA:8
        a=7-415B0cAAAA:8 a=M1zDxuRCMWIfiWoXodwA:9 a=CjuIK1q_8ugA:10
        a=hl_xKfOxWho2XEkUDbUg:22 a=-tElvS_Zar9K8zhlwiSp:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> When following a trailing symlink in rcu-walk mode it's possible to
> succeed in getting the ->get_link() method pointer but the link path
> string be deallocated while it's being used.
> 
> Utilize the rcu mechanism to mitigate this risk.
> 
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/xfs/kmem.h      |    4 ++++
>  fs/xfs/xfs_inode.c |    4 ++--
>  fs/xfs/xfs_iops.c  |   10 ++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> index 54da6d717a06..c1bd1103b340 100644
> --- a/fs/xfs/kmem.h
> +++ b/fs/xfs/kmem.h
> @@ -61,6 +61,10 @@ static inline void  kmem_free(const void *ptr)
>  {
>  	kvfree(ptr);
>  }
> +static inline void  kmem_free_rcu(const void *ptr)
> +{
> +	kvfree_rcu(ptr);
> +}
>  
>  
>  static inline void *
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index a4f6f034fb81..aaa1911e61ed 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2650,8 +2650,8 @@ xfs_ifree(
>  	 * already been freed by xfs_attr_inactive.
>  	 */
>  	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> -		kmem_free(ip->i_df.if_u1.if_data);
> -		ip->i_df.if_u1.if_data = NULL;
> +		kmem_free_rcu(ip->i_df.if_u1.if_data);
> +		RCU_INIT_POINTER(ip->i_df.if_u1.if_data, NULL);
>  		ip->i_df.if_bytes = 0;
>  	}

How do we get here in a way that the VFS will walk into this inode
during a lookup?

I mean, the dentry has to be validated and held during the RCU path
walk, so if we are running a transaction to mark the inode as free
here it has already been unlinked and the dentry turned
negative. So anything that is doing a lockless pathwalk onto that
dentry *should* see that it is a negative dentry at this point and
hence nothing should be walking any further or trying to access the
link that was shared from ->get_link().

AFAICT, that's what the sequence check bug you fixed in the previous
patch guarantees. It makes no difference if the unlinked inode has
been recycled or not, the lookup race condition is the same in that
the inode has gone through ->destroy_inode and is now owned by the
filesystem and not the VFS.

Otherwise, it might just be best to memset the buffer to zero here
rather than free it, and leave it to be freed when the inode is
freed from the RCU callback in xfs_inode_free_callback() as per
normal.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
