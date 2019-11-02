Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE7ECEC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 14:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKBNNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 09:13:05 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33668 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfKBNNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 09:13:04 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BE43E2E144E;
        Sat,  2 Nov 2019 16:13:02 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id IqdqyEa08e-D10WsN1u;
        Sat, 02 Nov 2019 16:13:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572700382; bh=S/T/iL7jEJxMwyZ59MfWBFPCGwDwwzXkT2FcFTKPCc4=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=BfwjJO9Ao/nI9ks9slEwlWMFLlqzytlHEsrFjK63anNbSeKq7Ao5Q6zjdDXYhvyVc
         f7BS4RSgIwyPpGxKJ0D8lsW8PxpSjQmLqfU4Ie4ZFSaqXQ3M+yBInfffwOxjSbFuLE
         WYyITwJ2TECD7VcHIQNde3wTja4QNmcSvgEFpKg8=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZXpOk2889Z-D1WiJTEg;
        Sat, 02 Nov 2019 16:13:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/3] fs: keep dio_warn_stale_pagecache() when
 CONFIG_BLOCK=n
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Sat, 02 Nov 2019 16:13:00 +0300
Message-ID: <157270038074.4812.7980855544557488880.stgit@buzz>
In-Reply-To: <157270037850.4812.15036239021726025572.stgit@buzz>
References: <157270037850.4812.15036239021726025572.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper prints warning if direct I/O write failed to invalidate cache,
and set EIO at inode to warn usersapce about possible data corruption.
See also commit 5a9d929d6e13 ("iomap: report collisions between directio and
buffered writes to userspace").

Direct I/O is supported by non-disk filesystems, for example NFS.
Thus generic code needs this even in kernel without CONFIG_BLOCK.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
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
index 288e38199068..189b8f318da2 100644
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

