Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F15651D80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLTJfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 04:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiLTJfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:35:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9292917E13;
        Tue, 20 Dec 2022 01:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wXcD/dVdhqpXy83aSCAv5lxDm7KBebMxBukINnltoLo=; b=vCn9O8QgEcK5975YyyXM5mImfh
        iILAxXimAGpNNFl9nb6R57iUnVEwHPlS9S20GGEoqcpJp2BAKamLKvS0BH01gE2kcfizsvjCUBO5l
        2urPFFBsyCw4BjxpXxsDr4kMxbR/g7fwuL7PU647eMiuP4VZr4vn1QU6w57lGIDboTpRO0ceFTWEM
        1i86dm4vxaZUVeg2Sb015gGKq9wirf20G8fQtr6d4DmFgKjcWZKxw7T+A/eqxl9ggV6uZg7DbS+Zt
        FKNHF3Ypnz3iBn4dLWz3W4h9/2uBKIzXcezRCE1c+BUw7l2hGCrVsR8JXYahwu6UHCDe8j0IRiXYn
        NSSUF1EA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7Z2F-001exM-9A; Tue, 20 Dec 2022 09:35:43 +0000
Date:   Tue, 20 Dec 2022 09:35:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y6GB75HMEKfcGcsO@casper.infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y55WUrzblTsw6FfQ@iweiny-mobl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 17, 2022 at 03:52:50PM -0800, Ira Weiny wrote:
> > +			addr = kmap_local_folio(cn->bh->b_folio, offset);
> > +			memcpy(tmp_bh->b_data, addr, cn->bh->b_size);
> > +			kunmap_local(addr);
> 
> I think we should have a memcpy_{to|from}_folio() like we do for the pages.
> 
> Did I miss this in the earlier patch?

I've been going back-and-forth on a memcpy_(to|from)_folio().
I'm generally in favour of higher-level abstractions; I just don't
know that this is the right one.
On the one hand, we have a memcpy_(to|from)_page() already and
the folio version leads to an obvious conversion.

On the other hand, it's massively overkill for all the places I've been
looking at in reiserfs, which generally just want to touch the contents of
a single buffer_head, which is block-sized.  Obviously I have a sampling
bias since I'm looking for bh->b_page usages.  But I was thinking about
a kmap_local_buffer() for these cases.

But that doesn't solve the "What about fs block size > PAGE_SIZE"
problem that we also want to solve.  Here's a concrete example:

 static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
 {
-       struct page *page = bh->b_page;
+       struct folio *folio = bh->b_folio;
        char *addr;
        __u32 checksum;
 
-       addr = kmap_atomic(page);
-       checksum = crc32_be(crc32_sum,
-               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
-       kunmap_atomic(addr);
+       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
+
+       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
+       checksum = crc32_be(crc32_sum, addr, bh->b_size);
+       kunmap_local(addr);
 
        return checksum;
 }

I don't want to add a lot of complexity to handle the case of b_size >
PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
many people.  I'd rather have the assertion that we don't support it.
But if there's a good higher-level abstraction I'm missing here ...
