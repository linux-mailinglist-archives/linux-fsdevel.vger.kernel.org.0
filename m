Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D96624667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiKJPzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 10:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiKJPza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:55:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6F2B1B3;
        Thu, 10 Nov 2022 07:55:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3747071wmb.2;
        Thu, 10 Nov 2022 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+EdQPE3FmfPtSVPDfrx8UgxIukmWt6408vScCtnW74=;
        b=lUP3Okf+FRY4BzN9hFG5Qf0hV92d+T/gDAYw7goZP2Bcuro6EZP4qHHD2XZNYQVULH
         X0QHGxXOhofA2EHDa8pab6foedYSSMUuxSii7NhkRKsMt1dXdX5377OU8Sys0gyw7nXb
         JM39h445WmaM798KmtfhovoeWMvsUys67mS5uGRlq29KeNsg937Pov0vQcYRTUQYmDKp
         yK+X3aA86M9aBknwklQRWZU9VTt/p80aaoQxN//xN3PCgpoJfR8muT40PykhxsJMuwx0
         iA1a7n0vz0rj/Ci7rGtxEXmNnjdRXfCdd3JyWHczmASmGzDaVFXlNQUlkv1d0qvMqHYL
         JRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+EdQPE3FmfPtSVPDfrx8UgxIukmWt6408vScCtnW74=;
        b=amdMoVzlqav8YtFXjzE4lRz9oEL8xKT7D4pG+dkeNc4jA2KrJHXOSozRbhEvcsN2ZG
         8fD2QH51G6zSIGXxAmPGQJBEAbUGfgMWd6BOGCcas1jyYfJv9SJA0KnSyx9qX2ttgr+T
         CyukOvjXZjnLGdistf40HmDczXlFUMz5emIIPtmxhd/8S1WGtcK9MDG9+ALhwrWvgFpJ
         EyyN7xy0nR8ORQ9SRNOzxxxLUxTPs/mLuf6MkeiggAQT1FKGvFEnNroUxgWyEdRZbz/T
         GEM73Uoyz2QLtbnnmg791Z2oHc6QAuFS0jeUU6ncyx2dLwHjHiFEgrmfDxZrQD+xDLpp
         yo4A==
X-Gm-Message-State: ACrzQf1BPELfPBm21besEo/OkbGoQJMoXqjRXEVMrSttMyjKgV1aR2bO
        IfPLsM5qlCigN4xcEe/rmws=
X-Google-Smtp-Source: AMsMyM7jCZizpAbDzaiI/65KNKAhENrYNXK7szU2FN8y+yOYgD+vPb50Ppl0Hc9rCl0bPReG4UKPmw==
X-Received: by 2002:a05:600c:1ca5:b0:3cf:550f:0 with SMTP id k37-20020a05600c1ca500b003cf550f0000mr45563088wms.23.1668095727472;
        Thu, 10 Nov 2022 07:55:27 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id i5-20020adffc05000000b0023660f6cecfsm16292106wrr.80.2022.11.10.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:55:26 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH] vfs: fix copy_file_range() averts filesystem freeze protection
Date:   Thu, 10 Nov 2022 17:55:22 +0200
Message-Id: <20221110155522.556225-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Al,

Another fix for the long tradition of copy_file_range() regressions.
This one only affected cross-fs server-side-copy from nfsd/ksmbd.

I ran the copy_range fstests group on ext4/xfs/overlay to verify no
regressions in local fs and nfsv3/nfsv4 to test server-side-copy.

I also patched copy_file_range() to test the nfsd fallback code on
local fs.

Namje, could you please test ksmbd.

Thanks,
Amir.

 fs/ksmbd/vfs.c     |  6 +++---
 fs/nfsd/vfs.c      |  4 ++--
 fs/read_write.c    | 19 +++++++++++++++----
 include/linux/fs.h |  8 ++++++++
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 8de970d6146f..94b8ed4ef870 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1794,9 +1794,9 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 		ret = vfs_copy_file_range(src_fp->filp, src_off,
 					  dst_fp->filp, dst_off, len, 0);
 		if (ret == -EOPNOTSUPP || ret == -EXDEV)
-			ret = generic_copy_file_range(src_fp->filp, src_off,
-						      dst_fp->filp, dst_off,
-						      len, 0);
+			ret = vfs_copy_file_range(src_fp->filp, src_off,
+						  dst_fp->filp, dst_off, len,
+						  COPY_FILE_SPLICE);
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f650afedd67f..5cf11cde51f8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -596,8 +596,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 	ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
-					      count, 0);
+		ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
+					  COPY_FILE_SPLICE);
 	return ret;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 328ce8cf9a85..24b9668d6377 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1388,6 +1388,8 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
+	lockdep_assert(sb_write_started(file_inode(file_out)->i_sb));
+
 	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
 				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
 }
@@ -1424,7 +1426,9 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
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
@@ -1474,8 +1478,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			    size_t len, unsigned int flags)
 {
 	ssize_t ret;
+	bool splice = flags & COPY_FILE_SPLICE;
 
-	if (flags != 0)
+	if (flags & ~COPY_FILE_SPLICE)
 		return -EINVAL;
 
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
@@ -1501,14 +1506,14 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
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
@@ -1528,6 +1533,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * consistent story about which filesystems support copy_file_range()
 	 * and which filesystems do not, that will allow userspace tools to
 	 * make consistent desicions w.r.t using copy_file_range().
+	 *
+	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
 	 */
 	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
 				      flags);
@@ -1582,6 +1589,10 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
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
index e654435f1651..59ae95ddb679 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2089,6 +2089,14 @@ struct dir_context {
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
 struct io_uring_cmd;
 
-- 
2.25.1

