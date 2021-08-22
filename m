Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF863F3D29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhHVCdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 22:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhHVCdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 22:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E3F461267;
        Sun, 22 Aug 2021 02:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629599544;
        bh=EHSdNj7riKIM3GT/ZWaOK/dV1R95bNm2B1E7K7HCEsI=;
        h=Date:From:To:Cc:Subject:From;
        b=RHqqrYRX1jBM9beynYADzEQTk0yoPBDBdCm6L7xYzFMatN7Wx8BsZB0bFJAGD+jkV
         fbgkUOHQf46D9uZD5hlR2IzqCZuYoHPDe3bySGkEwFTEVCmLDEJhZGBGoiK5I8P5Em
         JhmGI2iziSUxLVaofPPRHWDmAO88Ji8KinNDFUfH1Cmg2O15zMYzEb4YQFCD+vQ8iU
         Dfs94uuYaiQ456Ni1sKuOtnvZ89fndrLyf+Yyj5BmCh8Eqwl+ANj/QJegychk9cw2l
         6L3qiZLnpnjIrLIqrcSOMMcpUVuqlfKNqmwB2NRwHMf9kIY7hVDsbz0rdHxqq/ULvC
         JtWCLLmpgSI1Q==
Date:   Sat, 21 Aug 2021 19:32:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] iomap: standardize tracepoint formatting and storage
Message-ID: <20210822023223.GY12640@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Print all the offset, pos, and length quantities in hexadecimal.  While
we're at it, update the types of the tracepoint structure fields to
match the types of the values being recorded in them.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/trace.h |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index f1519f9a1403..48cff616ef81 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -42,14 +42,14 @@ DEFINE_READPAGE_EVENT(iomap_readpage);
 DEFINE_READPAGE_EVENT(iomap_readahead);
 
 DECLARE_EVENT_CLASS(iomap_range_class,
-	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),
+	TP_PROTO(struct inode *inode, loff_t off, u64 len),
 	TP_ARGS(inode, off, len),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(u64, ino)
 		__field(loff_t, size)
-		__field(unsigned long, offset)
-		__field(unsigned int, length)
+		__field(loff_t, offset)
+		__field(u64, length)
 	),
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
@@ -58,8 +58,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
 		__entry->offset = off;
 		__entry->length = len;
 	),
-	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
-		  "length %x",
+	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx length 0x%llx",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  __entry->size,
@@ -69,7 +68,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
 
 #define DEFINE_RANGE_EVENT(name)		\
 DEFINE_EVENT(iomap_range_class, name,	\
-	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),\
+	TP_PROTO(struct inode *inode, loff_t off, u64 len),\
 	TP_ARGS(inode, off, len))
 DEFINE_RANGE_EVENT(iomap_writepage);
 DEFINE_RANGE_EVENT(iomap_releasepage);
@@ -122,8 +121,8 @@ DECLARE_EVENT_CLASS(iomap_class,
 		__entry->flags = iomap->flags;
 		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
 	),
-	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr %lld offset %lld "
-		  "length %llu type %s flags %s",
+	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
+		  "length 0x%llx type %s flags %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
@@ -149,7 +148,7 @@ TRACE_EVENT(iomap_iter,
 		__field(dev_t, dev)
 		__field(u64, ino)
 		__field(loff_t, pos)
-		__field(loff_t, length)
+		__field(u64, length)
 		__field(unsigned int, flags)
 		__field(const void *, ops)
 		__field(unsigned long, caller)
@@ -163,7 +162,7 @@ TRACE_EVENT(iomap_iter,
 		__entry->ops = ops;
 		__entry->caller = caller;
 	),
-	TP_printk("dev %d:%d ino 0x%llx pos %lld length %lld flags %s (0x%x) ops %ps caller %pS",
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx flags %s (0x%x) ops %ps caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		   __entry->ino,
 		   __entry->pos,
