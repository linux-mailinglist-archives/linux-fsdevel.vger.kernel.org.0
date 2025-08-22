Return-Path: <linux-fsdevel+bounces-58859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B120B32389
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184E03AB34F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A52D7DF0;
	Fri, 22 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="K2YeL26Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F752877F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894035; cv=none; b=XGd+qLgy/L7UgXNJ70JGR0diAFGhldgFWdQGvE0my0cWwnMWt2JRzMXLz6IBMV+2A64s2Lti/PpqFVmYC4arnRPtwu0AsID4cwvIKpAP/7UbaXS3zSylotPi6/0wAjHPIhkc96FA154YKMkXZvQQlqi74NY+LdRmdn4uPwaGUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894035; c=relaxed/simple;
	bh=gxzFO2D4eysttkHE1Ux3TZ95rNmSMQtNgyhC0dcYJeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1R93t3oeCYn2bgDLgj6PjjZdvJr8amlV4x45krOTSUtycPix4S2/m58YqS0GNjTu1pD5xK6wrHY6EI4EJDiluM5bSfZgMotib1ww1QnLlJcfdflgrR3dU7n7A1J8jWgnhoQ08910mwLFPuFuh7IuIqiVL1y+SBfa5yXIIglDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=K2YeL26Y; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70d9eb2e655so10015436d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755894033; x=1756498833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l70WFhqycv5nkPU3UrRJ6EMYeZQABqO3XZ+ctox0Og=;
        b=K2YeL26YPD7zDfJGjDTvXYeDYyGPHuA21Fvg/vl17fZR280xLEupB5z6ic1kv/L+yT
         KbWWKpBk2+k6LjAcTzBCFLlLe66z2wY8vr9S3OZGo7O2LxWuY2X7LDOLUtQRnuzFJYYI
         2w0XSAHpA37bOBLMqL79R6XLUKEtHvgHZrRSqxeQ7B7JeEFeNTE8f/5eILBBKGeaNp1l
         lcZc3v1l8IyOt7GELIFiRURHkULbJcFEA4LRtIEpJImblFUKrP0WQ3TVyNHMqijaAiAn
         TA0NTK8YMuL4KxTlrY/eNI3NTy4rD27vp4SOalPSs13RNsi8AshPdjA7ANevUqw/AXa9
         Muhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894033; x=1756498833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l70WFhqycv5nkPU3UrRJ6EMYeZQABqO3XZ+ctox0Og=;
        b=iQdUCjtXLtXHLZVdlWWZWqETIJnnOiql2qd+2V+XrClEXcdnygMqwfQkCcXAdy8oWB
         wrP+0P5yEsC3vI6K1KRFDBYrQ4lneCqqkPGMaks4zy5FFjHcz7w/vZemBShjJN8gbyFX
         HTpsIiWmeacWhlwUaipRVBT3iaC9B74m4XEq497016HeWLyecF4MaIEnma1P6BNiqHJM
         5TTGbe8QhxF20cgLip1jHWT+WInJVCAce+iaUqNZKbx4/yFAKMUmsN45tCCvGluBynwg
         5NbLGO+zYqnqtP3cHPInHyZ2OfEtgk4sHlVgiJ4bA2+U01hLsHX1jkvy1eOaQsB0m/S0
         9FGw==
X-Gm-Message-State: AOJu0YxC2P1xXksQ83XxxjISIWfgaQeMeQ1qnfGngxPRMYMAt12tscIl
	xxw/1z9GQth/+gZgUyBhZ0pzAsdXoeHuf9MLQBmTpkFPb/WfyKUd7Nbo9gvkCKYRutI=
X-Gm-Gg: ASbGnct7BOUVY/fktbL2PTdPwjGJb6Dl3oK8sospM4ZHRWt91FQqIwSFQTXYM4qyds0
	iGcHe786bDKX4i2aHn9ymSdGQeCgD2H8bGhaAXeEPPaRPEIxhy1PvooDp27YLPGy8s70LN3iHyC
	6P0+B4361omvZhXovsxSHcYEN9mh4n9H5G8XiPfsXA0H33yDrupTK0S2pwIxdfyr4QaohddjY5R
	naUgt+Ki9+0YEhZ8ODjX21k8+xTnrydZzowj+99E3m8h5vEEk7RVzJQytzytR1wQqQlWsjKKjPO
	Zk+YucyYfEaUmZBF7BVG1/9BvQoNXXi9cyNT02y32KfEquhdBpk/HyBzF1ZZg4h6WkQXNHVvhhq
	SpsE9y6Qw6gm1ctUsA+RiVJrEs2ml6fSDVLs7YQ==
X-Google-Smtp-Source: AGHT+IHQdbGLB27VeQHL8oHYYGFfha5KkRMdhoMV8SHncYyU1CT3gPJWp55L2FxdpgtyRQp5wzV1PA==
X-Received: by 2002:ad4:5cad:0:b0:70d:774e:942a with SMTP id 6a1803df08f44-70d9710c391mr55114966d6.19.1755894032425;
        Fri, 22 Aug 2025 13:20:32 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714dc98sm4944206d6.12.2025.08.22.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:20:32 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v4 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Fri, 22 Aug 2025 16:20:10 -0400
Message-Id: <20250822202010.232922-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822202010.232922-1-ethan.ferguson@zetier.com>
References: <20250822202010.232922-1-ethan.ferguson@zetier.com>
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
 fs/exfat/exfat_fs.h  |   5 +
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  88 +++++++++++++++++
 fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 323 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..ed4b5ecb952b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -267,6 +267,7 @@ struct exfat_sb_info {
 	struct buffer_head **vol_amap; /* allocation bitmap */
 
 	unsigned short *vol_utbl; /* upcase table */
+	unsigned short *volume_label; /* volume name */
 
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
@@ -431,6 +432,10 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 /* super.c */
 int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
+int exfat_read_volume_label(struct super_block *sb);
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *uniname,
+			     struct inode *root_inode);
 
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
index 538d2b6ac2ec..970e3ee57c43 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -486,10 +487,93 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
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
+					unsigned long arg,
+					struct inode *root_inode)
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
+		if (ret < 0)
+			goto cleanup;
+		else if (lossy & NLS_NAME_LOSSY) {
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
+	ret = exfat_write_volume_label(sb, uniname, root_inode);
+
+cleanup:
+	kfree(uniname);
+	return ret;
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	u32 __user *user_attr = (u32 __user *)arg;
+	struct inode *root_inode = filp->f_path.mnt->mnt_root->d_inode;
 
 	switch (cmd) {
 	case FAT_IOCTL_GET_ATTRIBUTES:
@@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
 		return exfat_ioctl_fitrim(inode, arg);
+	case FS_IOC_GETFSLABEL:
+		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
+	case FS_IOC_SETFSLABEL:
+		return exfat_ioctl_set_volume_label(inode->i_sb, arg, root_inode);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8926e63f5bb7..7931cdb4a1d1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -573,6 +574,228 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_dentry,
+				       struct inode *root_inode)
+{
+	int i, ret;
+	unsigned int type, old_clu;
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
+			if (type == TYPE_DELETED && !deleted_ep && root_inode) {
+				deleted_ep = ep;
+				deleted_bh = bh;
+				continue;
+			}
+
+			if (type == TYPE_UNUSED) {
+				if (!root_inode) {
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
+				if (i < sbi->dentries_per_clu - 1) {
+					deleted_ep = ep;
+					deleted_bh = bh;
+
+					ep = exfat_get_dentry(sb, &clu,
+							      i + 1, &bh);
+					memset(ep, 0,
+					       sizeof(struct exfat_dentry));
+					ep->type = EXFAT_UNUSED;
+					exfat_update_bh(bh, true);
+					brelse(bh);
+
+					goto end;
+				}
+
+				// Last dentry in cluster
+				clu.size = 0;
+				old_clu = clu.dir;
+				ret = exfat_alloc_cluster(root_inode, 1,
+							  &clu, true);
+				if (ret < 0) {
+					brelse(bh);
+					goto end;
+				}
+
+				ret = exfat_ent_set(sb, old_clu, clu.dir);
+				if (ret < 0) {
+					exfat_free_cluster(root_inode, &clu);
+					brelse(bh);
+					goto end;
+				}
+
+				ret = exfat_zeroed_cluster(root_inode, clu.dir);
+				if (ret < 0) {
+					exfat_free_cluster(root_inode, &clu);
+					brelse(bh);
+					goto end;
+				}
+
+				deleted_ep = ep;
+				deleted_bh = bh;
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
+	ret = -EIO;
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
+
+	mutex_lock(&sbi->s_lock);
+	sbi->volume_label = kcalloc(EXFAT_VOLUME_LABEL_LEN,
+						     sizeof(short), GFP_KERNEL);
+	mutex_unlock(&sbi->s_lock);
+
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
+	struct buffer_head *bh = NULL;
+	struct exfat_dentry *ep = NULL;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, NULL);
+	// ENOENT signifies that a volume label dentry doesn't exist
+	// We will treat this as an empty volume label and not fail.
+	if (ret < 0 && ret != -ENOENT)
+		goto cleanup;
+
+	ret = exfat_alloc_volume_label(sb);
+	if (ret < 0)
+		goto cleanup;
+
+	mutex_lock(&sbi->s_lock);
+	if (!ep)
+		memset(sbi->volume_label, 0, EXFAT_VOLUME_LABEL_LEN);
+	else
+		for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
+			sbi->volume_label[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
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
+			     struct exfat_uni_name *uniname,
+			     struct inode *root_inode)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
+	struct exfat_dentry *ep = NULL;
+
+	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, root_inode);
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
@@ -791,6 +1014,7 @@ static void delayed_free(struct rcu_head *p)
 
 	unload_nls(sbi->nls_io);
 	exfat_free_upcase_table(sbi);
+	kfree(sbi->volume_label);
 	exfat_free_sbi(sbi);
 }
 
-- 
2.34.1


