Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0C612024
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 06:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ2Eq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 00:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJ2Eq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:46:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90920129742;
        Fri, 28 Oct 2022 21:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45E72B82AA2;
        Sat, 29 Oct 2022 04:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968C2C433D6;
        Sat, 29 Oct 2022 04:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667018781;
        bh=80lU3QpeiitIVawK91PHV+p4z43WIDD4Rouks6i2Gj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uStOgrQ+MB0RzqQUR2IfSfKEroJt+tBJ1eUXiuGJdVpHPU65B4Wndy12I7NwulNEH
         QLUNGsb9gPkhyPjLpOHxZest61y+4N8W4qWlHOMrKXoINg0FcDDDOjXxHaefByx+f/
         8kBWsq7LLWaUOqILmEqMSRc+s3mc9FckVC7dRltlA3gueYJyLaWQeeWS7ZpJzaVFRR
         3jqmb9wVl/FmxMezeNEb5Mt6NqqRQIo9nqBur1wO2lEpw78o6TPaG3b+pYYYWCgZiM
         1KYPHhw1mZSVn8629ziSH0yjYWEjxqX/XkcIejJBjvO5Ogm4Ov/+SG8x91NwiUvL6B
         J+nrTC2V/HxDA==
Message-ID: <cee7fa24-5699-9777-d157-f03a8dd18a00@kernel.org>
Date:   Sat, 29 Oct 2022 12:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH v3 11/23] f2fs: Convert f2fs_fsync_node_pages()
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
 <20221017202451.4951-12-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221017202451.4951-12-vishal.moola@gmail.com>
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
>   fs/f2fs/node.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 983572f23896..e8b72336c096 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1728,12 +1728,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   			unsigned int *seq_id)
>   {
>   	pgoff_t index;
> -	struct pagevec pvec;
> +	struct folio_batch fbatch;
>   	int ret = 0;
>   	struct page *last_page = NULL;
>   	bool marked = false;
>   	nid_t ino = inode->i_ino;
> -	int nr_pages;
> +	int nr_folios;
>   	int nwritten = 0;
>   
>   	if (atomic) {
> @@ -1742,20 +1742,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   			return PTR_ERR_OR_ZERO(last_page);
>   	}
>   retry:
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
>   	index = 0;
>   
> -	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -				PAGECACHE_TAG_DIRTY))) {
> +	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
> +					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> +					&fbatch))) {
>   		int i;
>   
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct page *page = &fbatch.folios[i]->page;
>   			bool submitted = false;
>   
>   			if (unlikely(f2fs_cp_error(sbi))) {
>   				f2fs_put_page(last_page, 0);
> -				pagevec_release(&pvec);
> +				folio_batch_release(&fbatch);
>   				ret = -EIO;
>   				goto out;
>   			}
> @@ -1821,7 +1822,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   				break;
>   			}
>   		}
> -		pagevec_release(&pvec);
> +		folio_batch_release(&fbatch);
>   		cond_resched();
>   
>   		if (ret || marked)
