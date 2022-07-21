Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D357D70F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 00:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiGUWog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 18:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUWoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:44:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719EE78589;
        Thu, 21 Jul 2022 15:44:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so2921394pgc.12;
        Thu, 21 Jul 2022 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aC/fs4gtBUPJ1XcqWtBzIeZ4t21NIE+hcHDSProhOug=;
        b=qC1wIJyYzHPWuck+8MLr7C9b2GkXmDg8+fanLUyFhQDiVbqopXUKtwAn7WkUeVbceZ
         JuvR1Yns9S0Lb7RkXe3P+m+Ci1phq6/CREbX6gxLBy/zvZmCTkQL9IpENp/55JENABYF
         QKX42Kvs0dHBOUDF2MRPqNDK62r09Bs8f/DXHxxmt5jRt1Ia+r3DM2chl+8lVoVqHv+d
         Uulvnr6tveWFmcSu+11iCEu3kqAH/LpXc8HzuijFhgMMLWdgsHns8T5dOcCkvo6e4pAp
         Q9wyCv7PHQe4L0JxXJBIuvOxLt/ZDX1gtt7s8KdHYjSugSdDSszmjFqvmbT9WL5WdDyQ
         +ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aC/fs4gtBUPJ1XcqWtBzIeZ4t21NIE+hcHDSProhOug=;
        b=20aM+gJbkHxP0V9BNnvQumQybUuqj+shXymEJOayVvjd1YiIninDY3E1u+DHJSzuCf
         llPPGEXmKG4hKdIzpu8cVEezzSFY6arPowTLXqgeNFdOPtinuAngyaPhECaBrTDhqq5o
         UIM3bFcr847/ToTAAZsc3i+iqK4cQvEij0QuBbLSiYVQyvNVvLwAuDn3k5hn0wFsU/Pi
         /JyIUK9zd1UaPp+87ZR5tyteXy3ze/vXZ6RXjHwIM61LSDLblSdUBnT28dtjWAJuWP2x
         KfZRwNapbsposBX6Vrup8LvKwK+GjDf/Fndy5BE5HgQpo9GvUrINJf//iM4wkkNxtA/l
         2oXA==
X-Gm-Message-State: AJIora9px6Rt/wv5A1egW9P8bg5jUCLYiL/Ua4uA7fZd5GMJsMe5ZV6X
        uBh+cb4tkMAICDHewL3XDms=
X-Google-Smtp-Source: AGRyM1ukQpMK3hp0P+IfFqpQKVG3XEKbxoJBsNJC1WdQjp4Po/ys+k7iHQB6drUHxaZZfLxSzgqTNQ==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr562003pgu.30.1658443471471;
        Thu, 21 Jul 2022 15:44:31 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id pj5-20020a17090b4f4500b001df264610c4sm9925763pjb.0.2022.07.21.15.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:44:30 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v5] Add ioctls to get/set the ext4 superblock uuid.
Date:   Thu, 21 Jul 2022 15:44:22 -0700
Message-Id: <20220721224422.438351-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
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

Changes in v5:

Return size of uuid in a EXT4_IOC_GETFSUUID operation if fsu_len is 0.

 fs/ext4/ext4.h  | 11 +++++++
 fs/ext4/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

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
index cb01c1da0f9d..b7c9bf9e7864 100644
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
+	struct fsuuid fsuuid;
+	__u8 uuid[UUID_SIZE];
+
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	if (fsuuid.fsu_len == 0) {
+		fsuuid.fsu_len = UUID_SIZE;
+		if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid.fsu_len)))
+			return -EFAULT;
+		return -EINVAL;
+	}
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
2.37.1.359.gd136c6c3e2-goog

