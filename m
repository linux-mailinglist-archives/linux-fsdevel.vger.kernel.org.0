Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259352FAADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 21:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437716AbhARUDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437881AbhARUCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:02:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984BC061573;
        Mon, 18 Jan 2021 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=auEVqQ4zOacSI9TxWGWEHZ0yBV/Ht1F9yfenZvCalnA=; b=dPDYyqs6V+L7COqohwiVdEzWX9
        7BF6t+ikCdPodDFsSHoi3PIjxMClLL/ze0Zyd2gvXKpn74lj9c/NBnu3fgtW9thj2jDgcb5zDCX1q
        FE7ZdBSw5W0lmnrBmNZFnvvS5A7/GRnjwwd9uF3KLgAsJZfcheL7VnXDWSCYwNfr7N3zmCxXMz1MA
        JFkmwPF8cBUeKXKjSwnaQmKlYmP2fJbSwYu2dPcfyFfbMixgX3euNOFx0qv8ym7i/aNYKltMF08zX
        o3VbC0Q1SRgOEMGQV7zKKqP41pgTsLHwwtMRTZCTA8a2KKXsEOm1xr5lIS3+vEpmVq9x6Zjc/19BC
        Qq9Gfxtg==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1ahs-00DKdB-8d; Mon, 18 Jan 2021 20:01:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [PATCH 10/11] iomap: add a IOMAP_DIO_UNALIGNED flag
Date:   Mon, 18 Jan 2021 20:35:15 +0100
Message-Id: <20210118193516.2915706-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118193516.2915706-1-hch@lst.de>
References: <20210118193516.2915706-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag to signal an I/O that is not file system block aligned.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 7 +++++++
 include/linux/iomap.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 32dbbf7dd4aadb..d93019ee4c9e3e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iomap_flags |= IOMAP_NOWAIT;
 	}
 
+	if (dio_flags & IOMAP_DIO_UNALIGNED) {
+		ret = -EAGAIN;
+		if (pos >= dio->i_size)
+			goto out_free_dio;
+		iomap_flags |= IOMAP_UNALIGNED;
+	}
+
 	ret = filemap_write_and_wait_range(mapping, pos, end);
 	if (ret)
 		goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b322598dc10ec0..2fa94ec9583d0a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_UNALIGNED		(1 << 6) /* do not allocate blocks */
 
 struct iomap_ops {
 	/*
@@ -262,6 +263,13 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
 
+/*
+ * Direct I/O that is not aligned to the file system block.  Do not allocate
+ * blocks and do not zero partial blocks, fall back to the caller by returning
+ * -EAGAIN instead.
+ */
+#define IOMAP_DIO_UNALIGNED	(1 << 1)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int flags);
-- 
2.29.2

