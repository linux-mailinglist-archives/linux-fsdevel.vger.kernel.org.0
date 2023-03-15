Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F646BB686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjCOOvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjCOOvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:51:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154C61885;
        Wed, 15 Mar 2023 07:51:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FED4219B2;
        Wed, 15 Mar 2023 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678891899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zN92RATXHClyStOM+d5V8uZWcn/TnTw/Njd/6C4epA=;
        b=hhtriCNraBCnTfLEs3tdlL0KY8e9/UGeNlNxe/Rzcn3Y2wQmJl9Zhfw5kwz764TkjVZIW2
        KBz3ViihppZ1vOiOUmS5GlzcZenc7ZpupP8OI+HTM18Nl7XfjBx56GNBl6xwuBsEqznvbA
        VHxg/JEM6yX5nHOsXcypLNLjzgNRrQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678891899;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zN92RATXHClyStOM+d5V8uZWcn/TnTw/Njd/6C4epA=;
        b=3KraaO6gycZxDWk83e+AXp9e/HO+t+93D+tFnY0MOiGFNcA9jaDsWN//mFB/SY6YL1PVTy
        p4ffaRKzuVcYxbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 682FD13A00;
        Wed, 15 Mar 2023 14:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cp2tFXrbEWTpVQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 15 Mar 2023 14:51:38 +0000
Message-ID: <a0984167-76bd-ec7c-08a7-93b29f364843@suse.de>
Date:   Wed, 15 Mar 2023 15:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, willy@infradead.org,
        minchan@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230315123233.121593-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/23 13:32, Pankaj Raghav wrote:
> page_endio() already works on folios by converting a page in to a folio as
> the first step. Convert page_endio to folio_endio by taking a folio as the
> first parameter.
> 
> Instead of doing a page to folio conversion in the page_endio()
> function, the consumers of this API do this conversion and call the
> folio_endio() function in this patch.
> The following patches will convert the consumers of this API to use native
> folio functions to pass to folio_endio().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/block/zram/zram_drv.c | 2 +-
>   fs/mpage.c                    | 2 +-
>   fs/orangefs/inode.c           | 2 +-
>   include/linux/pagemap.h       | 2 +-
>   mm/filemap.c                  | 8 +++-----
>   5 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index aa490da3cef2..f441251c9138 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -610,7 +610,7 @@ static void zram_page_end_io(struct bio *bio)
>   {
>   	struct page *page = bio_first_page_all(bio);
>   
> -	page_endio(page, op_is_write(bio_op(bio)),
> +	folio_endio(page_folio(page), op_is_write(bio_op(bio)),
>   			blk_status_to_errno(bio->bi_status));
>   	bio_put(bio);
>   }
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 22b9de5ddd68..40e86e839e77 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -50,7 +50,7 @@ static void mpage_end_io(struct bio *bio)
>   
>   	bio_for_each_segment_all(bv, bio, iter_all) {
>   		struct page *page = bv->bv_page;
> -		page_endio(page, bio_op(bio),
> +		folio_endio(page_folio(page), bio_op(bio),
>   			   blk_status_to_errno(bio->bi_status));
>   	}
>   
Can't this be converted to use 'bio_for_each_folio_all()' instead of
bio_for_each_segment_all()?

Cheers,

Hannes

