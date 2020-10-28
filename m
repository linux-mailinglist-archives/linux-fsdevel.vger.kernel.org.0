Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5205429D74E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgJ1WWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbgJ1WWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:24 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CDA247B2;
        Wed, 28 Oct 2020 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603897930;
        bh=lub8VFdz9y1ay4Kw8idOVilwJzgx9JVK/MSfD79W7mQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ym3WEmO2VDY3tqNE+V5DjPOajVNzG45tFzO5Xq26Fk17ahiATlI8aQ0yBcgSkxktG
         Ulaa2zatXB58MUZAxY2ID+nPSvAJqQSE1u3UwLBO68Qw1LIL/F+6UbuJ5a1zqSKHwk
         FswansWVaI4SJFX4q7vMXLMED9aRFFkRcctAODpE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v4] seq_file: fix clang warning for NULL pointer arithmetic
Date:   Wed, 28 Oct 2020 16:11:36 +0100
Message-Id: <20201028151202.3074398-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out that adding something to NULL is not allowed in
standard C:

fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Rephrase the code to be extra explicit about the valid, giving them
named SEQ_OPEN_EOF and SEQ_OPEN_SINGLE definitions.  The instance in
kernfs was copied from single_start, so fix both at once.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add the named macros after Christoph Hellwig pointed out
    that my original logic was too ugly.

v3: don't overload the NULL return, avoid ?: operator

v4: fix changelog text (Nathan Chancellor), add comment (Christoph
    Hellwig)
---
 fs/kernfs/file.c         | 9 ++++++---
 fs/seq_file.c            | 5 ++++-
 include/linux/seq_file.h | 6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..5a5adb03c6df 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -121,10 +121,13 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		return next;
 	} else {
 		/*
-		 * The same behavior and code as single_open().  Returns
-		 * !NULL if pos is at the beginning; otherwise, NULL.
+		 * The same behavior and code as single_open().  Continues
+		 * if pos is at the beginning; otherwise, NULL.
 		 */
-		return NULL + !*ppos;
+		if (*ppos)
+			return NULL;
+
+		return SEQ_OPEN_SINGLE;
 	}
 }
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 31219c1db17d..6b467d769501 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -526,7 +526,10 @@ EXPORT_SYMBOL(seq_dentry);
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	if (*pos)
+	       return NULL;
+
+	return SEQ_OPEN_SINGLE;
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 813614d4b71f..bfa34f5578b9 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -37,6 +37,12 @@ struct seq_operations {
 
 #define SEQ_SKIP 1
 
+/*
+ * op->start must return a non-NULL pointer for single_open(),
+ * this is used when we don't care about the specific value.
+ */
+#define SEQ_OPEN_SINGLE (void *)1
+
 /**
  * seq_has_overflowed - check if the buffer has overflowed
  * @m: the seq_file handle
-- 
2.27.0

