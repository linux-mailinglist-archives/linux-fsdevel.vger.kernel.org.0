Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB26E0927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDMImA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDMIlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0039004;
        Thu, 13 Apr 2023 01:41:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id la3so14113405plb.11;
        Thu, 13 Apr 2023 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375304; x=1683967304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTChYixzPpvW+Osfv8JLBdej0R3AkyKJ59o5qBXi+Bs=;
        b=bWxFRrIyPxbR08jluz8taFFCqCP6eu+DnAUD12Hy21HeB5IVD+cskHwnJltlhL0+J2
         qAWOPg23mknKl3/3BS1u+8LeGl3yGtTPc+5COXkY0jCmThMSxnvq1djZeMacs0hnbTd3
         F54zhxFyDGO1W5z93FCbrkCG2tRIZTejtzmLms05cMB8AFa2YPGfStWh/3YVusDQwVMP
         364KDMjNOZRZoEfVm/DsDvywEBcyDReSmSb0ChuieT+DCRvJ3rVV7fVP0MciyGK1Zwbs
         5SMkzKRIarN1btfyvhBSHn227GAiX8rcEBmzcNGbeJksle5ACUV4Vc519c7L2dv0HKc9
         exrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375304; x=1683967304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTChYixzPpvW+Osfv8JLBdej0R3AkyKJ59o5qBXi+Bs=;
        b=cuLJCQH1cHjeOAJzag4lbXhm1GWt93qAbzyU4Vfyq18Gu5Wc3lun6FnGQSlFD6G3MA
         ePw7Tzqf8QI6vpoL9G0qnB8fJM+qNrSop41FQr3o8rwmCOSeiA6Q9q00OzYolvdAEW2R
         aHmRdQSrRb/j43lOGqsnqnqsn9tTlQTqDsDQQzrHtRsshu/YbMA7lDwI+7fsufjemo+J
         w4tkAg/r+ScEwZ6aqJDaVAMgHpORQhQSevr+1H46Qy3WJ2KXRm2wtL8WBpy/cP9JRLp1
         Wg1Tt23lFPTyb89+0vd3GC3yYZePhX1Ka/9MlriRcz3KxCxsuSwvf6ei15qooDaRdNla
         DuFg==
X-Gm-Message-State: AAQBX9eMKFGpx93G04Xg6fXhjA4kOU3YVIWHUtXfP7pjQFXtGag8jS9K
        ui9pTnhVgdvcCnZG+2Z9fxsatmpygm4=
X-Google-Smtp-Source: AKy350ZU+ksTt5nfOqLzVGCovYL0As2Gk4LT1X3+hSEWe2404mJTa1uzfNkZ1/t/PTnM0ItRgI44TA==
X-Received: by 2002:a05:6a20:4f27:b0:eb:a2c8:b6d1 with SMTP id gi39-20020a056a204f2700b000eba2c8b6d1mr1281591pzb.24.1681375304347;
        Thu, 13 Apr 2023 01:41:44 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:44 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 10/10] iomap: Add trace points for DIO path
Date:   Thu, 13 Apr 2023 14:10:32 +0530
Message-Id: <93ab8386c4620395c5e674a7930506895fc758ef.1681365596.git.ritesh.list@gmail.com>
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

This patch adds trace point events for iomap DIO path.

<e.g. iomap dio trace>
     xfs_io-8815  [000]   526.790418: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x0 pos 0x0 count 4096 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 0
     xfs_io-8815  [000]   526.790978: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x1000 pos 0x1000 flags DIRECT aio 0 error 0 ret 4096
     xfs_io-8815  [000]   526.790988: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x1000 pos 0x1000 count 0 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 4096
        fsx-8827  [005]   526.939345: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 61440 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret 0
        fsx-8827  [005]   526.939459: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 0 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret -529
ksoftirqd/5-41    [005]   526.939564: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x922f8 pos 0x5e000 flags NOWAIT|DIRECT|ALLOC_CACHE aio 1 error 0 ret 61440

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c |  3 ++
 fs/iomap/trace.c     |  1 +
 fs/iomap/trace.h     | 90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5871956ee880..bb7a6dfbc8b3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	if (ret > 0)
 		ret += dio->done_before;
 
+	trace_iomap_dio_complete(iocb, dio->error, ret);
 	kfree(dio);
 
 	return ret;
@@ -681,6 +682,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct iomap_dio *dio;
 	ssize_t ret = 0;
 
+	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
 	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
 			     done_before);
 	if (IS_ERR_OR_NULL(dio)) {
@@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	ret = iomap_dio_complete(dio);
 out:
+	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
index da217246b1a9..728d5443daf5 100644
--- a/fs/iomap/trace.c
+++ b/fs/iomap/trace.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019 Christoph Hellwig
  */
 #include <linux/iomap.h>
+#include <linux/uio.h>
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index f6ea9540d082..dcb4dd4db5fb 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -183,6 +183,96 @@ TRACE_EVENT(iomap_iter,
 		   (void *)__entry->caller)
 );
 
+#define TRACE_IOMAP_DIO_STRINGS \
+	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
+	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
+	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }
+
+DECLARE_EVENT_CLASS(iomap_dio_class,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
+		 unsigned int dio_flags, u64 done_before, int ret),
+	TP_ARGS(iocb, iter, dio_flags, done_before, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(u64,	count)
+		__field(u64,	done_before)
+		__field(int,	ki_flags)
+		__field(unsigned int,	dio_flags)
+		__field(bool,	aio)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
+		__entry->done_before = done_before;
+		__entry->dio_flags = dio_flags;
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+		__entry->ret = ret;
+	),
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx count %llu "
+		  "flags %s dio_flags %s done_before %llu aio %d ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __entry->count,
+		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
+		  __print_flags(__entry->dio_flags, "|", TRACE_IOMAP_DIO_STRINGS),
+		  __entry->done_before,
+		  __entry->aio,
+		  __entry->ret)
+)
+
+#define DEFINE_DIO_RW_EVENT(name)					\
+DEFINE_EVENT(iomap_dio_class, name,					\
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,		\
+		 unsigned int dio_flags, u64 done_before,		\
+		 int ret),						\
+	TP_ARGS(iocb, iter, dio_flags, done_before, ret))
+DEFINE_DIO_RW_EVENT(iomap_dio_rw_begin);
+DEFINE_DIO_RW_EVENT(iomap_dio_rw_end);
+
+TRACE_EVENT(iomap_dio_complete,
+	TP_PROTO(struct kiocb *iocb, int error, int ret),
+	TP_ARGS(iocb, error, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(int,	ki_flags)
+		__field(bool,	aio)
+		__field(int,	error)
+		__field(int,	ret)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+		__entry->error = error;
+		__entry->ret = ret;
+	),
+	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx flags %s aio %d error %d ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
+		  __entry->aio,
+		  __entry->error,
+		  __entry->ret)
+);
+
 #endif /* _IOMAP_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.39.2

