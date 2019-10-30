Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26323E97AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJ3ILR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 04:11:17 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54232 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfJ3ILR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:11:17 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id DA8332E154E;
        Wed, 30 Oct 2019 11:11:13 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OlQEp3d1hj-BDeW5lL2;
        Wed, 30 Oct 2019 11:11:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572423073; bh=quyBFSBUxZLyiOh/Pn2ut7NnhKb8kTc5N+3Wo+3KAUE=;
        h=Message-ID:Date:To:From:Subject;
        b=E0YaAQv09VZ6bMh3jIKqlt38V6yindX2nS8vnODKXOzEUm8lDewK7liAn69aBYbTB
         r6oTVNuG3Wtmn8pjYsRL/zpRo1hJpXlA289v39ul140pV9BiZKoa7moJaJtKOCxkeK
         mY8K0W/FbDqmCUF6vaP7wEEJKjoJ8DkoA4sgORFY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by vla1-5826f599457c.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id WammiHiM15-BDVSWk1b;
        Wed, 30 Oct 2019 11:11:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs: keep dio_warn_stale_pagecache() when CONFIG_BLOCK=n
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 30 Oct 2019 11:11:13 +0300
Message-ID: <157242307298.5840.14949889649221596095.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper prints warning if direct I/O write failed to invalidate cache.
Direct I/O is supported by non-disk filesystems, for example NFS.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/201910300824.UIo56oC7%25lkp@intel.com/
---
 fs/direct-io.c     |   21 ---------------------
 include/linux/fs.h |    6 +++++-
 mm/filemap.c       |   21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9329ced91f1d..0ec4f270139f 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -220,27 +220,6 @@ static inline struct page *dio_get_page(struct dio *dio,
 	return dio->pages[sdio->head];
 }
 
-/*
- * Warn about a page cache invalidation failure during a direct io write.
- */
-void dio_warn_stale_pagecache(struct file *filp)
-{
-	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
-	char pathname[128];
-	struct inode *inode = file_inode(filp);
-	char *path;
-
-	errseq_set(&inode->i_mapping->wb_err, -EIO);
-	if (__ratelimit(&_rs)) {
-		path = file_path(filp, pathname, sizeof(pathname));
-		if (IS_ERR(path))
-			path = "(unknown)";
-		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
-		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
-			current->comm);
-	}
-}
-
 /*
  * dio_complete() - called when all DIO BIO I/O has been completed
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..b4e4560d1c38 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3153,7 +3153,6 @@ enum {
 };
 
 void dio_end_io(struct bio *bio);
-void dio_warn_stale_pagecache(struct file *filp);
 
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,
@@ -3198,6 +3197,11 @@ static inline void inode_dio_end(struct inode *inode)
 		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
 }
 
+/*
+ * Warn about a page cache invalidation failure diring a direct I/O write.
+ */
+void dio_warn_stale_pagecache(struct file *filp);
+
 extern void inode_set_flags(struct inode *inode, unsigned int flags,
 			    unsigned int mask);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index cdb8780a0758..d7394226f5ab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3161,6 +3161,27 @@ int pagecache_write_end(struct file *file, struct address_space *mapping,
 }
 EXPORT_SYMBOL(pagecache_write_end);
 
+/*
+ * Warn about a page cache invalidation failure during a direct I/O write.
+ */
+void dio_warn_stale_pagecache(struct file *filp)
+{
+	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
+	char pathname[128];
+	struct inode *inode = file_inode(filp);
+	char *path;
+
+	errseq_set(&inode->i_mapping->wb_err, -EIO);
+	if (__ratelimit(&_rs)) {
+		path = file_path(filp, pathname, sizeof(pathname));
+		if (IS_ERR(path))
+			path = "(unknown)";
+		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
+		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
+			current->comm);
+	}
+}
+
 ssize_t
 generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {

