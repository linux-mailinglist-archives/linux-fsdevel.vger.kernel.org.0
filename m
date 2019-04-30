Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F0FC99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfD3PSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:18:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3PSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:18:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UF9Q7t096269;
        Tue, 30 Apr 2019 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jzZU5S7D0PFnQHhGt++IzIfE4eQUJO0gpL6CGYFTVfQ=;
 b=YFOApBlhGiuCaYb6++ewapKgPoSL4iOOzBV7zYcz5BObHaeOejH7TMl7fs98iak3891M
 1MZDYP7A459ryCVgS/wDbMEQpcAvzqXkEVRg80/UC8HyVGmGE4Ji+N0EYWthcQJaKy3y
 Sy8WK4W/Ca9RyCujC9h9qa8nORdZ5BdtxmlD4O8SgfniYw6t/xQQ5Xvi1mdXgUJpjtdf
 zKdyy+U7SL6WnX5v+cM/EzX9gX2eqsSmjKe5weFgoxuj7dfhsSV0Kakm3+lPsvosWYPY
 RCJW0d3yXi48yHus+BsasbYluenCGQf4hta1dnNGD9F+xlI1GOzSUm2PnqpiXEc09he4 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s5j5u1xa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:17:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UFGfFi064844;
        Tue, 30 Apr 2019 15:17:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s4d4ajyg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:17:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UFHCVQ021587;
        Tue, 30 Apr 2019 15:17:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 08:17:12 -0700
Date:   Tue, 30 Apr 2019 08:17:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/5] fs: Turn __generic_write_end into a void function
Message-ID: <20190430151710.GC5200@magnolia>
References: <20190429220934.10415-1-agruenba@redhat.com>
 <20190429220934.10415-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429220934.10415-3-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300094
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:31AM +0200, Andreas Gruenbacher wrote:
> The VFS-internal __generic_write_end helper always returns the value of
> its @copied argument.  This can be confusing, and it isn't very useful
> anyway, so turn __generic_write_end into a function returning void
> instead.

(Also weird that @copied is unsigned but the return value is signed...)

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/buffer.c   | 6 +++---
>  fs/internal.h | 2 +-
>  fs/iomap.c    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ce357602f471..e0d4c6a5e2d2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2085,7 +2085,7 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  }
>  EXPORT_SYMBOL(block_write_begin);
>  
> -int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
> +void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  		struct page *page)
>  {
>  	loff_t old_size = inode->i_size;
> @@ -2116,7 +2116,6 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  	 */
>  	if (i_size_changed)
>  		mark_inode_dirty(inode);
> -	return copied;
>  }
>  
>  int block_write_end(struct file *file, struct address_space *mapping,
> @@ -2160,7 +2159,8 @@ int generic_write_end(struct file *file, struct address_space *mapping,
>  			struct page *page, void *fsdata)
>  {
>  	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
> -	return __generic_write_end(mapping->host, pos, copied, page);
> +	__generic_write_end(mapping->host, pos, copied, page);
> +	return copied;
>  }
>  EXPORT_SYMBOL(generic_write_end);
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index 6a8b71643af4..530587fdf5d8 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -44,7 +44,7 @@ static inline int __sync_blockdev(struct block_device *bdev, int wait)
>  extern void guard_bio_eod(int rw, struct bio *bio);
>  extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>  		get_block_t *get_block, struct iomap *iomap);
> -int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
> +void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  		struct page *page);
>  
>  /*
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 2344c662e6fc..f8c9722d1a97 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -777,7 +777,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
>  	}
>  
> -	ret = __generic_write_end(inode, pos, ret, page);
> +	__generic_write_end(inode, pos, ret, page);
>  	if (iomap->page_done)
>  		iomap->page_done(inode, pos, copied, page, iomap);
>  
> -- 
> 2.20.1
> 
