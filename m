Return-Path: <linux-fsdevel+bounces-41036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7EA2A121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B761676DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EA224B10;
	Thu,  6 Feb 2025 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGUtyZnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92A224AEA;
	Thu,  6 Feb 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824068; cv=none; b=d8snXp3kvA3v/8GexnNMjvYdHEBW5tzr9S2CSj0Xmi3RiOaWOi47/IWYtrXw6dXd+Ahu9SOWGcMdk+YS+pZly8HjhWfcRfKCuK/Bu0G23PhtqMPrvQUXKbxkMx2haRNmcrKxprtDplPMq5EzDaxsYi22JLaA6AxtWpiv58s4TlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824068; c=relaxed/simple;
	bh=inQkC4IXeBGvIqYH4HZBjyVMuYsAKqE5w6qy1FtgjfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKECyG3vOmYoZ/5grDlzN0WQugSPaprue/QEwPMKvnfl68Yq+sBIqUE5GAmuVK9nppzcFnPHWFN+is5fO8XTTPSRFcRrtF8GRQO/UlBEm75znvmRR3Ejs8K2bdcyWOL+cVtGn+BwGQYPC7CyTtXijUbAEuiRD8o8fc7i5AfuwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GGUtyZnP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v40XuIE4WAidPFS7fif3q/r+YIrLdqzKne4mlyS9/vY=; b=GGUtyZnPw9uUUL1sa5L3bsBbKQ
	KH6p98j5UoySRzU3Ges/7Z1X8+afYrCRYJiQzh2+Z0a4RuUpmDFYnRNrTEIG+riYqS8d2mKWllWXq
	9mfpcJ/b0DbZJvtNrt4IVBsuuH22BM0QKAl9acRQTd3oh8swvYXvacKtrEZKMAyKHmgo8bSaCaJ+O
	YQIaUwQAYyqBsILLyfqn1n2Z2SidI9TDyP8V9FKmfMh34DXk0K9VSQXVDRYRCizMrmpjTxiQt++7W
	UcCanSz9caHjOgdMYhRga83DYdI9y6MB7QqupFmGEVRHtUlF5eU4kfNJRMUpy3PUROBY5FKQ1BWcJ
	gAX1s1KQ==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZR-00000005Pa6-3lb1;
	Thu, 06 Feb 2025 06:41:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] iomap: pass private data to iomap_truncate_page
Date: Thu,  6 Feb 2025 07:40:09 +0100
Message-ID: <20250206064035.2323428-12-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
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
index 382647fda1d1..3458f97d1b1e 100644
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
index 483dec1475d2..46acf727cbe7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1510,5 +1510,5 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops);
+				   &xfs_buffered_write_iomap_ops, NULL);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index eddf524ac749..022d7f338c68 100644
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


