Return-Path: <linux-fsdevel+bounces-32712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E877F9AE0A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1377A1C22493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B991C4A2D;
	Thu, 24 Oct 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdxfDyoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E481B394F;
	Thu, 24 Oct 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761985; cv=none; b=S/nl2HBjovT8VhoAYudxAnTO9DrL7ytQsw+a10Juc7xCEK/dMXBjJvBYBK9GdgKRSBx3K27KHmLIB2DMIigSWf9kwas/EhNHw/dBUIBODGS6/NNDHthyVXKf0D5hFzYCEo+1w8+OCsNv9habtoxXl5rYk8gz9QgxqIL6WbHWko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761985; c=relaxed/simple;
	bh=lnlSpSRuEWC2+V1fFBVKSi7pR/S2wsUDYeUHRvfZDsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnSpOJlaAhPR606X6vBzl3Ioyg2jz/eNIaFPe4ACEYs7NNquToinrTpffg99yl5W/yS0iksRCqnVCdPh/VExsrZhHGryBJVkIRagsGz4UbGsTJSEIYwW8+Lkdv+JngfqT93PtAuYgKI9Cm7axWMt59UROTg+2JcwhThLKMHALNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdxfDyoY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so451991a12.3;
        Thu, 24 Oct 2024 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761982; x=1730366782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjC2ZyAS0c5+ZNkIKeA4HqrorWpfWyuyhr+EB27pGMQ=;
        b=QdxfDyoYwc1CHmV05/A5dTslomfCVbcNQZSOgku6+cu5o76b/kuUBFeL+qzDezfodV
         fe2tXN5iCAqwScPervHRwhQQf1ebN2ETlMNlgD/67an6BTPuYLF4qLntD3m7qAA/4LKI
         x6U/K+UBIz7egEQ81ZhKMbPzMuPpGKDW0nPKAPxgel4116FrV5FkYstypMwHnKsg9iHn
         C5nONERpFL9rFOyG+7ys1k4WSAihw0AH/gJScpcK9BSJtdbe7h9sxNKRFvHHs0Fnli5k
         F3iS9UWYPcUDWBxzrCQ7dKLRw6ZX24ULq2qcQp8pC9iUflmYjaESXrDUlpjfXzctBJO/
         EBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761982; x=1730366782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjC2ZyAS0c5+ZNkIKeA4HqrorWpfWyuyhr+EB27pGMQ=;
        b=f3if7J6I+IBz9hb1MCEktP57Ik+feX857+sUiaAPaZSZAblo+94u+pDl9WLFr1mnen
         rfZM82aJx1lY6ogIGy97/Mteeywxgv7VC+BWxmaWeRvg8rKY0J/aDSXlKC1/3EV/lg8G
         sxxuh17KTqr3ufmc687EAlHeWRKnyU1nyejyV8ieWLO6wtf/rEF+j7fSkoybLWqv+Ivg
         dSWnXk3V3adLNreu3lTSuasYaxSVHjIcRlQKDJiG37MI0xUg86PYkq8RYfvfOkhKa6rD
         7Pp+MgD2dBAA7eduQ52Q4mVjgOgGapFG1Ii7ICuSZsUMBwD62oV2lYV8jqjqq01EF+YH
         Dv8A==
X-Forwarded-Encrypted: i=1; AJvYcCVZwcH8DaOcic8xXDKGZB26+SGQCm3RD++k6Vp+A8VzbLyfxU/jFLicb5gPSilo/mswuISWToOrMjYlk4hH@vger.kernel.org, AJvYcCWWluRZjEKBpua+F/ElXC0k71A3/IvK6Gb5Pf2IzCN/1LAuMK8Xy9c0AqnhswaNC34tuK+0hcPRACp6Xq18@vger.kernel.org, AJvYcCWqScYFMqduqSQLzZPmm73mFSCujaP0OeKkgV9kzny1987Gjv6nn4P2lzms8U6anN95umyPKf8zy+KgwYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXxjo/2ywH23CgOPhkDan38vHs1kcZCbb0vFCj2PmAIrkcer5
	MWnrCTkYmd1mATF4QcOtGX7cdTsqTvgWdl3JdR3BWZ/RV8tA0AfyB1U2lQ==
X-Google-Smtp-Source: AGHT+IEue/HkDpnTRSPvjF+GeHCL0FWVWHhW8thqswbSVQ0jhYwBfAj5Boirue/y+UqaVN4yA5a+pQ==
X-Received: by 2002:a05:6a21:3984:b0:1d9:275b:4ee9 with SMTP id adf61e73a8af0-1d978af6913mr6299775637.15.1729761982081;
        Thu, 24 Oct 2024 02:26:22 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:21 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] nilfs2: convert DAT file to be folio-based
Date: Thu, 24 Oct 2024 18:25:40 +0900
Message-ID: <20241024092602.13395-7-konishi.ryusuke@gmail.com>
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

Regarding the DAT, a metadata file that manages virtual block
addresses, convert the page-based implementation to a folio-based
implementation.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dat.c | 98 ++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 0bef662176a4..e220dcb08aa6 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -89,15 +89,15 @@ int nilfs_dat_prepare_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 void nilfs_dat_commit_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	struct nilfs_dat_entry *entry;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	entry->de_start = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_end = cpu_to_le64(NILFS_CNO_MAX);
 	entry->de_blocknr = cpu_to_le64(0);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	nilfs_palloc_commit_alloc_entry(dat, req);
 	nilfs_dat_commit_entry(dat, req);
@@ -113,15 +113,15 @@ static void nilfs_dat_commit_free(struct inode *dat,
 				  struct nilfs_palloc_req *req)
 {
 	struct nilfs_dat_entry *entry;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	entry->de_start = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_end = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_blocknr = cpu_to_le64(0);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	nilfs_dat_commit_entry(dat, req);
 
@@ -143,14 +143,14 @@ void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
 			    sector_t blocknr)
 {
 	struct nilfs_dat_entry *entry;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	entry->de_start = cpu_to_le64(nilfs_mdt_cno(dat));
 	entry->de_blocknr = cpu_to_le64(blocknr);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	nilfs_dat_commit_entry(dat, req);
 }
@@ -160,19 +160,19 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	struct nilfs_dat_entry *entry;
 	__u64 start;
 	sector_t blocknr;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	start = le64_to_cpu(entry->de_start);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	if (blocknr == 0) {
 		ret = nilfs_palloc_prepare_free_entry(dat, req);
@@ -200,11 +200,11 @@ void nilfs_dat_commit_end(struct inode *dat, struct nilfs_palloc_req *req,
 	struct nilfs_dat_entry *entry;
 	__u64 start, end;
 	sector_t blocknr;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	end = start = le64_to_cpu(entry->de_start);
 	if (!dead) {
 		end = nilfs_mdt_cno(dat);
@@ -212,7 +212,7 @@ void nilfs_dat_commit_end(struct inode *dat, struct nilfs_palloc_req *req,
 	}
 	entry->de_end = cpu_to_le64(end);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	if (blocknr == 0)
 		nilfs_dat_commit_free(dat, req);
@@ -225,14 +225,14 @@ void nilfs_dat_abort_end(struct inode *dat, struct nilfs_palloc_req *req)
 	struct nilfs_dat_entry *entry;
 	__u64 start;
 	sector_t blocknr;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-					     req->pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, req->pr_entry_nr,
+					   req->pr_entry_bh);
+	entry = kmap_local_folio(req->pr_entry_bh->b_folio, offset);
 	start = le64_to_cpu(entry->de_start);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	if (start == nilfs_mdt_cno(dat) && blocknr == 0)
 		nilfs_palloc_abort_free_entry(dat, req);
@@ -336,7 +336,7 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 {
 	struct buffer_head *entry_bh;
 	struct nilfs_dat_entry *entry;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	ret = nilfs_palloc_get_entry_block(dat, vblocknr, 0, &entry_bh);
@@ -359,21 +359,21 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 		}
 	}
 
-	kaddr = kmap_local_page(entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, vblocknr, entry_bh);
+	entry = kmap_local_folio(entry_bh->b_folio, offset);
 	if (unlikely(entry->de_blocknr == cpu_to_le64(0))) {
 		nilfs_crit(dat->i_sb,
 			   "%s: invalid vblocknr = %llu, [%llu, %llu)",
 			   __func__, (unsigned long long)vblocknr,
 			   (unsigned long long)le64_to_cpu(entry->de_start),
 			   (unsigned long long)le64_to_cpu(entry->de_end));
-		kunmap_local(kaddr);
+		kunmap_local(entry);
 		brelse(entry_bh);
 		return -EINVAL;
 	}
 	WARN_ON(blocknr == 0);
 	entry->de_blocknr = cpu_to_le64(blocknr);
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 
 	mark_buffer_dirty(entry_bh);
 	nilfs_mdt_mark_dirty(dat);
@@ -407,7 +407,7 @@ int nilfs_dat_translate(struct inode *dat, __u64 vblocknr, sector_t *blocknrp)
 	struct buffer_head *entry_bh, *bh;
 	struct nilfs_dat_entry *entry;
 	sector_t blocknr;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	ret = nilfs_palloc_get_entry_block(dat, vblocknr, 0, &entry_bh);
@@ -423,8 +423,8 @@ int nilfs_dat_translate(struct inode *dat, __u64 vblocknr, sector_t *blocknrp)
 		}
 	}
 
-	kaddr = kmap_local_page(entry_bh->b_page);
-	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(dat, vblocknr, entry_bh);
+	entry = kmap_local_folio(entry_bh->b_folio, offset);
 	blocknr = le64_to_cpu(entry->de_blocknr);
 	if (blocknr == 0) {
 		ret = -ENOENT;
@@ -433,7 +433,7 @@ int nilfs_dat_translate(struct inode *dat, __u64 vblocknr, sector_t *blocknrp)
 	*blocknrp = blocknr;
 
  out:
-	kunmap_local(kaddr);
+	kunmap_local(entry);
 	brelse(entry_bh);
 	return ret;
 }
@@ -442,11 +442,12 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 			    size_t nvi)
 {
 	struct buffer_head *entry_bh;
-	struct nilfs_dat_entry *entry;
+	struct nilfs_dat_entry *entry, *first_entry;
 	struct nilfs_vinfo *vinfo = buf;
 	__u64 first, last;
-	void *kaddr;
+	size_t offset;
 	unsigned long entries_per_block = NILFS_MDT(dat)->mi_entries_per_block;
+	unsigned int entry_size = NILFS_MDT(dat)->mi_entry_size;
 	int i, j, n, ret;
 
 	for (i = 0; i < nvi; i += n) {
@@ -454,23 +455,28 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 						   0, &entry_bh);
 		if (ret < 0)
 			return ret;
-		kaddr = kmap_local_page(entry_bh->b_page);
-		/* last virtual block number in this block */
+
 		first = vinfo->vi_vblocknr;
 		first = div64_ul(first, entries_per_block);
 		first *= entries_per_block;
+		/* first virtual block number in this block */
+
 		last = first + entries_per_block - 1;
+		/* last virtual block number in this block */
+
+		offset = nilfs_palloc_entry_offset(dat, first, entry_bh);
+		first_entry = kmap_local_folio(entry_bh->b_folio, offset);
 		for (j = i, n = 0;
 		     j < nvi && vinfo->vi_vblocknr >= first &&
 			     vinfo->vi_vblocknr <= last;
 		     j++, n++, vinfo = (void *)vinfo + visz) {
-			entry = nilfs_palloc_block_get_entry(
-				dat, vinfo->vi_vblocknr, entry_bh, kaddr);
+			entry = (void *)first_entry +
+				(vinfo->vi_vblocknr - first) * entry_size;
 			vinfo->vi_start = le64_to_cpu(entry->de_start);
 			vinfo->vi_end = le64_to_cpu(entry->de_end);
 			vinfo->vi_blocknr = le64_to_cpu(entry->de_blocknr);
 		}
-		kunmap_local(kaddr);
+		kunmap_local(first_entry);
 		brelse(entry_bh);
 	}
 
-- 
2.43.0


