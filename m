Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE877D079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjHOQ6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjHOQ5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:57:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F4B3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 09:57:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3197808bb08so1791061f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692118646; x=1692723446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiZgsPaUUhJ20SitvQ6L4iCITLr8MSvrys3DnrNr51w=;
        b=O2T10xZmyKLxcem0TO+VB3wP3Zj6iigSt4YDFyUaGKrgYwSMv9H8W8PvXaxnx4wKe2
         X6pdybxYDMWriBtszlXn2z6TJA39mk6hCrxV2BKSaq4d/+UPjLhfwq67yyH+51FzsENC
         puPZXKW9BlUqFUmpaL+CfjDqcV1dTgDZ3Uj97t1DFY0rJ0aPJ5EPIFWFmwIxCOV1DQKj
         3PPxinE8xHxDAURiFGJYb3LodEj6sesQ71BUqZfWzadYBYi2qHfH9pYDyak5qQYiYRaS
         GW6CPN+CQQOWMhq4Gle5CHj+7cgbSrGvoCGGTkEK6CgcGP2IE9oLqiu8v6xwmkNSqASM
         wrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118646; x=1692723446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiZgsPaUUhJ20SitvQ6L4iCITLr8MSvrys3DnrNr51w=;
        b=hHb6MUDGd204bGWXORZ14iS+GRjWWD/z+zO+yYME6zAkVbJ5EQIKsHt5SuwjORZuv+
         WBMNNDplT22LnVZNQAWnAtho6yiUopXFc5u2BTdfPiWVY9daRxy9mWnHsV/N5k6BTrv8
         0FmnKzEMCBPZPrmzGjM7O1jxANtxBcZ7wSgtA5oKl2fvgb5wWO28C5b91hoavNsk44jj
         9LujjF0cyE9WYXUiGGXRWzqRLQxmH1/CLNgchKTES7Gv0+3jk4wDwiowVR4O4KfjW/w9
         cm+z7+8bvEzfjn5lCI9xOZd4Mh9xXX0qNhA3/CBlrNTnFywz28LUlmt0ZWgpL855jP4f
         7Fuw==
X-Gm-Message-State: AOJu0YzOyP7TNX8JTUS32teq3k+EI4iZkuN7fFOJ+ExI9Jf7O1QA3dOd
        pcapVF5xFtemRVbosTqByYk=
X-Google-Smtp-Source: AGHT+IFg+DA1YvFVogWilEz2i8Vxx0brnOeE+zwRez4ThlRL/8uW76yboMsXSsX/7FBbTudDg4P/JA==
X-Received: by 2002:a5d:60c9:0:b0:319:77c4:68d1 with SMTP id x9-20020a5d60c9000000b0031977c468d1mr4415677wrt.23.1692118645393;
        Tue, 15 Aug 2023 09:57:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b003fe13c3ece7sm21260147wme.10.2023.08.15.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:57:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: create kiocb_{start,end}_write() helpers
Date:   Tue, 15 Aug 2023 19:57:21 +0300
Message-Id: <20230815165721.821906-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
of file_{start,end}_write() to silence lockdep warnings.

Create helpers for this lockdep dance and use the helpers in all the
callers.

Use a new iocb flag IOCB_WRITE_STARTED to indicate if sb_start_write()
was called.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This is an attempt to consolidate the open coded lockdep fooling in
all those async io submitters into a single helper.
The idea to do that consolidation was suggested by Jan.
The (questionable) idea to use an IOCB_ flag was mine.

This re-factoring is part of a larger vfs cleanup I am doing for
fanotify permission events.  The complete series is not ready for
prime time yet, but this one patch is independent and I would love
to get it reviewed/merged a head of the rest.

Thanks,
Amir.

 fs/aio.c            | 26 ++----------------
 fs/cachefiles/io.c  | 16 ++---------
 fs/overlayfs/file.c | 15 ++++------
 include/linux/fs.h  | 67 +++++++++++++++++++++++++++++++++++++++++++--
 io_uring/rw.c       | 36 ++++--------------------
 5 files changed, 82 insertions(+), 78 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 77e33619de40..410598cb9d21 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
 	if (!list_empty_careful(&iocb->ki_list))
 		aio_remove_iocb(iocb);
 
-	if (kiocb->ki_flags & IOCB_WRITE) {
-		struct inode *inode = file_inode(kiocb->ki_filp);
-
-		/*
-		 * Tell lockdep we inherited freeze protection from submission
-		 * thread.
-		 */
-		if (S_ISREG(inode->i_mode))
-			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-		file_end_write(kiocb->ki_filp);
-	}
+	if (kiocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(kiocb);
 
 	iocb->ki_res.res = res;
 	iocb->ki_res.res2 = 0;
@@ -1581,18 +1572,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
-		/*
-		 * Open-code file_start_write here to grab freeze protection,
-		 * which will be released by another thread in
-		 * aio_complete_rw().  Fool lockdep by telling it the lock got
-		 * released so that it doesn't complain about the held lock when
-		 * we return to userspace.
-		 */
-		if (S_ISREG(file_inode(file)->i_mode)) {
-			sb_start_write(file_inode(file)->i_sb);
-			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
-		}
-		req->ki_flags |= IOCB_WRITE;
+		kiocb_start_write(req);
 		aio_rw_done(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 175a25fcade8..6e16f7c116da 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,9 +259,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	_enter("%ld", ret);
 
-	/* Tell lockdep we inherited freeze protection from submission thread */
-	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+	kiocb_end_write(iocb);
 
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
@@ -286,7 +284,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 {
 	struct cachefiles_cache *cache;
 	struct cachefiles_kiocb *ki;
-	struct inode *inode;
 	unsigned int old_nofs;
 	ssize_t ret;
 	size_t len = iov_iter_count(iter);
@@ -322,19 +319,12 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	/* Open-code file_start_write here to grab freeze protection, which
-	 * will be released by another thread in aio_complete_rw().  Fool
-	 * lockdep by telling it the lock got released so that it doesn't
-	 * complain about the held lock when we return to userspace.
-	 */
-	inode = file_inode(file);
-	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	kiocb_start_write(ki);
 
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
-	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
+	trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7e7876aae01c..d1dc8779d95d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -293,10 +293,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	if (iocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
-		/* Actually acquired in ovl_write_iter() */
-		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
-				      SB_FREEZE_WRITE);
-		file_end_write(iocb->ki_filp);
+		kiocb_end_write(iocb);
 		ovl_copyattr(inode);
 	}
 
@@ -365,6 +362,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+/* IOCB flags that may be propagated to real file io */
+#define OVL_IOCB_MASK ~(IOCB_WRITE_STARTED)
+
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -372,7 +372,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct fd real;
 	const struct cred *old_cred;
 	ssize_t ret;
-	int ifl = iocb->ki_flags;
+	int ifl = iocb->ki_flags & OVL_IOCB_MASK;
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -412,10 +412,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!aio_req)
 			goto out;
 
-		file_start_write(real.file);
-		/* Pacify lockdep, same trick as done in aio_write() */
-		__sb_writers_release(file_inode(real.file)->i_sb,
-				     SB_FREEZE_WRITE);
 		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
@@ -423,6 +419,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);
+		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
 		ovl_aio_put(aio_req);
 		if (ret != -EIOCBQUEUED)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fb1f050f560..6305bc710d30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -338,6 +338,8 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+/* file_start_write() was called */
+#define IOCB_WRITE_STARTED	(1 << 22)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
@@ -351,7 +353,8 @@ enum rw_hint {
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
+	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
+	{ IOCB_WRITE_STARTED,	"WRITE_STARTED" }
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -2632,6 +2635,13 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
 	return (inode->i_mode ^ mode) & S_IFMT;
 }
 
+/**
+ * file_start_write - get write access to a superblock for regular file io
+ * @file: the file we want to write to
+ *
+ * This is a variant of sb_start_write() which is a noop on non-regualr file.
+ * Should be matched with a call to file_end_write().
+ */
 static inline void file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
@@ -2646,11 +2656,64 @@ static inline bool file_start_write_trylock(struct file *file)
 	return sb_start_write_trylock(file_inode(file)->i_sb);
 }
 
+/**
+ * file_end_write - drop write access to a superblock of a regular file
+ * @file: the file we wrote to
+ *
+ * Should be matched with a call to file_start_write().
+ */
 static inline void file_end_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(file_inode(file)->i_sb);
+}
+
+/**
+ * kiocb_start_write - get write access to a superblock for async file io
+ * @iocb: the io context we want to submit the write with
+ *
+ * This is a variant of file_start_write() for async io submission.
+ * Should be matched with a call to kiocb_end_write().
+ */
+static inline void kiocb_start_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	iocb->ki_flags |= IOCB_WRITE;
+	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
+		return;
+	if (!S_ISREG(inode->i_mode))
+		return;
+	sb_start_write(inode->i_sb);
+	/*
+	 * Fool lockdep by telling it the lock got released so that it
+	 * doesn't complain about the held lock when we return to userspace.
+	 */
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	iocb->ki_flags |= IOCB_WRITE_STARTED;
+}
+
+/**
+ * kiocb_end_write - drop write access to a superblock after async file io
+ * @iocb: the io context we sumbitted the write with
+ *
+ * Should be matched with a call to kiocb_start_write().
+ */
+static inline void kiocb_end_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
+		return;
+	if (!S_ISREG(inode->i_mode))
+		return;
+	/*
+	 * Tell lockdep we inherited freeze protection from submission thread.
+	 */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(inode->i_sb);
+	iocb->ki_flags &= ~IOCB_WRITE_STARTED;
 }
 
 /*
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1bce2208b65c..09493ae49b85 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -220,20 +220,6 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 }
 #endif
 
-static void kiocb_end_write(struct io_kiocb *req)
-{
-	/*
-	 * Tell lockdep we inherited freeze protection from submission
-	 * thread.
-	 */
-	if (req->flags & REQ_F_ISREG) {
-		struct super_block *sb = file_inode(req->file)->i_sb;
-
-		__sb_writers_acquired(sb, SB_FREEZE_WRITE);
-		sb_end_write(sb);
-	}
-}
-
 /*
  * Trigger the notifications after having done some IO, and finish the write
  * accounting, if any.
@@ -243,7 +229,7 @@ static void io_req_io_end(struct io_kiocb *req)
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
 	if (rw->kiocb.ki_flags & IOCB_WRITE) {
-		kiocb_end_write(req);
+		kiocb_end_write(&rw->kiocb);
 		fsnotify_modify(req->file);
 	} else {
 		fsnotify_access(req->file);
@@ -313,7 +299,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(req);
+		kiocb_end_write(kiocb);
 	if (unlikely(res != req->cqe.res)) {
 		if (res == -EAGAIN && io_rw_should_reissue(req)) {
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
@@ -902,19 +888,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		return ret;
 	}
 
-	/*
-	 * Open-code file_start_write here to grab freeze protection,
-	 * which will be released by another thread in
-	 * io_complete_rw().  Fool lockdep by telling it the lock got
-	 * released so that it doesn't complain about the held lock when
-	 * we return to userspace.
-	 */
-	if (req->flags & REQ_F_ISREG) {
-		sb_start_write(file_inode(req->file)->i_sb);
-		__sb_writers_release(file_inode(req->file)->i_sb,
-					SB_FREEZE_WRITE);
-	}
-	kiocb->ki_flags |= IOCB_WRITE;
+	kiocb_start_write(kiocb);
 
 	if (likely(req->file->f_op->write_iter))
 		ret2 = call_write_iter(req->file, kiocb, &s->iter);
@@ -961,7 +935,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 				io->bytes_done += ret2;
 
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				kiocb_end_write(kiocb);
 			return ret ? ret : -EAGAIN;
 		}
 done:
@@ -972,7 +946,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		ret = io_setup_async_rw(req, iovec, s, false);
 		if (!ret) {
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				kiocb_end_write(kiocb);
 			return -EAGAIN;
 		}
 		return ret;
-- 
2.34.1

