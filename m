Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1C29C19F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369870AbgJ0R0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 13:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775650AbgJ0OxA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:53:00 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8B322265;
        Tue, 27 Oct 2020 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603810379;
        bh=lRyihQET4wWx+8eZkdWW/pEjjC0GgzuvTCnX9bjWC58=;
        h=From:To:Cc:Subject:Date:From;
        b=vWHtUIU3xS3y972jDvabA7wU5uusJLJNPIqvCNH4++kQmDLjEujYO2dT0z5CE3CnJ
         GFh2fD2xao/N4nvwRK4YspksIahDl9wNyDBja9hX6n96y8Vp0iK7RlOqrL7aeyUU/K
         ohk+KEh4/8n/NwztAYfPHTFnucqTtAs/s+C+7XNw=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2] seq_file: fix clang warning for NULL pointer arithmetic
Date:   Tue, 27 Oct 2020 15:52:23 +0100
Message-Id: <20201027145252.3976138-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out that adding something to NULL is notallowed
in standard C:

fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Rephrase the code to be extra explicit about the valid, giving
them named SEQ_OPEN_EOF and SEQ_OPEN_SINGLE definitions.
The instance in kernfs was copied from single_start, so fix both
at once.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add the named macros after Christoph Hellwig pointed out
that my original logic was too ugly.
Suggestions for better names welcome
---
 fs/kernfs/file.c         | 8 ++++----
 fs/seq_file.c            | 4 ++--
 include/linux/seq_file.h | 3 +++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..eafeb8bf4fe4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -121,10 +121,10 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		return next;
 	} else {
 		/*
-		 * The same behavior and code as single_open().  Returns
-		 * !NULL if pos is at the beginning; otherwise, NULL.
+		 * The same behavior and code as single_open().  Continues
+		 * if pos is at the beginning; otherwise, EOF.
 		 */
-		return NULL + !*ppos;
+		return *ppos ? SEQ_OPEN_SINGLE : SEQ_OPEN_EOF;
 	}
 }
 
@@ -145,7 +145,7 @@ static void *kernfs_seq_next(struct seq_file *sf, void *v, loff_t *ppos)
 		 * terminate after the initial read.
 		 */
 		++*ppos;
-		return NULL;
+		return SEQ_OPEN_EOF;
 	}
 }
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 31219c1db17d..203cd86136ad 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -526,13 +526,13 @@ EXPORT_SYMBOL(seq_dentry);
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	return *pos == 0 ? SEQ_OPEN_SINGLE : SEQ_OPEN_EOF;
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
 {
 	++*pos;
-	return NULL;
+	return SEQ_OPEN_EOF;
 }
 
 static void single_stop(struct seq_file *p, void *v)
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 813614d4b71f..26f0758b6551 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -37,6 +37,9 @@ struct seq_operations {
 
 #define SEQ_SKIP 1
 
+#define SEQ_OPEN_EOF	(void *)0
+#define SEQ_OPEN_SINGLE	(void *)1
+
 /**
  * seq_has_overflowed - check if the buffer has overflowed
  * @m: the seq_file handle
-- 
2.27.0

