Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82E55C26F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbiF1L2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbiF1L1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:27:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025A2CDF0;
        Tue, 28 Jun 2022 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dsxZmxpcDr/FXePgtiCyPC1Y/0j2en5t6KCqa++zGIA=; b=I19DyBBV06iqqCKYxqT2Vd4TKh
        /8NJXw4BWTSC5CQTyAebr2Cu9hdG5mOMT5hyXKh2jvA5HXNCisIFEpStl+AjkXD+OCEC6uLZzXJpx
        acBYZytxLXlKOWl/Infgh/Y68VOCotu4n1GlWXARikHEao8RDXgm+1o8L/A3TZrzGIIgMQYAbR/4J
        kZGB0qaU174zVoe20N8dtsf6OsllQ3mtnrFamQ9FzmWbfBOCqNnpMZ0ytylnFbUepNvbRE2fyHFv6
        ecTA1s1ilSjb1Vby4lEX26z/jyRs8miMzTQOML3yt30EHm1PnZElrAPL0KfUb4kAT8jP5Vw3qIlGV
        nE3IqkQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o69Nc-00CFTb-S4; Tue, 28 Jun 2022 11:27:40 +0000
Date:   Tue, 28 Jun 2022 12:27:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <YrrlrMK/7pyZwZj2@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628073120.GI227878@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> So using this technique, I've discovered that there's a dirty page
> accounting leak that eventually results in fsx hanging in
> balance_dirty_pages().

Alas, I think this is only an accounting error, and not related to
the problem(s) that Darrick & Zorro are seeing.  I think what you're
seeing is dirty pages being dropped at truncation without the
appropriate accounting.  ie this should be the fix:

+++ b/mm/huge_memory.c
@@ -2443,6 +2443,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
                        __delete_from_page_cache(head + i, NULL);
                        if (shmem_mapping(head->mapping))
                                shmem_uncharge(head->mapping->host, 1);
+                       else
+                               folio_account_cleaned(page_folio(head + i));
                        put_page(head + i);
                } else if (!PageAnon(page)) {
                        __xa_store(&head->mapping->i_pages, head[i].index,

