Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D510768878
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjG3Vm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3Vm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:42:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826FCA;
        Sun, 30 Jul 2023 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1Opzr/5dCzOISssMERYtnogRBsg3jiV2CKz9u3Hxb8U=; b=hAIOP77AAzhkO3U6Fw01MZwM+f
        uQkHPzoqWifaVO4Ih3pLtS0kiEYrph2CPjAEv5gSeI6NjkBo3jm05QeCuuPR/Qp8lZrBZYTuvn/v3
        yjSMFohjsPE2GFt+qJmMkgNb4HD3T5NyHAZ7lyKLwBCBl32ZeTt6scjIIptj5ohEk7Qptasy/nMTm
        NaiVnhdxC233zFTLV7S8/1n1vbwJQw9krJYV5/ifLSkMaC/GqO/O2aZTFeAXWpdxDIeh27GKENp8T
        NZIDlol9DwCyOeaLK/bhetFRQknPcZwt4GpikVW7UkSihsKeAeyssRyAgqNCKDiciDDvd3+pE2Ahc
        Fj8Wfqpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQEBa-00FpI2-Jq; Sun, 30 Jul 2023 21:42:46 +0000
Date:   Sun, 30 Jul 2023 22:42:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
Message-ID: <ZMbZVjMaIeI1DSj9@casper.infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
 <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
 <ZMZHH5Xc507OZA1O@casper.infradead.org>
 <40a3ab47-da3e-0d08-b3fa-b4663f3e727d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40a3ab47-da3e-0d08-b3fa-b4663f3e727d@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 30, 2023 at 09:57:06PM +0800, Zhu Yanjun wrote:
> 
> 在 2023/7/30 19:18, Matthew Wilcox 写道:
> > On Sun, Jul 30, 2023 at 07:01:26PM +0800, Zhu Yanjun wrote:
> > > Does the following function have folio version?
> > > 
> > > "
> > > int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
> > > 		struct page **pages, unsigned int n_pages, unsigned int offset,
> > > 		unsigned long size, unsigned int max_segment,
> > > 		unsigned int left_pages, gfp_t gfp_mask)
> > > "
> > No -- I haven't needed to convert anything that uses
> > sg_alloc_append_table_from_pages() yet.  It doesn't look like it should
> > be _too_ hard to add a folio version.
> 
> In many places, this function is used. So this function needs the folio
> version.

It's not used in very many places.  But the first one that I see it used
(drivers/infiniband/core/umem.c), you can't do a straightforward folio
conversion:

                pinned = pin_user_pages_fast(cur_base,
                                          min_t(unsigned long, npages,
                                                PAGE_SIZE /
                                                sizeof(struct page *)),
                                          gup_flags, page_list);
...
                ret = sg_alloc_append_table_from_pages(
                        &umem->sgt_append, page_list, pinned, 0,
                        pinned << PAGE_SHIFT, ib_dma_max_seg_size(device),
                        npages, GFP_KERNEL);

That can't be converted to folios.  The GUP might start in the middle of
the folio, and we have no way to communicate that.

This particular usage really needs the phyr work that Jason is doing so
we can efficiently communicate physically contiguous ranges from GUP
to sg.

> Another problem, after folio is used, I want to know the performance after
> folio is implemented.
> 
> How to make tests to get the performance?

You know what you're working on ... I wouldn't know how best to test
your code.
