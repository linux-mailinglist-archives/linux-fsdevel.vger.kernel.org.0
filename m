Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37C74B662C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiBOIdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiBOIdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:33:10 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A339E687E
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 00:33:00 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyZ7r5WPSzccm8;
        Tue, 15 Feb 2022 16:31:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:32:57 +0800
Subject: Re: [PATCH 04/10] mm/truncate: Replace page_mapped() call in
 invalidate_inode_page()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-5-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7e9447a6-f456-82ed-c9cd-c7075d258547@huawei.com>
Date:   Tue, 15 Feb 2022 16:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-5-willy@infradead.org>
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
> folio_mapped() is expensive because it has to check each page's mapcount
> field.  A cheaper check is whether there are any extra references to
> the page, other than the one we own and the ones held by the page cache.
> The call to remove_mapping() will fail in any case if it cannot freeze
> the refcount, but failing here avoids cycling the i_pages spinlock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

>  mm/truncate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b73c30c95cd0..d67fa8871b75 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -287,7 +287,7 @@ int invalidate_inode_page(struct page *page)
>  		return 0;
>  	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return 0;
> -	if (page_mapped(page))
> +	if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
>  		return 0;
>  	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
>  		return 0;
> 

