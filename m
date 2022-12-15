Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2345664E12E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiLOSpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiLOSpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:45:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367E2F019;
        Thu, 15 Dec 2022 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2f3RFg8lKPZEmxg/33DtgJz7ZsALqBstxpKP4BpvF/I=; b=qmWy52v5M1Cn1nsPjbLE5vPwki
        rauwwLIkT3RZ4l8uaifRy3cFnwWg/FJ0qrTlWwiG2l6ZyhDnHfedJCjngdVQqJ/DTGZ5tQRKJrFBv
        U3hFPfNGg5EWx7AmLYPg+X1dDEgGur5NyuHGFFb29shQ8BLcCmpJf2gYLsdCOj0UphiodCYqlxIqY
        VVpnqh6CfUAfhKt/G3eW5HqVc1Wn28TFt/Jxms44MKyzI/5ri+A4K5UhxzjL/M4V0MAokjJH+nR0Z
        0MphCPLU3nK9wyxTT5aY5yWu/dp/FFC+Y4yevD/QRKd10VebhMJjdMTpnLlmc8p0ybTxbNqUOQI0s
        mVh/Z0xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5tED-00EdoE-Pj; Thu, 15 Dec 2022 18:45:09 +0000
Date:   Thu, 15 Dec 2022 18:45:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y5trNfldXrM4FIyU@casper.infradead.org>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com>
 <6770f692-490e-34fc-46f8-4f65aa071f58@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6770f692-490e-34fc-46f8-4f65aa071f58@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:48:41AM +0800, Chao Yu wrote:
> On 2022/12/13 3:13, Vishal Moola (Oracle) wrote:
> > +add_more:
> > +			pages[nr_pages] = folio_page(folio,idx);
> > +			folio_ref_inc(folio);
> 
> It looks if CONFIG_LRU_GEN is not set, folio_ref_inc() does nothing. For those
> folios recorded in pages array, we need to call folio_get() here to add one more
> reference on each of them?

static inline void folio_get(struct folio *folio)
{
        VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
        folio_ref_inc(folio);
}

That said, folio_ref_inct() is very much MM-internal and filesystems
should be using folio_get(), so please make that modification in the
next revision, Vishal.

