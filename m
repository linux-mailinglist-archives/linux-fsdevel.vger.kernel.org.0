Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE4B68AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfIRRJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:09:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfIRRJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:09:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IGwunR052840;
        Wed, 18 Sep 2019 17:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=mIOVBfJOZdJiVOdT6RpchmdT5w2GyOm1tB4d7UiZUj0=;
 b=DMocbHY4wegIxuEQbZIqXyxUzc3HnyfJ3bgaPAHPy/a01myFs/mqEKPdTodpzXYX0nP0
 ceRneH1r8ofOj+2Yd7PXtwn+WvtSqRuxvMEbVx316816grgE/zlT7Wd+7jM1PBQf4JUD
 6oKrkpPVPezJXogY+ve27oSvs8tqqyqpQ7L6XMvFsvvwOt3wtrYo6CXEM9f5ZvFrbh5b
 E5JBOGuso3dbzUPCY7gGbHWkb+WvB6QGgm95h/7KBDNn2tYQYxucCpx8wCLLi7XArCZ0
 2FShyoIf7T8pHHW8c5kbzT90MJZyxgKksj/MDj6VANaDynWdDlD1YDWT5RnXHfUUQDQ8 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v385dwc2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:09:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IGw29m142209;
        Wed, 18 Sep 2019 17:09:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v37mausm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:09:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IH9DQr026097;
        Wed, 18 Sep 2019 17:09:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:09:13 -0700
Date:   Wed, 18 Sep 2019 10:09:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/19] xfs: also call xfs_file_iomap_end_delalloc for
 zeroing operations
Message-ID: <20190918170912.GZ2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-9-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:11PM +0200, Christoph Hellwig wrote:
> There is no reason not to punch out stale delalloc blocks for zeroing
> operations, as they otherwise behave exactly like normal writes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index f1c3ff27c666..db4764c16142 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1138,7 +1138,8 @@ xfs_file_iomap_end(
>  	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> -	if ((flags & IOMAP_WRITE) && iomap->type == IOMAP_DELALLOC)
> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
> +	    iomap->type == IOMAP_DELALLOC)
>  		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
>  				length, written, iomap);
>  	return 0;
> -- 
> 2.20.1
> 
