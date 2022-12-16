Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9264F2B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLPUyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiLPUxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB463D34;
        Fri, 16 Dec 2022 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nZjqb/pnX3kUAIPhMQGB+kKLtRzP7goj+6JV9G39dj8=; b=vLn6w77XxVWd5b0UsMTcj9FN/Y
        5l4ix4o6FMXDXQETHjrPHgHfsKci9/ryEqP1b/+7kdR5AhQa7KhcoaOzzy7SMR+dpJaxILM0AKco+
        ilQwpLMww65c9mcsRUgAspuvTcJksBWo0GlPJ9huThpp03GzdKvWs9jzwfnqcaXPfuZdY7v74vqbr
        k6GrzJyiDpHrlZVA3CZsGnTCJNUznq3LC//OV3CJoMBmJtSCYy6zPTdSEVo5nCfE0gz0qVWzPZ5We
        XTNKDY7iZwALrAJ2Tl8d9Oxz6Pyicch1kXhnZKr0CtWmBHrsfv2wGqX856B3OHytrc6SombuwTBud
        Brlw5wkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiI-00Frfq-5r; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 5/8] reiserfs: Convert do_journal_end() to use kmap_local_folio()
Date:   Fri, 16 Dec 2022 20:53:44 +0000
Message-Id: <20221216205348.3781217-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove uses of kmap() and b_page.  Also move the set_buffer_uptodate()
call to after the memcpy() so that the memory barrier in
set_buffer_uptodate() actually ensures that the old data can't be visible.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/journal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 9ce4ec296b74..faf2f09d82e1 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -4200,21 +4200,19 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
 		/* copy all the real blocks into log area.  dirty log blocks */
 		if (buffer_journaled(cn->bh)) {
 			struct buffer_head *tmp_bh;
+			size_t offset = offset_in_folio(cn->bh->b_folio,
+							cn->bh->b_data);
 			char *addr;
-			struct page *page;
 			tmp_bh =
 			    journal_getblk(sb,
 					   SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 					   ((cur_write_start +
 					     jindex) %
 					    SB_ONDISK_JOURNAL_SIZE(sb)));
+			addr = kmap_local_folio(cn->bh->b_folio, offset);
+			memcpy(tmp_bh->b_data, addr, cn->bh->b_size);
+			kunmap_local(addr);
 			set_buffer_uptodate(tmp_bh);
-			page = cn->bh->b_page;
-			addr = kmap(page);
-			memcpy(tmp_bh->b_data,
-			       addr + offset_in_page(cn->bh->b_data),
-			       cn->bh->b_size);
-			kunmap(page);
 			mark_buffer_dirty(tmp_bh);
 			jindex++;
 			set_buffer_journal_dirty(cn->bh);
-- 
2.35.1

