Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B574C3575CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbhDGUVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbhDGUVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:21:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5397C061761
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X0KGs20hHUbeK3N6OG91vwGL9l1jfAcytim+Ealea2g=; b=UWF10tkFkeUUutVHHjQyFGJkgJ
        Shx5QoJ8hJ1Q0CTq/DIMo/0q+nWoJUwF0QGKWdnk2lCO01Uxtz2q7MW41V+mZKyIBVE7LOUcL8kPO
        lroMnafYpgrnFsNH3NRBrYpI+c+ge23d8yrBU3cL+vbCluxVNNZEgdwKd++rGfsXfJKWZ6gf1x9gH
        ifXHsS1B+4qBymL+4NNSHyxdeGGOuKov4HiguweJMfVXDU1G7XJdXuHbvSnzOFzkZD9Rg3Yl2ni+A
        /op70yOfonFpHJDFdbw5dW31KHjBlwd+kEpIHO5xhIYIKTr5dvtbxLtqckZs6rty1VfmNg5TCQtNX
        +Zg8TEow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUEeW-00F26Y-NV; Wed, 07 Apr 2021 20:20:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fs: Document file_ra_state
Date:   Wed,  7 Apr 2021 21:18:56 +0100
Message-Id: <20210407201857.3582797-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407201857.3582797-1-willy@infradead.org>
References: <20210407201857.3582797-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn the comments into kernel-doc and improve the wording slightly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3fbb98126248..8c347fe9783d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -889,18 +889,22 @@ struct fown_struct {
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
-/*
- * Track a single file's readahead state
+/**
+ * struct file_ra_state - Track a file's readahead state.
+ * @start: Where the most recent readahead started.
+ * @size: Number of pages read in the most recent readahead.
+ * @async_size: Start next readahead when this many pages are left.
+ * @ra_pages: Maximum size of a readahead request.
+ * @mmap_miss: How many mmap accesses missed in the page cache.
+ * @prev_pos: The last byte in the most recent read request.
  */
 struct file_ra_state {
-	pgoff_t start;			/* where readahead started */
-	unsigned int size;		/* # of readahead pages */
-	unsigned int async_size;	/* do asynchronous readahead when
-					   there are only # of pages ahead */
-
-	unsigned int ra_pages;		/* Maximum readahead window */
-	unsigned int mmap_miss;		/* Cache miss stat for mmap accesses */
-	loff_t prev_pos;		/* Cache last read() position */
+	pgoff_t start;
+	unsigned int size;
+	unsigned int async_size;
+	unsigned int ra_pages;
+	unsigned int mmap_miss;
+	loff_t prev_pos;
 };
 
 /*
-- 
2.30.2

