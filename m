Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1963865633F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiLZOW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiLZOWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3AF63BF;
        Mon, 26 Dec 2022 06:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BC760EB5;
        Mon, 26 Dec 2022 14:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDD4C433F2;
        Mon, 26 Dec 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064535;
        bh=KTlaKtoc30smqwDFYdlWnFXEn9JLsGy9kBhgPLFkugI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k1C6pep7mjb2vxyhmR6RmjD5TxwJDJwot8DuSPJBJDV53ijpJR+rV1MBrf7h3cb6m
         me7Pg6aNRllW0ZdOkLjWFHwaqfLeK8FixgI8Lx9frkhm8Sz/qPflhrh1HrDSZR1KZ5
         Yj7LUS4AdmfbcvFn88aAEZmGxv+mlpNPtAa/cv4CKXt3VjW687mqwFX0Tuk/r5DrB6
         zY5bk1RoDqtWT5rYh/oIZr+vl4bHQO/fg9xySFujE/B5pvIbJrJi8m+ci3q1N818jj
         rIWMcCC2am4zCGZDtMhvUJWbhz6CE/2B9XB0p4kL3gxo7YjZXJf7Slpjd3mPm0exA1
         kGWP5cEi4dzEQ==
Received: by pali.im (Postfix)
        id E8E4C9D7; Mon, 26 Dec 2022 15:22:14 +0100 (CET)
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
Subject: [RFC PATCH v2 13/18] jfs: Fix buffer overflow in jfs_strfromUCS_le() function
Date:   Mon, 26 Dec 2022 15:21:45 +0100
Message-Id: <20221226142150.13324-14-pali@kernel.org>
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

Function jfs_strfromUCS_le() writes to unknown offset in buffer allocated
by __get_free_page(GFP_KERNEL). So it cannot expects that there is least
NLS_MAX_CHARSET_SIZE bytes space before end of that buffer.

Fix this issue by add a new parameter maxlen for jfs_strfromUCS_le()
function. And use it for passing remaining size of buffer to prevent buffer
overflow in kernel.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/jfs/jfs_dtree.c   | 13 ++++++++++---
 fs/jfs/jfs_unicode.c |  6 +++---
 fs/jfs/jfs_unicode.h |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..a09c9bc46351 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2715,6 +2715,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 	int d_namleft, len, outlen;
 	unsigned long dirent_buf;
 	char *name_ptr;
+	int maxlen;
 	u32 dir_index;
 	int do_index = 0;
 	uint loop_count = 0;
@@ -2937,7 +2938,10 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			}
 
 			/* copy the name of head/only segment */
-			outlen = jfs_strfromUCS_le(name_ptr, d->name, len,
+			maxlen = PAGE_SIZE - sizeof(struct jfs_dirent) -
+				 (name_ptr - jfs_dirent->name);
+			outlen = jfs_strfromUCS_le(name_ptr, maxlen,
+						   d->name, len,
 						   codepage);
 			jfs_dirent->name_len = outlen;
 
@@ -2957,8 +2961,11 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 					goto skip_one;
 				}
 				len = min(d_namleft, DTSLOTDATALEN);
-				outlen = jfs_strfromUCS_le(name_ptr, t->name,
-							   len, codepage);
+				maxlen = PAGE_SIZE - sizeof(struct jfs_dirent) -
+					 (name_ptr - jfs_dirent->name);
+				outlen = jfs_strfromUCS_le(name_ptr, maxlen,
+							   t->name, len,
+							   codepage);
 				jfs_dirent->name_len += outlen;
 
 				next = t->next;
diff --git a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
index 1d0f65d13b58..2db923872bf1 100644
--- a/fs/jfs/jfs_unicode.c
+++ b/fs/jfs/jfs_unicode.c
@@ -16,7 +16,7 @@
  * FUNCTION:	Convert little-endian unicode string to character string
  *
  */
-int jfs_strfromUCS_le(char *to, const __le16 * from,
+int jfs_strfromUCS_le(char *to, int maxlen, const __le16 * from,
 		      int len, struct nls_table *codepage)
 {
 	int i;
@@ -25,12 +25,12 @@ int jfs_strfromUCS_le(char *to, const __le16 * from,
 	int warn = !!warn_again;	/* once per string */
 
 	if (codepage) {
-		for (i = 0; (i < len) && from[i]; i++) {
+		for (i = 0; (i < len) && from[i] && outlen < maxlen-1; i++) {
 			int charlen;
 			charlen =
 			    codepage->uni2char(le16_to_cpu(from[i]),
 					       &to[outlen],
-					       NLS_MAX_CHARSET_SIZE);
+					       maxlen-1-outlen);
 			if (charlen > 0)
 				outlen += charlen;
 			else {
diff --git a/fs/jfs/jfs_unicode.h b/fs/jfs/jfs_unicode.h
index 9db62d047daa..8b5c74315e07 100644
--- a/fs/jfs/jfs_unicode.h
+++ b/fs/jfs/jfs_unicode.h
@@ -19,7 +19,7 @@ typedef struct {
 extern signed char UniUpperTable[512];
 extern UNICASERANGE UniUpperRange[];
 extern int get_UCSname(struct component_name *, struct dentry *);
-extern int jfs_strfromUCS_le(char *, const __le16 *, int, struct nls_table *);
+extern int jfs_strfromUCS_le(char *, int, const __le16 *, int, struct nls_table *);
 
 #define free_UCSname(COMP) kfree((COMP)->name)
 
-- 
2.20.1

