Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E54B649A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiBOHpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:45:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBOHpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:45:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D17107DBD
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:45:37 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyY1Q6TxJzZfdT;
        Tue, 15 Feb 2022 15:41:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 15:45:35 +0800
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page() into
 its one caller
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
CC:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <71259221-bc5a-24d0-d7b9-46781d71473a@huawei.com>
Date:   Tue, 15 Feb 2022 15:45:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-3-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/2/15 4:00, Matthew Wilcox (Oracle) wrote:
> invalidate_inode_page() is the only caller of invalidate_complete_page()
> and inlining it reveals that the first check is unnecessary (because we
> hold the page locked, and we just retrieved the mapping from the page).
> Actually, it does make a difference, in that tail pages no longer fail
> at this check, so it's now possible to remove a tail page from a mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/truncate.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 9dbf0b75da5d..e5e2edaa0b76 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -193,27 +193,6 @@ static void truncate_cleanup_folio(struct folio *folio)
>  	folio_clear_mappedtodisk(folio);
>  }
>  
> -/*
> - * This is for invalidate_mapping_pages().  That function can be called at
> - * any time, and is not supposed to throw away dirty pages.  But pages can
> - * be marked dirty at any time too, so use remove_mapping which safely
> - * discards clean, unused pages.
> - *
> - * Returns non-zero if the page was successfully invalidated.
> - */
> -static int
> -invalidate_complete_page(struct address_space *mapping, struct page *page)
> -{
> -
> -	if (page->mapping != mapping)
> -		return 0;
> -
> -	if (page_has_private(page) && !try_to_release_page(page, 0))
> -		return 0;
> -
> -	return remove_mapping(mapping, page);
> -}
> -
>  int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
>  {
>  	if (folio->mapping != mapping)
> @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
>  		return 0;
>  	if (page_mapped(page))
>  		return 0;
> -	return invalidate_complete_page(mapping, page);

It seems the checking of page->mapping != mapping is removed here.
IIUC, this would cause possibly unexpected side effect because
swapcache page can be invalidate now. I think this function is
not intended to deal with swapcache though it could do this.
Or am I miss anything?

Many thanks!

> +	if (page_has_private(page) && !try_to_release_page(page, 0))
> +		return 0;
> +
> +	return remove_mapping(mapping, page);
>  }
>  
>  /**
> @@ -584,7 +566,7 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
>  }
>  
>  /*
> - * This is like invalidate_complete_page(), except it ignores the page's
> + * This is like invalidate_inode_page(), except it ignores the page's
>   * refcount.  We do this because invalidate_inode_pages2() needs stronger
>   * invalidation guarantees, and cannot afford to leave pages behind because
>   * shrink_page_list() has a temp ref on them, or because they're transiently
> 

