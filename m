Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32D256B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEUR2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 13:28:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUR2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 13:28:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHJ0Zl033530;
        Tue, 21 May 2019 17:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OOcWSZoeDkFkWMlMGxcEwTFzHm7ucnXrKRYtjPeAjkU=;
 b=VY4JWLl3yuaRt4RzEooktXCp9in26MPPjPax+VOstWjbNrxH7oJRLf69Wq5MACINfmNq
 UClPg7Nmdc1pX232a/hkQvvSf2nP++yG9N+UgIDBvyKXMlaqHQgIilPHWe+DPEhvEcrE
 bARDZGd8UHtqbs3JzJMQfvl1pZSfEQ22OQrwNXaC6qOXyVIEwQ+HRjcZLSSH/09QFvTs
 Rae/kjjlcoHf1K8s8bFE2cb4KlOaEsSB67HKW0nB4T6/iWcx8+07nqtBG++eEpG62JWs
 RFF9XnzhRD8DykGEV0+i6GLesKdVFtkxrXnvtmfV8nvwRW70t09ZIieg7F1iYog2wkqG FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2sj7jdq6dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:27:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHQ2u2084102;
        Tue, 21 May 2019 17:27:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sm0473sc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:27:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LHRikR012396;
        Tue, 21 May 2019 17:27:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 17:27:44 +0000
Date:   Tue, 21 May 2019 10:27:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 14/18] dax: memcpy before zeroing range
Message-ID: <20190521172742.GD5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-15-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-15-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210107
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:45PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> However, this needed more iomap fields, so it was easier
> to pass iomap and compute inside the function rather
> than passing a log of arguments.
> 
> Note, there is subtle difference between iomap_sector and
> dax_iomap_sector(). Can we replace dax_iomap_sector with
> iomap_sector()? It would need pos & PAGE_MASK though or else
> bdev_dax_pgoff() return -EINVAL.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c              | 17 ++++++++++++-----
>  fs/iomap.c            |  9 +--------
>  include/linux/dax.h   | 11 +++++------
>  include/linux/iomap.h |  6 ++++++
>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index fa9ccbad7c03..82a08b0eec23 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1063,11 +1063,16 @@ static bool dax_range_is_aligned(struct block_device *bdev,
>  	return true;
>  }
>  
> -int __dax_zero_page_range(struct block_device *bdev,
> -		struct dax_device *dax_dev, sector_t sector,
> -		unsigned int offset, unsigned int size)
> +int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
> +			  unsigned int offset, unsigned int size)
>  {
> -	if (dax_range_is_aligned(bdev, offset, size)) {
> +	sector_t sector = dax_iomap_sector(iomap, pos & PAGE_MASK);
> +	struct block_device *bdev = iomap->bdev;
> +	struct dax_device *dax_dev = iomap->dax_dev;
> +	int ret = 0;
> +
> +	if (!(iomap->type == IOMAP_DAX_COW) &&
> +	    dax_range_is_aligned(bdev, offset, size)) {
>  		sector_t start_sector = sector + (offset >> 9);
>  
>  		return blkdev_issue_zeroout(bdev, start_sector,
> @@ -1087,11 +1092,13 @@ int __dax_zero_page_range(struct block_device *bdev,
>  			dax_read_unlock(id);
>  			return rc;
>  		}
> +		if (iomap->type == IOMAP_DAX_COW)
> +			ret = memcpy_mcsafe(kaddr, iomap->inline_data, offset);

If the memcpy fails, does it make sense to keep going?

>  		memset(kaddr + offset, 0, size);

Is it ever the case that offset + size isn't the end of the page?  If
so, then don't we need a second memcpy_mcsafe to handle that too?

>  		dax_flush(dax_dev, kaddr + offset, size);
>  		dax_read_unlock(id);
>  	}
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index abdd18e404f8..90698c854883 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -98,12 +98,6 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	return written ? written : ret;
>  }
>  
> -static sector_t
> -iomap_sector(struct iomap *iomap, loff_t pos)
> -{
> -	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
> -}
> -
>  static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
> @@ -990,8 +984,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
>  static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>  		struct iomap *iomap)
>  {
> -	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
> -			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
> +	return __dax_zero_page_range(iomap, pos, offset, bytes);
>  }
>  
>  static loff_t
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 1370d39c91b6..c469d9ff54b4 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -9,6 +9,7 @@
>  
>  typedef unsigned long dax_entry_t;
>  
> +struct iomap;
>  struct iomap_ops;
>  struct dax_device;
>  struct dax_operations {
> @@ -163,13 +164,11 @@ int dax_file_range_compare(struct inode *src, loff_t srcoff,
>  			   const struct iomap_ops *ops);
>  
>  #ifdef CONFIG_FS_DAX
> -int __dax_zero_page_range(struct block_device *bdev,
> -		struct dax_device *dax_dev, sector_t sector,
> -		unsigned int offset, unsigned int length);
> +int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
> +		unsigned int offset, unsigned int size);
>  #else
> -static inline int __dax_zero_page_range(struct block_device *bdev,
> -		struct dax_device *dax_dev, sector_t sector,
> -		unsigned int offset, unsigned int length)
> +static inline int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
> +		unsigned int offset, unsigned int size)
>  {
>  	return -ENXIO;
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6e885c5a38a3..fcfce269db3e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -7,6 +7,7 @@
>  #include <linux/mm.h>
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
> +#include <linux/blkdev.h>
>  
>  struct address_space;
>  struct fiemap_extent_info;
> @@ -120,6 +121,11 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
>  	return NULL;
>  }
>  
> +static inline sector_t iomap_sector(struct iomap *iomap, loff_t pos)
> +{
> +	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
> +}

FWIW the iomap changes seem fine to me.

--D

> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
>  int iomap_readpage(struct page *page, const struct iomap_ops *ops);
> -- 
> 2.16.4
> 
