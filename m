Return-Path: <linux-fsdevel+bounces-37913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298DC9F8BCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 06:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906641891948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26A17838C;
	Fri, 20 Dec 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7VaH9sJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F17083C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734671708; cv=none; b=gfvf5NQrKhFsaCI/yXUa+L4s6RElJaFWfoViy5pA0ObEx+0ScDnzL5qIObcNgpQhyKwEPb4awPak5LD5mDsfqbJvTO5US/2qaubs7kc0s/nJltmehZCtDdoS+i3ZiMyFQPrJt/Yiisc0f5VPvpkhxChTKE6wIkOEZFSHmHWkgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734671708; c=relaxed/simple;
	bh=j9+jwpc+Y2fYL99yRX2zVgc0j7/Wv8MxIAIuWPPwXwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQ4/fPv/YAtctndPwnnwMoo8CA/OnFncjW2Hmzet0szK/cszMoafYAXiTdCJASs0L8IHoDhHtcVjOYi+4hbRQJwMpNOMrSib4j/j26U6OQO9HDqclPwrHNeMiS9ayiwQ+xDP0b57yQsmynzXOYCL2hiFiyAvjkfcYLMk/OoW3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s7VaH9sJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hbyDsBYs078/edYsxxQxZi+pKFEuecjVboPxERHpBOk=; b=s7VaH9sJHuR6ieR/HltkARbxm6
	Jg9SDtN0yFFZCtUhWL/LPyfqM9ZWn70vZ4lldIjTQxXZubbScbkVzLR26dzjrbbNSkMOg2Yleuqjw
	ErhmfyUBzk6odNkJK3o9RtBu3OrqHAX81sbMw56RlB8WJk6Wm1P8z6D32UJvWUAK9dH/2wj7tEoyQ
	voQZ0B6kK/9saJaGBk0Kkw/tvHQ6JZWs6ryCLKWu+q59tCJNVLQwq7wzyUbFVwi9vxPGQTuGrSwbp
	uMEfIplHVyvl7pcWoBEIY3jCeZ8kT5iZd2/B4TNGEZOqxIBEQL2HcAP4VoRBA6FOhOvz2vrP08ZVA
	LTvRHEbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOVLq-000000083KQ-0caJ;
	Fri, 20 Dec 2024 05:15:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] hostfs: Convert to writepages
Date: Fri, 20 Dec 2024 05:14:58 +0000
Message-ID: <20241220051500.1919389-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we add a migrate_folio operation, we can convert the writepage
operation to writepages.  The large folio support here is illusory;
we would need to kmap each page in turn for proper support.  But we do
remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 54 +++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7e51d2cec64b..844c45253452 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -410,38 +410,33 @@ static const struct file_operations hostfs_dir_fops = {
 	.fsync		= hostfs_fsync,
 };
 
-static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
+static int hostfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
-	char *buffer;
-	loff_t base = page_offset(page);
-	int count = PAGE_SIZE;
-	int end_index = inode->i_size >> PAGE_SHIFT;
-	int err;
-
-	if (page->index >= end_index)
-		count = inode->i_size & (PAGE_SIZE-1);
-
-	buffer = kmap_local_page(page);
-
-	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
-	if (err != count) {
-		if (err >= 0)
-			err = -EIO;
-		mapping_set_error(mapping, err);
-		goto out;
+	struct folio *folio = NULL;
+	loff_t i_size = i_size_read(inode);
+	int err = 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		loff_t pos = folio_pos(folio);
+		size_t count = folio_size(folio);
+		char *buffer;
+		int ret;
+
+		if (count > i_size - pos)
+			count = i_size - pos;
+
+		buffer = kmap_local_folio(folio, 0);
+		ret = write_file(HOSTFS_I(inode)->fd, &pos, buffer, count);
+		kunmap_local(buffer);
+		folio_unlock(folio);
+		if (ret != count) {
+			err = ret < 0 ? ret : -EIO;
+			mapping_set_error(mapping, err);
+		}
 	}
 
-	if (base > inode->i_size)
-		inode->i_size = base;
-
-	err = 0;
-
- out:
-	kunmap_local(buffer);
-	unlock_page(page);
-
 	return err;
 }
 
@@ -506,11 +501,12 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 }
 
 static const struct address_space_operations hostfs_aops = {
-	.writepage 	= hostfs_writepage,
+	.writepages 	= hostfs_writepages,
 	.read_folio	= hostfs_read_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.write_begin	= hostfs_write_begin,
 	.write_end	= hostfs_write_end,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
-- 
2.45.2


