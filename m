Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60428E4C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgJNQrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:47:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbgJNQrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:47:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGho1Z155477;
        Wed, 14 Oct 2020 16:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZaMFU1hUPbcaQ3+P0S5DuNiAoCTwtGbEn+HLNCGkkPE=;
 b=t7W8f+l4Sy0VaiWxIg6OhZ/Fgkbl6gp6bRkPdLHKdX4zC3OA5S8pd6Shavkqy7poTGJ8
 GQ/NyTx1RQ6aHZJC/1DGsTB5qsKsWEKkRM6k/CHKm59o+kyYT3XiH0aqBYEffrUfyCOd
 pVPN/9Nivp6suut1HoJ7dWrew5UQ14O7www3H+3AZZEhZEFx86oRnLa4rLexxK4hKBQi
 jDp2ctGNIjGIl+tceQT8EKRoYJNZuElxsTCxi98K4NTb2rTfJVSuosXF1xQQqQvjXI6E
 FzBm2XBQRJb8MSSZpcOlreQMikKhPOw2fbMPOjvEIL2n3n2e062dL2vjo40b5HyJsc0D lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 343vaeexja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 16:47:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGjang067519;
        Wed, 14 Oct 2020 16:47:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by3wsej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 16:47:46 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EGljJv002056;
        Wed, 14 Oct 2020 16:47:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 09:47:45 -0700
Date:   Wed, 14 Oct 2020 09:47:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/14] iomap: Change iomap_write_begin calling convention
Message-ID: <20201014164744.GK9832@magnolia>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-10-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140119
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:52AM +0100, Matthew Wilcox (Oracle) wrote:
> Pass (up to) the remaining length of the extent to iomap_write_begin()
> and have it return the number of bytes that will fit in the page.
> That lets us copy more bytes per call to iomap_write_begin() if the page
> cache has already allocated a THP (and will in future allow us to pass
> a hint to the page cache that it should try to allocate a larger page
> if there are none in the cache).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 61 +++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4ef02afaedc5..397795db3ce5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -616,14 +616,14 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  	return submit_bio_wait(&bio);
>  }
>  
> -static int
> -__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> -		struct page *page, struct iomap *srcmap)
> +static ssize_t __iomap_write_begin(struct inode *inode, loff_t pos,
> +		size_t len, int flags, struct page *page, struct iomap *srcmap)
>  {
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> -	unsigned from = offset_in_page(pos), to = from + len;
> +	size_t from = offset_in_thp(page, pos);
> +	size_t to = from + len;
>  	size_t poff, plen;
>  
>  	if (PageUptodate(page))
> @@ -658,12 +658,13 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	return 0;
>  }
>  
> -static int
> -iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> +static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
> +		unsigned flags, struct page **pagep, struct iomap *iomap,

loff_t len?  You've been using size_t (ssize_t?) for length elsewhere,
can't return more than ssize_t, and afaik MAX_RW_COUNT will never go
larger than 2GB so I'm confused about types here...?

Mostly because my brain has been trained to think that if it sees
"size_t len" as an input parameter and a ssize_t return value, then
probably the return value is however much of @len we managed to process.

> +		struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	struct page *page;
> +	size_t offset;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iomap->offset + iomap->length);
> @@ -674,6 +675,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		return -EINTR;
>  
>  	if (page_ops && page_ops->page_prepare) {
> +		if (len > UINT_MAX)
> +			len = UINT_MAX;

I'm not especially familiar with page_prepare (since it's a gfs2 thing);
why do you clamp len to UINT_MAX here?

--D

>  		status = page_ops->page_prepare(inode, pos, len, iomap);
>  		if (status)
>  			return status;
> @@ -685,6 +688,10 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		status = -ENOMEM;
>  		goto out_no_page;
>  	}
> +	page = thp_head(page);
> +	offset = offset_in_thp(page, pos);
> +	if (len > thp_size(page) - offset)
> +		len = thp_size(page) - offset;
>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, srcmap);
> @@ -694,11 +701,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		status = __iomap_write_begin(inode, pos, len, flags, page,
>  				srcmap);
>  
> -	if (unlikely(status))
> +	if (status < 0)
>  		goto out_unlock;
>  
>  	*pagep = page;
> -	return 0;
> +	return len;
>  
>  out_unlock:
>  	unlock_page(page);
> @@ -854,8 +861,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
>  				srcmap);
> -		if (unlikely(status))
> +		if (status < 0)
>  			break;
> +		/* We may be partway through a THP */
> +		offset = offset_in_thp(page, pos);
>  
>  		if (mapping_writably_mapped(inode->i_mapping))
>  			flush_dcache_page(page);
> @@ -915,7 +924,6 @@ static loff_t
>  iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap, struct iomap *srcmap)
>  {
> -	long status = 0;
>  	loff_t written = 0;
>  
>  	/* don't bother with blocks that are not shared to start with */
> @@ -926,25 +934,24 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		return length;
>  
>  	do {
> -		unsigned long offset = offset_in_page(pos);
> -		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  		struct page *page;
> +		ssize_t bytes;
>  
> -		status = iomap_write_begin(inode, pos, bytes,
> +		bytes = iomap_write_begin(inode, pos, length,
>  				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
> -		if (unlikely(status))
> -			return status;
> +		if (bytes < 0)
> +			return bytes;
>  
> -		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
> +		bytes = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
>  				srcmap);
> -		if (WARN_ON_ONCE(status == 0))
> +		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
>  		cond_resched();
>  
> -		pos += status;
> -		written += status;
> -		length -= status;
> +		pos += bytes;
> +		written += bytes;
> +		length -= bytes;
>  
>  		balance_dirty_pages_ratelimited(inode->i_mapping);
>  	} while (length);
> @@ -975,15 +982,13 @@ static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
>  		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page;
> -	int status;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> +	ssize_t bytes;
>  
> -	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
> -	if (status)
> -		return status;
> +	bytes = iomap_write_begin(inode, pos, length, 0, &page, iomap, srcmap);
> +	if (bytes < 0)
> +		return bytes;
>  
> -	zero_user(page, offset, bytes);
> +	zero_user(page, offset_in_thp(page, pos), bytes);
>  	mark_page_accessed(page);
>  
>  	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
> -- 
> 2.28.0
> 
