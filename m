Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0473EEA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZWXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjFZWXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:23:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85F12E;
        Mon, 26 Jun 2023 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5+/776suwjWNImbh9uLIA8Agdi2BtVsAJ4alJSyX5E=; b=Qt4imOlFVKaYa+N24wYZ4Mfnke
        iga8ldSUJlp1ji5VInVNkg4/mf3YxqfqFPZuY5NZVf8aEpJIrkT/vd5wN5l7tfl5PrM1Q3/2nciEx
        xzOMIbZF9sF4rFb0OIceqlC1kyQmInc7IfFZORR+G/Pz+Bby210dbl8fJMJMGaaHIEKwGbmII1/+p
        FZVJL8+KUmCiyrFjjV6/5IEZl5XhdVeqCkBPPAuXliqbr24iUIM5CHvIroOyrXc8+9cr85lGKhGn1
        yC1143Dv3JCjSokFh7FC2/qG/INorydYFtJSo/hZO4BiYzI6IAvIfLHSg6rg+TwH5yckuEjvrW/GX
        vpnCHHcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDucL-0026sN-1h; Mon, 26 Jun 2023 22:23:29 +0000
Date:   Mon, 26 Jun 2023 23:23:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJoP4e6VPkJnvSAh@casper.infradead.org>
References: <ZJnTRfHND0Wi4YcU@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJnTRfHND0Wi4YcU@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> is slower than __find_get_block_slow:
> 
>  114 ns per __find_get_block
>  68 ns per __find_get_block_slow
> 
> So remove the per-CPU buffer_head caching.
> 
> Test program:
> 
> #define NRLOOPS 200000
> static int __init example_init(void)
> {
>         ktime_t s, e;
>         s64 delta;
>         int i, suc;
> 
>         bdev = blkdev_get_by_path("/dev/loop0", FMODE_READ, NULL);
>         if (IS_ERR(bdev)) {
>                 printk(KERN_ERR "failed to load /dev/loop0\n");
>                 return -ENODEV;
>         }
> 
>         suc = 0;
>         delta = 0;
>         for (i=0; i < NRLOOPS; i++) {
>                 struct buffer_head *bh;
> 
>                 s = ktime_get();
>                 bh = __find_get_block(bdev, 1, 512);
>                 e = ktime_get();
>                 if (bh) {
>                                 suc++;
>                                 __brelse(bh);
>                 }
>                 delta = delta + ktime_to_ns(ktime_sub(e, s));
> 
>         }
>         printk(KERN_ERR "%lld ns per __find_get_block (suc=%d)\n", delta/NRLOOPS, suc);
> 
>         suc = 0;
>         delta = 0;
>         for (i=0; i < NRLOOPS; i++) {
>                 struct buffer_head *bh;
> 
>                 s = ktime_get();
>                 bh = __find_get_block_slow(bdev, 1);
>                 e = ktime_get();
>                 if (bh) {
>                         suc++;
>                         __brelse(bh);
>                 }
>                 delta = delta + ktime_to_ns(ktime_sub(e, s));
>         }
>         printk(KERN_ERR "%lld ns per __find_get_block_slow (suc=%d)\n", delta/NRLOOPS, suc);

It occurs to me that this is close to being the best-case scenario for
page-cache lookup as well as for lru lookup.  Can you re-run it with
block 4UL * 1024 * 1024 * 1024 instead of block 1?
