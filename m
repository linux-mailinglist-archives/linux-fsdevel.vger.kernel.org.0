Return-Path: <linux-fsdevel+bounces-32708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798A9AE094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE91F2447A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0E1B85DF;
	Thu, 24 Oct 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmnzwDvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF351B6CE5;
	Thu, 24 Oct 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761975; cv=none; b=pAeDHgwGYv+rJMrJdd6Bzvhs4UYiSgh0lFxKOM6vsBgd3QkKnCeH8rytrVZPW6Os2aQ5PgzFLAfVTK47XgFkJ1WiVoAxodtkAYRZeZx2AeYgjRf7zqhnU2QvaaINuiDEyHlRFRff1T9wrVH4f7gU6aQo2LOCQhUL4vK8PSzJnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761975; c=relaxed/simple;
	bh=dAuAbitdK04/Qrt+mcN9ml8VLwPLnqkBs+pQeXLRJ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eACG/TzTVNY4Cu8OFBPCVFcCS8jUH0z2fUxjlzG+pLrBSES/iU301tDHyF88x0cD3kRTapb7BWmkLXxtPvRPsOCBsAUbCunj/EwFNXERbbE3MguOwED2iSbMGLivQfT0TxYSw9uEybG8+UYzS7IbCP/EqmA1qX3+C55WxoXX0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmnzwDvl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso392667a12.1;
        Thu, 24 Oct 2024 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761972; x=1730366772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHfMBOD/PqNIJ26AHKOSrnJwh3FsZ7ICIL3IEGW9+OE=;
        b=MmnzwDvlNXQEzC7Hl0Q/UOlkiQnuN1Laa6+/nPDnZlk62LcmejUzGMrkHEmw10NWA0
         hqtg54PZgUIjVNB9AYPiPsGZ2923jUvNIAbfLVVrLJvtjNpKf7q2FPVkiQADkyEJ4pez
         aLE2FMmLecZrFUPvU0wPTJT2my3qu5KHJ5x0K9O1WC0+zYXMS9ro1Etw/WKuHXBUKIWI
         bESH0pkhuUSZ8YHqxv9TOUHXHaAjrx98Xy86gxAGduqL8XqvPE0sr8EpzWlG+t34Sg0J
         N+MOrAS38KVqg0LzsMnUnJQKaA5o1wJSRr3OUP6OwmAHFZY5fhtyQGCAckfjE1A45mrf
         V4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761972; x=1730366772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHfMBOD/PqNIJ26AHKOSrnJwh3FsZ7ICIL3IEGW9+OE=;
        b=nbgA0v9lU6C65ZoyKNNz6FpWy9ftFqttqKggdgM7EWqA0iiwzO+rOvIblJvg3dhJ5w
         KGx/U5WwYQjK83FXQigLfxewEbb3gwKrfLp5BnHFB3yiGW+QvJXnHs/FhIlCUoWG179D
         zKEDSaVYrfUyesXmrCxvHDGYmJwkr6Y0ln6RGKnT/BNXfPRR+MCwXReMpSvl5j7Ueq7K
         oSIFrnM6YGO8fhTk9b4V6uLz+Kf/zBhO7GOTy7cgnDPnQc74qitHjDECPHuXcOJTdIhT
         jZBusjz9rOt4UnM5yrNhUx6+2vJLjqhm5qJrep/2VZVNT0qH2Kf8A6GW6+n3/VSV5HiJ
         DQfw==
X-Forwarded-Encrypted: i=1; AJvYcCV1jN84FR20D7Q7n8RUkJru1/3OKLVVVCX87E+mKCJwqbvFwrm7xQjWsVmW/wgFYCEis9+r/En6bGp/vlc=@vger.kernel.org, AJvYcCWCyBc9y3i8Tu70YmFw53vgVmwqxZK94YgwjHKK5stpmPAGnNR9NQEJBBK5nV1tGT9ps6uLAfWfFzQb/JjT@vger.kernel.org, AJvYcCWse6fv2Y9oQPdNZa2fATbxXKCNt5op383zyNHdVLlZ9jIpDmwn3KuvHu+tqp4y5iTI6L4OCOSTqQNL8nde@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3JDGRIz6Uqre++lAy0w1sPasnE7KPgPa0X5gcs4njvKW3NoX
	ar6RpFjKJJXgbXkZ/e8fX2EWmYMf6R+VWaWou/VRKXmv2rgptkNFm9R5zA==
X-Google-Smtp-Source: AGHT+IGx0mmVGSkVPTW38b7zdZugzXCeoHUu/1sonYrx3QTIf8K0w3kKAen4zAsuZ6j2Spfj/dAPVQ==
X-Received: by 2002:a05:6a20:e347:b0:1cf:573a:bb58 with SMTP id adf61e73a8af0-1d978bae140mr6510610637.40.1729761972469;
        Thu, 24 Oct 2024 02:26:12 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:11 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] nilfs2: convert common metadata file code to be folio-based
Date: Thu, 24 Oct 2024 18:25:36 +0900
Message-ID: <20241024092602.13395-3-konishi.ryusuke@gmail.com>
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

In the common routines for metadata files,
nilfs_mdt_insert_new_block(), which inserts a new block buffer into
the cache, is still page-based, and there are two places where
bh_offset() is used.  Convert these to page-based.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/alloc.c  |  8 +++++---
 fs/nilfs2/cpfile.c |  4 ++--
 fs/nilfs2/mdt.c    | 21 +++++++++++++--------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index ba50388ee4bf..d30dfed707b6 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -177,12 +177,14 @@ nilfs_palloc_entry_blkoff(const struct inode *inode, __u64 nr)
  * nilfs_palloc_desc_block_init - initialize buffer of a group descriptor block
  * @inode: inode of metadata file
  * @bh: buffer head of the buffer to be initialized
- * @kaddr: kernel address mapped for the page including the buffer
+ * @from: kernel address mapped for a chunk of the block
+ *
+ * This function does not yet support the case where block size > PAGE_SIZE.
  */
 static void nilfs_palloc_desc_block_init(struct inode *inode,
-					 struct buffer_head *bh, void *kaddr)
+					 struct buffer_head *bh, void *from)
 {
-	struct nilfs_palloc_group_desc *desc = kaddr + bh_offset(bh);
+	struct nilfs_palloc_group_desc *desc = from;
 	unsigned long n = nilfs_palloc_groups_per_desc_block(inode);
 	__le32 nfrees;
 
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index f0ce37552446..a8046cbf2753 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -113,9 +113,9 @@ nilfs_cpfile_block_get_checkpoint(const struct inode *cpfile, __u64 cno,
 
 static void nilfs_cpfile_block_init(struct inode *cpfile,
 				    struct buffer_head *bh,
-				    void *kaddr)
+				    void *from)
 {
-	struct nilfs_checkpoint *cp = kaddr + bh_offset(bh);
+	struct nilfs_checkpoint *cp = from;
 	size_t cpsz = NILFS_MDT(cpfile)->mi_entry_size;
 	int n = nilfs_cpfile_checkpoints_per_block(cpfile);
 
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index ceb7dc0b5bad..a4c1e00aaaac 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -33,7 +33,8 @@ nilfs_mdt_insert_new_block(struct inode *inode, unsigned long block,
 					      struct buffer_head *, void *))
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
-	void *kaddr;
+	struct folio *folio = bh->b_folio;
+	void *from;
 	int ret;
 
 	/* Caller exclude read accesses using page lock */
@@ -47,12 +48,14 @@ nilfs_mdt_insert_new_block(struct inode *inode, unsigned long block,
 
 	set_buffer_mapped(bh);
 
-	kaddr = kmap_local_page(bh->b_page);
-	memset(kaddr + bh_offset(bh), 0, i_blocksize(inode));
+	/* Initialize block (block size > PAGE_SIZE not yet supported) */
+	from = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
+	memset(from, 0, bh->b_size);
 	if (init_block)
-		init_block(inode, bh, kaddr);
-	flush_dcache_page(bh->b_page);
-	kunmap_local(kaddr);
+		init_block(inode, bh, from);
+	kunmap_local(from);
+
+	flush_dcache_folio(folio);
 
 	set_buffer_uptodate(bh);
 	mark_buffer_dirty(bh);
@@ -571,7 +574,8 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 	if (!bh_frozen)
 		bh_frozen = create_empty_buffers(folio, 1 << blkbits, 0);
 
-	bh_frozen = get_nth_bh(bh_frozen, bh_offset(bh) >> blkbits);
+	bh_frozen = get_nth_bh(bh_frozen,
+			       offset_in_folio(folio, bh->b_data) >> blkbits);
 
 	if (!buffer_uptodate(bh_frozen))
 		nilfs_copy_buffer(bh_frozen, bh);
@@ -601,7 +605,8 @@ nilfs_mdt_get_frozen_buffer(struct inode *inode, struct buffer_head *bh)
 	if (!IS_ERR(folio)) {
 		bh_frozen = folio_buffers(folio);
 		if (bh_frozen) {
-			n = bh_offset(bh) >> inode->i_blkbits;
+			n = offset_in_folio(folio, bh->b_data) >>
+				inode->i_blkbits;
 			bh_frozen = get_nth_bh(bh_frozen, n);
 		}
 		folio_unlock(folio);
-- 
2.43.0


