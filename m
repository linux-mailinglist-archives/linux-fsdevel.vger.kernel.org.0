Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4A4B67BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiBOJiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:38:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiBOJiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:38:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A96C3C2C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:37:51 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JybZh3Frxzccxy;
        Tue, 15 Feb 2022 17:36:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:37:49 +0800
Subject: Re: [PATCH 09/10] mm/truncate: Combine invalidate_mapping_pagevec()
 and __invalidate_mapping_pages()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-10-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <54cc232e-9eb9-efbf-2f93-e23cfa3d6c36@huawei.com>
Date:   Tue, 15 Feb 2022 17:37:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-10-willy@infradead.org>
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
> We can save a function call by combining these two functions, which
> are identical except for the return value.  Also move the prototype
> to mm/internal.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  include/linux/fs.h |  4 ----
>  mm/internal.h      |  2 ++
>  mm/truncate.c      | 32 +++++++++++++-------------------
>  3 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e2d892b201b0..85c584c5c623 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2749,10 +2749,6 @@ extern bool is_bad_inode(struct inode *);
>  unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  					pgoff_t start, pgoff_t end);
>  
> -void invalidate_mapping_pagevec(struct address_space *mapping,
> -				pgoff_t start, pgoff_t end,
> -				unsigned long *nr_pagevec);
> -
>  static inline void invalidate_remote_inode(struct inode *inode)
>  {
>  	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> diff --git a/mm/internal.h b/mm/internal.h
> index d886b87b1294..6bbe40a1880a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -102,6 +102,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
>  		loff_t end);
>  long invalidate_inode_page(struct page *page);
> +unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
> +		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec);
>  
>  /**
>   * folio_evictable - Test whether a folio is evictable.
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 14486e75ec28..6b94b00f4307 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -492,7 +492,18 @@ void truncate_inode_pages_final(struct address_space *mapping)
>  }
>  EXPORT_SYMBOL(truncate_inode_pages_final);
>  
> -static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
> +/**
> + * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
> + * @mapping: the address_space which holds the pages to invalidate
> + * @start: the offset 'from' which to invalidate
> + * @end: the offset 'to' which to invalidate (inclusive)
> + * @nr_pagevec: invalidate failed page number for caller
> + *
> + * This helper is similar to invalidate_mapping_pages(), except that it accounts
> + * for pages that are likely on a pagevec and counts them in @nr_pagevec, which
> + * will be used by the caller.
> + */
> +unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
>  		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
>  {
>  	pgoff_t indices[PAGEVEC_SIZE];
> @@ -557,27 +568,10 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
>  unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  		pgoff_t start, pgoff_t end)
>  {
> -	return __invalidate_mapping_pages(mapping, start, end, NULL);
> +	return invalidate_mapping_pagevec(mapping, start, end, NULL);
>  }
>  EXPORT_SYMBOL(invalidate_mapping_pages);
>  
> -/**
> - * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
> - * @mapping: the address_space which holds the pages to invalidate
> - * @start: the offset 'from' which to invalidate
> - * @end: the offset 'to' which to invalidate (inclusive)
> - * @nr_pagevec: invalidate failed page number for caller
> - *
> - * This helper is similar to invalidate_mapping_pages(), except that it accounts
> - * for pages that are likely on a pagevec and counts them in @nr_pagevec, which
> - * will be used by the caller.
> - */
> -void invalidate_mapping_pagevec(struct address_space *mapping,
> -		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
> -{
> -	__invalidate_mapping_pages(mapping, start, end, nr_pagevec);
> -}
> -
>  /*
>   * This is like invalidate_inode_page(), except it ignores the page's
>   * refcount.  We do this because invalidate_inode_pages2() needs stronger
> 

