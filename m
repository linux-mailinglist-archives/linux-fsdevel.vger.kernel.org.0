Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346272FE603
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhAUJMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 04:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbhAUJMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:12:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1172C061575;
        Thu, 21 Jan 2021 01:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9o83V42vu6yUi+o2Wb0ZeVDwO25X9PTxXcCtlcoTFTU=; b=Iw8d5ugekNLJpkoQuGlh61OR9M
        velsn9W270MQY2pED2ZJWoostwyn9DMNIuUvgF/eulNd4NVQVgIJ2pM1MDsOddZCZtbU+qihjIDVh
        9fRhshEgfFwdiLIKsJ9OgEnGvFq5M1rCM5bK+ehqwVLwxKj4K4PmuRfo3gVjA0n9IhirrBLtzXaLp
        KOAw3z0dq9+QzJf43IzyGJDmc6uYgvtVhDZkzVIptScgh8ClI5LquvMqRnj+7WPFtGXQrMNr3HJ15
        CLV9FStwGQGpM7UUAnRJuT5cpT64y5/mTCMkoeN6TmniLqeX/Jn5GkHmcu5W8hbf6BWSN7Fn974e/
        ABdIE7Tw==;
Received: from [2001:4bb8:188:1954:d5b3:2657:287:e45f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Vzj-00Gqhw-6R; Thu, 21 Jan 2021 09:11:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [PATCH 10/11] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
Date:   Thu, 21 Jan 2021 09:59:05 +0100
Message-Id: <20210121085906.322712-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121085906.322712-1-hch@lst.de>
References: <20210121085906.322712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag to signal an only pure overwrites are allowed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 7 +++++++
 include/linux/iomap.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 947343730e2c93..65d32364345d22 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iomap_flags |= IOMAP_NOWAIT;
 	}
 
+	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
+		ret = -EAGAIN;
+		if (pos >= dio->i_size || pos + count > dio->i_size)
+			goto out_free_dio;
+		iomap_flags |= IOMAP_OVERWRITE_ONLY;
+	}
+
 	ret = filemap_write_and_wait_range(mapping, pos, end);
 	if (ret)
 		goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index be4e1e1e01e801..cfa20afd7d5b87 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* purely overwrites allowed */
 
 struct iomap_ops {
 	/*
@@ -262,6 +263,13 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
 
+/*
+ * Do not allocate blocks or zero partial blocks, but instead fall back to
+ * the caller by returning -EAGAIN.  Used to optimize direct I/O writes that
+ * are not aligned to the file system block size.
+  */
+#define IOMAP_DIO_OVERWRITE_ONLY	(1 << 1)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
-- 
2.29.2

