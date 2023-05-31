Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5A717314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 03:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjEaBVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 21:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjEaBV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 21:21:28 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B193;
        Tue, 30 May 2023 18:21:24 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685496025tw3oxnvp
Received: from [10.7.13.54] ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 May 2023 09:20:22 +0800 (CST)
X-QQ-SSF: 01400000000000C0G000000A0000000
X-QQ-FEAT: W+onFc5Tw4MXg9NmrArDYuEAjJHK4eL16p2bcGANAmu997qLZ+ujaV0s8Z1f/
        Nzmi8pNaWsKZP3Jmi5RKnu6nb+dCbNyrwOCVF3RhlVA1YBbFzgt8Coml9Vf2MloZUnDRpkl
        ADpUgJE8XNtjVow/bv7ZzhCNWk6I9WYmKFl0SSM5YLTrc8oT51rizMWMAPqdm1XDAhtCWWX
        DTqIUQa3efIfkNOAZX6/Yw4UnTUT6YoTYppGEuFOveHR6P5KZuNwCsuXN+Ey1bBhqyCVvPN
        eC3evk9wk+U3FfRn1CeZLX4tO4xCLND+a2cq7UCdAoJE6IMuJmrs5xNI56H1bmPeS+O61qR
        RBvgLchUjYteu3Ao0qfjQZGWJn29WS3hcVcO44C5o7MX+jf/j0=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16526261309428552688
Message-ID: <594B3D441ED28D0D+301afc15-d56d-4b9b-dc94-c97c658df05c@uniontech.com>
Date:   Wed, 31 May 2023 09:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 04/20] fs: buffer: use __bio_add_page to add single
 page to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
 <f67cc9c310bed1e3c3302ea1c206da7d5ebc14cb.1685461490.git.johannes.thumshirn@wdc.com>
Reply-To: f67cc9c310bed1e3c3302ea1c206da7d5ebc14cb.1685461490.git.johannes.thumshirn@wdc.com
From:   Gou Hao <gouhao@uniontech.com>
In-Reply-To: <f67cc9c310bed1e3c3302ea1c206da7d5ebc14cb.1685461490.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/23 23:49, Johannes Thumshirn wrote:

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


Reviewed-by: Gou Hao <gouhao@uniontech.com>

> ---
>   fs/buffer.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a7fc561758b1..63da30ce946a 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2760,8 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>   
>   	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>   
> -	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
> -	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
> +	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
>   
>   	bio->bi_end_io = end_bio_bh_io_sync;
>   	bio->bi_private = bh;
