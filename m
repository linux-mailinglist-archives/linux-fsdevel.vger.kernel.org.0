Return-Path: <linux-fsdevel+bounces-35305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8F9D38C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F681F24A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F519D884;
	Wed, 20 Nov 2024 10:52:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257E33C5;
	Wed, 20 Nov 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099954; cv=none; b=WLCe7pNXgpUeaYx9inBSQ+gdFUU1ZyDWxiBk2FKkfE9VVVmhU62HTnpZpklKicoUaC2W157UR6Dh2xfNS3dJl8e/FciWLhvSh+QjAn+SMImr6aFAH4+eS/6iZzn5aeaXEJvN8xRzAgouZQatPK7oPoPB2UCt/U1SR0UIzXqyQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099954; c=relaxed/simple;
	bh=BvrPqH/JjuDxvHT2iBBoF6DimfCqDzvK3hg6PwE5HHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TRSWix6sgQIKCG21FiSzyJlzmQwBnbsE5U4/wnmVkwgA6tTobsnMolNAWSvlrDTKyo6hdprBBgXAhoLvs5tTylHhKKMVh3BXRVx0FNGEh0iVxa2DmuDASLa0MiQVpAGjesRiFagqpNnhNymPsdFlbyMa6c6pIwiYiM589Uo7Gx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5673dbf66034-5504b;
	Wed, 20 Nov 2024 18:52:25 +0800 (CST)
X-RM-TRANSID:2ee5673dbf66034-5504b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9673dbf5635b-7f187;
	Wed, 20 Nov 2024 18:52:25 +0800 (CST)
X-RM-TRANSID:2ee9673dbf5635b-7f187
From: guanjing <guanjing@cmss.chinamobile.com>
To: krisman@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	brauner@kernel.org,
	tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] tmpfs: Unsigned expression compared with zero
Date: Wed, 20 Nov 2024 18:51:50 +0800
Message-Id: <20241120105150.24008-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to utf8_parse_version() is not
of the unsigned type.

However, the return value is being assigned to an unsigned int
variable 'version'. This will result in the inability to handle
errors that occur when parsing a UTF-8 version number from
a string.

Additionally, this patch can help eliminate the following
Coccicheck warning:

mm/shmem.c:4378:6-13: WARNING: Unsigned expression compared with zero: version < 0

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 fs/unicode/utf8-core.c  | 9 +++++----
 include/linux/unicode.h | 2 +-
 mm/shmem.c              | 5 +++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6fc9ab8667e6..c54dc7ac5ce6 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -219,9 +219,9 @@ EXPORT_SYMBOL(utf8_unload);
  *
  * @version: input string
  *
- * Returns the parsed version on success, negative code on error
+ * Returns 0 on success, negative code on error
  */
-int utf8_parse_version(char *version)
+int utf8_parse_version(char *version_str, unsigned int *version)
 {
 	substring_t args[3];
 	unsigned int maj, min, rev;
@@ -230,13 +230,14 @@ int utf8_parse_version(char *version)
 		{0, NULL}
 	};
 
-	if (match_token(version, token, args) != 1)
+	if (match_token(version_str, token, args) != 1)
 		return -EINVAL;
 
 	if (match_int(&args[0], &maj) || match_int(&args[1], &min) ||
 	    match_int(&args[2], &rev))
 		return -EINVAL;
 
-	return UNICODE_AGE(maj, min, rev);
+	*version = UNICODE_AGE(maj, min, rev);
+	return 0;
 }
 EXPORT_SYMBOL(utf8_parse_version);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 5e6b212a2aed..7de545bc66cb 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -78,6 +78,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
-int utf8_parse_version(char *version);
+int utf8_parse_version(char *version_str, unsigned int *version);
 
 #endif /* _LINUX_UNICODE_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index ccb9629a0f70..7d07f649a8df 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4368,14 +4368,15 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 	unsigned int version = UTF8_LATEST;
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
+	int ret;
 
 	if (!latest_version) {
 		if (strncmp(param->string, "utf8-", 5))
 			return invalfc(fc, "Only UTF-8 encodings are supported "
 				       "in the format: utf8-<version number>");
 
-		version = utf8_parse_version(version_str);
-		if (version < 0)
+		ret = utf8_parse_version(version_str, &version);
+		if (ret < 0)
 			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
 	}
 
-- 
2.33.0




