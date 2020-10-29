Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4529F71A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 22:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ2VoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 17:44:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60182 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2VoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:44:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLTLE5143644;
        Thu, 29 Oct 2020 21:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Q1LyfFkwIhmV8JIQzjfHTcxIH2rHy2Ksbcg5CrUB/rY=;
 b=C6TDYGc/W5OLHbu2wLCGtagWsK59vDXg84ijQ9fpObkcOUxuod+NCNas/CmT4DZv6p3I
 H/rm4NAdcyhGZjQcqJuY7Mc3b6NISAOvqlofV59xxye+F8Cj0cO0ebaxigmIh0z+8KJs
 UFf+2RH03zOJrWQXAwDa8uVyZ+hNKXqQXvArcr9hkXMnXG3EL1O7YWNbog7ROY3fYmlH
 jBgxM4Uufk7wZVXCLCpn97ImFStQlX0ntNXm57COAOhpn0hNISo+N0A5eoSWp3gRfy5L
 tKcDPCDMJKfl18tmo9OhAPiniiQbXFmOgmHBFs0d0FtNe1JeT4tc2/6upUcWE5jW0rUD jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9sb7c8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:44:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLQB2e114408;
        Thu, 29 Oct 2020 21:44:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx6107tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:44:12 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TLiBHr025005;
        Thu, 29 Oct 2020 21:44:11 GMT
Received: from localhost (/10.159.244.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:44:11 -0700
Date:   Thu, 29 Oct 2020 14:44:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] xfs: flush new eof page on truncate to avoid
 post-eof corruption
Message-ID: <20201029214410.GI1061252@magnolia>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029132325.1663790-2-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:23:23AM -0400, Brian Foster wrote:
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

Seems reasonable,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iops.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 5e165456da68..1414ab79eacf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -911,6 +911,16 @@ xfs_setattr_size(
>  		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
>  				&did_zeroing, &xfs_buffered_write_iomap_ops);
>  	} else {
> +		/*
> +		 * iomap won't detect a dirty page over an unwritten block (or a
> +		 * cow block over a hole) and subsequently skips zeroing the
> +		 * newly post-EOF portion of the page. Flush the new EOF to
> +		 * convert the block before the pagecache truncate.
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
