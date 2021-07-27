Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1933D7363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhG0Kge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236104AbhG0Kge (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45046152B;
        Tue, 27 Jul 2021 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627382191;
        bh=XrjTlqopfnfwY0WGIXPa9IUHl0yY09PQcERb+9iKDQE=;
        h=From:To:Cc:Subject:Date:From;
        b=G2+bvPMFWliWKEWLySVevvnBMQMM4x272wv1j32YL4P4HkYScvXrxP90916rQb2F+
         kFk8n0NfBvfase/IAQulpT/8bmuJORPQ8U+0/jikfcQMDUmljygTmUqmgBCebC6PaX
         wvRxifh8RCdKLrQFSyu9hkkuUhYc9qIrKMos9C/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH] fs: make d_path-like functions all have unsigned size
Date:   Tue, 27 Jul 2021 12:36:25 +0200
Message-Id: <20210727103625.74961-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4567; h=from:subject; bh=XrjTlqopfnfwY0WGIXPa9IUHl0yY09PQcERb+9iKDQE=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/Hy43rbdOV+ecOPd888rURykX41fKZDyzO/1Rp/CwnvX9 NxqrOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi534xzC9+zZa3+nxtpX/UVR9HW+ ZJ/xpu/2VYMPeM0SmB6bbO3hP8U0ubytaYznr3CAA=
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
 fs/d_path.c            | 14 +++++++-------
 include/linux/dcache.h | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 23a53f7b5c71..7876b741a47e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
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
index 9e23d33bb6f1..1a9838dc66fe 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -296,13 +296,13 @@ static inline unsigned d_count(const struct dentry *dentry)
  * helper function for dentry_operations.d_dname() members
  */
 extern __printf(4, 5)
-char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
+char *dynamic_dname(struct dentry *, char *, unsigned int, const char *, ...);
 
-extern char *__d_path(const struct path *, const struct path *, char *, int);
-extern char *d_absolute_path(const struct path *, char *, int);
-extern char *d_path(const struct path *, char *, int);
-extern char *dentry_path_raw(const struct dentry *, char *, int);
-extern char *dentry_path(const struct dentry *, char *, int);
+char *__d_path(const struct path *, const struct path *, char *, unsigned int);
+char *d_absolute_path(const struct path *, char *, unsigned int);
+char *d_path(const struct path *, char *, unsigned int);
+char *dentry_path_raw(const struct dentry *, char *, unsigned int);
+char *dentry_path(const struct dentry *, char *, unsigned int);
 
 /* Allocation counts.. */
 
-- 
2.32.0

