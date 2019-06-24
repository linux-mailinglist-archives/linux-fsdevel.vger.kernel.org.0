Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047A3517F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfFXQFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:05:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFXQFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:05:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFxD38102539;
        Mon, 24 Jun 2019 16:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=41sMWJSvnLAsRg6ez6H1oy7Azi3oAaiWmBUqC3HmD1c=;
 b=d+iVvU182KeWLCIxwR84lKkvldN63MA0JYNwLkIQE/W0BCoNXXyjUPYJs8AO6YIFr8P3
 Qd7A6a5DKf1YgoUcS1JPAmUmOpi3f84PZ1kkpXZ/aiG7pzfIYN1IKmXKwgl7mUhxO6BE
 FBDtaKy0Nmmk1++NcEzHFxPQSjwZiDqOrlrcIDosUksJQW7+DQvs0sTt1poruZhW/eew
 i2iafeOcbPFUuRCt3p1yEjGyQvgQ6fqDD0qBcokOTfD5XsDOeIg/ZpTF/eJXoJh/Bu/t
 WPVpTDZIAbPQIG7zJkb5J1f0C8pPlb7zcZP+N5lZvDH5GDIxdb5UudafqGeVtF5muQIx rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brsybsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:04:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OG4g5o029842;
        Mon, 24 Jun 2019 16:04:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6tnus3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:04:53 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OG4pHj017154;
        Mon, 24 Jun 2019 16:04:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 09:04:51 -0700
Date:   Mon, 24 Jun 2019 09:04:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] xfs: refactor the ioend merging code
Message-ID: <20190624160450.GO5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:50AM +0200, Christoph Hellwig wrote:
> Introduce two nicely abstracted helper, which can be moved to the
> iomap code later.  Also use list_pop and list_first_entry_or_null
> to simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 66 ++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index acbd73976067..5d302ebe2a33 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -121,6 +121,19 @@ xfs_destroy_ioend(
>  	}
>  }
>  
> +static void
> +xfs_destroy_ioends(
> +	struct xfs_ioend	*ioend,
> +	int			error)
> +{
> +	struct list_head	tmp;
> +
> +	list_replace_init(&ioend->io_list, &tmp);
> +	xfs_destroy_ioend(ioend, error);
> +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list)))
> +		xfs_destroy_ioend(ioend, error);
> +}
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -173,7 +186,6 @@ xfs_end_ioend(
>  	struct xfs_ioend	*ioend)
>  {
>  	unsigned int		nofs_flag = memalloc_nofs_save();
> -	struct list_head	ioend_list;
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
>  	xfs_off_t		offset = ioend->io_offset;
>  	size_t			size = ioend->io_size;
> @@ -207,16 +219,7 @@ xfs_end_ioend(
>  	if (!error && xfs_ioend_is_append(ioend))
>  		error = xfs_setfilesize(ip, offset, size);
>  done:
> -	list_replace_init(&ioend->io_list, &ioend_list);
> -	xfs_destroy_ioend(ioend, error);
> -
> -	while (!list_empty(&ioend_list)) {
> -		ioend = list_first_entry(&ioend_list, struct xfs_ioend,
> -				io_list);
> -		list_del_init(&ioend->io_list);
> -		xfs_destroy_ioend(ioend, error);
> -	}
> -
> +	xfs_destroy_ioends(ioend, error);
>  	memalloc_nofs_restore(nofs_flag);
>  }
>  
> @@ -246,15 +249,16 @@ xfs_ioend_try_merge(
>  	struct xfs_ioend	*ioend,
>  	struct list_head	*more_ioends)
>  {
> -	struct xfs_ioend	*next_ioend;
> +	struct xfs_ioend	*next;
>  
> -	while (!list_empty(more_ioends)) {
> -		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
> -				io_list);
> -		if (!xfs_ioend_can_merge(ioend, next_ioend))
> +	INIT_LIST_HEAD(&ioend->io_list);
> +
> +	while ((next = list_first_entry_or_null(more_ioends, struct xfs_ioend,
> +			io_list))) {
> +		if (!xfs_ioend_can_merge(ioend, next))
>  			break;
> -		list_move_tail(&next_ioend->io_list, &ioend->io_list);
> -		ioend->io_size += next_ioend->io_size;
> +		list_move_tail(&next->io_list, &ioend->io_list);
> +		ioend->io_size += next->io_size;
>  	}
>  }
>  
> @@ -277,29 +281,31 @@ xfs_ioend_compare(
>  	return 0;
>  }
>  
> +static void
> +xfs_sort_ioends(
> +	struct list_head	*ioend_list)
> +{
> +	list_sort(NULL, ioend_list, xfs_ioend_compare);
> +}
> +
>  /* Finish all pending io completions. */
>  void
>  xfs_end_io(
>  	struct work_struct	*work)
>  {
> -	struct xfs_inode	*ip;
> +	struct xfs_inode	*ip =
> +		container_of(work, struct xfs_inode, i_ioend_work);
>  	struct xfs_ioend	*ioend;
> -	struct list_head	completion_list;
> +	struct list_head	tmp;
>  	unsigned long		flags;
>  
> -	ip = container_of(work, struct xfs_inode, i_ioend_work);
> -
>  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> -	list_replace_init(&ip->i_ioend_list, &completion_list);
> +	list_replace_init(&ip->i_ioend_list, &tmp);
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  
> -	list_sort(NULL, &completion_list, xfs_ioend_compare);
> -
> -	while (!list_empty(&completion_list)) {
> -		ioend = list_first_entry(&completion_list, struct xfs_ioend,
> -				io_list);
> -		list_del_init(&ioend->io_list);
> -		xfs_ioend_try_merge(ioend, &completion_list);
> +	xfs_sort_ioends(&tmp);
> +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list))) {
> +		xfs_ioend_try_merge(ioend, &tmp);
>  		xfs_end_ioend(ioend);
>  	}
>  }
> -- 
> 2.20.1
> 
