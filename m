Return-Path: <linux-fsdevel+bounces-32714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A966B9AE0A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0501F24607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7D1CACD4;
	Thu, 24 Oct 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxoFnObn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EB1C75F9;
	Thu, 24 Oct 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761991; cv=none; b=rkGjUZFbM58dfgKkF0Ws1vvS5qRlxLJbXNKNrXq2ROk/Bh9IiAtaa5gwppzxGXLSha/5XzeKfVAviPQIjCRJPOSMvySWdtiIEyC3virr3gEPlszRIyZ8340juTzokKFeEBTh8CmoW1lpgRYG0fyE+Xcgfidry9T2FxF5/1WPPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761991; c=relaxed/simple;
	bh=Syw4GyotNgDMewrm2WfebnZtMBQ5lp2jvq84CsU4/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuFRAI85MVt1+vU3+yo2OADnGOrYwUfy9Uu57rC4CgH4GtHHrjtr+0DR18cTHrXyn8n62cbfv5jWTQiTinBiHviYbLRjyguwk24jNc1Jg+An045xLwi++AYffP6EiJDDqMBt7vGzJ9+7bmN5nTrmzudObU93ZE9ALKMkRZQAif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxoFnObn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so517860b3a.0;
        Thu, 24 Oct 2024 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761987; x=1730366787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HCAS6C7GITEkTSee22mjEQINZktMD4P7+akevVqk6c=;
        b=gxoFnObnp3hI5ukRTJcvBEmglgv59f3qKLZWjF5twGI2k2hyp4BegYNCWPUcMdNyjo
         4viXVa4qlai/fO+aCsMEEb2n3KwjM7rj8INia3dqPRkGnshJESx6yZtLQnjVU6ZJcdZ5
         21s6epkA+B8tnK+JAp6+6YxfK0rnRmahCIfYWOSznkMpfsmQf3OTbUEXv1hZ7RTtZUQo
         +5jkNsYMBtN97OsNwVSMpasln9nLRVUymSQ8bxn4Dd70uTt8rpU/heB5klmT+yFktgUr
         6gGrQ8bYKx0pFGQ9oF8UqkVxjAiOqyRrfYnXpf3RtZVupEgWCpZi1/+HjrKsf5Qnp9V2
         /2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761987; x=1730366787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HCAS6C7GITEkTSee22mjEQINZktMD4P7+akevVqk6c=;
        b=cMRgn/0sy3RTvcvQ8Vt2vPq2JtuAhkT3Y8oZn3aGLyHosL85Hyr2CWoVrb+5Cl1bY1
         BCFdkhbNYCg2ONgUrEtcRd8kVq8Z5hjOfHvLHBhi4EMKPW6TneR1VFQZiv6bMyDlaWBi
         d4FkNvdO0OxgjfsJmIVhMEyOZvSTpNDvEpMi1J1G5DWzbxl8Kcw3hdUlY2n3eKC9l4Ta
         G7rxfGaAymeqSP+RDUYi9PnWj5fP249JSXs74d9ptGEbv281xc5+eYrrjKyaRXER5MBL
         AoxeyA5PrVUJvLJgeVGfR9byxYY/j1tRFkyUYbnvf1u5CD6uEJXWB/PER1DbDEL62cV2
         zhwA==
X-Forwarded-Encrypted: i=1; AJvYcCUqZYJNziuwBNvg6WkicOZ8Fg7asTFnrKclAdXmzN9FRc2clANA1GChOPTWE4TmgTNXfIBg4vPXqK4vljtO@vger.kernel.org, AJvYcCVzi4FeyIuydQ+Xv2e1w8yWNJz9RbeTBxp0EobmAWpOPiyfGdxqDVVFuk4xtt46QDToa0FszD/VqX2ohe3L@vger.kernel.org, AJvYcCXgwroUMFrjB/itSWA8Fgob/Y4CpWCipvq9D+PGPIBC/zLTuqcYrm3hswtjd2ZyN8LphdAsZJVIYuYMZa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnzJP7hsRaMN8Fw5bo37KsYFVjoUSmkdBufMHB07jcyKoaYW7
	bSphXT16Hae7X4u7wloHZNVSijxvWrujQo4LadvvALyUbirsb1wSIejnog==
X-Google-Smtp-Source: AGHT+IFeIypfH8v9Nrynkx/2/y18iRnMBFTkFgBHuG0MiTYRxM6iB+YHmF68Bk2y2ckF8hq6/EwtUA==
X-Received: by 2002:a05:6a00:22d3:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-72030b62bffmr7918748b3a.2.1729761986935;
        Thu, 24 Oct 2024 02:26:26 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:26 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] nilfs2: convert checkpoint file to be folio-based
Date: Thu, 24 Oct 2024 18:25:42 +0900
Message-ID: <20241024092602.13395-9-konishi.ryusuke@gmail.com>
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

Regarding the cpfile, a metadata file that manages checkpoints, convert
the page-based implementation to a folio-based implementation.

This change involves some helper functions to calculate byte offsets on
folios and removing a few helper functions that are no longer needed.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/cpfile.c | 379 ++++++++++++++++++++++++---------------------
 1 file changed, 204 insertions(+), 175 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index a8046cbf2753..c20207d7a989 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -68,49 +68,36 @@ static inline int nilfs_cpfile_is_in_first(const struct inode *cpfile,
 static unsigned int
 nilfs_cpfile_block_add_valid_checkpoints(const struct inode *cpfile,
 					 struct buffer_head *bh,
-					 void *kaddr,
 					 unsigned int n)
 {
-	struct nilfs_checkpoint *cp = kaddr + bh_offset(bh);
+	struct nilfs_checkpoint *cp;
 	unsigned int count;
 
+	cp = kmap_local_folio(bh->b_folio,
+			      offset_in_folio(bh->b_folio, bh->b_data));
 	count = le32_to_cpu(cp->cp_checkpoints_count) + n;
 	cp->cp_checkpoints_count = cpu_to_le32(count);
+	kunmap_local(cp);
 	return count;
 }
 
 static unsigned int
 nilfs_cpfile_block_sub_valid_checkpoints(const struct inode *cpfile,
 					 struct buffer_head *bh,
-					 void *kaddr,
 					 unsigned int n)
 {
-	struct nilfs_checkpoint *cp = kaddr + bh_offset(bh);
+	struct nilfs_checkpoint *cp;
 	unsigned int count;
 
+	cp = kmap_local_folio(bh->b_folio,
+			      offset_in_folio(bh->b_folio, bh->b_data));
 	WARN_ON(le32_to_cpu(cp->cp_checkpoints_count) < n);
 	count = le32_to_cpu(cp->cp_checkpoints_count) - n;
 	cp->cp_checkpoints_count = cpu_to_le32(count);
+	kunmap_local(cp);
 	return count;
 }
 
-static inline struct nilfs_cpfile_header *
-nilfs_cpfile_block_get_header(const struct inode *cpfile,
-			      struct buffer_head *bh,
-			      void *kaddr)
-{
-	return kaddr + bh_offset(bh);
-}
-
-static struct nilfs_checkpoint *
-nilfs_cpfile_block_get_checkpoint(const struct inode *cpfile, __u64 cno,
-				  struct buffer_head *bh,
-				  void *kaddr)
-{
-	return kaddr + bh_offset(bh) + nilfs_cpfile_get_offset(cpfile, cno) *
-		NILFS_MDT(cpfile)->mi_entry_size;
-}
-
 static void nilfs_cpfile_block_init(struct inode *cpfile,
 				    struct buffer_head *bh,
 				    void *from)
@@ -125,6 +112,54 @@ static void nilfs_cpfile_block_init(struct inode *cpfile,
 	}
 }
 
+/**
+ * nilfs_cpfile_checkpoint_offset - calculate the byte offset of a checkpoint
+ *                                  entry in the folio containing it
+ * @cpfile: checkpoint file inode
+ * @cno:    checkpoint number
+ * @bh:     buffer head of block containing checkpoint indexed by @cno
+ *
+ * Return: Byte offset in the folio of the checkpoint specified by @cno.
+ */
+static size_t nilfs_cpfile_checkpoint_offset(const struct inode *cpfile,
+					     __u64 cno,
+					     struct buffer_head *bh)
+{
+	return offset_in_folio(bh->b_folio, bh->b_data) +
+		nilfs_cpfile_get_offset(cpfile, cno) *
+		NILFS_MDT(cpfile)->mi_entry_size;
+}
+
+/**
+ * nilfs_cpfile_cp_snapshot_list_offset - calculate the byte offset of a
+ *                                        checkpoint snapshot list in the folio
+ *                                        containing it
+ * @cpfile: checkpoint file inode
+ * @cno:    checkpoint number
+ * @bh:     buffer head of block containing checkpoint indexed by @cno
+ *
+ * Return: Byte offset in the folio of the checkpoint snapshot list specified
+ *         by @cno.
+ */
+static size_t nilfs_cpfile_cp_snapshot_list_offset(const struct inode *cpfile,
+						   __u64 cno,
+						   struct buffer_head *bh)
+{
+	return nilfs_cpfile_checkpoint_offset(cpfile, cno, bh) +
+		offsetof(struct nilfs_checkpoint, cp_snapshot_list);
+}
+
+/**
+ * nilfs_cpfile_ch_snapshot_list_offset - calculate the byte offset of the
+ *                                        snapshot list in the header
+ *
+ * Return: Byte offset in the folio of the checkpoint snapshot list
+ */
+static size_t nilfs_cpfile_ch_snapshot_list_offset(void)
+{
+	return offsetof(struct nilfs_cpfile_header, ch_snapshot_list);
+}
+
 static int nilfs_cpfile_get_header_block(struct inode *cpfile,
 					 struct buffer_head **bhp)
 {
@@ -214,7 +249,7 @@ int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
 {
 	struct buffer_head *cp_bh;
 	struct nilfs_checkpoint *cp;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	if (cno < 1 || cno > nilfs_mdt_cno(cpfile))
@@ -228,8 +263,8 @@ int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
 		goto out_sem;
 	}
 
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	if (nilfs_checkpoint_invalid(cp)) {
 		ret = -EINVAL;
 		goto put_cp;
@@ -254,7 +289,7 @@ int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
 	root->ifile = ifile;
 
 put_cp:
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 	brelse(cp_bh);
 out_sem:
 	up_read(&NILFS_MDT(cpfile)->mi_sem);
@@ -282,7 +317,7 @@ int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno)
 	struct buffer_head *header_bh, *cp_bh;
 	struct nilfs_cpfile_header *header;
 	struct nilfs_checkpoint *cp;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	if (WARN_ON_ONCE(cno < 1))
@@ -297,24 +332,22 @@ int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno)
 	if (unlikely(ret < 0))
 		goto out_header;
 
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	if (nilfs_checkpoint_invalid(cp)) {
 		/* a newly-created checkpoint */
 		nilfs_checkpoint_clear_invalid(cp);
+		kunmap_local(cp);
 		if (!nilfs_cpfile_is_in_first(cpfile, cno))
 			nilfs_cpfile_block_add_valid_checkpoints(cpfile, cp_bh,
-								 kaddr, 1);
-		kunmap_local(kaddr);
+								 1);
 
-		kaddr = kmap_local_page(header_bh->b_page);
-		header = nilfs_cpfile_block_get_header(cpfile, header_bh,
-						       kaddr);
+		header = kmap_local_folio(header_bh->b_folio, 0);
 		le64_add_cpu(&header->ch_ncheckpoints, 1);
-		kunmap_local(kaddr);
+		kunmap_local(header);
 		mark_buffer_dirty(header_bh);
 	} else {
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 	}
 
 	/* Force the buffer and the inode to become dirty */
@@ -353,7 +386,7 @@ int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
 {
 	struct buffer_head *cp_bh;
 	struct nilfs_checkpoint *cp;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	if (WARN_ON_ONCE(cno < 1))
@@ -367,10 +400,10 @@ int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
 		goto out_sem;
 	}
 
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	if (unlikely(nilfs_checkpoint_invalid(cp))) {
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 		brelse(cp_bh);
 		goto error;
 	}
@@ -391,7 +424,7 @@ int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
 	nilfs_write_inode_common(root->ifile, &cp->cp_ifile_inode);
 	nilfs_bmap_write(NILFS_I(root->ifile)->i_bmap, &cp->cp_ifile_inode);
 
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 	brelse(cp_bh);
 out_sem:
 	up_write(&NILFS_MDT(cpfile)->mi_sem);
@@ -432,6 +465,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 	struct nilfs_checkpoint *cp;
 	size_t cpsz = NILFS_MDT(cpfile)->mi_entry_size;
 	__u64 cno;
+	size_t offset;
 	void *kaddr;
 	unsigned long tnicps;
 	int ret, ncps, nicps, nss, count, i;
@@ -462,9 +496,8 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 			continue;
 		}
 
-		kaddr = kmap_local_page(cp_bh->b_page);
-		cp = nilfs_cpfile_block_get_checkpoint(
-			cpfile, cno, cp_bh, kaddr);
+		offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+		cp = kaddr = kmap_local_folio(cp_bh->b_folio, offset);
 		nicps = 0;
 		for (i = 0; i < ncps; i++, cp = (void *)cp + cpsz) {
 			if (nilfs_checkpoint_snapshot(cp)) {
@@ -474,43 +507,42 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 				nicps++;
 			}
 		}
-		if (nicps > 0) {
-			tnicps += nicps;
-			mark_buffer_dirty(cp_bh);
-			nilfs_mdt_mark_dirty(cpfile);
-			if (!nilfs_cpfile_is_in_first(cpfile, cno)) {
-				count =
-				  nilfs_cpfile_block_sub_valid_checkpoints(
-						cpfile, cp_bh, kaddr, nicps);
-				if (count == 0) {
-					/* make hole */
-					kunmap_local(kaddr);
-					brelse(cp_bh);
-					ret =
-					  nilfs_cpfile_delete_checkpoint_block(
-								   cpfile, cno);
-					if (ret == 0)
-						continue;
-					nilfs_err(cpfile->i_sb,
-						  "error %d deleting checkpoint block",
-						  ret);
-					break;
-				}
-			}
+		kunmap_local(kaddr);
+
+		if (nicps <= 0) {
+			brelse(cp_bh);
+			continue;
 		}
 
-		kunmap_local(kaddr);
+		tnicps += nicps;
+		mark_buffer_dirty(cp_bh);
+		nilfs_mdt_mark_dirty(cpfile);
+		if (nilfs_cpfile_is_in_first(cpfile, cno)) {
+			brelse(cp_bh);
+			continue;
+		}
+
+		count = nilfs_cpfile_block_sub_valid_checkpoints(cpfile, cp_bh,
+								 nicps);
 		brelse(cp_bh);
+		if (count)
+			continue;
+
+		/* Delete the block if there are no more valid checkpoints */
+		ret = nilfs_cpfile_delete_checkpoint_block(cpfile, cno);
+		if (unlikely(ret)) {
+			nilfs_err(cpfile->i_sb,
+				  "error %d deleting checkpoint block", ret);
+			break;
+		}
 	}
 
 	if (tnicps > 0) {
-		kaddr = kmap_local_page(header_bh->b_page);
-		header = nilfs_cpfile_block_get_header(cpfile, header_bh,
-						       kaddr);
+		header = kmap_local_folio(header_bh->b_folio, 0);
 		le64_add_cpu(&header->ch_ncheckpoints, -(u64)tnicps);
 		mark_buffer_dirty(header_bh);
 		nilfs_mdt_mark_dirty(cpfile);
-		kunmap_local(kaddr);
+		kunmap_local(header);
 	}
 
 	brelse(header_bh);
@@ -544,6 +576,7 @@ static ssize_t nilfs_cpfile_do_get_cpinfo(struct inode *cpfile, __u64 *cnop,
 	struct buffer_head *bh;
 	size_t cpsz = NILFS_MDT(cpfile)->mi_entry_size;
 	__u64 cur_cno = nilfs_mdt_cno(cpfile), cno = *cnop;
+	size_t offset;
 	void *kaddr;
 	int n, ret;
 	int ncps, i;
@@ -562,8 +595,8 @@ static ssize_t nilfs_cpfile_do_get_cpinfo(struct inode *cpfile, __u64 *cnop,
 		}
 		ncps = nilfs_cpfile_checkpoints_in_block(cpfile, cno, cur_cno);
 
-		kaddr = kmap_local_page(bh->b_page);
-		cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, bh, kaddr);
+		offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, bh);
+		cp = kaddr = kmap_local_folio(bh->b_folio, offset);
 		for (i = 0; i < ncps && n < nci; i++, cp = (void *)cp + cpsz) {
 			if (!nilfs_checkpoint_invalid(cp)) {
 				nilfs_cpfile_checkpoint_to_cpinfo(cpfile, cp,
@@ -597,7 +630,7 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 	struct nilfs_cpinfo *ci = buf;
 	__u64 curr = *cnop, next;
 	unsigned long curr_blkoff, next_blkoff;
-	void *kaddr;
+	size_t offset;
 	int n = 0, ret;
 
 	down_read(&NILFS_MDT(cpfile)->mi_sem);
@@ -606,10 +639,9 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 		ret = nilfs_cpfile_get_header_block(cpfile, &bh);
 		if (ret < 0)
 			goto out;
-		kaddr = kmap_local_page(bh->b_page);
-		header = nilfs_cpfile_block_get_header(cpfile, bh, kaddr);
+		header = kmap_local_folio(bh->b_folio, 0);
 		curr = le64_to_cpu(header->ch_snapshot_list.ssl_next);
-		kunmap_local(kaddr);
+		kunmap_local(header);
 		brelse(bh);
 		if (curr == 0) {
 			ret = 0;
@@ -627,9 +659,9 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 			ret = 0; /* No snapshots (started from a hole block) */
 		goto out;
 	}
-	kaddr = kmap_local_page(bh->b_page);
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, curr, bh);
+	cp = kmap_local_folio(bh->b_folio, offset);
 	while (n < nci) {
-		cp = nilfs_cpfile_block_get_checkpoint(cpfile, curr, bh, kaddr);
 		curr = ~(__u64)0; /* Terminator */
 		if (unlikely(nilfs_checkpoint_invalid(cp) ||
 			     !nilfs_checkpoint_snapshot(cp)))
@@ -641,9 +673,9 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 		if (next == 0)
 			break; /* reach end of the snapshot list */
 
+		kunmap_local(cp);
 		next_blkoff = nilfs_cpfile_get_blkoff(cpfile, next);
 		if (curr_blkoff != next_blkoff) {
-			kunmap_local(kaddr);
 			brelse(bh);
 			ret = nilfs_cpfile_get_checkpoint_block(cpfile, next,
 								0, &bh);
@@ -651,12 +683,13 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 				WARN_ON(ret == -ENOENT);
 				goto out;
 			}
-			kaddr = kmap_local_page(bh->b_page);
 		}
+		offset = nilfs_cpfile_checkpoint_offset(cpfile, next, bh);
+		cp = kmap_local_folio(bh->b_folio, offset);
 		curr = next;
 		curr_blkoff = next_blkoff;
 	}
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 	brelse(bh);
 	*cnop = curr;
 	ret = n;
@@ -733,26 +766,6 @@ int nilfs_cpfile_delete_checkpoint(struct inode *cpfile, __u64 cno)
 	return nilfs_cpfile_delete_checkpoints(cpfile, cno, cno + 1);
 }
 
-static struct nilfs_snapshot_list *
-nilfs_cpfile_block_get_snapshot_list(const struct inode *cpfile,
-				     __u64 cno,
-				     struct buffer_head *bh,
-				     void *kaddr)
-{
-	struct nilfs_cpfile_header *header;
-	struct nilfs_checkpoint *cp;
-	struct nilfs_snapshot_list *list;
-
-	if (cno != 0) {
-		cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, bh, kaddr);
-		list = &cp->cp_snapshot_list;
-	} else {
-		header = nilfs_cpfile_block_get_header(cpfile, bh, kaddr);
-		list = &header->ch_snapshot_list;
-	}
-	return list;
-}
-
 static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 {
 	struct buffer_head *header_bh, *curr_bh, *prev_bh, *cp_bh;
@@ -761,94 +774,103 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 	struct nilfs_snapshot_list *list;
 	__u64 curr, prev;
 	unsigned long curr_blkoff, prev_blkoff;
-	void *kaddr;
+	size_t offset, curr_list_offset, prev_list_offset;
 	int ret;
 
 	if (cno == 0)
 		return -ENOENT; /* checkpoint number 0 is invalid */
 	down_write(&NILFS_MDT(cpfile)->mi_sem);
 
+	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
+	if (unlikely(ret < 0))
+		goto out_sem;
+
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
 	if (ret < 0)
-		goto out_sem;
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+		goto out_header;
+
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	if (nilfs_checkpoint_invalid(cp)) {
 		ret = -ENOENT;
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 		goto out_cp;
 	}
 	if (nilfs_checkpoint_snapshot(cp)) {
 		ret = 0;
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 		goto out_cp;
 	}
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 
-	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
-	if (ret < 0)
-		goto out_cp;
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
+	/*
+	 * Find the last snapshot before the checkpoint being changed to
+	 * snapshot mode by going backwards through the snapshot list.
+	 * Set "prev" to its checkpoint number, or 0 if not found.
+	 */
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	list = &header->ch_snapshot_list;
 	curr_bh = header_bh;
 	get_bh(curr_bh);
 	curr = 0;
 	curr_blkoff = 0;
+	curr_list_offset = nilfs_cpfile_ch_snapshot_list_offset();
 	prev = le64_to_cpu(list->ssl_prev);
 	while (prev > cno) {
 		prev_blkoff = nilfs_cpfile_get_blkoff(cpfile, prev);
 		curr = prev;
+		kunmap_local(list);
 		if (curr_blkoff != prev_blkoff) {
-			kunmap_local(kaddr);
 			brelse(curr_bh);
 			ret = nilfs_cpfile_get_checkpoint_block(cpfile, curr,
 								0, &curr_bh);
-			if (ret < 0)
-				goto out_header;
-			kaddr = kmap_local_page(curr_bh->b_page);
+			if (unlikely(ret < 0))
+				goto out_cp;
 		}
+		curr_list_offset = nilfs_cpfile_cp_snapshot_list_offset(
+			cpfile, curr, curr_bh);
+		list = kmap_local_folio(curr_bh->b_folio, curr_list_offset);
 		curr_blkoff = prev_blkoff;
-		cp = nilfs_cpfile_block_get_checkpoint(
-			cpfile, curr, curr_bh, kaddr);
-		list = &cp->cp_snapshot_list;
 		prev = le64_to_cpu(list->ssl_prev);
 	}
-	kunmap_local(kaddr);
+	kunmap_local(list);
 
 	if (prev != 0) {
 		ret = nilfs_cpfile_get_checkpoint_block(cpfile, prev, 0,
 							&prev_bh);
 		if (ret < 0)
 			goto out_curr;
+
+		prev_list_offset = nilfs_cpfile_cp_snapshot_list_offset(
+			cpfile, prev, prev_bh);
 	} else {
 		prev_bh = header_bh;
 		get_bh(prev_bh);
+		prev_list_offset = nilfs_cpfile_ch_snapshot_list_offset();
 	}
 
-	kaddr = kmap_local_page(curr_bh->b_page);
-	list = nilfs_cpfile_block_get_snapshot_list(
-		cpfile, curr, curr_bh, kaddr);
+	/* Update the list entry for the next snapshot */
+	list = kmap_local_folio(curr_bh->b_folio, curr_list_offset);
 	list->ssl_prev = cpu_to_le64(cno);
-	kunmap_local(kaddr);
+	kunmap_local(list);
 
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	/* Update the checkpoint being changed to a snapshot */
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	cp->cp_snapshot_list.ssl_next = cpu_to_le64(curr);
 	cp->cp_snapshot_list.ssl_prev = cpu_to_le64(prev);
 	nilfs_checkpoint_set_snapshot(cp);
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 
-	kaddr = kmap_local_page(prev_bh->b_page);
-	list = nilfs_cpfile_block_get_snapshot_list(
-		cpfile, prev, prev_bh, kaddr);
+	/* Update the list entry for the previous snapshot */
+	list = kmap_local_folio(prev_bh->b_folio, prev_list_offset);
 	list->ssl_next = cpu_to_le64(cno);
-	kunmap_local(kaddr);
+	kunmap_local(list);
 
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
+	/* Update the statistics in the header */
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	le64_add_cpu(&header->ch_nsnapshots, 1);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 
 	mark_buffer_dirty(prev_bh);
 	mark_buffer_dirty(curr_bh);
@@ -861,12 +883,12 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
  out_curr:
 	brelse(curr_bh);
 
- out_header:
-	brelse(header_bh);
-
  out_cp:
 	brelse(cp_bh);
 
+ out_header:
+	brelse(header_bh);
+
  out_sem:
 	up_write(&NILFS_MDT(cpfile)->mi_sem);
 	return ret;
@@ -879,79 +901,87 @@ static int nilfs_cpfile_clear_snapshot(struct inode *cpfile, __u64 cno)
 	struct nilfs_checkpoint *cp;
 	struct nilfs_snapshot_list *list;
 	__u64 next, prev;
-	void *kaddr;
+	size_t offset, next_list_offset, prev_list_offset;
 	int ret;
 
 	if (cno == 0)
 		return -ENOENT; /* checkpoint number 0 is invalid */
 	down_write(&NILFS_MDT(cpfile)->mi_sem);
 
+	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
+	if (unlikely(ret < 0))
+		goto out_sem;
+
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
 	if (ret < 0)
-		goto out_sem;
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+		goto out_header;
+
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, cp_bh);
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	if (nilfs_checkpoint_invalid(cp)) {
 		ret = -ENOENT;
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 		goto out_cp;
 	}
 	if (!nilfs_checkpoint_snapshot(cp)) {
 		ret = 0;
-		kunmap_local(kaddr);
+		kunmap_local(cp);
 		goto out_cp;
 	}
 
 	list = &cp->cp_snapshot_list;
 	next = le64_to_cpu(list->ssl_next);
 	prev = le64_to_cpu(list->ssl_prev);
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 
-	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
-	if (ret < 0)
-		goto out_cp;
 	if (next != 0) {
 		ret = nilfs_cpfile_get_checkpoint_block(cpfile, next, 0,
 							&next_bh);
 		if (ret < 0)
-			goto out_header;
+			goto out_cp;
+
+		next_list_offset = nilfs_cpfile_cp_snapshot_list_offset(
+			cpfile, next, next_bh);
 	} else {
 		next_bh = header_bh;
 		get_bh(next_bh);
+		next_list_offset = nilfs_cpfile_ch_snapshot_list_offset();
 	}
 	if (prev != 0) {
 		ret = nilfs_cpfile_get_checkpoint_block(cpfile, prev, 0,
 							&prev_bh);
 		if (ret < 0)
 			goto out_next;
+
+		prev_list_offset = nilfs_cpfile_cp_snapshot_list_offset(
+			cpfile, prev, prev_bh);
 	} else {
 		prev_bh = header_bh;
 		get_bh(prev_bh);
+		prev_list_offset = nilfs_cpfile_ch_snapshot_list_offset();
 	}
 
-	kaddr = kmap_local_page(next_bh->b_page);
-	list = nilfs_cpfile_block_get_snapshot_list(
-		cpfile, next, next_bh, kaddr);
+	/* Update the list entry for the next snapshot */
+	list = kmap_local_folio(next_bh->b_folio, next_list_offset);
 	list->ssl_prev = cpu_to_le64(prev);
-	kunmap_local(kaddr);
+	kunmap_local(list);
 
-	kaddr = kmap_local_page(prev_bh->b_page);
-	list = nilfs_cpfile_block_get_snapshot_list(
-		cpfile, prev, prev_bh, kaddr);
+	/* Update the list entry for the previous snapshot */
+	list = kmap_local_folio(prev_bh->b_folio, prev_list_offset);
 	list->ssl_next = cpu_to_le64(next);
-	kunmap_local(kaddr);
+	kunmap_local(list);
 
-	kaddr = kmap_local_page(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	/* Update the snapshot being changed back to a plain checkpoint */
+	cp = kmap_local_folio(cp_bh->b_folio, offset);
 	cp->cp_snapshot_list.ssl_next = cpu_to_le64(0);
 	cp->cp_snapshot_list.ssl_prev = cpu_to_le64(0);
 	nilfs_checkpoint_clear_snapshot(cp);
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
+	/* Update the statistics in the header */
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	le64_add_cpu(&header->ch_nsnapshots, -1);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 
 	mark_buffer_dirty(next_bh);
 	mark_buffer_dirty(prev_bh);
@@ -964,12 +994,12 @@ static int nilfs_cpfile_clear_snapshot(struct inode *cpfile, __u64 cno)
  out_next:
 	brelse(next_bh);
 
- out_header:
-	brelse(header_bh);
-
  out_cp:
 	brelse(cp_bh);
 
+ out_header:
+	brelse(header_bh);
+
  out_sem:
 	up_write(&NILFS_MDT(cpfile)->mi_sem);
 	return ret;
@@ -990,7 +1020,7 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
 {
 	struct buffer_head *bh;
 	struct nilfs_checkpoint *cp;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	/*
@@ -1004,13 +1034,14 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &bh);
 	if (ret < 0)
 		goto out;
-	kaddr = kmap_local_page(bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, bh, kaddr);
+
+	offset = nilfs_cpfile_checkpoint_offset(cpfile, cno, bh);
+	cp = kmap_local_folio(bh->b_folio, offset);
 	if (nilfs_checkpoint_invalid(cp))
 		ret = -ENOENT;
 	else
 		ret = nilfs_checkpoint_snapshot(cp);
-	kunmap_local(kaddr);
+	kunmap_local(cp);
 	brelse(bh);
 
  out:
@@ -1079,7 +1110,6 @@ int nilfs_cpfile_get_stat(struct inode *cpfile, struct nilfs_cpstat *cpstat)
 {
 	struct buffer_head *bh;
 	struct nilfs_cpfile_header *header;
-	void *kaddr;
 	int ret;
 
 	down_read(&NILFS_MDT(cpfile)->mi_sem);
@@ -1087,12 +1117,11 @@ int nilfs_cpfile_get_stat(struct inode *cpfile, struct nilfs_cpstat *cpstat)
 	ret = nilfs_cpfile_get_header_block(cpfile, &bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_local_page(bh->b_page);
-	header = nilfs_cpfile_block_get_header(cpfile, bh, kaddr);
+	header = kmap_local_folio(bh->b_folio, 0);
 	cpstat->cs_cno = nilfs_mdt_cno(cpfile);
 	cpstat->cs_ncps = le64_to_cpu(header->ch_ncheckpoints);
 	cpstat->cs_nsss = le64_to_cpu(header->ch_nsnapshots);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 	brelse(bh);
 
  out_sem:
-- 
2.43.0


