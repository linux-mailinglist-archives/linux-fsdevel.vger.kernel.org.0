Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF591F5C82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgFJUOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgFJUNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F928C0085C3;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nogVZwCGMHTUnccVf6su9Crc41Rj8q29sZmEfeg+55U=; b=B6YqyDI1W81riSbux+Vqd6NQmq
        cAoL/rxz0dLAReAf6MspJHD1x1Gb9CYEfTcjhnFjQuAWU+a3aOM3Gq3E1DLA7K2peW0+M7zBhIOyX
        K76vx756jdjTDWtlW56VZupLDFsFQl2sC34HjPV/uiS1BmthqJmt9VWcNr+Y6FMNHCDGgGX/pLFEn
        mB8R1MKvYrmnYTPzNMk26lbJByeJngAZIbQ+x3SXVVsQOp1kUYuvDQivzNOKgSzS2Fk5dHQ8iguRf
        0JRv07onWNjVa5ORY11q3sgv7cjIsI/nzzEHzFcjzgT8oPsexNajzCPyVVAAsypE9MOe8Qx39LZKG
        uGnzvRWQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003Xy-5H; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 46/51] mm: Add DEFINE_READAHEAD
Date:   Wed, 10 Jun 2020 13:13:40 -0700
Message-Id: <20200610201345.13273-47-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Allow for a more concise definition of a struct readahead_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 +++++++
 mm/readahead.c          | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8455a3e16900..77c20da5ae99 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -759,6 +759,13 @@ struct readahead_control {
 	unsigned int _batch_count;
 };
 
+#define DEFINE_READAHEAD(rac, f, m, i)					\
+	struct readahead_control rac = {				\
+		.file = f,						\
+		.mapping = m,						\
+		._index = i,						\
+	}
+
 /**
  * readahead_page - Get the next page to read.
  * @rac: The current readahead request.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..2126a2754e22 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -179,11 +179,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 {
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	struct readahead_control rac = {
-		.mapping = mapping,
-		.file = file,
-		._index = index,
-	};
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
-- 
2.26.2

