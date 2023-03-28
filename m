Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0C6CC605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjC1PWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjC1PVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:21:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268CE18F;
        Tue, 28 Mar 2023 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wX0gmGH9IveBATxHqfl2f3+O0L57UTWE20X3bYSnO1g=; b=pr1joZerHeKsBlyHogQ7a2PLlI
        OnKh0jl/7d0I5iiAMB3X7PawFs8SxWFO5NOBIiE/eGbmzg3mKFkP+FwRa5Ny5sshyl1sTJhGnrPxM
        i0MpOhosQtQBiby8hQFQO7A547F7BZHII2Gq3lLxvo2wHCUyCNlUkBH2lWpFKhivqkwK73X1FvCJ1
        xLdu2PshCd8JBCdj8YknFzz0zElmgXh2/EyRWj8nrbt2FtuH5VKto89AE5WltWejQQIgwhOsB109K
        5E0AzOvrQIsWkVletsJB/nREkTB9gE00L06B+oQy1+yUivc+7vioonZ2bMQDnHKEDOstKf2D+vqu9
        lfiylSRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phB6P-008XAW-Sn; Tue, 28 Mar 2023 15:19:13 +0000
Date:   Tue, 28 Mar 2023 16:19:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        viro@zeniv.linux.org.uk, senozhatsky@chromium.org,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Message-ID: <ZCMFcTHkTe/1WapL@casper.infradead.org>
References: <20230328112716.50120-1-p.raghav@samsung.com>
 <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
 <20230328112716.50120-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328112716.50120-2-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:27:12PM +0200, Pankaj Raghav wrote:
> -static void zram_page_end_io(struct bio *bio)
> +static void zram_read_end_io(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> -
> -	page_endio(page, op_is_write(bio_op(bio)),
> -			blk_status_to_errno(bio->bi_status));
>  	bio_put(bio);
>  }
>  
> @@ -635,7 +631,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  	}
>  
>  	if (!parent)
> -		bio->bi_end_io = zram_page_end_io;
> +		bio->bi_end_io = zram_read_end_io;

Can we just do:

	if (!parent)
		bio->bi_end_io = bio_put;

drivers/nvme/target/passthru.c does this, so it wouldn't be the first.
