Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0F28E416
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgJNQM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:12:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgJNQM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:12:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EFsZ5R006286;
        Wed, 14 Oct 2020 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CI4qo3u2w7u/s4WuyHkpLIG4wXwALvpwlsaVB7wLhEo=;
 b=HN7LhxyE9/LcDa0AQ2h/jw62Ota3IM1ALC/CEQO8rRXh2y7SeAn3rGP1eGlae0eotjsF
 eFQfhaCxC7FppR4oEOy0qrDFgdJNr5KQVaUH3mgFCI7IazQ/m8BXO+rM0ynbObug7skK
 g7eEx2ayUX+K81Fu52EPP+MWX1eHFMSxtOP7K/dmApRclC1u8AkiOWZnfEnKZm6fg7Ni
 tqP+8NuJcHxQaHj2NNgEZnxiC4J38GWVrD6SvX2OnT1Ec1R7tHR1OPnuhJBZKI/Wuaiz
 c61dHsLcrE8t5YNTVzkspayZhVmLqnZN6RKL9I4dpP3fuun8nxYK2rltpHqu3CSCyIR+ 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3434wkreqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 16:12:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EFtafd095835;
        Wed, 14 Oct 2020 16:12:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by3vd58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 16:12:19 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EGCHCD014645;
        Wed, 14 Oct 2020 16:12:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 09:12:17 -0700
Date:   Wed, 14 Oct 2020 09:12:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/14] fs: Support THPs in vfs_dedupe_file_range
Message-ID: <20201014161216.GE9832@magnolia>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-2-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:44AM +0100, Matthew Wilcox (Oracle) wrote:
> We may get tail pages returned from vfs_dedupe_get_page().  If we do,
> we have to call page_mapping() instead of dereferencing page->mapping
> directly.  We may also deadlock trying to lock the page twice if they're
> subpages of the same THP, so compare the head pages instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/read_write.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 19f5c4bf75aa..ead675fef582 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1604,6 +1604,8 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
>   */
>  static void vfs_lock_two_pages(struct page *page1, struct page *page2)
>  {
> +	page1 = thp_head(page1);
> +	page2 = thp_head(page2);

Hmm, is this usage (calling thp_head() to extract the head page from an
arbitrary page reference) a common enough idiom that it doesn't need a
comment saying why we need the head page?

I'm asking that genuinely-- thp_head() is new to me but maybe it's super
obvious to everyone else?  Or at least the mm developers?  I suspect
that might be the case....?

Aside from that question, this looks fine to me.

Also, I was sort of thinking about sending a patch to Linus at the end
of the merge window moving all the remap/clone/dedupe common code to a
separate file to declutter fs/read_write.c and mm/filemap.c.  Does that
sound ok?

--D

>  	/* Always lock in order of increasing index. */
>  	if (page1->index > page2->index)
>  		swap(page1, page2);
> @@ -1616,6 +1618,8 @@ static void vfs_lock_two_pages(struct page *page1, struct page *page2)
>  /* Unlock two pages, being careful not to unlock the same page twice. */
>  static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>  {
> +	page1 = thp_head(page1);
> +	page2 = thp_head(page2);
>  	unlock_page(page1);
>  	if (page1 != page2)
>  		unlock_page(page2);
> @@ -1670,8 +1674,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
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
