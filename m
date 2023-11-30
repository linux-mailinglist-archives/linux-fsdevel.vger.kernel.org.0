Return-Path: <linux-fsdevel+bounces-4300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BB7FE701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857AF1C20A43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9619134BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199E10F9;
	Wed, 29 Nov 2023 17:33:38 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2857670af8cso526742a91.0;
        Wed, 29 Nov 2023 17:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308018; x=1701912818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emRzA7eDfcJiBAI1RimyMo0ifL5e30squgruQiizoQ0=;
        b=GWPS6T9S2l9YXkrKnuJgzthyIL2/ArcmuY2vEr+xiFRWWho4oVLeVVpita1GynF/gc
         l9eQyj/aYq9IWbocJK04IrSix5bVPVj+G4k67pCZAK/Ky287MKVLsnAXJ/6xrm1nKnLh
         fXsRjsp1OsOcfXCbbR7VQ4eIR/tyQP8G8xqlaOC6JDdh6Se4lPjY6OEzdpdWKfI6Y75y
         N7FD1kxFfSRivHQj/NzBaxuBKjHbqnJ+0dGzwGk7KqqO0dCuif79xdeqy8DYnNjLniz5
         eaZhaepkV2frYJkukR56ofXQ6dPVJynoO4dLldEvFD1GYgJDcji8DRBPVWQoX6AEEEUZ
         nfsA==
X-Gm-Message-State: AOJu0Yx4A31ETJPJP35i1cHCoBCbRUVCMCj87o7MRnHicJzL+q1H6ujB
	JErAfl0UWmueE5k4CeJKjbE=
X-Google-Smtp-Source: AGHT+IH9uT88xYII6229QXCYlqySVQYsAavBQZHnUx8lJZoOptRY2aTXQ4My7gRtSUVZELvWKtk7Ig==
X-Received: by 2002:a17:90b:1d8c:b0:285:b7b9:dcd4 with SMTP id pf12-20020a17090b1d8c00b00285b7b9dcd4mr15979587pjb.16.1701308017598;
        Wed, 29 Nov 2023 17:33:37 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:37 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v5 05/17] fs: Restore kiocb.ki_hint
Date: Wed, 29 Nov 2023 17:33:10 -0800
Message-ID: <20231130013322.175290-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore support for passing file and/or inode write hints to the code
that processes struct kiocb. This patch reverts commit 41d36a9f3e53
("fs: remove kiocb.ki_hint").

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c                    | 1 +
 fs/f2fs/file.c              | 6 ++++++
 include/linux/fs.h          | 3 +++
 include/trace/events/f2fs.h | 5 ++++-
 io_uring/rw.c               | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index f8589caef9c1..a9dc84a984db 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1466,6 +1466,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_flags = req->ki_filp->f_iocb_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
+	req->ki_hint = file_write_hint(req->ki_filp);
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
 		/*
 		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e50363583f01..6ffafa29f1a2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4644,8 +4644,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
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
@@ -4678,6 +4680,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		if (do_opu)
 			f2fs_down_read(&fi->i_gc_rwsem[READ]);
 	}
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
@@ -4700,6 +4704,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret = iomap_dio_complete(dio);
 	}
 
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = hint;
 	if (do_opu)
 		f2fs_up_read(&fi->i_gc_rwsem[READ]);
 	f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a6e0c4b5a72b..acc0cbab93dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -362,6 +362,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
+	u8			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
 	union {
 		/*
@@ -2176,6 +2177,7 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = filp->f_iocb_flags,
+		.ki_hint = file_write_hint(filp),
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
@@ -2186,6 +2188,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = kiocb_src->ki_flags,
+		.ki_hint = kiocb_src->ki_hint,
 		.ki_ioprio = kiocb_src->ki_ioprio,
 		.ki_pos = kiocb_src->ki_pos,
 	};
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..eb9ba109949e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -946,6 +946,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__field(ino_t,	ino)
 		__field(loff_t,	ki_pos)
 		__field(int,	ki_flags)
+		__field(u16,	ki_hint)
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
index 64390d4e20c1..24a6122c837b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -994,6 +994,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		kfree(iovec);
 		return ret;
 	}
+	kiocb->ki_hint = file_write_hint(req->file);
 	req->cqe.res = iov_iter_count(&s->iter);
 
 	if (force_nonblock) {

