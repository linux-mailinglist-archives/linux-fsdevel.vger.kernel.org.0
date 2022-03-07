Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3448B4CFC8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiCGLWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiCGLWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511F6431;
        Mon,  7 Mar 2022 02:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zdR2eHZtZScfZ5UydZPv5wfih1RGjuRwXMxoXkOjRbY=; b=AWmsiMM6yN0ReZnDGH1KA6ypaK
        AgLxjTCfzUqpSb9uXRcKHQCeLez3JmZ9Wvv7oQf6FIyUY/at6dNk2pYSmfG58yIsPMo55B690qd73
        ajsldvU0qG/wY3O7dYlxxXxCwSxINUTeq6VmBQoI5YnHrEmQEHdAoffDEdD2JexvX/UySQb6d5ber
        95xmZ1pe+Fm2YNLyVQAk1baIjKoWp04evfsVHB8D6TLMkl+m7naziZJ7LfSicaj4SHVekj/2T3xyg
        pCHN+AmxKmplvEOXIf+p3/vdRKOfkp+pXMR1Yf/qSHSgFMb+6OCfJLEh7y75+JDzpBF86VoGwexo6
        kaszXxDg==;
Received: from [2001:4bb8:184:7746:acf1:fa8:78c0:4ff2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRAtO-00HCgH-Ef; Mon, 07 Mar 2022 10:47:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: remove kiocb.ki_hint
Date:   Mon,  7 Mar 2022 11:47:00 +0100
Message-Id: <20220307104701.607750-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307104701.607750-1-hch@lst.de>
References: <20220307104701.607750-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This field is entirely unused now except for a tracepoint in f2fs, so
remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c                    |  1 -
 fs/cachefiles/io.c          |  2 --
 fs/f2fs/file.c              |  6 ------
 fs/io_uring.c               |  1 -
 include/linux/fs.h          | 12 ------------
 include/trace/events/f2fs.h |  3 +--
 6 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13a7db0f..eb0948bb74f18 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1478,7 +1478,6 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_flags = iocb_flags(req->ki_filp);
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
-	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
 		/*
 		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 753986ea1583b..bc7c7a7d92600 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -138,7 +138,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos + skipped;
 	ki->iocb.ki_flags	= IOCB_DIRECT;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
 	ki->object		= object;
@@ -313,7 +312,6 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos;
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
 	ki->inval_counter	= cres->inval_counter;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c98ef6af97d1..45076c01a2bab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4479,10 +4479,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const bool do_opu = f2fs_lfs_mode(sbi);
-	const int whint_mode = F2FS_OPTION(sbi).whint_mode;
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
-	const enum rw_hint hint = iocb->ki_hint;
 	unsigned int dio_flags;
 	struct iomap_dio *dio;
 	ssize_t ret;
@@ -4515,8 +4513,6 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		if (do_opu)
 			down_read(&fi->i_gc_rwsem[READ]);
 	}
-	if (whint_mode == WHINT_MODE_OFF)
-		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
@@ -4539,8 +4535,6 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret = iomap_dio_complete(dio);
 	}
 
-	if (whint_mode == WHINT_MODE_OFF)
-		iocb->ki_hint = hint;
 	if (do_opu)
 		up_read(&fi->i_gc_rwsem[READ]);
 	up_read(&fi->i_gc_rwsem[WRITE]);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 23e7f93d39563..02400fd00501e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3790,7 +3790,6 @@ static int io_write_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	req->rw.kiocb.ki_hint = ki_hint_validate(file_write_hint(req->file));
 	return io_prep_rw(req, sqe);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b07..d5658ac5d8c65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -327,7 +327,6 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
-	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
 	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	randomized_struct_fields_end
@@ -2225,21 +2224,11 @@ static inline enum rw_hint file_write_hint(struct file *file)
 
 static inline int iocb_flags(struct file *file);
 
-static inline u16 ki_hint_validate(enum rw_hint hint)
-{
-	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;
-
-	if (hint <= max_hint)
-		return hint;
-	return 0;
-}
-
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
-		.ki_hint = ki_hint_validate(file_write_hint(filp)),
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
@@ -2250,7 +2239,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = kiocb_src->ki_flags,
-		.ki_hint = kiocb_src->ki_hint,
 		.ki_ioprio = kiocb_src->ki_ioprio,
 		.ki_pos = kiocb_src->ki_pos,
 	};
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f701bb23f83c4..1779e133cea0c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -956,12 +956,11 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->rw	= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->iocb->ki_pos,
 		__entry->len,
 		__entry->iocb->ki_flags,
-		__entry->iocb->ki_hint,
 		__entry->iocb->ki_ioprio,
 		__entry->rw)
 );
-- 
2.30.2

