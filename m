Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F37B406B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390405AbfIPSei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:34:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59780 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfIPSei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:34:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GITQ5f076686;
        Mon, 16 Sep 2019 18:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SRSA8s2DyDp6cmc0wvVnsItF/nm+k78LpvjLA15TBNc=;
 b=m2wQfLXkjfbbpH67pKWe1WDTSMqL8PggXgmuliObFWsHhmdQaQlahpvQjeWrmRfJ8+7h
 WR9mT5Zwu+GH/qnArVqDQmaXPSDejopCspK4r82b86mFZAGTWFZ1C5vomOBJrSKTeE5d
 ntegnuFBYFKrn3C6c1cXyMxbg2+rp+MsVGu06nf6jdpMYCVnk4bF10xYsrodkQ/Qwvhu
 OEGB1KpJd2VpOZLJB1ah3ZB+n/JOghNSHnqqGznZPQxP7PmBOaVhgrHFMlJHLGdoti9+
 LPGiDph22viHnbReid0txH2CUm9TSlFrcrAWYu9g9jcAKevVBt9rUrTIUeMC6JTosijz Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v0ruqhaxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:34:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GIWpRB140198;
        Mon, 16 Sep 2019 18:34:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v0nb55pct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:34:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GIYUPB007887;
        Mon, 16 Sep 2019 18:34:30 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:34:29 -0700
Date:   Mon, 16 Sep 2019 11:34:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/19] iomap: use write_begin to read pages to unshare
Message-ID: <20190916183428.GK2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160180
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:09PM +0200, Christoph Hellwig wrote:
> Use the existing iomap write_begin code to read the pages unshared
> by iomap_file_unshare.  That avoids the extra ->readpage call and
> extent tree lookup currently done by read_mapping_page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 49 ++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fe099faf540f..a421977a9496 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -533,6 +533,10 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  EXPORT_SYMBOL_GPL(iomap_migrate_page);
>  #endif /* CONFIG_MIGRATION */
>  
> +enum {
> +	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
> +};
> +
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -562,7 +566,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  }
>  
>  static int
> -__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
> +__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		struct page *page, struct iomap *iomap)
>  {
>  	struct iomap_page *iop = iomap_page_create(inode, page);
> @@ -581,11 +585,14 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  		if (plen == 0)
>  			break;
>  
> -		if ((from <= poff || from >= poff + plen) &&
> +		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&

Mmm, archeology of code that I wrote originally and have forgotten
already... :)

I think the purpose of F_UNSHARE is to mimic the behavior of the code
that's being removed, and the old behavior is that if a user asks to
unshare a page backed by shared extents we'll read in all the blocks
backing the page, even if that means reading in blocks that weren't part
of the original unshare request, right?

The only reason I can think of (or remember) for doing it that way is
that read_mapping_page does its IO one page at a time, i.e. sheer
laziness on my part.

So do we actually need F_UNSHARE to read in the whole page or can we get
by with reading only the blocks that are included in the range that's
being unshared, just like how write only reads in the blocks that are
included in the range being written to?

--D

> +		    (from <= poff || from >= poff + plen) &&
>  		    (to <= poff || to >= poff + plen))
>  			continue;
>  
>  		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
> +			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
> +				return -EIO;
>  			zero_user_segments(page, poff, from, to, poff + plen);
>  			iomap_set_range_uptodate(page, poff, plen);
>  			continue;
> @@ -631,7 +638,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
> -		status = __iomap_write_begin(inode, pos, len, page, iomap);
> +		status = __iomap_write_begin(inode, pos, len, flags, page,
> +				iomap);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> @@ -854,22 +862,6 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> -static struct page *
> -__iomap_read_page(struct inode *inode, loff_t offset)
> -{
> -	struct address_space *mapping = inode->i_mapping;
> -	struct page *page;
> -
> -	page = read_mapping_page(mapping, offset >> PAGE_SHIFT, NULL);
> -	if (IS_ERR(page))
> -		return page;
> -	if (!PageUptodate(page)) {
> -		put_page(page);
> -		return ERR_PTR(-EIO);
> -	}
> -	return page;
> -}
> -
>  static loff_t
>  iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
> @@ -885,24 +877,15 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		return length;
>  
>  	do {
> -		struct page *page, *rpage;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> -
> -		offset = offset_in_page(pos);
> -		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> -
> -		rpage = __iomap_read_page(inode, pos);
> -		if (IS_ERR(rpage))
> -			return PTR_ERR(rpage);
> +		unsigned long offset = offset_in_page(pos);
> +		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> +		struct page *page;
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
> -		put_page(rpage);
> +		status = iomap_write_begin(inode, pos, bytes,
> +				IOMAP_WRITE_F_UNSHARE, &page, iomap);
>  		if (unlikely(status))
>  			return status;
>  
> -		WARN_ON_ONCE(!PageUptodate(page));
> -
>  		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
>  		if (unlikely(status <= 0)) {
>  			if (WARN_ON_ONCE(status == 0))
> -- 
> 2.20.1
> 
