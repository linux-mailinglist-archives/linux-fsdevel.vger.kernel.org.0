Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C261D252390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 00:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYWYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 18:24:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYWYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:24:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PM9F6M152383;
        Tue, 25 Aug 2020 22:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oeKJZmmYR5uMQ5BCN6pmoROIcHs/c+lN/lZTS/iI3aw=;
 b=xHgPNBM/tXzqFEXOXJ1PdoMNsD3RpLtGKA2eLTAcqps33vmj44wVAurox4de08xBUvUV
 RKs3G8sD0ijRTWdo8zYoJzh+kc6fvqF9OOdz49BtwOlDZi5D4gPlirkLlvIJ+y/UhFtr
 6fSUeGywJ2OE3v2BJYH1uUJ0S16f4cjcE+HGGU1CCc+2fGGecbU047LBgIvwhD9TGzy7
 zWOwSAnvE9+8ABCF12vrXlsFGJvPaXkMTtCpYzHhx5Y5k0OXK+vm07JNoEq8myeLfNe+
 /sXhhKD2uW3k7kCJwJ5Qju0f2h1AMmFemeBTmUW8ah+EI+EPf4h7WGdCnlRfUMUKtXVE 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6tusfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 22:23:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PMACVc058270;
        Tue, 25 Aug 2020 22:23:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 333ru8n88f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 22:23:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07PMNvr9015301;
        Tue, 25 Aug 2020 22:23:57 GMT
Received: from localhost (/10.159.234.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 15:23:56 -0700
Date:   Tue, 25 Aug 2020 15:23:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825222355.GL6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-10-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:10PM +0100, Matthew Wilcox (Oracle) wrote:
> Pass the full length to iomap_zero() and dax_iomap_zero(), and have
> them return how many bytes they actually handled.  This is preparatory
> work for handling THP, although it looks like DAX could actually take
> advantage of it if there's a larger contiguous area.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/dax.c               | 13 ++++++-------
>  fs/iomap/buffered-io.c | 33 +++++++++++++++------------------
>  include/linux/dax.h    |  3 +--
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 95341af1a966..f2b912cb034e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1037,18 +1037,18 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	return ret;
>  }
>  
> -int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> -		   struct iomap *iomap)
> +loff_t dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)

Sorry for my ultra-slow response to this.  The u64 length seems ok to me
(or uint64_t, I don't care all /that/ much), but using loff_t as a
return type bothers me because I see that and think that this function
is returning a new file offset, e.g. (pos + number of bytes zeroed).

So please, let's use s64 or something that isn't so misleading.

FWIW, Linus also[0] doesn't[1] like using loff_t for the number of bytes
copied.

--D

[0] https://lore.kernel.org/linux-fsdevel/CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com/
[1] https://lore.kernel.org/linux-fsdevel/CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com/

>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
>  	long rc, id;
>  	void *kaddr;
>  	bool page_aligned = false;
> -
> +	unsigned offset = offset_in_page(pos);
> +	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>  
>  	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
> -	    IS_ALIGNED(size, PAGE_SIZE))
> +	    (size == PAGE_SIZE))
>  		page_aligned = true;
>  
>  	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
> @@ -1058,8 +1058,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
>  	id = dax_read_lock();
>  
>  	if (page_aligned)
> -		rc = dax_zero_page_range(iomap->dax_dev, pgoff,
> -					 size >> PAGE_SHIFT);
> +		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>  	else
>  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
>  	if (rc < 0) {
> @@ -1072,7 +1071,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
>  	dax_read_unlock(id);
> -	return 0;
> +	return size;
>  }
>  
>  static loff_t
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7f618ab4b11e..2dba054095e8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -901,11 +901,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> -		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_zero(struct inode *inode, loff_t pos, u64 length,
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page;
>  	int status;
> +	unsigned offset = offset_in_page(pos);
> +	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
>  	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
>  	if (status)
> @@ -917,38 +919,33 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
>  	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
>  }
>  
> -static loff_t
> -iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
> +		loff_t length, void *data, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	bool *did_zero = data;
>  	loff_t written = 0;
> -	int status;
>  
>  	/* already zeroed?  we're done. */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> -		return count;
> +		return length;
>  
>  	do {
> -		unsigned offset, bytes;
> -
> -		offset = offset_in_page(pos);
> -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
> +		loff_t bytes;
>  
>  		if (IS_DAX(inode))
> -			status = dax_iomap_zero(pos, offset, bytes, iomap);
> +			bytes = dax_iomap_zero(pos, length, iomap);
>  		else
> -			status = iomap_zero(inode, pos, offset, bytes, iomap,
> -					srcmap);
> -		if (status < 0)
> -			return status;
> +			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
> +		if (bytes < 0)
> +			return bytes;
>  
>  		pos += bytes;
> -		count -= bytes;
> +		length -= bytes;
>  		written += bytes;
>  		if (did_zero)
>  			*did_zero = true;
> -	} while (count > 0);
> +	} while (length > 0);
>  
>  	return written;
>  }
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 6904d4e0b2e0..80f17946f940 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -214,8 +214,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> -int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> -			struct iomap *iomap);
> +loff_t dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> -- 
> 2.28.0
> 
