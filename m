Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1185452E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbiFIRZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244617AbiFIRZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:25:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494C27B25;
        Thu,  9 Jun 2022 10:25:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20B841FEC7;
        Thu,  9 Jun 2022 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654795536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qqv5M93wpHo23KHWJ4hOb2+wV7cmIhR4afJUVlNrr4U=;
        b=ITmVuKoPV03RoO2+mK8TXq0amJTLvwnDZe0aqwtVO9PtH4SY/Lfk/gofY95bT3aRhlJVRW
        Zw+T2xfLTKDGPtSNDQuVzZPJxzxo7oLfY5FvR0OU2qNRR6OQzJYetKsWGgdwZZILRxilfL
        v5V5fs6JqR8RpiWudRI7T0Sbx2Fnfik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654795536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qqv5M93wpHo23KHWJ4hOb2+wV7cmIhR4afJUVlNrr4U=;
        b=fiqhUZwHZDSMOLZttYnvjndI1d6PgUdKXGp5dyuFMCkdkjm6L/Y//rikXFpu1lK8Cv7vAk
        PW+5IM1fhIeSGbBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 083E62C141;
        Thu,  9 Jun 2022 17:25:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C8D8A0633; Thu,  9 Jun 2022 19:25:30 +0200 (CEST)
Date:   Thu, 9 Jun 2022 19:25:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 5/5] fs: remove the NULL get_block case in
 mpage_writepages
Message-ID: <20220609172530.q7bzttn5v2orirre@quack3.lan>
References: <20220608150451.1432388-1-hch@lst.de>
 <20220608150451.1432388-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150451.1432388-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 17:04:51, Christoph Hellwig wrote:
> No one calls mpage_writepages with a NULL get_block paramter, so remove
> support for that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

What about ntfs_writepages()? That seems to call mpage_writepages() with
NULL get_block() in one case...

								Honza

> ---
>  fs/mpage.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index a354ef2b4b4eb..e4cf881634a6a 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -636,8 +636,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>   * @mapping: address space structure to write
>   * @wbc: subtract the number of written pages from *@wbc->nr_to_write
>   * @get_block: the filesystem's block mapper function.
> - *             If this is NULL then use a_ops->writepage.  Otherwise, go
> - *             direct-to-BIO.
>   *
>   * This is a library function, which implements the writepages()
>   * address_space_operation.
> @@ -654,24 +652,16 @@ int
>  mpage_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, get_block_t get_block)
>  {
> +	struct mpage_data mpd = {
> +		.get_block	= get_block,
> +	};
>  	struct blk_plug plug;
>  	int ret;
>  
>  	blk_start_plug(&plug);
> -
> -	if (!get_block)
> -		ret = generic_writepages(mapping, wbc);
> -	else {
> -		struct mpage_data mpd = {
> -			.bio = NULL,
> -			.last_block_in_bio = 0,
> -			.get_block = get_block,
> -		};
> -
> -		ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
> -		if (mpd.bio)
> -			mpage_bio_submit(mpd.bio);
> -	}
> +	ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
> +	if (mpd.bio)
> +		mpage_bio_submit(mpd.bio);
>  	blk_finish_plug(&plug);
>  	return ret;
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
