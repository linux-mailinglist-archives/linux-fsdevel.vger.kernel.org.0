Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F833894F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhCLJ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhCLJzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F51C061761;
        Fri, 12 Mar 2021 01:55:45 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKeW0-00F7m8-Ro; Fri, 12 Mar 2021 10:55:29 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/6] seq_file: rename mangle_path to seq_mangle_path
Date:   Fri, 12 Mar 2021 10:55:21 +0100
Message-Id: <20210312104627.3ac77adf84c4.I2f2e5cec5cc82a51652dafbeb0d1b88708b3c565@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The symbol mangle_path conflicts with a gcov symbol which
can break the build of ARCH=um with gcov, and it's also
not very specific and descriptive.

Rename mangle_path() to seq_mangle_path(), and also remove
the export since it's not needed or used by any modules.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/seq_file.c            | 11 +++++------
 include/linux/seq_file.h |  2 +-
 lib/seq_buf.c            |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..dfa1982a87ca 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -413,7 +413,7 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 EXPORT_SYMBOL(seq_printf);
 
 /**
- *	mangle_path -	mangle and copy path to buffer beginning
+ *	seq_mangle_path -	mangle and copy path to buffer beginning
  *	@s: buffer start
  *	@p: beginning of path in above buffer
  *	@esc: set of characters that need escaping
@@ -423,7 +423,7 @@ EXPORT_SYMBOL(seq_printf);
  *      Returns pointer past last written character in @s, or NULL in case of
  *      failure.
  */
-char *mangle_path(char *s, const char *p, const char *esc)
+char *seq_mangle_path(char *s, const char *p, const char *esc)
 {
 	while (s <= p) {
 		char c = *p++;
@@ -442,7 +442,6 @@ char *mangle_path(char *s, const char *p, const char *esc)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(mangle_path);
 
 /**
  * seq_path - seq_file interface to print a pathname
@@ -462,7 +461,7 @@ int seq_path(struct seq_file *m, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
@@ -505,7 +504,7 @@ int seq_path_root(struct seq_file *m, const struct path *path,
 			return SEQ_SKIP;
 		res = PTR_ERR(p);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 			else
@@ -529,7 +528,7 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
 	if (size) {
 		char *p = dentry_path(dentry, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..0a7dda239e56 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -104,7 +104,7 @@ static inline void seq_setwidth(struct seq_file *m, size_t size)
 }
 void seq_pad(struct seq_file *m, char c);
 
-char *mangle_path(char *s, const char *p, const char *esc);
+char *seq_mangle_path(char *s, const char *p, const char *esc);
 int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
 ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter);
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 707453f5d58e..90b50a514edb 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -274,7 +274,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
-- 
2.29.2

