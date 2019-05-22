Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A49269A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfEVSNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:13:35 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:51919 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVSNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:13:35 -0400
Received: by mail-oi1-f202.google.com with SMTP id w5so1261376oig.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6wO6oiSLtG+g/llMooqVDOP+WudURPHtf7GN76fyZzI=;
        b=exb8k5l8CB978GrssJJQSUDvEF5O8bh9lzG4ewE4r8MAd60F7JGj1Q4sF4R5zcD5sS
         Bcs7SLRaaO7JpgUjDJSSErJMPS+x+58C5blLzSWO3RpEDNyy6J3L02A1aPlyFp4M2Rj8
         Z4kXt7ZbfWnQd5ewyD/8o5vp/rZFan3o0Vt97uEzWUFXQeykzNwphZCJUJBlWJ/LOlnV
         6Blsr6/QajUtNgtu5oV1dQfXea8WouWBdswfOAnzsX+J9rVVKLRBopH2S7tC6rTPK3Zq
         YCePgWR9onlwuOfR1DsC5DycNqclfXc9VL1Z/65cJDFwvKjrszwutv31jBnNnzHFBFNa
         gPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6wO6oiSLtG+g/llMooqVDOP+WudURPHtf7GN76fyZzI=;
        b=d2/ghpIzhlO5IG1AU7+XhnMFGqtVcaAo3zqHFQw7erswGJDVsW0PNnfmUdektDT1mT
         cGV+5IvUyDhBtn0JS3//aTPK3vEWMxPa50IOFeJ83fWAalszz2/Dr+tWyAgHStnZh5KT
         kntmjK2J40qBqw7RGZbYjpXMnConTzQ0GELE16MlaJsP86/vcj4t5/UWHm8THWpbkqXV
         BeOU9hmouzqxvE09YFch/P00To8ptQiehKBnJYHtUPXjaaNbu+FSxv+08CBSk+i4hJk+
         uM1DC2yOHXB8gHK2FNkz/3Eh5eAdScRQT5V+kc8XFIaYAqOeMIXxvIiOK27Dc5SxKwd9
         BGFg==
X-Gm-Message-State: APjAAAVuDEt39hGHi8Am3HIhlNfLDboGnX7nXrUyWcIusy/0Z+LwDgpL
        2qbyxewYa/YfGZNvREU34qBZSSDxaHckMiOer5ixHg==
X-Google-Smtp-Source: APXvYqzSP/OiEWYntQWkldbi77heTw6ka6f05ZnI9TroTmLmU0qCosjcXD6Tg0HMe5qxojPOICMM03TCBJnpNK8F0+uS+Q==
X-Received: by 2002:aca:c6c2:: with SMTP id w185mr801882oif.104.1558548814728;
 Wed, 22 May 2019 11:13:34 -0700 (PDT)
Date:   Wed, 22 May 2019 11:13:23 -0700
In-Reply-To: <20190522181327.71980-1-matthewgarrett@google.com>
Message-Id: <20190522181327.71980-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190522181327.71980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V4 1/5] VFS: Add a call to obtain a file's hash
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

IMA wants to know what the hash of a file is, and currently does so by
reading the entire file and generating the hash. Some filesystems may
have the ability to store the hash in a secure manner resistant to
offline attacks (eg, filesystem-level file signing), and in that case
it's a performance win for IMA to be able to use that rather than having
to re-hash everything. This patch simply adds VFS-level support for
calling down to filesystems.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/read_write.c    | 24 ++++++++++++++++++++++++
 include/linux/fs.h |  6 +++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index c543d965e288..34c939b4d05f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2178,3 +2178,27 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range);
+
+/**
+ * vfs_gethash - obtain a file's hash
+ * @file:	file structure in question
+ * @hash_algo:	the hash algorithm requested
+ * @buf:	buffer to return the hash in
+ * @size:	size allocated for the buffer by the caller
+ *
+ * This function allows filesystems that support securely storing the hash
+ * of a file to return it rather than forcing the kernel to recalculate it.
+ * Filesystems that cannot provide guarantees about the hash being resistant
+ * to offline attack should not implement this functionality.
+ *
+ * Returns 0 on success, -EOPNOTSUPP if the filesystem doesn't support it.
+ */
+int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
+		 size_t size)
+{
+	if (!file->f_op->get_hash)
+		return -EOPNOTSUPP;
+
+	return file->f_op->get_hash(file, hash, buf, size);
+}
+EXPORT_SYMBOL(vfs_get_hash);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..9e9f927ac2fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/hash_info.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -1828,6 +1829,8 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*get_hash)(struct file *, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 } __randomize_layout;
 
 struct inode_operations {
@@ -1904,7 +1907,8 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
-
+extern int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
-- 
2.21.0.1020.gf2820cf01a-goog

