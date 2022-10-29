Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0B61202D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 06:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ2ErM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 00:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2ErK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74F180264;
        Fri, 28 Oct 2022 21:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B291960A72;
        Sat, 29 Oct 2022 04:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26DC433C1;
        Sat, 29 Oct 2022 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667018828;
        bh=30H2uNbMFKcPAqFuShUf03uMolLK4p541xhuBs+CXnI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gfP7Tdy8pIqM0v1DJqaGNtauH+2lb48dJX1fYQaIymUJ+CLtqqb7q9wwRAcGy2DSs
         BdOmbwNbY5OZr2xEEYKKwU2aU+9GuTOSo4R6ns36zTSUIcjAcfVL/VlZzpDeZpKME8
         JwsNjTbmlK+V7B2zgQZey1WW23pzhAP58MPZ23igfVckJhNckDLUxy6puVSkrGCoRK
         f7eGMud7OL+mzoMFyvpYEH0blFGHNsjz3+hc1IYbpOYbQAJIjaOJ/GfqfVcPe35zvS
         TRnDS1nX8jY4iti+jV9+pW0OWxMZ12yvdyJjPO1eQOSLk6K/9vEZaUEfj2WxQfgeHF
         1akF8W1Dj6/Qg==
Message-ID: <04bf9d52-e12d-f11b-558e-a6b358e4b564@kernel.org>
Date:   Sat, 29 Oct 2022 12:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH v3 12/23] f2fs: Convert
 f2fs_flush_inline_data() to use filemap_get_folios_tag()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-13-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221017202451.4951-13-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> Convert function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_tag().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/node.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e8b72336c096..a2f477cc48c7 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1887,17 +1887,18 @@ static bool flush_dirty_inode(struct page *page)
>   void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
>   {
>   	pgoff_t index = 0;
> -	struct pagevec pvec;
> -	int nr_pages;
> +	struct folio_batch fbatch;
> +	int nr_folios;
>   
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
>   
> -	while ((nr_pages = pagevec_lookup_tag(&pvec,
> -			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
> +	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
> +					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> +					&fbatch))) {
>   		int i;
>   
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct page *page = &fbatch.folios[i]->page;
>   
>   			if (!IS_DNODE(page))
>   				continue;
> @@ -1924,7 +1925,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
>   			}
>   			unlock_page(page);
>   		}
> -		pagevec_release(&pvec);
> +		folio_batch_release(&fbatch);
>   		cond_resched();
>   	}
>   }
