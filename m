Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630724B67BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiBOJhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:37:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiBOJhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:37:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81157C1CB5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:37:41 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JybWx1bbNz8wct;
        Tue, 15 Feb 2022 17:34:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:37:39 +0800
Subject: Re: [PATCH 07/10] mm/truncate: Convert __invalidate_mapping_pages()
 to use a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-8-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ab79c26b-6dcf-feca-ef54-20273407fbc9@huawei.com>
Date:   Tue, 15 Feb 2022 17:37:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-8-willy@infradead.org>
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
> Now we can call mapping_shrink_folio() instead of invalidate_inode_page()
> and save a few calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/truncate.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b1bdc61198f6..567557c36d45 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -505,27 +505,27 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
>  	folio_batch_init(&fbatch);
>  	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> -			struct page *page = &fbatch.folios[i]->page;
> +			struct folio *folio = fbatch.folios[i];
>  
> -			/* We rely upon deletion not changing page->index */
> +			/* We rely upon deletion not changing folio->index */
>  			index = indices[i];
>  
> -			if (xa_is_value(page)) {
> +			if (xa_is_value(folio)) {
>  				count += invalidate_exceptional_entry(mapping,
>  								      index,
> -								      page);
> +								      folio);
>  				continue;
>  			}
> -			index += thp_nr_pages(page) - 1;
> +			index += folio_nr_pages(folio) - 1;
>  
> -			ret = invalidate_inode_page(page);
> -			unlock_page(page);
> +			ret = mapping_shrink_folio(mapping, folio);
> +			folio_unlock(folio);
>  			/*
> -			 * Invalidation is a hint that the page is no longer
> +			 * Invalidation is a hint that the folio is no longer
>  			 * of interest and try to speed up its reclaim.
>  			 */
>  			if (!ret) {
> -				deactivate_file_page(page);
> +				deactivate_file_page(&folio->page);
>  				/* It is likely on the pagevec of a remote CPU */
>  				if (nr_pagevec)
>  					(*nr_pagevec)++;
> 

