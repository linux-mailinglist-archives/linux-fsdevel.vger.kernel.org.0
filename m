Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B435D4F792E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiDGINd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiDGINN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:13:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550673FD9E;
        Thu,  7 Apr 2022 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YSea+azCLlVibk6WtN+bQC5ZLuefUNq1U9p8LGAsefw=; b=s5JoQXtZ0ZBfVVwo8YuDOdZXfo
        ZTf1iTaiLB6l8SU7IQiVOaxjyuZSMWy3wvU2rCDLUQDWnyKVA/j3CHn4s/7ak3kZTsLew1/DMQK3p
        6+czEMANzRDZjFuvPhsIXwUgGLkK42flhsMUBsU7WJ9JtoF3sDJL2y+aqyTxwJTx65xEigyVg4yGf
        vxUIGanMEgiGtiU0d3JREEJm1heHIWdXMODkG7zqKl4A/VMcV3hoFR7Cz7Cwo8X7HpK3xkmjoiCXR
        4KsMWOeBb9Wq7n1JoaeJcyyv6L+lo9O0cFbBeL1Qe0Nxzn55iE+UxCPo2Ne/MWMYvGEzRFjEClaqA
        5uTqFh+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncNET-00AGuj-7k; Thu, 07 Apr 2022 08:11:09 +0000
Date:   Thu, 7 Apr 2022 01:11:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] block: add sync_blockdev_range()
Message-ID: <Yk6cnX5eHrJYrVXQ@infradead.org>
References: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Ykp5cmdP3nV8XTFj@infradead.org>
 <HK2PR04MB38910663E1666A0C74A5618781E79@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB38910663E1666A0C74A5618781E79@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:21:15AM +0000, Yuezhang.Mo@sony.com wrote:
> > From: Christoph Hellwig <hch@infradead.org>
> > > --- a/block/bdev.c
> > > +++ b/block/bdev.c
> > > @@ -200,6 +200,16 @@ int sync_blockdev(struct block_device *bdev)  }
> > > EXPORT_SYMBOL(sync_blockdev);
> > >
> > > +int sync_blockdev_range(struct block_device *bdev, loff_t lstart,
> > > +loff_t lend) {
> > > +	if (!bdev)
> > > +		return 0;
> > 
> > This check isn't really needed, and I don't think we need a !CONFIG_BLOCK
> > stub for this either.
> 
> sync_blockdev() and related helpers have this check and a !CONFIG_BLOCK stub.
> I would like to understand the background of your comment, could you explain a little more?

sync_blockdev and sync_blockdev do that because they are unconditionally
called from sync_filesystem, and not just from block-dependent code.
Eventually that should be cleaned up as well, but please don't add it to
new code.
