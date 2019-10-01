Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCFC2E18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfJAHQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:16:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbfJAHQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z4pMGaq/FkeqVLQ6dS6r9dj5gM7omeo3/3d/waJqFtY=; b=ojotwhc+9JLkZY8mnShAQxblAU
        EDhZhRFaCL776325OGqHk307gNkc2DQOMnwqUfnPdNkKvsd5Iqt3GxD2Ue/30bzigcbpmYM7U/UbX
        QctC9rkNrk1c39rak1D9wFPvJskxlaez9pOQMDb0IryDgXw7DNg6tLtcEt1dBGcAKKmo7jv3olImT
        TFSh9qeVMQ7vQ9r7Oa20MqIeot6LYHxUC23jldZHTcwNIymKaD29x5RTCnAD6DjZSiUZTJd3y3XoX
        nL1V4sb5xQyo26ddWKG0v5I5/C1fzipXC6WYqd0R66S97fH22cNHhGvQXcyFojmn5MBJxk931bHj+
        PvgQFowQ==;
Received: from [2001:4bb8:18c:4d4a:b9e5:f9f0:a515:3f0a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCOb-0001Rp-Ir; Tue, 01 Oct 2019 07:16:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] xfs: remove the readpage / readpages tracing code
Date:   Tue,  1 Oct 2019 09:11:47 +0200
Message-Id: <20191001071152.24403-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001071152.24403-1-hch@lst.de>
References: <20191001071152.24403-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The actual iomap implementations now have equivalent trace points.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c  |  2 --
 fs/xfs/xfs_trace.h | 26 --------------------------
 2 files changed, 28 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f16d5f196c6b..b6101673c8fb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1160,7 +1160,6 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	trace_xfs_vm_readpage(page->mapping->host, 1);
 	return iomap_readpage(page, &xfs_iomap_ops);
 }
 
@@ -1171,7 +1170,6 @@ xfs_vm_readpages(
 	struct list_head	*pages,
 	unsigned		nr_pages)
 {
-	trace_xfs_vm_readpages(mapping->host, nr_pages);
 	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eaae275ed430..eae4b29c174e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1197,32 +1197,6 @@ DEFINE_PAGE_EVENT(xfs_writepage);
 DEFINE_PAGE_EVENT(xfs_releasepage);
 DEFINE_PAGE_EVENT(xfs_invalidatepage);
 
-DECLARE_EVENT_CLASS(xfs_readpage_class,
-	TP_PROTO(struct inode *inode, int nr_pages),
-	TP_ARGS(inode, nr_pages),
-	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(xfs_ino_t, ino)
-		__field(int, nr_pages)
-	),
-	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
-		__entry->ino = inode->i_ino;
-		__entry->nr_pages = nr_pages;
-	),
-	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->ino,
-		  __entry->nr_pages)
-)
-
-#define DEFINE_READPAGE_EVENT(name)		\
-DEFINE_EVENT(xfs_readpage_class, name,	\
-	TP_PROTO(struct inode *inode, int nr_pages), \
-	TP_ARGS(inode, nr_pages))
-DEFINE_READPAGE_EVENT(xfs_vm_readpage);
-DEFINE_READPAGE_EVENT(xfs_vm_readpages);
-
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.20.1

