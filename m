Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF1CD318
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfJFPsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 11:48:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfJFPsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YrSIkJAZEX2PC4bhPUc4ArtWFXnLR/JwWtyPm3VgUHk=; b=GDO12pXqHo4n8DYufaCeViyJVS
        1K4UxstgVHj049tTnlzYpTHkkiLfS6YqeYeZ0UWMzmcvvusxRWtPM2tBunXdlTizIIOWNkR8vf5RZ
        WgzYxTCS6T3Gnaz7EU43yzG8JI+tySgeuaCPPkSxSL0/EM9WO1Uov+snS7zOu+DfsD5YPGAgyNdZM
        FURxWnLtM0+O2CHFNNAbMrD8MjC5zJgSTyvh5dvc9gOOj4RW3gXdv+NnA4Sdbs52tCvrkJUMGkEDb
        +gbM737pVLmDEXuH0fcRow2JdPl4dwlW7XefcYgaU+JBlzjVyRI0UF6hok+1+/ldn00T1ivRJhR34
        DzFns0Tg==;
Received: from [2001:4bb8:18c:4d4a:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8mA-0008UV-1X; Sun, 06 Oct 2019 15:48:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 11/11] iomap: move struct iomap_page out of iomap.h
Date:   Sun,  6 Oct 2019 17:46:08 +0200
Message-Id: <20191006154608.24738-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191006154608.24738-1-hch@lst.de>
References: <20191006154608.24738-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all the writepage code is in the iomap code there is no
need to keep this structure public.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 17 +++++++++++++++++
 include/linux/iomap.h  | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4132c0cccb0a..35c93f72c172 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -21,6 +21,23 @@
 
 #include "../internal.h"
 
+/*
+ * Structure allocated for each page when block size < PAGE_SIZE to track
+ * sub-page uptodate status and I/O completions.
+ */
+struct iomap_page {
+	atomic_t		read_count;
+	atomic_t		write_count;
+	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+};
+
+static inline struct iomap_page *to_iomap_page(struct page *page)
+{
+	if (page_has_private(page))
+		return (struct iomap_page *)page_private(page);
+	return NULL;
+}
+
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0b399718c387..46ce730b1590 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -134,23 +134,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
 		iomap_actor_t actor);
 
-/*
- * Structure allocate for each page when block size < PAGE_SIZE to track
- * sub-page uptodate status and I/O completions.
- */
-struct iomap_page {
-	atomic_t		read_count;
-	atomic_t		write_count;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
-};
-
-static inline struct iomap_page *to_iomap_page(struct page *page)
-{
-	if (page_has_private(page))
-		return (struct iomap_page *)page_private(page);
-	return NULL;
-}
-
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-- 
2.20.1

