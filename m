Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FC3E3B6C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHHQZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232036AbhHHQZj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04B2E61057;
        Sun,  8 Aug 2021 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439920;
        bh=yqPsetOw4W6bNgWR24S/rgdafRjACRvNO9i2APLG5Ro=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BtwW5Zl6wIxOKHFKlHcsPRe+j0YTnRSwYl6E6kuEnVHwY4CBX48L8O0rugI7wyCYC
         UnlD/kWdvO4XtPIXqTb9wFag7zVQd+J2uBqrUWWzyXYo7l34TOngROP6s7SQhK15CC
         ky5BgKIX53TpuEKZmKIFlZ9O8/DntW5KQ//t2T6jHyh2ljsaRO9T+KnRJbQ8f0R3TE
         UHq3mHTu4YXURWwRjPI43ewlLrf73Cra+K38i6EMoOMJsyUr8tat/P1CqLlFLgi3Go
         XZf3P9HXbdpA910MyUK3rx5xNerwfViTPsPc+th1TeeFWtsn74GqakoahK2cdtspTH
         7JxuJHSVoY2YA==
Received: by pali.im (Postfix)
        id B983D1430; Sun,  8 Aug 2021 18:25:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 14/20] jfs: Remove custom iso8859-1 implementation
Date:   Sun,  8 Aug 2021 18:24:47 +0200
Message-Id: <20210808162453.1653-15-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When iocharset= mount option is not specified or when is set to
iocharset=none then jfs driver uses its own custom iso8895-1 encoding
implementation.

NLS already provides iso8895-1 module, so use it instead of custom jfs
iso8859-1 implementation.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/jfs/jfs_unicode.c | 14 +-------------
 fs/jfs/super.c       | 29 +++++++++++++++++++----------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
index 0c1e9027245a..1d0f65d13b58 100644
--- a/fs/jfs/jfs_unicode.c
+++ b/fs/jfs/jfs_unicode.c
@@ -33,13 +33,8 @@ int jfs_strfromUCS_le(char *to, const __le16 * from,
 					       NLS_MAX_CHARSET_SIZE);
 			if (charlen > 0)
 				outlen += charlen;
-			else
+			else {
 				to[outlen++] = '?';
-		}
-	} else {
-		for (i = 0; (i < len) && from[i]; i++) {
-			if (unlikely(le16_to_cpu(from[i]) & 0xff00)) {
-				to[i] = '?';
 				if (unlikely(warn)) {
 					warn--;
 					warn_again--;
@@ -49,12 +44,8 @@ int jfs_strfromUCS_le(char *to, const __le16 * from,
 					printk(KERN_ERR
 				"mount with iocharset=utf8 to access\n");
 				}
-
 			}
-			else
-				to[i] = (char) (le16_to_cpu(from[i]));
 		}
-		outlen = i;
 	}
 	to[outlen] = 0;
 	return outlen;
@@ -84,9 +75,6 @@ static int jfs_strtoUCS(wchar_t * to, const unsigned char *from, int len,
 				return charlen;
 			}
 		}
-	} else {
-		for (i = 0; (i < len) && from[i]; i++)
-			to[i] = (wchar_t) from[i];
 	}
 
 	to[i] = 0;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9030aeaf0f88..8ba2ac032292 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -231,7 +231,7 @@ static const match_table_t tokens = {
 };
 
 static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
-			 int *flag)
+			 int *flag, int remount)
 {
 	void *nls_map = (void *)-1;	/* -1: no change;  NULL: none */
 	char *p;
@@ -263,14 +263,14 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 		case Opt_iocharset:
 			if (nls_map && nls_map != (void *) -1)
 				unload_nls(nls_map);
-			if (!strcmp(args[0].from, "none"))
-				nls_map = NULL;
-			else {
+			/* compatibility alias none means ISO-8859-1 */
+			if (strcmp(args[0].from, "none") == 0)
+				nls_map = load_nls("iso8859-1");
+			else
 				nls_map = load_nls(args[0].from);
-				if (!nls_map) {
-					pr_err("JFS: charset not found\n");
-					goto cleanup;
-				}
+			if (!nls_map) {
+				pr_err("JFS: charset not found\n");
+				goto cleanup;
 			}
 			break;
 		case Opt_resize:
@@ -414,6 +414,15 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 		}
 	}
 
+	if (!remount && nls_map == (void *) -1) {
+		/* Previously default NLS table was ISO-8859-1 */
+		nls_map = load_nls("iso8859-1");
+		if (!nls_map) {
+			pr_err("JFS: iso8859-1 charset not found\n");
+			goto cleanup;
+		}
+	}
+
 	if (nls_map != (void *) -1) {
 		/* Discard old (if remount) */
 		unload_nls(sbi->nls_tab);
@@ -435,7 +444,7 @@ static int jfs_remount(struct super_block *sb, int *flags, char *data)
 	int ret;
 
 	sync_filesystem(sb);
-	if (!parse_options(data, sb, &newLVSize, &flag))
+	if (!parse_options(data, sb, &newLVSize, &flag, 1))
 		return -EINVAL;
 
 	if (newLVSize) {
@@ -513,7 +522,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;
 
-	if (!parse_options((char *) data, sb, &newLVSize, &flag))
+	if (!parse_options((char *) data, sb, &newLVSize, &flag, 0))
 		goto out_kfree;
 	sbi->flag = flag;
 
-- 
2.20.1

