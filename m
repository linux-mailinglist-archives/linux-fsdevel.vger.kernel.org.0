Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7903AA105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFPQRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPQRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:17:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C13C061574;
        Wed, 16 Jun 2021 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UYgA6mhHKU9oeMzNXSF0VSiZSgYXxS5DH1D4fnF0pG8=; b=vqB3tzg46j8/37tBCf9piyoUIa
        q6XMZHfiyFA7RruP1A6BnJZKnMM48MojXpQUuME5QEeRbj0Nydxt8wDiuLXQsXfcnjRyWxwSlJFBH
        7ucNtOJ25H1OR+WBZN4Lw46euVTkLe7U4yDLYJlBPCOVMRw1qxR7Bet2jlPy0yRAUntyppskTcxCr
        aT4q9tdbRbzPTcrbwMIr1tXUQDy1tq1uQ/DIcm7sdCcsya9yag0VUAXQHbtBUfHOOoSfkAndIsXV9
        Q/kuUVVongqTiiTzNKQ9G55BTD7jU9NybS0c1uGSLY/A/48y5hc8aiFZ/iHm63c0oywP5POslfKo3
        ABo+UA8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltYBL-008F14-TZ; Wed, 16 Jun 2021 16:14:27 +0000
Date:   Wed, 16 Jun 2021 17:14:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/writeback: Move __set_page_dirty() to core mm
Message-ID: <YMojXxiyYTRaQvJs@casper.infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162342.1669332-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:23:37PM +0100, Matthew Wilcox (Oracle) wrote:
> -/*
> - * Mark the page dirty, and set it dirty in the page cache, and mark the inode
> - * dirty.
> - *
> - * If warn is true, then emit a warning if the page is not uptodate and has
> - * not been truncated.
> - *
> - * The caller must hold lock_page_memcg().
> - */

Checking against my folio tree, I found a bit of extra documentation
that I had added and didn't make it into this submission.  Let me know
if it's useful and if so I can submit it as a fixup patch:

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 73b937955cc1..2072787d9b44 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2466,7 +2466,11 @@ void account_page_cleaned(struct page *page, struct addre
ss_space *mapping,
  * If warn is true, then emit a warning if the page is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().
+ * The caller must hold lock_page_memcg().  Most callers have the page
+ * locked.  A few have the page blocked from truncation through other
+ * means (eg zap_page_range() has it mapped and is holding the page table
+ * lock).  This can also be called from mark_buffer_dirty(), which I
+ * cannot prove is always protected against truncate.
  */
 void __set_page_dirty(struct page *page, struct address_space *mapping,
                             int warn)


... it's a bit "notes to self", so perhaps someone can clean it up.
In particular, someone who knows the buffer code better than I do can
prove that mark_buffer_dirty() is always protected against truncate.
