Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37CA6E2EDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 05:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDODoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:44:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37695270;
        Fri, 14 Apr 2023 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IA9ip5bWB1ooOWtdktRveDQHQwdcZUthNMzBra0HynA=; b=rNQjyH4XIZodG7Hs4L6O1x68Rm
        USXE+8fk55T0Ag6HiXuxyRajtUaXOtU0e6BuW+o44iwW6qbprtyX4VpOO6BfWqqJ1pmfGGDaTrI8Q
        pfpZUD3QYkEGx+dqRsCcuVmzNeVCmvwBXoqLzuCgWlRLrsXMWH9XzCOYqEbD4ZobcNKe1THCQ1WBx
        Hw4sEYyEEr4GbwrkfpFVPDXdcnDGGZBWtNpU52M2W8B807/Y15m3PWyx8KkajV9T9HbPW35qn6MTR
        l7F1n18wb2km4XiEDvrsmvA+e6BXQ2hVgS9Y479iJ0YDwsVNBi6XHcxQ+eTIBE3i36fMgZbKAKuue
        A6gPJwTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnWpq-009KMF-CR; Sat, 15 Apr 2023 03:44:22 +0000
Date:   Sat, 15 Apr 2023 04:44:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDodlnm2nvYxbvR4@casper.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:24:56PM -0700, Luis Chamberlain wrote:
> I thought of that but I saw that the loop that assigns the arr only
> pegs a bh if we don't "continue" for certain conditions, which made me
> believe that we only wanted to keep on the array as non-null items which
> meet the initial loop's criteria. If that is not accurate then yes,
> the simplication is nice!

Uh, right.  A little bit more carefully this time ... how does this
look?

diff --git a/fs/buffer.c b/fs/buffer.c
index 5e67e21b350a..dff671079b02 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2282,7 +2282,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head;
 	unsigned int blocksize, bbits;
 	int nr, i;
 	int fully_mapped = 1;
@@ -2335,7 +2335,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			if (buffer_uptodate(bh))
 				continue;
 		}
-		arr[nr++] = bh;
+		nr++;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (fully_mapped)
@@ -2352,25 +2352,29 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		return 0;
 	}
 
-	/* Stage two: lock the buffers */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
+	/*
+	 * Stage two: lock the buffers.  Recheck the uptodate flag under
+	 * the lock in case somebody else brought it uptodate first.
+	 */
+	bh = head;
+	do {
+		if (buffer_uptodate(bh))
+			continue;
 		lock_buffer(bh);
+		if (buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			continue;
+		}
 		mark_buffer_async_read(bh);
-	}
+	} while ((bh = bh->b_this_page) != head);
 
-	/*
-	 * Stage 3: start the IO.  Check for uptodateness
-	 * inside the buffer lock in case another process reading
-	 * the underlying blockdev brought it uptodate (the sct fix).
-	 */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
+	/* Stage 3: start the IO */
+	bh = head;
+	do {
+		if (buffer_async_read(bh))
 			submit_bh(REQ_OP_READ, bh);
-	}
+	} while ((bh = bh->b_this_page) != head);
+
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);


I do wonder how much it's worth doing this vs switching to non-BH methods.
I appreciate that's a lot of work still.
