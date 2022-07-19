Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67B57939C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 08:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiGSG4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiGSG4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:56:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E725291;
        Mon, 18 Jul 2022 23:56:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g4-20020a17090a290400b001f1f2b7379dso1535402pjd.0;
        Mon, 18 Jul 2022 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkKMjMc3GMLmWElO+5aTic/lvxqLH4t54nTlwOcczmI=;
        b=ktK2jD0eF4TnILpK49UuIJHofd6clQE1NC8sXlxhJ4IV5Jn8dmm3KqgE/G8GrzMzuq
         sBSNuWesrRoiWjAGNL4BQYC2WN8q0dx0XOL9G7gi5O+xCkjqbjjvNmXEuMPtGtB937y/
         jiaJqTWSwNQYNzKjFTpVbl/nkFsoneS+80LQPLEuf2Erqsibme3vfsKQNTGjqeS7dF8e
         yhJdNbmWUMIwYLgXPUrYXOvIKgrxDCXdN66DHxh2RzuZ0Fy11gFoknfgtwZkJg7vn0iM
         KmGHgXWoBJMm1lUgC3VuZkFSetn/fjX1K4iY2dy20y8ESkwGAQPS3gGq5hNEHO7KoCvb
         9qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkKMjMc3GMLmWElO+5aTic/lvxqLH4t54nTlwOcczmI=;
        b=xl6rml3rc08r9W3zDbeuMMTKwih2NjYGPouihYws6LCsWLU+XcYt2q9yLsSDkcslKS
         zLP8YgHavX4FLuk1dQ/47XQ29k59A68Jq/LGI6SPuxuor6dLWP3cleY9UTOr8TahlFLo
         YstunrBbmJpeb2mdGiXyLzoM4uRa2bQqVY01fSxsa1gCDDNaM9WurEFwTkIK5PNwwVum
         mlnDw665UIXD96k0nHsZibi/8GJVRKNRZ28stB9xlRzN7sPGIbe7B1dZ7hPiyvxfGB7e
         t30so4BBxKAr2gsM4YwEh666KkDaJRRmTZPE4Bbk3RFBVIJ9f/ugShAHpBI5Yp19R/kO
         W/Yw==
X-Gm-Message-State: AJIora9TtvYt5gT+9dFs8wHHZvWncUhIvJbU98XPBgmztDg++3kPzOXu
        jVS9mBZeMwxeGC4nyHvOMM8=
X-Google-Smtp-Source: AGRyM1sQtPtOA1gRvB7c49nmsx5Jx8slf5bDWZNaQeVTBMWAQlHeXmE48fU6ZZEAjGz+B3k5B1fWUQ==
X-Received: by 2002:a17:90b:3a84:b0:1f0:56d5:4600 with SMTP id om4-20020a17090b3a8400b001f056d54600mr43231866pjb.162.1658213759974;
        Mon, 18 Jul 2022 23:55:59 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id c128-20020a624e86000000b00525231e15ccsm10462256pfb.113.2022.07.18.23.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 23:55:59 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v3] Add ioctls to get/set the ext4 superblock uuid.
Date:   Mon, 18 Jul 2022 23:55:51 -0700
Message-Id: <20220719065551.154132-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes a race between changing the ext4 superblock uuid and operations
like mounting, resizing, changing features, etc.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---

This pair of ioctls may be implemented in more filesystems in the future,
namely XFS.

Changes in v3:

fu_* fields are now named fsu_*.

EXT4_IOC_SETFSUUID_FLAG_BLOCKING flag was removed.

Checks are in place to ensure fsu_flags is 0.

Removed inappropriate use of __user for VLA fsu_uuid. 

 fs/ext4/ext4.h  | 11 +++++++
 fs/ext4/ioctl.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..b760d669a1ca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -724,6 +724,8 @@ enum {
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
+#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
+#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -753,6 +755,15 @@ enum {
 						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
 						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 
+/*
+ * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
+ */
+struct fsuuid {
+	__u32       fsu_len;
+	__u32       fsu_flags;
+	__u8        fsu_uuid[];
+};
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index cb01c1da0f9d..59d320719596 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
+#include <linux/uuid.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -41,6 +42,15 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
 	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
 }
 
+/*
+ * Superblock modification callback function for changing file system
+ * UUID.
+ */
+static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
+{
+	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
+}
+
 static
 int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
 			   ext4_update_sb_callback func,
@@ -1131,6 +1141,67 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	return 0;
 }
 
+static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
+			struct fsuuid __user *ufsuuid)
+{
+	int ret = 0;
+	struct fsuuid fsuuid;
+	__u8 uuid[UUID_SIZE];
+
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
+		return -EINVAL;
+
+	lock_buffer(sbi->s_sbh);
+	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
+	unlock_buffer(sbi->s_sbh);
+
+	if (copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
+		return -EFAULT;
+	return 0;
+}
+
+static int ext4_ioctl_setuuid(struct file *filp,
+			const struct fsuuid __user *ufsuuid)
+{
+	int ret = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct fsuuid fsuuid;
+	__u8 uuid[UUID_SIZE];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * If any checksums (group descriptors or metadata) are being used
+	 * then the checksum seed feature is required to change the UUID.
+	 */
+	if (((ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb))
+			&& !ext4_has_feature_csum_seed(sb))
+		|| ext4_has_feature_stable_inodes(sb))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
+		return -EINVAL;
+
+	if (copy_from_user(uuid, &ufsuuid->fsu_uuid[0], UUID_SIZE))
+		return -EFAULT;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1509,6 +1580,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_setlabel(filp,
 					   (const void __user *)arg);
 
+	case EXT4_IOC_GETFSUUID:
+		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
+	case EXT4_IOC_SETFSUUID:
+		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -1586,6 +1661,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CHECKPOINT:
 	case FS_IOC_GETFSLABEL:
 	case FS_IOC_SETFSLABEL:
+	case EXT4_IOC_GETFSUUID:
+	case EXT4_IOC_SETFSUUID:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.37.0.170.g444d1eabd0-goog

