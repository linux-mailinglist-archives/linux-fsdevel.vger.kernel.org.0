Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF332F35CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbhALQaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbhALQaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:30:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95CC061794;
        Tue, 12 Jan 2021 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bs34eYkajnii5whqNunURL3Ej5X7Vn/vh7t+jlaI+S8=; b=cbg015b42ZWdNiQZnLavnkXYDB
        2V2oLkQOUcXKEJSXf8E6vDq0zVkajQnQ2JpO47pr7J2JS3U7eBsEzIhU2zO/4YYCHX8YNGGTZ34YS
        WVWUgvd629+NQuhOcm1oV039LttmGr6+79s0b4cDvE+hrfjkA3tU02xo+5X3LAp+fmm/TjuKi/pgf
        WfFa8T0beF3x6pbxQfCTwJHGe0ie4gSb5lgT+uc5TaasmTpnvUeRNiCpKprBUFzmGIbxKda7gGh7/
        tQuPsAZOLDrxr1kZzK8zeCf9F7Z7w68RpijX2KckdwOYF3ppFt5Zlar6zvbsy3Z2kM9K9pvarKPiP
        3kUrYYVQ==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMXg-0052I3-Mt; Tue, 12 Jan 2021 16:29:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
Date:   Tue, 12 Jan 2021 17:26:15 +0100
Message-Id: <20210112162616.2003366-10-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112162616.2003366-1-hch@lst.de>
References: <20210112162616.2003366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag to request that the iomap instances do not allocate blocks
by translating it to another new IOMAP_NOALLOC flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 2 ++
 include/linux/iomap.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 96dc72debc4b79..a01f1d182685b4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -436,6 +436,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (is_sync_kiocb(iocb))
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
+	if (dio_flags & IOMAP_DIO_NOALLOC)
+		flags |= IOMAP_NOALLOC;
 
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e7865654dd0dca..a92890d5dc6799 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_NOALLOC		(1 << 6) /* do not allocate blocks */
 
 struct iomap_ops {
 	/*
@@ -257,6 +258,7 @@ struct iomap_dio_ops {
 };
 
 #define IOMAP_DIO_FORCE_WAIT	(1 << 0)	/* force waiting for I/O */
+#define IOMAP_DIO_NOALLOC	(1 << 1)	/* do not allocate blocks */
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-- 
2.29.2

