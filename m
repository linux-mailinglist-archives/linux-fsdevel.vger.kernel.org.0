Return-Path: <linux-fsdevel+bounces-17433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E28AD4EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A0D1F211C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06815572D;
	Mon, 22 Apr 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlkytfL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA63155331;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814332; cv=none; b=ST89FrhZZcTbWl76GR7Hq4ivN2/2UyiULcBBamlnau/RVkLBN+ALDvQ4wsxyeJC8xsV3JiMjmqaSv6B8+lvs923nJ0/rOnVeC1qXFQSl8ASoqDmCmER8YHMMh4X6lzYCPXWHzzBgKrhHKnWNfATujg8pkhnTDWA5BkVlOKIfNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814332; c=relaxed/simple;
	bh=eDzZ4vNVsWAEW/IPJpi6Lz7Ek5AahfE9k2M4rt9/Go4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYzh1q5wz2hQ9C0G7A0Z193hHnTz9BeB7RGFobUoqLrmomOWcMabcoHpth64ofix+RnTP5fA7SeHpoRESweyrqXNLQwrWrGsjXFdAVgumNOxUS1BYrPYBpcHOSwo0r1slzJ0M6gfDTOVcrlu3QSbW2FGjMYI+q60/D+mHUCvN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlkytfL3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jA6DvimgocJNoFfxUx1rKqz4GwPAUGQUlfv1jnS2/+o=; b=LlkytfL3G8GwyCJwG6dhJ+oaav
	EzfUq8KRM1yIbNgoedol51GW7P4pRf0FVrkbb/GVgVh2NBT4tOC9Gb0dQPXmHpPaq8+qXoVFJypwu
	8QBTPdGJlhPpHlWBcFGtwJWrMLL9sP3vWEP/+7TMvqRVf4KK1Pf4jKJaGtASkQJAxgovBknkfz2So
	vKfBzNnJnj9GdEsGCS4eGMSTQDJUQU74biYmc2hdtuQuqmuASfXN7HxI3hvWaTOqwCJJWEbduw5AU
	CDXM6YX7ZQnGySFFsFrQ6axY1Ud5wf2y8csY35uQ5zLtmepWtiLS268ikgbdL5B/06nDFGnOHqRG1
	tm9/HPMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOR-1pWB;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/11] ntfs3: Convert attr_data_write_resident to use a folio
Date: Mon, 22 Apr 2024 20:31:55 +0100
Message-ID: <20240422193203.3534108-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that both callers of attr_data_write_resident() have a folio, pass
it in and use memcpy_from_folio() to handle all the gnarly highmem
multi-page problems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/attrib.c  | 12 ++++--------
 fs/ntfs3/inode.c   |  4 ++--
 fs/ntfs3/ntfs_fs.h |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 676489b05a1f..02fa3245850a 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1267,7 +1267,7 @@ int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio)
 	return 0;
 }
 
-int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
+int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio)
 {
 	u64 vbo;
 	struct mft_inode *mi;
@@ -1283,17 +1283,13 @@ int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
 		return E_NTFS_NONRESIDENT;
 	}
 
-	vbo = page->index << PAGE_SHIFT;
+	vbo = folio->index << PAGE_SHIFT;
 	data_size = le32_to_cpu(attr->res.data_size);
 	if (vbo < data_size) {
 		char *data = resident_data(attr);
-		char *kaddr = kmap_atomic(page);
-		u32 use = data_size - vbo;
+		size_t len = min(data_size - vbo, folio_size(folio));
 
-		if (use > PAGE_SIZE)
-			use = PAGE_SIZE;
-		memcpy(data + vbo, kaddr, use);
-		kunmap_atomic(kaddr);
+		memcpy_from_folio(data + vbo, folio, 0, len);
 		mi->dirty = true;
 	}
 	ni->i_valid = data_size;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e9c1cba44741..69dd51d7cf83 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -871,7 +871,7 @@ static int ntfs_resident_writepage(struct folio *folio,
 		return -EIO;
 
 	ni_lock(ni);
-	ret = attr_data_write_resident(ni, &folio->page);
+	ret = attr_data_write_resident(ni, folio);
 	ni_unlock(ni);
 
 	if (ret != E_NTFS_NONRESIDENT)
@@ -959,7 +959,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_write_resident(ni, page);
+		err = attr_data_write_resident(ni, folio);
 		ni_unlock(ni);
 		if (!err) {
 			struct buffer_head *head = folio_buffers(folio);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index bd8c9b520269..275def366443 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -446,7 +446,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			CLST *len, bool *new, bool zero);
 int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio);
-int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
+int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		       const __le16 *name, u8 name_len, struct runs_tree *run,
 		       CLST vcn);
-- 
2.43.0


