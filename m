Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C639B2A118A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 00:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgJ3XYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 19:24:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgJ3XYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:24:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNJZxn180925;
        Fri, 30 Oct 2020 23:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ADVugUv0bTu4BMg6qD29TxXNTGOmcqzEqsMPhSTlEEI=;
 b=wUxANNHzh26uDxsSjMxD8uoiN3iDv6gKIidP21l7JeWnb3OWpUCh1gLMrLdDvkeVqV3J
 b2TGt4rXfP8Twi8wIK+XkuOjurXJdKEnNcJ9IGwcvqwi0uNIeB5cw6zbvR7WFC8guKPA
 PNQrzEKTdEiOyoXLSWUzh0XBU1pDDBH4opTgtUQ94Ovo4qXF53DYkBBeHhNs8BKUOJD0
 Xx86UsbSz8BrbbUCOqFFD2re3GnOr0PS47PxcbDT/osfsu2fcXTBsbtcfZB5pT2LWBde
 K4nY+0BBNLvm45hU9czh6iWyjaFcOwMs5AfW17XswLIHtKG99LM1AnJlX/AEJLfzaCRW 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm4hk5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 23:23:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNKkZv056022;
        Fri, 30 Oct 2020 23:23:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwurg3ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 23:23:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09UNNvVj016466;
        Fri, 30 Oct 2020 23:23:57 GMT
Received: from [192.168.1.226] (/67.1.244.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 16:23:57 -0700
Subject: Re: [PATCH v2 3/3] iomap: clean up writeback state logic on writepage
 error
To:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-4-bfoster@redhat.com>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <072e1601-ae80-024b-48d8-cde43ede8c05@oracle.com>
Date:   Fri, 30 Oct 2020 16:23:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029132325.1663790-4-bfoster@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300176
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/29/20 6:23 AM, Brian Foster wrote:
> The iomap writepage error handling logic is a mash of old and
> slightly broken XFS writepage logic. When keepwrite writeback state
> tracking was introduced in XFS in commit 0d085a529b42 ("xfs: ensure
> WB_SYNC_ALL writeback handles partial pages correctly"), XFS had an
> additional cluster writeback context that scanned ahead of
> ->writepage() to process dirty pages over the current ->writepage()
> extent mapping. This context expected a dirty page and required
> retention of the TOWRITE tag on partial page processing so the
> higher level writeback context would revisit the page (in contrast
> to ->writepage(), which passes a page with the dirty bit already
> cleared).
> 
> The cluster writeback mechanism was eventually removed and some of
> the error handling logic folded into the primary writeback path in
> commit 150d5be09ce4 ("xfs: remove xfs_cancel_ioend"). This patch
> accidentally conflated the two contexts by using the keepwrite logic
> in ->writepage() without accounting for the fact that the page is
> not dirty. Further, the keepwrite logic has no practical effect on
> the core ->writepage() caller (write_cache_pages()) because it never
> revisits a page in the current function invocation.
> 
> Technically, the page should be redirtied for the keepwrite logic to
> have any effect. Otherwise, write_cache_pages() may find the tagged
> page but will skip it since it is clean. Even if the page was
> redirtied, however, there is still no practical effect to keepwrite
> since write_cache_pages() does not wrap around within a single
> invocation of the function. Therefore, the dirty page would simply
> end up retagged on the next writeback sequence over the associated
> range.
> 
> All that being said, none of this really matters because redirtying
> a partially processed page introduces a potential infinite redirty
> -> writeback failure loop that deviates from the current design
> principle of clearing the dirty state on writepage failure to avoid
> building up too much dirty, unreclaimable memory on the system.
> Therefore, drop the spurious keepwrite usage and dirty state
> clearing logic from iomap_writepage_map(), treat the partially
> processed page the same as a fully processed page, and let the
> imminent ioend failure clean up the writeback state.
> 
Ok, thanks for all the explaining.  Makes sense :-)
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>   fs/iomap/buffered-io.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d1f04eabc7e4..e3a4568f6c2e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1404,6 +1404,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>   	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
>   	WARN_ON_ONCE(!PageLocked(page));
>   	WARN_ON_ONCE(PageWriteback(page));
> +	WARN_ON_ONCE(PageDirty(page));
>   
>   	/*
>   	 * We cannot cancel the ioend directly here on error.  We may have
> @@ -1425,21 +1426,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>   			unlock_page(page);
>   			goto done;
>   		}
> -
> -		/*
> -		 * If the page was not fully cleaned, we need to ensure that the
> -		 * higher layers come back to it correctly.  That means we need
> -		 * to keep the page dirty, and for WB_SYNC_ALL writeback we need
> -		 * to ensure the PAGECACHE_TAG_TOWRITE index mark is not removed
> -		 * so another attempt to write this page in this writeback sweep
> -		 * will be made.
> -		 */
> -		set_page_writeback_keepwrite(page);
> -	} else {
> -		clear_page_dirty_for_io(page);
> -		set_page_writeback(page);
>   	}
>   
> +	set_page_writeback(page);
>   	unlock_page(page);
>   
>   	/*
> 
