Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CF4F0E65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377204AbiDDEyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377287AbiDDEyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:54:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F153B299;
        Sun,  3 Apr 2022 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b5rvgKHQBrxUjxrXC1n/6ZmRlGY5pOrxtPmT3z1PEjc=; b=SlZcwtx7AAAee889K+zl49LOb9
        oV6PrhY+KekPy01nguN00WX7mhZwuYAm38m0y6xm2BW33Wz8fASnXyAdwPNQt5wbQdvfLdIhjZmdc
        wmMfGoqckxzjpwJVo7iY9EIHrDYxEpJug//AV/69EiHp07dx72GjnnAl5l6DRHH01+lxPTBfjLItY
        8h5XY1wF2I4AbmO2ndxmfnQkKtWWJL/9VGeG2SgFOuBkqsUzz82z4VyeKRaYBu0nP35uRzZffOFpq
        i/4soywdERhe1oWmrVjnNpdJ7QQB1+hsg95r5wpBH1I/sJyngnq8q2Hwwx0mHUoo80mTAR34+RKr6
        1Ku5c33Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEh8-00D5Dg-TI; Mon, 04 Apr 2022 04:52:02 +0000
Date:   Sun, 3 Apr 2022 21:52:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] block: add sync_blockdev_range()
Message-ID: <Ykp5cmdP3nV8XTFj@infradead.org>
References: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 02, 2022 at 03:28:00AM +0000, Yuezhang.Mo@sony.com wrote:
> sync_blockdev_range() is to support syncing multiple sectors
> with as few block device requests as possible, it is helpful
> to make the block device to give full play to its performance.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> cc: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bdev.c           | 10 ++++++++++
>  include/linux/blkdev.h |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 102837a37051..57043e4f3322 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -200,6 +200,16 @@ int sync_blockdev(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL(sync_blockdev);
>  
> +int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
> +{
> +	if (!bdev)
> +		return 0;

This check isn't really needed, and I don't think we need a
!CONFIG_BLOCK stub for this either.
