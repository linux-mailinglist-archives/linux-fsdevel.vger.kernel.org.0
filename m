Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A187B0791
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjI0PCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjI0PCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:02:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BAF5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y4V9nbeTLh81lw4qhUl7hh0+UOvG/La5zTxJu4bZJSo=; b=svWYaR70p9arM7xttAWR0atlnp
        y3IAll8db2o/dxSHmNVdSFuSwbjejNI7Ln7O1/EaTO9QAzV7wBJ1bfTjyPNXBm6AQI/kcm8HWIQDS
        ro1odm+xI/wdZne0HmI+vyWjM+DDXMBSRB19qmOZ2QV2JjLPqFClmE0QfbpH7qo5KZT4RL6ePaGqv
        k0wZiKjnztzLg2E5iwbAvY10BoWly2pzjXw0KdNhUbsGPwKoHtUJnDcmAA1K1z4dk3PoBAJwtuOoi
        SDYqpwUlD55rXtwBNOLCLhTi3Q10GEAk0DhgV0/puzz2L2hG8GDnI19UZHzUafmBoRcZ+7M2Be6gr
        xjFEglhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlW3l-00EWkK-0h; Wed, 27 Sep 2023 15:02:41 +0000
Date:   Wed, 27 Sep 2023 16:02:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] buffer: hoist GFP flags from grow_dev_page() to
 __getblk_gfp()
Message-ID: <ZRREEIwqiy5DijKB@casper.infradead.org>
References: <592d088a-12c7-40e6-9726-65433e2e5a2d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592d088a-12c7-40e6-9726-65433e2e5a2d@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:40:21AM +0300, Dan Carpenter wrote:
> Hello Matthew Wilcox (Oracle),
> 
> The patch a3c38500d469: "buffer: hoist GFP flags from grow_dev_page()
> to __getblk_gfp()" from Sep 14, 2023 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/buffer.c:1065 grow_dev_page()
> 	warn: NEW missing error code 'ret'

Andrew, please add this -fix patch to "buffer: hoist GFP flags from
grow_dev_page() to __getblk_gfp()".  I'll send a further cleanup patch
to make the return values a bit more meaningful.

diff --git a/fs/buffer.c b/fs/buffer.c
index 3fe293c9f3ca..b1610202eb5c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1060,6 +1060,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 			goto failed;
 	}
 
+	ret = -ENOMEM;
 	bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
 	if (!bh)
 		goto failed;
