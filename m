Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1592264F57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIJTkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:40:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbgIJPjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:39:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFcXjE160622;
        Thu, 10 Sep 2020 15:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Ie+oiBdMx/pfhmauh7Z/OVd0UMkJ8RaAfSVCOnfOL4I=;
 b=jcfMm38Qq9Y2AjPMcHPROcr3ADK61lpCKN+xgIqcJsKj9Q1gKrgKJSTUTXJCqUBJZ5DE
 zc0x4mXRIs2y2OM2BawfYS6esR+BOkN6njGSKGz024sIzNrf3UEHkEYIP0Jyj3TnWCCI
 W5UImP7/7Z2i4eOLTFe94wPTCHaKrDcdhrNxr8RLt0BfjvmuQBZIixu6QAnhGaQncVc6
 Ps3NNZx7CzbE8rEOO18SCD8RfMmlmwPbJds6nMvIVo3Spa6/PXUA1waCnh4Ox9/XyQxn
 LgnyiReoaLHfAcyXq345mPwtk+FuQRVz0EnbVXfIADWJJGG55Yr+A5wK0vLlNcgmysjh fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mm8w97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 15:39:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFZAYY120142;
        Thu, 10 Sep 2020 15:37:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33cmka26kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:37:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08AFb26h027690;
        Thu, 10 Sep 2020 15:37:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 08:37:02 -0700
Date:   Thu, 10 Sep 2020 08:37:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH] iomap: Use round_down/round_up macros in
 __iomap_write_begin
Message-ID: <20200910153701.GC7964@magnolia>
References: <20200910124743.27603-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910124743.27603-1-nborisov@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:47:43PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..31eb680d8c64 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -571,8 +571,8 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  {
>  	struct iomap_page *iop = iomap_page_create(inode, page);
>  	loff_t block_size = i_blocksize(inode);
> -	loff_t block_start = pos & ~(block_size - 1);
> -	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> +	loff_t block_start = round_down(pos, block_size);
> +	loff_t block_end = round_up(pos + len, block_size);
>  	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
>  	int status;
>  
> -- 
> 2.17.1
> 
