Return-Path: <linux-fsdevel+bounces-32710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5009AE09B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B769B22836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A121C07D3;
	Thu, 24 Oct 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbGbVGbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C991B6D01;
	Thu, 24 Oct 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761982; cv=none; b=j8voYXEfBsfviNIbWHBFBNlA5Vmll+wEAEqYE/V5ZI75EPgg5Roarq3lBHxfO9TUO55pKdugfIhpNE5GE4EVBu7HdxY4wz6guhRfOmnvhthG2jT5TWoJSr4E1dgMVlsN6T6ePsFV4i4lzBMrkCp1zSPMMzmuFUMttPpye95DGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761982; c=relaxed/simple;
	bh=vtTvtsQdkz4/yTiq4OQsJy7KWz0L86eeowaYLNlKGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXOwmUmeTZ7ofiTQNuq8gSASd3BO782kZV4tpFNpQqkJg8tWFzXrBLlkrim1hMSvpTwqKPfW7dTZyPUPO/8nd/2UQTJjyUlwheTp+7kxpEGdUOxIC0OFl3yZJy+qHCNWeiEMzQIMmPHqkNLNmRP+OvHuPWqhQtT+fsz1m8vYaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbGbVGbV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso500129b3a.2;
        Thu, 24 Oct 2024 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761975; x=1730366775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nXrQmW+YVo2eeU8/p6IXqjviSMZctE3yKb4AwwJMu4=;
        b=RbGbVGbVYG3LzoWKgPdhUP29/Vb+xnu5KSGNYw4ef9E0LHjU+h8SvamlzNeqpiiLiB
         XGtks2phgbutLJVYzaLXwM/SA1envNG1cZuWU+X003fCX+23g7Y3fv2UbuqJsDcnLkDV
         qsiw92lyVp7bDCNFxlQ0+/YRgNd+2Nv2i3A0poMcwiLg7P6nI5/FS3Ony/EBmGCqUGL+
         VIxSLht8hHUV4q8QQoade9m0Gs6LStDj7ozx5BZ4hP7yycDebdZhHeLM4TP7vXE5dGI3
         t7FgOtect0Jq/J5OiZXYV9DSlLbGfGfoKFA05L2AiDo6Z3bO3AFgd9FrnVQuWQBXuEyh
         meTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761975; x=1730366775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nXrQmW+YVo2eeU8/p6IXqjviSMZctE3yKb4AwwJMu4=;
        b=ohzdHmSnsbpDVHhQt0IKVs2E+NSmVssDsdeg0yz9s2/gOSASpbf6KD9VQiqMXGO6lb
         CSha54TbWVtLQNWJHxPLewRYm71WWmorYPkoSmwDTKpsKbIrAHs/IhkzyS3ZohKYfNKC
         C0R72pZix+0pYhW3lLepRvmgqs2GUfxUqMr+vjLYp86fimRwme3iqsrNvtY+r9oTMswr
         hVODYqAMhvbTNcc8yTjMRigITIEgulvySa0Ihcrg2Ujq3V+hWYc+zvMtV9v14kgnhuyf
         K0Vd+XH13hVo6X//AmPIaxktuXNEnB+3DSu6EmcFhqNzxAUAePvxDzS05IS8ZlhkjWON
         0lmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+fgSajOfWiIWVIj/koD0/z9p5g/CBOr3ZfO+lwwELq4gYK5qUTtreyalGirtiupfUTRHvT1+DEWFZyyr@vger.kernel.org, AJvYcCVsSJHLuVijRnvZz61v7RqG3DyQvA3ptVWte0XVRtUv8lTEHIyGsQAzDW38KsPZ7VFe7pThugbPx2nNDqE=@vger.kernel.org, AJvYcCWdjg3TqfZ9tqwb8Ty+wHlJBGa7Hux3e3rGAOlo3ebB0gAh6ce3iJ6JS986OsvtrmvTWofaZKX3a9wBFmnC@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6SvKZYLrWXPfRI+0e+UYbCUoGU0+omgzPDxcOGRoFB27BbSZ
	TI30Z6Xr9Srl+je817p00wDHm1OmE9TmMrPIMs/ZDSPy+YbnqfNR
X-Google-Smtp-Source: AGHT+IH3NVvtkTpiokiRrac5UJHIZYDOd2D8G4giZv/Qtpvm5ZmwrA4DZjZweJ1Bt5ia1E6C+TkQ0A==
X-Received: by 2002:aa7:88ce:0:b0:71e:44f6:6900 with SMTP id d2e1a72fcca58-72030a8a42bmr7581102b3a.16.1729761974975;
        Thu, 24 Oct 2024 02:26:14 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:14 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] nilfs2: convert segment usage file to be folio-based
Date: Thu, 24 Oct 2024 18:25:37 +0900
Message-ID: <20241024092602.13395-4-konishi.ryusuke@gmail.com>
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

For the sufile, which is a metadata file that holds information
about managing segments, convert the page-based implementation to a
folio-based implementation.

kmap_local_page() is changed to use kmap_local_folio(), and where
offsets within a page are calculated using bh_offset(), are replaced
with calculations using offset_in_folio() with an additional helper
function nilfs_sufile_segment_usage_offset().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/sufile.c | 160 +++++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 78 deletions(-)

diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index eea5a6a12f7b..d3ecc813d633 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -70,11 +70,20 @@ nilfs_sufile_segment_usages_in_block(const struct inode *sufile, __u64 curr,
 		     max - curr + 1);
 }
 
-static struct nilfs_segment_usage *
-nilfs_sufile_block_get_segment_usage(const struct inode *sufile, __u64 segnum,
-				     struct buffer_head *bh, void *kaddr)
+/**
+ * nilfs_sufile_segment_usage_offset - calculate the byte offset of a segment
+ *                                     usage entry in the folio containing it
+ * @sufile: segment usage file inode
+ * @segnum: number of segment usage
+ * @bh:     buffer head of block containing segment usage indexed by @segnum
+ *
+ * Return: Byte offset in the folio of the segment usage entry.
+ */
+static size_t nilfs_sufile_segment_usage_offset(const struct inode *sufile,
+						__u64 segnum,
+						struct buffer_head *bh)
 {
-	return kaddr + bh_offset(bh) +
+	return offset_in_folio(bh->b_folio, bh->b_data) +
 		nilfs_sufile_get_offset(sufile, segnum) *
 		NILFS_MDT(sufile)->mi_entry_size;
 }
@@ -112,13 +121,11 @@ static void nilfs_sufile_mod_counter(struct buffer_head *header_bh,
 				     u64 ncleanadd, u64 ndirtyadd)
 {
 	struct nilfs_sufile_header *header;
-	void *kaddr;
 
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = kaddr + bh_offset(header_bh);
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	le64_add_cpu(&header->sh_ncleansegs, ncleanadd);
 	le64_add_cpu(&header->sh_ndirtysegs, ndirtyadd);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 
 	mark_buffer_dirty(header_bh);
 }
@@ -313,6 +320,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 	struct nilfs_sufile_info *sui = NILFS_SUI(sufile);
 	size_t susz = NILFS_MDT(sufile)->mi_entry_size;
 	__u64 segnum, maxsegnum, last_alloc;
+	size_t offset;
 	void *kaddr;
 	unsigned long nsegments, nsus, cnt;
 	int ret, j;
@@ -322,10 +330,9 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 	ret = nilfs_sufile_get_header_block(sufile, &header_bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = kaddr + bh_offset(header_bh);
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	last_alloc = le64_to_cpu(header->sh_last_alloc);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 
 	nsegments = nilfs_sufile_get_nsegments(sufile);
 	maxsegnum = sui->allocmax;
@@ -359,9 +366,10 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 							   &su_bh);
 		if (ret < 0)
 			goto out_header;
-		kaddr = kmap_local_page(su_bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(
-			sufile, segnum, su_bh, kaddr);
+
+		offset = nilfs_sufile_segment_usage_offset(sufile, segnum,
+							   su_bh);
+		su = kaddr = kmap_local_folio(su_bh->b_folio, offset);
 
 		nsus = nilfs_sufile_segment_usages_in_block(
 			sufile, segnum, maxsegnum);
@@ -372,12 +380,11 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 			nilfs_segment_usage_set_dirty(su);
 			kunmap_local(kaddr);
 
-			kaddr = kmap_local_page(header_bh->b_page);
-			header = kaddr + bh_offset(header_bh);
+			header = kmap_local_folio(header_bh->b_folio, 0);
 			le64_add_cpu(&header->sh_ncleansegs, -1);
 			le64_add_cpu(&header->sh_ndirtysegs, 1);
 			header->sh_last_alloc = cpu_to_le64(segnum);
-			kunmap_local(kaddr);
+			kunmap_local(header);
 
 			sui->ncleansegs--;
 			mark_buffer_dirty(header_bh);
@@ -411,18 +418,18 @@ void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
 				 struct buffer_head *su_bh)
 {
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 
-	kaddr = kmap_local_page(su_bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, su_bh);
+	su = kmap_local_folio(su_bh->b_folio, offset);
 	if (unlikely(!nilfs_segment_usage_clean(su))) {
 		nilfs_warn(sufile->i_sb, "%s: segment %llu must be clean",
 			   __func__, (unsigned long long)segnum);
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		return;
 	}
 	nilfs_segment_usage_set_dirty(su);
-	kunmap_local(kaddr);
+	kunmap_local(su);
 
 	nilfs_sufile_mod_counter(header_bh, -1, 1);
 	NILFS_SUI(sufile)->ncleansegs--;
@@ -436,14 +443,14 @@ void nilfs_sufile_do_scrap(struct inode *sufile, __u64 segnum,
 			   struct buffer_head *su_bh)
 {
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 	int clean, dirty;
 
-	kaddr = kmap_local_page(su_bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, su_bh);
+	su = kmap_local_folio(su_bh->b_folio, offset);
 	if (su->su_flags == cpu_to_le32(BIT(NILFS_SEGMENT_USAGE_DIRTY)) &&
 	    su->su_nblocks == cpu_to_le32(0)) {
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		return;
 	}
 	clean = nilfs_segment_usage_clean(su);
@@ -453,7 +460,7 @@ void nilfs_sufile_do_scrap(struct inode *sufile, __u64 segnum,
 	su->su_lastmod = cpu_to_le64(0);
 	su->su_nblocks = cpu_to_le32(0);
 	su->su_flags = cpu_to_le32(BIT(NILFS_SEGMENT_USAGE_DIRTY));
-	kunmap_local(kaddr);
+	kunmap_local(su);
 
 	nilfs_sufile_mod_counter(header_bh, clean ? (u64)-1 : 0, dirty ? 0 : 1);
 	NILFS_SUI(sufile)->ncleansegs -= clean;
@@ -467,15 +474,15 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 			  struct buffer_head *su_bh)
 {
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 	int sudirty;
 
-	kaddr = kmap_local_page(su_bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, su_bh);
+	su = kmap_local_folio(su_bh->b_folio, offset);
 	if (nilfs_segment_usage_clean(su)) {
 		nilfs_warn(sufile->i_sb, "%s: segment %llu is already clean",
 			   __func__, (unsigned long long)segnum);
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		return;
 	}
 	if (unlikely(nilfs_segment_usage_error(su)))
@@ -488,7 +495,7 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 			   (unsigned long long)segnum);
 
 	nilfs_segment_usage_set_clean(su);
-	kunmap_local(kaddr);
+	kunmap_local(su);
 	mark_buffer_dirty(su_bh);
 
 	nilfs_sufile_mod_counter(header_bh, 1, sudirty ? (u64)-1 : 0);
@@ -507,7 +514,7 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 {
 	struct buffer_head *bh;
-	void *kaddr;
+	size_t offset;
 	struct nilfs_segment_usage *su;
 	int ret;
 
@@ -523,12 +530,12 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 		goto out_sem;
 	}
 
-	kaddr = kmap_local_page(bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, bh);
+	su = kmap_local_folio(bh->b_folio, offset);
 	if (unlikely(nilfs_segment_usage_error(su))) {
 		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
 
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		brelse(bh);
 		if (nilfs_segment_is_active(nilfs, segnum)) {
 			nilfs_error(sufile->i_sb,
@@ -546,7 +553,7 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 		ret = -EIO;
 	} else {
 		nilfs_segment_usage_set_dirty(su);
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		mark_buffer_dirty(bh);
 		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
@@ -568,7 +575,7 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 {
 	struct buffer_head *bh;
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
@@ -576,8 +583,8 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 	if (ret < 0)
 		goto out_sem;
 
-	kaddr = kmap_local_page(bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, bh);
+	su = kmap_local_folio(bh->b_folio, offset);
 	if (modtime) {
 		/*
 		 * Check segusage error and set su_lastmod only when updating
@@ -587,7 +594,7 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 		su->su_lastmod = cpu_to_le64(modtime);
 	}
 	su->su_nblocks = cpu_to_le32(nblocks);
-	kunmap_local(kaddr);
+	kunmap_local(su);
 
 	mark_buffer_dirty(bh);
 	nilfs_mdt_mark_dirty(sufile);
@@ -619,7 +626,6 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 	struct buffer_head *header_bh;
 	struct nilfs_sufile_header *header;
 	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
-	void *kaddr;
 	int ret;
 
 	down_read(&NILFS_MDT(sufile)->mi_sem);
@@ -628,8 +634,7 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 	if (ret < 0)
 		goto out_sem;
 
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = kaddr + bh_offset(header_bh);
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	sustat->ss_nsegs = nilfs_sufile_get_nsegments(sufile);
 	sustat->ss_ncleansegs = le64_to_cpu(header->sh_ncleansegs);
 	sustat->ss_ndirtysegs = le64_to_cpu(header->sh_ndirtysegs);
@@ -638,7 +643,7 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 	spin_lock(&nilfs->ns_last_segment_lock);
 	sustat->ss_prot_seq = nilfs->ns_prot_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 	brelse(header_bh);
 
  out_sem:
@@ -651,18 +656,18 @@ void nilfs_sufile_do_set_error(struct inode *sufile, __u64 segnum,
 			       struct buffer_head *su_bh)
 {
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 	int suclean;
 
-	kaddr = kmap_local_page(su_bh->b_page);
-	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
+	offset = nilfs_sufile_segment_usage_offset(sufile, segnum, su_bh);
+	su = kmap_local_folio(su_bh->b_folio, offset);
 	if (nilfs_segment_usage_error(su)) {
-		kunmap_local(kaddr);
+		kunmap_local(su);
 		return;
 	}
 	suclean = nilfs_segment_usage_clean(su);
 	nilfs_segment_usage_set_error(su);
-	kunmap_local(kaddr);
+	kunmap_local(su);
 
 	if (suclean) {
 		nilfs_sufile_mod_counter(header_bh, -1, 0);
@@ -700,7 +705,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 	unsigned long segusages_per_block;
 	unsigned long nsegs, ncleaned;
 	__u64 segnum;
-	void *kaddr;
+	size_t offset;
 	ssize_t n, nc;
 	int ret;
 	int j;
@@ -731,16 +736,16 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 			/* hole */
 			continue;
 		}
-		kaddr = kmap_local_page(su_bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(
-			sufile, segnum, su_bh, kaddr);
+		offset = nilfs_sufile_segment_usage_offset(sufile, segnum,
+							   su_bh);
+		su = kmap_local_folio(su_bh->b_folio, offset);
 		su2 = su;
 		for (j = 0; j < n; j++, su = (void *)su + susz) {
 			if ((le32_to_cpu(su->su_flags) &
 			     ~BIT(NILFS_SEGMENT_USAGE_ERROR)) ||
 			    nilfs_segment_is_active(nilfs, segnum + j)) {
 				ret = -EBUSY;
-				kunmap_local(kaddr);
+				kunmap_local(su2);
 				brelse(su_bh);
 				goto out_header;
 			}
@@ -752,7 +757,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 				nc++;
 			}
 		}
-		kunmap_local(kaddr);
+		kunmap_local(su2);
 		if (nc > 0) {
 			mark_buffer_dirty(su_bh);
 			ncleaned += nc;
@@ -799,7 +804,6 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 	struct buffer_head *header_bh;
 	struct nilfs_sufile_header *header;
 	struct nilfs_sufile_info *sui = NILFS_SUI(sufile);
-	void *kaddr;
 	unsigned long nsegs, nrsvsegs;
 	int ret = 0;
 
@@ -837,10 +841,9 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 		sui->allocmin = 0;
 	}
 
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = kaddr + bh_offset(header_bh);
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	header->sh_ncleansegs = cpu_to_le64(sui->ncleansegs);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 
 	mark_buffer_dirty(header_bh);
 	nilfs_mdt_mark_dirty(sufile);
@@ -874,6 +877,7 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 	struct nilfs_suinfo *si = buf;
 	size_t susz = NILFS_MDT(sufile)->mi_entry_size;
 	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	size_t offset;
 	void *kaddr;
 	unsigned long nsegs, segusages_per_block;
 	ssize_t n;
@@ -901,9 +905,9 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 			continue;
 		}
 
-		kaddr = kmap_local_page(su_bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(
-			sufile, segnum, su_bh, kaddr);
+		offset = nilfs_sufile_segment_usage_offset(sufile, segnum,
+							   su_bh);
+		su = kaddr = kmap_local_folio(su_bh->b_folio, offset);
 		for (j = 0; j < n;
 		     j++, su = (void *)su + susz, si = (void *)si + sisz) {
 			si->sui_lastmod = le64_to_cpu(su->su_lastmod);
@@ -951,7 +955,7 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 	struct buffer_head *header_bh, *bh;
 	struct nilfs_suinfo_update *sup, *supend = buf + supsz * nsup;
 	struct nilfs_segment_usage *su;
-	void *kaddr;
+	size_t offset;
 	unsigned long blkoff, prev_blkoff;
 	int cleansi, cleansu, dirtysi, dirtysu;
 	long ncleaned = 0, ndirtied = 0;
@@ -983,9 +987,9 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 		goto out_header;
 
 	for (;;) {
-		kaddr = kmap_local_page(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(
-			sufile, sup->sup_segnum, bh, kaddr);
+		offset = nilfs_sufile_segment_usage_offset(
+			sufile, sup->sup_segnum, bh);
+		su = kmap_local_folio(bh->b_folio, offset);
 
 		if (nilfs_suinfo_update_lastmod(sup))
 			su->su_lastmod = cpu_to_le64(sup->sup_sui.sui_lastmod);
@@ -1020,7 +1024,7 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 			su->su_flags = cpu_to_le32(sup->sup_sui.sui_flags);
 		}
 
-		kunmap_local(kaddr);
+		kunmap_local(su);
 
 		sup = (void *)sup + supsz;
 		if (sup >= supend)
@@ -1076,6 +1080,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
 	struct buffer_head *su_bh;
 	struct nilfs_segment_usage *su;
+	size_t offset;
 	void *kaddr;
 	size_t n, i, susz = NILFS_MDT(sufile)->mi_entry_size;
 	sector_t seg_start, seg_end, start_block, end_block;
@@ -1125,9 +1130,9 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 			continue;
 		}
 
-		kaddr = kmap_local_page(su_bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum,
-				su_bh, kaddr);
+		offset = nilfs_sufile_segment_usage_offset(sufile, segnum,
+							   su_bh);
+		su = kaddr = kmap_local_folio(su_bh->b_folio, offset);
 		for (i = 0; i < n; ++i, ++segnum, su = (void *)su + susz) {
 			if (!nilfs_segment_usage_clean(su))
 				continue;
@@ -1167,9 +1172,10 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 				}
 
 				ndiscarded += nblocks;
-				kaddr = kmap_local_page(su_bh->b_page);
-				su = nilfs_sufile_block_get_segment_usage(
-					sufile, segnum, su_bh, kaddr);
+				offset = nilfs_sufile_segment_usage_offset(
+					sufile, segnum, su_bh);
+				su = kaddr = kmap_local_folio(su_bh->b_folio,
+							      offset);
 			}
 
 			/* start new extent */
@@ -1221,7 +1227,6 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	struct nilfs_sufile_info *sui;
 	struct buffer_head *header_bh;
 	struct nilfs_sufile_header *header;
-	void *kaddr;
 	int err;
 
 	if (susize > sb->s_blocksize) {
@@ -1262,10 +1267,9 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	}
 
 	sui = NILFS_SUI(sufile);
-	kaddr = kmap_local_page(header_bh->b_page);
-	header = kaddr + bh_offset(header_bh);
+	header = kmap_local_folio(header_bh->b_folio, 0);
 	sui->ncleansegs = le64_to_cpu(header->sh_ncleansegs);
-	kunmap_local(kaddr);
+	kunmap_local(header);
 	brelse(header_bh);
 
 	sui->allocmax = nilfs_sufile_get_nsegments(sufile) - 1;
-- 
2.43.0


