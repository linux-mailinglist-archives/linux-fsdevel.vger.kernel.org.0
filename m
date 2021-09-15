Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050240C00A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhIOHF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhIOHF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D20C061574;
        Wed, 15 Sep 2021 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=knC9nff2RSLhnE3ogamdo97AP2z8DK/rEcwpcKccbLE=; b=fBZPvjnr/jw1u0hJsKQVjah39p
        rVbIUZQdU+iwUldG6gkGJRna8RNNlzPj7hv2t3mNJtqwHOIODNg4JwC+fILudLBvAhT2qyI6mxeWZ
        L+2+SqZNBMKcotlNZ0A+LSriAqUB7fRck9aJFFI4h6jxI3IoUC30m33G9lZxIuRB5VoI2vZjgDPfl
        9oGZN7zsmi32UBbgi2dltK7pJZAYLa8+2nESzp/gD6RfQnlyl0ugpLMBirFGln0WcPqDwzWftObRn
        yeIZnYNWJp8R3CKt6NP8tIPC2nxGhYA3fIVKKgDVruWqcWUJJamhDysJ8LqASJgTgMt9gO/iRqzkm
        jpso9eMA==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOxT-00FRbo-GS; Wed, 15 Sep 2021 07:04:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple to utf8_load
Date:   Wed, 15 Sep 2021 09:00:00 +0200
Message-Id: <20210915070006.954653-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't bother with pointless string parsing when the caller can just pass
the version in the format that the core expects.  Also remove the
fallback to the latest version that none of the callers actually uses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c            | 18 +++++++++-----
 fs/f2fs/super.c            | 18 +++++++++-----
 fs/unicode/utf8-core.c     | 50 ++++----------------------------------
 fs/unicode/utf8-norm.c     | 11 ++-------
 fs/unicode/utf8-selftest.c | 15 ++++++------
 fs/unicode/utf8n.h         | 14 ++---------
 include/linux/unicode.h    | 25 ++++++++++++++++++-
 7 files changed, 65 insertions(+), 86 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7401a181878e5..da4e307d7599f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2012,9 +2012,9 @@ static const struct mount_opts {
 static const struct ext4_sb_encodings {
 	__u16 magic;
 	char *name;
-	char *version;
+	unsigned int version;
 } ext4_sb_encoding_map[] = {
-	{EXT4_ENC_UTF8_12_1, "utf8", "12.1.0"},
+	{EXT4_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
 };
 
 static const struct ext4_sb_encodings *
@@ -4160,15 +4160,21 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		encoding = utf8_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			ext4_msg(sb, KERN_ERR,
-				 "can't mount with superblock charset: %s-%s "
+				 "can't mount with superblock charset: %s-%u.%u.%u "
 				 "not supported by the kernel. flags: 0x%x.",
-				 encoding_info->name, encoding_info->version,
+				 encoding_info->name,
+				 unicode_major(encoding_info->version),
+				 unicode_minor(encoding_info->version),
+				 unicode_rev(encoding_info->version),
 				 encoding_flags);
 			goto failed_mount;
 		}
 		ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
-			 "%s-%s with flags 0x%hx", encoding_info->name,
-			 encoding_info->version?:"\b", encoding_flags);
+			 "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
+			 unicode_major(encoding_info->version),
+			 unicode_minor(encoding_info->version),
+			 unicode_rev(encoding_info->version),
+			 encoding_flags);
 
 		sb->s_encoding = encoding;
 		sb->s_encoding_flags = encoding_flags;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c457100f18ea..3029f71bf2b74 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -259,9 +259,9 @@ void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...)
 static const struct f2fs_sb_encodings {
 	__u16 magic;
 	char *name;
-	char *version;
+	unsigned int version;
 } f2fs_sb_encoding_map[] = {
-	{F2FS_ENC_UTF8_12_1, "utf8", "12.1.0"},
+	{F2FS_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
 };
 
 static const struct f2fs_sb_encodings *
@@ -3847,15 +3847,21 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		encoding = utf8_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			f2fs_err(sbi,
-				 "can't mount with superblock charset: %s-%s "
+				 "can't mount with superblock charset: %s-%u.%u.%u "
 				 "not supported by the kernel. flags: 0x%x.",
-				 encoding_info->name, encoding_info->version,
+				 encoding_info->name,
+				 unicode_major(encoding_info->version),
+				 unicode_minor(encoding_info->version),
+				 unicode_rev(encoding_info->version),
 				 encoding_flags);
 			return PTR_ERR(encoding);
 		}
 		f2fs_info(sbi, "Using encoding defined by superblock: "
-			 "%s-%s with flags 0x%hx", encoding_info->name,
-			 encoding_info->version?:"\b", encoding_flags);
+			 "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
+			 unicode_major(encoding_info->version),
+			 unicode_minor(encoding_info->version),
+			 unicode_rev(encoding_info->version),
+			 encoding_flags);
 
 		sbi->sb->s_encoding = encoding;
 		sbi->sb->s_encoding_flags = encoding_flags;
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 86f42a078d99b..dca2865c3bee8 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -167,59 +167,19 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_normalize);
 
-static int utf8_parse_version(const char *version, unsigned int *maj,
-			      unsigned int *min, unsigned int *rev)
+struct unicode_map *utf8_load(unsigned int version)
 {
-	substring_t args[3];
-	char version_string[12];
-	static const struct match_token token[] = {
-		{1, "%d.%d.%d"},
-		{0, NULL}
-	};
-
-	strncpy(version_string, version, sizeof(version_string));
-
-	if (match_token(version_string, token, args) != 1)
-		return -EINVAL;
-
-	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
-	    match_int(&args[2], rev))
-		return -EINVAL;
+	struct unicode_map *um;
 
-	return 0;
-}
-
-struct unicode_map *utf8_load(const char *version)
-{
-	struct unicode_map *um = NULL;
-	int unicode_version;
-
-	if (version) {
-		unsigned int maj, min, rev;
-
-		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
-			return ERR_PTR(-EINVAL);
-
-		if (!utf8version_is_supported(maj, min, rev))
-			return ERR_PTR(-EINVAL);
-
-		unicode_version = UNICODE_AGE(maj, min, rev);
-	} else {
-		unicode_version = utf8version_latest();
-		printk(KERN_WARNING"UTF-8 version not specified. "
-		       "Assuming latest supported version (%d.%d.%d).",
-		       (unicode_version >> 16) & 0xff,
-		       (unicode_version >> 8) & 0xff,
-		       (unicode_version & 0xff));
-	}
+	if (!utf8version_is_supported(version))
+		return ERR_PTR(-EINVAL);
 
 	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
 	if (!um)
 		return ERR_PTR(-ENOMEM);
-	um->version = unicode_version;
+	um->version = version;
 	return um;
 }
 EXPORT_SYMBOL(utf8_load);
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 1d2d2e5b906ae..12abf89ae6eca 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -15,13 +15,12 @@ struct utf8data {
 #include "utf8data.h"
 #undef __INCLUDED_FROM_UTF8NORM_C__
 
-int utf8version_is_supported(u8 maj, u8 min, u8 rev)
+int utf8version_is_supported(unsigned int version)
 {
 	int i = ARRAY_SIZE(utf8agetab) - 1;
-	unsigned int sb_utf8version = UNICODE_AGE(maj, min, rev);
 
 	while (i >= 0 && utf8agetab[i] != 0) {
-		if (sb_utf8version == utf8agetab[i])
+		if (version == utf8agetab[i])
 			return 1;
 		i--;
 	}
@@ -29,12 +28,6 @@ int utf8version_is_supported(u8 maj, u8 min, u8 rev)
 }
 EXPORT_SYMBOL(utf8version_is_supported);
 
-int utf8version_latest(void)
-{
-	return utf8vers;
-}
-EXPORT_SYMBOL(utf8version_latest);
-
 /*
  * UTF-8 valid ranges.
  *
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 6fe8af7edccbb..37f33890e012f 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -235,7 +235,7 @@ static void check_utf8_nfdicf(void)
 static void check_utf8_comparisons(void)
 {
 	int i;
-	struct unicode_map *table = utf8_load("12.1.0");
+	struct unicode_map *table = utf8_load(UNICODE_AGE(12, 1, 0));
 
 	if (IS_ERR(table)) {
 		pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
@@ -269,18 +269,19 @@ static void check_utf8_comparisons(void)
 static void check_supported_versions(void)
 {
 	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(7, 0, 0));
+	test(utf8version_is_supported(UNICODE_AGE(7, 0, 0)));
 
 	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(9, 0, 0));
+	test(utf8version_is_supported(UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(latest_maj, latest_min, latest_rev));
+	test(utf8version_is_supported(
+		UNICODE_AGE(latest_maj, latest_min, latest_rev)));
 
 	/* Next versions don't exist. */
-	test(!utf8version_is_supported(13, 0, 0));
-	test(!utf8version_is_supported(0, 0, 0));
-	test(!utf8version_is_supported(-1, -1, -1));
+	test(!utf8version_is_supported(UNICODE_AGE(13, 0, 0)));
+	test(!utf8version_is_supported(UNICODE_AGE(0, 0, 0)));
+	test(!utf8version_is_supported(UNICODE_AGE(-1, -1, -1)));
 }
 
 static int __init init_test_ucd(void)
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 0acd530c2c791..85a7bebf69275 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -11,19 +11,9 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/unicode.h>
 
-/* Encoding a unicode version number as a single unsigned int. */
-#define UNICODE_MAJ_SHIFT		(16)
-#define UNICODE_MIN_SHIFT		(8)
-
-#define UNICODE_AGE(MAJ, MIN, REV)			\
-	(((unsigned int)(MAJ) << UNICODE_MAJ_SHIFT) |	\
-	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
-	 ((unsigned int)(REV)))
-
-/* Highest unicode version supported by the data tables. */
-extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
-extern int utf8version_latest(void);
+int utf8version_is_supported(unsigned int version);
 
 /*
  * Look for the correct const struct utf8data for a unicode version.
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 0744f81c4b5fc..77bb915fd1f05 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -5,6 +5,29 @@
 #include <linux/init.h>
 #include <linux/dcache.h>
 
+#define UNICODE_MAJ_SHIFT		16
+#define UNICODE_MIN_SHIFT		8
+
+#define UNICODE_AGE(MAJ, MIN, REV)			\
+	(((unsigned int)(MAJ) << UNICODE_MAJ_SHIFT) |	\
+	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
+	 ((unsigned int)(REV)))
+
+static inline u8 unicode_major(unsigned int age)
+{
+	return (age >> UNICODE_MAJ_SHIFT) & 0xff;
+}
+
+static inline u8 unicode_minor(unsigned int age)
+{
+	return (age >> UNICODE_MIN_SHIFT) & 0xff;
+}
+
+static inline u8 unicode_rev(unsigned int age)
+{
+	return age & 0xff;
+}
+
 struct unicode_map {
 	unsigned int version;
 };
@@ -29,7 +52,7 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 		       struct qstr *str);
 
-struct unicode_map *utf8_load(const char *version);
+struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
 #endif /* _LINUX_UNICODE_H */
-- 
2.30.2

