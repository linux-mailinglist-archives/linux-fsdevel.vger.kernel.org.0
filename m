Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81911C20F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgEAWyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:54:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgEAWyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:54:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041MniQw035632;
        Fri, 1 May 2020 22:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VsgINUB4dOK/ph54tHrMMLjIBVUKKHJuPipUU2BCAVU=;
 b=0AJ1ab2NqUtmXY8U8+ltf4fgkk1T6fwz996pBsvHw1kEsTAceflrcbdI/b3LjDqxded2
 QNQ/0rVdjQpXLr1FX9cn37v2G6HRwBpsKCka42zOAAFsU6hDGIfNaiNdOkCcUFeM78W8
 zCyN5zDiguvgJjRlIibtaOPkFuCUC73RO5Ok7B/sCE3D2LXVvVvndBweLr84H+nTBSK3
 99wjgfXDGlzxybq08q9lzPpn6p/hZgEtyXz5bi4bCw8Lelz7cZnrmHGgtvgOqNVM0FUC
 bxKblBTnG7ea3d86QmFArYFl+uOhY83CC3uUwFgFg/5sdqwjhOs+EDhHShH+zbpsSNcj xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30r7f3mafa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 22:54:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041MgWwW151710;
        Fri, 1 May 2020 22:54:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30r7f572dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 22:54:34 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041MsYti013771;
        Fri, 1 May 2020 22:54:34 GMT
Received: from [192.168.1.223] (/67.1.142.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 15:54:33 -0700
Subject: Re: [PATCH 02/18] xfs: fix xfs_reflink_remap_prep calling conventions
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <158812825316.168506.932540609191384366.stgit@magnolia>
 <158812826681.168506.8309047158870409011.stgit@magnolia>
From:   Allison Collins <allison.henderson@oracle.com>
Message-ID: <80ec9426-b634-7db1-070f-06fa1508ffcf@oracle.com>
Date:   Fri, 1 May 2020 15:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <158812826681.168506.8309047158870409011.stgit@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/28/20 7:44 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Fix the return value of xfs_reflink_remap_prep so that its calling
> conventions match the rest of xfs.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Looks fine to me:
Reviewed-by: Allison Collins <allison.henderson@oracle.com>

> ---
>   fs/xfs/xfs_file.c    |    2 +-
>   fs/xfs/xfs_reflink.c |    6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 994fd3d59872..1759fbcbcd46 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1029,7 +1029,7 @@ xfs_file_remap_range(
>   	/* Prepare and then clone file data. */
>   	ret = xfs_reflink_remap_prep(file_in, pos_in, file_out, pos_out,
>   			&len, remap_flags);
> -	if (ret < 0 || len == 0)
> +	if (ret || len == 0)
>   		return ret;
>   
>   	trace_xfs_reflink_remap_range(src, pos_in, len, dest, pos_out);
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index d8c8b299cb1f..5e978d1f169d 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1375,7 +1375,7 @@ xfs_reflink_remap_prep(
>   	struct inode		*inode_out = file_inode(file_out);
>   	struct xfs_inode	*dest = XFS_I(inode_out);
>   	bool			same_inode = (inode_in == inode_out);
> -	ssize_t			ret;
> +	int			ret;
>   
>   	/* Lock both files against IO */
>   	ret = xfs_iolock_two_inodes_and_break_layout(inode_in, inode_out);
> @@ -1399,7 +1399,7 @@ xfs_reflink_remap_prep(
>   
>   	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
>   			len, remap_flags);
> -	if (ret < 0 || *len == 0)
> +	if (ret || *len == 0)
>   		goto out_unlock;
>   
>   	/* Attach dquots to dest inode before changing block map */
> @@ -1434,7 +1434,7 @@ xfs_reflink_remap_prep(
>   	if (ret)
>   		goto out_unlock;
>   
> -	return 1;
> +	return 0;
>   out_unlock:
>   	xfs_reflink_remap_unlock(file_in, file_out);
>   	return ret;
> 
