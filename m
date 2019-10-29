Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8FE8C84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfJ2QPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 12:15:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfJ2QPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:15:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TFxJ5U033344;
        Tue, 29 Oct 2019 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=A1kYMmkaG5FKs/QVIwTtK+7+pOSUYwVnoIw867e/re8=;
 b=apxkMzZocVJycoJd7xxDLAGwLZw+ta+Wpupyn3WkaRjN4vPMVB6rucRJdgubvrCtJNdY
 +sui1tn/SLpc8pHESfo/VRgM26ydbuY8dpGmbRvjYp8yWOPMqUgRtU+BbDiAaQvF9gKm
 WtFgVZ/YWSdiUmRR4mlRNn3bc8MBn8BibcFQmkFKEwxdVAbdVFek104Ks3jqHlku8DXz
 eGDt9ohQ5S5FAH6mh/fprjAmcparxUmGxzDHkNccIjIhU2HiiRJd3khUyMfVcmmhaHAl
 2ylyXlyitLvZtluyn5GniOhuiUZBNj1TFCzFeprj8vk+4v7JLZjrsWjpxoi+pzAtWDrb Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vvumff787-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 16:15:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TG351i064792;
        Tue, 29 Oct 2019 16:14:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxpgf7qc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 16:14:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TGEriI001291;
        Tue, 29 Oct 2019 16:14:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 09:14:53 -0700
Date:   Tue, 29 Oct 2019 09:14:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs/iomap: remove redundant check in iomap_dio_rw()
Message-ID: <20191029161452.GC15222@magnolia>
References: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290145
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:40:47PM +0800, Joseph Qi wrote:
> We've already check if it is READ iov_iter, no need check again.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Applied to the iomap tree, thanks.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2..9712648 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -430,7 +430,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  		if (pos >= dio->i_size)
>  			goto out_free_dio;
>  
> -		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
> +		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
>  		flags |= IOMAP_WRITE;
> -- 
> 1.8.3.1
> 
