Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146A286241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgJGPg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 11:36:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgJGPg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:36:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097FXS7M021665;
        Wed, 7 Oct 2020 15:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5f69miCPt+NV0LANFf/qO1h0nLQY1MwO9sbrOzCAKXg=;
 b=A3gBZ56H1novabUez4R1w5Sej3V87adyElfnlhPv4YAW+IMki1gknRxoArFhu/hvDAJ2
 n1iqburVQ+/f8wX66ajrL4xQ+XBLT2th0ZLHzcMkyNkctAiQYjLhg6NR+JtetIa4wi8y
 DG7mbgV27hqknqaHdLnJhXgbgHW2RFG7Rr+nNTHF+qyKSqrBifdQG93TtWcDWvmLwItt
 ZbkcHPG/TSkVlxOLuSP6QiKqBXKJ7Up45WwlayF9lRAhMconbPSSumdcdHLcelw/HHLM
 wMQIUfDyJRB0zB+In2+AQKQ0jx8FIwGI1oC9V8IFwuQV3M8t7EIYBExw42D2Ro6uECeP JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxn2f9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 15:36:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097FZIEx008693;
        Wed, 7 Oct 2020 15:36:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33yyjhc1at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 15:36:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097FaKhX018653;
        Wed, 7 Oct 2020 15:36:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 08:36:20 -0700
Date:   Wed, 7 Oct 2020 08:36:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
Message-ID: <20201007153619.GD49547@magnolia>
References: <20201006230930.3908-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006230930.3908-1-rcampbell@nvidia.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 04:09:30PM -0700, Ralph Campbell wrote:
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> I'm resending this as a separate patch since I think it is ready to
> merge. Originally, this was part of an RFC and is unchanged from v3:
> https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.com
> 
> It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
> depend on anything, just simple merge conflicts when applied to
> other trees.
> I'll let the various maintainers decide which tree and when to merge.
> It isn't urgent since it is a clean up patch.
> 
>  fs/dax.c            |  4 ++--
>  fs/ext4/inode.c     |  5 +----
>  fs/xfs/xfs_file.c   |  4 +---
>  include/linux/dax.h | 10 ++++++++++
>  4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..85c63f735909 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -358,7 +358,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> +		WARN_ON_ONCE(trunc && !dax_layout_is_idle_page(page));
>  		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>  		page->mapping = NULL;
>  		page->index = 0;
> @@ -372,7 +372,7 @@ static struct page *dax_busy_page(void *entry)
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		if (page_ref_count(page) > 1)
> +		if (!dax_layout_is_idle_page(page))
>  			return page;
>  	}
>  	return NULL;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 771ed8b1fadb..132620cbfa13 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3937,10 +3937,7 @@ int ext4_break_layouts(struct inode *inode)
>  		if (!page)
>  			return 0;
>  
> -		error = ___wait_var_event(&page->_refcount,
> -				atomic_read(&page->_refcount) == 1,
> -				TASK_INTERRUPTIBLE, 0, 0,
> -				ext4_wait_dax_page(ei));
> +		error = dax_wait_page(ei, page, ext4_wait_dax_page);
>  	} while (error == 0);
>  
>  	return error;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 3d1b95124744..a5304aaeaa3a 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -749,9 +749,7 @@ xfs_break_dax_layouts(
>  		return 0;
>  
>  	*retry = true;
> -	return ___wait_var_event(&page->_refcount,
> -			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
> -			0, 0, xfs_wait_dax_page(inode));
> +	return dax_wait_page(inode, page, xfs_wait_dax_page);

I don't mind this open-coded soup getting cleaned up into a macro,
though my general opinion is that if the mm/dax developers are ok with
this then:

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  }
>  
>  int
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..8909a91cd381 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -243,6 +243,16 @@ static inline bool dax_mapping(struct address_space *mapping)
>  	return mapping->host && IS_DAX(mapping->host);
>  }
>  
> +static inline bool dax_layout_is_idle_page(struct page *page)
> +{
> +	return page_ref_count(page) == 1;
> +}
> +
> +#define dax_wait_page(_inode, _page, _wait_cb)				\
> +	___wait_var_event(&(_page)->_refcount,				\
> +		dax_layout_is_idle_page(_page),				\
> +		TASK_INTERRUPTIBLE, 0, 0, _wait_cb(_inode))
> +
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>  void hmem_register_device(int target_nid, struct resource *r);
>  #else
> -- 
> 2.20.1
> 
