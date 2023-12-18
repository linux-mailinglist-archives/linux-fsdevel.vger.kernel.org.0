Return-Path: <linux-fsdevel+bounces-6401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D0817A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512C91F23554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4873465;
	Mon, 18 Dec 2023 18:57:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509281EB3F;
	Mon, 18 Dec 2023 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d66a0d10dcso888859b3a.0;
        Mon, 18 Dec 2023 10:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925857; x=1703530657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkfmWvzYpeF4rVnGX845jm7wZsJBKGi3ManaTXeaBIQ=;
        b=E3VvnlvcVZ39zd1VI81938lheR95fVOQu6QQ/GbIakmJjU7OAjsrYQMW13ZXxc0vaN
         IQaDwpR0OZC4nKD0dQ13pDuDMFkBgOIgfWIGxMhqRUyWWnLeTCcnU+NmQZ+sU3wnovkW
         VGqPBuTHmKlPGqfghgqgFTaqgdeOfNQ3vx5Sm4lMUYCjJEWbxtCvSF+2f+J9gIMn0HUs
         pjZIHXu08Va2/Qi7AUPny54yvqF3E/7y+ql3RgsVJ3EuaocsEHY/UiGlvb3csARH1n7Q
         kscMtiQNRvZFEgzXI/AbcRQQ5B7z8TdUC6l0QNozS+AAoW0V4s3+thdURR75HXvwBRWK
         kVPQ==
X-Gm-Message-State: AOJu0YziQKtBx6sFz9Bz3ZEOfYeGw9QfHjVHxqcSmOKtj+LD+OwYbXyB
	NoKptIVvw2lTwlDQ6HKJqVY=
X-Google-Smtp-Source: AGHT+IEsyC/PbuIEFoA4s4gpEUpGZUbbdjKhJaREFILE5vXo/bJOpHdJGIQQ+v6Qu0QJUhwjKQ374w==
X-Received: by 2002:a05:6a21:3398:b0:18f:d2a9:da50 with SMTP id yy24-20020a056a21339800b0018fd2a9da50mr9505725pzb.30.1702925856606;
        Mon, 18 Dec 2023 10:57:36 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:35 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v7 07/19] fs/f2fs: Restore the whint_mode mount option
Date: Mon, 18 Dec 2023 10:56:30 -0800
Message-ID: <20231218185705.2002516-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users to control which write hints are passed to the block layer:
- whint_mode=off - no write hints are passed to the block layer.
- whint_mode=user-based - write hints are derived from inode->i_write_hint
  and also from the system.advise xattr information (hot and cold bits).
- whint_mode=fs-based - F2FS chooses write hints.

This patch reverts commit 930e2607638d ("f2fs: remove obsolete whint_mode").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/filesystems/f2fs.rst | 70 ++++++++++++++++++++++
 fs/f2fs/data.c                     |  2 +
 fs/f2fs/f2fs.h                     |  9 +++
 fs/f2fs/segment.c                  | 95 ++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    | 32 +++++++++-
 5 files changed, 207 insertions(+), 1 deletion(-)

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
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e42b5f24deb..12ad311a22f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -478,6 +478,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
+		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
+						fio->type, fio->temp);
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e0c66a6b097..1bf1bce887d5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -141,6 +141,12 @@ struct f2fs_rwsem {
 #endif
 };
 
+enum whint_mode {
+	WHINT_MODE_OFF,		/* not pass down write hints */
+	WHINT_MODE_USER,	/* try to pass down hints given by users */
+	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
+};
+
 struct f2fs_mount_info {
 	unsigned int opt;
 	int write_io_size_bits;		/* Write IO size bits */
@@ -158,6 +164,7 @@ struct f2fs_mount_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	/* For which write hints are passed down to block layer */
+	enum whint_mode whint_mode;
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
@@ -3731,6 +3738,8 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 727d016318f9..e1a2eb1a1db9 100644
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
index 033af907c3b1..441f2a309d8a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -156,6 +156,7 @@ enum {
 	Opt_jqfmt_vfsold,
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
+	Opt_whint,
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
@@ -235,6 +236,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
+	{Opt_whint, "whint_mode=%s"},
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
@@ -1026,6 +1028,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
@@ -1437,6 +1455,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	/* Not pass down write hints if the number of active logs is less
+	 * than NR_CURSEG_PERSIST_TYPE.
+	 */
+	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
+		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -2108,6 +2132,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER)
+		seq_printf(seq, ",whint_mode=%s", "user-based");
+	else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS)
+		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
 	fscrypt_show_test_dummy_encryption(seq, ',', sbi->sb);
 
@@ -2177,6 +2205,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
 
 	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main) <=
 							SMALL_VOLUME_SEGMENTS)
 		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
@@ -2491,7 +2520,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (*flags & SB_RDONLY ||
+	    F2FS_OPTION(sbi).whint_mode != org_mount_opt.whint_mode) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);

