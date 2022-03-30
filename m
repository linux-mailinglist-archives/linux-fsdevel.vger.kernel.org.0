Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFD4EC70D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347240AbiC3OvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FD16595
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PQ4ZfSygxrY40epZHhBmj5o3QfZh/Bq14OxqrPSTtkI=; b=qqLtKzMT3qImUeCS5REwZ1XDwT
        8UNVARpfKQBmTHEuPvTx6gqWSoL3CkR6qRs4dlLCBg9KLqyMJvjNSAamMC0K/T9CCO3Tu/P0DnhJS
        TIByAqGkkYVLduXO9KIgT0AzLbDaGAE4WGcrLtfxAQtumGpeufHya+kuUq08quLwbCcsDKyrGkzox
        0F1Ogn5mg4BQqyfPJddeHYq+0eXfNh9Lksb0JslEg0u5l7MxA/eXYI5YgHvNt5bQf53ckWUzADZTz
        5hfkH3sEhivDmCjweqI9veZWLi9NovbbYCyCtqS/mcSCj4VQbPDotb5UxShCdp2HaQVlQpzGh7jZW
        HBLG0wRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDC-7k; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/12] fs, net: Move read_descriptor_t to net.h
Date:   Wed, 30 Mar 2022 15:49:23 +0100
Message-Id: <20220330144930.315951-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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

fs.h has no more need for this typedef; networking is now the sole user
of the read_descriptor_t.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h  | 19 -------------------
 include/linux/net.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7588d3a0ced8..8ff28939de60 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -338,25 +338,6 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 	return kiocb->ki_complete == NULL;
 }
 
-/*
- * "descriptor" for what we're up to with a read.
- * This allows us to use the same read code yet
- * have multiple different users of the data that
- * we read from a file.
- *
- * The simplest case just copies the data to user
- * mode.
- */
-typedef struct {
-	size_t written;
-	size_t count;
-	union {
-		char __user *buf;
-		void *data;
-	} arg;
-	int error;
-} read_descriptor_t;
-
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
diff --git a/include/linux/net.h b/include/linux/net.h
index ba736b457a06..12093f4db50c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -125,6 +125,25 @@ struct socket {
 	struct socket_wq	wq;
 };
 
+/*
+ * "descriptor" for what we're up to with a read.
+ * This allows us to use the same read code yet
+ * have multiple different users of the data that
+ * we read from a file.
+ *
+ * The simplest case just copies the data to user
+ * mode.
+ */
+typedef struct {
+	size_t written;
+	size_t count;
+	union {
+		char __user *buf;
+		void *data;
+	} arg;
+	int error;
+} read_descriptor_t;
+
 struct vm_area_struct;
 struct page;
 struct sockaddr;
-- 
2.34.1

