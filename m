Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A1D6BB69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjCOOyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjCOOxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBD61AAB;
        Wed, 15 Mar 2023 07:52:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD4801FD7D;
        Wed, 15 Mar 2023 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678891938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeXuBT5re30n3EyAvxraZ4YKC162yAT2h8vBulDZHfg=;
        b=BRQirtO4JiHFW+e/VMG4fmjhkpXqE53I2/DwtbxDAN2K4v4x3js+Fu4XOMb3a9w9IvT8k3
        EVkJ+YUb01F9L7oYqRBgPJJNiZELGGTZAgLdH+AwSGXSGlQhu6BT5GwTuRocsHs3C9wQ+e
        8vmTENppyygkG+LGDpNylglnfJbH7+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678891938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeXuBT5re30n3EyAvxraZ4YKC162yAT2h8vBulDZHfg=;
        b=tV4w+HvqB4FUzJ2fUhT1gqgQjMumf9KQcoHfwajPgkzztoNGnc4vjWZR6BCCD5Ln7h1WJu
        uen4gD7+EXJcHjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5EED13A00;
        Wed, 15 Mar 2023 14:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZi4I6DbEWRLVgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 15 Mar 2023 14:52:16 +0000
Message-ID: <64a5e85e-4018-ed7d-29d4-db12af290899@suse.de>
Date:   Wed, 15 Mar 2023 15:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 2/3] mpage: use bio_for_each_folio_all in
 mpage_end_io()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, willy@infradead.org,
        minchan@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd@eucas1p1.samsung.com>
 <20230315123233.121593-3-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230315123233.121593-3-p.raghav@samsung.com>
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
> Use bio_for_each_folio_all to iterate through folios in a bio so that
> the folios can be directly passed to the folio_endio() function.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/mpage.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 40e86e839e77..bfcc139938a8 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -45,14 +45,11 @@
>    */
>   static void mpage_end_io(struct bio *bio)
>   {
> -	struct bio_vec *bv;
> -	struct bvec_iter_all iter_all;
> +	struct folio_iter fi;
>   
> -	bio_for_each_segment_all(bv, bio, iter_all) {
> -		struct page *page = bv->bv_page;
> -		folio_endio(page_folio(page), bio_op(bio),
> -			   blk_status_to_errno(bio->bi_status));
> -	}
> +	bio_for_each_folio_all(fi, bio)
> +		folio_endio(fi.folio, bio_op(bio),
> +			    blk_status_to_errno(bio->bi_status));
>   
>   	bio_put(bio);
>   }

Ah. Here it is.

I would suggest merge these two patches.

Cheers,

Hannes
