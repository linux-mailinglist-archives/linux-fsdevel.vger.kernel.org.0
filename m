Return-Path: <linux-fsdevel+bounces-2862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB57EB8CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8269B20B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930523309D;
	Tue, 14 Nov 2023 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BD33077;
	Tue, 14 Nov 2023 21:42:13 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D2C9;
	Tue, 14 Nov 2023 13:42:12 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cc3bb4c307so48185335ad.0;
        Tue, 14 Nov 2023 13:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998132; x=1700602932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obxMjYwKm307V/bNS8jvei2i5X3is8OkdljuRYbD4KA=;
        b=v7JIVNyHyWehCkUv75hWskWOoCBqV9SDAqGgKXPLSFQ/E0jTCK0xO56APpsduzVLGS
         ii6PKZqmgN28yngj6Eb2RIPCRBJQ9PX1kWdkfm8GEngetcn8mUORA+4Jytvwek7+xAwn
         FIG90fOnuJG1ZyWV3KVyDWvC0jcjmf37/r6ssQTU7GenlRgfyl6750lR11IiUsEVlEjD
         5Cxy+wXe6Y8qtAfFaTKXvn0DhLmYicQUlOnaAxm5j1mKOI3RFM+gujudyl61EhXbQz+9
         rt05fMkr0ddTxLA0bl6pfAsrFGeTpKwn4t0z7I7GuqC6jex86WqDN+q72jcZRnx5Yga5
         h+Lg==
X-Gm-Message-State: AOJu0YwH/TqE1QwBaaiJ4hpb+bw70zWDmw55ZWxru/8QNzuLJiythPJe
	UrxZhlhURJaSFWhv2lzo3zA=
X-Google-Smtp-Source: AGHT+IGVI8WNCnUR9UGfQSbjMzzLf//kRDX505QtCZqDcG2lYUPPO+FYcDrdYu8mqx6Gu78YbyHFuQ==
X-Received: by 2002:a17:902:ed8f:b0:1cc:373b:f0e6 with SMTP id e15-20020a170902ed8f00b001cc373bf0e6mr2786276plj.67.1699998131607;
        Tue, 14 Nov 2023 13:42:11 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:10 -0800 (PST)
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
	Avri Altman <avri.altman@wdc.com>,
	Bean Huo <beanhuo@micron.com>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 05/15] fs/f2fs: Restore data lifetime support
Date: Tue, 14 Nov 2023 13:41:00 -0800
Message-ID: <20231114214132.1486867-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114214132.1486867-1-bvanassche@acm.org>
References: <20231114214132.1486867-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore support for the whint_mode mount option that was removed by commit
930e2607638d ("f2fs: remove obsolete whint_mode"). Additionally, restore
the bio->bi_lifetime assignment in __bio_alloc() that was removed by
commit c75e707fe1aa ("block: remove the per-bio/request write hint").
Use the new names for data lifetimes (WRITE_LIFE_<n>).

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bean Huo <beanhuo@micron.com>
Cc: Daejun Park <daejun7.park@samsung.com>
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
index d32c6209685d..11fde8bcb3b6 100644
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
+1) whint_mode=off. F2FS only passes down WRITE_LIFE_0.
+
+2) whint_mode=user-based. F2FS tries to pass down hints given by
+users.
+
+===================== ======================== ===================
+User                  F2FS                     Block
+===================== ======================== ===================
+N/A                   META                     WRITE_LIFE_0
+N/A                   HOT_NODE                 "
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                "
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_5
+extension list        "                        "
+
+-- buffered io
+WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+WRITE_LIFE_1          "                        "
+WRITE_LIFE_3          "                        "
+WRITE_LIFE_4          "                        "
+
+-- direct io
+WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+WRITE_LIFE_1          "                        WRITE_LIFE_1
+WRITE_LIFE_3          "                        WRITE_LIFE_3
+WRITE_LIFE_4          "                        WRITE_LIFE_4
+===================== ======================== ===================
+
+3) whint_mode=fs-based. F2FS passes down hints with its policy.
+
+===================== ======================== ===================
+User                  F2FS                     Block
+===================== ======================== ===================
+N/A                   META                     WRITE_LIFE_3;
+N/A                   HOT_NODE                 WRITE_LIFE_0
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                WRITE_LIFE_1
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_5
+extension list        "                        "
+
+-- buffered io
+WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_4
+WRITE_LIFE_1          "                        "
+WRITE_LIFE_3          "                        "
+WRITE_LIFE_4          "                        "
+
+-- direct io
+WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+WRITE_LIFE_1          "                        WRITE_LIFE_1
+WRITE_LIFE_3          "                        WRITE_LIFE_3
+WRITE_LIFE_4          "                        WRITE_LIFE_4
+===================== ======================== ===================
+
 Fallocate(2) Policy
 -------------------
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e42b5f24deb..b92fcfd6ab42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -478,6 +478,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
+		bio->bi_lifetime = f2fs_io_type_to_rw_hint(sbi, fio->type,
+							   fio->temp);
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e0c66a6b097..adbc42e20201 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -158,6 +158,7 @@ struct f2fs_mount_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	/* For which write hints are passed down to block layer */
+	int whint_mode;
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
@@ -1345,6 +1346,12 @@ enum {
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
index 098a574d8d84..e5a983e6de46 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3290,6 +3290,101 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
 	}
 }
 
+/* This returns write hints for each segment type. This hints will be
+ * passed down to block layer. There are mapping tables which depend on
+ * the mount option 'whint_mode'.
+ *
+ * 1) whint_mode=off. F2FS only passes down WRITE_LIFE_0.
+ *
+ * 2) whint_mode=user-based. F2FS tries to pass down hints given by users.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_0
+ *                       HOT_NODE                 "
+ *                       WARM_NODE                "
+ *                       COLD_NODE                "
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_5
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+ * WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+ * WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+ * WRITE_LIFE_1          "                        "
+ * WRITE_LIFE_3          "                        "
+ * WRITE_LIFE_4          "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+ * WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+ * WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+ * WRITE_LIFE_1          "                        WRITE_LIFE_1
+ * WRITE_LIFE_3          "                        WRITE_LIFE_3
+ * WRITE_LIFE_4          "                        WRITE_LIFE_4
+ *
+ * 3) whint_mode=fs-based. F2FS passes down hints with its policy.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_3;
+ *                       HOT_NODE                 WRITE_LIFE_0
+ *                       WARM_NODE                "
+ *                       COLD_NODE                WRITE_LIFE_1
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_5
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+ * WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+ * WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_4
+ * WRITE_LIFE_1          "                        "
+ * WRITE_LIFE_3          "                        "
+ * WRITE_LIFE_4          "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_5          COLD_DATA                WRITE_LIFE_5
+ * WRITE_LIFE_2          HOT_DATA                 WRITE_LIFE_2
+ * WRITE_LIFE_0          WARM_DATA                WRITE_LIFE_0
+ * WRITE_LIFE_1          "                        WRITE_LIFE_1
+ * WRITE_LIFE_3          "                        WRITE_LIFE_3
+ * WRITE_LIFE_4          "                        WRITE_LIFE_4
+ */
+
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+				enum page_type type, enum temp_type temp)
+{
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER) {
+		if (type == DATA) {
+			if (temp == WARM)
+				return WRITE_LIFE_0;
+			else if (temp == HOT)
+				return WRITE_LIFE_2;
+			else if (temp == COLD)
+				return WRITE_LIFE_5;
+		} else {
+			return WRITE_LIFE_0;
+		}
+	} else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS) {
+		if (type == DATA) {
+			if (temp == WARM)
+				return WRITE_LIFE_4;
+			else if (temp == HOT)
+				return WRITE_LIFE_2;
+			else if (temp == COLD)
+				return WRITE_LIFE_5;
+		} else if (type == NODE) {
+			if (temp == WARM || temp == HOT)
+				return WRITE_LIFE_0;
+			else if (temp == COLD)
+				return WRITE_LIFE_1;
+		} else if (type == META) {
+			return WRITE_LIFE_3;
+		}
+	}
+	return WRITE_LIFE_0;
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..91f46926f139 100644
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
 
+	/* Not pass down write hints if the number of active logs is lesser
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

