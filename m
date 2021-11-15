Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94534517C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 23:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbhKOWqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 17:46:30 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:54735 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234008AbhKOW3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:29:31 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 35875A3EE7;
        Tue, 16 Nov 2021 09:26:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mmkQm-009HS0-AB; Tue, 16 Nov 2021 09:26:28 +1100
Date:   Tue, 16 Nov 2021 09:26:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211115222628.GP449541@dread.disaster.area>
References: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
 <163694306800.229789.11812765289669370510.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163694306800.229789.11812765289669370510.stgit@mickey.themaw.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6192de97
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=jUFqNg-nAAAA:8
        a=7-415B0cAAAA:8 a=EyonS_EgehF9X83yCPAA:9 a=CjuIK1q_8ugA:10
        a=hl_xKfOxWho2XEkUDbUg:22 a=-tElvS_Zar9K8zhlwiSp:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:24:28AM +0800, Ian Kent wrote:
> When following an inline symlink in rcu-walk mode it's possible to
> succeed in getting the ->get_link() method pointer but the link path
> string be deallocated while it's being used.
> 
> This is becuase of the xfs inode reclaim mechanism. While rcu freeing
> the link path can prevent it from being freed during use the inode
> reclaim could assign a new value to the field at any time outside of
> the path walk and result in an invalid link path pointer being
> returned. Admittedly a very small race window but possible.
> 
> The best way to mitigate this risk is to return -ECHILD to the VFS
> if the inline symlink method, ->get_link(), is called in rcu-walk mode
> so the VFS can switch to ref-walk mode or redo the walk if the inode
> has become invalid.
> 
> If it's discovered that staying in rcu-walk mode gives a worth while
> performance improvement (unlikely) then the link path could be freed
> under rcu once potential side effects of the xfs inode reclaim
> sub-system have been analysed and dealt with if needed.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/xfs/xfs_iops.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4..0a96183c5381 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -520,6 +520,9 @@ xfs_vn_get_link_inline(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	char			*link;
>  
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);
> +
>  	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);

NACK. As I just mentioned in the original thread, we can fix this
inode reuse within the RCU grace period problem realtively easily
without needing to turn off lockless pathwalk support for inline
symlinks.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
