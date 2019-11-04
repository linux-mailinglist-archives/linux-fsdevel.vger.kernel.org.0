Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018CCEF122
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfKDXUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:20:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53388 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKDXUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:20:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4NJY8u071789;
        Mon, 4 Nov 2019 23:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1cx1RbADQKDZqG/g3NhoeTvntNZxR921bxJ3a014JHg=;
 b=nB5dVG7Vclcs8O5OgoIdXggoGJG/i3PX3ipv8Fyk9hXLk9w3PWbRBzHI5Tas28pCfUxf
 Ug/I7XgMjHzpvFwY7HrnVzvcd4REHgbtWcidoIENsrI603W55yVlD/Jud8e8jssdfl2F
 7fmgOMjal37HSevFbhv698SSmmS049qi9l092WPEgz4H+W3rp4cxBiNyvDMk2hPWOCS1
 y1/j35DiKLQ7gCeCxo8uVK+eJc9Aj0ldcGlxV9R9xSDr2h6QaaJc746TmFckpK+qc+rz
 Ex7xV64x3I856JJRg/jk9M7o7CVoebfueeGKS5jIkntM9IMdpiEtf++BHHWouOCA4t2Q ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w117ttpkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:20:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4NJ5lT069076;
        Mon, 4 Nov 2019 23:20:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w1k8vpqgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:20:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4NK1YC019709;
        Mon, 4 Nov 2019 23:20:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 15:20:01 -0800
Date:   Mon, 4 Nov 2019 15:20:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/28] xfs: factor inode lookup from xfs_ifree_cluster
Message-ID: <20191104232000.GR4153244@magnolia>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031234618.15403-9-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040222
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:58AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> There's lots of indent in this code which makes it a bit hard to
> follow. We are also going to completely rework the inode lookup code
> as part of the inode reclaim rework, so factor out the inode lookup
> code from the inode cluster freeing code.
> 
> Based on prototype code from Christoph Hellwig.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Seems pretty straightforward,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_inode.c | 152 +++++++++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 68 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index e9e4f444f8ce..33edb18098ca 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2516,6 +2516,88 @@ xfs_iunlink_remove(
>  	return error;
>  }
>  
> +/*
> + * Look up the inode number specified and mark it stale if it is found. If it is
> + * dirty, return the inode so it can be attached to the cluster buffer so it can
> + * be processed appropriately when the cluster free transaction completes.
> + */
> +static struct xfs_inode *
> +xfs_ifree_get_one_inode(
> +	struct xfs_perag	*pag,
> +	struct xfs_inode	*free_ip,
> +	int			inum)
> +{
> +	struct xfs_mount	*mp = pag->pag_mount;
> +	struct xfs_inode	*ip;
> +
> +retry:
> +	rcu_read_lock();
> +	ip = radix_tree_lookup(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, inum));
> +
> +	/* Inode not in memory, nothing to do */
> +	if (!ip)
> +		goto out_rcu_unlock;
> +
> +	/*
> +	 * because this is an RCU protected lookup, we could find a recently
> +	 * freed or even reallocated inode during the lookup. We need to check
> +	 * under the i_flags_lock for a valid inode here. Skip it if it is not
> +	 * valid, the wrong inode or stale.
> +	 */
> +	spin_lock(&ip->i_flags_lock);
> +	if (ip->i_ino != inum || __xfs_iflags_test(ip, XFS_ISTALE)) {
> +		spin_unlock(&ip->i_flags_lock);
> +		goto out_rcu_unlock;
> +	}
> +	spin_unlock(&ip->i_flags_lock);
> +
> +	/*
> +	 * Don't try to lock/unlock the current inode, but we _cannot_ skip the
> +	 * other inodes that we did not find in the list attached to the buffer
> +	 * and are not already marked stale. If we can't lock it, back off and
> +	 * retry.
> +	 */
> +	if (ip != free_ip) {
> +		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> +			rcu_read_unlock();
> +			delay(1);
> +			goto retry;
> +		}
> +
> +		/*
> +		 * Check the inode number again in case we're racing with
> +		 * freeing in xfs_reclaim_inode().  See the comments in that
> +		 * function for more information as to why the initial check is
> +		 * not sufficient.
> +		 */
> +		if (ip->i_ino != inum) {
> +			xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +			goto out_rcu_unlock;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	xfs_iflock(ip);
> +	xfs_iflags_set(ip, XFS_ISTALE);
> +
> +	/*
> +	 * We don't need to attach clean inodes or those only with unlogged
> +	 * changes (which we throw away, anyway).
> +	 */
> +	if (!ip->i_itemp || xfs_inode_clean(ip)) {
> +		ASSERT(ip != free_ip);
> +		xfs_ifunlock(ip);
> +		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +		goto out_no_inode;
> +	}
> +	return ip;
> +
> +out_rcu_unlock:
> +	rcu_read_unlock();
> +out_no_inode:
> +	return NULL;
> +}
> +
>  /*
>   * A big issue when freeing the inode cluster is that we _cannot_ skip any
>   * inodes that are in memory - they all must be marked stale and attached to
> @@ -2616,77 +2698,11 @@ xfs_ifree_cluster(
>  		 * even trying to lock them.
>  		 */
>  		for (i = 0; i < igeo->inodes_per_cluster; i++) {
> -retry:
> -			rcu_read_lock();
> -			ip = radix_tree_lookup(&pag->pag_ici_root,
> -					XFS_INO_TO_AGINO(mp, (inum + i)));
> -
> -			/* Inode not in memory, nothing to do */
> -			if (!ip) {
> -				rcu_read_unlock();
> +			ip = xfs_ifree_get_one_inode(pag, free_ip, inum + i);
> +			if (!ip)
>  				continue;
> -			}
> -
> -			/*
> -			 * because this is an RCU protected lookup, we could
> -			 * find a recently freed or even reallocated inode
> -			 * during the lookup. We need to check under the
> -			 * i_flags_lock for a valid inode here. Skip it if it
> -			 * is not valid, the wrong inode or stale.
> -			 */
> -			spin_lock(&ip->i_flags_lock);
> -			if (ip->i_ino != inum + i ||
> -			    __xfs_iflags_test(ip, XFS_ISTALE)) {
> -				spin_unlock(&ip->i_flags_lock);
> -				rcu_read_unlock();
> -				continue;
> -			}
> -			spin_unlock(&ip->i_flags_lock);
> -
> -			/*
> -			 * Don't try to lock/unlock the current inode, but we
> -			 * _cannot_ skip the other inodes that we did not find
> -			 * in the list attached to the buffer and are not
> -			 * already marked stale. If we can't lock it, back off
> -			 * and retry.
> -			 */
> -			if (ip != free_ip) {
> -				if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> -					rcu_read_unlock();
> -					delay(1);
> -					goto retry;
> -				}
> -
> -				/*
> -				 * Check the inode number again in case we're
> -				 * racing with freeing in xfs_reclaim_inode().
> -				 * See the comments in that function for more
> -				 * information as to why the initial check is
> -				 * not sufficient.
> -				 */
> -				if (ip->i_ino != inum + i) {
> -					xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -					rcu_read_unlock();
> -					continue;
> -				}
> -			}
> -			rcu_read_unlock();
>  
> -			xfs_iflock(ip);
> -			xfs_iflags_set(ip, XFS_ISTALE);
> -
> -			/*
> -			 * we don't need to attach clean inodes or those only
> -			 * with unlogged changes (which we throw away, anyway).
> -			 */
>  			iip = ip->i_itemp;
> -			if (!iip || xfs_inode_clean(ip)) {
> -				ASSERT(ip != free_ip);
> -				xfs_ifunlock(ip);
> -				xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -				continue;
> -			}
> -
>  			iip->ili_last_fields = iip->ili_fields;
>  			iip->ili_fields = 0;
>  			iip->ili_fsync_fields = 0;
> -- 
> 2.24.0.rc0
> 
