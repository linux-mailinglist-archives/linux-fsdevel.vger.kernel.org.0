Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F213D077E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 06:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhGUD2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 23:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhGUD2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:28:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F5C061574;
        Tue, 20 Jul 2021 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yFDcRMBQ9XsC1qxHn+UJuS8ZrSYlG5x1Kh5PLuKmJMM=; b=Gr1SzULnnGzEHXK6kypqZDWO7C
        vrOl03FrqcqFGSllzzDMuoBfJFUSxiSSH0+/k9RBAqED1necOey9qP7PNmQFxbPp+J/EmQXWNBsVs
        urySsGyXuGBbtFTNTdgqAhoNUorC3VIbLUGZzOvv1qcDyawykI9SR9ULh546ajG+taCy9VR5SMTxy
        ox6+JF+dIn/7xFy6QAqAaCLvJujqtgeiY01tSg2lYyToscrnL6KDotjnakXlP442fI4Caql+4Zf/b
        uTjTzMbrSO/+Kx7LyUv7b+rgDa3eLrVj7sOENRB4s+9ostzfjOIQGwLRTeB2Bp5n5IAdS86mIEm4m
        vTaFyRTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m63XI-008mBJ-8j; Wed, 21 Jul 2021 04:08:47 +0000
Date:   Wed, 21 Jul 2021 05:08:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPedzMQi+h/q0sRU@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <YPao+syEWXGhDxay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPao+syEWXGhDxay@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:44:10PM +0300, Mike Rapoport wrote:
> It seems mm_inline.h is not a part of generated API docs, otherwise
> kerneldoc would be unhappy about missing Return: description.

It isn't, but I did add mm_inline.h to Documentation as part of this
patch (thanks!) and made this change:

 /**
- * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
- * @folio: the folio to test
- *
- * Returns 1 if @folio is a regular filesystem backed page cache folio
- * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
- * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
- * swap backed folio.  Used by functions that manipulate the LRU lists,
- * to sort a folio onto the right LRU list.
+ * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
+ * @folio: The folio to test.
  *
  * We would like to get this info without a page flag, but the state
  * needs to survive until the folio is last deleted from the LRU, which
  * could be as far down as __page_cache_release.
+ *
+ * Return: An integer (not a boolean!) used to sort a folio onto the
+ * right LRU list and to account folios correctly.
+ * 1 if @folio is a regular filesystem backed page cache folio
+ * or a lazily freed anonymous folio (e.g. via MADV_FREE).
+ * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
+ * ram or swap backed folio.
  */

I wanted to turn those last two sentences into a list, but my
kernel-doc-fu abandoned me.  Feel free to submit a follow-on patch to
fix that ;-)
