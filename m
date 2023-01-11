Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5E665D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjAKN5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 08:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAKN5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:57:43 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAAA6323
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 05:57:43 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so20081227pjg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 05:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfOSYsYW7YMODPgjminTUMyBs/OzYXawNKzfrzn/4eM=;
        b=06b9fAIz9svQnPFNSCkK6LWLMPh4YW+kNpOkT551Nw5fVFXyLHPu32uc8FYrjnoUlv
         qBxBzKWyqaDYhJAzrB7IOTX8IKtOk/LGDZgg6eUgz1RwzjA8T++SKd0I84f5/I3CWAjH
         WE74bDjz87U3ZeqkDhgt5ihKRW7i09gmSzF4bPrS7rp0FSmJWx3gSafK0lGK7k1Pe7Nw
         nSIGFJ9Sk9dBdsVBLORHtnFr6wlPM3i8hURKDgKCGEev4Ktm/HSUxfNacRdUR5z/m05z
         nniVxGCcMEC+KIe6Q1v0otaOHhVSTuJXQyRTaDIxeNSOjro6YzquXbvyurDY78mGzjIc
         duBw==
X-Gm-Message-State: AFqh2krvfK+mzXfm8N+fdwoh5lOZHO06PJnS6B665W4P39Qi51GKZoXm
        8PR47wKwRuKo04lABjAebZzc1VMjR5k=
X-Google-Smtp-Source: AMrXdXstl5ibaTe8LKeGV2z+/Nci3D1GJLzC4PYJmOwF0spWKAUmaiRlvj3Epzdid/dm4nN7fh9eiA==
X-Received: by 2002:a17:903:22c5:b0:193:2ed4:5615 with SMTP id y5-20020a17090322c500b001932ed45615mr15122801plg.29.1673445462427;
        Wed, 11 Jan 2023 05:57:42 -0800 (PST)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001929212b478sm10240908plh.118.2023.01.11.05.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:57:42 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Yuezhang Mo <Yuezhang.Mo@sony.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        =?UTF-8?q?Bar=C3=B3csi=20D=C3=A9nes?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] exfat: handle unreconized benign secondary entries
Date:   Wed, 11 Jan 2023 22:56:30 +0900
Message-Id: <20230111135630.8836-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sony PXW-Z280 camera add vendor allocation entries to directory of
pictures. Currently, linux exfat does not support it and the file is
not visible. This patch handle vendor extension and allocation entries
as unreconized benign secondary entries. As described in the specification,
it is recognized but ignored, and when deleting directory entry set,
the associated clusters allocation are removed as well as benign secondary
directory entries.

Cc: Yuezhang Mo <Yuezhang.Mo@sony.com> 
Cc: Wang Yugui <wangyugui@e16-tech.com>
Reported-by: Barócsi Dénes <admin@tveger.hu>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/dir.c       | 76 +++++++++++++++++++++++++++++---------------
 fs/exfat/exfat_fs.h  |  2 ++
 fs/exfat/exfat_raw.h | 20 ++++++++++++
 3 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 158427e8124e..1c372e2c3f44 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -29,14 +29,15 @@ static int exfat_extract_uni_name(struct exfat_dentry *ep,
 
 }
 
-static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
+static int exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
 {
-	int i;
+	int i, err;
 	struct exfat_entry_set_cache es;
 
-	if (exfat_get_dentry_set(&es, sb, p_dir, entry, ES_ALL_ENTRIES))
-		return;
+	err = exfat_get_dentry_set(&es, sb, p_dir, entry, ES_ALL_ENTRIES);
+	if (err)
+		return err;
 
 	/*
 	 * First entry  : file entry
@@ -56,12 +57,13 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	}
 
 	exfat_put_dentry_set(&es, false);
+	return 0;
 }
 
 /* read a directory entry from the opened directory */
 static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_entry *dir_entry)
 {
-	int i, dentries_per_clu, num_ext;
+	int i, dentries_per_clu, num_ext, err;
 	unsigned int type, clu_offset, max_dentries;
 	struct exfat_chain dir, clu;
 	struct exfat_uni_name uni_name;
@@ -146,8 +148,12 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 					0);
 
 			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &clu, i,
+			err = exfat_get_uniname_from_ext_entry(sb, &clu, i,
 				uni_name.name);
+			if (err) {
+				brelse(bh);
+				continue;
+			}
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
 				dir_entry->namebuf.lfnbuf_len);
@@ -375,6 +381,12 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
 			return TYPE_ACL;
 		return TYPE_CRITICAL_SEC;
 	}
+
+	if (ep->type == EXFAT_VENDOR_EXT)
+		return TYPE_VENDOR_EXT;
+	if (ep->type == EXFAT_VENDOR_ALLOC)
+		return TYPE_VENDOR_ALLOC;
+
 	return TYPE_BENIGN_SEC;
 }
 
@@ -567,12 +579,30 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 	int i;
 	struct exfat_dentry *ep;
 	struct buffer_head *bh;
+	int type;
 
 	for (i = order; i < num_entries; i++) {
 		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh);
 		if (!ep)
 			return -EIO;
 
+		type = exfat_get_entry_type(ep);
+		if (type & TYPE_BENIGN_SEC) {
+			struct exfat_chain dir;
+			unsigned int start_clu =
+				le32_to_cpu(ep->dentry.generic_secondary.start_clu);
+			u64 size = le64_to_cpu(ep->dentry.generic_secondary.size);
+			unsigned char flags = ep->dentry.generic_secondary.flags;
+
+			if (!(flags & ALLOC_FAT_CHAIN) || !start_clu || !size)
+				continue;
+
+			exfat_chain_set(&dir, start_clu,
+					EXFAT_B_TO_CLU_ROUND_UP(size, EXFAT_SB(sb)),
+					flags);
+			exfat_free_cluster(inode, &dir);
+		}
+
 		exfat_set_entry_type(ep, TYPE_DELETED);
 		exfat_update_bh(bh, IS_DIRSYNC(inode));
 		brelse(bh);
@@ -741,6 +771,7 @@ enum exfat_validate_dentry_mode {
 	ES_MODE_GET_STRM_ENTRY,
 	ES_MODE_GET_NAME_ENTRY,
 	ES_MODE_GET_CRITICAL_SEC_ENTRY,
+	ES_MODE_GET_BENIGN_SEC_ENTRY,
 };
 
 static bool exfat_validate_entry(unsigned int type,
@@ -754,36 +785,33 @@ static bool exfat_validate_entry(unsigned int type,
 		if  (type != TYPE_FILE && type != TYPE_DIR)
 			return false;
 		*mode = ES_MODE_GET_FILE_ENTRY;
-		return true;
+		break;
 	case ES_MODE_GET_FILE_ENTRY:
 		if (type != TYPE_STREAM)
 			return false;
 		*mode = ES_MODE_GET_STRM_ENTRY;
-		return true;
+		break;
 	case ES_MODE_GET_STRM_ENTRY:
 		if (type != TYPE_EXTEND)
 			return false;
 		*mode = ES_MODE_GET_NAME_ENTRY;
-		return true;
+		break;
 	case ES_MODE_GET_NAME_ENTRY:
-		if (type == TYPE_STREAM)
+		if (type & TYPE_BENIGN_SEC)
+			*mode = ES_MODE_GET_BENIGN_SEC_ENTRY;
+		else if (type != TYPE_EXTEND)
 			return false;
-		if (type != TYPE_EXTEND) {
-			if (!(type & TYPE_CRITICAL_SEC))
-				return false;
-			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
-		}
-		return true;
-	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+		break;
+	case ES_MODE_GET_BENIGN_SEC_ENTRY:
+		/* Assume unreconized benign secondary entry */
+		if (!(type & TYPE_BENIGN_SEC))
 			return false;
-		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
-			return false;
-		return true;
+		break;
 	default:
-		WARN_ON_ONCE(1);
 		return false;
 	}
+
+	return true;
 }
 
 struct exfat_dentry *exfat_get_dentry_cached(
@@ -1164,10 +1192,8 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
 
 		type = exfat_get_entry_type(ext_ep);
 		brelse(bh);
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+		if (type & TYPE_CRITICAL_SEC || type & TYPE_BENIGN_SEC)
 			count++;
-		else
-			break;
 	}
 	return count;
 }
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 25a5df0fdfe0..8a399e234aab 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -71,6 +71,8 @@ enum {
 #define TYPE_PADDING		0x0402
 #define TYPE_ACLTAB		0x0403
 #define TYPE_BENIGN_SEC		0x0800
+#define TYPE_VENDOR_EXT		0x0801
+#define TYPE_VENDOR_ALLOC	0x0802
 
 #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
 #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 7f39b1c6469c..066df432f38e 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -50,6 +50,8 @@
 #define EXFAT_STREAM		0xC0	/* stream entry */
 #define EXFAT_NAME		0xC1	/* file name entry */
 #define EXFAT_ACL		0xC2	/* stream entry */
+#define EXFAT_VENDOR_EXT	0xE0	/* vendor extension entry */
+#define EXFAT_VENDOR_ALLOC	0xE1	/* vendor allocation entry */
 
 #define IS_EXFAT_CRITICAL_PRI(x)	(x < 0xA0)
 #define IS_EXFAT_BENIGN_PRI(x)		(x < 0xC0)
@@ -155,6 +157,24 @@ struct exfat_dentry {
 			__le32 start_clu;
 			__le64 size;
 		} __packed upcase; /* up-case table directory entry */
+		struct {
+			__u8 flags;
+			__u8 vendor_guid[16];
+			__u8 vendor_defined[14];
+		} __packed vendor_ext; /* vendor extension directory entry */
+		struct {
+			__u8 flags;
+			__u8 vendor_guid[16];
+			__u8 vendor_defined[2];
+			__le32 start_clu;
+			__le64 size;
+		} __packed vendor_alloc; /* vendor allocation directory entry */
+		struct {
+			__u8 flags;
+			__u8 custom_defined[18];
+			__le32 start_clu;
+			__le64 size;
+		} __packed generic_secondary; /* generic secondary directory entry */
 	} __packed dentry;
 } __packed;
 
-- 
2.25.1

