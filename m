Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695AC517DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfFXQBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:01:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFXQBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:01:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFxKPh013673;
        Mon, 24 Jun 2019 16:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=V3ndcbQ+TD0LKSqQzM3594IpMdqXKhrtNeECQwftLGg=;
 b=m/jK0RHjc6e19DnNRpaH326/Sd3WoZnVNM6LuWd5CqrxEpraHwHJiRjFqmbkocm6rdkd
 Wk63oRCGUr22uSLQWdeF6DPABbMed+nshfq5g6E2Awhx4Cbi44wavPeVJW5eYmlsfNoa
 T8cBvlmVWxqInzZxySncLgE97qr9M8KMPbVNrOFTacny8BXANNS+DQwO6UuYDOQJ7qOe
 0cgm5uKnFd1Z0p5hBNB0r/3vjxSGK4Wwq4kpNT/ZGSvFnCX1o47wUt4IOZcfLRxaoiUL
 BlDlFvf1pSIZVmJQXnMOlcTKV+y7hPWV9ZTL9TIjXHWdHqbrkSF2dTSQwZYwdWpz+XCK 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pf97e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:00:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFxocm018126;
        Mon, 24 Jun 2019 16:00:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f3btjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:00:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OG0wBD006770;
        Mon, 24 Jun 2019 16:00:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 09:00:57 -0700
Date:   Mon, 24 Jun 2019 09:00:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] xfs: simplify xfs_ioend_can_merge
Message-ID: <20190624160056.GN5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-9-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240127
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

On Mon, Jun 24, 2019 at 07:52:49AM +0200, Christoph Hellwig wrote:
> Compare the block layer status directly instead of converting it to
> an errno first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 017b87b7765f..acbd73976067 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -226,13 +226,9 @@ xfs_end_ioend(
>  static bool
>  xfs_ioend_can_merge(
>  	struct xfs_ioend	*ioend,
> -	int			ioend_error,
>  	struct xfs_ioend	*next)
>  {
> -	int			next_error;
> -
> -	next_error = blk_status_to_errno(next->io_bio->bi_status);
> -	if (ioend_error != next_error)
> +	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
>  		return false;
>  	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
>  		return false;
> @@ -251,17 +247,11 @@ xfs_ioend_try_merge(
>  	struct list_head	*more_ioends)
>  {
>  	struct xfs_ioend	*next_ioend;
> -	int			ioend_error;
> -
> -	if (list_empty(more_ioends))
> -		return;
> -
> -	ioend_error = blk_status_to_errno(ioend->io_bio->bi_status);
>  
>  	while (!list_empty(more_ioends)) {
>  		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
>  				io_list);
> -		if (!xfs_ioend_can_merge(ioend, ioend_error, next_ioend))
> +		if (!xfs_ioend_can_merge(ioend, next_ioend))
>  			break;
>  		list_move_tail(&next_ioend->io_list, &ioend->io_list);
>  		ioend->io_size += next_ioend->io_size;
> -- 
> 2.20.1
> 
