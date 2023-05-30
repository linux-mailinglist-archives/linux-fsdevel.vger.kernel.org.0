Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132FE715566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjE3GOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 02:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3GOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 02:14:03 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA330CD;
        Mon, 29 May 2023 23:14:00 -0700 (PDT)
X-QQ-mid: bizesmtp65t1685426547tmy4xja6
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 14:02:24 +0800 (CST)
X-QQ-SSF: 01400000000000C0G000000A0000000
X-QQ-FEAT: znfcQSa1hKaNoAA+Wu37XwpK1cksC/6aTghWFSS0JvJasQfz+eIO2zJLQRT6i
        rEM1DjNn+cMKUMmMkYKxNVhiJ/YaqYwyOdwJn8trVVHL4FwWqRIC1gXasm0tl2QcgbOhP2j
        LvZhKTr8+O0f7WbJ7aEKXPBecA76aTyilAsJsTVqnedMXbBhFAnGHPVXjv6vLMsjW6YvPyi
        i1gtBueSiPnfPmNzUzOGPtA6xO9BEI1yiGrXZ0be9XSQujkY1RIoTVJFJr5g/q5q1gPvFUS
        ZEKOIIEP+REIXrHWhBXhZbB8seLB4k9ZUsPfQMlMU4/yyaVrRkuBNBwcOqvR1A5Vgs91htm
        UZo1RdQcwSh9F4y0PRV2IDwcHtWLTFF1d191XBv6COHtM1tov3TE4c2SwkUPUQ1WWsDxlmz
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6104239791662094715
From:   gouhao@uniontech.com
To:     johannes.thumshirn@wdc.com
Cc:     agruenba@redhat.com, axboe@kernel.dk, cluster-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org
Subject: Re:[PATCH v5 04/20] fs: buffer: use __bio_add_page to add single page to bio
Date:   Tue, 30 May 2023 14:02:22 +0800
Message-Id: <20230530060222.14892-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230502101934.24901-5-johannes.thumshirn@wdc.com>
References: <20230502101934.24901-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> The buffer_head submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a7fc561758b1..5abc26d8399d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2760,7 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  
>  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>  
> -	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
> +	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
>  	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
Can `BUG_ON` be deleted now ?
>  
>  	bio->bi_end_io = end_bio_bh_io_sync;
> -- 
> 2.40.0
--
thanks,
Gou Hao
