Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3EA2289FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgGUUfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 16:35:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGUUfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:35:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LKRJV3175529;
        Tue, 21 Jul 2020 20:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4v/XK3jArSM5GdNy79pVNgZbgmLE/7IavWQqjWY0cWQ=;
 b=XNtGkFfHbRAg0aQNbSnK32Fn0KuB/0dv6ruqO7V7a6+YkBbIPeFkDk9XY5KuizSpop6y
 bugK20WiDqhKJVxJLrKe1flEQWeXwa8Rv3r+tDaOspHwnn92RbvJf/khR51qbIctG6QW
 8txL8D3+TQD322WBEQ5zgOTPQ5bhRtYPhhTwkzXZZYUDDcw8GS5QfgFOFX9q2XujvRrt
 qc9LXsZKur24Dz1Dou8067hxdmbJV4/fP773tT5Y+omjcfKWW+5pDXdEInLwl4w3+78v
 SnlC2ba8GxuKa6pbVye5swu8zz14ccr+ln7EEYTSXm/Fbba7gRYXIT0vzCYF5T0cWfxv LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32d6ksktu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 20:35:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LKXIgM147407;
        Tue, 21 Jul 2020 20:35:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32e3vet5sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 20:35:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06LKZ8fM018008;
        Tue, 21 Jul 2020 20:35:08 GMT
Received: from localhost (/10.159.147.229)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 20:35:08 +0000
Date:   Tue, 21 Jul 2020 13:35:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: use ENOTBLK for direct I/O to buffered I/O
 fallback
Message-ID: <20200721203505.GE3151642@magnolia>
References: <20200721183157.202276-1-hch@lst.de>
 <20200721183157.202276-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721183157.202276-2-hch@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:31:55PM +0200, Christoph Hellwig wrote:
> This is what the classic fs/direct-io.c implementation and thuse other
> file systems use.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 00db81eac80d6c..a6ef90457abf97 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -505,7 +505,7 @@ xfs_file_dio_aio_write(
>  		 */
>  		if (xfs_is_cow_inode(ip)) {
>  			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
> -			return -EREMCHG;
> +			return -ENOTBLK;
>  		}
>  		iolock = XFS_IOLOCK_EXCL;
>  	} else {
> @@ -714,7 +714,7 @@ xfs_file_write_iter(
>  		 * allow an operation to fall back to buffered mode.
>  		 */
>  		ret = xfs_file_dio_aio_write(iocb, from);
> -		if (ret != -EREMCHG)
> +		if (ret != -ENOTBLK)
>  			return ret;
>  	}
>  
> -- 
> 2.27.0
> 
