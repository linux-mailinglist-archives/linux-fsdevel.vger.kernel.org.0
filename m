Return-Path: <linux-fsdevel+bounces-54592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83FB015CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8716435AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E17218593;
	Fri, 11 Jul 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9viDCNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC33215179;
	Fri, 11 Jul 2025 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221515; cv=none; b=SRHxKOqPDerx9aXMUA6lwPi9yuRHqcXCX7sD36tz/FfuQAA111CU4UCNXq49ywZPpdjgZXWNwv8v1TpnN8sEuU8P4AaIV6z0ZZtvin95p7BMbJ0fSUvQg2zntMLEPc4dyW7bctMb8ZSRMDJNtIrPirjJifAvMY/ASNJ96Wodp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221515; c=relaxed/simple;
	bh=OCr0c7dyekem0VO6jnILOOdUC6Pj+RqeiVt7hdJ5DOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOXCoX28qcLT8UVY6Us3RKp/usPUFCKES+ZuTxpFTdkCVFDg0ELwJMWe+37Tegz8uveaCNs5raLV/T0h7bLv1aqV6HM1sAuvcy7yiKbQFf+ZTiuC4O9PQuYXZGjPq59s0k+LmYQ7lfUh7tKJKnH3H4a0to29XvARCfgqQUSEna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9viDCNt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=eTEjEPn2OOOUGAVKb34lTzQhJl34ux1rQiUak37BLyo=; b=R9viDCNtI5cxg4e1dB4aWx5Ah7
	RD1/54Mq00owc9WRi39tC7Rf+0GUyv65hIwl2ltfisgx6a7ERvUGpVdGzxqrqlgjAyx1wXf35qxil
	xZh8kDPIIyIPEttIwSffxeX5dwm8GnLy+b8UNNmyvrRPYxmYDZQ00sEzOeAYkAn0lR+wwGoGJ0BRj
	yUtWqqqfeYD1ypKQBbBX6pBJKTVlcnVZhBIInzkh/X43gEkzmn9JWAZggo1M/1ehnH20twiJJc9MW
	mftsrfjBeFJ6rEgs1xYFwIzaN0zTCw1bgfz4IotL1KEor7zWdr3zrT4zAdtgGXYpSs1MeowAV7G8u
	+N1w6aow==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8rI-0000000E5kj-2qI5;
	Fri, 11 Jul 2025 08:11:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ntfs3: stop using write_cache_pages
Date: Fri, 11 Jul 2025 10:11:50 +0200
Message-ID: <20250711081150.564592-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using the obsolete write_cache_pages and use writeback_iter directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/inode.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0f0d27d4644a..0a6a7a343aa1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -871,9 +871,9 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 }
 
 static int ntfs_resident_writepage(struct folio *folio,
-				   struct writeback_control *wbc, void *data)
+				   struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	int ret;
@@ -899,9 +899,14 @@ static int ntfs_writepages(struct address_space *mapping,
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	if (is_resident(ntfs_i(inode)))
-		return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
-					 mapping);
+	if (is_resident(ntfs_i(inode))) {
+		struct folio *folio = NULL;
+		int error;
+
+		while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+			error = ntfs_resident_writepage(folio, wbc);
+		return error;
+	}
 	return mpage_writepages(mapping, wbc, ntfs_get_block);
 }
 
-- 
2.47.2


