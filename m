Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFDD3E3B68
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhHHQZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhHHQZj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F64B610CB;
        Sun,  8 Aug 2021 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439920;
        bh=BUPoxALGC7F75VOkWPfL8v5IuC/ZnFA2iXsEfysXhCI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jlk2xHjSB3vCq6E0hlc67/375GfJRZJ9Ws1YxQ+dX1+bTRkucGkfObV2q2EHTxOls
         cr9ZDxbxOLgjznzzCIqlhXTj+MAhu04CuPhVT0krP7SDiHNb7YIRUcMFdd8JVv6lUq
         T2LEHvz2QJ/lc52ZXvyWP7WP5Ezng2UIad7JWsf2mBcJ86CwHSLHU0YwUOMgS+T39l
         qMvtXAH/riRRJHnyS06r8Vut06PWSdz8sxOuv6oydNMZllYoAD6KB4nkOWS4Lw9ZJu
         Gp1iVVVBdKJQd3qi0VpNmR8PECjq7CdzYGSqhM+mSKQh+TC9MR8z367myFOdc0nBHR
         L0joQoFIiupfA==
Received: by pali.im (Postfix)
        id 3F73113DC; Sun,  8 Aug 2021 18:25:20 +0200 (CEST)
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
Subject: [RFC PATCH 15/20] jfs: Fix buffer overflow in jfs_strfromUCS_le() function
Date:   Sun,  8 Aug 2021 18:24:48 +0200
Message-Id: <20210808162453.1653-16-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 837d42f61464..6dbdce54f139 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3013,6 +3013,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 	int d_namleft, len, outlen;
 	unsigned long dirent_buf;
 	char *name_ptr;
+	int maxlen;
 	u32 dir_index;
 	int do_index = 0;
 	uint loop_count = 0;
@@ -3235,7 +3236,10 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			}
 
 			/* copy the name of head/only segment */
-			outlen = jfs_strfromUCS_le(name_ptr, d->name, len,
+			maxlen = PAGE_SIZE - sizeof(struct jfs_dirent) -
+				 (name_ptr - jfs_dirent->name);
+			outlen = jfs_strfromUCS_le(name_ptr, maxlen,
+						   d->name, len,
 						   codepage);
 			jfs_dirent->name_len = outlen;
 
@@ -3255,8 +3259,11 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
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

