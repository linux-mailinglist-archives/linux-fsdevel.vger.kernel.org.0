Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C26580C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF0KtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:49:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfF0KtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2yvHT618NnovgFgJsjPpwcRncjLi75iioGv1+Lk+glw=; b=Gm6dKltSVJUY2JooJvnqOHubwq
        RxVZ1Pvw8jYycr4/bEM+4rbq24oMAayMyj9SzYDljkAOpxmu6irXFxWOvGG5/ZP7h16MTt8Jy0vBf
        xi38zY0wFgbIaifMrB/EmbAC13tk0xEfGomZL+9Sn0HYRp8E0hWc1EpzsAYoLdyq0Cx8sycAoi2tI
        4btHhONtwu1yIaBWj7rih5GajxOTA3JNYijrBu2131yyvURrSWRX0s1h10Lj1uwcIUF8PhEuj5tHi
        +Aqit2geKwD45FLCp/+P5SyzY7dEqxVekkba5MWGplLRovoiq9NKytlin5+1nBra44WMz9ZpZclVf
        JNEe2VMg==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxb-000574-Jw; Thu, 27 Jun 2019 10:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Date:   Thu, 27 Jun 2019 12:48:30 +0200
Message-Id: <20190627104836.25446-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no real problem merging ioends that go beyond i_size into an
ioend that doesn't.  We just need to move the append transaction to the
base ioend.  Also use the opportunity to use a real error code instead
of the magic 1 to cancel the transactions, and write a comment
explaining the scheme.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8b3070a40245..4ef8343c3759 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -314,11 +314,28 @@ xfs_ioend_can_merge(
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
-	if (xfs_ioend_is_append(ioend) != xfs_ioend_is_append(next))
-		return false;
 	return true;
 }
 
+/*
+ * If the to be merged ioend has a preallocated transaction for file
+ * size updates we need to ensure the ioend it is merged into also
+ * has one.  If it already has one we can simply cancel the transaction
+ * as it is guaranteed to be clean.
+ */
+static void
+xfs_ioend_merge_append_transactions(
+	struct xfs_ioend	*ioend,
+	struct xfs_ioend	*next)
+{
+	if (!ioend->io_append_trans) {
+		ioend->io_append_trans = next->io_append_trans;
+		next->io_append_trans = NULL;
+	} else {
+		xfs_setfilesize_ioend(next, -ECANCELED);
+	}
+}
+
 /* Try to merge adjacent completions. */
 STATIC void
 xfs_ioend_try_merge(
@@ -327,7 +344,6 @@ xfs_ioend_try_merge(
 {
 	struct xfs_ioend	*next_ioend;
 	int			ioend_error;
-	int			error;
 
 	if (list_empty(more_ioends))
 		return;
@@ -341,10 +357,8 @@ xfs_ioend_try_merge(
 			break;
 		list_move_tail(&next_ioend->io_list, &ioend->io_list);
 		ioend->io_size += next_ioend->io_size;
-		if (ioend->io_append_trans) {
-			error = xfs_setfilesize_ioend(next_ioend, 1);
-			ASSERT(error == 1);
-		}
+		if (next_ioend->io_append_trans)
+			xfs_ioend_merge_append_transactions(ioend, next_ioend);
 	}
 }
 
-- 
2.20.1

