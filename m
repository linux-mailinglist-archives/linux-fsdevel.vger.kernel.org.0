Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF0563B11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGAUMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiGAULy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:11:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31F58FE5;
        Fri,  1 Jul 2022 13:11:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so3361349pgs.3;
        Fri, 01 Jul 2022 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWWq2l7x4j8QkihvnI7D4BaLA0CA33eSGP54fRTUtZ8=;
        b=SE0NlNgneYoUCa71nO0MLM7oRAsoepETaKTv8zddYwRrlWEw1qB22rkPq0mhaMfGBm
         F2Yf5D0cZhic4NNUB0BykZSdDexD3qJ9jiad5/nOJLSoQnhjboUCCkpKzePmar8/Y0Hl
         J+3voEG61Is30X4LZ/UcH0mJf4MIu39LxW7SKfwCfeJeI+/Mn6LMbr2PnwW/U+2ca6uX
         sK/B9tNXdzPKnwp+mj2EvBjNujbYLNEU2/9pmzH82yT5ATLy7OkycOya9I+oohc0tvlw
         IIFGUJjjsiTIbU/KK83AAUeRZ0SWfHYjDwvIyyHrlWxuM0sqhwv3B6f7iQ3pDSz5GLCK
         P1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWWq2l7x4j8QkihvnI7D4BaLA0CA33eSGP54fRTUtZ8=;
        b=WkHkKIL//LUqfu3uygQxk1atgy+pKHV1QP1YV3r4n4+IH9hqBUmLhSRZM73LZiXNVa
         hCdCTqJfEqdhlvhKxTumQ84HT7/0gXrYJcEor0GTKRftv0CkOvKqPcuKRlSpvuIu9QIS
         eBgqxPl7kpbixvKs7zY7U+enXCpRD7a9f89EHsBPSCrg39aJ5jLa0FShBzoHbRrmhbUX
         3/q93BXxu9NjPrtMuyLno4BDgP44jlJT346Fi7W58n5uhiBlugLnUizvuHN0sQH0V4KJ
         UWmkU8E36TNhIHwXzpRbEUloLyUX6b/QlqO7cJpC5+18xuNYvCHBDIvTrWYTWqVisTVP
         trQQ==
X-Gm-Message-State: AJIora/+XhkUwxMOlXbWVdregpW7gPxYtch3uGk7ligXhm5G7T+cGjZF
        pfSkiElJSsNyfDr9LNXVGur0svAXbXE=
X-Google-Smtp-Source: AGRyM1urqKvkNTvHimy9bW2FV7QEut7gRKZd2WcpiYS5MOp0FhKpKfZHDOD4Ffa8p1LOpf2RtztzhA==
X-Received: by 2002:a05:6a00:d9b:b0:525:7208:3d9 with SMTP id bf27-20020a056a000d9b00b00525720803d9mr21647774pfb.82.1656706288646;
        Fri, 01 Jul 2022 13:11:28 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:443b:ca33:8b9a:ccba])
        by smtp.googlemail.com with ESMTPSA id k11-20020aa79d0b000000b0050dc76281d3sm16574676pfp.173.2022.07.01.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:11:28 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v2] Add ioctls to get/set the ext4 superblock uuid.
Date:   Fri,  1 Jul 2022 13:11:23 -0700
Message-Id: <20220701201123.183468-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/ext4/ext4.h  | 13 ++++++++
 fs/ext4/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..0cf960cb591e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -724,6 +724,8 @@ enum {
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
+#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
+#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -753,6 +755,17 @@ enum {
 						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
 						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 
+/*
+ * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
+ */
+struct fsuuid {
+	__u32       fu_len;
+	__u32       fu_flags;
+	__u8 __user fu_uuid[];
+};
+
+#define EXT4_IOC_SETFSUUID_FLAG_BLOCKING 0x1
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index cb01c1da0f9d..75069afc16ae 100644
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
@@ -1131,6 +1141,73 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	return 0;
 }
 
+static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
+			struct fsuuid __user *ufsuuid)
+{
+	int ret = 0;
+	__u8 uuid[UUID_SIZE];
+	struct fsuuid fsuuid;
+
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	if (fsuuid.fu_len != UUID_SIZE)
+		return -EINVAL;
+
+	lock_buffer(sbi->s_sbh);
+	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
+	unlock_buffer(sbi->s_sbh);
+
+	if (copy_to_user(&ufsuuid->fu_uuid[0], uuid, UUID_SIZE))
+		ret = -EFAULT;
+	return ret;
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
+	if (fsuuid.fu_len != UUID_SIZE)
+		return -EINVAL;
+
+	if (copy_from_user(uuid, &ufsuuid->fu_uuid[0], UUID_SIZE))
+		return -EFAULT;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	do {
+		if (ret == -EBUSY)
+			msleep(1000);
+		ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
+	} while (ret == -EBUSY &&
+		fsuuid.fu_flags & EXT4_IOC_SETFSUUID_FLAG_BLOCKING);
+
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1509,6 +1586,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_setlabel(filp,
 					   (const void __user *)arg);
 
+	case EXT4_IOC_GETFSUUID:
+		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
+	case EXT4_IOC_SETFSUUID:
+		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -1586,6 +1667,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CHECKPOINT:
 	case FS_IOC_GETFSLABEL:
 	case FS_IOC_SETFSLABEL:
+	case EXT4_IOC_GETFSUUID:
+	case EXT4_IOC_SETFSUUID:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.37.0.rc0.161.g10f37bed90-goog

