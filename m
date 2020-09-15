Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01B526B092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgIOWOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:14:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgIOQiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:38:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGTvAK188883;
        Tue, 15 Sep 2020 16:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vPDhIQb1XulBqQb/KNdgDnWaj7MfxWzfytsyaT9JniE=;
 b=IOS/JtgNNOUIfm7RZrN71Wyyz7626OY0S5zTELNuiY12YM8BGU+UBasue+vPWUscMRNl
 aVieb2XXH/cQlQdXqFlwTxXue+lm3ECYjPOTHOEudN4JxmBFBal+qOA13HF3bq23MHlC
 2+h+5ny5SxD1SptJJJJn22nlNuU9MQC4KMK8AxuIVTSoKQmGb03IpyRmWfo73eTAhUVr
 HvF9lXgiYFudGf6LGM3id8NTufU0wGOth/uocGf2FDp3Jr2Q3emG6wGSW1JVrd+zjWv5
 tNoTwVTojlWFmdOG23bkUVsETn5eVjLInLLMlCCJRDdzX18dARjI1uqo/ArZ/sBxjprD 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqx8wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 16:38:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGVQI7179094;
        Tue, 15 Sep 2020 16:38:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h885d1pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:38:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FGcPEp015277;
        Tue, 15 Sep 2020 16:38:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 16:38:25 +0000
Date:   Tue, 15 Sep 2020 09:38:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH] fs: Support THPs in vfs_dedupe_file_range
Message-ID: <20200915163824.GB7949@magnolia>
References: <20200915144616.27288-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915144616.27288-1-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:46:16PM +0100, Matthew Wilcox (Oracle) wrote:
> We may get tail pages returned from vfs_dedupe_get_page().  If we do,
> we have to call page_mapping() instead of dereferencing page->mapping
> directly.  We may also deadlock trying to lock the page twice if they're
> subpages of the same THP, so compare the head pages instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems fine to me...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/read_write.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5db58b8c78d0..c4d5eb47a21e 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1906,6 +1906,8 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
>   */
>  static void vfs_lock_two_pages(struct page *page1, struct page *page2)
>  {
> +	page1 = thp_head(page1);
> +	page2 = thp_head(page2);
>  	/* Always lock in order of increasing index. */
>  	if (page1->index > page2->index)
>  		swap(page1, page2);
> @@ -1918,6 +1920,8 @@ static void vfs_lock_two_pages(struct page *page1, struct page *page2)
>  /* Unlock two pages, being careful not to unlock the same page twice. */
>  static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>  {
> +	page1 = thp_head(page1);
> +	page2 = thp_head(page2);
>  	unlock_page(page1);
>  	if (page1 != page2)
>  		unlock_page(page2);
> @@ -1972,8 +1976,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		 * someone is invalidating pages on us and we lose.
>  		 */
>  		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
> -		    src_page->mapping != src->i_mapping ||
> -		    dest_page->mapping != dest->i_mapping) {
> +		    page_mapping(src_page) != src->i_mapping ||
> +		    page_mapping(dest_page) != dest->i_mapping) {
>  			same = false;
>  			goto unlock;
>  		}
> -- 
> 2.28.0
> 
