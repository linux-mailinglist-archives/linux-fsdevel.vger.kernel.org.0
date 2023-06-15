Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801ED730FC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbjFOGuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbjFOGuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:50:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB1271E;
        Wed, 14 Jun 2023 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ujp7Cb4Puhv9syHzyPpb5VxEgoGi5+oIVsk88bBU634=; b=G8S9VWaWdBMGIzQTo9cXlWrKeR
        HIDnnr0NFb7vncLcS8cYSVpy0pWSz0Imtr+VbRB6mVoWUXBxu0TrZEcXSiQAjWS8bY9+4MjjtuQ8y
        aAA9HR463cAUX7m8pppWXJZ0sOWvv271853IoYlR5VCZbDZ6rPZ9KLTQyT+B8kzfzZQfOBhgs+NkY
        tJONUQEzEcKvr6hGIQjgQQbw4qaWi00tK7ziFP3l8fmsoMgTHOyQFex6tpphFAfnrZy5TUAGwI+v6
        oZdmOEZl6uPwM04nO9mJPd7ZgrYBT2U8QA9uMufJ98RqhXgsuAvLCSVbr40vGxS9MxmuJBaCxTKTY
        wXojkK2Q==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gn4-00DuBu-2X;
        Thu, 15 Jun 2023 06:49:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] md: make bitmap file support optional
Date:   Thu, 15 Jun 2023 08:48:39 +0200
Message-Id: <20230615064840.629492-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The support for write intent bitmaps in files on an external files in md
is a hot mess that abuses ->bmap to map file offsets into physical device
objects, and also abuses buffer_heads in a creative way.

Make this code optional so that MD can be built into future kernels
without buffer_head support, and so that we can eventually deprecate it.

Note this does not affect the internal bitmap support, which has none of
the problems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/Kconfig     | 10 ++++++++++
 drivers/md/md-bitmap.c | 15 +++++++++++++++
 drivers/md/md.c        |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b0a22e99bade37..9712ab9bcba52e 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -50,6 +50,16 @@ config MD_AUTODETECT
 
 	  If unsure, say Y.
 
+config MD_BITMAP_FILE
+	bool "MD bitmap file support"
+	default y
+	help
+	  If you say Y here, support for write intent bitmaps in files on an
+	  external file system is enabled.  This is an alternative to the internal
+	  bitmaps near the MD superblock, and very problematic code that abuses
+	  various kernel APIs and can only work with files on a file system not
+	  actually sitting on the MD device.
+
 config MD_LINEAR
 	tristate "Linear (append) mode (deprecated)"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index ed402f4dad182d..1e29088b1f081a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -295,6 +295,7 @@ static void write_sb_page(struct bitmap *bitmap, unsigned long pg_index,
 
 static void md_bitmap_file_kick(struct bitmap *bitmap);
 
+#ifdef CONFIG_MD_BITMAP_FILE
 static void write_file_page(struct bitmap *bitmap, struct page *page, int wait)
 {
 	struct buffer_head *bh = page_buffers(page);
@@ -408,6 +409,20 @@ static int read_file_page(struct file *file, unsigned long index,
 		       ret);
 	return ret;
 }
+#else /* CONFIG_MD_BITMAP_FILE */
+static void write_file_page(struct bitmap *bitmap, struct page *page, int wait)
+{
+}
+static int read_file_page(struct file *file, unsigned long index,
+		struct bitmap *bitmap, unsigned long count, struct page *page)
+{
+	return -EIO;
+}
+static void free_buffers(struct page *page)
+{
+	put_page(page);
+}
+#endif /* CONFIG_MD_BITMAP_FILE */
 
 /*
  * bitmap file superblock operations
diff --git a/drivers/md/md.c b/drivers/md/md.c
index cf3733c90c47ed..c9fcefaf9c073b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7020,6 +7020,13 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 
 		if (mddev->bitmap || mddev->bitmap_info.file)
 			return -EEXIST; /* cannot add when bitmap is present */
+
+		if (!IS_ENABLED(CONFIG_MD_BITMAP_FILE)) {
+			pr_warn("%s: bitmap files not supported by this kernel\n",
+				mdname(mddev));
+			return -EINVAL;
+		}
+
 		f = fget(fd);
 
 		if (f == NULL) {
-- 
2.39.2

