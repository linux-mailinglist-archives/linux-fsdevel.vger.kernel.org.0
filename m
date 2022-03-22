Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205BC4E43B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiCVP7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiCVP7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D67007F;
        Tue, 22 Mar 2022 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ssmYmdZc2lIu8cl4pE1bm9BjUj1Pj2cPdjbbeERwfbM=; b=O5AYPQxw72SC3KQnFytG1XgKxv
        FPLkURMISnMO7hGUGM8LTiARCj1/HtS1pGcE2x05jzj/wQwX3wTR1Voy8Fpd5X1l9KaaiqSkJSQBz
        cTAtCJKdyQJujPHq82LYq8xewJwjWX7ej5OQpNVeL6fZsNedt6zdYbJvo+BXr2PBjK7G4/H4xCdnc
        s5IL8bxI6ZBjq+iLQEphzRBldmZqfsRKb9sKQ17vvjLpOYhpmlKNDi3fEOVR9O1oHaEDiM0bH2I4E
        9+pAwdQtNRuG4AFZVYpCOo65qULODai7l8OPfM+cO9SACBDl/gWvs1Sv1GeSPo3si1j0MFjWMmQ35
        y+TaFQkg==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsy-00Bb2q-Nw; Tue, 22 Mar 2022 15:57:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/40] iomap: add a new ->iomap_iter operation
Date:   Tue, 22 Mar 2022 16:55:57 +0100
Message-Id: <20220322155606.1267165-32-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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

This new operation combines ->iomap_beging, ->iomap_end and the actual
advancing of the iter into a new operation.  Matthew Wilcox originally
proposed this kind of interface to eventually allow inlining most of
the iteration and avoid an indirect call.  But it also allows for more
control in the file system to e.g. keep a little more state over
multiple iterations, which is something we'll need to improve the
btrfs direct I/O code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/iter.c       | 13 +++++++++----
 include/linux/iomap.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index a1c7592d2aded..0bb22f2586e77 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -7,7 +7,7 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
-static inline int iomap_iter_advance(struct iomap_iter *iter)
+int iomap_iter_advance(struct iomap_iter *iter)
 {
 	/* handle the previous iteration (if any) */
 	if (iter->iomap.length) {
@@ -27,8 +27,9 @@ static inline int iomap_iter_advance(struct iomap_iter *iter)
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 	return 1;
 }
+EXPORT_SYMBOL_GPL(iomap_iter_advance);
 
-static inline void iomap_iter_done(struct iomap_iter *iter)
+void iomap_iter_done(struct iomap_iter *iter)
 {
 	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
 	WARN_ON_ONCE(iter->iomap.length == 0);
@@ -38,6 +39,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	if (iter->srcmap.type != IOMAP_HOLE)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
 }
+EXPORT_SYMBOL_GPL(iomap_iter_done);
 
 /**
  * iomap_iter - iterate over a ranges in a file
@@ -58,10 +60,13 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	int ret;
 
+	if (ops->iomap_iter)
+		return ops->iomap_iter(iter);
+
 	if (iter->iomap.length && ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
-				iter->processed > 0 ? iter->processed : 0,
-				iter->flags, &iter->iomap);
+				iomap_processed(iter), iter->flags,
+				&iter->iomap);
 		if (ret < 0 && !iter->processed)
 			return ret;
 	}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3cc5ee01066d0..494f530aa8bf8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -14,6 +14,7 @@ struct address_space;
 struct fiemap_extent_info;
 struct inode;
 struct iomap_dio;
+struct iomap_iter;
 struct iomap_writepage_ctx;
 struct iov_iter;
 struct kiocb;
@@ -148,6 +149,8 @@ struct iomap_page_ops {
 #endif /* CONFIG_FS_DAX */
 
 struct iomap_ops {
+	int (*iomap_iter)(struct iomap_iter *iter);
+
 	/*
 	 * Return the existing mapping at pos, or reserve space starting at
 	 * pos for up to length, as long as we can do it as a single mapping.
@@ -208,6 +211,17 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
 	return min(iter->len, end - iter->pos);
 }
 
+/**
+ * iomap_length - amount of data processed by the previous iomap iteration
+ * @iter: iteration structure
+ */
+static inline u64 iomap_processed(const struct iomap_iter *iter)
+{
+	if (iter->processed <= 0)
+		return 0;
+	return iter->processed;
+}
+
 /**
  * iomap_iter_srcmap - return the source map for the current iomap iteration
  * @i: iteration structure
@@ -224,6 +238,9 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+int iomap_iter_advance(struct iomap_iter *iter);
+void iomap_iter_done(struct iomap_iter *iter);
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-- 
2.30.2

