Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF929F728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 22:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJ2VsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 17:48:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgJ2VsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:48:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLTd2t063614;
        Thu, 29 Oct 2020 21:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OBwsoX7oz24R5Hfrexpp1Gg3snENyroyOANEslu+n4o=;
 b=O3NgScSQPe5l6huGIMwSxXUWx/dRuJEOpzK14uWn0iMzzBVdSfprhEil/OYg8TZHJrtl
 wDKOZrkSL4BXlcQQnYyfQMD6erpdPDMl4Dcrw1MskezeLxgUuWy1LxqT6VxKvjcqGewp
 nGRL3tCqPjTXr1VLpEtixPjCgmdSgNyaOwTUGTtHsUfntgGuInCuvItq+2ZMAuQbClFQ
 sPC8o5YXKMuIWYTmubkRU2nLPaQwUEk32TYvSLVr0dTLnz7A2vcc3MC4fD1CA3U6Ju0q
 GF+USDEo8u+I1g6sDwvUVUWfepzWWPDHCiPkJjr+UCRw9R6n2HA2yuGHJYfQ+RpBbuTC Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7m77bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:48:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLkAFF171641;
        Thu, 29 Oct 2020 21:48:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx610b8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:48:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TLmHof021164;
        Thu, 29 Oct 2020 21:48:17 GMT
Received: from localhost (/10.159.244.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:48:17 -0700
Date:   Thu, 29 Oct 2020 14:48:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iomap: clean up writeback state logic on
 writepage error
Message-ID: <20201029214816.GK1061252@magnolia>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-4-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029132325.1663790-4-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:23:25AM -0400, Brian Foster wrote:
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

...and run away before ext4 tries to port itself to buffered iomap,
since it's the only other user of keepwrite.  Not sure why it ends up in
a state where it's doing writeback to a hole(?!)

> Signed-off-by: Brian Foster <bfoster@redhat.com>

Anyway this seems sensible to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d1f04eabc7e4..e3a4568f6c2e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1404,6 +1404,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
>  	WARN_ON_ONCE(!PageLocked(page));
>  	WARN_ON_ONCE(PageWriteback(page));
> +	WARN_ON_ONCE(PageDirty(page));
>  
>  	/*
>  	 * We cannot cancel the ioend directly here on error.  We may have
> @@ -1425,21 +1426,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  			unlock_page(page);
>  			goto done;
>  		}
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
>  	}
>  
> +	set_page_writeback(page);
>  	unlock_page(page);
>  
>  	/*
> -- 
> 2.25.4
> 
