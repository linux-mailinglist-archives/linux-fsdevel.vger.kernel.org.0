Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E147A8C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjITTP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjITTP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:26 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A195EB;
        Wed, 20 Sep 2023 12:14:55 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so110997b3a.3;
        Wed, 20 Sep 2023 12:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237295; x=1695842095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+1lG1eCcPW2wHVHtVCKpPCzIcbg4+wuQozGsxMVYEs=;
        b=uMqZqYwUMJYYvgERJHKPij9DD33BM7xaJwSpjoKE5oesQ7f8qUeN3kR8hfweuBfn2M
         NGp77PhOVFyXCjY55tOggeP33xgsS7a0OhhJZNFPg2oHhN/jSGlQ0KvZb6csyQY20tdF
         gCxsG5///B0G5CqkyU9o1180UospGrAJrRTJ1rvTUd3lv8xqa4qbpCWX6OavILmQtRDM
         vZzgUw46silk1Fnq+0NKsHvAW/2R3KjWWbDopwaQtm1yaXSAJUhCA2Xotug0IuExDflS
         cLAbaLrnJzTvkmc98cdQCYEhAPnnRR6QRbdvJ9yfL+xobhi1dStweB+NE1+V5u+PcyBz
         Yg3g==
X-Gm-Message-State: AOJu0Yxk+xEfNauHXg4bKck1yUY6J9kyjOS4NEdIvaV0vDA03RLEtohY
        LRt8GdLslWNmjFCAlPJ9Jgg=
X-Google-Smtp-Source: AGHT+IGEXiZXOYHWyW1BNez1YEG58AWmtPf5pJ4HY0WudDf4UY3bmILtstoF6ghA6t0iYA+hsQLZFw==
X-Received: by 2002:a05:6a20:914e:b0:159:c2d0:9fc6 with SMTP id x14-20020a056a20914e00b00159c2d09fc6mr3876841pzc.8.1695237294679;
        Wed, 20 Sep 2023 12:14:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:14:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        David Howells <dhowells@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 03/13] fs: Restore kiocb.ki_hint
Date:   Wed, 20 Sep 2023 12:14:28 -0700
Message-ID: <20230920191442.3701673-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restore support for passing write hint information from a filesystem to the
block layer. Write hint information can be set via fcntl(fd, F_SET_RW_HINT,
&hint). This patch reverts commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c                    |  1 +
 fs/cachefiles/io.c          |  2 ++
 fs/f2fs/file.c              |  6 ++++++
 include/linux/fs.h          | 12 ++++++++++++
 include/trace/events/f2fs.h |  5 ++++-
 io_uring/rw.c               |  1 +
 6 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index a4c2a6bac72c..a09743049738 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1466,6 +1466,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_flags = req->ki_filp->f_iocb_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
+	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
 		/*
 		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..ad2870748c15 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -138,6 +138,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos + skipped;
 	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
 	ki->object		= object;
@@ -306,6 +307,7 @@ int __cachefiles_write(struct cachefiles_object *object,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos;
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
 	ki->start		= start_pos;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..9dc0e06c38ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4634,8 +4634,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const bool do_opu = f2fs_lfs_mode(sbi);
+	const int whint_mode = F2FS_OPTION(sbi).whint_mode;
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
+	const enum rw_hint hint = iocb->ki_hint;
 	unsigned int dio_flags;
 	struct iomap_dio *dio;
 	ssize_t ret;
@@ -4668,6 +4670,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		if (do_opu)
 			f2fs_down_read(&fi->i_gc_rwsem[READ]);
 	}
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
@@ -4690,6 +4694,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret = iomap_dio_complete(dio);
 	}
 
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = hint;
 	if (do_opu)
 		f2fs_up_read(&fi->i_gc_rwsem[READ]);
 	f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba2c5c90af6d..8ebed22dfc88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -374,6 +374,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
+	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
 	union {
 		/*
@@ -2143,11 +2144,21 @@ static inline enum rw_hint file_write_hint(struct file *file)
 	return file_inode(file)->i_write_hint;
 }
 
+static inline u16 ki_hint_validate(enum rw_hint hint)
+{
+	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;
+
+	if (hint <= max_hint)
+		return hint;
+	return 0;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = filp->f_iocb_flags,
+		.ki_hint = ki_hint_validate(file_write_hint(filp)),
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
@@ -2158,6 +2169,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = kiocb_src->ki_flags,
+		.ki_hint = kiocb_src->ki_hint,
 		.ki_ioprio = kiocb_src->ki_ioprio,
 		.ki_pos = kiocb_src->ki_pos,
 	};
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..9247ad58034e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -946,6 +946,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__field(ino_t,	ino)
 		__field(loff_t,	ki_pos)
 		__field(int,	ki_flags)
+		__field(u16,    ki_hint)
 		__field(u16,	ki_ioprio)
 		__field(unsigned long,	len)
 		__field(int,	rw)
@@ -956,16 +957,18 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->ino		= inode->i_ino;
 		__entry->ki_pos		= iocb->ki_pos;
 		__entry->ki_flags	= iocb->ki_flags;
+		__entry->ki_hint	= iocb->ki_hint;
 		__entry->ki_ioprio	= iocb->ki_ioprio;
 		__entry->len		= len;
 		__entry->rw		= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->ki_pos,
 		__entry->len,
 		__entry->ki_flags,
+		__entry->ki_hint,
 		__entry->ki_ioprio,
 		__entry->rw)
 );
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8c822fa7980..c41ae6654116 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -677,6 +677,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 		req->flags |= io_file_get_flags(file);
 
 	kiocb->ki_flags = file->f_iocb_flags;
+	kiocb->ki_hint = file_inode(file)->i_write_hint;
 	ret = kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
