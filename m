Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A22A1186
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 00:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ3XXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 19:23:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3XXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:23:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNK2fk097795;
        Fri, 30 Oct 2020 23:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BYYi4yWFIZMCh5y/gy4Ug7lW1zRBhShB0aEmGn1QAVA=;
 b=WL7LKva1UMxWXouc/acW2fziB2zCZ0F9YaZaCmEcHTV3uyxsm2/mWLk00Yi9tLwEDMTj
 C+evnyzwe+u2LCOPX6/9W50dl6WyQNTC9InnWwkGHKcUcfYJPtEF1XvWG5xqYUkyGvNn
 breJkR/Hgyj26W9lV/l/yHDabswPe4IxuZKsOYuCRkUwcH5YCAuMgAYMomB0WUPQxpOL
 lXzQSU0quRZgIRPXq9uDcJWcHG/T/6uaZ+7ik7ZycYNN0pEhWzA23Q6wEJW3wbjBdHRE
 pM4usEjMJ8VyXuzNoymrzayZm+FpqVqk08Ez04haa7urnx1n4xnQPwqeJcG2eiXBBWg0 vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7mbys8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 23:23:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNKcav055903;
        Fri, 30 Oct 2020 23:23:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34cwurg3h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 23:23:50 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UNNo78004266;
        Fri, 30 Oct 2020 23:23:50 GMT
Received: from [192.168.1.226] (/67.1.244.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 16:23:50 -0700
Subject: Re: [PATCH v2.1 2/3] iomap: support partial page discard on writeback
 block mapping failure
To:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
References: <20201029132325.1663790-3-bfoster@redhat.com>
 <20201029163313.1766967-1-bfoster@redhat.com>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <6abde9e8-c701-cf66-254c-b2711eab0346@oracle.com>
Date:   Fri, 30 Oct 2020 16:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029163313.1766967-1-bfoster@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300176
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/29/20 9:33 AM, Brian Foster wrote:
> iomap writeback mapping failure only calls into ->discard_page() if
> the current page has not been added to the ioend. Accordingly, the
> XFS callback assumes a full page discard and invalidation. This is
> problematic for sub-page block size filesystems where some portion
> of a page might have been mapped successfully before a failure to
> map a delalloc block occurs. ->discard_page() is not called in that
> error scenario and the bio is explicitly failed by iomap via the
> error return from ->prepare_ioend(). As a result, the filesystem
> leaks delalloc blocks and corrupts the filesystem block counters.
> 
> Since XFS is the only user of ->discard_page(), tweak the semantics
> to invoke the callback unconditionally on mapping errors and provide
> the file offset that failed to map. Update xfs_discard_page() to
> discard the corresponding portion of the file and pass the range
> along to iomap_invalidatepage(). The latter already properly handles
> both full and sub-page scenarios by not changing any iomap or page
> state on sub-page invalidations.
> 
Looks ok to me
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> v2.1:
> - Rebased to v5.10-rc1.
> 
>   fs/iomap/buffered-io.c | 15 ++++++++-------
>   fs/xfs/xfs_aops.c      | 14 ++++++++------
>   include/linux/iomap.h  |  2 +-
>   3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8180061b9e16..e4ea1f9f94d0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1382,14 +1382,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>   	 * appropriately.
>   	 */
>   	if (unlikely(error)) {
> +		/*
> +		 * Let the filesystem know what portion of the current page
> +		 * failed to map. If the page wasn't been added to ioend, it
> +		 * won't be affected by I/O completion and we must unlock it
> +		 * now.
> +		 */
> +		if (wpc->ops->discard_page)
> +			wpc->ops->discard_page(page, file_offset);
>   		if (!count) {
> -			/*
> -			 * If the current page hasn't been added to ioend, it
> -			 * won't be affected by I/O completions and we must
> -			 * discard and unlock it right here.
> -			 */
> -			if (wpc->ops->discard_page)
> -				wpc->ops->discard_page(page);
>   			ClearPageUptodate(page);
>   			unlock_page(page);
>   			goto done;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 55d126d4e096..5bf37afae5e9 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -527,13 +527,15 @@ xfs_prepare_ioend(
>    */
>   static void
>   xfs_discard_page(
> -	struct page		*page)
> +	struct page		*page,
> +	loff_t			fileoff)
>   {
>   	struct inode		*inode = page->mapping->host;
>   	struct xfs_inode	*ip = XFS_I(inode);
>   	struct xfs_mount	*mp = ip->i_mount;
> -	loff_t			offset = page_offset(page);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> +	unsigned int		pageoff = offset_in_page(fileoff);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
> +	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
>   	int			error;
>   
>   	if (XFS_FORCED_SHUTDOWN(mp))
> @@ -541,14 +543,14 @@ xfs_discard_page(
>   
>   	xfs_alert_ratelimited(mp,
>   		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> -			page, ip->i_ino, offset);
> +			page, ip->i_ino, fileoff);
>   
>   	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			i_blocks_per_page(inode, page));
> +			i_blocks_per_page(inode, page) - pageoff_fsb);
>   	if (error && !XFS_FORCED_SHUTDOWN(mp))
>   		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>   out_invalidate:
> -	iomap_invalidatepage(page, 0, PAGE_SIZE);
> +	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
>   }
>   
>   static const struct iomap_writeback_ops xfs_writeback_ops = {
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 172b3397a1a3..5bd3cac4df9c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -221,7 +221,7 @@ struct iomap_writeback_ops {
>   	 * Optional, allows the file system to discard state on a page where
>   	 * we failed to submit any I/O.
>   	 */
> -	void (*discard_page)(struct page *page);
> +	void (*discard_page)(struct page *page, loff_t fileoff);
>   };
>   
>   struct iomap_writepage_ctx {
> 
