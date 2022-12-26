Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8249565633A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiLZOWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiLZOWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBD2608;
        Mon, 26 Dec 2022 06:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB22A60EB5;
        Mon, 26 Dec 2022 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3473C433D2;
        Mon, 26 Dec 2022 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064532;
        bh=Xsp3m3OsW4jVnQPkMQLxfCHZ/XiAut6pdb2ruAApCB4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Up4OAqH55iaCAJw883S9943eBNly3aIMlynhdSIFfKbVseamKeJfQH0MxLPkAHuPa
         0RO+8XOWxMOAchvnruly8oZKaVEQHv93la8lc8DwyAqnDlp/+ol3zsBzwGycA5kTs3
         PiipsjZFO53qGXeQAlkyrZ2Iet0frsmuqAA9GT26/1kj2XkqsT9ysgskuXT64p/YCW
         NdTkq630GuiyNhUfa+c2ohwTj+LBm3CEJKAf/qfyCBgrckS9wp2z+abpEpNKo+7RC4
         qzXqOV8xr4EQF3Y0KwHx44xvTMy2W5MYRu++4b1Ux+ux6ypyB58J8MsaHiompDhxdR
         lLWkEteZYAALA==
Received: by pali.im (Postfix)
        id 8C8A49D7; Mon, 26 Dec 2022 15:22:11 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 10/18] hfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:42 +0100
Message-Id: <20221226142150.13324-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index cea19ed06bce..5a63df41da05 100644
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
+	bool have_iocharset;
 
 	/* initialize the sb with defaults */
 	hsb->s_uid = current_uid();
@@ -239,6 +243,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 	if (!options)
 		return 1;
 
+	have_iocharset = false;
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
+			have_iocharset = true;
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
index dbf535d52d37..01f37b395f10 100644
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
 
 		while (srclen > 0 && dstlen > 0) {
-			size = nls_io->char2uni(src, srclen, &ch);
+			if (nls_io)
+				size = nls_io->char2uni(src, srclen, &ch);
+			else {
+				size = utf8_to_utf32(src, srclen, &u);
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

