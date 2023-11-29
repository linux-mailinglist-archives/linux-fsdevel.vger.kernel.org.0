Return-Path: <linux-fsdevel+bounces-4249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DA7FE126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84861C20898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330275EE62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mib6icO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959EF122
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso1113235e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701288437; x=1701893237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTuA/BYq0/ZLLoJDYu3P0IgZk++nACMYQTxnr/DZNfs=;
        b=Mib6icO4PlCj+RMp4uF6EsffmeT1rpT0dtTnqJ/nA/v8Sgf0OPc3j2T9ud4zgKmFWJ
         OuDmKU93KfQnqpuQV7m0AqzUYZwae/KzRAKM9mQaLAos7eO2EoWYMwOQQ+VP3fJxqRBM
         wBNv4VMMB0IqScJm42qVVsQbSlOyLlAljXQBPu2nWuozTrH1rT64AwJ8xFLG2uLoq1rm
         f4iAickKHcb9M5iGA+ab5ccVofG4pBWYDhzebtztetZpJ4EWZgRrCUQmOZtL+MU85P/P
         nckLu0cHsPLeR+AFx6bYClzR0ljvu2YWDj9pOGtTLeX3QHIQhr7W7zC/3X1L3UfBgLIP
         jSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288437; x=1701893237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTuA/BYq0/ZLLoJDYu3P0IgZk++nACMYQTxnr/DZNfs=;
        b=ai0KX+O+rXGHY1giX7d7JilaW4Y/2Q+iVI7kXN+6ocqtilDnnJt9OzcehMeeqbMAIo
         lmPHWEc7apkcNzl6BQMG8btaLHwPzqXc4ZWFeQKgVze030F3uY2IKNcTMUQ2ajQ45PYV
         +4ijaaRsPg4pr+woT3kN/Pza7k4CsVSbqOsgllSbocBeo3O90rMfv7tAXF1/n0vewvJ5
         tt/pVZQKXtmsjc1AJcrOKjT+GwSEW1QDZZZrWHNevNjZRg5FtGxzNFJjcNMdgkNWx0qn
         RRaF7rqG/3YVazF1x6i3/Rcxqp58Wpepp90KfDkF4a90tseu292UzPB+J87xtPAxvI43
         7nrw==
X-Gm-Message-State: AOJu0YyISzHG7Cv4jKht5g4mTFz+omxg9VpmHi0xQVcKgQgPmtHsM7yN
	JRVtmtop6DVG5kaIYUa4a/M=
X-Google-Smtp-Source: AGHT+IHaNIVrK6YZclxVHEcbUn61tx2ri2dlo6EoRblmQsf2fgCp34i98wex5rpuZivWE/uUkEyKxA==
X-Received: by 2002:a05:600c:1ca5:b0:40b:3e7e:af56 with SMTP id k37-20020a05600c1ca500b0040b3e7eaf56mr10800764wms.26.1701288436645;
        Wed, 29 Nov 2023 12:07:16 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b00333083a20e5sm7412719wrr.113.2023.11.29.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:07:16 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: fork do_splice_copy_file_range() from do_splice_direct()
Date: Wed, 29 Nov 2023 22:07:08 +0200
Message-Id: <20231129200709.3154370-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129200709.3154370-1-amir73il@gmail.com>
References: <20231129200709.3154370-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new helper is meant to be called from context of ->copy_file_range()
methods instead of do_splice_direct().

Currently, the only difference is that do_splice_copy_file_range() does
not take a splice flags argument and it asserts that file_start_write()
was called.

Soon, do_splice_direct() will be called without file_start_write() held.

Use the new helper from __ceph_copy_file_range(), that was incorrectly
passing the copy_file_range() flags argument as splice flags argument
to do_splice_direct(). the value of flags was 0, so no actual bug fix.

Move the definition of both helpers to linux/splice.h.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c         |  9 ++---
 fs/read_write.c        |  6 ++--
 fs/splice.c            | 82 ++++++++++++++++++++++++++++++------------
 include/linux/fs.h     |  2 --
 include/linux/splice.h | 13 ++++---
 5 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3b5aae29e944..7c2db78e2c6e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -12,6 +12,7 @@
 #include <linux/falloc.h>
 #include <linux/iversion.h>
 #include <linux/ktime.h>
+#include <linux/splice.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		 * {read,write}_iter, which will get caps again.
 		 */
 		put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
-		ret = do_splice_direct(src_file, &src_off, dst_file,
-				       &dst_off, src_objlen, flags);
+		ret = do_splice_copy_file_range(src_file, &src_off, dst_file,
+						&dst_off, src_objlen);
 		/* Abort on short copies or on error */
 		if (ret < (long)src_objlen) {
 			doutc(cl, "Failed partial copy (%zd)\n", ret);
@@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 */
 	if (len && (len < src_ci->i_layout.object_size)) {
 		doutc(cl, "Final partial copy of %zu bytes\n", len);
-		bytes = do_splice_direct(src_file, &src_off, dst_file,
-					 &dst_off, len, flags);
+		bytes = do_splice_copy_file_range(src_file, &src_off, dst_file,
+						  &dst_off, len);
 		if (bytes > 0)
 			ret += bytes;
 		else
diff --git a/fs/read_write.c b/fs/read_write.c
index f791555fa246..555514cdad53 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
-	lockdep_assert(file_write_started(file_out));
-
-	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+	return do_splice_copy_file_range(file_in, &pos_in, file_out, &pos_out,
+				len > MAX_RW_COUNT ? MAX_RW_COUNT : len);
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
diff --git a/fs/splice.c b/fs/splice.c
index 3fce5f6072dd..3bb4936f8b70 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1158,8 +1158,15 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len,
-			      sd->flags);
+	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+}
+
+static int copy_file_range_splice_actor(struct pipe_inode_info *pipe,
+					struct splice_desc *sd)
+{
+	struct file *file = sd->u.file;
+
+	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
@@ -1170,25 +1177,10 @@ static void direct_file_splice_eof(struct splice_desc *sd)
 		file->f_op->splice_eof(file);
 }
 
-/**
- * do_splice_direct - splices data directly between two files
- * @in:		file to splice from
- * @ppos:	input file offset
- * @out:	file to splice to
- * @opos:	output file offset
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    For use by do_sendfile(). splice can easily emulate sendfile, but
- *    doing it in the application would incur an extra system call
- *    (splice in + splice out, as compared to just sendfile()). So this helper
- *    can splice directly through a process-private pipe.
- *
- * Callers already called rw_verify_area() on the entire range.
- */
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags)
+static long do_splice_direct_actor(struct file *in, loff_t *ppos,
+				   struct file *out, loff_t *opos,
+				   size_t len, unsigned int flags,
+				   splice_direct_actor *actor)
 {
 	struct splice_desc sd = {
 		.len		= len,
@@ -1207,14 +1199,60 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
-	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
+	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
 	return ret;
 }
+/**
+ * do_splice_direct - splices data directly between two files
+ * @in:		file to splice from
+ * @ppos:	input file offset
+ * @out:	file to splice to
+ * @opos:	output file offset
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    For use by do_sendfile(). splice can easily emulate sendfile, but
+ *    doing it in the application would incur an extra system call
+ *    (splice in + splice out, as compared to just sendfile()). So this helper
+ *    can splice directly through a process-private pipe.
+ *
+ * Callers already called rw_verify_area() on the entire range.
+ */
+long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+		      loff_t *opos, size_t len, unsigned int flags)
+{
+	return do_splice_direct_actor(in, ppos, out, opos, len, flags,
+				      direct_splice_actor);
+}
 EXPORT_SYMBOL(do_splice_direct);
 
+/**
+ * do_splice_copy_file_range - splices data for copy_file_range()
+ * @in:		file to splice from
+ * @ppos:	input file offset
+ * @out:	file to splice to
+ * @opos:	output file offset
+ * @len:	number of bytes to splice
+ *
+ * Description:
+ *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *
+ * Callers already called rw_verify_area() on the entire range.
+ */
+long do_splice_copy_file_range(struct file *in, loff_t *ppos, struct file *out,
+			       loff_t *opos, size_t len)
+{
+	lockdep_assert(file_write_started(out));
+
+	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
+				      copy_file_range_splice_actor);
+}
+EXPORT_SYMBOL(do_splice_copy_file_range);
+
 static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 {
 	for (;;) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ae0e2fb7bcea..04422a0eccdd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3052,8 +3052,6 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 size_t len, unsigned int flags);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
-extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		loff_t *opos, size_t len, unsigned int flags);
 
 
 extern void
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 6c461573434d..11e62b641d69 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -80,11 +80,14 @@ extern ssize_t add_to_pipe(struct pipe_inode_info *,
 long vfs_splice_read(struct file *in, loff_t *ppos,
 		     struct pipe_inode_info *pipe, size_t len,
 		     unsigned int flags);
-extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
-				      splice_direct_actor *);
-extern long do_splice(struct file *in, loff_t *off_in,
-		      struct file *out, loff_t *off_out,
-		      size_t len, unsigned int flags);
+ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd,
+			       splice_direct_actor *actor);
+long do_splice(struct file *in, loff_t *off_in, struct file *out,
+	       loff_t *off_out, size_t len, unsigned int flags);
+long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+		      loff_t *opos, size_t len, unsigned int flags);
+long do_splice_copy_file_range(struct file *in, loff_t *ppos, struct file *out,
+			       loff_t *opos, size_t len);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
-- 
2.34.1


