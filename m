Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14057AA89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbiGSXlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 19:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiGSXlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:41:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7104D17C;
        Tue, 19 Jul 2022 16:41:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p8so3628555plq.13;
        Tue, 19 Jul 2022 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqsR5Qa41uqsmBSwrGwuBGBYHH2ruR9RmWHJJrYHuuw=;
        b=Cm3VoniwbPwxVmYtpDACUHbb+TC1ngFQZjr2AVqXutU05iMZG+Y2QnuITneZhJXqm1
         dpukrVAgu1e7Li/UzuJ2qD+FiofXucgeDuCrChnp7AnDjpQnQh3OpEa+HST2QJQPG9in
         4NptzAmJaq/zVgR+1SFppTKqAElLWfoT7Id8sLoR9N1HDOXtZpRhkPqfOyl0L2tLoyee
         iY54ayQtBx6BDrbTdU9mjzQid+mPFu53xjMsomrpb0NXMQUuNNvuh1tHeYN46t0NVj5+
         52gBbu24jGKQflICTKKHV3c/zg5zFOHfnYBDrnw6lJpMnAaA+axT7fdzMRth8I2V/5dF
         KnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqsR5Qa41uqsmBSwrGwuBGBYHH2ruR9RmWHJJrYHuuw=;
        b=VXYYzeiVNVqhJ7QrN8CgcRhUcBlMMeBWwAZ9KVglAXPEMIs7R6WTI1CKohWhrWprOE
         BdbWGoADc+ZgsJhnxNSNjNCBJeqLFXw3o4m/0DvlT+kyqnrX+OyzEsKMhegRvo2O1EF0
         PiJGlup0PnDduZvUSmY+/ASHEXH5E2hb5OWeTMbSHKLkZ4x1Oo0g7KKps+sh1LDIH1j1
         TuRpH11KlFBOAjxPdkHqODnsIGtI4uBDiJDGIBTcGlKbknOL0uibNmkTfMxIlEz5RwLE
         TCGAqKGFqlT4YiquhzPBUPkq8Y2p60y4H5/QWF4RMqrVzGtXnwobNDzAAfOokKyXJm/2
         SOiA==
X-Gm-Message-State: AJIora/ys+aoItPsLbKsM8MWNFI12vtUCqHxc6rPrzHZmlVMrOsuEifQ
        +x0j5S1ltoq4UED0Ck/UiAOXlD59l5UKMg==
X-Google-Smtp-Source: AGRyM1ul9g2AM6xEXtrh38YKk/niq2P7kj2874xrO8q5T5qlbwx87fUqcA4buHJWN1LNKyr7OesT7A==
X-Received: by 2002:a17:902:f546:b0:16b:e4c7:671b with SMTP id h6-20020a170902f54600b0016be4c7671bmr36069613plf.129.1658274097670;
        Tue, 19 Jul 2022 16:41:37 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:c88e:7520:969d:1265])
        by smtp.googlemail.com with ESMTPSA id w3-20020a626203000000b005253bf1e4d0sm11900379pfb.24.2022.07.19.16.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:41:37 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Date:   Tue, 19 Jul 2022 16:41:31 -0700
Message-Id: <20220719234131.235187-1-bongiojp@gmail.com>
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

Changes in v4:
Removed unused variable.

 fs/ext4/ext4.h  | 11 +++++++
 fs/ext4/ioctl.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index cb01c1da0f9d..2c4c3eedfb7b 100644
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
@@ -1131,6 +1141,66 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	return 0;
 }
 
+static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
+			struct fsuuid __user *ufsuuid)
+{
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
@@ -1509,6 +1579,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_setlabel(filp,
 					   (const void __user *)arg);
 
+	case EXT4_IOC_GETFSUUID:
+		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
+	case EXT4_IOC_SETFSUUID:
+		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -1586,6 +1660,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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

