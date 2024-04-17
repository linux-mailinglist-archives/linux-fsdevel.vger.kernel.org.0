Return-Path: <linux-fsdevel+bounces-17178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A468A89F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266F4B26FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C058171673;
	Wed, 17 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSK55F7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8017166B;
	Wed, 17 Apr 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373794; cv=none; b=Zej0y5YhpwQbjClE201eGrrZv5FonHJLyBnUmYLG42lTsyEpFWnPL6yqwnNtP4LzGsPSTfcN5OAiHbVam6o35aQo2VASgdD0oRBcbPLFrGMklTgu2GUZO4sNIaMJYplhHAVYbO9iGMzYnmYZD4B+6pyuYqNo4hBsMvwAgFxYgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373794; c=relaxed/simple;
	bh=EAQDFPEy6cQ4YkGhr+2EUXffLxBkkeq8LcO6iBwOLKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0PZmIs507c3KELOg+We9xzNmSqy+PoZxsRbbAjvuAWch5I0gNVYY8ppHa918Q4yU2IgP+NexPVOQagtGBmoTz9bbXZhRl2lvRnF9p93c5hpd4/8TVMr1V25d+RXGW1jEbJQ5p+b6DsWc4YFBaoldi0pvQHuHd0ihjcDXA68JyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSK55F7H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=S3wehsEJVgq9ww+YHdEdObRQcvwJ3zi7CoaRl0ZoYQk=; b=lSK55F7HfZvfr8Y9BIiVX423ZJ
	nMJArF65Swg+93Y40jQ48IE51W8rc30NOpHgzoMOvytmjaxOrOT9mI6QKQqZL3Z3tKq2/qWAcsVxF
	wsgR1I9vOjKO2u0chzfRDmfzTtHo0HohAXyB/sV8IUHZVHi0cFj+rVASuQcaRFaU4IyV7YFzukCPb
	WxKzzxSDi37hBW/JNWhEX6mCmxQX9LoiGqnhQ2BiGN6CFCPlVpwluUWznCXyDx6eFpfgVfmZen5rq
	FdqZ5cBkIT4BP8W3jr43iduvFpjucOp7o8jgr1XtUFyEuTZhmJVsRhjNswjiFWVR2tLwicTWDkTmI
	FOkfl1iw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n8-00000003LNY-2yUv;
	Wed, 17 Apr 2024 17:09:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] ntfs3: Convert attr_data_write_resident to use a folio
Date: Wed, 17 Apr 2024 18:09:33 +0100
Message-ID: <20240417170941.797116-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
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
index 11f90b140122..64b526fd2dbc 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1250,7 +1250,7 @@ int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio)
 	return 0;
 }
 
-int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
+int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio)
 {
 	u64 vbo;
 	struct mft_inode *mi;
@@ -1266,17 +1266,13 @@ int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
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
index e649d191554d..cd634398d770 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -859,7 +859,7 @@ static int ntfs_resident_writepage(struct folio *folio,
 		return -EIO;
 
 	ni_lock(ni);
-	ret = attr_data_write_resident(ni, &folio->page);
+	ret = attr_data_write_resident(ni, folio);
 	ni_unlock(ni);
 
 	if (ret != E_NTFS_NONRESIDENT)
@@ -947,7 +947,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_write_resident(ni, page);
+		err = attr_data_write_resident(ni, folio);
 		ni_unlock(ni);
 		if (!err) {
 			struct buffer_head *head = folio_buffers(folio);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0b518bf8182a..d35dc001c2c0 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -435,7 +435,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
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


