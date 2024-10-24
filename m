Return-Path: <linux-fsdevel+bounces-32709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5C9AE097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A991B284BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915D1B394C;
	Thu, 24 Oct 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6UTHWQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E61BDAB9;
	Thu, 24 Oct 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761981; cv=none; b=JPacv6yeXmUf+ngSkjVUj2UrIzeZjSlW0Lw7ZGzKi4PmglvRB9UYoJkS4bcxiiGMjVnZI5JHO3WUNwn1OkS9WOyj6KjkYRsKFieYhWqcORdmT2VyfV3+6yCp+qoQnMivTWpjnOh/oxlAIfYclDROAfIEP2UbKC71HoZIHfcLaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761981; c=relaxed/simple;
	bh=YBGa1W/R574ExgUu1Xmj/WNRWG9AEhdKLc/mvsWGYM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpQ26V1imuCCjzRMBXPRNGkjd9+489uiPXh4r2AB1YDxAhQZA/tb9U7ZoFJDVkMUf5LwrjVUC8Aq3CoOA6o86z3PDbDiW0idm9sAncrlHOQNycKer8Tw0PC31jY221mqtuQ2mt8qZWtdekgiIzpxaIiq2zEljIcSfHCUPWKIqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6UTHWQy; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2884e7fadb8so423788fac.2;
        Thu, 24 Oct 2024 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761977; x=1730366777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoCQQE9idr8Ibh7QiNSt322nKVFTvmt/BLT3jNLBlk8=;
        b=e6UTHWQyDrJpfZNIQn8n4E34iTQgLfgFDsrMfYMryFz9jWyWTULHySAi8nMB4wa2MR
         cabC7qERsAgG0gvneQeUcFCPWUpCpWM3BKpBeuwZS7fZnPTVMTpAOmpyUPIZcU4PDfkg
         gHokE/WczwNmHR6wBCw4I8Dn5SzvmatGF8DLMROYgZQRMane4qLrj4tqrLNwLTWJWOg1
         Im8FX0qXoRZV59D7KpaCQmmXNRWcQcmL4wLRW8XmCUIIOAYwWFXGmG5uAtmjqYk7e3Wm
         LtlckRuez/Chvm1oikT10J8goSHrTbozGXnaib8XAb9O91Tk9v/yQX7HwLvwbb0g2F7l
         s8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761977; x=1730366777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoCQQE9idr8Ibh7QiNSt322nKVFTvmt/BLT3jNLBlk8=;
        b=ho5omkJwOnr/mdp00frFXNx7GkIh6pE32m8TAwmolha3zhALpm+XkbtnKzzkG58DjY
         7EjzWQeVNOLafOa20hlBp95tnp9G655Er3r0e+9wlddX1dJcKBRivbLA06QZdXq8DsBx
         ka76xC0FXFYnBiPxxsUdG6WKe6/MnX4OVUgjS1BIfGLwPX+3ECJIbvBmBYXUqexLdbFi
         gu2GUIfYaucZyVTEO04CgTGKtS5jjkuE+4j5XCN9a434DkEFhtDuYub+cyRTykFXX/OA
         veilWTD1wrPHEUS/T4OM8O+1jTNpoZzCHf4uxwXbwgW/Gi3d9vRkugjWYXETgsxKugRs
         rIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIJqUYvUc3AQn+n3GsOMDcuKBSToliC0SQDnAl4s5RxqOW7gqBR9BylNcB4rjOuVdA2MUs0jCean3NMgJq@vger.kernel.org, AJvYcCVPEbUIiDumHic54JvQ4IninRGu1jgyoPsxdHy0iqxBolVijKAbwcpjLq3sdpW8Gfi36trlWttYf6QiFJk=@vger.kernel.org, AJvYcCXkw1EtjAWaZL7jdLQnViLliP54Nx+dnYXgmtuBzsfsGsgN9I/P/S/WoybBSVuJgDq9J6O2oYPRtjVHwKIO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kGNhR1bX769z3Ok5TuNCCEp5xnUXixsscFXykXSnBbu/KirY
	E1gZSaSXaQEjvXVJdnMSClGx5eZ8UPaQETfSS3REMx6nL4LqZOXr
X-Google-Smtp-Source: AGHT+IFDqD5NT+w/YCScMbz0etsmr/tPYi6Fhrdj9JvpJvKYC6RUwxM/wq2kNwbIVhhKmgn31rsXug==
X-Received: by 2002:a05:6871:3a14:b0:288:6365:d7a2 with SMTP id 586e51a60fabf-28ccba5169amr6011474fac.44.1729761977392;
        Thu, 24 Oct 2024 02:26:17 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:16 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] nilfs2: convert persistent object allocator to be folio-based
Date: Thu, 24 Oct 2024 18:25:38 +0900
Message-ID: <20241024092602.13395-5-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
References: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the persistent oject allocator, a common mechanism for
allocating objects in metadata files such as inodes and DAT entries,
convert the page-based implementation to a folio-based implementation.

In this conversion, helper functions nilfs_palloc_group_desc_offset()
and nilfs_palloc_bitmap_offset() are added and used to calculate the
byte offset within a folio of a group descriptor structure and bitmap,
respectively, to replace kmap_local_page with kmap_local_folio.

In addition, a helper function called nilfs_palloc_entry_offset() is
provided to facilitate common calculation of the byte offset within a
folio of metadata file entries managed in the persistent object
allocator format.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/alloc.c | 137 +++++++++++++++++++++++++++++-----------------
 fs/nilfs2/alloc.h |   2 +
 2 files changed, 89 insertions(+), 50 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index d30dfed707b6..5e0a6bd3e015 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -339,19 +339,55 @@ static int nilfs_palloc_delete_entry_block(struct inode *inode, __u64 nr)
 }
 
 /**
- * nilfs_palloc_block_get_group_desc - get kernel address of a group descriptor
+ * nilfs_palloc_group_desc_offset - calculate the byte offset of a group
+ *                                  descriptor in the folio containing it
  * @inode: inode of metadata file using this allocator
  * @group: group number
- * @bh: buffer head of the buffer storing the group descriptor block
- * @kaddr: kernel address mapped for the page including the buffer
+ * @bh:    buffer head of the group descriptor block
+ *
+ * Return: Byte offset in the folio of the group descriptor for @group.
  */
-static struct nilfs_palloc_group_desc *
-nilfs_palloc_block_get_group_desc(const struct inode *inode,
-				  unsigned long group,
-				  const struct buffer_head *bh, void *kaddr)
+static size_t nilfs_palloc_group_desc_offset(const struct inode *inode,
+					     unsigned long group,
+					     const struct buffer_head *bh)
 {
-	return (struct nilfs_palloc_group_desc *)(kaddr + bh_offset(bh)) +
-		group % nilfs_palloc_groups_per_desc_block(inode);
+	return offset_in_folio(bh->b_folio, bh->b_data) +
+		sizeof(struct nilfs_palloc_group_desc) *
+		(group % nilfs_palloc_groups_per_desc_block(inode));
+}
+
+/**
+ * nilfs_palloc_bitmap_offset - calculate the byte offset of a bitmap block
+ *                              in the folio containing it
+ * @bh: buffer head of the bitmap block
+ *
+ * Return: Byte offset in the folio of the bitmap block for @bh.
+ */
+static size_t nilfs_palloc_bitmap_offset(const struct buffer_head *bh)
+{
+	return offset_in_folio(bh->b_folio, bh->b_data);
+}
+
+/**
+ * nilfs_palloc_entry_offset - calculate the byte offset of an entry in the
+ *                             folio containing it
+ * @inode: inode of metadata file using this allocator
+ * @nr:    serial number of the entry (e.g. inode number)
+ * @bh:    buffer head of the entry block
+ *
+ * Return: Byte offset in the folio of the entry @nr.
+ */
+size_t nilfs_palloc_entry_offset(const struct inode *inode, __u64 nr,
+				 const struct buffer_head *bh)
+{
+	unsigned long entry_index_in_group, entry_index_in_block;
+
+	nilfs_palloc_group(inode, nr, &entry_index_in_group);
+	entry_index_in_block = entry_index_in_group %
+		NILFS_MDT(inode)->mi_entries_per_block;
+
+	return offset_in_folio(bh->b_folio, bh->b_data) +
+		entry_index_in_block * NILFS_MDT(inode)->mi_entry_size;
 }
 
 /**
@@ -508,7 +544,7 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
 	unsigned char *bitmap;
-	void *desc_kaddr, *bitmap_kaddr;
+	size_t doff, boff;
 	unsigned long group, maxgroup, ngroups;
 	unsigned long group_offset, maxgroup_offset;
 	unsigned long n, entries_per_group;
@@ -531,17 +567,17 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 		ret = nilfs_palloc_get_desc_block(inode, group, 1, &desc_bh);
 		if (ret < 0)
 			return ret;
-		desc_kaddr = kmap_local_page(desc_bh->b_page);
-		desc = nilfs_palloc_block_get_group_desc(
-			inode, group, desc_bh, desc_kaddr);
+
+		doff = nilfs_palloc_group_desc_offset(inode, group, desc_bh);
+		desc = kmap_local_folio(desc_bh->b_folio, doff);
 		n = nilfs_palloc_rest_groups_in_desc_block(inode, group,
 							   maxgroup);
-		for (j = 0; j < n; j++, desc++, group++, group_offset = 0) {
+		for (j = 0; j < n; j++, group++, group_offset = 0) {
 			lock = nilfs_mdt_bgl_lock(inode, group);
-			if (nilfs_palloc_group_desc_nfrees(desc, lock) == 0)
+			if (nilfs_palloc_group_desc_nfrees(&desc[j], lock) == 0)
 				continue;
 
-			kunmap_local(desc_kaddr);
+			kunmap_local(desc);
 			ret = nilfs_palloc_get_bitmap_block(inode, group, 1,
 							    &bitmap_bh);
 			if (unlikely(ret < 0)) {
@@ -549,12 +585,14 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 				return ret;
 			}
 
-			desc_kaddr = kmap_local_page(desc_bh->b_page);
-			desc = nilfs_palloc_block_get_group_desc(
-				inode, group, desc_bh, desc_kaddr);
+			/*
+			 * Re-kmap the folio containing the first (and
+			 * subsequent) group descriptors.
+			 */
+			desc = kmap_local_folio(desc_bh->b_folio, doff);
 
-			bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
-			bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
+			boff = nilfs_palloc_bitmap_offset(bitmap_bh);
+			bitmap = kmap_local_folio(bitmap_bh->b_folio, boff);
 			pos = nilfs_palloc_find_available_slot(
 				bitmap, group_offset, entries_per_group, lock,
 				wrap);
@@ -564,14 +602,14 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 			 * beginning, the wrap flag only has an effect on the
 			 * first search.
 			 */
-			kunmap_local(bitmap_kaddr);
+			kunmap_local(bitmap);
 			if (pos >= 0)
 				goto found;
 
 			brelse(bitmap_bh);
 		}
 
-		kunmap_local(desc_kaddr);
+		kunmap_local(desc);
 		brelse(desc_bh);
 	}
 
@@ -580,9 +618,9 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 
 found:
 	/* found a free entry */
-	nilfs_palloc_group_desc_add_entries(desc, lock, -1);
+	nilfs_palloc_group_desc_add_entries(&desc[j], lock, -1);
 	req->pr_entry_nr = entries_per_group * group + pos;
-	kunmap_local(desc_kaddr);
+	kunmap_local(desc);
 
 	req->pr_desc_bh = desc_bh;
 	req->pr_bitmap_bh = bitmap_bh;
@@ -613,18 +651,18 @@ void nilfs_palloc_commit_alloc_entry(struct inode *inode,
 void nilfs_palloc_commit_free_entry(struct inode *inode,
 				    struct nilfs_palloc_req *req)
 {
-	struct nilfs_palloc_group_desc *desc;
 	unsigned long group, group_offset;
+	size_t doff, boff;
+	struct nilfs_palloc_group_desc *desc;
 	unsigned char *bitmap;
-	void *desc_kaddr, *bitmap_kaddr;
 	spinlock_t *lock;
 
 	group = nilfs_palloc_group(inode, req->pr_entry_nr, &group_offset);
-	desc_kaddr = kmap_local_page(req->pr_desc_bh->b_page);
-	desc = nilfs_palloc_block_get_group_desc(inode, group,
-						 req->pr_desc_bh, desc_kaddr);
-	bitmap_kaddr = kmap_local_page(req->pr_bitmap_bh->b_page);
-	bitmap = bitmap_kaddr + bh_offset(req->pr_bitmap_bh);
+	doff = nilfs_palloc_group_desc_offset(inode, group, req->pr_desc_bh);
+	desc = kmap_local_folio(req->pr_desc_bh->b_folio, doff);
+
+	boff = nilfs_palloc_bitmap_offset(req->pr_bitmap_bh);
+	bitmap = kmap_local_folio(req->pr_bitmap_bh->b_folio, boff);
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
@@ -635,8 +673,8 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
-	kunmap_local(bitmap_kaddr);
-	kunmap_local(desc_kaddr);
+	kunmap_local(bitmap);
+	kunmap_local(desc);
 
 	mark_buffer_dirty(req->pr_desc_bh);
 	mark_buffer_dirty(req->pr_bitmap_bh);
@@ -655,17 +693,17 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 				    struct nilfs_palloc_req *req)
 {
 	struct nilfs_palloc_group_desc *desc;
-	void *desc_kaddr, *bitmap_kaddr;
+	size_t doff, boff;
 	unsigned char *bitmap;
 	unsigned long group, group_offset;
 	spinlock_t *lock;
 
 	group = nilfs_palloc_group(inode, req->pr_entry_nr, &group_offset);
-	desc_kaddr = kmap_local_page(req->pr_desc_bh->b_page);
-	desc = nilfs_palloc_block_get_group_desc(inode, group,
-						 req->pr_desc_bh, desc_kaddr);
-	bitmap_kaddr = kmap_local_page(req->pr_bitmap_bh->b_page);
-	bitmap = bitmap_kaddr + bh_offset(req->pr_bitmap_bh);
+	doff = nilfs_palloc_group_desc_offset(inode, group, req->pr_desc_bh);
+	desc = kmap_local_folio(req->pr_desc_bh->b_folio, doff);
+
+	boff = nilfs_palloc_bitmap_offset(req->pr_bitmap_bh);
+	bitmap = kmap_local_folio(req->pr_bitmap_bh->b_folio, boff);
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
@@ -676,8 +714,8 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
-	kunmap_local(bitmap_kaddr);
-	kunmap_local(desc_kaddr);
+	kunmap_local(bitmap);
+	kunmap_local(desc);
 
 	brelse(req->pr_bitmap_bh);
 	brelse(req->pr_desc_bh);
@@ -741,7 +779,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
 	unsigned char *bitmap;
-	void *desc_kaddr, *bitmap_kaddr;
+	size_t doff, boff;
 	unsigned long group, group_offset;
 	__u64 group_min_nr, last_nrs[8];
 	const unsigned long epg = nilfs_palloc_entries_per_group(inode);
@@ -769,8 +807,8 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		/* Get the first entry number of the group */
 		group_min_nr = (__u64)group * epg;
 
-		bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
-		bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
+		boff = nilfs_palloc_bitmap_offset(bitmap_bh);
+		bitmap = kmap_local_folio(bitmap_bh->b_folio, boff);
 		lock = nilfs_mdt_bgl_lock(inode, group);
 
 		j = i;
@@ -815,7 +853,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			entry_start = rounddown(group_offset, epb);
 		} while (true);
 
-		kunmap_local(bitmap_kaddr);
+		kunmap_local(bitmap);
 		mark_buffer_dirty(bitmap_bh);
 		brelse(bitmap_bh);
 
@@ -829,11 +867,10 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 					   inode->i_ino);
 		}
 
-		desc_kaddr = kmap_local_page(desc_bh->b_page);
-		desc = nilfs_palloc_block_get_group_desc(
-			inode, group, desc_bh, desc_kaddr);
+		doff = nilfs_palloc_group_desc_offset(inode, group, desc_bh);
+		desc = kmap_local_folio(desc_bh->b_folio, doff);
 		nfree = nilfs_palloc_group_desc_add_entries(desc, lock, n);
-		kunmap_local(desc_kaddr);
+		kunmap_local(desc);
 		mark_buffer_dirty(desc_bh);
 		nilfs_mdt_mark_dirty(inode);
 		brelse(desc_bh);
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index e19d7eb10084..af8f882619d4 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -33,6 +33,8 @@ int nilfs_palloc_get_entry_block(struct inode *, __u64, int,
 				 struct buffer_head **);
 void *nilfs_palloc_block_get_entry(const struct inode *, __u64,
 				   const struct buffer_head *, void *);
+size_t nilfs_palloc_entry_offset(const struct inode *inode, __u64 nr,
+				 const struct buffer_head *bh);
 
 int nilfs_palloc_count_max_entries(struct inode *, u64, u64 *);
 
-- 
2.43.0


