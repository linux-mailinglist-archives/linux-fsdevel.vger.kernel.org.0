Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527A2580DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfF0Ktf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:49:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0KtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fJI0E4skoEI39TQxKK3DQfuBuzuWn7ZecOIlC7qvXjg=; b=G0vwFVEzswLdenMMdOKWsZBAz4
        wkvp3ljicZ7JxF6HhgrKn/2/QhjIH2evGJl4g/jLV4v/Gyulz/VAy5UlPlu+lzU4ChzFyEk9x+/Tb
        hQ6Spgu2rDkL27lgmzuh+ennK1xiFxsLNBw1IzgXKmHH1cnrVM93oNfIT94nb76qowRgUTqkjvbLk
        DNGXE6a4FfDQMi/LC3Y7GubhyWJBZ07X7on9mW4Z8hfHLNA1TvyTO5RVwQylgc/0MMhYrReSEJJKe
        CDwJ/QqBxrTbVwbkgN+xPj8xbR6tDJrgHp8+AmAvM9KTgKiVJy65PFa1OhpG2PXw7/0IpcsLa2kBK
        xnHSR/lw==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxg-00057j-R3; Thu, 27 Jun 2019 10:49:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] xfs: refactor the ioend merging code
Date:   Thu, 27 Jun 2019 12:48:32 +0200
Message-Id: <20190627104836.25446-10-hch@lst.de>
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

Introduce two nicely abstracted helper, which can be moved to the
iomap code later.  Also use list_pop_entry and list_first_entry_or_null
to simplify the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index cd839f24c7ef..f3b99b0a9999 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -121,6 +121,19 @@ xfs_destroy_ioend(
 	}
 }
 
+static void
+xfs_destroy_ioends(
+	struct xfs_ioend	*ioend,
+	int			error)
+{
+	struct list_head	tmp;
+
+	list_replace_init(&ioend->io_list, &tmp);
+	xfs_destroy_ioend(ioend, error);
+	while ((ioend = list_pop_entry(&tmp, struct xfs_ioend, io_list)))
+		xfs_destroy_ioend(ioend, error);
+}
+
 /*
  * Fast and loose check if this write could update the on-disk inode size.
  */
@@ -235,7 +248,6 @@ STATIC void
 xfs_end_ioend(
 	struct xfs_ioend	*ioend)
 {
-	struct list_head	ioend_list;
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
 	xfs_off_t		offset = ioend->io_offset;
 	size_t			size = ioend->io_size;
@@ -280,16 +292,7 @@ xfs_end_ioend(
 done:
 	if (ioend->io_append_trans)
 		error = xfs_setfilesize_ioend(ioend, error);
-	list_replace_init(&ioend->io_list, &ioend_list);
-	xfs_destroy_ioend(ioend, error);
-
-	while (!list_empty(&ioend_list)) {
-		ioend = list_first_entry(&ioend_list, struct xfs_ioend,
-				io_list);
-		list_del_init(&ioend->io_list);
-		xfs_destroy_ioend(ioend, error);
-	}
-
+	xfs_destroy_ioends(ioend, error);
 	memalloc_nofs_restore(nofs_flag);
 }
 
@@ -338,17 +341,18 @@ xfs_ioend_try_merge(
 	struct xfs_ioend	*ioend,
 	struct list_head	*more_ioends)
 {
-	struct xfs_ioend	*next_ioend;
+	struct xfs_ioend	*next;
 
-	while (!list_empty(more_ioends)) {
-		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
-				io_list);
-		if (!xfs_ioend_can_merge(ioend, next_ioend))
+	INIT_LIST_HEAD(&ioend->io_list);
+
+	while ((next = list_first_entry_or_null(more_ioends, struct xfs_ioend,
+			io_list))) {
+		if (!xfs_ioend_can_merge(ioend, next))
 			break;
-		list_move_tail(&next_ioend->io_list, &ioend->io_list);
-		ioend->io_size += next_ioend->io_size;
-		if (next_ioend->io_append_trans)
-			xfs_ioend_merge_append_transactions(ioend, next_ioend);
+		list_move_tail(&next->io_list, &ioend->io_list);
+		ioend->io_size += next->io_size;
+		if (next->io_append_trans)
+			xfs_ioend_merge_append_transactions(ioend, next);
 	}
 }
 
@@ -371,29 +375,31 @@ xfs_ioend_compare(
 	return 0;
 }
 
+static void
+xfs_sort_ioends(
+	struct list_head	*ioend_list)
+{
+	list_sort(NULL, ioend_list, xfs_ioend_compare);
+}
+
 /* Finish all pending io completions. */
 void
 xfs_end_io(
 	struct work_struct	*work)
 {
-	struct xfs_inode	*ip;
+	struct xfs_inode	*ip =
+		container_of(work, struct xfs_inode, i_ioend_work);
 	struct xfs_ioend	*ioend;
-	struct list_head	completion_list;
+	struct list_head	tmp;
 	unsigned long		flags;
 
-	ip = container_of(work, struct xfs_inode, i_ioend_work);
-
 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
-	list_replace_init(&ip->i_ioend_list, &completion_list);
+	list_replace_init(&ip->i_ioend_list, &tmp);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 
-	list_sort(NULL, &completion_list, xfs_ioend_compare);
-
-	while (!list_empty(&completion_list)) {
-		ioend = list_first_entry(&completion_list, struct xfs_ioend,
-				io_list);
-		list_del_init(&ioend->io_list);
-		xfs_ioend_try_merge(ioend, &completion_list);
+	xfs_sort_ioends(&tmp);
+	while ((ioend = list_pop_entry(&tmp, struct xfs_ioend, io_list))) {
+		xfs_ioend_try_merge(ioend, &tmp);
 		xfs_end_ioend(ioend);
 	}
 }
-- 
2.20.1

