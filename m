Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760D9D442D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJKP3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 11:29:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKP3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:29:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BFNgOr096818;
        Fri, 11 Oct 2019 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=MsuotdAFaOMeEC/raKqstKTSiuaWwp2FNL9cMOEAuqw=;
 b=XGriVgZ0BExukqYJly8UItVCMa+wg20eMK+vZiGg8uywNRogAjO3nvsg7GuB7sDvmAN9
 LFU2iZ9eTN3ZHyRbXcRCsgNCO6FQGJHvz2PFSgpx3ynv/HRCGAfFM3L/3NZde8yX0V0f
 Lt/qmoQlb7GGzEJNdTjmbNU8SPwK8fyo9xt8RmsOw+Mr3+2WiWpjW6qVNFmqsSjYue3O
 yxEao3Y5xnQeeXx3431JymaQwkojwGneg9kQaSwLsRcUT/XcDIA+ksARMxMA/9R346wD
 GK4lb051c9JhPDk4E5hIc0rnQIZjr3mtlKVKbKYW3ApLfdkKpMTyi3q+G8a7i1PElrjr pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkv2g1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 15:29:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BFNYZB125338;
        Fri, 11 Oct 2019 15:29:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vj9qv40x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 15:29:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BFT3AB030582;
        Fri, 11 Oct 2019 15:29:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 08:29:03 -0700
Date:   Fri, 11 Oct 2019 08:28:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 2/2] xfs: Use iomap_dio_rw_wait()
Message-ID: <20191011152859.GK13108@magnolia>
References: <20191011125520.11697-1-jack@suse.cz>
 <20191011141433.18354-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011141433.18354-2-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:14:32PM +0200, Jan Kara wrote:
> Use iomap_dio_rw() to wait for unaligned direct IO instead of opencoding
> the wait.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_file.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 0739ba72a82e..c0620135a279 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -547,16 +547,12 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
> -			   is_sync_kiocb(iocb));
> -
>  	/*
> -	 * If unaligned, this is the only IO in-flight. If it has not yet
> -	 * completed, wait on it before we release the iolock to prevent
> -	 * subsequent overlapping IO.
> +	 * If unaligned, this is the only IO in-flight. Wait on it before we
> +	 * release the iolock to prevent subsequent overlapping IO.
>  	 */
> -	if (ret == -EIOCBQUEUED && unaligned_io)
> -		inode_dio_wait(inode);
> +	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
> +			   is_sync_kiocb(iocb) || unaligned_io);
>  out:
>  	xfs_iunlock(ip, iolock);
>  
> -- 
> 2.16.4
> 
