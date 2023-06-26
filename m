Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1080D73E6A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjFZRg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjFZRgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4F2968;
        Mon, 26 Jun 2023 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QSocI68SnxGROAi6KnsuaQtLU/TknPAXfYvMKgd/IsY=; b=duXZv5WH1H74olkGLz6lqhcWMg
        ycaQBDHoe0qUqHIgblnjFaUpUKwN8MGzm4avigX/QCt4cNL3uCwpYv+DTycTDK9TSw8XUkK7m8QwG
        Xx1hLohNCFLwjChZBPCwmdd3SfdAwlTEou4IxynYnkaQNaTVGLaSjbkiAj7mOVuqvbl+qv5P/w3Xv
        UEdx5tcwSg83Nx0/nnHphNfbPqk2EAzCNqIAfrFYAJqBhFMOAYjutv1w4XrJSjWAr7t9LOzNITzdY
        gijCkd6XiDvCxOfwKpwcTEonef52AtZir2Poqu6PPz0gLJFB0XwmCAgF1n0UVKH9Ow2NVWKicFnsA
        OfW3NJTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vUx-5v; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 00/12] Convert write_cache_pages() to an iterator
Date:   Mon, 26 Jun 2023 18:35:09 +0100
Message-Id: <20230626173521.459345-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Howells doesn't like the indirect function call imposed by
write_cache_pages(), so refactor it into an iterator.  I took the
opportunity to add the ability to iterate a folio_batch without having
an external variable.

This is against next-20230623.  If you try to apply it on top of a tree
which doesn't include the pagevec removal series, IT WILL CRASH because
it won't reinitialise folio_batch->i and the iteration will index out
of bounds.

I have a feeling the 'done' parameter could have a better name, but I
can't think what it might be.

Matthew Wilcox (Oracle) (12):
  writeback: Factor out writeback_finish()
  writeback: Factor writeback_get_batch() out of write_cache_pages()
  writeback: Factor should_writeback_folio() out of write_cache_pages()
  writeback: Simplify the loops in write_cache_pages()
  pagevec: Add ability to iterate a queue
  writeback: Use the folio_batch queue iterator
  writeback: Factor writeback_iter_init() out of write_cache_pages()
  writeback: Factor writeback_get_folio() out of write_cache_pages()
  writeback: Factor writeback_iter_next() out of write_cache_pages()
  writeback: Add for_each_writeback_folio()
  iomap: Convert iomap_writepages() to use for_each_writeback_folio()
  writeback: Remove a use of write_cache_pages() from do_writepages()

 fs/iomap/buffered-io.c    |  14 +-
 include/linux/pagevec.h   |  18 +++
 include/linux/writeback.h |  22 ++-
 mm/page-writeback.c       | 310 +++++++++++++++++++++-----------------
 4 files changed, 216 insertions(+), 148 deletions(-)

-- 
2.39.2

