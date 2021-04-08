Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14C3584BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhDHNcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 09:32:10 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:59264 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhDHNcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:32:07 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 09:32:06 EDT
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id F11186C01C6B;
        Thu,  8 Apr 2021 16:25:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617888312; bh=O2I5sRbsIGV6O7BRd81yBLGFZqvG4P4JnLPd6Ijeamg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=WkugiplNaH4XCk6aVA2NznlBO0dCN+YN9BvN6Gu6tVb82IwiLGdY52NbzbrWikL7Z
         nCn0ilSVtp6zVFqvcs6Hpt8z2FH1YBq0Fi9rCyXinFjhMesdZt48iFUC7pZlU+qFmu
         /88sp16IKcOmTz+87ZCDc01atwu64Y7Q2CCLpEBc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E1F6B6C01C68;
        Thu,  8 Apr 2021 16:25:11 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id cWmb_CTFk_k9; Thu,  8 Apr 2021 16:25:11 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 571956C019FD;
        Thu,  8 Apr 2021 16:25:11 +0300 (EEST)
Received: from nas (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 4E5D91BE2271;
        Thu,  8 Apr 2021 16:25:02 +0300 (EEST)
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-8-ruansy.fnst@fujitsu.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Date:   Thu, 08 Apr 2021 21:12:00 +0800
Message-ID: <czv4syut.fsf@damenly.su>
In-reply-to: <20210408120432.1063608-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mlY5SaUCpygHhXxmqCAcxrytLVO7k/+GmqX1UmH7kOSmad00TUxOr7h97Nxyk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu 08 Apr 2021 at 20:04, Shiyang Ruan 
<ruansy.fnst@fujitsu.com> wrote:

> Add xfs_break_two_dax_layouts() to break layout for tow dax 
> files.  Then
> call compare range function only when files are both DAX or not.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
Not family with xfs code but reading code make my sleep better :)
See bellow.

> ---
>  fs/xfs/xfs_file.c    | 20 ++++++++++++++++++++
>  fs/xfs/xfs_inode.c   |  8 +++++++-
>  fs/xfs/xfs_inode.h   |  1 +
>  fs/xfs/xfs_reflink.c |  5 +++--
>  4 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5795d5d6f869..1fd457167c12 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -842,6 +842,26 @@ xfs_break_dax_layouts(
>  			0, 0, xfs_wait_dax_page(inode));
>  }
>
> +int
> +xfs_break_two_dax_layouts(
> +	struct inode		*src,
> +	struct inode		*dest)
> +{
> +	int			error;
> +	bool			retry = false;
> +
> +retry:
>
'retry = false;' ? since xfs_break_dax_layouts() won't
set retry to false if there is no busy page in inode->i_mapping.
Dead loop will happen if retry is true once.

> +	error = xfs_break_dax_layouts(src, &retry);
> +	if (error || retry)
> +		goto retry;
> +
> +	error = xfs_break_dax_layouts(dest, &retry);
> +	if (error || retry)
> +		goto retry;
> +
> +	return error;
> +}
> +
>  int
>  xfs_break_layouts(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index f93370bd7b1e..c01786917eef 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3713,8 +3713,10 @@ xfs_ilock2_io_mmap(
>  	struct xfs_inode	*ip2)
>  {
>  	int			ret;
> +	struct inode		*inode1 = VFS_I(ip1);
> +	struct inode		*inode2 = VFS_I(ip2);
>
> -	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), 
> VFS_I(ip2));
> +	ret = xfs_iolock_two_inodes_and_break_layout(inode1, inode2);
>  	if (ret)
>  		return ret;
>  	if (ip1 == ip2)
> @@ -3722,6 +3724,10 @@ xfs_ilock2_io_mmap(
>  	else
>  		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
>  				    ip2, XFS_MMAPLOCK_EXCL);
> +
> +	if (IS_DAX(inode1) && IS_DAX(inode2))
> +		ret = xfs_break_two_dax_layouts(inode1, inode2);
> +
ret is ignored here.

--
Su
>  	return 0;
>  }
>
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 88ee4c3930ae..5ef21924dddc 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -435,6 +435,7 @@ enum xfs_prealloc_flags {
>
>  int	xfs_update_prealloc_flags(struct xfs_inode *ip,
>  				  enum xfs_prealloc_flags flags);
> +int	xfs_break_two_dax_layouts(struct inode *inode1, struct 
> inode *inode2);
>  int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  		enum layout_break_reason reason);
>
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index a4cd6e8a7aa0..4426bcc8a985 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -29,6 +29,7 @@
>  #include "xfs_iomap.h"
>  #include "xfs_sb.h"
>  #include "xfs_ag_resv.h"
> +#include <linux/dax.h>
>
>  /*
>   * Copy on Write of Shared Blocks
> @@ -1324,8 +1325,8 @@ xfs_reflink_remap_prep(
>  	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>  		goto out_unlock;
>
> -	/* Don't share DAX file data for now. */
> -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> +	/* Don't share DAX file data with non-DAX file. */
> +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
>  		goto out_unlock;
>
>  	if (!IS_DAX(inode_in))
