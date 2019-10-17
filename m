Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7BDB52C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441168AbfJQR5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:57:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395081AbfJQR5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0UL9ARtnKTUW5wAFwMjG0jmQyb6DrKDYKTjzEbcyVl4=; b=TZGOIEQliN05kExA2H7dLlgZ9J
        PGQHv7fEP0nMHiIo5d737u3C6NWMOuN8wZe3JbCvJNHlQi7ItAstiJNHs5PAZCvL75IpuReSyNl+/
        0eSuJFcdTkHQAHRNifxc1+Blp2o+iOaB3ipjpTJdyk5/wMcIPnjiNF4ir6Mig5RDW/rdbgqnhNLQD
        355L4ex7p8aO8IMfiulipLS0xgFPJSPUwHkfT5YVRob8yNCkWumqkJ40NyC3wzgbErvsbPj2wfGmQ
        VgtVKuCx8e38ag0Timm7cua9MUddb+juaMIra3kw/AfCY2/EJc351kVFKAFyqW8iDK+obl0rmNtDS
        uw3k8HGw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA1H-0001RV-RF; Thu, 17 Oct 2019 17:57:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 13/14] iomap: cleanup iomap_ioend_compare
Date:   Thu, 17 Oct 2019 19:56:23 +0200
Message-Id: <20191017175624.30305-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f8ff96124a86..bb96499c352f 100644
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

