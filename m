Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F575724C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfFZUJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 16:09:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFZUJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:09:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QK9CXN098279;
        Wed, 26 Jun 2019 20:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OzU8niIx+4SJuJDg2iu/g3uoXdDBgToEow6b4jLA5Fw=;
 b=5lWMghZwhbue5Pj6GNlCOLxorKlxkgOqZ55Ny9Z7hosl9yAF3y5UYAr7jui+ZxTPcff/
 dnWi8/+5UZdqaXHXQydO4BlDbFYS1k3fwZDbvytgq3jDvh9aAzIqwZeJjG9K31XGrAuQ
 WLCG2DCeO7WwrR+Iv+C1d/acQ6x5l/nFSedrDtQxpKjrZOCwxgwrbV68QJIUuiWzorRo
 4UKKlttGLXyKaaWLdBO0jyvmopHZ/NCk+8H55r2E/n1YheINwq0+LO5jy9fzjj+zlKDV
 Zu994WHEG8YXK+AynR3Fgwc/wE9Ed9/uCkZE8ax5htw57rTx17et3SkKPGSkWVqfE5aE vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pvefp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 20:09:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QK85F3127937;
        Wed, 26 Jun 2019 20:09:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f4ndv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 20:09:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QK9Kbo018899;
        Wed, 26 Jun 2019 20:09:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 13:09:20 -0700
Date:   Wed, 26 Jun 2019 13:09:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iomap: don't mark the inode dirty in
 iomap_write_end
Message-ID: <20190626200919.GI5171@magnolia>
References: <20190626132335.14809-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626132335.14809-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260233
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260233
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:23:33PM +0200, Andreas Gruenbacher wrote:
> Marking the inode dirty for each page copied into the page cache can be
> very inefficient for file systems that use the VFS dirty inode tracking,
> and is completely pointless for those that don't use the VFS dirty inode
> tracking.  So instead, only set an iomap flag when changing the in-core
> inode size, and open code the rest of __generic_write_end.
> 
> Partially based on code from Christoph Hellwig.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/gfs2/bmap.c        |  2 ++
>  fs/iomap.c            | 15 ++++++++++++++-
>  include/linux/iomap.h |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 93ea1d529aa3..f4b895fc632d 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1182,6 +1182,8 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (ip->i_qadata && ip->i_qadata->qa_qd_num)
>  		gfs2_quota_unlock(ip);
> +	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
> +		mark_inode_dirty(inode);
>  	gfs2_write_unlock(inode);
>  
>  out:
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 12654c2e78f8..97569064faaa 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -777,6 +777,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		unsigned copied, struct page *page, struct iomap *iomap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> +	loff_t old_size = inode->i_size;
>  	int ret;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> @@ -788,7 +789,19 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
>  	}
>  
> -	__generic_write_end(inode, pos, ret, page);
> +	/*
> +	 * Update the in-memory inode size after copying the data into the page
> +	 * cache.  It's up to the file system to write the updated size to disk,
> +	 * preferably after I/O completion so that no stale data is exposed.
> +	 */
> +	if (pos + ret > old_size) {
> +		i_size_write(inode, pos + ret);
> +		iomap->flags |= IOMAP_F_SIZE_CHANGED;
> +	}
> +	unlock_page(page);
> +
> +	if (old_size < pos)
> +		pagecache_isize_extended(inode, old_size, pos);
>  	if (page_ops && page_ops->page_done)
>  		page_ops->page_done(inode, pos, copied, page, iomap);
>  	put_page(page);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2103b94cb1bf..1df9ea187a9a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -35,6 +35,7 @@ struct vm_fault;
>  #define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
>  #define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
>  #define IOMAP_F_BUFFER_HEAD	0x04	/* file system requires buffer heads */
> +#define IOMAP_F_SIZE_CHANGED	0x08	/* file size has changed */
>  
>  /*
>   * Flags that only need to be reported for IOMAP_REPORT requests:
> -- 
> 2.20.1
> 
