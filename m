Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59904539DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbiFAHEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348130AbiFAHEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:04:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B28BD3D;
        Wed,  1 Jun 2022 00:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD21361323;
        Wed,  1 Jun 2022 07:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C864AC385B8;
        Wed,  1 Jun 2022 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654067075;
        bh=BfAsk3P+5WEVQwfCV3N2UzTi5iZs95agLnGWAp6Lvso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd2/kzakSesSChevVq3SafU+B04oNWyNUh1UNpOrbH7SWTxzlN+lyP5MwKhBb+/p6
         z+XD701W2xtoWCv+4MKqii1IMzIC9q9aoAPbkGjpWG23RDOoVfrgW51I4COCJSJqkS
         2JfuMLXtYG61hSXg7PRzPfm+MsjOHihY3CNdIVU6LgGU4R2QThf6oqgmZWKe5byGwy
         FKsmV7YBe+MnVv6Uz180jU7SpA1CFJELS8CVnfvahvArK326gv6mIFrNm7uSZlfoJm
         F8eBtcGPPB7nXqLhakeeVsKy64boFtnRdrRSx2yo61puc92G54MKbHev29X+OrAF1j
         ZZt3SnV4WffEQ==
Date:   Wed, 1 Jun 2022 00:04:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv5 07/11] block/bounce: count bytes instead of sectors
Message-ID: <YpcPecSPRG6kkydy@sol.localdomain>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-8-kbusch@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 12:11:33PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> v4->v5:
> 
>   Updated comment (Christoph)
> 
>  block/bounce.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..fbadf179601f 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	int rw = bio_data_dir(*bio_orig);
>  	struct bio_vec *to, from;
>  	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	/*
> +	 * Individual bvecs may not be logical block aligned. Round down
> +	 * the split size so that each bio is properly sector size aligned,
> +	 * even if we do not use the full hardware limits.
> +	 */

Please write "might not" instead of "may not", since "may not" is ambiguous; it
sometimes means "are not allowed to".  Likewise in other patches.

"Sector size" is ambiguous as well.  I think you mean "logical block size"?

- Eric
