Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE536D66D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjDDPJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDDPJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:09:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9AE359F;
        Tue,  4 Apr 2023 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PlNwhxmRsqAwivE1o4coXOoSVUnRwZpYbtOW5USkPZw=; b=zpV9QjGDblzOdT3Kpl/izTo0J+
        ojzjuO+DWg0aaCeHuCFEMQoNJ1qVxvDWY5z71t5kvNZUV1lQUm4yb5vtR2bIPAKrIb5N1udjGt9Rk
        gV2W8FHgScYVgfs1W+znbo2NtP/oA7EIwCTNK1BYGfMQaCOzdUCfA5+jPGCodnJLBeZ1Y9HuCMTUZ
        NhZTqatBJlNvnpwAWTZW17Q41G15Slw/1UFT5OppIWUJUrO0pmhe+8jxbCgUVEIShGHyH4cTdBD/d
        9DF5rIAbpmX/6XACqnqm7wsW7ZjKnMHgXsJogBYve1FvXu8wpB0O+0JM4PW2EenYkKVq10vyInIej
        jfGiLqEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiHd-001wCA-0R;
        Tue, 04 Apr 2023 15:09:17 +0000
Date:   Tue, 4 Apr 2023 08:09:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mpage: split bi_end_io callback for reads and
 writes
Message-ID: <ZCw9nWqgtLOt4+ia@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132224eucas1p21fd296fbd4af70220331bb19023f4169@eucas1p2.samsung.com>
 <20230403132221.94921-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-4-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		struct page *page = bv->bv_page;
> -		page_endio(page, bio_op(bio),
> +		page_endio(page, REQ_OP_READ,
> +			   blk_status_to_errno(bio->bi_status));

Nit: I think we can do without the page local variable here.

> +	bio_for_each_segment_all(bv, bio, iter_all) {
> +		struct page *page = bv->bv_page;
> +		page_endio(page, REQ_OP_WRITE,
>  			   blk_status_to_errno(bio->bi_status));

Same here.

>  	}
>  
> @@ -59,7 +73,11 @@ static void mpage_end_io(struct bio *bio)
>  
>  static struct bio *mpage_bio_submit(struct bio *bio)
>  {
> -	bio->bi_end_io = mpage_end_io;
> +	if (op_is_write(bio_op(bio)))
> +		bio->bi_end_io = mpage_write_end_io;
> +	else
> +		bio->bi_end_io = mpage_read_end_io;
> +

I'd also split mpage_bio_submit as all allers are clearly either
for reads or writes.

