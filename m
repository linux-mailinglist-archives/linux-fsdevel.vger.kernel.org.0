Return-Path: <linux-fsdevel+bounces-37854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1C9F824F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FA2166985
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54611C5CB4;
	Thu, 19 Dec 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6TWilxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402D1C2325;
	Thu, 19 Dec 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630039; cv=none; b=lq8BtaYhAcRjhnv/wI76Vc1gsiZ2MD7NbQeGdUSLEE+tJ3A/PlTP4PZYCTw7ME7VGnYJmF785IQZ2Wpp50Qe+Cmd8k1SrJK6RuGTVQpYQ2DE/bNLZrz2G+1/P/1GEhSH4KMl/ObDAPrMR7LjdxxisOr/d3coTxhcU3wGfglVxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630039; c=relaxed/simple;
	bh=UD4LsMgujnO0QZ8c2U3RI1fFZzA95EnMNTrpBGV2ZCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSmsVqRtivn++RCHydtVnSqF2HfWPynrTFK9fOeO3IvZczaZaEKKzIHQ1sRDEntJPQ9e8+6rwVxrDBanK3o0W0xCk1xQjtogyKYvilU7LCjyXcegf379Sq9cpJBpBa283rq/ar1M+tv6N7QBpcv5xneqmCFlXYYl+0b2ock95XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V6TWilxv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NGNnGDCZ4RarAF37IlyT2MBOKZTUrZ5fy6pzWTT79MQ=; b=V6TWilxvQ5CzR/uRNChPY8w0+B
	6CPb/f2u43wTsFeFsPDMTBbili+2crrpCDCYmU1teSDKQwPsk3afBtXfKGQpT4R22zlSPnju4oz9Y
	z+knYnMgbH0Cw9Fy2qlDbPgR34jfy7stv3b3j/z5e3qbd+e7HNre5wXya+QtKp6U8P2vwIFW0scN+
	ahOs/6ZXV1ZXVA1gwHZGCKnlkuoz+g+bSKbIj7rF+7PzmvGV1osgVCNTBs2RIwhC83pjPANb4zD2g
	ksz8AJVQjFeHiaJn/9XsvoWemWkt3CuBjdyOf82bKIWDMB1HNTqFCsoxQpJTiSp/2oyKcP6fab1Aw
	3zceS1Rg==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVo-00000002b3o-44Iu;
	Thu, 19 Dec 2024 17:40:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] iomap: pass private data to iomap_truncate_page
Date: Thu, 19 Dec 2024 17:39:15 +0000
Message-ID: <20241219173954.22546-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow the file system to pass private data which can be used by the
iomap_begin and iomap_end methods through the private pointer in the
iomap_iter structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ++--
 fs/xfs/xfs_iomap.c     | 2 +-
 include/linux/iomap.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c2957ec9ab8b..54c42a88155a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1458,7 +1458,7 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
@@ -1467,7 +1467,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	if (!off)
 		return 0;
 	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
-			NULL);
+			private);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 3410c55f544a..5dd0922fe2d1 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1512,5 +1512,5 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops);
+				   &xfs_buffered_write_iomap_ops, NULL);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d2debb7f4344..de2ecde47aea 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -315,7 +315,7 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 		void *private);
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
-- 
2.45.2


