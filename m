Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7718728E42E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbgJNQRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:17:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58446 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgJNQRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:17:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGEcrk161263;
        Wed, 14 Oct 2020 16:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=frf7SMFdgKB/ROnyHA2rdqoVAB974sL7dJhXz9sNEeU=;
 b=MOBNgr6j62RlRxnxDjNxxRq/AIp8zeuLzBPRbEoVD5U6yOBWkuRsfryuNhl12/fJp/JK
 iIpvQWao1AP7gKicHOfzW/gf0x8wxyKhlOE5w+jc+8uC/U3RXzP2DfnFPWzvT28sxkOj
 FZdL2H9CEjj4v4B50+kLZ22GtmRAu3jJcaHWXgTvXHoRVMd+9fENg8cn7B2gPhsYaOXA
 o0D7BNo0sa3YdAjvsajPQZhJ1NjR+6PfsFBPZaPt0BeC/3m0it1buOWHh1qIWnS4GXDG
 k6lzz1zW1yIjyUt+nbr+hiRyddlocCIzi6NnGo8fZZZyK8nYzUp0pVQ06NrLoNLd4snN 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 343pajy471-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 16:17:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGEa0p112028;
        Wed, 14 Oct 2020 16:17:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 343pvy28ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 16:17:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EGH5kD018785;
        Wed, 14 Oct 2020 16:17:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 09:17:05 -0700
Date:   Wed, 14 Oct 2020 09:17:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/14] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20201014161704.GF9832@magnolia>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-3-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=1 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=1
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140115
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:45AM +0100, Matthew Wilcox (Oracle) wrote:
> If the page is compound, check the last index in the page and return
> the appropriate size.  Change the return type to ssize_t in case we ever
> support pages larger than 2GB.

"But what about 16G pages?" :P

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7dc6bf713d27..5083a0efafa8 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -983,22 +983,22 @@ static inline unsigned long dir_pages(struct inode *inode)
>   * @page: the page to check
>   * @inode: the inode to check the page against
>   *
> - * Returns the number of bytes in the page up to EOF,
> + * Return: The number of bytes in the page up to EOF,
>   * or -EFAULT if the page was truncated.
>   */
> -static inline int page_mkwrite_check_truncate(struct page *page,
> +static inline ssize_t page_mkwrite_check_truncate(struct page *page,
>  					      struct inode *inode)
>  {
>  	loff_t size = i_size_read(inode);
>  	pgoff_t index = size >> PAGE_SHIFT;
> -	int offset = offset_in_page(size);
> +	unsigned long offset = offset_in_thp(page, size);
>  
>  	if (page->mapping != inode->i_mapping)
>  		return -EFAULT;
>  
>  	/* page is wholly inside EOF */
> -	if (page->index < index)
> -		return PAGE_SIZE;
> +	if (page->index + thp_nr_pages(page) - 1 < index)

Just curious, is this expression common enough to create a helper for
that too?

#define thp_last_index(page) ((page)->index + thp_nr_pages(page) - 1) ?

(Maybe make that a static inline, I used a macro for brevity)

Otherwise looks fine to me...

--D

> +		return thp_size(page);
>  	/* page is wholly past EOF */
>  	if (page->index > index || !offset)
>  		return -EFAULT;
> -- 
> 2.28.0
> 
