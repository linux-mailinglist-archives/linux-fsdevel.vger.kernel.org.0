Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486076DD18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDKFWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDKFWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47A26B8;
        Mon, 10 Apr 2023 22:22:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ke16so6713760plb.6;
        Mon, 10 Apr 2023 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190552; x=1683782552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojYIQRhoSpmzdsqEiiJkGhsA9uyk5BYxcjTL2AardMY=;
        b=QyJMXe41VZNwOySGpwFcaDKNux7kerK3jEuT1kGxKgxOmkm/OLGUbc4RPUg2+K7Gml
         DgxoehC/Xyttw7+AkB7L3EB8TRK0v0QZhDa9wPuO7I5240fAIaiXAzdCTA00daT3gf2B
         iQYEopM3yYasF1DahZIWkouuXg9c6OTmI5Xkr3ANSkZmsi3D9kF1dFsrNUAVi5I0oCp+
         5NJ7f/Cemfb1LRiZ47r6zkuPfKIfOORdXMdggTDzXAbjcsWZpKXPr3GmbcG3Q5JR+Xrh
         j1rO9Rbztxnmk8eOW8CfL7ggYP9qJwI1H6KSTOiFb3g+zX08da61mb+kQ8ctI6/9lhaI
         6IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190552; x=1683782552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojYIQRhoSpmzdsqEiiJkGhsA9uyk5BYxcjTL2AardMY=;
        b=Uvxv73D9kWvfoKZVzCZSG87wstNQQSCn50D2C0lD47MdBStRkkSpOLUeanH0aLPOjf
         k4huFCTLo90jf9V7qJosEoh6jpqBCDflOmEemQGDxTLzGiapiQo0jJr8bxYk0y6htIFS
         K4WpFq4iAuoXeLRBqM/SDki3/nRRyYZ+nHnP24FdpDyr2yCOilAZCavbgxTthH98YRcb
         0Hd/RCZuKkrhSYHTezCVsfgNbvQrQdAZ0Dc+o9P7FjpgACgHHQCG28VVgaJq1+LVhXbI
         Ur7oKqLh+P1uzcu4aGTp5OeTlavq/0wfNL4Bm7+/haeJT+j3/ZkhUIFVh1/53XI8x0Dx
         UdNg==
X-Gm-Message-State: AAQBX9eqmRLQF2RMdtP5uXE9rw+X53/7kNdQCfORLGqwszqu6EKlzFgB
        cSKj+oEVPmCLCHlBCTZP8q10YUoXGug=
X-Google-Smtp-Source: AKy350av0hb+Nga/AvXOB7YwDOu9jUmomYknp3P5CIGEOca33n94lZNJoD9VMfJDqHYhQOQL/V1WnQ==
X-Received: by 2002:a17:90b:370a:b0:237:5a3c:e86c with SMTP id mg10-20020a17090b370a00b002375a3ce86cmr2262282pjb.24.1681190551900;
        Mon, 10 Apr 2023 22:22:31 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:31 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 8/8] ext2: Add direct-io trace points
Date:   Tue, 11 Apr 2023 10:51:56 +0530
Message-Id: <f9825fab612761bee205046ce6e6e4caf25642ee.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the trace point to ext2 direct-io apis
in fs/ext2/file.c

Here is how the output looks like
         xfs_io-4099  [004]    81.431800: ext2_dio_write_iter_start: dev 7:7 ino 0xc isize 0x4000 pos 0x4000 count 4096 flags DIRECT aio 0 ret=0
         xfs_io-4099  [004]    81.432002: ext2_dio_write_end_io: dev 7:7 ino 0xc isize 0x5000 pos 0x4000 count 4096 flags DIRECT aio 0 ret=0
         xfs_io-4099  [004]    81.432014: ext2_dio_write_iter_dio_end: dev 7:7 ino 0xc isize 0x5000 pos 0x5000 count 0 flags DIRECT aio 0 ret=4096
aio-dio-fcntl-r-4103  [005]    81.461123: ext2_dio_write_iter_start: dev 7:7 ino 0xc isize 0x400 pos 0x200 count 512 flags DIRECT|WRITE aio 1 ret=0
aio-dio-fcntl-r-4103  [005]    81.462099: ext2_dio_write_end_io: dev 7:7 ino 0xc isize 0x400 pos 0x200 count 512 flags DIRECT|WRITE aio 1 ret=0
aio-dio-fcntl-r-4103  [005]    81.462133: ext2_dio_write_iter_dio_end: dev 7:7 ino 0xc isize 0x400 pos 0x400 count 0 flags DIRECT|WRITE aio 1 ret=512

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/Makefile |  2 +-
 fs/ext2/file.c   | 10 +++++++-
 fs/ext2/trace.c  |  5 ++++
 fs/ext2/trace.h  | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
index 311479d864a7..ae600f011826 100644
--- a/fs/ext2/Makefile
+++ b/fs/ext2/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
 ext2-y := balloc.o dir.o file.o ialloc.o inode.o \
-	  ioctl.o namei.o super.o symlink.o
+	  ioctl.o namei.o super.o symlink.o trace.o
 
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 3511ef85379f..322bfa2d5a28 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -28,6 +28,7 @@
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "trace.h"
 
 #ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -169,9 +170,11 @@ static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file->f_mapping->host;
 	ssize_t ret;
 
+	trace_ext2_dio_read_iter_start(iocb, to, 0);
 	inode_lock_shared(inode);
 	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
+	trace_ext2_dio_read_iter_end(iocb, to, ret);
 
 	return ret;
 }
@@ -199,6 +202,7 @@ static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 		mark_inode_dirty(inode);
 	}
 
+	trace_ext2_dio_write_end_io(iocb, NULL, size);
 	return 0;
 }
 
@@ -215,7 +219,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	unsigned long blocksize = inode->i_sb->s_blocksize;
 	loff_t offset = iocb->ki_pos;
 	loff_t count = iov_iter_count(from);
+	ssize_t status = 0;
 
+	trace_ext2_dio_write_iter_start(iocb, from, 0);
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
@@ -243,7 +249,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* handle case for partial write and for fallback to buffered write */
 	if (ret >= 0 && iov_iter_count(from)) {
 		loff_t pos, endbyte;
-		ssize_t status;
 		int ret2;
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
@@ -269,6 +274,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 out_unlock:
 	inode_unlock(inode);
+	if (status)
+		trace_ext2_dio_write_iter_buff_end(iocb, from, status);
+	trace_ext2_dio_write_iter_dio_end(iocb, from, ret);
 	return ret;
 }
 
diff --git a/fs/ext2/trace.c b/fs/ext2/trace.c
new file mode 100644
index 000000000000..2d5a3a5109f0
--- /dev/null
+++ b/fs/ext2/trace.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "ext2.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/ext2/trace.h b/fs/ext2/trace.h
new file mode 100644
index 000000000000..26b53de86f00
--- /dev/null
+++ b/fs/ext2/trace.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ext2
+
+#if !defined(_EXT2_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _EXT2_TRACE_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(ext2_dio_class,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter, int ret),
+	TP_ARGS(iocb, iter, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(size_t,	count)
+		__field(int,	ki_flags)
+		__field(int,	aio)
+		__field(int,	ret)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->count = iter ? iov_iter_count(iter) : ret;
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+		__entry->ret = iter ? ret : 0;
+	),
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx count %ld flags %s aio %d ret=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __entry->count,
+		  __print_flags(__entry->ki_flags, "|", IOCB_STRINGS),
+		  __entry->aio,
+		  __entry->ret)
+)
+
+#define DEFINE_RW_EVENT(name)						\
+DEFINE_EVENT(ext2_dio_class, name,					\
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter, int ret),	\
+	TP_ARGS(iocb, iter, ret))
+DEFINE_RW_EVENT(ext2_dio_write_iter_start);
+DEFINE_RW_EVENT(ext2_dio_write_iter_dio_end);
+DEFINE_RW_EVENT(ext2_dio_write_iter_buff_end);
+DEFINE_RW_EVENT(ext2_dio_write_end_io);
+DEFINE_RW_EVENT(ext2_dio_read_iter_start);
+DEFINE_RW_EVENT(ext2_dio_read_iter_end);
+
+#endif /* _EXT2_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.39.2

