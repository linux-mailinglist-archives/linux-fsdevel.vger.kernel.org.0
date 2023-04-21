Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998F96EA785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjDUJrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjDUJr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5821B774;
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517c840f181so1195943a12.3;
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070409; x=1684662409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqGwn0BPG7633DzJyGxGiG7IB9Aqjhen1X5TwksmL7M=;
        b=ZFbuyvl4x0Qax8eBtg1CXCRqjYmDIZq2bA3RgiRBBMxF8uJn+dognFbdXYiX/5WHBG
         uHn1TT93TkmmbHSRmG3C7wQQ516YqRn2MWjgixQ/C7F1oKu5lGhvKkQu9UMmONgnghID
         lr8SnB78qe6YhFum5StVZDU6VV0LChdqwzklUI3JyZZ+6BcMTN3ypsFUpFeaRW9ped+0
         sG3bSVI+yoTdsCTEPPfEsfvNI0IEsFpeckLbG8pmnroM529LNEXY34Mb8smLpsd/gcLs
         gEyudJ9+YURMRFKGEdiXQ9YD2JgXyWnaR9qOqndrZzI4FLUQ+Jhu7U7l7UqoaLk4Sv4t
         rVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070409; x=1684662409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqGwn0BPG7633DzJyGxGiG7IB9Aqjhen1X5TwksmL7M=;
        b=G3flNzZPI6nGR5BlBNDq/0jd3fZ3/txcwlMOOqJdS+en5WNkRnlWO4X8CYRDjbGSB6
         ZZPJJWBXd110YWb00a660Di7xDGDOR81cQ6oBcSSl/ihwRcnZzlxxYFZMdW8OAafARUB
         zbnLkXxe80qQ4b//3WjVEqjOtLZAwmFpvXqmEL7HisBVkwSAfN69wyFJjKzrmiyWqQ6m
         Jgm7FtM0R54OfFyTfm3GS1/7YvOxHod3cwVJLicyccebpRATWrbTwNkOZDBUo4uVWwKJ
         IMVGePtP+nYi94d3RxhfuvUAvqiAnpri98XHIHaZ/MTHI/H1F6OjadhJt5N+lLIomX3K
         bY6A==
X-Gm-Message-State: AAQBX9f4ZL6YEG/KsFOWIHpK4MOqBjNqz+7KtKkUJOO6XVm5+6O/P2gi
        EDVPjw6NcYaHh2r14kWULL77x+pLJ8c=
X-Google-Smtp-Source: AKy350aSXhEjddHY63U1ZSLZxQo+UE5X/cKsNojNDUnjHEsXCWUU9uS/PpOPzt9B8efbsvBASCQZNw==
X-Received: by 2002:a05:6a20:4426:b0:da:7036:dfa4 with SMTP id ce38-20020a056a20442600b000da7036dfa4mr7162612pzb.32.1682070409430;
        Fri, 21 Apr 2023 02:46:49 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:49 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 7/9] ext2: Add direct-io trace points
Date:   Fri, 21 Apr 2023 15:16:17 +0530
Message-Id: <b8b0897fa2b273a448d7b4ba7317357ac73c08bc.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
References: <cover.1682069716.git.ritesh.list@gmail.com>
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
index 98add36c1a59..7a32f202908e 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -29,6 +29,7 @@
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "trace.h"
 
 #ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -168,9 +169,11 @@ static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file->f_mapping->host;
 	ssize_t ret;
 
+	trace_ext2_dio_read_begin(iocb, to, 0);
 	inode_lock_shared(inode);
 	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
+	trace_ext2_dio_read_end(iocb, to, ret);
 
 	return ret;
 }
@@ -198,6 +201,7 @@ static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 		mark_inode_dirty(inode);
 	}
 out:
+	trace_ext2_dio_write_endio(iocb, size, error);
 	return error;
 }
 
@@ -214,7 +218,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	unsigned long blocksize = inode->i_sb->s_blocksize;
 	loff_t offset = iocb->ki_pos;
 	loff_t count = iov_iter_count(from);
+	ssize_t status = 0;
 
+	trace_ext2_dio_write_begin(iocb, from, 0);
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
@@ -242,7 +248,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* handle case for partial write and for fallback to buffered write */
 	if (ret >= 0 && iov_iter_count(from)) {
 		loff_t pos, endbyte;
-		ssize_t status;
 		int ret2;
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
@@ -268,6 +273,9 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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

