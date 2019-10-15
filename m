Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014A5D7A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfJOPoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:44:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbfJOPoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mr41y1LsPmV/Aa5P6Nreo6G927X7sBwSFPq0Rl3lz2Y=; b=UQ7AFX3Fwrd+C2k1E/INz+eeqC
        SevBl7fm5BPPKcpB9SjOtbKHDvCx4AYAu2DiRSMZN686KpRcUbbqKaGNWag8cP/55+ZY6wFLOAYSv
        xsR0xy+2SKDs3lerkhEwIsMXy3CcV19q5I7FqKraykzYyO7wVycSFvpgvFpsaNDFUQ10CKsZ2v/Dj
        yoNWg5475HBB83MN0id0CaJOmX1xsaYwrD8p0wOaXduQt21b8jPL5A1lw24paa1gjtwLbXmiVL4Az
        MLMhndsLa/KqEPqIYA/uQmUw9ACwWSNBv4e6cEpYWOxuEOLYdwZ9EgcQwjjvpa6KRMgR9ZKV9skjj
        /4UKFxWg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOzq-00080n-8K; Tue, 15 Oct 2019 15:44:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] iomap: cleanup iomap_ioend_compare
Date:   Tue, 15 Oct 2019 17:43:45 +0200
Message-Id: <20191015154345.13052-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015154345.13052-1-hch@lst.de>
References: <20191015154345.13052-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the initialization of ia and ib to the declaration line and remove
a superflous else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c57acc3d3120..0c7f185c8c52 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1226,13 +1226,12 @@ EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
 static int
 iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
 {
-	struct iomap_ioend *ia, *ib;
+	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
+	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
 
-	ia = container_of(a, struct iomap_ioend, io_list);
-	ib = container_of(b, struct iomap_ioend, io_list);
 	if (ia->io_offset < ib->io_offset)
 		return -1;
-	else if (ia->io_offset > ib->io_offset)
+	if (ia->io_offset > ib->io_offset)
 		return 1;
 	return 0;
 }
-- 
2.20.1

