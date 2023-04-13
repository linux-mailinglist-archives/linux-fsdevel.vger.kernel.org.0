Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22C46E0924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDMIls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDMIln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8D8A7B;
        Thu, 13 Apr 2023 01:41:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y6so13197715plp.2;
        Thu, 13 Apr 2023 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375296; x=1683967296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBtr6w3LmrLfDm0HFp2sgZ7xfGoiIZQUmW+EauYMs9A=;
        b=BDGNmuzZyklkg8kVonj+rZZsFcgodAi0p4ASdrAF8ZVLRH1yBX6VCyYpdoHX3o4fdh
         jUzO4bUl79nOXd0nBtl4JLe5FsmGlSYKoiZtMYR5Kr9DvClgLTeHvWRdGsWMw8ybtkf1
         0xq9M9D52DVE/rufwH7AVL7seJOPL9CoZJkiT3zLAQb+wn5HLB2ji4B/8SIvRyUJxtpg
         tCZ1N9ZiaKFvd9gxB7Ba1BtSH4SmouHPUcoWxrGXLfiUEN6jjS7ysIkox/b7mLqbPMsL
         n/z/Ut6pJ0iAYPin2d7pYb+4lZxdv/84mY71PK9jM7+r/cL97BNXic3wr4KalEXqSrMG
         5xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375296; x=1683967296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBtr6w3LmrLfDm0HFp2sgZ7xfGoiIZQUmW+EauYMs9A=;
        b=bBzsdqeNvEkaB9mtTMG9WBhN31GNHFRQ35yZEHVgEW2DSjxcidhQuDH4YmOK8NhIoJ
         +obvnGS/nlM5oZM4EuE0/e/5Q8B0J3RSNb7oUOuFA3EzXVnTrZcaZVIgur2QMdSH+5A8
         IO/+MJxTPL9JTx5zdOfIKn7Xtay4a2XO1LGEdsJHPPX6zkvNo4YrUM6KjI5Vkn9Yl14M
         WsAQFgfdHumjGIYQIbQM5xyaUU17fLVrv5IPW5do5or8yiA2/wTVN68DtBo5ikGOWAZ5
         dRDnDBOrJhEB1D04NXlDuhVh8eJGz/mg8tgE7EnjloyiuHVvZgTH1jeR6y8a97xG2clk
         Jlgg==
X-Gm-Message-State: AAQBX9fQR9r8WQYSyI3iPrVQNf21JeoqUUYcYireYORbXZAhtoaESpsP
        +Yb1FyTkg8C49t9KHuVcm5aeodaa6kI=
X-Google-Smtp-Source: AKy350bx1huk4mnk0pUhaUZc1wM36vCKExLJTC1lFr14xqMHY3tOJtmMyM+B6p+SGE/unK+oSXHmlw==
X-Received: by 2002:a05:6a20:144c:b0:ec:6882:f04b with SMTP id a12-20020a056a20144c00b000ec6882f04bmr988957pzi.8.1681375295995;
        Thu, 13 Apr 2023 01:41:35 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:35 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 07/10] ext2: Add direct-io trace points
Date:   Thu, 13 Apr 2023 14:10:29 +0530
Message-Id: <4487ba6fc44e37903a81ddf55a24a865ed9255e2.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
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

This patch adds the trace point to ext2 direct-io apis
in fs/ext2/file.c

Here is how the output looks like
         xfs_io-4099  [004]    81.431800: ext2_dio_write_iter_start: dev 7:7 ino 0xc isize 0x4000 pos 0x4000 count 4096 flags DIRECT aio 0 ret=0
         xfs_io-4099  [004]    81.432002: ext2_dio_write_end_io: dev 7:7 ino 0xc isize 0x5000 pos 0x4000 count 4096 flags DIRECT aio 0 ret=0
         xfs_io-4099  [004]    81.432014: ext2_dio_write_iter_dio_end: dev 7:7 ino 0xc isize 0x5000 pos 0x5000 count 0 flags DIRECT aio 0 ret=4096
aio-dio-fcntl-r-4103  [005]    81.461123: ext2_dio_write_iter_start: dev 7:7 ino 0xc isize 0x400 pos 0x200 count 512 flags DIRECT|WRITE aio 1 ret=0
aio-dio-fcntl-r-4103  [005]    81.462099: ext2_dio_write_end_io: dev 7:7 ino 0xc isize 0x400 pos 0x200 count 512 flags DIRECT|WRITE aio 1 ret=0
aio-dio-fcntl-r-4103  [005]    81.462133: ext2_dio_write_iter_dio_end: dev 7:7 ino 0xc isize 0x400 pos 0x400 count 0 flags DIRECT|WRITE aio 1 ret=512

Reported-and-tested-by: Disha Goel <disgoel@linux.ibm.com>
[Need to add CFLAGS_trace for fixing unable to find trace file problem]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/Makefile |  5 ++-
 fs/ext2/file.c   | 10 +++++-
 fs/ext2/trace.c  |  6 ++++
 fs/ext2/trace.h  | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
index 311479d864a7..8860948ef9ca 100644
--- a/fs/ext2/Makefile
+++ b/fs/ext2/Makefile
@@ -6,7 +6,10 @@
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
 ext2-y := balloc.o dir.o file.o ialloc.o inode.o \
-	  ioctl.o namei.o super.o symlink.o
+	  ioctl.o namei.o super.o symlink.o trace.o
+
+# For tracepoints to include our trace.h from tracepoint infrastructure
+CFLAGS_trace.o := -I$(src)
 
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 243395616599..902eaabc5c62 100644
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
 
+	trace_ext2_dio_read_begin(iocb, to, 0);
 	inode_lock_shared(inode);
 	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
+	trace_ext2_dio_read_end(iocb, to, ret);
 
 	return ret;
 }
@@ -199,6 +202,7 @@ static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 		mark_inode_dirty(inode);
 	}
 out:
+	trace_ext2_dio_write_endio(iocb, size, error);
 	return error;
 }
 
@@ -215,7 +219,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	unsigned long blocksize = inode->i_sb->s_blocksize;
 	loff_t offset = iocb->ki_pos;
 	loff_t count = iov_iter_count(from);
+	ssize_t status = 0;
 
+	trace_ext2_dio_write_begin(iocb, from, 0);
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
+		trace_ext2_dio_write_buff_end(iocb, from, status);
+	trace_ext2_dio_write_end(iocb, from, ret);
 	return ret;
 }
 
diff --git a/fs/ext2/trace.c b/fs/ext2/trace.c
new file mode 100644
index 000000000000..b01cdf6526fd
--- /dev/null
+++ b/fs/ext2/trace.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "ext2.h"
+#include <linux/uio.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/ext2/trace.h b/fs/ext2/trace.h
new file mode 100644
index 000000000000..36deeaa8cfe2
--- /dev/null
+++ b/fs/ext2/trace.h
@@ -0,0 +1,94 @@
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
+		__field(u64,	count)
+		__field(int,	ki_flags)
+		__field(bool,	aio)
+		__field(int,	ret)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+		__entry->ret = ret;
+	),
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx count %llu flags %s aio %d ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __entry->count,
+		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
+		  __entry->aio,
+		  __entry->ret)
+);
+
+#define DEFINE_DIO_RW_EVENT(name)						\
+DEFINE_EVENT(ext2_dio_class, name,					\
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter, int ret),	\
+	TP_ARGS(iocb, iter, ret))
+DEFINE_DIO_RW_EVENT(ext2_dio_write_begin);
+DEFINE_DIO_RW_EVENT(ext2_dio_write_end);
+DEFINE_DIO_RW_EVENT(ext2_dio_write_buff_end);
+DEFINE_DIO_RW_EVENT(ext2_dio_read_begin);
+DEFINE_DIO_RW_EVENT(ext2_dio_read_end);
+
+TRACE_EVENT(ext2_dio_write_endio,
+	TP_PROTO(struct kiocb *iocb, loff_t size, int ret),
+	TP_ARGS(iocb, size, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(loff_t, size)
+		__field(int,	ki_flags)
+		__field(bool,	aio)
+		__field(int,	ret)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->size = size;
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+		__entry->ret = ret;
+	),
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx size %lld flags %s aio %d ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __entry->size,
+		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
+		  __entry->aio,
+		  __entry->ret)
+);
+
+#endif /* _EXT2_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.39.2

