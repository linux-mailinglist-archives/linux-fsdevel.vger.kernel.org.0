Return-Path: <linux-fsdevel+bounces-22496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C491812E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6281F23782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709D185089;
	Wed, 26 Jun 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CoX01Sbb";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Qh+TsKyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C6183088;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405801; cv=none; b=PhrkppG5xQk6ym9nLaUaBbV7Cfhtd/6U39oPctGyBMbn1/IILJdwigpJEFJ5dg8p4A/sNwqXwJv4KkL+v5OPwIPHUi+EpeVIIytYGzxQBZj6ARIiH+if7KFI/4haj9AJZT/ShNkANTzZ829T+epwsztozOaYjSEktAPEC/Kz6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405801; c=relaxed/simple;
	bh=yQ3M9JcUB9Y7/ndl8aH9G1pwMMSo2hLxoNC6F3RwUG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWdQlsjnA8vySLv5zDVnXecc9wogey0nBPcOzuAmcE0Gf1s7ABHOCUW2Yj7HStEe2Ivm7CAWVMIazB7PQpfIcb0qxiRyn+WieV/TI/S8TreMR6YQCseeNJkczLsgxgxsdQZawgQelNXTr7RwAbHd1mr7lyGnAoiNTx8tcZLkIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CoX01Sbb; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Qh+TsKyp; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1FA5E2188;
	Wed, 26 Jun 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405314;
	bh=K26/kDZdkktd9e94JVo/xMX+ydCzCiAdUUmIkjkRM1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CoX01Sbb/TMtISqwMOsoC051E9capmUaIhiYK8h+y3na7zf2hf/4FUPx3P1VDiFnS
	 QOYymS7SCvnc9tNbimW2VBgcLJxtRncG/bKYKmNwo0LM244iu6K0o35GinxZJoy3HX
	 h049TDsOYs7314Q47iHWmvR9efS2QnKcH3pvuh1E=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4CDE33E3;
	Wed, 26 Jun 2024 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405797;
	bh=K26/kDZdkktd9e94JVo/xMX+ydCzCiAdUUmIkjkRM1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Qh+TsKypECv4N84yuyg++UiCMo9x389boNNvrYep2sPUARxN3+V6Ag5plQy6NENEu
	 Hc/vJk7VBStUeA/acI7FWFfQapjyriMHMzt8C0XkXbXsdpyR0m0eIci+0dvte9AfYn
	 lxUgBbRJcmaDe1ANuteA152BR/9sV3uCjR65LauA=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:16 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 06/11] fs/ntfs3: Check more cases when directory is corrupted
Date: Wed, 26 Jun 2024 15:42:53 +0300
Message-ID: <20240626124258.7264-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Mark ntfs dirty in this case.
Rename ntfs_filldir to ntfs_dir_emit.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c | 52 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 858efe255f6f..1ec09f2fca64 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -272,9 +272,12 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
 }
 
-static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
-			       const struct NTFS_DE *e, u8 *name,
-			       struct dir_context *ctx)
+/*
+ * returns false if 'ctx' if full
+ */
+static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
+				 struct ntfs_inode *ni, const struct NTFS_DE *e,
+				 u8 *name, struct dir_context *ctx)
 {
 	const struct ATTR_FILE_NAME *fname;
 	unsigned long ino;
@@ -284,29 +287,29 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	fname = Add2Ptr(e, sizeof(struct NTFS_DE));
 
 	if (fname->type == FILE_NAME_DOS)
-		return 0;
+		return true;
 
 	if (!mi_is_ref(&ni->mi, &fname->home))
-		return 0;
+		return true;
 
 	ino = ino_get(&e->ref);
 
 	if (ino == MFT_REC_ROOT)
-		return 0;
+		return true;
 
 	/* Skip meta files. Unless option to show metafiles is set. */
 	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
-		return 0;
+		return true;
 
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
-		return 0;
+		return true;
 
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
 		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
 			  ino);
-		return 0;
+		return true;
 	}
 
 	/*
@@ -336,17 +339,20 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		}
 	}
 
-	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+	return dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
 
 /*
  * ntfs_read_hdr - Helper function for ntfs_readdir().
+ *
+ * returns 0 if ok.
+ * returns -EINVAL if directory is corrupted.
+ * returns +1 if 'ctx' is full.
  */
 static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
 			 u8 *name, struct dir_context *ctx)
 {
-	int err;
 	const struct NTFS_DE *e;
 	u32 e_size;
 	u32 end = le32_to_cpu(hdr->used);
@@ -354,12 +360,12 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 
 	for (;; off += e_size) {
 		if (off + sizeof(struct NTFS_DE) > end)
-			return -1;
+			return -EINVAL;
 
 		e = Add2Ptr(hdr, off);
 		e_size = le16_to_cpu(e->size);
 		if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
-			return -1;
+			return -EINVAL;
 
 		if (de_is_last(e))
 			return 0;
@@ -369,14 +375,15 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			continue;
 
 		if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
-			return -1;
+			return -EINVAL;
 
 		ctx->pos = vbo + off;
 
 		/* Submit the name to the filldir callback. */
-		err = ntfs_filldir(sbi, ni, e, name, ctx);
-		if (err)
-			return err;
+		if (!ntfs_dir_emit(sbi, ni, e, name, ctx)) {
+			/* ctx is full. */
+			return +1;
+		}
 	}
 }
 
@@ -475,8 +482,6 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
-			ntfs_inode_err(dir, "Looks like your dir is corrupt");
-			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
@@ -499,9 +504,16 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	__putname(name);
 	put_indx_node(node);
 
-	if (err == -ENOENT) {
+	if (err == 1) {
+		/* 'ctx' is full. */
+		err = 0;
+	} else if (err == -ENOENT) {
 		err = 0;
 		ctx->pos = pos;
+	} else if (err < 0) {
+		if (err == -EINVAL)
+			ntfs_inode_err(dir, "directory corrupted");
+		ctx->pos = eod;
 	}
 
 	return err;
-- 
2.34.1


