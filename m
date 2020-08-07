Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CDE23F0CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGQQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 12:16:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHGQQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:16:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077GBQOS027293;
        Fri, 7 Aug 2020 16:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Iw9gSXOT177RL8c5e54Q3cyOdHO3XECC9NU+v/BWeOo=;
 b=mnQfNCSPb2InFc+cNqgOSdQsDi0Eghe526jJr33AVNMBVINNJGfyNKaSmZv+25WlLG79
 xcbZG4MGWLVG3iW31jyWub51ov3/uN1p907iOKuzm4WFYqN/YRr/5crg9FEPtUKrzi/U
 q9y553uFmrD3JfDmAxNdZb7NJKSn7bU0d9DP2Gg7dT7aq2DfXlbf5ZumMLl82+6Df5j9
 YKbImz/j0WX4ZkCREJarSjksa3k25DBhEyUwzvbnjV67Bj1LHfPD9IazhmOAr2/qMgBu
 e+c9PgrDFHiqwsMBfiPQs357tfQTXVofqoTKI3ssXMQZMrTgYxXN3ewcJs068RUKrS7c Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32r6gx1cwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 07 Aug 2020 16:15:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077G80mw090947;
        Fri, 7 Aug 2020 16:15:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32r6cxya29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Aug 2020 16:15:32 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 077GFSgT003950;
        Fri, 7 Aug 2020 16:15:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Aug 2020 09:15:28 -0700
Date:   Fri, 7 Aug 2020 09:15:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH 1/8] fs: introduce get_shared_files() for dax&reflink
Message-ID: <20200807161526.GD6090@magnolia>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807131336.318774-2-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807131336.318774-2-ruansy.fnst@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=5 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:13:29PM +0800, Shiyang Ruan wrote:
> Under the mode of both dax and reflink on, one page may be shared by
> multiple files and offsets.  In order to track them in memory-failure or
> other cases, we introduce this function by finding out who is sharing
> this block(the page) in a filesystem.  It returns a list that contains
> all the owners, and the offset in each owner.
> 
> For XFS, rmapbt is used to find out the owners of one block.  So, it
> should be turned on when we want to use dax&reflink feature together.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_super.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h |  7 +++++
>  include/linux/fs.h  |  2 ++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 379cbff438bc..b71392219c91 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -35,6 +35,9 @@
>  #include "xfs_refcount_item.h"
>  #include "xfs_bmap_item.h"
>  #include "xfs_reflink.h"
> +#include "xfs_alloc.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
> @@ -1097,6 +1100,69 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +static int _get_shared_files_fn(

Needs an xfs_ prefix...

> +	struct xfs_btree_cur	*cur,
> +	struct xfs_rmap_irec	*rec,
> +	void			*priv)
> +{
> +	struct list_head	*list = priv;
> +	struct xfs_inode	*ip;
> +	struct shared_files	*sfp;
> +
> +	/* Get files that incore, filter out others that are not in use. */
> +	xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE, 0, &ip);

No error checking at all?

What if rm_owner refers to metadata?

> +	if (ip && !ip->i_vnode.i_mapping)
> +		return 0;

When is the xfs_inode released?  We don't iput it here, and there's no
way for dax_unlock_page (afaict the only consumer) to do it, so we
leak the reference.

> +
> +	sfp = kmalloc(sizeof(*sfp), GFP_KERNEL);

If there are millions of open files reflinked to this range of pmem this
is going to allocate a /lot/ of memory.

> +	sfp->mapping = ip->i_vnode.i_mapping;

sfp->mapping = VFS_I(ip)->i_mapping;

> +	sfp->index = rec->rm_offset;
> +	list_add_tail(&sfp->list, list);

Why do we leave ->cookie uninitialized?  What does it even do?

> +
> +	return 0;
> +}
> +
> +static int
> +xfs_fs_get_shared_files(
> +	struct super_block	*sb,
> +	pgoff_t			offset,

Which device does this offset refer to?  XFS supports multiple storage
devices.

Also, uh, is this really a pgoff_t?  If yes, you can't use it with
XFS_B_TO_FSB below without first converting it to a loff_t.

> +	struct list_head	*list)
> +{
> +	struct xfs_mount	*mp = XFS_M(sb);
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_rmap_irec	rmap_low = { 0 }, rmap_high = { 0 };

No need to memset(0) rmap_low later, or zero rmap_high just to memset it
later.

> +	struct xfs_buf		*agf_bp = NULL;
> +	xfs_agblock_t		bno = XFS_B_TO_FSB(mp, offset);

"FSB" refers to xfs_fsblock_t.  You just ripped the upper 32 bits off
the fsblock number.

> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, bno);
> +	int			error = 0;
> +
> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;
> +
> +	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +	if (error)
> +		return error;
> +
> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
> +
> +	memset(&cur->bc_rec, 0, sizeof(cur->bc_rec));

Not necessary, bc_rec is zero in a freshly created cursor.

> +	/* Construct the range for one rmap search */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = bno;
> +
> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
> +				     _get_shared_files_fn, list);
> +	if (error == -ECANCELED)
> +		error = 0;
> +
> +	xfs_btree_del_cursor(cur, error);
> +	xfs_trans_brelse(tp, agf_bp);
> +	return error;
> +}

Looking at this, I don't think this is the right way to approach memory
poisoning.  Rather than allocating a (potentially huge) linked list and
passing it to the memory poison code to unmap pages, kill processes, and
free the list, I think:

1) "->get_shared_files" should be more targetted.  Call it ->storage_lost
or something, so that it only has one purpose, which is to react to
asynchronous notifications that storage has been lost.

2) The inner _get_shared_files_fn should directly call back into the
memory manager to remove a poisoned page from the mapping and signal
whatever process might have it mapped.

That way, _get_shared_files_fn can look in the xfs buffer cache to see
if we have a copy in DRAM, and immediately write it back to pmem.

Hmm and now that you've gotten me rambling about hwpoison, I wonder what
happens if dram backing part of the xfs buffer cache goes bad...

--D

> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1110,6 +1176,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.get_shared_files	= xfs_fs_get_shared_files,
>  };
>  
>  static int
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 6904d4e0b2e0..0a85e321d6b4 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -40,6 +40,13 @@ struct dax_operations {
>  
>  extern struct attribute_group dax_attribute_group;
>  
> +struct shared_files {
> +	struct list_head	list;
> +	struct address_space	*mapping;
> +	pgoff_t			index;
> +	dax_entry_t		cookie;
> +};
> +
>  #if IS_ENABLED(CONFIG_DAX)
>  struct dax_device *dax_get_by_host(const char *host);
>  struct dax_device *alloc_dax(void *private, const char *host,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5abba86107d..81de3d2739b9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1977,6 +1977,8 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	int (*get_shared_files)(struct super_block *sb, pgoff_t offset,
> +				struct list_head *list);
>  };
>  
>  /*
> -- 
> 2.27.0
> 
> 
> 
