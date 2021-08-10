Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17F3E3B7B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHHQ0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHHQZi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43AA610A4;
        Sun,  8 Aug 2021 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439919;
        bh=GVWc9h9qXo3w6BuAifpFN5wphrKQHojXUzLj6VQLC7o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kkuf+n+awf758izx7pj105V2BfDs9zGD8qkRchL7e0TnqKjYoj46PxdNSNztJNd8u
         15nd+jHLdLfJwFNHHQmc03tUc7kepFgi9VDCzuEEQSoUeLE6xWTRLWyw2P4l8ceLzU
         9JaIOEiuf5kNnTIjqmmf1ry6/WGK8iWvh14YNJY0niYzmVxuCjsnYpUdp/svHZGl8G
         2knMpBO4O9s4ROCZmBEZm19rh64Y2YanXH2QlmwONdvAocMhWYhyxRe9B7kbUCHhHz
         NUk79n2rj8QVITDP2L4DN5rY8ZDGaw2aWPR1xbWLnVdkXJIIEIfCuRsSmSMsUe0/pP
         CYPq7YsVWz1ZA==
Received: by pali.im (Postfix)
        id 947131430; Sun,  8 Aug 2021 18:25:18 +0200 (CEST)
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
Subject: [RFC PATCH 12/20] hfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Sun,  8 Aug 2021 18:24:45 +0200
Message-Id: <20210808162453.1653-13-pali@kernel.org>
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
functions utf8_to_utf32() and utf32_to_utf8() which implements correct
encoding and decoding between Unicode code points and UTF-8 sequence.

When iochatset=utf8 is used then set hsb->nls_io to NULL and use it for
distinguish between the fact if NLS table or native UTF-8 functions should
be used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/hfs/super.c | 33 ++++++++++++++++++++++-----------
 fs/hfs/trans.c | 24 ++++++++++++++++++++----
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 86bc46746c7f..076308df41cf 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -149,10 +149,13 @@ static int hfs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",part=%u", sbi->part);
 	if (sbi->session >= 0)
 		seq_printf(seq, ",session=%u", sbi->session);
-	if (sbi->nls_disk)
+	if (sbi->nls_disk) {
 		seq_printf(seq, ",codepage=%s", sbi->nls_disk->charset);
-	if (sbi->nls_io)
-		seq_printf(seq, ",iocharset=%s", sbi->nls_io->charset);
+		if (sbi->nls_io)
+			seq_printf(seq, ",iocharset=%s", sbi->nls_io->charset);
+		else
+			seq_puts(seq, ",iocharset=utf8");
+	}
 	if (sbi->s_quiet)
 		seq_printf(seq, ",quiet");
 	return 0;
@@ -225,6 +228,7 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int tmp, token;
+	int have_iocharset;
 
 	/* initialize the sb with defaults */
 	hsb->s_uid = current_uid();
@@ -239,6 +243,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 	if (!options)
 		return 1;
 
+	have_iocharset = 0;
+
 	while ((p = strsep(&options, ",")) != NULL) {
 		if (!*p)
 			continue;
@@ -332,18 +338,22 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 			kfree(p);
 			break;
 		case opt_iocharset:
-			if (hsb->nls_io) {
+			if (have_iocharset) {
 				pr_err("unable to change iocharset\n");
 				return 0;
 			}
 			p = match_strdup(&args[0]);
-			if (p)
-				hsb->nls_io = load_nls(p);
-			if (!hsb->nls_io) {
-				pr_err("unable to load iocharset \"%s\"\n", p);
-				kfree(p);
+			if (!p)
 				return 0;
+			if (strcmp(p, "utf8") != 0) {
+				hsb->nls_io = load_nls(p);
+				if (!hsb->nls_io) {
+					pr_err("unable to load iocharset \"%s\"\n", p);
+					kfree(p);
+					return 0;
+				}
 			}
+			have_iocharset = 1;
 			kfree(p);
 			break;
 		default:
@@ -351,7 +361,7 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 		}
 	}
 
-	if (hsb->nls_io && !hsb->nls_disk) {
+	if (have_iocharset && !hsb->nls_disk) {
 		/*
 		 * Previous version of hfs driver did something unexpected:
 		 * When codepage was not defined but iocharset was then
@@ -382,7 +392,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 			return 0;
 		}
 	}
-	if (hsb->nls_disk && !hsb->nls_io) {
+	if (hsb->nls_disk &&
+	    !have_iocharset && strcmp(CONFIG_NLS_DEFAULT, "utf8") != 0) {
 		hsb->nls_io = load_nls_default();
 		if (!hsb->nls_io) {
 			pr_err("unable to load default iocharset\n");
diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
index c75682c61b06..bff8e54003ab 100644
--- a/fs/hfs/trans.c
+++ b/fs/hfs/trans.c
@@ -44,7 +44,7 @@ int hfs_mac2asc(struct super_block *sb, char *out, const struct hfs_name *in)
 		srclen = HFS_NAMELEN;
 	dst = out;
 	dstlen = HFS_MAX_NAMELEN;
-	if (nls_io) {
+	if (nls_disk) {
 		wchar_t ch;
 
 		while (srclen > 0) {
@@ -57,7 +57,12 @@ int hfs_mac2asc(struct super_block *sb, char *out, const struct hfs_name *in)
 			srclen -= size;
 			if (ch == '/')
 				ch = ':';
-			size = nls_io->uni2char(ch, dst, dstlen);
+			if (nls_io)
+				size = nls_io->uni2char(ch, dst, dstlen);
+			else if (dstlen > 0)
+				size = utf32_to_utf8(ch, dst, dstlen);
+			else
+				size = -ENAMETOOLONG;
 			if (size < 0) {
 				if (size == -ENAMETOOLONG)
 					goto out;
@@ -101,11 +106,22 @@ void hfs_asc2mac(struct super_block *sb, struct hfs_name *out, const struct qstr
 	srclen = in->len;
 	dst = out->name;
 	dstlen = HFS_NAMELEN;
-	if (nls_io) {
+	if (nls_disk) {
 		wchar_t ch;
+		unicode_t u;
 
 		while (srclen > 0) {
-			size = nls_io->char2uni(src, srclen, &ch);
+			if (nls_io)
+				size = nls_io->char2uni(src, srclen, &ch);
+			else {
+				size = utf8_to_utf32(str, strlen, &u);
+				if (size >= 0) {
+					if (u <= MAX_WCHAR_T)
+						ch = u;
+					else
+						size = -EINVAL;
+				}
+			}
 			if (size < 0) {
 				ch = '?';
 				size = 1;
-- 
2.20.1

