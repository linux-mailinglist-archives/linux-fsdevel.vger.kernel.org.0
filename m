Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BEF7A8C87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjITTP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjITTP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:26 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA418E;
        Wed, 20 Sep 2023 12:14:52 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2764b04dc5cso50739a91.3;
        Wed, 20 Sep 2023 12:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237291; x=1695842091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/w+iFsOw+9R6TOmv8TsPrH6RWn9igJVx+jEqxf1A0=;
        b=Dn80mG3YqQMD9zOF1ZKM77tp/1vQVXyoxFbD3RN3nibfvxr/LGlRvK3EQ89Hkd2e3i
         rBv6F3C60clawv9NLLuRl7YC4w86geMz0ieFzbB1CACKZHdj5KCA/VJymAXfAXcFhsuh
         C3AbQOiAsoEepNzKxHe+oisjGEfQTpf9wB7P6SNLhHr7aoCudsBA1oJG5EIsK3ASlD19
         osaeS5+6Lyam+mX6dGvMHQSTdzwIkX00eB/9etOQYwDt3AgaEqBqxsHwldblI6nRg46e
         vE5wNjBnp35UbU7JbHacdlvLNJv4T5lcV6xbiHgkT1/LPE/zKOFVhrjWf+Y6EYVkG7ds
         STbQ==
X-Gm-Message-State: AOJu0YxiPuzagX6LCTiNdts7MgUe3vlVkwo7w4fNyfxpn88AnWftZLsP
        93Reyt0f8FLYOAaAez5dqI4=
X-Google-Smtp-Source: AGHT+IFNycPbitH/IfCXqwt9tHmiKj3elCAyr0qCcP5EmmHoWHWTHI31P50Luu1cTGe8uWmAb0ZKkA==
X-Received: by 2002:a17:90b:3902:b0:274:9a85:2596 with SMTP id ob2-20020a17090b390200b002749a852596mr3680924pjb.32.1695237291121;
        Wed, 20 Sep 2023 12:14:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:14:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/13] fs/f2fs: Restore the whint_mode mount option
Date:   Wed, 20 Sep 2023 12:14:26 -0700
Message-ID: <20230920191442.3701673-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restore support for the whint_mode mount option by reverting commit
930e2607638d ("f2fs: remove obsolete whint_mode").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/filesystems/f2fs.rst | 70 ++++++++++++++++++++++
 fs/f2fs/f2fs.h                     |  9 +++
 fs/f2fs/segment.c                  | 95 ++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    | 32 +++++++++-
 4 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d32c6209685d..de412ddebcc8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -242,6 +242,12 @@ offgrpjquota		 Turn off group journalled quota.
 offprjjquota		 Turn off project journalled quota.
 quota			 Enable plain user disk quota accounting.
 noquota			 Disable all plain disk quota option.
+whint_mode=%s		 Control which write hints are passed down to block
+			 layer. This supports "off", "user-based", and
+			 "fs-based".  In "off" mode (default), f2fs does not pass
+			 down hints. In "user-based" mode, f2fs tries to pass
+			 down hints given by users. And in "fs-based" mode, f2fs
+			 passes down hints with its policy.
 alloc_mode=%s		 Adjust block allocation policy, which supports "reuse"
 			 and "default".
 fsync_mode=%s		 Control the policy of fsync. Currently supports "posix",
@@ -776,6 +782,70 @@ In order to identify whether the data in the victim segment are valid or not,
 F2FS manages a bitmap. Each bit represents the validity of a block, and the
 bitmap is composed of a bit stream covering whole blocks in main area.
 
+Write-hint Policy
+-----------------
+
+1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
+
+2) whint_mode=user-based. F2FS tries to pass down hints given by
+users.
+
+===================== ======================== ===================
+User                  F2FS                     Block
+===================== ======================== ===================
+N/A                   META                     WRITE_LIFE_NOT_SET
+N/A                   HOT_NODE                 "
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                "
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+extension list        "                        "
+
+-- buffered io
+WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+WRITE_LIFE_NONE       "                        "
+WRITE_LIFE_MEDIUM     "                        "
+WRITE_LIFE_LONG       "                        "
+
+-- direct io
+WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+===================== ======================== ===================
+
+3) whint_mode=fs-based. F2FS passes down hints with its policy.
+
+===================== ======================== ===================
+User                  F2FS                     Block
+===================== ======================== ===================
+N/A                   META                     WRITE_LIFE_MEDIUM;
+N/A                   HOT_NODE                 WRITE_LIFE_NOT_SET
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                WRITE_LIFE_NONE
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+extension list        "                        "
+
+-- buffered io
+WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
+WRITE_LIFE_NONE       "                        "
+WRITE_LIFE_MEDIUM     "                        "
+WRITE_LIFE_LONG       "                        "
+
+-- direct io
+WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+===================== ======================== ===================
+
 Fallocate(2) Policy
 -------------------
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c..39ffad5c4087 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -157,6 +157,7 @@ struct f2fs_mount_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	/* For which write hints are passed down to block layer */
+	int whint_mode;
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
@@ -1343,6 +1344,12 @@ enum {
 	FS_MODE_FRAGMENT_BLK,		/* block fragmentation mode */
 };
 
+enum {
+	WHINT_MODE_OFF,		/* not pass down write hints */
+	WHINT_MODE_USER,	/* try to pass down hints given by users */
+	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
+};
+
 enum {
 	ALLOC_MODE_DEFAULT,	/* stay default */
 	ALLOC_MODE_REUSE,	/* reuse segments as much as possible */
@@ -3727,6 +3734,8 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d05b41608fc0..38c0cb8d9571 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3290,6 +3290,101 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
 	}
 }
 
+/* This returns write hints for each segment type. This hints will be
+ * passed down to block layer. There are mapping tables which depend on
+ * the mount option 'whint_mode'.
+ *
+ * 1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
+ *
+ * 2) whint_mode=user-based. F2FS tries to pass down hints given by users.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_NOT_SET
+ *                       HOT_NODE                 "
+ *                       WARM_NODE                "
+ *                       COLD_NODE                "
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        "
+ * WRITE_LIFE_MEDIUM     "                        "
+ * WRITE_LIFE_LONG       "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+ *
+ * 3) whint_mode=fs-based. F2FS passes down hints with its policy.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_MEDIUM;
+ *                       HOT_NODE                 WRITE_LIFE_NOT_SET
+ *                       WARM_NODE                "
+ *                       COLD_NODE                WRITE_LIFE_NONE
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
+ * WRITE_LIFE_NONE       "                        "
+ * WRITE_LIFE_MEDIUM     "                        "
+ * WRITE_LIFE_LONG       "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+ */
+
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+				enum page_type type, enum temp_type temp)
+{
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER) {
+		if (type == DATA) {
+			if (temp == WARM)
+				return WRITE_LIFE_NOT_SET;
+			else if (temp == HOT)
+				return WRITE_LIFE_SHORT;
+			else if (temp == COLD)
+				return WRITE_LIFE_EXTREME;
+		} else {
+			return WRITE_LIFE_NOT_SET;
+		}
+	} else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS) {
+		if (type == DATA) {
+			if (temp == WARM)
+				return WRITE_LIFE_LONG;
+			else if (temp == HOT)
+				return WRITE_LIFE_SHORT;
+			else if (temp == COLD)
+				return WRITE_LIFE_EXTREME;
+		} else if (type == NODE) {
+			if (temp == WARM || temp == HOT)
+				return WRITE_LIFE_NOT_SET;
+			else if (temp == COLD)
+				return WRITE_LIFE_NONE;
+		} else if (type == META) {
+			return WRITE_LIFE_MEDIUM;
+		}
+	}
+	return WRITE_LIFE_NOT_SET;
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..5bb062075acf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -141,6 +141,7 @@ enum {
 	Opt_jqfmt_vfsold,
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
+	Opt_whint,
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
@@ -220,6 +221,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
+	{Opt_whint, "whint_mode=%s"},
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
@@ -988,6 +990,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			f2fs_info(sbi, "quota operations not supported");
 			break;
 #endif
+		case Opt_whint:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "user-based")) {
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_USER;
+			} else if (!strcmp(name, "off")) {
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
+			} else if (!strcmp(name, "fs-based")) {
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_FS;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		case Opt_alloc:
 			name = match_strdup(&args[0]);
 			if (!name)
@@ -1389,6 +1407,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	/* Not pass down write hints if the number of active logs is lesser
+	 * than NR_CURSEG_PERSIST_TYPE.
+	 */
+	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
+		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -2060,6 +2084,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER)
+		seq_printf(seq, ",whint_mode=%s", "user-based");
+	else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS)
+		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
 	fscrypt_show_test_dummy_encryption(seq, ',', sbi->sb);
 
@@ -2129,6 +2157,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
 
 	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main) <=
 							SMALL_VOLUME_SEGMENTS)
 		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
@@ -2443,7 +2472,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (*flags & SB_RDONLY ||
+	    F2FS_OPTION(sbi).whint_mode != org_mount_opt.whint_mode) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
