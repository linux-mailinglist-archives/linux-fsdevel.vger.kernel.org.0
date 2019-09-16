Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B94B4026
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbfIPSRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:17:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbfIPSRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:17:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8plP074272;
        Mon, 16 Sep 2019 18:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=T1sbp3kmJ4LMtUeVkJ8R6zTWO9wMv08W0PNnMkTyCj0=;
 b=AL9l/bbzHm5+CnE3y7xmIsmqT3OmoSePg5NABzT89DWX2CrIdXGQMgFnJfH95rQjYnIl
 QISbvVsUep8z97QUjjRVlX2TKC4I1LyS7HhKjxfIuT1UFEn6S1yo9kV3i+X4KJBD3+JD
 c0LAdBTWDzBjGuNiWeXjoOTwPjLHLSJ/pcnHrmJs+YXy9uDpD8MWM2MIdj4ccv+LR2q6
 qN0flYnbi0G6AgW7TwyBKCbXEtb38gvsGafamCALS5FeUsheQdnKUxP3yAk9FXr0E1sm
 WjoV8Klwxq2f1Nq/CKL5l97UxdZ1Blf8htEIgRelzOYylntwGB3TLslfNCf/INQpCOvU Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v2bx2sfg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:17:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8gtS076158;
        Mon, 16 Sep 2019 18:17:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0nb550gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:17:27 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GIHRx6019192;
        Mon, 16 Sep 2019 18:17:27 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:17:26 -0700
Date:   Mon, 16 Sep 2019 11:17:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] iomap: move the zeroing case out of
 iomap_read_page_sync
Message-ID: <20190916181725.GJ2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-6-hch@lst.de>
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

On Mon, Sep 09, 2019 at 08:27:08PM +0200, Christoph Hellwig wrote:
> That keeps the function a little easier to understand, and easier to
> modify for pending enhancements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0b05551d9b5a..fe099faf540f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -547,19 +547,12 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  }
>  
>  static int
> -iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
> -		unsigned poff, unsigned plen, unsigned from, unsigned to,
> -		struct iomap *iomap)
> +iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
> +		unsigned plen, struct iomap *iomap)
>  {
>  	struct bio_vec bvec;
>  	struct bio bio;
>  
> -	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
> -		zero_user_segments(page, poff, from, to, poff + plen);
> -		iomap_set_range_uptodate(page, poff, plen);
> -		return 0;
> -	}
> -
>  	bio_init(&bio, &bvec, 1);
>  	bio.bi_opf = REQ_OP_READ;
>  	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
> @@ -577,7 +570,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
>  	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
> -	int status = 0;
> +	int status;
>  
>  	if (PageUptodate(page))
>  		return 0;
> @@ -588,17 +581,23 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  		if (plen == 0)
>  			break;
>  
> -		if ((from > poff && from < poff + plen) ||
> -		    (to > poff && to < poff + plen)) {
> -			status = iomap_read_page_sync(inode, block_start, page,
> -					poff, plen, from, to, iomap);
> -			if (status)
> -				break;
> +		if ((from <= poff || from >= poff + plen) &&
> +		    (to <= poff || to >= poff + plen))
> +			continue;
> +
> +		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
> +			zero_user_segments(page, poff, from, to, poff + plen);
> +			iomap_set_range_uptodate(page, poff, plen);
> +			continue;
>  		}
>  
> +		status = iomap_read_page_sync(block_start, page, poff, plen,
> +				iomap);
> +		if (status)
> +			return status;
>  	} while ((block_start += plen) < block_end);
>  
> -	return status;
> +	return 0;
>  }
>  
>  static int
> -- 
> 2.20.1
> 
