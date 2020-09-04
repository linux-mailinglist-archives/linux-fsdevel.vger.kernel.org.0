Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBF25DD7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgIDP0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 11:26:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34062 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbgIDPY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FJsMC188608;
        Fri, 4 Sep 2020 15:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WfiizxCphgb6QMNLb5fT4M+/BAoLor82zRM000tnzY8=;
 b=OZVm2W8U/UA+Ndwco77I9LszK18bI2NyYtqN4HAAx1AE0V1EN1mbzulc8oa+9/yABdR9
 YncAiMkHYRntgKpZ1erX5uN+z/xY76Ve5OIxZ5GAio/biL5wI4l6V4OtZ5cKXX3TNxB/
 J1wWY15uhggrVkT4pxhkPCKOOt3BeSsHo7wAt5zSFbpPtbmW8/85rxWUS1qz6DEmpgT5
 8sjfkmhizAYnW1gI+O3mKvYMqe0s7V8W6lpsLPzovo4iSI1zW2wRY2A33uG54zeaaQGl
 ZiHZ39RDgR+lq7hRDXKTidizr1t7OxcwTlDI+fK3x6k0b/x2w2wPMp061ZoCwL+N+MN0 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmndgav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 15:24:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FLLFV040943;
        Fri, 4 Sep 2020 15:22:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380ktmmeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 15:22:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084FMmoB004140;
        Fri, 4 Sep 2020 15:22:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 08:22:48 -0700
Date:   Fri, 4 Sep 2020 08:22:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH] ext4: Implement swap_activate aops using iomap
Message-ID: <20200904152247.GA6088@magnolia>
References: <20200904091653.1014334-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904091653.1014334-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:46:53PM +0530, Ritesh Harjani wrote:
> After moving ext4's bmap to iomap interface, swapon functionality
> on files created using fallocate (which creates unwritten extents) are
> failing. This is since iomap_bmap interface returns 0 for unwritten
> extents and thus generic_swapfile_activate considers this as holes
> and hence bail out with below kernel msg :-
> 
> [340.915835] swapon: swapfile has holes
> 
> To fix this we need to implement ->swap_activate aops in ext4
> which will use ext4_iomap_report_ops. Since we only need to return
> the list of extents so ext4_iomap_report_ops should be enough.
> 
> Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
> Fixes: ac58e4fb03f ("ext4: move ext4 bmap to use iomap infrastructure")
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> [Tested xfstests with -g swap; Tested stress-ng with --thrash option]

Seems reasonable to me (at least from the iomap and "did you run QA?"
end...)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
>  fs/ext4/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1556cabd3a7d..9ac0f83e6fbe 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3605,6 +3605,13 @@ static int ext4_set_page_dirty(struct page *page)
>  	return __set_page_dirty_buffers(page);
>  }
>  
> +static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
> +				    struct file *file, sector_t *span)
> +{
> +	return iomap_swapfile_activate(sis, file, span,
> +				       &ext4_iomap_report_ops);
> +}
> +
>  static const struct address_space_operations ext4_aops = {
>  	.readpage		= ext4_readpage,
>  	.readpages		= ext4_readpages,
> @@ -3620,6 +3627,7 @@ static const struct address_space_operations ext4_aops = {
>  	.migratepage		= buffer_migrate_page,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate		= ext4_iomap_swap_activate,
>  };
>  
>  static const struct address_space_operations ext4_journalled_aops = {
> @@ -3636,6 +3644,7 @@ static const struct address_space_operations ext4_journalled_aops = {
>  	.direct_IO		= noop_direct_IO,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate		= ext4_iomap_swap_activate,
>  };
>  
>  static const struct address_space_operations ext4_da_aops = {
> @@ -3653,6 +3662,7 @@ static const struct address_space_operations ext4_da_aops = {
>  	.migratepage		= buffer_migrate_page,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate		= ext4_iomap_swap_activate,
>  };
>  
>  static const struct address_space_operations ext4_dax_aops = {
> @@ -3661,6 +3671,7 @@ static const struct address_space_operations ext4_dax_aops = {
>  	.set_page_dirty		= noop_set_page_dirty,
>  	.bmap			= ext4_bmap,
>  	.invalidatepage		= noop_invalidatepage,
> +	.swap_activate		= ext4_iomap_swap_activate,
>  };
>  
>  void ext4_set_aops(struct inode *inode)
> -- 
> 2.25.1
> 
