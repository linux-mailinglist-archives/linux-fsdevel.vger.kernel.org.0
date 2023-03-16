Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CC6BD363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjCPPYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCPPYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:24:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4359E309;
        Thu, 16 Mar 2023 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jbs95Gjo7Q//j6ilu4KDrnygFvpFxedZLKTPScHD73o=; b=0REXzHjdr3ri4fT8gvfHhc1YE+
        CzFmb3IfjPqEVtLc1hEeKsHoeslo1BrVqyrSvvD6iQ1WKABF792Y2KK6Nh7Qn5I2vZl9kDc7LLt3T
        9aUYhgNnDW8A4+Qo9nAt4e4s9sCq6nUnN2Em41FVx5tUawAAN+Zh3sgRpI9AcqR8y1BJ613rpSfqZ
        kiVkZUmktBBZMU7XEIB9zErbzECUCup5LesKj8eenY3JrKQDHarPokKUw9z9UG5oip1vyw1co0470
        v85Mz316j22qeqbbxrlwcOuhs6kE1J61YoNNW5W4NPLOE4uAbtSElJR7WOqXoqHGtOpQ5zFWoOGte
        b9F5fWzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcpSW-00Goph-19;
        Thu, 16 Mar 2023 15:24:04 +0000
Date:   Thu, 16 Mar 2023 08:24:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, willy@infradead.org,
        minchan@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Message-ID: <ZBM0lPycYm2X0Tfp@infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
 <ZBHcl8Pz2ULb4RGD@infradead.org>
 <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 11:04:54AM +0100, Pankaj Raghav wrote:
> It looks like this endio function is called when alloc_page is used (for
> partial IO) to trigger writeback from the user space `echo "idle" >
> /sys/block/zram0/writeback`.


Yes.

> I don't understand when you say the harm might not be horrible if we don't
> call folio_endio here. Do you think it is just safe to remove the call to
> folio_endio function?

I suspect so.  It doesn't seem like the involved pages are ever locked
or have the writeback set, so it should be fine.

> +               while ((folio = readahead_folio(rac))) {
> +                       folio_clear_uptodate(folio);
> +                       folio_set_error(folio);
> +                       folio_unlock(folio);
> +               }
> +               return;
> +       }
> +
> +       while ((folio = readahead_folio(rac))) {
> +               folio_mark_uptodate(folio);
> +               folio_unlock(folio);
>         }
>  }

Looks good.

> @@ -59,7 +59,8 @@ static void mpage_end_io(struct bio *bio)
> static struct bio *mpage_bio_submit(struct bio *bio)
>  {
> -       bio->bi_end_io = mpage_end_io;
> +       bio->bi_end_io = (op_is_write(bio_op(bio))) ? mpage_write_end_io :
> +                                                     mpage_read_end_io;
>         guard_bio_eod(bio);
>         submit_bio(bio);
>         return NULL;
> And mpage_{write,read}_end_io will iterate over the folio and call the
> respective functions.

Yes, although I'd do it with a good old if/else and with less braces.
It might make sense to split mpage_bio_submit as well, though.
