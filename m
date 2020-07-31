Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B71233FA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 09:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgGaHBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 03:01:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19692 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731384AbgGaHBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:01:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V6WCoY059876;
        Fri, 31 Jul 2020 03:01:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mc8wk8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 03:01:17 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V6oCOo103706;
        Fri, 31 Jul 2020 03:01:16 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mc8wk8mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 03:01:16 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V70YTs023783;
        Fri, 31 Jul 2020 07:01:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0v9c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 07:01:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V71BHi25362690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 07:01:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 614075205A;
        Fri, 31 Jul 2020 07:01:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B13252079;
        Fri, 31 Jul 2020 07:01:08 +0000 (GMT)
Subject: Re: [PATCH 3/3] iomap: fall back to buffered writes for invalidation
 failures
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200721183157.202276-1-hch@lst.de>
 <20200721183157.202276-4-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 31 Jul 2020 12:31:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200721183157.202276-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200731070109.1B13252079@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_01:2020-07-30,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=2 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/22/20 12:01 AM, Christoph Hellwig wrote:
> Failing to invalid the page cache means data in incoherent, which is
> a very bad state for the system.  Always fall back to buffered I/O
> through the page cache if we can't invalidate mappings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
  mainly for ext4 part.


> ---
>   fs/ext4/file.c       |  2 ++
>   fs/gfs2/file.c       |  3 ++-
>   fs/iomap/direct-io.c | 16 +++++++++++-----
>   fs/iomap/trace.h     |  1 +
>   fs/xfs/xfs_file.c    |  4 ++--
>   fs/zonefs/super.c    |  7 +++++--
>   6 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c4c..129cc1dd6b7952 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		iomap_ops = &ext4_iomap_overwrite_ops;
>   	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>   			   is_sync_kiocb(iocb) || unaligned_io || extend);
> +	if (ret == -ENOTBLK)
> +		ret = 0;
> 
>   	if (extend)
>   		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bebde537ac8cf2..b085a3bea4f0fd 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -835,7 +835,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
> 
>   	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
>   			   is_sync_kiocb(iocb));
> -
> +	if (ret == -ENOTBLK)
> +		ret = 0;
>   out:
>   	gfs2_glock_dq(&gh);
>   out_uninit:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 190967e87b69e4..c1aafb2ab99072 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -10,6 +10,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/uio.h>
>   #include <linux/task_io_accounting_ops.h>
> +#include "trace.h"
> 
>   #include "../internal.h"
> 
> @@ -401,6 +402,9 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>    * can be mapped into multiple disjoint IOs and only a subset of the IOs issued
>    * may be pure data writes. In that case, we still need to do a full data sync
>    * completion.
> + *
> + * Returns -ENOTBLK In case of a page invalidation invalidation failure for
> + * writes.  The callers needs to fall back to buffered I/O in this case.
>    */
>   ssize_t
>   iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> @@ -478,13 +482,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	if (iov_iter_rw(iter) == WRITE) {
>   		/*
>   		 * Try to invalidate cache pages for the range we are writing.
> -		 * If this invalidation fails, tough, the write will still work,
> -		 * but racing two incompatible write paths is a pretty crazy
> -		 * thing to do, so we don't support it 100%.
> +		 * If this invalidation fails, let the caller fall back to
> +		 * buffered I/O.
>   		 */
>   		if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> -				end >> PAGE_SHIFT))
> -			dio_warn_stale_pagecache(iocb->ki_filp);
> +				end >> PAGE_SHIFT)) {
> +			trace_iomap_dio_invalidate_fail(inode, pos, count);
> +			ret = -ENOTBLK;
> +			goto out_free_dio;
> +		}
> 
>   		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
>   			ret = sb_init_dio_done_wq(inode->i_sb);

Just as a note. So if the driver returns -ENOTBLK (from ->iomap_end)then
iomap considers it as a magic value to fall back to buffered-io and it
changes ret=0 And now with this patch, iomap could also return
-ENOTBLK if it gets an error while doing above operation and so the
driver is free to consider this as a fallback mechanism to buffered-io.
