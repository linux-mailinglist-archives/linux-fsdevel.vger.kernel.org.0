Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5121F1D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgFHQQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:16:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:16:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058G8UH7065871;
        Mon, 8 Jun 2020 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HHRFXu/PCOEWFmyos370eOgdoHcGkVPFbRZIoCPNwdk=;
 b=WHltGvXUGsZwrSPxIRNR30psiX6+Y2ORx4d30cpqAwnTRvXqeBfV83PRvbJSkvV+gH+B
 YQUyTxtmUWLYHtJyJLApfXfh1C0qzpWhFEN3dNSA6EUNIRxJjXnH/A6Dnx/EGCOmbYTf
 T//YW9dqIlBXm2ZdDq3yTPGPoxpy33nSzt3cU1hoawWxNX2st8NcU2XuGoG4N+NA8TCE
 zzcdZecmUk0Az/o43z+CZs19kvYstpe4iYAHLnZ+zFBIDRcIMBS+R47wt035dBHDVoma
 V5Dtoi6jh9Dn/2oJ3oQyzuPXQTByAuxxem2u3iVRAykFxZvrWd4mBG9RgKJN2vasi5cK jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jqyseb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 16:16:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058GDqt8012177;
        Mon, 8 Jun 2020 16:16:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31gn2ved05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:16:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058GGPS5003304;
        Mon, 8 Jun 2020 16:16:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 09:16:24 -0700
Date:   Mon, 8 Jun 2020 09:16:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix unsharing of an extent >2GB on a 32-bit
 machine
Message-ID: <20200608161623.GV2162697@magnolia>
References: <20200607103536.26508-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607103536.26508-1-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 03:35:36AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Widen the type used for counting the number of bytes unshared.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Makes sense,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ae6c5e38f0e8..9f90d2394535 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -909,7 +909,7 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	long status = 0;
> -	ssize_t written = 0;
> +	loff_t written = 0;
>  
>  	/* don't bother with blocks that are not shared to start with */
>  	if (!(iomap->flags & IOMAP_F_SHARED))
> -- 
> 2.26.2
> 
