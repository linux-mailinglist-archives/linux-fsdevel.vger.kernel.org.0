Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6864B5D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiLMNOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 08:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiLMNN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:13:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1C1F9DF;
        Tue, 13 Dec 2022 05:13:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so15574105wrm.2;
        Tue, 13 Dec 2022 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFhVgM4vk/xP4R2eEYX3ghJB5sOA60awIF3bJXSTLVc=;
        b=TU8O+JGmM8I2XUjGw8AufjPZmy8W9zpCv5FzQvn6fclnZoaXDe0GTyQe29Ids65Op/
         XWfd0zebnqi48B2lq3+BRnaWHQWcjCytA4C0sZFB4l62k5zUyEjKiZN/HDVQRAJyMigX
         eUa8ZiNQrVZIFMyPRhSfl1Go1wm0jwzwbyJGhcKJF4f51bbXtONDm/QP0OPvwQRYa+X4
         jiZQ/ISv6RbjiFNl3Wxa/hIKzaGMDB1Ayo1vLITJcUh51O+q5mnlu75Fj2vrb3FIeydZ
         dDXsp6zAn2XTIvmPxJyFrucNpzA7vzvzxfq3Lm1CfBnWX4hqCJYuYVzAXmoFRrtzc/H+
         wSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFhVgM4vk/xP4R2eEYX3ghJB5sOA60awIF3bJXSTLVc=;
        b=rzMzojm1Q3TTeBjrx9+kT8BLNZhXpqxUJDux5mKWJtNq5IbzSeRjKArCKzpHZlSr/u
         n+/NsNo7cenRrD7t+bIIqSQs4IiSaLvLODc4HNY/z9+F6D5Auiasn+q/3YwEu1mb93QH
         tOyfjJL82hoALfEmk5uWMRaNq4BtzT599eC47GPXqrw+nx2c+Yd5RbUzJIpL4fN3rSah
         XwkgDkZIW9n7AnHunSsymBpBK2mZQuvyfsHeM5r/cNEpyweAJZkTvDdJEJ3rwBE7QF3U
         etFUMH4qTWS+fNoPzRBA6HkcHfQVL5JhlJjraTI0e7mFGUavozdVRv2ze1dLAxwNjqYz
         47pg==
X-Gm-Message-State: ANoB5plHjv21eiIDpfpLEubUI/rbXD+Sec3PuXTu9T0z8KfFRrBQUpgf
        Ga/Y+r9yCXwjZ8IE65/H7Bw=
X-Google-Smtp-Source: AA0mqf4tfpJGltiam/afxkQOqaxHXHouAThh1svRZq2lzBH4TC6WqjN7okqfIZiCz46kmh3/tx7m+g==
X-Received: by 2002:a5d:690d:0:b0:242:60dd:3a69 with SMTP id t13-20020a5d690d000000b0024260dd3a69mr12793338wru.68.1670937231373;
        Tue, 13 Dec 2022 05:13:51 -0800 (PST)
Received: from localhost.localdomain ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y11-20020adff14b000000b002365b759b65sm11643563wro.86.2022.12.13.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:13:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Luis Henriques <lhenriques@suse.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5.10 2/2] vfs: fix copy_file_range() averts filesystem freeze protection
Date:   Tue, 13 Dec 2022 15:13:41 +0200
Message-Id: <20221213131341.951049-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213131341.951049-1-amir73il@gmail.com>
References: <20221213131341.951049-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 10bc8e4af65946b727728d7479c028742321b60a upstream.

[backport comments for pre v5.15:
- ksmbd mentions are irrelevant - ksmbd hunks were dropped
- sb_write_started() is missing - assert was dropped
]

Commit 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
copies") removed fallback to generic_copy_file_range() for cross-fs
cases inside vfs_copy_file_range().

To preserve behavior of nfsd and ksmbd server-side-copy, the fallback to
generic_copy_file_range() was added in nfsd and ksmbd code, but that
call is missing sb_start_write(), fsnotify hooks and more.

Ideally, nfsd and ksmbd would pass a flag to vfs_copy_file_range() that
will take care of the fallback, but that code would be subtle and we got
vfs_copy_file_range() logic wrong too many times already.

Instead, add a flag to explicitly request vfs_copy_file_range() to
perform only generic_copy_file_range() and let nfsd and ksmbd use this
flag only in the fallback path.

This choise keeps the logic changes to minimum in the non-nfsd/ksmbd code
paths to reduce the risk of further regressions.

Fixes: 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs copies")
Tested-by: Namjae Jeon <linkinjeon@kernel.org>
Tested-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/vfs.c      |  4 ++--
 fs/read_write.c    | 17 +++++++++++++----
 include/linux/fs.h |  8 ++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9ecaf9481a37..e6bdc16aaf05 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -582,8 +582,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 	ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
-					      count, 0);
+		ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
+					  COPY_FILE_SPLICE);
 	return ret;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index e1e83d6c21e6..ce74f3e0a346 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1444,7 +1444,9 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	 * and several different sets of file_operations, but they all end up
 	 * using the same ->copy_file_range() function pointer.
 	 */
-	if (file_out->f_op->copy_file_range) {
+	if (flags & COPY_FILE_SPLICE) {
+		/* cross sb splice is allowed */
+	} else if (file_out->f_op->copy_file_range) {
 		if (file_in->f_op->copy_file_range !=
 		    file_out->f_op->copy_file_range)
 			return -EXDEV;
@@ -1494,8 +1496,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			    size_t len, unsigned int flags)
 {
 	ssize_t ret;
+	bool splice = flags & COPY_FILE_SPLICE;
 
-	if (flags != 0)
+	if (flags & ~COPY_FILE_SPLICE)
 		return -EINVAL;
 
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
@@ -1521,14 +1524,14 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * same sb using clone, but for filesystems where both clone and copy
 	 * are supported (e.g. nfs,cifs), we only call the copy method.
 	 */
-	if (file_out->f_op->copy_file_range) {
+	if (!splice && file_out->f_op->copy_file_range) {
 		ret = file_out->f_op->copy_file_range(file_in, pos_in,
 						      file_out, pos_out,
 						      len, flags);
 		goto done;
 	}
 
-	if (file_in->f_op->remap_file_range &&
+	if (!splice && file_in->f_op->remap_file_range &&
 	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
 		ret = file_in->f_op->remap_file_range(file_in, pos_in,
 				file_out, pos_out,
@@ -1548,6 +1551,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * consistent story about which filesystems support copy_file_range()
 	 * and which filesystems do not, that will allow userspace tools to
 	 * make consistent desicions w.r.t using copy_file_range().
+	 *
+	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
 	 */
 	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
 				      flags);
@@ -1602,6 +1607,10 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 		pos_out = f_out.file->f_pos;
 	}
 
+	ret = -EINVAL;
+	if (flags != 0)
+		goto out;
+
 	ret = vfs_copy_file_range(f_in.file, pos_in, f_out.file, pos_out, len,
 				  flags);
 	if (ret > 0) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8bde32cf9711..acf8dd6288f7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1817,6 +1817,14 @@ struct dir_context {
  */
 #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
 
+/*
+ * These flags control the behavior of vfs_copy_file_range().
+ * They are not available to the user via syscall.
+ *
+ * COPY_FILE_SPLICE: call splice direct instead of fs clone/copy ops
+ */
+#define COPY_FILE_SPLICE		(1 << 0)
+
 struct iov_iter;
 
 struct file_operations {
-- 
2.16.5

