Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC5656352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiLZOXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLZOWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38E63DE;
        Mon, 26 Dec 2022 06:22:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB7760ECC;
        Mon, 26 Dec 2022 14:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A37C433D2;
        Mon, 26 Dec 2022 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064536;
        bh=UK6BsAqbMHD2yEk56WVb4gYlz7RwyfUXM7sbl2vvPCA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=efntnbsbXMUd/3GVdPWgMJrVdE4PvcR0ghBC55RqUJ4rPHQlXrJMXeykHqg94BVpB
         hu2ZGUq8HkJSJnELi0aFA0lGyrMRBKpN+N3VjxBZq6OEW1vrHiVQun4Hhm2c6algSG
         8fh6m1xxtDXfE38s3iwstylP1uwUkLdJEtfKPZY6XcEKjnJzCtr0SN+BPTpyiHwI5J
         44uZ8tYtcuRDPT0WXsPT34PpSRjG+5roeG9qcYMnjMFfLmyk5HE1RHWxi+P+iRGlGx
         W+wkKS7UAwKqhk8UvHsm5Ltkew/N9vQ6WAzRtLJod71xGKcxsd5OJ286VWej6f4UQV
         ZJmdCwwMPQHPQ==
Received: by pali.im (Postfix)
        id F1EC09D7; Mon, 26 Dec 2022 15:22:15 +0100 (CET)
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
Subject: [RFC PATCH v2 14/18] jfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:46 +0100
Message-Id: <20221226142150.13324-15-pali@kernel.org>
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
index 2db923872bf1..0b0b80063a98 100644
--- a/fs/jfs/jfs_unicode.c
+++ b/fs/jfs/jfs_unicode.c
@@ -46,6 +46,9 @@ int jfs_strfromUCS_le(char *to, int maxlen, const __le16 * from,
 				}
 			}
 		}
+	} else {
+		outlen = utf16s_to_utf8s((const wchar_t *)from, len,
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
index a2bb3d5d3f69..f26460147b62 100644
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
@@ -713,6 +717,8 @@ static int jfs_show_options(struct seq_file *seq, struct dentry *root)
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

