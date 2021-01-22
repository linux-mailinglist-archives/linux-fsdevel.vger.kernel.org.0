Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5312F3008EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbhAVQih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbhAVQh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:37:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586EC06178B;
        Fri, 22 Jan 2021 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IVGed9YW98Hyb8s20QtzkmMpJX27vn/G//kLg2LEvKQ=; b=pRWwA8I9hva8/XeNhTz7gz30fT
        0QVEpwKwf77KCyAVvc5DYMroLY4ysHE2kdhNhVBv20WyyLGH2Ip+hHqU4GttdY8EILcWhBnGfGjdI
        h6RdzIb/fPmNwcnj7KArxSPj7RdC4AdqwXdEiUimugvGO4Rt0mcQhs8cNSLPle0HIPmhrHBKSslAA
        eMrG6OgLD/FEnW/Oa0fbgMm/C+aLR833SP8JW2Ke2q3djziaaHmqAkqs6HJM3u2FGx4mPjQLyWJlQ
        E+bPExVgGw9QbynFCfTUQO9KS28GGQrEKBXZjlO564zDgGOZv3sC878esSC6tMkN95X3+gUvgnTAL
        f8Tr+pNw==;
Received: from [2001:4bb8:188:1954:662b:86d3:ab5f:ac21] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zN9-000xnF-7r; Fri, 22 Jan 2021 16:33:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 10/11] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
Date:   Fri, 22 Jan 2021 17:20:42 +0100
Message-Id: <20210122162043.616755-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122162043.616755-1-hch@lst.de>
References: <20210122162043.616755-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag to signal that only pure overwrites are allowed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index be4e1e1e01e801..1a86f520de560a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 
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

