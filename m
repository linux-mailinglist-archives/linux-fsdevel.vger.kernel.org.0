Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD921F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfEQVY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:24:58 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:49387 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfEQVY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:24:57 -0400
Received: by mail-yw1-f73.google.com with SMTP id y144so7544273ywg.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=APRT6LEPqixBvHano+viVPqM6dMjKu1ogq3RkP5nfIs=;
        b=aQGynE/2Ct9KNtAZ5iXBB7Jw62upUkAAyczhhJA2F2czqiQLh5wh9ZmTZ5mdlePYNW
         7Q2l38wyOVWIApdmBcxAMtIrAymD+NglINpMls/Kdy0g5QIlyE8eSjjdDcnZFhgq967e
         Fy2OWQajtivBBaDPOHJOu1hVM5zn38CSqqq/wtOqyPLhTlCHffHTk5yB/O8qMLjnfiDj
         tneN6ddq1ojgYtZPEs34VwLam+ZAeHQV5/+rVb2RvxpDlHs6E95TpD1GltdHSms2k08y
         tGJ9EcZT40MUmHTOE7+C+psQM8srkuGOYH+1esnAYAtmwgChEZqTpGueKDGXdRQ46EIN
         RD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=APRT6LEPqixBvHano+viVPqM6dMjKu1ogq3RkP5nfIs=;
        b=IR+sWP+fAB9Ey9u+M7Kq9ClcDOfVUH+Pi3murTALdiXv2DOmV76/mdSBMbCngOsjK5
         rjdT1njNV9zl8bp2Gb21s+zzJKxB95rEHemOzgMWr3zseWY0AO3263wg2b9pdMUlTUn3
         Nww1HNdrgCz3GURqIdaZV+dzx6/3Enn0JOylCOG9ryEXp+0fQCTLAKXrqvNT7hzHdWYn
         ic7YOVs2Vp9fNtc5yRwlGjwpH0Fg2QufphjrOeP5Bc8AcJzaQeogltUl70He72JOm3oZ
         EDzguYrp9KtND5F7vlfx0OFpGVeCCOdk5VRicu3mW8BoXO54fvBmauJrf3SKixpqkCGZ
         yKYQ==
X-Gm-Message-State: APjAAAXZGYBb5l9me11N6PL1qzSJpZ9LkiEL2yrWQr/E+h4AtCyaZWMN
        +jazJelPd2ETh5sr55C5DZa3BD//hQ8uMnei7ZN+ng==
X-Google-Smtp-Source: APXvYqz8FZKK/R4raVavRFrW36HXdCWJ+9zF2vh1ttYxP1/usjMDW20DfxgQgYrPzK6jQWhBLwEqmk7fErV5wuX5TcKCNw==
X-Received: by 2002:a81:2717:: with SMTP id n23mr29712693ywn.511.1558128297020;
 Fri, 17 May 2019 14:24:57 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:43 -0700
In-Reply-To: <20190517212448.14256-1-matthewgarrett@google.com>
Message-Id: <20190517212448.14256-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 1/6] VFS: Add a call to obtain a file's hash
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
index 61b43ad7608e..3ba7038ba9a9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2157,3 +2157,27 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
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
index dd28e7679089..211f0e214953 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/hash_info.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -1822,6 +1823,8 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*get_hash)(struct file *, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 } __randomize_layout;
 
 struct inode_operations {
@@ -1898,7 +1901,8 @@ extern int vfs_dedupe_file_range(struct file *file,
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

