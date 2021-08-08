Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060F3E3B69
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhHHQZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQZk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41CA61158;
        Sun,  8 Aug 2021 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439921;
        bh=egOVkUn690xt7FZbOqT8MsamXeKICn7MJFEojXwgYng=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VfOqSRuFvLe4mUUL47GjIPLuSciYWeBfWxTj8QxGd/gywNzUF/V/VSDO1OyBQr2KI
         pb+/lcc+l8h1rOWyRpZkTobnDfwXGl/H7pUks8skBwnjgJ8dMZQLIP9YOvb3BKH3Wy
         V1R+kOj4CCwoCPPwLaaCpJxU4fOXP4FYxCVXWqkaOHv0JNJsuzxurHCQKqPhY0n1z1
         4vZJUKQ9G5I1Ky5nA1PqgI7ZFqOMpZdsfyxxz0S30hvQAWk9476TrXbiEKOAo6kLM3
         SIF8Py6NINVOJfprskSbi/cpeMQk6ukYVbWgPcDIPnVFRXEz7veuskQX6vEW+BSd/N
         2QRocWokUB1bQ==
Received: by pali.im (Postfix)
        id B20291430; Sun,  8 Aug 2021 18:25:20 +0200 (CEST)
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
Subject: [RFC PATCH 16/20] jfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Sun,  8 Aug 2021 18:24:49 +0200
Message-Id: <20210808162453.1653-17-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS table for utf8 is broken and cannot be fixed.

So instead of broken utf8 nls functions char2uni() and uni2char() use
functions utf8s_to_utf16s() and utf16s_to_utf8s() which implements correct
conversion between UTF-16 and UTF-8.

These functions implements also correct processing of UTF-16 surrogate
pairs and therefore after this change jfs driver would be able to correctly
handle also file names with 4-byte UTF-8 sequences.

When iochatset=utf8 is used then set sbi->nls_tab to NULL and use it for
distinguish between the fact if NLS table or native UTF-8 functions should
be used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/jfs/jfs_unicode.c | 17 +++++++++++++++--
 fs/jfs/super.c       | 24 +++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
index 2db923872bf1..4c39b6b65bca 100644
--- a/fs/jfs/jfs_unicode.c
+++ b/fs/jfs/jfs_unicode.c
@@ -46,6 +46,9 @@ int jfs_strfromUCS_le(char *to, int maxlen, const __le16 * from,
 				}
 			}
 		}
+	} else {
+		outlen = utf16s_to_utf8s(from, len,
+					 UTF16_LITTLE_ENDIAN, to, maxlen-1);
 	}
 	to[outlen] = 0;
 	return outlen;
@@ -61,6 +64,7 @@ static int jfs_strtoUCS(wchar_t * to, const unsigned char *from, int len,
 		struct nls_table *codepage)
 {
 	int charlen;
+	int outlen;
 	int i;
 
 	if (codepage) {
@@ -75,10 +79,19 @@ static int jfs_strtoUCS(wchar_t * to, const unsigned char *from, int len,
 				return charlen;
 			}
 		}
+		outlen = i;
+	} else {
+		outlen = utf8s_to_utf16s(from, len, UTF16_LITTLE_ENDIAN,
+					 to, len);
+		if (outlen < 1) {
+			jfs_err("jfs_strtoUCS: utf8s_to_utf16s returned %d.",
+				outlen);
+			return outlen;
+		}
 	}
 
-	to[i] = 0;
-	return i;
+	to[outlen] = 0;
+	return outlen;
 }
 
 /*
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8ba2ac032292..f449fdd56654 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -261,16 +261,20 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 			/* Don't do anything ;-) */
 			break;
 		case Opt_iocharset:
-			if (nls_map && nls_map != (void *) -1)
+			if (nls_map && nls_map != (void *) -1) {
 				unload_nls(nls_map);
-			/* compatibility alias none means ISO-8859-1 */
-			if (strcmp(args[0].from, "none") == 0)
-				nls_map = load_nls("iso8859-1");
-			else
-				nls_map = load_nls(args[0].from);
-			if (!nls_map) {
-				pr_err("JFS: charset not found\n");
-				goto cleanup;
+				nls_map = NULL;
+			}
+			if (strcmp(args[0].from, "utf8") != 0) {
+				/* compatibility alias none means ISO-8859-1 */
+				if (strcmp(args[0].from, "none") == 0)
+					nls_map = load_nls("iso8859-1");
+				else
+					nls_map = load_nls(args[0].from);
+				if (!nls_map) {
+					pr_err("JFS: charset not found\n");
+					goto cleanup;
+				}
 			}
 			break;
 		case Opt_resize:
@@ -718,6 +722,8 @@ static int jfs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",discard=%u", sbi->minblks_trim);
 	if (sbi->nls_tab)
 		seq_printf(seq, ",iocharset=%s", sbi->nls_tab->charset);
+	else
+		seq_puts(seq, ",iocharset=utf8");
 	if (sbi->flag & JFS_ERR_CONTINUE)
 		seq_printf(seq, ",errors=continue");
 	if (sbi->flag & JFS_ERR_PANIC)
-- 
2.20.1

