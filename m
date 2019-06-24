Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3C50195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfFXFx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 01:53:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFXFxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6iPllgByjiycLh9HLKiv2XHWXOkGIXp7tU5AXv0oDVg=; b=hWNTtuvbA9OqXzZmc+55gkDkws
        brZE7otREjpfwOnTBzLkP2W8E+PPPemWS+Pn0dPJmMAosxZ2jaTHeOWILkYT+keRUoBOEls2AnaVw
        HDPbJ3BDknzpyqgyLHJKUPG9xTxPnowyGYg20Epq5i8vJOJ7+E+NXbnuFQooWcIy6nA7hh3fyD3U8
        Qs9JOcXTWqn+Slpq5J0PJPZyNXbNkmcMDKJpXuvmUzyzwha4TeMWxwXXonKmwwsB8AN7MCeXjVAn9
        5CooJGHTKyLr5qACNtrISwkuIuS35S0KLOrH2g9pbzryedFsl7yiv1jvrUHv5hp70GsN5N2L6JGD0
        WDaNz/tg==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHuq-00047L-Ah; Mon, 24 Jun 2019 05:53:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] xfs: simplify xfs_ioend_can_merge
Date:   Mon, 24 Jun 2019 07:52:49 +0200
Message-Id: <20190624055253.31183-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624055253.31183-1-hch@lst.de>
References: <20190624055253.31183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Compare the block layer status directly instead of converting it to
an errno first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 017b87b7765f..acbd73976067 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -226,13 +226,9 @@ xfs_end_ioend(
 static bool
 xfs_ioend_can_merge(
 	struct xfs_ioend	*ioend,
-	int			ioend_error,
 	struct xfs_ioend	*next)
 {
-	int			next_error;
-
-	next_error = blk_status_to_errno(next->io_bio->bi_status);
-	if (ioend_error != next_error)
+	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
 	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
 		return false;
@@ -251,17 +247,11 @@ xfs_ioend_try_merge(
 	struct list_head	*more_ioends)
 {
 	struct xfs_ioend	*next_ioend;
-	int			ioend_error;
-
-	if (list_empty(more_ioends))
-		return;
-
-	ioend_error = blk_status_to_errno(ioend->io_bio->bi_status);
 
 	while (!list_empty(more_ioends)) {
 		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
 				io_list);
-		if (!xfs_ioend_can_merge(ioend, ioend_error, next_ioend))
+		if (!xfs_ioend_can_merge(ioend, next_ioend))
 			break;
 		list_move_tail(&next_ioend->io_list, &ioend->io_list);
 		ioend->io_size += next_ioend->io_size;
-- 
2.20.1

