Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1165633E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLZOWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiLZOWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC06178;
        Mon, 26 Dec 2022 06:22:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD0560EBB;
        Mon, 26 Dec 2022 14:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E69C433D2;
        Mon, 26 Dec 2022 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064534;
        bh=MTbJQXmNYIn3aIarKGddxE1E8WlMgp5B50dVxH4DJ4Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nAKwOBNQge72LJf3BR6bK0gFclV7iB2LTO/ZPBjQ6PXtoHYu8uiBLepZmf33P9IOj
         4LntY2IUWK6Q7NqH0RyXZI42XK5PqaaOsRnbg9Y0LPZlF222iMalDK3PsW4xLDl//j
         7sS4MCexxoHY65fiXFNmzotdf1+VOIxwMVqUZkPQejJ7eh5QTq7yTWnFUA8Tg8iELD
         mhFR5xRn9KgjQup7u8tT6jm1yAJStxUKJDw14cMRemu+pPVg2/WgXaWLEFiZ1rLzHE
         3Jy4UtensntSs+1cPmpSVS3b0wtZ3f0o5aT8X/m4GnFcHQym06PJ/5C0QLmoU1RYOW
         5hKB5J97xCu9g==
Received: by pali.im (Postfix)
        id D1E989D7; Mon, 26 Dec 2022 15:22:13 +0100 (CET)
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
Subject: [RFC PATCH v2 12/18] jfs: Remove custom iso8859-1 implementation
Date:   Mon, 26 Dec 2022 15:21:44 +0100
Message-Id: <20221226142150.13324-13-pali@kernel.org>
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
index d2f82cb7db1b..a2bb3d5d3f69 100644
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
@@ -409,6 +409,15 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
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
@@ -430,7 +439,7 @@ static int jfs_remount(struct super_block *sb, int *flags, char *data)
 	int ret;
 
 	sync_filesystem(sb);
-	if (!parse_options(data, sb, &newLVSize, &flag))
+	if (!parse_options(data, sb, &newLVSize, &flag, 1))
 		return -EINVAL;
 
 	if (newLVSize) {
@@ -508,7 +517,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;
 
-	if (!parse_options((char *) data, sb, &newLVSize, &flag))
+	if (!parse_options((char *) data, sb, &newLVSize, &flag, 0))
 		goto out_kfree;
 	sbi->flag = flag;
 
-- 
2.20.1

