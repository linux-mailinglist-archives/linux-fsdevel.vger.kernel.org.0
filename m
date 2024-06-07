Return-Path: <linux-fsdevel+bounces-21190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC76900358
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C51C24809
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AD419408C;
	Fri,  7 Jun 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="QrBgp6qI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DF15B127;
	Fri,  7 Jun 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762877; cv=none; b=m+JCEmZDKC0ETTMsKf2qjed6kSaxUKwN8zO4uOL8QveC6PV51EczXfk09seFEIRq/zQfau0a8kAppc/WsWpWqIDlcrZSQFVYPNkPFzKq7kyJ2jFq+PAJSzd5SnEyfduYCEKMZOmS8gSzoNy2seYyDiL10dOFIPwXnlZMzEjkLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762877; c=relaxed/simple;
	bh=J6KPuZ2VxItqZmJdi4nQDQNER33qNxybVV6F+t0nrao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jByU0HlrMs+cYnTd8a1wzKB/zdke7UNZPS03cyjv+XmqtybTDp/ftLT27buMzijAfiaw1nXJEMhrU3mVewEheTuIY3vZRnNnp3Em9ESfBxfZLvAl5krom2dUq4tUT/KEhuBfhM9sJ0pFCSkDp2oK/sdETOBvBDCPmbMAhxIjObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=QrBgp6qI; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id ABBA720FF;
	Fri,  7 Jun 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762091;
	bh=GaStLi+0wBM9tYp9G17MLO5l7cW1O7P/lNN8XAy/iCs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QrBgp6qIbln4ZrPCCqQEz4pKb2V85OCBgT80EIrWad4iz5GuhJzrQIKjpwanfzub/
	 R86lsncvALbmlnjFnSt+uHqqHLLgZQF+yyzRiPnQYbM68vhNo/e73uHXxlUGRLsU76
	 GX6ljmhAxqHUWXfVVpsJ71odO+F2CJqsYTuBK9Og=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:05 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 02/18] fs/ntfs3: Simplify initialization of $AttrDef and $UpCase
Date: Fri, 7 Jun 2024 15:15:32 +0300
Message-ID: <20240607121548.18818-3-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Replaced the two loops reading $AttrDef and $UpCase with
the inode_read_data() function.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c   | 28 ++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h | 17 +------------
 fs/ntfs3/super.c   | 60 ++++++++++++++++++----------------------------
 3 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6dc51faeef8d..2a3522bbeeb4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1097,6 +1097,34 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 	return ret;
 }
 
+/*
+ * Helper function to read file.
+ */
+int inode_read_data(struct inode *inode, void *data, size_t bytes)
+{
+	pgoff_t idx;
+	struct address_space *mapping = inode->i_mapping;
+
+	for (idx = 0; bytes; idx++) {
+		size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
+		struct page *page = read_mapping_page(mapping, idx, NULL);
+		void *kaddr;
+
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		kaddr = kmap_atomic(page);
+		memcpy(data, kaddr, op);
+		kunmap_atomic(kaddr);
+
+		put_page(page);
+
+		bytes -= op;
+		data = Add2Ptr(data, PAGE_SIZE);
+	}
+	return 0;
+}
+
 /*
  * ntfs_reparse_bytes
  *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index ee0c1b76e812..3583d47b95da 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -716,6 +716,7 @@ int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
+int inode_read_data(struct inode *inode, void *data, size_t bytes);
 int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, const struct cpu_str *uni,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
@@ -909,22 +910,6 @@ static inline bool ntfs_is_meta_file(struct ntfs_sb_info *sbi, CLST rno)
 	       rno == sbi->usn_jrnl_no;
 }
 
-static inline void ntfs_unmap_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
-static inline struct page *ntfs_map_page(struct address_space *mapping,
-					 unsigned long index)
-{
-	struct page *page = read_mapping_page(mapping, index, NULL);
-
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
-}
-
 static inline size_t wnd_zone_bit(const struct wnd_bitmap *wnd)
 {
 	return wnd->zone_bit;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 27fbde2701b6..6c9e5fe8ce81 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1163,7 +1163,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	CLST vcn, lcn, len;
 	struct ATTRIB *attr;
 	const struct VOLUME_INFO *info;
-	u32 idx, done, bytes;
+	u32 done, bytes;
 	struct ATTR_DEF_ENTRY *t;
 	u16 *shared;
 	struct MFT_REF ref;
@@ -1435,31 +1435,22 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode_out;
 	}
 
-	for (done = idx = 0; done < bytes; done += PAGE_SIZE, idx++) {
-		unsigned long tail = bytes - done;
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
+	/* Read the entire file. */
+	err = inode_read_data(inode, sbi->def_table, bytes);
+	if (err) {
+		ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
+		goto put_inode_out;
+	}
 
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
-			goto put_inode_out;
-		}
-		memcpy(Add2Ptr(t, done), page_address(page),
-		       min(PAGE_SIZE, tail));
-		ntfs_unmap_page(page);
-
-		if (!idx && ATTR_STD != t->type) {
-			ntfs_err(sb, "$AttrDef is corrupted.");
-			err = -EINVAL;
-			goto put_inode_out;
-		}
+	if (ATTR_STD != t->type) {
+		ntfs_err(sb, "$AttrDef is corrupted.");
+		err = -EINVAL;
+		goto put_inode_out;
 	}
 
 	t += 1;
 	sbi->def_entries = 1;
 	done = sizeof(struct ATTR_DEF_ENTRY);
-	sbi->reparse.max_size = MAXIMUM_REPARSE_DATA_BUFFER_SIZE;
-	sbi->ea_max_size = 0x10000; /* default formatter value */
 
 	while (done + sizeof(struct ATTR_DEF_ENTRY) <= bytes) {
 		u32 t32 = le32_to_cpu(t->type);
@@ -1495,27 +1486,22 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode_out;
 	}
 
-	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
-		const __le16 *src;
-		u16 *dst = Add2Ptr(sbi->upcase, idx << PAGE_SHIFT);
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
-
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			ntfs_err(sb, "Failed to read $UpCase (%d).", err);
-			goto put_inode_out;
-		}
-
-		src = page_address(page);
+	/* Read the entire file. */
+	err = inode_read_data(inode, sbi->upcase, 0x10000 * sizeof(short));
+	if (err) {
+		ntfs_err(sb, "Failed to read $UpCase (%d).", err);
+		goto put_inode_out;
+	}
 
 #ifdef __BIG_ENDIAN
-		for (i = 0; i < PAGE_SIZE / sizeof(u16); i++)
+	{
+		const __le16 *src = sbi->upcase;
+		u16 *dst = sbi->upcase;
+
+		for (i = 0; i < 0x10000; i++)
 			*dst++ = le16_to_cpu(*src++);
-#else
-		memcpy(dst, src, PAGE_SIZE);
-#endif
-		ntfs_unmap_page(page);
 	}
+#endif
 
 	shared = ntfs_set_shared(sbi->upcase, 0x10000 * sizeof(short));
 	if (shared && sbi->upcase != shared) {
-- 
2.34.1


