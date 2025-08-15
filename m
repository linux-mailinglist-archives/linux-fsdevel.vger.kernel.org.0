Return-Path: <linux-fsdevel+bounces-58044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D319B284C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBA2581E8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D9318147;
	Fri, 15 Aug 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Bk5B/MHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B2308F17
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277874; cv=none; b=P+F9603q08DmeILsEigVX566dtYwKgK5O4huak40gVx+1MWWiVycA4zViaA+gZRO/4ti0oyZBpCr/5J3ufZxF9hvXAtmkWeQ1lw0XSjOdnfiznyaXOqIlobe39WPMiwyoTytU8Iw2sUC1FDCTETzK/JnPd2oT6W+drQwlmdFGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277874; c=relaxed/simple;
	bh=l/7Eh2DudsyPkLExw4dKdBqyZ0Rri+o75ltrxeKNJ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sj6nfruYK7yXylW2VugS9RyNiYPq/0Vq+B6O+FaQge3Vq8spb3csXIsW6KBRD5ubNLV+Hbkmca4qoyqd5b1ZvaL4oO6uzsuZ3x0yTEuy74U3Kfx5elAhoUiWiJECjtI6+IfoTHcIEE2QFPHO+2P0tnSEVtqcApCI07Jt0iJTlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Bk5B/MHB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b121dc259cso3966411cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755277871; x=1755882671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtC+BcI+CsBQKLzkcYUIR4H/yQk/QBWq5ePJ9iWrbf0=;
        b=Bk5B/MHBDBgubjzHWqeLljgno0Uz3j5qRFj3b8YHR5lUP2tZA3B+mtJgNzGR3Aov+y
         t2et+V19b68foBJoRM8xSvRNZNIO4OUOzO/JZzwwICfUe6teUCPacvqPESMHHHAWxxQW
         tI2ZBf1GYPjgvoDMAR1eurv4+sdlFFFqwoQa6carw6hIbFvqCStrBEeR7z5HU1uNKfEf
         O6y/g7m/CBAZjz0U+2R+kBuy89pmqj7cZcXKxb6oOvACc4mRNu7EF8GRyk9ft5Isadqd
         PCaekAtdYCW+nrsln7hkQhijEZybyJsvUgq4IuzAQxsDF0kDmqq2gpR5FESTjmofBpTb
         pl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277871; x=1755882671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtC+BcI+CsBQKLzkcYUIR4H/yQk/QBWq5ePJ9iWrbf0=;
        b=slkk7JsxTkSmody/H0lQxgLqJLkd8zMWN1u61AWSvGbBeB4/zXhLMzSUxVsvejNtqB
         Y+wpCeUBpjSHYmlyL5iHGerZpmAloZSCogbGKzBD14NZ+wvdJBjVQoAPuH67VNRMvRwx
         +eC+k63V3rof33jsM1OOb4C6axWcxQ9w65dG+Ib4NePMFaioKFIEHYftW/ReOgZN8xLs
         M1FXu0Vt/wMAAqngXljuiioBROroOSAv23i8CQzhALJTinNd3me4Prbqg9jLMeuzUG6l
         gCEOZMUTPYyF+tQX+sNXA9UuOGYO+huDpMQdLkIZylzGYXCVErwR5/WhlEtLc3ckILON
         bpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYGB7lR8aAg6oZ8xFkpeXavBhTRmONI+RV67Slb5ENQdpOuoPohx5rJFhBIEBbO52n8OqWkn7ba4uE+Qug@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Yl+J7J57dOfhpUGAMSATYtWLztdlpx/1eTG7rTpgSpsKfZI0
	G+Zqp9IrTCqLVIfbO8vqXLz7OfbhE8Q/ikiBFjQckqmD+jhSYYfGTeOn6oJay/WVD5I=
X-Gm-Gg: ASbGncuA6B8xzNon5ZQKX2Tcj0ndPHrq+WJT1h6Kl0Kw18kl/ot50eoxWuBHRDREKYY
	KHWHOSId/QeLxTaX6wW82uEdZS9d2zjpWBAo1ebMVEc9MVu6AJAbMzzkq1nHj2r5yR7pqcA2kZU
	LynWBHwRzYliBXgdrL9ckMLPsiwaXx9rML2C70V30/nRoQqcq22J5OnolSuYzhJY8juVbWvbRDu
	+g7AOg8yC/D64qYNQ5zykZ6HNEVFoWd8FjHLDwhu/A+zKzIul9IPNXOa1Op2Fle9EQA3vmC+HT/
	W1eWMoQ188wq4RrO8sc4oU5BieI3GJsnQTvZvqd+UH2jvJPCDw/Hf4v4Ynmaa+DWY8PtKmqn39V
	0/4sLG5ysNXiiaedNt/9Uh9JP6oBfUikRxfsNMA==
X-Google-Smtp-Source: AGHT+IGo0r6hm723oocYsiyYOKipJsMhZBj7nu7udPpnv9O4kFNCPcEVwjjc11jO2y0YA9vBm94kyw==
X-Received: by 2002:a05:622a:11cf:b0:4b0:863b:f4e6 with SMTP id d75a77b69052e-4b11e10fa95mr36384341cf.14.1755277871085;
        Fri, 15 Aug 2025 10:11:11 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e192d8esm137659985a.41.2025.08.15.10.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:11:10 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Fri, 15 Aug 2025 13:10:56 -0400
Message-Id: <20250815171056.103751-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815171056.103751-1-ethan.ferguson@zetier.com>
References: <20250815171056.103751-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..a764e6362172 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -267,6 +267,7 @@ struct exfat_sb_info {
 	struct buffer_head **vol_amap; /* allocation bitmap */
 
 	unsigned short *vol_utbl; /* upcase table */
+	unsigned short volume_label[EXFAT_VOLUME_LABEL_LEN]; /* volume name */
 
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
@@ -431,6 +432,7 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 /* super.c */
 int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
+int exfat_write_volume_label(struct super_block *sb);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 971a1ccd0e89..af04cef81c0c 100644
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
+		} __packed volume_label;
 		struct {
 			__u8 flags;
 			__u8 vendor_guid[16];
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 538d2b6ac2ec..c57d266aae3d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -486,6 +487,57 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
 	return exfat_force_shutdown(sb, flags);
 }
 
+static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret;
+	char utf8[FSLABEL_MAX] = {0};
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	size_t len = UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
+
+	mutex_lock(&sbi->s_lock);
+	ret = utf16s_to_utf8s(sbi->volume_label, len,
+				UTF16_HOST_ENDIAN, utf8, FSLABEL_MAX);
+	mutex_unlock(&sbi->s_lock);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int exfat_ioctl_set_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret = 0;
+	char utf8[FSLABEL_MAX];
+	size_t len;
+	unsigned short utf16[EXFAT_VOLUME_LABEL_LEN] = {0};
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX))
+		return -EFAULT;
+
+	len = strnlen(utf8, FSLABEL_MAX);
+	if (len > EXFAT_VOLUME_LABEL_LEN)
+		exfat_info(sb, "Volume label length too long, truncating");
+
+	mutex_lock(&sbi->s_lock);
+	ret = utf8s_to_utf16s(utf8, len, UTF16_HOST_ENDIAN, utf16, EXFAT_VOLUME_LABEL_LEN);
+	mutex_unlock(&sbi->s_lock);
+
+	if (ret < 0)
+		return ret;
+
+	memcpy(sbi->volume_label, utf16, sizeof(sbi->volume_label));
+
+	return exfat_write_volume_label(sb);
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -500,6 +552,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
index 8926e63f5bb7..cd426bb332e0 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -573,6 +574,98 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_dentry)
+{
+	int i;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+
+	clu.dir = sbi->root_dir;
+	clu.flags = ALLOC_FAT_CHAIN;
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh);
+
+			if (!ep)
+				return -EIO;
+
+			type = exfat_get_entry_type(ep);
+			if (type == TYPE_UNUSED) {
+				brelse(bh);
+				return -EIO;
+			}
+
+			if (type == TYPE_VOLUME) {
+				*out_bh = bh;
+				*out_dentry = ep;
+				return 0;
+			}
+
+			brelse(bh);
+		}
+
+		if (exfat_get_next_cluster(sb, &(clu.dir)))
+			return -EIO;
+	}
+
+	return -EIO;
+}
+
+static int exfat_read_volume_label(struct super_block *sb)
+{
+	int ret;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	if (ret < 0)
+		goto cleanup;
+
+	memcpy(sbi->volume_label, ep->dentry.volume_label.volume_label, sizeof(sbi->volume_label));
+
+cleanup:
+	if (bh)
+		brelse(bh);
+
+	return ret;
+}
+
+int exfat_write_volume_label(struct super_block *sb)
+{
+	int ret;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	if (ret < 0)
+		goto cleanup;
+
+	mutex_lock(&sbi->s_lock);
+	memcpy(ep->dentry.volume_label.volume_label, sbi->volume_label,
+				sizeof(sbi->volume_label));
+
+	ep->dentry.volume_label.char_count =
+		UniStrnlen(ep->dentry.volume_label.volume_label,
+				EXFAT_VOLUME_LABEL_LEN);
+	mutex_unlock(&sbi->s_lock);
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
@@ -616,6 +709,12 @@ static int __exfat_fill_super(struct super_block *sb,
 		goto free_bh;
 	}
 
+	ret = exfat_read_volume_label(sb);
+	if (ret) {
+		exfat_err(sb, "failed to read volume label");
+		goto free_bh;
+	}
+
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
 	if (ret) {
 		exfat_err(sb, "failed to scan clusters");
-- 
2.34.1

