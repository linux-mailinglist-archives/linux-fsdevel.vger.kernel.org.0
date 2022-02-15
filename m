Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2944B662B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiBOIdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:33:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiBOIc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5818E7AC4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 00:32:47 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JyZ712cxKz9shW;
        Tue, 15 Feb 2022 16:31:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:32:45 +0800
Subject: Re: [PATCH 03/10] mm/truncate: Convert invalidate_inode_page() to use
 a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-4-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <aa3293b6-ca96-b7b1-ff5d-68eba2f65e1e@huawei.com>
Date:   Tue, 15 Feb 2022 16:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-4-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> This saves a number of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

>  mm/truncate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index e5e2edaa0b76..b73c30c95cd0 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -281,14 +281,15 @@ EXPORT_SYMBOL(generic_error_remove_page);
>   */
>  int invalidate_inode_page(struct page *page)
>  {
> -	struct address_space *mapping = page_mapping(page);
> +	struct folio *folio = page_folio(page);
> +	struct address_space *mapping = folio_mapping(folio);
>  	if (!mapping)
>  		return 0;
> -	if (PageDirty(page) || PageWriteback(page))
> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return 0;
>  	if (page_mapped(page))
>  		return 0;
> -	if (page_has_private(page) && !try_to_release_page(page, 0))
> +	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
>  		return 0;
>  
>  	return remove_mapping(mapping, page);
> 

