Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F556E2E99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDOCcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 22:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDOCcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:32:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2D59D2;
        Fri, 14 Apr 2023 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKu44/7divD7drUoUvhwbQweIThwjY6Ox0fiwkad+8M=; b=jkOcp4tWYw5Dep25AqfvxqhTc4
        GTCA3dP1WQgfymf/IooR40z7GLI6DLMgaeBasOvQVaaWYSmM4lh4dDW2fLel82NDzIZ54rPbUdBzF
        xGvbNAmM5pdLlIE7sS9cxobQ9+7HClxopbNumnWDoEVWsA1Vh7b4iYmCT4yTIIRJSWCY67XcTm4rR
        OxkafstpetKZvyEgWnM6lI1eEnlJ9+3hnMMXhm9n33RXXVT/l6PuA/Feqhjg1Xp4msf5SKcdVyT4F
        VFOYthuGpidWVrHCEv54eK76yMlcnMoa8POrsHHhRZlL6Ar004znok/fKBak7xVhndNnL5tNnqVsF
        1/RCzSfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnVhi-009Hpb-FL; Sat, 15 Apr 2023 02:31:54 +0000
Date:   Sat, 15 Apr 2023 03:31:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDoMmtcwNTINAu3N@casper.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDn3XPMA024t+C1x@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:01:16PM -0700, Luis Chamberlain wrote:
> a) dynamically allocate those now
> b) do a cursory review of the users of that and prepare them
>    to grok buffer heads which are blocksize based rather than
>    PAGE_SIZE based. So we just try to kill MAX_BUF_PER_PAGE.
> 
> Without a) I think buffers after PAGE_SIZE won't get submit_bh() or lock for
> bs > PAGE_SIZE right now.

Worse, we'll overflow the array and corrupt the stack.

This one is a simple fix ...

+++ b/fs/buffer.c
@@ -2282,7 +2282,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
        struct inode *inode = folio->mapping->host;
        sector_t iblock, lblock;
-       struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+       struct buffer_head *bh, *head;
        unsigned int blocksize, bbits;
        int nr, i;
        int fully_mapped = 1;
@@ -2335,7 +2335,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
                        if (buffer_uptodate(bh))
                                continue;
                }
-               arr[nr++] = bh;
        } while (i++, iblock++, (bh = bh->b_this_page) != head);
 
        if (fully_mapped)
@@ -2353,24 +2352,27 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
        }
 
        /* Stage two: lock the buffers */
-       for (i = 0; i < nr; i++) {
-               bh = arr[i];
+       bh = head;
+       do {
                lock_buffer(bh);
                mark_buffer_async_read(bh);
-       }
+               bh = bh->b_this_page;
+       } while (bh != head);
 
        /*
         * Stage 3: start the IO.  Check for uptodateness
         * inside the buffer lock in case another process reading
         * the underlying blockdev brought it uptodate (the sct fix).
         */
-       for (i = 0; i < nr; i++) {
-               bh = arr[i];
+       bh = head;
+       do {
                if (buffer_uptodate(bh))
                        end_buffer_async_read(bh, 1);
                else
                        submit_bh(REQ_OP_READ, bh);
-       }
+               bh = bh->b_this_page;
+       } while (bh != head);
+
        return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);

