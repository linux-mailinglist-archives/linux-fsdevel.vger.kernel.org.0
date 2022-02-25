Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B644C3C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 04:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiBYD2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 22:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYD2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:28:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DC63BCC
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 19:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/iBllfX+pxhtCQ1NmE+ODFZ0uxqZ7F38CrDW8I3Tbs=; b=o0fr0YVRVSqN23KLwGLhxP1lDt
        w9nm8G83S55Zwe2f6Ui0zdhuqVlfnEqoNjddvs7eSDsKQl6FvzNgaMbZ3GLNwokPK/h63sV2mxRAR
        Kc627x1+F3qqMLSJ+eIWX/dLOqisC82Wu0DAQCZ88k3YLLWKdC1PNYMTo169V6ewf0wheKI6ARMlZ
        seWeEqH8D1ZJ72J+tyLoXsfvZlAdYUQyR9I2TQduqUUcOAoTYA7IjzlKxe1TmLyowpHLUUxg/5xw3
        8TI9uK1r0qEW72lswk+AyqYt0u5FIRCItp/+6uNLq11iGtjVa6kt7+/UX65Wc5aKnttmySjZ1A1Mq
        +2KxXUfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNRGo-005QNm-FO; Fri, 25 Feb 2022 03:27:50 +0000
Date:   Fri, 25 Feb 2022 03:27:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/10] mm/truncate: Replace page_mapped() call in
 invalidate_inode_page()
Message-ID: <YhhMts5lZJjH3APL@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-5-willy@infradead.org>
 <YhgxXaDKX415lBlW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhgxXaDKX415lBlW@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:31:09AM +0000, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 08:00:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > folio_mapped() is expensive because it has to check each page's mapcount
> > field.  A cheaper check is whether there are any extra references to
> > the page, other than the one we own and the ones held by the page cache.
> > The call to remove_mapping() will fail in any case if it cannot freeze
> > the refcount, but failing here avoids cycling the i_pages spinlock.
> 
> This is the patch that's causing ltp's readahead02 test to break.
> Haven't dug into why yet, but it happens without large folios, so
> I got something wrong.

This fixes it:

+++ b/mm/truncate.c
@@ -288,7 +288,8 @@ int invalidate_inode_page(struct page *page)
        if (folio_test_dirty(folio) || folio_test_writeback(folio))
                return 0;
        /* The refcount will be elevated if any page in the folio is mapped */
-       if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
+       if (folio_ref_count(folio) >
+                       folio_nr_pages(folio) + 1 + folio_has_private(folio))
                return 0;
        if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
                return 0;

Too late for today's -next, but I'll push it out tomorrow.
