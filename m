Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC626B17F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgIOWbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:31:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgIOQRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGFZfu160482;
        Tue, 15 Sep 2020 16:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XT+yvQZiRbm8/UYbzOSiuWASepQF3mZn7H7wTZi/Cp8=;
 b=rxNuxNpvSiBY67BhGaZVFf7Lzy7cDpj39QD3Ggz4KUPcJyxFvis7DrTYpvOssCP0yvWF
 9EdMCxKq1JlSDAFQ7oe4or98/K6AJRz5DRgXq5G9fU7veW4664CvF3gi8dC3izjSrXV3
 No8w0pUT72uyfbb2gXyN0shy1DofMElXb0wjf1GPVGw08H74Yn69Gnj+EbX/RtCOoouK
 v2RdLJBW0DYxkM+lTzqt0h8GUn8qdWWxUEAACbvNVBCGidHu3Yw8NbYkp5mGBd8JpQ89
 CjBjuAybJnE5wvNwlFlVCX6VvEd80FbdLoVfOWo7eYTkNG7FaTFP+tXAlWw2kBVLd11R pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqx52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 16:16:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGBQQe094538;
        Tue, 15 Sep 2020 16:16:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h885bn7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:16:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FGG7HT015423;
        Tue, 15 Sep 2020 16:16:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 16:16:07 +0000
Date:   Tue, 15 Sep 2020 09:16:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH 1/4] fs: introduce ->storage_lost() for memory-failure
Message-ID: <20200915161606.GD7955@magnolia>
References: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
 <20200915101311.144269-2-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915101311.144269-2-ruansy.fnst@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=5 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=5
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:13:08PM +0800, Shiyang Ruan wrote:
> This function is used to handle errors which may cause data lost in
> filesystem.  Such as memory-failure in fsdax mode.
> 
> In XFS, it requires "rmapbt" feature in order to query for files or
> metadata which associated to the error block.  Then we could call fs
> recover functions to try to repair the damaged data.(did not implemented
> in this patch)
> 
> After that, the memory-failure also needs to kill processes who are
> using those files.  The struct mf_recover_controller is created to store
> necessary parameters.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_super.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  include/linux/mm.h |  6 ++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 71ac6c1cdc36..118d9c5d9e1e 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -35,6 +35,10 @@
>  #include "xfs_refcount_item.h"
>  #include "xfs_bmap_item.h"
>  #include "xfs_reflink.h"
> +#include "xfs_alloc.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_bit.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
> @@ -1104,6 +1108,81 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +static int
> +xfs_storage_lost_helper(
> +	struct xfs_btree_cur		*cur,
> +	struct xfs_rmap_irec		*rec,
> +	void				*priv)
> +{
> +	struct xfs_inode		*ip;
> +	struct mf_recover_controller	*mfrc = priv;
> +	int				rc = 0;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
> +		// TODO check and try to fix metadata
> +	} else {
> +		/*
> +		 * Get files that incore, filter out others that are not in use.
> +		 */
> +		xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
> +			 0, &ip);

Missing return value check here.

> +		if (!ip)
> +			return 0;
> +		if (!VFS_I(ip)->i_mapping)
> +			goto out;
> +
> +		rc = mfrc->recover_fn(mfrc->pfn, mfrc->flags,
> +				      VFS_I(ip)->i_mapping, rec->rm_offset);
> +
> +		// TODO try to fix data
> +out:
> +		xfs_irele(ip);
> +	}
> +
> +	return rc;
> +}
> +
> +static int
> +xfs_fs_storage_lost(
> +	struct super_block	*sb,
> +	loff_t			offset,

offset into which device?  XFS supports three...

I'm also a little surprised you don't pass in a length.

I guess that means this function will get called repeatedly for every
byte in the poisoned range?

> +	void			*priv)
> +{
> +	struct xfs_mount	*mp = XFS_M(sb);
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_rmap_irec	rmap_low, rmap_high;
> +	struct xfs_buf		*agf_bp = NULL;
> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
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

...and this is definitely the wrong call sequence if the malfunctioning
device is the realtime device.  If a dax rt device dies, you'll be
shooting down files on the data device, which will cause all sorts of
problems.

Question: Should all this poison recovery stuff go into a new file?
xfs_poison.c?  There's already a lot of code in xfs_super.c.

--D

> +
> +	/* Construct a range for rmap query */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
> +
> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
> +				     xfs_storage_lost_helper, priv);
> +	if (error == -ECANCELED)
> +		error = 0;
> +
> +	xfs_btree_del_cursor(cur, error);
> +	xfs_trans_brelse(tp, agf_bp);
> +	return error;
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1117,6 +1196,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.storage_lost		= xfs_fs_storage_lost,
>  };
>  
>  static int
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e019ea2f1347..bd90485cfdc9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1951,6 +1951,7 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	int (*storage_lost)(struct super_block *sb, loff_t offset, void *priv);
>  };
>  
>  /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1983e08f5906..3f0c36e1bf3d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3002,6 +3002,12 @@ extern void shake_page(struct page *p, int access);
>  extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(unsigned long pfn, int flags);
>  
> +struct mf_recover_controller {
> +	int (*recover_fn)(unsigned long pfn, int flags,
> +		struct address_space *mapping, pgoff_t index);
> +	unsigned long pfn;
> +	int flags;
> +};
>  
>  /*
>   * Error handlers for various types of pages.
> -- 
> 2.28.0
> 
> 
> 
