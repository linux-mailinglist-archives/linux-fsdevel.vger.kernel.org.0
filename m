Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5983328E49B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgJNQjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:39:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgJNQjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:39:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGTrZf134375;
        Wed, 14 Oct 2020 16:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=F4ZHy4aIkQEGNRieBuhfYbck9acmzjU5jbeOyjxyfZw=;
 b=lAUdkzmqshPurUFMdyHh5A60OVYfn8lz/BaWUs1NoUgpDDu/Sz7CrEQRX/eTymg14+Kj
 3rrdaeoZ+sJQU3HxicYLrhr1COENdWM/CkVo1U82EmGkFhIz6MI8aNyRlGZhpBWdgSai
 0cixfEjVuE8BSgNhlP2UKotZozX57jg9HJF119n0HR+/F0wd2gSUbWhLe8bCkp2q1nZj
 UIDY2uz9rLjFd8GI/F/XFzUjKvh2VdfBhbxyK5yJ5QMBZl6ze1n6aXZiQg2MFRkYuMde
 a601AhnF98038M1HsdUTp8DPpD9lPIvX1HbxpGKlnmzyO/H56Z1ZK9TbSONfnV2XNNd1 tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 343vaeewet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 16:39:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGZYc8035504;
        Wed, 14 Oct 2020 16:39:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by3wfes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 16:39:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EGdb5S029949;
        Wed, 14 Oct 2020 16:39:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 09:39:37 -0700
Date:   Wed, 14 Oct 2020 09:39:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/14] iomap: Support THPs in readpage
Message-ID: <20201014163936.GJ9832@magnolia>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-8-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:50AM +0100, Matthew Wilcox (Oracle) wrote:
> The VFS only calls readpage if readahead has encountered an error.
> Assume that any error requires the page to be split, and attempt to
> do so.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4ea6c601a183..ca305fbaf811 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -343,15 +343,50 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	return pos - orig_pos + plen;
>  }
>  
> +/*
> + * The page that was passed in has become Uptodate.  This may be due to
> + * the storage being synchronous or due to a page split finding the page
> + * is actually uptodate.  The page is still locked.
> + * Lift this into the VFS at some point.
> + */
> +#define AOP_UPDATED_PAGE       (AOP_TRUNCATED_PAGE + 1)

Er... why not lift it now?

"Because touching fs.h causes the whole kernel to be rebuilt and that's
annoying"? :D

--D

> +static int iomap_split_page(struct inode *inode, struct page *page)
> +{
> +	struct page *head = thp_head(page);
> +	bool uptodate = iomap_range_uptodate(inode, head,
> +				(page - head) * PAGE_SIZE, PAGE_SIZE);
> +
> +	iomap_page_release(head);
> +	if (split_huge_page(page) < 0) {
> +		unlock_page(page);
> +		return AOP_TRUNCATED_PAGE;
> +	}
> +	if (!uptodate)
> +		return 0;
> +	SetPageUptodate(page);
> +	return AOP_UPDATED_PAGE;
> +}
> +
>  int
>  iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  {
>  	struct iomap_readpage_ctx ctx = { .cur_page = page };
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = thp_head(page)->mapping->host;
>  	unsigned poff;
>  	loff_t ret;
>  
> -	trace_iomap_readpage(page->mapping->host, 1);
> +	trace_iomap_readpage(inode, 1);
> +
> +	if (PageTransCompound(page)) {
> +		int status = iomap_split_page(inode, page);
> +		if (status == AOP_UPDATED_PAGE) {
> +			unlock_page(page);

/me wonders why not do the unlock in iomap_split_page?

--D

> +			return 0;
> +		}
> +		if (status)
> +			return status;
> +	}
>  
>  	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
>  		ret = iomap_apply(inode, page_offset(page) + poff,
> -- 
> 2.28.0
> 
