Return-Path: <linux-fsdevel+bounces-4408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEE7FF2C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D561C20E7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACA3D3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OElRs6AT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059F1B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:34 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so12637371fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353792; x=1701958592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsugKz80pCBuLBfYgyxDcu1g28MIxYeS7EDWo4QmB9s=;
        b=OElRs6AT9pD2Elnd1yGjOuVd8YY7bGf1pQgCsGySN4Zghx3EWU9MasTjD61GVeKISF
         J2w5EzwCxEjE9BybU1eq7Pq1pFl7rOqJyJdQj1AlYwLNtveqR95sV4GWRtaVb6RpxrH1
         FRhbEMsT9DzW3Jg+j+Fcn1roclLr8QiKhICI0RAhtbaQABM+wO11JGnE4OJp10EcIBKn
         oaNQsAEe8O2a/YNCSNl/1R0q1Ht4FE4p9rE1Jhj2j2MB/+xRK708azuzcGhprR01DwvK
         ptivl+IXlyerbRWJp7KaWprjR2ACKTxlfm95bc9jdg2MyoflzFCbrSlgBr5JfvEFp/qK
         qlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353792; x=1701958592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsugKz80pCBuLBfYgyxDcu1g28MIxYeS7EDWo4QmB9s=;
        b=rd80uSbFNOeI/cxAmCsnac1DJ3xvEXdlwENzVf9w7Tc4d1w60AH5a2c/Z5JOCnwAD1
         oko6Llfnjzo8N+GdHdiQjbuDD8vkvZ5CDakvy6eNPG4q3pqKd3tgeNDu09vJveKnfFb3
         R/Px2v5r0jDNV3qWVQwiRv7IQCCRqacv6DQLvmCEwDZ/sSkoUZOFhs3g78HFTCxeudpe
         Y4b8MC+/OyhT6pE7xMYNPyGKQLYIL2NJM/R/O21mVfIqIo8M4dmwKVMOYjc9nNup5F3O
         T8AI4tnlc5DjRucS0E7RgBk3kWsJVUvYSEJ2Vj8HM+OHQAhrdTZspLDjzk7OZf9TSAzi
         zJRQ==
X-Gm-Message-State: AOJu0Yy5c2XPfiGxgYKXZ8uH7u8hGXPOWnR3Rl3fNlwp6wtbFNfwg3xg
	TyBUXBS/Dy8JsdSLNxJKCZE=
X-Google-Smtp-Source: AGHT+IFNniKOicKaTzOlvBqX3oN9m6TzbjRWF63f7mAgqn90yIg03GdmIOyEQ3kvEGWbf/0WKqtc7A==
X-Received: by 2002:a2e:8384:0:b0:2bf:a9b6:d254 with SMTP id x4-20020a2e8384000000b002bfa9b6d254mr11923308ljg.50.1701353792143;
        Thu, 30 Nov 2023 06:16:32 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm2170966wmq.14.2023.11.30.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:16:31 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/3] fs: move file_start_write() into direct_splice_actor()
Date: Thu, 30 Nov 2023 16:16:23 +0200
Message-Id: <20231130141624.3338942-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130141624.3338942-1-amir73il@gmail.com>
References: <20231130141624.3338942-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers of do_splice_direct() hold file_start_write() on the output
file.

This may cause file permission hooks to be called indirectly on an
overlayfs lower layer, which is on the same filesystem of the output
file and could lead to deadlock with fanotify permission events.

To fix this potential deadlock, move file_start_write() from the callers
into the direct_splice_actor(), so file_start_write() will not be held
while splicing from the input file.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231128214258.GA2398475@perftesting/
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c |  2 --
 fs/read_write.c        |  2 --
 fs/splice.c            | 19 ++++++++++++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7a44c8212331..294b330aba9f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -333,11 +333,9 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 		if (error)
 			break;
 
-		ovl_start_write(dentry);
 		bytes = do_splice_direct(old_file, &old_pos,
 					 new_file, &new_pos,
 					 this_len, SPLICE_F_MOVE);
-		ovl_end_write(dentry);
 		if (bytes <= 0) {
 			error = bytes;
 			break;
diff --git a/fs/read_write.c b/fs/read_write.c
index 642c7ce1ced1..0bc99f38e623 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1286,10 +1286,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
 		if (retval < 0)
 			goto fput_out;
-		file_start_write(out.file);
 		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
 					  count, fl);
-		file_end_write(out.file);
 	} else {
 		if (out.file->f_flags & O_NONBLOCK)
 			fl |= SPLICE_F_NONBLOCK;
diff --git a/fs/splice.c b/fs/splice.c
index 9007b2c8baa8..7cda013e5a1e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1157,9 +1157,20 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 			       struct splice_desc *sd)
 {
 	struct file *file = sd->u.file;
+	long ret;
+
+	file_start_write(file);
+	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	file_end_write(file);
+	return ret;
+}
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len,
-			      sd->flags);
+static int splice_file_range_actor(struct pipe_inode_info *pipe,
+					struct splice_desc *sd)
+{
+	struct file *file = sd->u.file;
+
+	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
@@ -1233,6 +1244,8 @@ EXPORT_SYMBOL(do_splice_direct);
  *
  * Description:
  *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *    Like do_splice_direct(), but vfs_copy_file_range() already holds
+ *    start_file_write() on @out file.
  *
  * Callers already called rw_verify_area() on the entire range.
  */
@@ -1242,7 +1255,7 @@ long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 	lockdep_assert(file_write_started(out));
 
 	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
-				      direct_splice_actor);
+				      splice_file_range_actor);
 }
 EXPORT_SYMBOL(splice_file_range);
 
-- 
2.34.1


