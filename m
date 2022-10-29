Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7392C612036
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 06:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ2Erh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2Erg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:47:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7218B743;
        Fri, 28 Oct 2022 21:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9447CE2FCE;
        Sat, 29 Oct 2022 04:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA46BC433C1;
        Sat, 29 Oct 2022 04:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667018852;
        bh=mAACII8QLXPb+2oghNArcGBgEFrS6aOgUSNOHVDZKPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CYsWQpVBnAqxfH9QjR9cAu5rm4qWCaoDoHDMrXu8qeGJPjfInBlhlb4hosNwuCb5y
         2/JzqwR6JP/mLfD9pMpYktbhYQ40F+5gyKrX5+LhkAeZVCGACQWLfAJN1MO+F+rPcr
         pF8cd+2VZwfLQNvSAvq7XUTQh6KwHuX3FKB2+f+TAi2/+GyiiYYojDCj8PoUYR+ZFY
         DOI0yXq6r/4zM8H+euAL9EjltJmkjxHL7PzH4n9I24I4nBVjmUa8zpgWtf5jD8qY3B
         fNuxhK1UeMdSTzH7u3Edo7OiEPYEp8TUmTzUuPUUxaMVZZr+PpvXV+EUQRERLh+cl5
         knBFlU8Gx7F1w==
Message-ID: <80fe1f37-586b-4fc6-f007-1d3e8ec3fdb9@kernel.org>
Date:   Sat, 29 Oct 2022 12:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH v3 13/23] f2fs: Convert f2fs_sync_node_pages()
 to use filemap_get_folios_tag()
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
 <20221017202451.4951-14-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221017202451.4951-14-vishal.moola@gmail.com>
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
> preparation for the removal of find_get_pages_range_tag().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/node.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a2f477cc48c7..38f32b4d61dc 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1935,23 +1935,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>   				bool do_balance, enum iostat_type io_type)
>   {
>   	pgoff_t index;
> -	struct pagevec pvec;
> +	struct folio_batch fbatch;
>   	int step = 0;
>   	int nwritten = 0;
>   	int ret = 0;
> -	int nr_pages, done = 0;
> +	int nr_folios, done = 0;
>   
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
>   
>   next_step:
>   	index = 0;
>   
> -	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
> -			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
> +	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
> +				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> +				&fbatch))) {
>   		int i;
>   
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct page *page = &fbatch.folios[i]->page;
>   			bool submitted = false;
>   
>   			/* give a priority to WB_SYNC threads */
> @@ -2026,7 +2027,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>   			if (--wbc->nr_to_write == 0)
>   				break;
>   		}
> -		pagevec_release(&pvec);
> +		folio_batch_release(&fbatch);
>   		cond_resched();
>   
>   		if (wbc->nr_to_write == 0) {
