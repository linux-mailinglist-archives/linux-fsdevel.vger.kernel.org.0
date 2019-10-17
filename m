Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56601DB672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395477AbfJQSkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:40:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390183AbfJQSkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:40:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIeEhn173767;
        Thu, 17 Oct 2019 18:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=r+FKO+kmS3nnfDRXobbClVjTN6e+SJeyN+DxsyZ7aR0=;
 b=fXtMtlwKm/4z2698vAb0C8uiAC1DoWqGslvXFZSfYJ+KXCbN8L2rFd+0OVHNzBbrhKbu
 3cZJ4u5mfE876ykEVu50YAXlT80I2PQEZNJfJ8Grc0ulX2Nwtf2z2CE3Ic7Gi5Q4xoo4
 2FDhdeP4FWAHV9KMVYf1gvGvy16mwmQluUczxg1Qr2FoOVT1hm9It9AE/e3zKrYILiXe
 ozUYq5MjcdFnpbTBXvKyPN7SudTdYQrtVIv4yNVsN1NXZQ4uoHbtjYK8Xv2TJkMoQoFb
 Su+I8ifjXlhfLBzFtFs/4ckWlhPGJAhhyFjJ+MnFjOD2Zt9aOr9w7OfEzMKlhSY+sOAI TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vk6sr0ahe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:40:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIWqFL113129;
        Thu, 17 Oct 2019 18:40:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vpf14fk7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:40:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HIeW6v008388;
        Thu, 17 Oct 2019 18:40:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:40:31 +0000
Date:   Thu, 17 Oct 2019 11:40:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 05/14] xfs: refactor the ioend merging code
Message-ID: <20191017184030.GM13108@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017175624.30305-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170167
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:56:15PM +0200, Christoph Hellwig wrote:
> Introduce two nicely abstracted helper, which can be moved to the iomap
> code later.  Also use list_first_entry_or_null to simplify the code a
> bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 73 +++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 91899de2be09..c29ef69d1e51 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -116,6 +116,22 @@ xfs_destroy_ioend(
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
> +	while ((ioend = list_first_entry_or_null(&tmp, struct xfs_ioend,
> +			io_list))) {
> +		list_del_init(&ioend->io_list);
> +		xfs_destroy_ioend(ioend, error);
> +	}
> +}
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -230,7 +246,6 @@ STATIC void
>  xfs_end_ioend(
>  	struct xfs_ioend	*ioend)
>  {
> -	struct list_head	ioend_list;
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
>  	xfs_off_t		offset = ioend->io_offset;
>  	size_t			size = ioend->io_size;
> @@ -275,16 +290,7 @@ xfs_end_ioend(
>  done:
>  	if (ioend->io_append_trans)
>  		error = xfs_setfilesize_ioend(ioend, error);
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
> @@ -333,17 +339,18 @@ xfs_ioend_try_merge(
>  	struct xfs_ioend	*ioend,
>  	struct list_head	*more_ioends)
>  {
> -	struct xfs_ioend	*next_ioend;
> +	struct xfs_ioend	*next;
> +
> +	INIT_LIST_HEAD(&ioend->io_list);
>  
> -	while (!list_empty(more_ioends)) {
> -		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
> -				io_list);
> -		if (!xfs_ioend_can_merge(ioend, next_ioend))
> +	while ((next = list_first_entry_or_null(more_ioends, struct xfs_ioend,
> +			io_list))) {
> +		if (!xfs_ioend_can_merge(ioend, next))
>  			break;
> -		list_move_tail(&next_ioend->io_list, &ioend->io_list);
> -		ioend->io_size += next_ioend->io_size;
> -		if (next_ioend->io_append_trans)
> -			xfs_ioend_merge_append_transactions(ioend, next_ioend);
> +		list_move_tail(&next->io_list, &ioend->io_list);
> +		ioend->io_size += next->io_size;
> +		if (next->io_append_trans)
> +			xfs_ioend_merge_append_transactions(ioend, next);
>  	}
>  }
>  
> @@ -366,29 +373,33 @@ xfs_ioend_compare(
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
> +	xfs_sort_ioends(&tmp);
> +	while ((ioend = list_first_entry_or_null(&tmp, struct xfs_ioend,
> +			io_list))) {
>  		list_del_init(&ioend->io_list);
> -		xfs_ioend_try_merge(ioend, &completion_list);
> +		xfs_ioend_try_merge(ioend, &tmp);
>  		xfs_end_ioend(ioend);
>  	}
>  }
> -- 
> 2.20.1
> 
