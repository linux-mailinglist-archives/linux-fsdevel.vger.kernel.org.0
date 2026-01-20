Return-Path: <linux-fsdevel+bounces-74566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B9D3BE55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92E1C354A7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0033C1B7;
	Tue, 20 Jan 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="obEGGJ+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE533B6F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882810; cv=none; b=Yk05MIc45i+7DsJLuPan+/DMfVvAvNZnoBnyw9InhLNU9ELbyC5X8zIC4twNLhDymxm7Z8w9zl8P1wVKJ1gGt5DJBM+Ut9gdanI2qgRLC+YQUAfHxmps5JcEEGcFkGJbW1J7mCOGTxVPkSyZrAVORuZwEc2dmtUf02MoJfYqO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882810; c=relaxed/simple;
	bh=DlXgw2xybDKncbIwL7HxVkjEVsLQnZIQdS531aY8JUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AArykweHnhqn9Y+r8wbTg3HzXgfFI1Tzm8Hf3ds4XqrobB5VZVva9Xso08rKi2pmJJ9WQ8I5LFWv2Hebnazo3kGfM17lF32U74REZiyotKU8d3Ya74Rg4Vmla9c3AOnWrU3dZheD+fn9wO/U4Nu68tHibq1TxmwEJU/tT4r4zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=obEGGJ+l; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7926b269f03so42248397b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768882805; x=1769487605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jRfA1Hde7rJpNzHrIbFX351VYVHvA+SREvN9uZgC2c=;
        b=obEGGJ+lp16vG5AYD5reJEw2qWtuqkumV0grroFIedzfi61lu5bU5CWIZJJigJ4znB
         OR3Ucxg1W5Bgn8qnCJaUeMZUk7a9PuFNLrzxDNKAz/L6OKW/cH5H22LupVg/6sZHAqXK
         631baate2UfB6njT8hwPhLExhQgqrx1+JlhrgW+P2G6iKXbPuJWEpKOTuhmuQK4X9QFY
         fFFRgdvfMTBAPCep1sHdLPrSs9ptEQv/s6+FGIfy6Pzv38pRh5YNAw/5EFDqEolU2CBl
         FIYjaW4mf3+JXIlXL1rNMo4wSu6Cr3sX/F7oaLIPdZt6sBrx02s4oiVFSb5i+wVfax1M
         RgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768882805; x=1769487605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jRfA1Hde7rJpNzHrIbFX351VYVHvA+SREvN9uZgC2c=;
        b=f7dkJNZ0O6QBXXbk5XglnXhfTS/EDH50TnX2y4zXCsConyzMrjeXrSPtwc+Do8Lbci
         EXfiju23O4NpJqdAK96M8tMxhrhfzM94Oq6Pa8yE8fLf6LMdN6DetmqOQPloX7nl1XQz
         AXFOBMfkEKjGh4gVL6ZIHtmhNP3reRgl6h9ClD83DkavKEykWsh6tFzNwzac+bulwq4i
         rlQ1S69W4Io0qqan+YFH6KarMIznwZPFpH/LZbKxEIuxG2SmtWQtJuCM0O++krAli9KR
         9HayGgPEivvNDuBj7UJroQy8SJcVstue9ipjf1WDn/KpwE6xatwrbTHXCNQifRTyrNM6
         Ybng==
X-Forwarded-Encrypted: i=1; AJvYcCWc8EargEY8eDngw8e0NI4yqvyOuDFpdKwf28SZRzvc75kIVi/2HimTgUMNolby2NM4KF7+ZlaoBmMh9SZH@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvC0yIGLia3+b2A6fEsbO9vycSrJjBlW2WQHyvBMh1fIJt3T9
	6p58M0xmRiba5nuP/quF9GHmrw0SmpYXbyVESBLrIIFvmd+szLJphb7AxinQzcXAVSY=
X-Gm-Gg: AZuq6aJtI8xd0XAZlzOAUOF6DYfBoN141ug2mpmY1pyLiRvNovgBRmNTI9lHHnh0mxD
	7X9oJXkjX9KWw28mjhIKTef6Xwit0nGf54fL3/g1/2KHBfEmbU78Z5c0VQH/v0j6D/e9z5fmE9c
	jaWNg2eS+SCJdQpjdgTi1IrFyv2sCxpGEh7dqyltkKRbp05kTfNG3oo+73JkSoxIPwzjz1PgNuE
	Azh3HvA80j9pUbEQRIUK/XM9RqUhQiZojdT0l8yRit2Dd1kNcLFxtRmVtraE+YYAD++/qiPTEqu
	z8cepXp6t4c0CenA0CHCPhyWfoCIl5Bxz3wU3+vrtIoTEFm+iyWl7nT+rtNHq9y/t1iduA1+bH8
	2rdFnnBjf72aRil/DcEZPUmB6Cp/sn+aA2etnwbrKjVgRMIQwrLEbTlgTO1Ksfg8KxJN+m6FWok
	nkO+wfDXzs1u2j59trnnF8ekUNiheDTX+d/TDzP4d6UFBPetP2UKGJafSoz6TGfyJEF5vg8JTBZ
	YJ1fPP+YWN2e6aOONlYRQE=
X-Received: by 2002:a05:690c:c50c:b0:78f:984b:4bef with SMTP id 00721157ae682-7940a470576mr11400417b3.68.1768882805114;
        Mon, 19 Jan 2026 20:20:05 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:ead3:ebfb:3b92:a0e5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c686db17sm47946407b3.38.2026.01.19.20.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:20:04 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/062 xfstests failure
Date: Mon, 19 Jan 2026 20:19:38 -0800
Message-Id: <20260120041937.3450928-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/062 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/062 - output mismatch (see xfstests-dev/results//generic/062.out.bad)

The generic/062 test tries to set and get xattrs for various types
of objects (regular file, folder, block device, character
device, pipe, etc) with the goal to check that xattr operations
works correctly for all possible types of file system objects.
But current HFS+ implementation somehow hasn't support of
xattr operatioons for the case of block device, character
device, and pipe objects. Also, it has not completely correct
set of operations for the case symlinks.

This patch implements proper declaration of xattrs operations
hfsplus_special_inode_operations and hfsplus_symlink_inode_operations.
Also, it slightly corrects the logic of hfsplus_listxattr()
method.

sudo ./check generic/062
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #59 SMP PREEMPT_DYNAMIC Mon Jan 19 16:26:21 PST 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/062 20s ...  20s
Ran: generic/062
Passed all 1 tests

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/93

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 23 +++++++++++++++++++++--
 fs/hfsplus/xattr.c | 29 ++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 6153e5cc6eb6..533c43cc3768 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -396,6 +396,19 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.fileattr_set	= hfsplus_fileattr_set,
 };
 
+const struct inode_operations hfsplus_symlink_inode_operations = {
+	.get_link	= page_get_link,
+	.setattr	= hfsplus_setattr,
+	.getattr	= hfsplus_getattr,
+	.listxattr	= hfsplus_listxattr,
+};
+
+const struct inode_operations hfsplus_special_inode_operations = {
+	.setattr	= hfsplus_setattr,
+	.getattr	= hfsplus_getattr,
+	.listxattr	= hfsplus_listxattr,
+};
+
 static const struct file_operations hfsplus_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -455,12 +468,17 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		hip->clump_blocks = sbi->data_clump_blocks;
 	} else if (S_ISLNK(inode->i_mode)) {
 		sbi->file_count++;
-		inode->i_op = &page_symlink_inode_operations;
+		inode->i_op = &hfsplus_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &hfsplus_aops;
 		hip->clump_blocks = 1;
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		sbi->file_count++;
+		inode->i_op = &hfsplus_special_inode_operations;
 	} else
 		sbi->file_count++;
+
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 	hfsplus_mark_mdb_dirty(sb);
@@ -591,10 +609,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			inode->i_fop = &hfsplus_file_operations;
 			inode->i_mapping->a_ops = &hfsplus_aops;
 		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &hfsplus_symlink_inode_operations;
 			inode_nohighmem(inode);
 			inode->i_mapping->a_ops = &hfsplus_aops;
 		} else {
+			inode->i_op = &hfsplus_special_inode_operations;
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index c3dcbe30f16a..9904944cbd54 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -258,6 +258,15 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	return err;
 }
 
+static inline
+bool is_xattr_operation_supported(struct inode *inode)
+{
+	if (HFSPLUS_IS_RSRC(inode))
+		return false;
+
+	return true;
+}
+
 int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
@@ -268,9 +277,11 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	u16 folder_finderinfo_len = sizeof(DInfo) + sizeof(DXInfo);
 	u16 file_finderinfo_len = sizeof(FInfo) + sizeof(FXInfo);
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	hfs_dbg("ino %lu, name %s, value %p, size %zu\n",
+		inode->i_ino, name ? name : NULL,
+		value, size);
+
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	if (value == NULL)
@@ -390,6 +401,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 end_setxattr:
 	hfs_find_exit(&cat_fd);
+	hfs_dbg("finished: res %d\n", err);
 	return err;
 }
 
@@ -514,9 +526,7 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	u16 record_length = 0;
 	ssize_t res;
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	if (!strcmp_xattr_finder_info(name))
@@ -709,9 +719,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	res = hfsplus_listxattr_finder_info(dentry, buffer, size);
@@ -737,8 +745,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
 		if (err == -ENOENT) {
-			if (res == 0)
-				res = -ENODATA;
+			res = 0;
 			goto end_listxattr;
 		} else {
 			res = err;
-- 
2.43.0


