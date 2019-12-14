Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625AE11EF3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 01:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfLNAcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 19:32:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLNAcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:32:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE0T6sg037334;
        Sat, 14 Dec 2019 00:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BkHyBFNBU1ZIUocglfi4HVdr41N8r54kNNMXZYyL1nA=;
 b=LuxLQ13mmr/M++uyyj4a9bNlarWopcqQANOYebYVFn1dP0Uo0T7KNGqr9ffOz88CJmzN
 dlrOAn2iH0pzT2APYufgjDkHv3Fw93bzF/dFdnZ/bLoNg6mxEoKZOUChLOejJvS5T87c
 Z9sCDMSCh2wajpek28/gLsiOLsca4SpnmVWYlyafQUNWjIQwOwCA3cy1NifkwNNnfmcj
 I/hMUNqac4FtWiDdCbuuzbNaVzvceU4C3rYawd2hEhUBuV+6+ZOclQ1KSrMYJ6qZtLk9
 IQ17GceTfD4mKi5Hkk3zQZlH/eW2waPOhUAJKwq5IMY+XgHL3KDoYPfATOTrKsXXy6C7 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wr4qs3tea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:32:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE0SlGZ102910;
        Sat, 14 Dec 2019 00:32:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wvmvj0m1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:32:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBE0WYBL006420;
        Sat, 14 Dec 2019 00:32:34 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 16:32:33 -0800
Date:   Fri, 13 Dec 2019 16:32:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191214003232.GB99860@magnolia>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213195750.32184-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912140001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912140001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:57:45PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as btrfs can perform direct I/O without holding the
> inode->i_rwsem in some of the cases like writing within i_size.
> So, remove the check for lockdep_assert_held() in iomap_dio_rw()
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Mildly scary, but OTOH filesystems are supposed to take care of their
own locking before calling iomap...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1a3bf3bd86fb..41c1e7c20a1f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -415,8 +415,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> -	lockdep_assert_held(&inode->i_rwsem);
> -
>  	if (!count)
>  		return 0;
>  
> -- 
> 2.16.4
> 
