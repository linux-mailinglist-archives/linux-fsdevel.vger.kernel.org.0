Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D3A55CD22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbiF1LcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbiF1Lb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:31:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EE2E693;
        Tue, 28 Jun 2022 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LHmUJFtDqFG/TnygpQr9QZ7x+BR8FiYTOOeMbaSiyrE=; b=hLpD8fYq8VTbM191ROYc4ygG2N
        NX6G9oz89GXYNbnbWLDzTleQ+i4rwD5nX9uPV/xn1asyhIbiCgUC3dH3KhyM541+nBHA4WWjI/RRF
        XMvWCW2jDgiA49M/naqW5xtwKuHzz8yREeXGrLeU6KTuVaZUbNelfIHnFuSMZcc6J0O7Zm8aHCoG6
        cP174iuaEA80kB7dogLX8QdMWj3oyNYWAxiQki5O9kt+T71+TMGDyZTcvg4iJEcWD6hUsEbyTkZVz
        T/HA2zoNx0CqSOr5TJzZYdHOAveb9xwiQXlFN2PpmSYGDw9eo5KgHDX+zcAzVYGd6C0so4kwxS0Xp
        fY7uMeVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o69Rj-00CFdG-9V; Tue, 28 Jun 2022 11:31:55 +0000
Date:   Tue, 28 Jun 2022 12:31:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <Yrrmq4hmJPkf5V7s@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrlrMK/7pyZwZj2@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > So using this technique, I've discovered that there's a dirty page
> > accounting leak that eventually results in fsx hanging in
> > balance_dirty_pages().
> 
> Alas, I think this is only an accounting error, and not related to
> the problem(s) that Darrick & Zorro are seeing.  I think what you're
> seeing is dirty pages being dropped at truncation without the
> appropriate accounting.  ie this should be the fix:

Argh, try one that actually compiles.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..0553ae90509f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -18,6 +18,7 @@
 #include <linux/shrinker.h>
 #include <linux/mm_inline.h>
 #include <linux/swapops.h>
+#include <linux/backing-dev.h>
 #include <linux/dax.h>
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
@@ -2443,6 +2444,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			__delete_from_page_cache(head + i, NULL);
 			if (shmem_mapping(head->mapping))
 				shmem_uncharge(head->mapping->host, 1);
+			else
+				folio_account_cleaned(page_folio(head + i),
+					inode_to_wb(folio->mapping->host));
 			put_page(head + i);
 		} else if (!PageAnon(page)) {
 			__xa_store(&head->mapping->i_pages, head[i].index,
