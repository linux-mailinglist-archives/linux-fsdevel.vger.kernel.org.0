Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD363D74BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhG0MIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhG0MIA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:08:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E73D61A38;
        Tue, 27 Jul 2021 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627387680;
        bh=/pDNMzFS+Mxit0n/scgZVo8ALxfKu5yarVzdhGl0duk=;
        h=From:To:Cc:Subject:Date:From;
        b=OZr+hbj/gUtIITczNWEZJrlhOAnG4Rz+A1677XGcOEq5Dff2MHdi1BkXff/v0pp5R
         ZIfP1KFYDbcpqcb7hedvwWvs2AjIWvPWUtjdVQNTRzjl+oeyoje2PPiDvaFreEvQxb
         ApSXrMMhJwYxRE+8u6cpFQYTIMRoqulsm0GFcgYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2] fs: make d_path-like functions all have unsigned size
Date:   Tue, 27 Jul 2021 14:07:54 +0200
Message-Id: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4979; h=from:subject; bh=/pDNMzFS+Mxit0n/scgZVo8ALxfKu5yarVzdhGl0duk=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/v4tPX5H3/KHA/hyxy/qf7f33Hmn+xryo42+M+b9sicgr akJ+HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRtVsYFsx7/UPDzf+5iXZi358X8h sXF7heLGWYn5FtyKKyLOr8hGBW7zw25kXmKRNPAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When running static analysis tools to find where signed values could
potentially wrap the family of d_path() functions turn out to trigger a
lot of mess.  In evaluating the code, all of these usages seem safe, but
pointer math is involved so if a negative number is ever somehow passed
into these functions, memory can be traversed backwards in ways not
intended.

Resolve all of the abuguity by just making "size" an unsigned value,
which takes the guesswork out of everything involved.

Reported-by: Jordy Zomer <jordy@pwning.systems>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
changes since v1:
	- add 'size' name to function prototypes
	- change struct prepend_buffer's size field to also be unsigned

 fs/d_path.c            | 16 ++++++++--------
 include/linux/dcache.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 23a53f7b5c71..73b7ea17a330 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -10,7 +10,7 @@
 
 struct prepend_buffer {
 	char *buf;
-	int len;
+	unsigned int len;
 };
 #define DECLARE_BUFFER(__name, __buf, __len) \
 	struct prepend_buffer __name = {.buf = __buf + __len, .len = __len}
@@ -182,7 +182,7 @@ static int prepend_path(const struct path *path,
  */
 char *__d_path(const struct path *path,
 	       const struct path *root,
-	       char *buf, int buflen)
+	       char *buf, unsigned int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
 
@@ -193,7 +193,7 @@ char *__d_path(const struct path *path,
 }
 
 char *d_absolute_path(const struct path *path,
-	       char *buf, int buflen)
+	       char *buf, unsigned int buflen)
 {
 	struct path root = {};
 	DECLARE_BUFFER(b, buf, buflen);
@@ -230,7 +230,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
  *
  * "buflen" should be positive.
  */
-char *d_path(const struct path *path, char *buf, int buflen)
+char *d_path(const struct path *path, char *buf, unsigned int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
 	struct path root;
@@ -266,7 +266,7 @@ EXPORT_SYMBOL(d_path);
 /*
  * Helper function for dentry_operations.d_dname() members
  */
-char *dynamic_dname(struct dentry *dentry, char *buffer, int buflen,
+char *dynamic_dname(struct dentry *dentry, char *buffer, unsigned int buflen,
 			const char *fmt, ...)
 {
 	va_list args;
@@ -284,7 +284,7 @@ char *dynamic_dname(struct dentry *dentry, char *buffer, int buflen,
 	return memcpy(buffer, temp, sz);
 }
 
-char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
+char *simple_dname(struct dentry *dentry, char *buffer, unsigned int buflen)
 {
 	DECLARE_BUFFER(b, buffer, buflen);
 	/* these dentries are never renamed, so d_lock is not needed */
@@ -328,7 +328,7 @@ static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
 	return extract_string(&b);
 }
 
-char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen)
+char *dentry_path_raw(const struct dentry *dentry, char *buf, unsigned int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
 
@@ -337,7 +337,7 @@ char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen)
 }
 EXPORT_SYMBOL(dentry_path_raw);
 
-char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
+char *dentry_path(const struct dentry *dentry, char *buf, unsigned int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9e23d33bb6f1..c93ac4e39566 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -295,14 +295,14 @@ static inline unsigned d_count(const struct dentry *dentry)
 /*
  * helper function for dentry_operations.d_dname() members
  */
-extern __printf(4, 5)
-char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
-
-extern char *__d_path(const struct path *, const struct path *, char *, int);
-extern char *d_absolute_path(const struct path *, char *, int);
-extern char *d_path(const struct path *, char *, int);
-extern char *dentry_path_raw(const struct dentry *, char *, int);
-extern char *dentry_path(const struct dentry *, char *, int);
+__printf(4, 5)
+char *dynamic_dname(struct dentry *, char *, unsigned int size , const char *, ...);
+
+char *__d_path(const struct path *, const struct path *, char *, unsigned int size);
+char *d_absolute_path(const struct path *, char *, unsigned int size);
+char *d_path(const struct path *, char *, unsigned int size);
+char *dentry_path_raw(const struct dentry *, char *, unsigned int size);
+char *dentry_path(const struct dentry *, char *, unsigned int size);
 
 /* Allocation counts.. */
 
-- 
2.32.0

