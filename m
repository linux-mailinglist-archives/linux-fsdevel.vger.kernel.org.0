Return-Path: <linux-fsdevel+bounces-60575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7507B495C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CD3412A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC07311945;
	Mon,  8 Sep 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="TbLf8pG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9D311588
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349643; cv=none; b=hPrESjjvazGkJT7GoUHs6/3VleIZ/TdkREpqLQkZLCzGbWAMzdGS5cGrx+yx9PgtIVNtYflEzM+4WY4avP17BYgLWugp6YZH+nLXk226ZtTslq97NNEDQd185ZhrmekQoP2fV85Pcf4wKz1KpaQh0IrRAMzqZhPbREz48l4/dw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349643; c=relaxed/simple;
	bh=XMY2/xu8PJI7DUrwm4ZXgwInILMf9viF7DT55xJdiWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lODW7ks4z9/5jxxQW/DoOhVsS0UlPx7aUXzCb5BLQ7JH/QvYVfvtWuojy87qHrHDobofwr4tH2BpzT4CXoya9yiP7zAGOyGW0YuDUtUUsga6epp/dehZ4konFhj0VgWqZe44jWHI5T9Kbc+UxstEnGumMbE+rz9/0TOPbPhMydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=TbLf8pG3; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-729c10746edso35088056d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757349639; x=1757954439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA+XrAiCtFVnCRuwQJPE61a3h/yFrURoMqW1IT0bnMY=;
        b=TbLf8pG3UzoNwgRWDk43+cIS/aFz53p7VrgPzOhL8ePjrm3TGYkE7vjyB+jlae6jou
         jPqCvwMUZ1tSqkxlmXx5LloNa/CtkR3NFWrBZd5RgjpDhqAjGwNUKnfW8t244n8jIpt+
         5OTJwAVMJCp/9PMAHoA7m20QRYf0rUnf4b3/JRHaYWQaaCOHwbnmiMzDfA3Moh8syaYf
         9Cn/cYCnBQH79KCimxYJfrZlucbobNDFHZ2DwGsAWZBBDydP7+3VDLRW5KOq6rvXKF+Y
         ZhFgktZ8XHB1Vbz7dDCkJng5YuXM1QYnRSrGpP68vtTdDeqGL2dWcmr6VOSZayddx2q5
         KYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349639; x=1757954439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA+XrAiCtFVnCRuwQJPE61a3h/yFrURoMqW1IT0bnMY=;
        b=hTV2ENkhkL31OLgtIfZtEWscCW+UypNKBT/+SZCSOnEM2gwu/cBKTJNsU39U/jSy//
         VbeR9HxArlSfEyieynSqrQlwOzQHrFkZnw0FXxPJBtL/f8JlywD6KOeUiFYiR8N7YzNa
         zemWWnR917R0+Czpi6DGmCmZaMjIY6YmMVUKuTYdmBdhXt2872wvgsH3RyplLp+OdeG/
         tk+lje83A60e5eBoYShG5a3xbRKeY19eTgNiN1EeRrGZT9ozDhCWR8A5LUUr8oJGpQQ+
         tiMITCKeb3czF/65O6vjzvVfXTR0RQI9Ydv+nfgjvY+j2G41+FXIM39/7D6rza/yFR8I
         KlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP1+LWpaNUKzQmfi7zIIHi/hXnMw5lklsqEncT1zTPFEOgavB766G0H6dv7gbES1489ugpXvLKUZu/yjvH@vger.kernel.org
X-Gm-Message-State: AOJu0YwGguCMB5jV5/3JCIpeqkAbXgdQB7289+8qLv8JEmYErYHXyRN6
	FvroQwpSjMFlbDO2vUwQvUFc10Xz8rSRVBpH+Nz1a3tPtcfImoYRLOL+EKLKDxKv9dvefQC+MoK
	IUdiv
X-Gm-Gg: ASbGncssz+HIy/j/dsK4AHRfvJQElUJA+Cv8T+d5dWd5HoX+7F32Ku3qyDQH6z1pEUJ
	cIdgua3Hwwwkzs5B/Md4aAMYb8zHx5rY090wlLtQ6EuEsfMmxVi9CNDKPbs1QaYpuXo56YCflv0
	eegmh4l8qvGrDAmdtZO9eBevt+ioYRnnknXX6HFExZ2B3vTLZyxLL24cYa/UwZ342Gh1FGCgbPt
	pTHX+1uptyHnrF0wa/XnZkyir065zWHCOXQPueTsSlvVDR7XLegTbTHLkUY2gxaAcI0gLaPunw2
	IoDYrYtEMvzHOaETh9zWhNOwHFcETh8tFDBow/J33W202htjtHk7TcQiIst4lJfq3k60j2XH2Y2
	gI/32Q3zrn3SeCCXdcCxGc04E/YQxLV8mlsFIPQ==
X-Google-Smtp-Source: AGHT+IFlG4T4xorxAijBMrIX7CGQ5l5ZtLksTzHwaUqTaZf2athPaTXSQBXJSEmdqGRA9WkMK0B0YQ==
X-Received: by 2002:a05:6214:20cf:b0:70d:f9d0:de72 with SMTP id 6a1803df08f44-7393d43265fmr72984926d6.61.1757349639110;
        Mon, 08 Sep 2025 09:40:39 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72a2d06b9b5sm88751706d6.70.2025.09.08.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:40:38 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v6 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon,  8 Sep 2025 12:40:28 -0400
Message-Id: <20250908164028.31711-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908164028.31711-1-ethan.ferguson@zetier.com>
References: <20250908164028.31711-1-ethan.ferguson@zetier.com>
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
 fs/exfat/dir.c       | 162 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ee060e26f51d..9223ef687a74 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1244,3 +1244,165 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 
 	return count;
 }
+
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_ep)
+{
+	int i, ret;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_hint_femp *hint_femp = &EXFAT_I(sb->s_root->d_inode)->hint_femp;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+	bool continue_deleted = false;
+
+	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
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
+			if (type == TYPE_DELETED || type == TYPE_UNUSED) {
+				if (hint_femp->eidx == EXFAT_HINT_NONE) {
+					continue_deleted = true;
+					hint_femp->cur = clu;
+					hint_femp->eidx = i;
+					if (type == TYPE_UNUSED)
+						hint_femp->count = sbi->dentries_per_clu - i;
+					else
+						hint_femp->count = 1;
+				} else if (continue_deleted) {
+					hint_femp->count++;
+				}
+			} else {
+				continue_deleted = false;
+			}
+
+			if (type == TYPE_UNUSED) {
+				ret = -ENOENT;
+				brelse(bh);
+				goto error;
+			}
+
+			if (type == TYPE_VOLUME) {
+				*out_bh = bh;
+				*out_ep = ep;
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
+	hint_femp->cur = clu;
+	hint_femp->eidx = 0;
+	hint_femp->count = 0;
+
+	ret = -ENOENT;
+
+error:
+	*out_bh = NULL;
+	*out_ep = NULL;
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
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	/* ENOENT signifies that a volume label dentry doesn't exist */
+	/* We will treat this as an empty volume label and not fail. */
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
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct exfat_entry_set_cache es = {0};
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh = NULL;
+
+	if (label->name_len > EXFAT_VOLUME_LABEL_LEN)
+		return -EINVAL;
+
+	mutex_lock(&sbi->s_lock);
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	if (ret == -ENOENT) {
+		if (label->name_len == 0) {
+			/* No need to allocate new volume label dentry */
+			ret = 0;
+			goto cleanup;
+		} else {
+			ret = exfat_find_empty_entry(root_inode, &clu, 1, &es);
+			if (ret < 0)
+				goto cleanup;
+			ret = 0;
+
+			ep = exfat_get_dentry_cached(&es, 0);
+			memset(ep, 0, sizeof(struct exfat_dentry));
+			ep->type = EXFAT_VOLUME;
+			es.modified = true;
+		}
+	} else if (ret < 0) {
+		goto cleanup;
+	}
+
+	for (i = 0; i < label->name_len; i++)
+		ep->dentry.volume_label.volume_label[i] =
+			cpu_to_le16(label->name[i]);
+	/* Fill the rest of the str with 0x0000 */
+	for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		ep->dentry.volume_label.volume_label[i] = 0x0000;
+
+	ep->dentry.volume_label.char_count = label->name_len;
+
+cleanup:
+	if (bh) {
+		exfat_update_bh(bh, IS_DIRSYNC(root_inode));
+		brelse(bh);
+	}
+
+	exfat_put_dentry_set(&es, IS_DIRSYNC(root_inode));
+
+	mutex_unlock(&sbi->s_lock);
+	return ret;
+}
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..329697c89d09 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -477,6 +477,9 @@ int exfat_force_shutdown(struct super_block *sb, u32 flags);
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
 extern const struct dentry_operations exfat_utf8_dentry_ops;
+int exfat_find_empty_entry(struct inode *inode,
+		struct exfat_chain *p_dir, int num_entries,
+			   struct exfat_entry_set_cache *es);
 
 /* cache.c */
 int exfat_cache_init(void);
@@ -517,6 +520,10 @@ int exfat_get_empty_dentry_set(struct exfat_entry_set_cache *es,
 		unsigned int num_entries);
 int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
+int exfat_read_volume_label(struct super_block *sb,
+			    struct exfat_uni_name *label_out);
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *label);
 
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
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
-- 
2.34.1


