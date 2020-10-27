Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D6B29CBEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 23:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832296AbgJ0WT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 18:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1832259AbgJ0WTZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:19:25 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B4E221FB;
        Tue, 27 Oct 2020 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603837164;
        bh=n7UpbqZyTI9aIsplmRkzVU0w4yzLRfwO05aNiS3AsM0=;
        h=From:To:Cc:Subject:Date:From;
        b=R+yq+59vcUy0GqZTDoz7lEjf9VLWUQtvLsbbN67XhkkSGUemJu7lccWxE85YogQjg
         AawX/Q4bqluHj2XJSkZzkACoWIuF3mUhY5inCqy/pTlE02I+3xHxfMVpUAPdhttJQv
         roSSIsl0ld4nBSNaKLtjhb6lGf5L3MrCxaLzKj9c=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v3] seq_file: fix clang warning for NULL pointer arithmetic
Date:   Tue, 27 Oct 2020 23:18:24 +0100
Message-Id: <20201027221916.463235-1-arnd@kernel.org>
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

v3: don't overload the NULL return, avoid ?: operator
---
 fs/kernfs/file.c         | 9 ++++++---
 fs/seq_file.c            | 5 ++++-
 include/linux/seq_file.h | 2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index 813614d4b71f..eb344448d4da 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -37,6 +37,8 @@ struct seq_operations {
 
 #define SEQ_SKIP 1
 
+#define SEQ_OPEN_SINGLE	(void *)1
+
 /**
  * seq_has_overflowed - check if the buffer has overflowed
  * @m: the seq_file handle
-- 
2.27.0

