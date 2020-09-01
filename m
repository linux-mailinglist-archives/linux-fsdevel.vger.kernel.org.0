Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C259CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgIARVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 13:21:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgIAPMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:12:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081F9ll8133109;
        Tue, 1 Sep 2020 15:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=69XBy7Prznwop6rn97Xe1cVn6rbsvD5ZvUeBPMnuuvQ=;
 b=pFHku2uaE5OiCnbPBE6xpzZ33M2FVJwUkv41wIGr1eBRvVX/dLV2AiEu+2mcgdlcN9jz
 P19htcvLglSXz81j4njmBNFFVwP3EGTEEH8GdUB8imSUJFkq9e6dY8pmZU2IunLd2Ld7
 l7aQjD6MsPP91eC1sfisbSYM9jteII6gJ+rLjz38o3rvopgslch/ER9Jo/+uFfvzVFvA
 7zNvfHbMnqOiL5MYHzWymPOfjC//GlihH4O9PUsTsxAmk6cLaLswsnxEHCDPgsWqzN/0
 wfsXeYLH16jc1YrAgXIPK3Or+xRD637UIpcl8+PB5ngbaO5EsGu10pApM/STlAKIDCuw BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmmudhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 15:12:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081F9uEW117432;
        Tue, 1 Sep 2020 15:12:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3380xwkduh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 15:12:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081FCT5i023180;
        Tue, 1 Sep 2020 15:12:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 08:12:29 -0700
Date:   Tue, 1 Sep 2020 08:12:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iomap: fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200901151233.GC6096@magnolia>
References: <20200831182353.14593-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182353.14593-1-cai@lca.pw>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=56
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=56
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:23:53PM -0400, Qian Cai wrote:
> It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
> unprivileged users which would taint the kernel, or worse - panic if
> panic_on_warn or panic_on_taint is set. Hence, just convert it to
> pr_warn_ratelimited() to let users know their workloads are racing.
> Thank Dave Chinner for the initial analysis of the racing reproducers.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks ok to me too.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v4: use %pD4.
> v3: Keep the default case and update the message.
> v2: Record the path, pid and command as well.
> 
>  fs/iomap/direct-io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..9519113ebc35 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -388,6 +388,16 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
>  	case IOMAP_INLINE:
>  		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> +	case IOMAP_DELALLOC:
> +		/*
> +		 * DIO is not serialised against mmap() access at all, and so
> +		 * if the page_mkwrite occurs between the writeback and the
> +		 * iomap_apply() call in the DIO path, then it will see the
> +		 * DELALLOC block that the page-mkwrite allocated.
> +		 */
> +		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
> +				    dio->iocb->ki_filp, current->comm);
> +		return -EIO;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return -EIO;
> -- 
> 2.18.4
> 
