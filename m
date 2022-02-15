Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F84B662A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiBOIcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:32:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBOIcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826DA94EE
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 00:32:23 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JyZ6X6hwhz9shc;
        Tue, 15 Feb 2022 16:30:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:32:21 +0800
Subject: Re: [PATCH 01/10] splice: Use a folio in
 page_cache_pipe_buf_try_steal()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-2-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d7fed149-806e-7991-30b7-00d878b9af58@huawei.com>
Date:   Tue, 15 Feb 2022 16:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-2-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> This saves a lot of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/splice.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> diff --git a/fs/splice.c b/fs/splice.c
> index 5dbce4dcc1a7..23ff9c303abc 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -47,26 +47,27 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
>  		struct pipe_buffer *buf)
>  {
>  	struct page *page = buf->page;
> +	struct folio *folio = page_folio(page);
>  	struct address_space *mapping;
>  
> -	lock_page(page);
> +	folio_lock(folio);
>  
> -	mapping = page_mapping(page);
> +	mapping = folio_mapping(folio);
>  	if (mapping) {
> -		WARN_ON(!PageUptodate(page));
> +		WARN_ON(!folio_test_uptodate(folio));
>  
>  		/*
>  		 * At least for ext2 with nobh option, we need to wait on
> -		 * writeback completing on this page, since we'll remove it
> +		 * writeback completing on this folio, since we'll remove it
>  		 * from the pagecache.  Otherwise truncate wont wait on the
> -		 * page, allowing the disk blocks to be reused by someone else
> +		 * folio, allowing the disk blocks to be reused by someone else
>  		 * before we actually wrote our data to them. fs corruption
>  		 * ensues.
>  		 */
> -		wait_on_page_writeback(page);
> +		folio_wait_writeback(folio);
>  
> -		if (page_has_private(page) &&
> -		    !try_to_release_page(page, GFP_KERNEL))
> +		if (folio_has_private(folio) &&
> +		    !filemap_release_folio(folio, GFP_KERNEL))
>  			goto out_unlock;
>  
>  		/*
> @@ -80,11 +81,11 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
>  	}
>  
>  	/*
> -	 * Raced with truncate or failed to remove page from current
> +	 * Raced with truncate or failed to remove folio from current
>  	 * address space, unlock and return failure.
>  	 */
>  out_unlock:
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	return false;
>  }
>  
> 

