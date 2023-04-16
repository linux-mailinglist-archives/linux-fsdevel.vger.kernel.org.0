Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371CD6E36F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjDPKJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDPKJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A481BDA;
        Sun, 16 Apr 2023 03:09:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kh6so21157141plb.0;
        Sun, 16 Apr 2023 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639756; x=1684231756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZTgcuhr1rtewOZ71zdiwcVt6maLiUIed7GaPq7jpvg=;
        b=jIfgbLd3eDjBVHi7afvMDbrZkCPy450MhBLL/unxULJaogtNRM4nh7JDigJTR11rLw
         Quufw5zWJiD5mr8LImfjW06yaaHDYIR39p0eoZp1gXMvsTiXdLT8dBD5yn2gg9lqdtHc
         LnpxSq9xLymbQ5Zn+MlMuYqyjcS29WEkLRQZp5x/fgzJ5LCP3/vyOcvR68Jly+wcza44
         ngjVXhdm6e+sYaTuSpzAhsvEXHtSioMs/8tPCwAYLnxiwC0iwsNd611Wo0vAdBvaxWWv
         iRbRPzoAYmp560TbG+EW80kGu2LCr1OUtAIeHfTRwnarPPtXVzmgCYLyB30DPj7ES0aP
         ruhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639756; x=1684231756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZTgcuhr1rtewOZ71zdiwcVt6maLiUIed7GaPq7jpvg=;
        b=QL/q0LgY+FHEd74GrTehd1qmFBvly6MwPiLiEPfuukSp+5HDeGLuBe2LWHmy0ZyFDh
         5f//qWgY3aKgn+EaM0Fx0FRhnqU1Mxg6M2z0i1WYm6neCr728qI3xwVRYK+ecmv1Ryck
         6c/cjj0kQ4qK0bWxzz30WPXsIJ45Uqbd5oJ5tsTjuIYgplJsdQFfSs1b2fIwGQvg7/FW
         uzfvg+Ii5IlJ1XNZIukPj4NZc0HL942U4iFA0KfPppyJKLiXK/kYBxp/Xjx1iKTGmfJ9
         2CIWuyqu0TO4CZ6FHDlYmuKeZYQh/ge5dcIgc5ySoaMwbWY0lHUu+smHy6EZQkQZ8D53
         YQwA==
X-Gm-Message-State: AAQBX9dAZflBQNCpaxOhnp1PwJERSmSonjs8rp3qXrdAJkMK4FpS4IVV
        qqUonimQePXjzlh7zbKkHhj8O+oF99k=
X-Google-Smtp-Source: AKy350bEGreHfSJhe6hN6NSRfFqN54BS7/i6mn4lmV/uauihT7ySK70xVjkq9XMVaTd1fywXCywZsA==
X-Received: by 2002:a05:6a20:9143:b0:ef:a85b:c715 with SMTP id x3-20020a056a20914300b000efa85bc715mr524907pzc.1.1681639755946;
        Sun, 16 Apr 2023 03:09:15 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:15 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv5 7/9] ext2: Add direct-io trace points
Date:   Sun, 16 Apr 2023 15:38:42 +0530
Message-Id: <c6b4d657cc7347b38b550dc549be6ce93972b07f.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the trace point to ext2 direct-io apis
in fs/ext2/file.c

Here is how the output looks like

        a.out-467865 [006]  6758.170968: ext2_dio_write_begin: dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT|WRITE aio 1 ret 0
        a.out-467865 [006]  6758.171061: ext2_dio_write_end:   dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 0 flags DIRECT|WRITE aio 1 ret -529
kworker/3:153-444162 [003]  6758.171252: ext2_dio_write_endio: dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT|WRITE aio 1 ret 0
        a.out-468222 [001]  6761.628924: ext2_dio_read_begin:  dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT aio 1 ret 0
        a.out-468222 [001]  6761.629063: ext2_dio_read_end:    dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 0 flags DIRECT aio 1 ret -529
        a.out-468428 [005]  6763.937454: ext2_dio_write_begin: dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT aio 0 ret 0
        a.out-468428 [005]  6763.937829: ext2_dio_write_endio: dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT aio 0 ret 0
        a.out-468428 [005]  6763.937847: ext2_dio_write_end:   dev 7:12 ino 0xe isize 0x1000 pos 0x1000 len 0 flags DIRECT aio 0 ret 4096
        a.out-468609 [000]  6765.702878: ext2_dio_read_begin:  dev 7:12 ino 0xe isize 0x1000 pos 0x0 len 4096 flags DIRECT aio 0 ret 0
        a.out-468609 [000]  6765.703243: ext2_dio_read_end:    dev 7:12 ino 0xe isize 0x1000 pos 0x1000 len 0 flags DIRECT aio 0 ret 4096

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
index 704abe0a79cb..c3e8d8cc6792 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -29,6 +29,7 @@
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "trace.h"
 
 #ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -170,9 +171,11 @@ static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file->f_mapping->host;
 	ssize_t ret;
 
+	trace_ext2_dio_read_begin(iocb, to, 0);
 	inode_lock_shared(inode);
 	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
+	trace_ext2_dio_read_end(iocb, to, ret);
 
 	return ret;
 }
@@ -200,6 +203,7 @@ static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 		mark_inode_dirty(inode);
 	}
 out:
+	trace_ext2_dio_write_endio(iocb, size, error);
 	return error;
 }
 
@@ -216,7 +220,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	unsigned long blocksize = inode->i_sb->s_blocksize;
 	loff_t offset = iocb->ki_pos;
 	loff_t count = iov_iter_count(from);
+	ssize_t status = 0;
 
+	trace_ext2_dio_write_begin(iocb, from, 0);
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
@@ -244,7 +250,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* handle case for partial write and for fallback to buffered write */
 	if (ret >= 0 && iov_iter_count(from)) {
 		loff_t pos, endbyte;
-		ssize_t status;
 		int ret2;
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
@@ -270,6 +275,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
index 000000000000..7d230e13576e
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
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter, ssize_t ret),
+	TP_ARGS(iocb, iter, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(size_t,	count)
+		__field(int,	ki_flags)
+		__field(bool,	aio)
+		__field(ssize_t, ret)
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
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx len %zu flags %s aio %d ret %zd",
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
+#define DEFINE_DIO_RW_EVENT(name)					  \
+DEFINE_EVENT(ext2_dio_class, name,					  \
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter, ssize_t ret), \
+	TP_ARGS(iocb, iter, ret))
+DEFINE_DIO_RW_EVENT(ext2_dio_write_begin);
+DEFINE_DIO_RW_EVENT(ext2_dio_write_end);
+DEFINE_DIO_RW_EVENT(ext2_dio_write_buff_end);
+DEFINE_DIO_RW_EVENT(ext2_dio_read_begin);
+DEFINE_DIO_RW_EVENT(ext2_dio_read_end);
+
+TRACE_EVENT(ext2_dio_write_endio,
+	TP_PROTO(struct kiocb *iocb, ssize_t size, int ret),
+	TP_ARGS(iocb, size, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(ssize_t, size)
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
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx len %zd flags %s aio %d ret %d",
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

