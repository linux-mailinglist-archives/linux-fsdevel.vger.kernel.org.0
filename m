Return-Path: <linux-fsdevel+bounces-60192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DFB428B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BE87A96E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB83680A8;
	Wed,  3 Sep 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="aRZ5uYkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8D3629A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924414; cv=none; b=bofOoZK6VlEBXpsPjbXMSM92qD2jNw2pLpqrID3/lZcbDVZCZH1niVCPGqlUstWDXZNA9Nxk2izpwTlIYSVBfFD2ZawyS4pYhOuTUzRgofJe49x1nORLl6BCLuHq+KWaSvs/Ii2Llbi4tBKwkkWwJGFvoDd21xypGB9VU/QRDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924414; c=relaxed/simple;
	bh=jzdWpVy2WRQxuOLSavRub2jhQs0TqGFWHgH9OMw4VgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=En8Ar+cOqbyhwbB9IAGAZAs4Smk+e0wRaVJLg2pKYSfGqC1LcukNiPnIbui22SejCHCHWCJRbu9JWOkohb5hq9FbqChfqZ/6zJE3iKFkwGcWWEUEdgfkdt4iDIvmrBugqAaw0WrHCSvsjT6vAsDoxFbMAhDoNP/hVyZkZQ4DA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=aRZ5uYkZ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-72816012c5cso1307296d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756924411; x=1757529211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD+OONIwE2g0cQIrw7/xSzKlvXPLOmxPlr+MjppAfqU=;
        b=aRZ5uYkZEd2Fl/oRh5r8Y3nRl1p6xPDCPttnfkCZUyCwxDNXh9m540+KHDfF3cWwi3
         EDu9QJxzRu6FzVQa1O/1EkIPbgx+dWgVu0iFKN01yowhTFljhASuEKw69cYSNO3jiAdb
         xHc/klzqRAqihr26OiMwvZjwcHVS7u28fVq/a6VCyd05lIlE1KXL7fClbDkdkFoYx4gF
         KGhoksJg2H32gx/rhBiUDIa+8ExBEEQRSmGyfj/W3N3GlHzEGWwnj+O1m7ocEDCsoBQn
         wg3dMh92hzeronQmaY7VqP7t7J3u/uRci14u/I3uj8/H63ImngYqjQwlDxbJ7mnhhgCp
         7RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924411; x=1757529211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD+OONIwE2g0cQIrw7/xSzKlvXPLOmxPlr+MjppAfqU=;
        b=SI8yTK5nUpHoTJQonQEH5o5lHt2bFnE2gkvk6XKf8k0h/Y0T92qu4YIouvCYQNY7d3
         7ntBGwd+dGUZ2PZeGo3P0HOYKzeDgxbp9d/BtiPn8H6WD0tBAGuM3XLeLxGsBIshoJ+R
         2FIs2dAJIeAmJcls3a7qPYfmfbOXxh4p4RJBHgik5/JPXiHa8QSNcLIEW8s71Zv9KeH/
         nwMY402LmhfO+ds5cq5mL+E/hlBaudI1fKDMfFBAhb67yD4Nlkio3UUjmV7kqsigMdoY
         dX54HZ4BI6GEY7EkJDztQGPeT0ne7DVLrukL/0YT+eXxYvG0pjyceMGCuUXBA8/i8ZzV
         i4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVLo6EluZrcFoLjKQqqNm2vAb24+zT68Cd340r6hBv6At/xduPj68sSEkFRe8B5VR1ZTiXwpXSzuGuuGXbO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7D0lMTSyC7z+cmyy4u2smDzXBoI7oyBzTqwvV8Bg9+79Ex63
	6PjxRqJ2swywGp/VvVW0u8jD5nDU8bVhS8EWirNrjz54cWX2xbbOGhVPTTRpg3eh5R8=
X-Gm-Gg: ASbGncvvwan28I7SPGr6mwlqGzLyv7Q2W8VSbgOpv9L14/I1LAjSbZrZQnzjmv9oHJw
	NHie6pb01uvrR58e/QIAF3KqROg6swOFmx3SYItYrOARClTbet9XH4zHa6nR4VJKNPD8sPtYnod
	9yxgxHXodb9wTg4bbTCtt0iJY+S8V6FP2T6BQhmTrXMMZKy6GjslwhSaHvOo+R147UMvCRLUjvL
	jNafDuFevmpJL4ivgFCspKajQvo00BcOeD1RlrRZ8TB/VzuGAx99JjVddqYVWR4RyOCnauY0RCp
	GCRbNiHNSfLDUk+ADyAcnDjKsM+n/NXR4sXzfxxC2RAq7uQAWhh2SFSexfR80R6V3tbDR5mvT4q
	9TMBkVPmLGjdAoizgmNL4KA9FdIN/OuDQDFioTg==
X-Google-Smtp-Source: AGHT+IHRY2RNe25lBq7+3VZDJKD9wjjK8ztFWWR4Tu0fZfwpqN3ow4gnlY7kyF/ZmpNoLKl8QujqtQ==
X-Received: by 2002:a05:6214:c82:b0:722:3e12:df07 with SMTP id 6a1803df08f44-7223e12df42mr55675626d6.65.1756924411355;
        Wed, 03 Sep 2025 11:33:31 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72160017b64sm28699916d6.55.2025.09.03.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:33:30 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v5 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Wed,  3 Sep 2025 14:33:22 -0400
Message-Id: <20250903183322.191136-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903183322.191136-1-ethan.ferguson@zetier.com>
References: <20250903183322.191136-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 fs/exfat/super.c     | 165 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 259 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..a11a086c9d09 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -431,6 +431,10 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 /* super.c */
 int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
+int exfat_read_volume_label(struct super_block *sb,
+			    struct exfat_uni_name *label_out);
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *label);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
@@ -477,6 +481,9 @@ int exfat_force_shutdown(struct super_block *sb, u32 flags);
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
 extern const struct dentry_operations exfat_utf8_dentry_ops;
+int exfat_find_empty_entry(struct inode *inode,
+		struct exfat_chain *p_dir, int num_entries,
+			   struct exfat_entry_set_cache *es);
 
 /* cache.c */
 int exfat_cache_init(void);
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 971a1ccd0e89..4082fa7b8c14 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -80,6 +80,7 @@
 #define BOOTSEC_OLDBPB_LEN		53
 
 #define EXFAT_FILE_NAME_LEN		15
+#define EXFAT_VOLUME_LABEL_LEN		11
 
 #define EXFAT_MIN_SECT_SIZE_BITS		9
 #define EXFAT_MAX_SECT_SIZE_BITS		12
@@ -159,6 +160,11 @@ struct exfat_dentry {
 			__le32 start_clu;
 			__le64 size;
 		} __packed upcase; /* up-case table directory entry */
+		struct {
+			__u8 char_count;
+			__le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
+			__u8 reserved[8];
+		} __packed volume_label; /* volume label directory entry */
 		struct {
 			__u8 flags;
 			__u8 vendor_guid[16];
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 538d2b6ac2ec..c44928c02474 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -486,6 +486,82 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
 	return exfat_force_shutdown(sb, flags);
 }
 
+static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret;
+	char utf8[FSLABEL_MAX] = {0};
+	struct exfat_uni_name *uniname;
+
+	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
+	if (!uniname)
+		return -ENOMEM;
+
+	ret = exfat_read_volume_label(sb, uniname);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
+	if (ret < 0)
+		goto cleanup;
+
+	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	ret = 0;
+
+cleanup:
+	kfree(uniname);
+	return ret;
+}
+
+static int exfat_ioctl_set_volume_label(struct super_block *sb,
+					unsigned long arg)
+{
+	int ret, lossy;
+	char utf8[FSLABEL_MAX];
+	struct exfat_uni_name *uniname;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
+	if (!uniname)
+		return -ENOMEM;
+
+	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	if (utf8[0]) {
+		ret = exfat_nls_to_utf16(sb, utf8, strnlen(utf8, FSLABEL_MAX),
+					 uniname, &lossy);
+		if (ret < 0) {
+			goto cleanup;
+		} else if (lossy & NLS_NAME_LOSSY) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		uniname->name[0] = 0x0000;
+		uniname->name_len = 0;
+	}
+
+	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
+		exfat_info(sb, "Volume label length too long, truncating");
+		uniname->name_len = EXFAT_VOLUME_LABEL_LEN;
+		uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
+	}
+
+	ret = exfat_write_volume_label(sb, uniname);
+
+cleanup:
+	kfree(uniname);
+	return ret;
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -500,6 +576,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
 		return exfat_ioctl_fitrim(inode, arg);
+	case FS_IOC_GETFSLABEL:
+		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
+	case FS_IOC_SETFSLABEL:
+		return exfat_ioctl_set_volume_label(inode->i_sb, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f5f1c4e8a29f..eaa781d6263c 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -300,7 +300,7 @@ static int exfat_check_max_dentries(struct inode *inode)
  *   the directory entry index in p_dir is returned on succeeds
  *   -error code is returned on failure
  */
-static int exfat_find_empty_entry(struct inode *inode,
+int exfat_find_empty_entry(struct inode *inode,
 		struct exfat_chain *p_dir, int num_entries,
 		struct exfat_entry_set_cache *es)
 {
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8926e63f5bb7..0374e41b48a5 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -573,6 +573,171 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_dentry,
+				       bool create)
+{
+	int i, ret;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct exfat_inode_info *ei = EXFAT_I(root_inode);
+	struct exfat_entry_set_cache es;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep, *overwrite_ep = NULL;
+	struct buffer_head *bh, *overwrite_bh = NULL;
+
+	clu.dir = sbi->root_dir;
+	clu.flags = ALLOC_FAT_CHAIN;
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh);
+
+			if (!ep) {
+				ret = -EIO;
+				goto error;
+			}
+
+			type = exfat_get_entry_type(ep);
+			if ((type == TYPE_DELETED || type == TYPE_UNUSED)
+			    && !overwrite_ep && create) {
+				overwrite_ep = ep;
+				overwrite_bh = bh;
+				continue;
+			}
+
+			if (type == TYPE_VOLUME) {
+				*out_bh = bh;
+				*out_dentry = ep;
+
+				brelse(overwrite_bh);
+				return 0;
+			}
+
+			brelse(bh);
+		}
+
+		if (exfat_get_next_cluster(sb, &(clu.dir))) {
+			ret = -EIO;
+			goto error;
+		}
+	}
+
+	if (!create) {
+		ret = -ENOENT;
+		goto error;
+	}
+
+
+	if (overwrite_ep) {
+		ep = overwrite_ep;
+		bh = overwrite_bh;
+		goto overwrite;
+	}
+
+	ret = exfat_find_empty_entry(root_inode, &clu, 1, &es);
+	if (ret < 0)
+		goto error;
+
+	ei->hint_femp.eidx = 0;
+	ei->hint_femp.count = sbi->dentries_per_clu;
+	ei->hint_femp.cur = clu;
+
+	ep = exfat_get_dentry_cached(&es, 0);
+	bh = es.bh[EXFAT_B_TO_BLK(es.start_off, sb)];
+	/* increment use counter so exfat_put_dentry_set doesn't free */
+	get_bh(bh);
+	ret = exfat_put_dentry_set(&es, false);
+	if (ret < 0) {
+		bforget(bh);
+		goto error;
+	}
+	ei->hint_femp.eidx++;
+	ei->hint_femp.count--;
+
+overwrite:
+
+	memset(ep, 0, sizeof(struct exfat_dentry));
+	ep->type = EXFAT_VOLUME;
+	*out_bh = bh;
+	*out_dentry = ep;
+	return 0;
+
+error:
+	*out_bh = NULL;
+	*out_dentry = NULL;
+	return ret;
+}
+
+int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_name *label_out)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
+	struct exfat_dentry *ep = NULL;
+
+	mutex_lock(&sbi->s_lock);
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, false);
+	// ENOENT signifies that a volume label dentry doesn't exist
+	// We will treat this as an empty volume label and not fail.
+	if (ret == -ENOENT) {
+		label_out->name[0] = 0x0000;
+		label_out->name_len = 0;
+		ret = 0;
+	} else if (ret < 0) {
+		goto cleanup;
+	} else {
+		for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
+			label_out->name[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
+		label_out->name_len = ep->dentry.volume_label.char_count;
+	}
+
+cleanup:
+	mutex_unlock(&sbi->s_lock);
+	brelse(bh);
+	return ret;
+}
+
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *label)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
+	struct exfat_dentry *ep = NULL;
+
+	if (label->name_len > EXFAT_VOLUME_LABEL_LEN)
+		return -EINVAL;
+
+	mutex_lock(&sbi->s_lock);
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, true);
+	if (ret < 0)
+		goto cleanup;
+
+	for (i = 0; i < label->name_len; i++)
+		ep->dentry.volume_label.volume_label[i] =
+			cpu_to_le16(label->name[i]);
+	// Fill the rest of the str with 0x0000
+	for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		ep->dentry.volume_label.volume_label[i] = 0x0000;
+
+	ep->dentry.volume_label.char_count = label->name_len;
+
+cleanup:
+	mutex_unlock(&sbi->s_lock);
+
+	if (bh) {
+		exfat_update_bh(bh, IS_DIRSYNC(sb->s_root->d_inode));
+		brelse(bh);
+	}
+
+	return ret;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb,
 		struct exfat_chain *root_clu)
-- 
2.34.1


