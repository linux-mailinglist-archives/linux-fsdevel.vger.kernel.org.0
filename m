Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D1B4010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfIPSLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:11:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44074 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfIPSLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:11:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8jte074221;
        Mon, 16 Sep 2019 18:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=mEJsBL/hcx97KcAHQx3akrOLXIDtqMFoC+xiIeFysos=;
 b=IGcqE3LJvBgMhE8GXoP7+CffFlBnfHkwlYFSYCSj5X8eAnWYWCM9nnOfaKr7BXuhe1vp
 q8DmxJtt7+3ToTVoEnhMXDVH0kmi13cKjTC94w+2mWf/oWnAdcCRRwsvfkE7zFoNc7QN
 dWNVNp6cVQYQTAFDBgbO/kMh6FXxjslLk+XETT2VfYGbEAiZ2fdcAEFBhKl5QMZg23mG
 ANPloeIsJNZAEbLDv9VCveCB6G5ZEEKFp4NrXXpL8MIn7WhF6m/G/Z2H55UIAl3tNwWr
 +uWQYcTSzs2dNa9T+j+btHVcRpg7eu8nd+/WdazTwpP3qN6mg3OT9cgd9echVNj73v0C aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v2bx2sed5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:11:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8qUv024007;
        Mon, 16 Sep 2019 18:11:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2v0p8uyey6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:11:10 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GIBA9E015208;
        Mon, 16 Sep 2019 18:11:10 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:11:10 -0700
Date:   Mon, 16 Sep 2019 11:11:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/19] iomap: always use AOP_FLAG_NOFS in
 iomap_write_begin
Message-ID: <20190916181109.GH2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:06PM +0200, Christoph Hellwig wrote:
> All callers pass AOP_FLAG_NOFS, so lift that flag to iomap_write_begin
> to allow reusing the flags arguments for an internal flags namespace
> soon.  Also remove the local index variable that is only used once.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a9b41352495..33e03992d8a7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -606,7 +606,6 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> -	pgoff_t index = pos >> PAGE_SHIFT;
>  	struct page *page;
>  	int status = 0;
>  
> @@ -621,7 +620,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  			return status;
>  	}
>  
> -	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
> +	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> +			AOP_FLAG_NOFS);
>  	if (!page) {
>  		status = -ENOMEM;
>  		goto out_no_page;
> @@ -763,7 +763,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	struct iov_iter *i = data;
>  	long status = 0;
>  	ssize_t written = 0;
> -	unsigned int flags = AOP_FLAG_NOFS;
>  
>  	do {
>  		struct page *page;
> @@ -793,8 +792,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, flags, &page,
> -				iomap);
> +		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
>  		if (unlikely(status))
>  			break;
>  
> @@ -892,8 +890,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		if (IS_ERR(rpage))
>  			return PTR_ERR(rpage);
>  
> -		status = iomap_write_begin(inode, pos, bytes,
> -					   AOP_FLAG_NOFS, &page, iomap);
> +		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
>  		put_page(rpage);
>  		if (unlikely(status))
>  			return status;
> @@ -944,8 +941,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
>  	struct page *page;
>  	int status;
>  
> -	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
> -				   iomap);
> +	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
>  	if (status)
>  		return status;
>  
> -- 
> 2.20.1
> 
