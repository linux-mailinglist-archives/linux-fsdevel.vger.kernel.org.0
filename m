Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD1FD010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKNVEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:04:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52214 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:04:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKxF1f037497;
        Thu, 14 Nov 2019 21:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=dnfYmXtuTFJ/DUGz8VaA60fPJFIOkGVYuPayfZf2++o=;
 b=bSs4UdzJaRXd5w6u7NH8KvOryp4qDuqBl2QKOnfFkm8e+GUSzUxMrW5W5ne7/6ajmZcy
 JuPT4eXbme/Hdi0n6qZ3q/oBSozKpcPwSyrlzx5iEsnW3pIZxcmr5+sLSnU78MdEqARA
 BPvkxJxP90K0jm0IWz0kTqFeY1DkZaNz8u2LSQK0kIhMldgKNru7dKPeNSSGeV/bOquf
 jFiW5Cken3iYojwgMF6D8TM4z9dokFr2r8OSFdNywM8T6BZeK/VlG6Nm4YYcoF90vwWZ
 uiz+H4Grq4upRp3EXXcyPRb7+RX+6ege7kvb5zXRgjV4zvMLzd9Ihd6mjsQgU9IFR6jt lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w5mvu5tpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 21:02:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKsGXS001815;
        Thu, 14 Nov 2019 21:02:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2w8g1a1ve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 21:02:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEL2fo9007838;
        Thu, 14 Nov 2019 21:02:41 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 13:02:41 -0800
Date:   Thu, 14 Nov 2019 13:02:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V2 1/2] fs: Clean up mapping variable
Message-ID: <20191114210239.GH6211@magnolia>
References: <20191113004244.9981-1-ira.weiny@intel.com>
 <20191113004244.9981-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113004244.9981-2-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:42:43PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The mapping variable is not directly used in these functions.  Just
> remove the additional variable.
> 
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

Please upgrade this to:
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes from V1
> 	Update recipients list
> 
>  fs/f2fs/data.c      | 3 +--
>  fs/iomap/swapfile.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ba3bcf4c7889..3c7777bfae17 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3146,8 +3146,7 @@ int f2fs_migrate_page(struct address_space *mapping,
>  /* Copied from generic_swapfile_activate() to check any holes */
>  static int check_swap_activate(struct file *swap_file, unsigned int max)
>  {
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = swap_file->f_mapping->host;
>  	unsigned blocks_per_page;
>  	unsigned long page_no;
>  	unsigned blkbits;
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index a648dbf6991e..80571add0180 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -140,8 +140,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  		.sis = sis,
>  		.lowest_ppage = (sector_t)-1ULL,
>  	};
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = swap_file->f_mapping->host;
>  	loff_t pos = 0;
>  	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
>  	loff_t ret;
> -- 
> 2.21.0
> 
