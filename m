Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF2286229
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgJGPeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 11:34:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJGPeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:34:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097FXd29021820;
        Wed, 7 Oct 2020 15:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IR1iHSLq8s/YXlPxkH6d1UGMtG9AcByaFCsHvId1+Ug=;
 b=YK56Xe7YNRI6bpWTcZzi7llTLJz2Zb9e2t7UoKtgAfEqNqTuI0c47YZmKrLTBJLjjlYw
 usu0UWSq/p4MUO08Lev9VzZHNqSPN00NLFK8qcx6JkZpGYw6FAH5cGkS25tv/BtngWkN
 k9rej83kgbyUwM5kiEP6qNAJN/B5GUAbvUDtJSqPYvB7WUjg6bKE4pRypGNSGUP9iKq+
 LX6AyYDrZAp6mOgr7546BhO9Fkx8ILpwLPJxCLsSqKpWUJAfZrdy4g7Tr8dNXqH5gdG9
 DVX3yC8fQ2e9nDyrH6zGRs7ojQCTwLbxOvsI0H0F6TJjJUCqG2lzaFq4qVY+YUos3JBf Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxn2eur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 15:34:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097FFCw6142944;
        Wed, 7 Oct 2020 15:34:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33yyjhbxnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 15:34:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097FXxuj011212;
        Wed, 7 Oct 2020 15:33:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 08:33:59 -0700
Date:   Wed, 7 Oct 2020 08:33:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfs: flush new eof page on truncate to avoid post-eof
 corruption
Message-ID: <20201007153359.GC49547@magnolia>
References: <20201007143509.669729-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007143509.669729-1-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:35:09AM -0400, Brian Foster wrote:
> It is possible to expose non-zeroed post-EOF data in XFS if the new
> EOF page is dirty, backed by an unwritten block and the truncate
> happens to race with writeback. iomap_truncate_page() will not zero
> the post-EOF portion of the page if the underlying block is
> unwritten. The subsequent call to truncate_setsize() will, but
> doesn't dirty the page. Therefore, if writeback happens to complete
> after iomap_truncate_page() (so it still sees the unwritten block)
> but before truncate_setsize(), the cached page becomes inconsistent
> with the on-disk block. A mapped read after the associated page is
> reclaimed or invalidated exposes non-zero post-EOF data.
> 
> For example, consider the following sequence when run on a kernel
> modified to explicitly flush the new EOF page within the race
> window:
> 
> $ xfs_io -fc "falloc 0 4k" -c fsync /mnt/file
> $ xfs_io -c "pwrite 0 4k" -c "truncate 1k" /mnt/file
>   ...
> $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> 00000400:  00 00 00 00 00 00 00 00  ........
> $ umount /mnt/; mount <dev> /mnt/
> $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> 00000400:  cd cd cd cd cd cd cd cd  ........
> 
> Update xfs_setattr_size() to explicitly flush the new EOF page prior
> to the page truncate to ensure iomap has the latest state of the
> underlying block.
> 
> Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> This patch is intentionally simplistic because I wanted to get some
> thoughts on a proper fix and at the same time consider something easily
> backportable. The iomap behavior seems rather odd to me in general,
> particularly if we consider the same kind of behavior can occur on
> file-extending writes. It's just not a user observable problem in that
> case because a sub-page write of a current EOF page (backed by an
> unwritten block) will zero fill the rest of the page at write time
> (before the zero range essentially skips it due to the unwritten block).
> It's not totally clear to me if that's an intentional design
> characteristic of iomap or something we should address.
> 
> It _seems_ like the more appropriate fix is that iomap truncate page
> should at least accommodate a dirty page over an unwritten block and
> modify the page (or perhaps just unconditionally do a buffered write on
> a non-aligned truncate, similar to what block_truncate_page() does). For
> example, we could push the UNWRITTEN check from iomap_zero_range_actor()
> down into iomap_zero(), actually check for an existing page there, and
> then either zero it or skip out if none exists. Thoughts?

I haven't looked at this in much depth yet, but I agree with the
principle that iomap ought to handle the case of unwritten extents
fronted by dirty pagecache.

--D

> Brian
> 
>  fs/xfs/xfs_iops.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 80a13c8561d8..3ef2e77b454e 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -911,6 +911,16 @@ xfs_setattr_size(
>  		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
>  				&did_zeroing, &xfs_buffered_write_iomap_ops);
>  	} else {
> +		/*
> +		 * iomap won't detect a dirty page over an unwritten block and
> +		 * subsequently skips zeroing the newly post-eof portion of the
> +		 * page. Flush the new EOF to convert the block before the
> +		 * pagecache truncate.
> +		 */
> +		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> +						     newsize);
> +		if (error)
> +			return error;
>  		error = iomap_truncate_page(inode, newsize, &did_zeroing,
>  				&xfs_buffered_write_iomap_ops);
>  	}
> -- 
> 2.25.4
> 
