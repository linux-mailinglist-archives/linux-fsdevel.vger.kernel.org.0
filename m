Return-Path: <linux-fsdevel+bounces-30717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E235198DE32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204E11C239EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5391D0BB0;
	Wed,  2 Oct 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vEj4X5/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B781CF7D4;
	Wed,  2 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881248; cv=none; b=u3hURom9ap04yFTrVGSLOIY0jqCUYaoWXpgoXFw7peS356pGR1HFmVJMqHUR2ulouwrClBmHqpCFi5Z+/W1jJjneCcO/hlWKdPy7kT6EuMJtN3OGjOmEkaAPqT+Hv1TQgq4t1ZITXVBofcu6zmW0DgjSI7WujpvfuBnvY94sE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881248; c=relaxed/simple;
	bh=7l5Go5t91dE8de6S1Lfp/42RC395bfstA28o3lJZg4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luBEkbDUWzT5yQ2tSnKINiO4eZEHWh7ubXyGT3hPnICt66lF+MWnGdd+LzOBKHpJar7lr7RApBWEb9y43WqA35RskOy5BaZzJKmfTrwAt6mab1AYXlWCstvJM/ZM1gCteovzXQwP4mnBxLtExgnKqnUQGosobzfWVHF/Sim7was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vEj4X5/E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZCxIAb+8r7iTnxFMXmLz+YjJPFISQmqachGJWAZOJPM=; b=vEj4X5/EZJSE8K8Qvc6sjCSTgT
	HpelyKkmzWbxfJZVZ0rHivBaURE8aaMlcin2IKKyoPuAL86Dm7iANTsn13BiKRAFPd4NpBfOdNRpb
	P2Z8mJZ3BftEYXat4rkwfwkiD19KfH9ZV9HYDfXOtt+GIMPAMuR99DvSbVFK7sJraPZZqovSaE9Ry
	zYpWwGhU+s/6ajSGc4Ty/kE1PNW2/hiYbCPeLB1Vmxh9EsyNOd3brKt0D0AWmWYD2dTX7pD4AbZ71
	7N4heM3oeetJGLs+6FHEEzxErVyn5x7Q+NhZ0ZqHnIDdy2zmXb/CbwPvtGdZviS4yiCJ3Pr0nmF4A
	Cw7uCkhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0qD-00000005cSr-3Fn5;
	Wed, 02 Oct 2024 15:00:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 4/4] nilfs2: Convert metadata aops from writepage to writepages
Date: Wed,  2 Oct 2024 16:00:34 +0100
Message-ID: <20241002150036.1339475-5-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002150036.1339475-1-willy@infradead.org>
References: <20241002150036.1339475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By implementing ->writepages instead of ->writepage, we remove a
layer of indirect function calls from the writeback path and the
last use of struct page in nilfs2.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/mdt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index ceb7dc0b5bad..4f4a935fcdc5 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -396,10 +396,9 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
 	return test_bit(NILFS_I_DIRTY, &ii->i_state);
 }
 
-static int
-nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
+static int nilfs_mdt_write_folio(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 	struct super_block *sb;
 	int err = 0;
@@ -432,11 +431,23 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
+static int nilfs_mdt_writeback(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		nilfs_mdt_write_folio(folio, wbc);
+
+	return error;
+}
 
 static const struct address_space_operations def_mdt_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
-	.writepage		= nilfs_mdt_write_page,
+	.writepages		= nilfs_mdt_writeback,
+	.migrate_folio		= buffer_migrate_folio,
 };
 
 static const struct inode_operations def_mdt_iops;
-- 
2.43.0


