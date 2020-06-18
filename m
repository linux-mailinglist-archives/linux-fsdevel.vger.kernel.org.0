Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9121FDF22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgFRBjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:39:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbgFRBjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:39:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05I1b029041625;
        Thu, 18 Jun 2020 01:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZNRhFbsEVEkKKSlXU9prNIrsFxXt4SEIe0tUGgiS1NI=;
 b=jz6PSOTL1QPpPrk8IhQPhJUzeNzdiCKUBT+tuOyD+fPe9adpoY6mBBw9jU5kD2Ih6g3l
 ELqucGhqXwSGNLgxY9/3JIlmpCoFT1FOmhZyvsuPUFsvfSbyMtfoqz7BlDfk0+fS4dJv
 Lxj/IArOIzAumpYzywwXRD7g0hI4oRDbobEBu2xT1I1ENcYTvDiTwe1UkjikC6ZDpvBV
 dW7ZQR3RronbERZEr6k6wDjACqXfOfhtH2PcSZqlJjiYiUvl8Tlp99Hx4AqkqKH6bJ82
 UIgd3rT/Tddh/9OMxrYizD6Oespecnmane8JXwS8GkOyrvrwIIOb1BXSoiDRUXiLpdyf fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31qeckw0ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 01:39:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05I1bhjn064536;
        Thu, 18 Jun 2020 01:39:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31q65ympkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 01:39:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05I1d1UO011446;
        Thu, 18 Jun 2020 01:39:01 GMT
Received: from localhost (/10.159.233.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jun 2020 18:39:00 -0700
Date:   Wed, 17 Jun 2020 18:39:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200618013901.GR11245@magnolia>
References: <20200615160244.741244-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615160244.741244-1-agruenba@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:02:44PM +0200, Andreas Gruenbacher wrote:
> Make sure iomap_end is always called when iomap_begin succeeds: the
> filesystem may take locks in iomap_begin and release them in iomap_end,
> for example.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/apply.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 76925b40b5fd..c00a14d825db 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -46,10 +46,10 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
> -	if (WARN_ON(iomap.offset > pos))
> -		return -EIO;
> -	if (WARN_ON(iomap.length == 0))
> -		return -EIO;
> +	if (WARN_ON(iomap.offset > pos) || WARN_ON(iomap.length == 0)) {

<urk> Forgot to actually review the original patch. :P

Why combine these WARN_ON?  Before, you could distinguish between your
iomap_begin method returning zero length vs. bad offset.

--D

> +		written = -EIO;
> +		goto out;
> +	}
>  
>  	trace_iomap_apply_dstmap(inode, &iomap);
>  	if (srcmap.type != IOMAP_HOLE)
> @@ -80,6 +80,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	written = actor(inode, pos, length, data, &iomap,
>  			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
>  
> +out:
>  	/*
>  	 * Now the data has been copied, commit the range we've copied.  This
>  	 * should not fail unless the filesystem has had a fatal error.
> 
> base-commit: 97e0204907ac4c42c6e94ef466a047523f34b853
> -- 
> 2.26.2
> 
