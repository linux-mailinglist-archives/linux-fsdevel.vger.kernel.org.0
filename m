Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896F9264F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIJTlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:41:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbgIJPgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:36:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFZQKr146910;
        Thu, 10 Sep 2020 15:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=degs3cd+U4EDFd6PEyVgvFmpZjcvtPaXyG2ihUwJ8Qc=;
 b=ZmlTDsV0U4yf2v6ssMG8fpkUqTf0wfnOIAk+h6xm02+vkQDioI+aFKuBldiAhO8Ba64V
 +OUTcm2kYl3F+pejvkpVYHTimSJVPnIiw8m3AzYW7dG4MdnLWoGvCZEYUrMfk0+Ra0S8
 3k1vFDnKTOuD2EROY2ji8yhzRse1eO6N6flRiCzVZoB9i4JOKa8LJUyd01uLkQz3AO2H
 mOyYG2nMNSLoFF9Qw6E3rlytaVcmFCYTRsr2KHRjbLhXf6+e+DsJLvLW86tSMUAyV0kg
 A9LK93WPoZg12iiZdPV7P9KKO8IMihI8MPrQPHRvmk8tPNZ6Dk7QdZBWJ5R8y60Nt3fD 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33c23r8yf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 15:36:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFZAsI120134;
        Thu, 10 Sep 2020 15:36:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmka24dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:36:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08AFaAq7022038;
        Thu, 10 Sep 2020 15:36:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 08:36:09 -0700
Date:   Thu, 10 Sep 2020 08:36:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: Don't opencode SECTOR_SIZE macro
Message-ID: <20200910153608.GB7964@magnolia>
References: <20200910152949.3227-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910152949.3227-1-nborisov@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=1 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:29:49PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 31eb680d8c64..4c688682236f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -29,7 +29,7 @@ struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> -	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	DECLARE_BITMAP(uptodate, PAGE_SIZE / SECTOR_SIZE);

FYI, Matthew Wilcox is (probably) going to replace this with a VLA in
5.10 as part of refactorings for THP support ("THP iomap patches for
5.10"), so I think I'll take that series instead.

--D

>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
> -- 
> 2.17.1
> 
