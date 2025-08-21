Return-Path: <linux-fsdevel+bounces-58618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A006DB2FDF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79229A000D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A62DBF48;
	Thu, 21 Aug 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="HTZfU1IM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAE28725A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788982; cv=none; b=ckttV5jm9CZ8ljbEzjH9qT5W2xWU6xUuqUNmmeb68XZBVVnJqKnjV9Op8NslQKVi/XnAVbC6Uw4sitHTXvygjthUzRsAP4wASHRvhwpOQnEDBqztkEQyY6YWoctKHmJmJkl/tyKY9ZARROOhw6ccRTaoGgmLHq7E7omJCiYi4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788982; c=relaxed/simple;
	bh=QiX+YNdLW0om3mUTjwDAs6d9HsJzzT92VO9OpZfag3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hO5mYF6BSL/a68M0A1kQmP5OSgGEr6ZCFy1u4mzVhl1m+ncFvANrvWD+DNmI3th3+t9GDG173GCYVx0NmXD2k25cL7E88fxbePvtf8beh/rqySY78/ztf0G4ksdGLBjQTCX0YmGZiUte5BgKO6YQHR5Di9IRiz3M9tD/EoUM/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=HTZfU1IM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a88ddc000so12301606d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755788978; x=1756393778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RggB6TtFQuYRXanMGqNph9WSo1Y0LSeA90mLIhIK0fA=;
        b=HTZfU1IMTBrSBeGH3nK9QhYXUKNJV8vzvaREIiTA7GXlICFzGRoBhy4t2iPYsFdodn
         okLswHVG3aqEvfp9aTKnbtmkOC0jR3neqSAs369Vn0PCOqK7uStZb2KUMqHCQYNbrlKo
         +D549h+F18D38bV2i09+VeBtrdWDgSx4rNfdfOSk7O3LIbmroHWgYov9tCTkWgEF6lRB
         JiSOB2+PqAokiszXT0JSx2Bww8lg2ul/GKaNJbCQIg40F52UyxdAT9d/bFK9ihziID9U
         m8nnSp1qs4ehpggytzf37wJcX7F4VOyZZ4VGC8F00ZhThmmK7q9of32tpq43vSl63CVU
         UJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788978; x=1756393778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RggB6TtFQuYRXanMGqNph9WSo1Y0LSeA90mLIhIK0fA=;
        b=E3G1mBwNz5DCkT8IXqClPYL8NHs1aQNwz/kANmbZ9Yy/lK/IotjQXInWcJjHWOhxI/
         3N4x484o/U4LbYd8jMg2gR8JzXD/ttAp6dePhmldXSUFgP+YRdS+VgrUyMReflpvdqSC
         d0IocGwvRGNHpnJqMPPs6lOOHE3ymTWHB/XVI+rvJIWKup+wJDoI+p0DvaouvnOTuXUT
         Z5zW63EIUG2F2tHV2liJZPlaHFSBptx1vxh1g/C0rmWfYe0EvUpO0w1ZmpkhguFIXw7m
         KC1AXcGkL3juPnt1aQhcZQpueeuoYwB6R4vSS+ssPgSgwmQm85mA02613riEo5aEHn+A
         sRwg==
X-Gm-Message-State: AOJu0YxNOrvk8bmGc3l6qxSLmdkdipTomWSAHYnh9N5oBiRgl8eV0WXc
	kZLyJs56NSUsXlpf0RHMh4/7NAgCpiEc9xR+tK5Phi4/xOM9vvjTpqe/ogezx0CmrYI=
X-Gm-Gg: ASbGncsWmKn+HdzHeWXyKMg+NQpC5K/Yvq6zFnyBVfaIjPj+YQjDcnlkvN+dRdX9iw/
	I26eCvkyuV6/1MKPZTWHN/wNOilLYb0HmRCq+l2UUP1KWd1p8zmg/y6rzcUXGSuTqHjfRwU9rMs
	ugBr775Jm9a/BKeYg/5znw9qCOTbTu0m8/6nJ7kzkyf2/VzDTgFMUetOTyoapTySEst2Au4Cpp1
	5CKEo29udIFErdLXUK7Iep+KGBo/x+qGovSD/ewKHUYrW+3CmRAheLzYI6TZO6LZ00usd/RvGPl
	rdihw6xFDtLqzXsqTxVg55Ndrx47IZ+6Nhib5UKbbXuyvIS3HZsqgETymo5ReH2XXprKAj1hg7J
	18kJUwV5x6X7gerdllWJ6bfLdL8TxV9loDfDWrw==
X-Google-Smtp-Source: AGHT+IEss4bK0dWNN8rJAypmL4XlATNbrJ15OVba+3ss6iU5pHA4gBIwKx/QPTq34/thLqZW0SSlRw==
X-Received: by 2002:a05:6214:3005:b0:707:54b6:1f2c with SMTP id 6a1803df08f44-70d88ea98ccmr27818266d6.27.1755788977377;
        Thu, 21 Aug 2025 08:09:37 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70d8b0e3e6dsm10845676d6.73.2025.08.21.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:09:36 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v3 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 21 Aug 2025 11:09:26 -0400
Message-Id: <20250821150926.1025302-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821150926.1025302-1-ethan.ferguson@zetier.com>
References: <20250821150926.1025302-1-ethan.ferguson@zetier.com>
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

Lazy label loading, better char conversion
---
 fs/exfat/exfat_fs.h  |   3 +
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  78 ++++++++++++++++++
 fs/exfat/super.c     | 190 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..19b8524e5b7d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -267,6 +267,7 @@ struct exfat_sb_info {
 	struct buffer_head **vol_amap; /* allocation bitmap */
 
 	unsigned short *vol_utbl; /* upcase table */
+	unsigned short *volume_label; /* volume name */
 
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
@@ -431,6 +432,8 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 /* super.c */
 int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
+int exfat_read_volume_label(struct super_block *sb);
+int exfat_write_volume_label(struct super_block *sb, struct exfat_uni_name *uniname);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
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
index 538d2b6ac2ec..12c8ae450193 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -486,6 +487,79 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
 	return exfat_force_shutdown(sb, flags);
 }
 
+static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret;
+	char utf8[FSLABEL_MAX] = {0};
+	struct exfat_uni_name *uniname;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
+	if (!uniname)
+		return -ENOMEM;
+
+	ret = exfat_read_volume_label(sb);
+	if (ret < 0)
+		goto cleanup;
+
+	memcpy(uniname->name, sbi->volume_label,
+	       EXFAT_VOLUME_LABEL_LEN * sizeof(short));
+	uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
+	uniname->name_len = UniStrnlen(uniname->name, EXFAT_VOLUME_LABEL_LEN);
+
+	ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
+
+	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+cleanup:
+	kfree(uniname);
+	return 0;
+}
+
+static int exfat_ioctl_set_volume_label(struct super_block *sb, unsigned long arg)
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
+		exfat_nls_to_utf16(sb, utf8, strnlen(utf8, FSLABEL_MAX), uniname, &lossy);
+		if (lossy & NLS_NAME_LOSSY) {
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
@@ -500,6 +574,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8926e63f5bb7..7aee6ea594d8 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -573,6 +574,194 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_dentry,
+				       bool find_new)
+{
+	int i, ret;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_chain clu;
+	struct exfat_dentry *ep, *deleted_ep = NULL;
+	struct buffer_head *bh, *deleted_bh;
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
+				goto end;
+			}
+
+			type = exfat_get_entry_type(ep);
+			if (type == TYPE_DELETED && !deleted_ep && find_new) {
+				deleted_ep = ep;
+				deleted_bh = bh;
+				continue;
+			}
+
+			if (type == TYPE_UNUSED) {
+				if (find_new) {
+					brelse(bh);
+					ret = -ENOENT;
+					goto end;
+				}
+
+				if (deleted_ep) {
+					brelse(bh);
+					goto end;
+				}
+
+				// Last dentry in cluster
+				if (i == sbi->dentries_per_clu - 1) {
+					// TODO allocate new cluster
+					brelse(bh);
+					ret = -ENOSPC;
+					goto end;
+				}
+
+				deleted_ep = ep;
+				deleted_bh = bh;
+
+				ep = exfat_get_dentry(sb, &clu, i + 1, &bh);
+				memset(ep, 0, sizeof(struct exfat_dentry));
+				ep->type = EXFAT_UNUSED;
+				exfat_update_bh(bh, true);
+				brelse(bh);
+
+				goto end;
+			}
+
+			if (type == TYPE_VOLUME) {
+				*out_bh = bh;
+				*out_dentry = ep;
+
+				if (deleted_ep)
+					brelse(deleted_bh);
+
+				return 0;
+			}
+
+			brelse(bh);
+		}
+
+		if (exfat_get_next_cluster(sb, &(clu.dir))) {
+			ret = -EIO;
+			goto end;
+		}
+	}
+
+end:
+	if (deleted_ep) {
+		*out_bh = deleted_bh;
+		*out_dentry = deleted_ep;
+		memset((*out_dentry), 0, sizeof(struct exfat_dentry));
+		(*out_dentry)->type = EXFAT_VOLUME;
+		return 0;
+	}
+
+	*out_bh = NULL;
+	*out_dentry = NULL;
+	return ret;
+}
+
+static int exfat_alloc_volume_label(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (sbi->volume_label)
+		return 0;
+
+	sbi->volume_label = kcalloc(EXFAT_VOLUME_LABEL_LEN,
+						     sizeof(short), GFP_KERNEL);
+	if (!sbi->volume_label)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int exfat_read_volume_label(struct super_block *sb)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, false);
+	// ENOENT signifies that a volume label dentry, doesn't exist
+	// We will treat this as an empty volume label and not fail.
+	if (ret < 0 && ret != -ENOENT)
+		goto cleanup;
+
+	ret = exfat_alloc_volume_label(sb);
+	if (ret < 0)
+		goto cleanup;
+
+	mutex_lock(&sbi->s_lock);
+	for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		sbi->volume_label[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
+	mutex_unlock(&sbi->s_lock);
+
+	ret = 0;
+
+cleanup:
+	if (bh)
+		brelse(bh);
+
+	return ret;
+}
+
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *uniname)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, true);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = exfat_alloc_volume_label(sb);
+	if (ret < 0)
+		goto cleanup;
+
+	memcpy(sbi->volume_label, uniname->name,
+	       uniname->name_len * sizeof(short));
+
+	mutex_lock(&sbi->s_lock);
+	for (i = 0; i < uniname->name_len; i++)
+		ep->dentry.volume_label.volume_label[i] =
+			cpu_to_le16(sbi->volume_label[i]);
+	// Fill the rest of the str with 0x0000
+	for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		ep->dentry.volume_label.volume_label[i] = 0x0000;
+
+	ep->dentry.volume_label.char_count = uniname->name_len;
+	mutex_unlock(&sbi->s_lock);
+
+	ret = 0;
+
+cleanup:
+	if (bh) {
+		exfat_update_bh(bh, true);
+		brelse(bh);
+	}
+
+	return ret;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb,
 		struct exfat_chain *root_clu)
@@ -791,6 +980,7 @@ static void delayed_free(struct rcu_head *p)
 
 	unload_nls(sbi->nls_io);
 	exfat_free_upcase_table(sbi);
+	kfree(sbi->volume_label);
 	exfat_free_sbi(sbi);
 }
 
-- 
2.34.1


