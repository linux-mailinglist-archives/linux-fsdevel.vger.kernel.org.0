Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298826EA788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjDUJsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjDUJr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCABBA9;
        Fri, 21 Apr 2023 02:46:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b35789313so1543617b3a.3;
        Fri, 21 Apr 2023 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070415; x=1684662415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dWf1dvZIG8pHMSeUg82C8AwnQh7cBAtdJ5vnIJgOrI=;
        b=Pk81xMbqBt2BMXaofB7jff0qXd/qhIlzYe2F8RzKUGDMOAGXLaUGCbK+337+e8aTrK
         rzSj02uSlDdMAuQD1Z+ugYknR83/GaTsJugWIxCzeFZp148WOtQQMx2VJAl+3FHFxkfo
         MTBrlXQDAVdP5a86wPc3ydYyPXU5tsHxVFNLBby2ezNZUVOqv/MvuSnyV+ySU03JbVLb
         BgmF4NZsX/q5fMrTtNuIoNfTriyjLxnM5mnKJWd+OymwaD0E3NOo84I8ZWLQ8tmifvdd
         gMEsNMcLaArBGwam/HFdBc7mj4ky+n1vO2rh6JzxBSq8fLkicb73WROjR4ajWToikbVp
         oHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070415; x=1684662415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dWf1dvZIG8pHMSeUg82C8AwnQh7cBAtdJ5vnIJgOrI=;
        b=GeNfwi1SLEC+8f6RBP48EKtlnZdWmH0uECH/5Cdg9XoJIQ4dsaLIV1906gthR8QlGR
         e7rKZHdfjcpG0/lqXy+Oq1ObASgEmggiV1ZfD1n4klDdI20y5NqjnoTVmpkp1YQtkxRN
         gIjazFlY675K/ptb7TQ71B8Uc4IGDsv/SFkN97c9sXPEk33JM/MnMlIbxrzKQ7KD8Un+
         B5wC6StniXyyE+/CsLGtYhFtvutH8c0w98/vJRbBoimJtxQ0U20+ZOPIIzwlsTlEUURV
         tMG8nwv9jpAf4o2Tmk1DZBxUzh9ddAuxmhVPcsDsru/IVNF09IYj6Nmtmo8Gs3/m4quj
         ZPvQ==
X-Gm-Message-State: AAQBX9cdZ9o2PiByirJ69KuLssCSg0wic62K3q1KvovsYIg4RxCKW8ON
        3WFrCrXYozsArLzJYgvzINlHlMfGZrw=
X-Google-Smtp-Source: AKy350ZC0Y01J1IkiYSgMUbjo0YCP9RBfMJmLqSUTXlHi1lAbDQAZbcnPNOMs87vWvqMz0G8fXkHJA==
X-Received: by 2002:a05:6a21:3403:b0:ee:786b:d6f8 with SMTP id yn3-20020a056a21340300b000ee786bd6f8mr5304131pzb.57.1682070415510;
        Fri, 21 Apr 2023 02:46:55 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:55 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv6 9/9] iomap: Add DIO tracepoints
Date:   Fri, 21 Apr 2023 15:16:19 +0530
Message-Id: <67daf0c2a4025b9c80023171bca5c9d1ec9b4341.1682069716.git.ritesh.list@gmail.com>
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

Add trace_iomap_dio_rw_begin, trace_iomap_dio_rw_queued and
trace_iomap_dio_complete tracepoint.
trace_iomap_dio_rw_queued is mostly only to know that the request was
queued and -EIOCBQUEUED was returned. It is mostly trace_iomap_dio_rw_begin
& trace_iomap_dio_complete which has all the details.

<example output log>
      a.out-2073  [006]   134.225717: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x0 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT|WRITE dio_flags DIO_FORCE_WAIT aio 1
      a.out-2073  [006]   134.226234: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT|WRITE aio 1 error 0 ret 4096
      a.out-2074  [006]   136.225975: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 1
      a.out-2074  [006]   136.226173: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
ksoftirqd/3-31    [003]   136.226389: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 1 error 0 ret 4096
      a.out-2075  [003]   141.674969: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT|WRITE dio_flags  aio 1
      a.out-2075  [003]   141.676085: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
kworker/2:0-27    [002]   141.676432: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT|WRITE aio 1 error 0 ret 4096
      a.out-2077  [006]   143.443746: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 1
      a.out-2077  [006]   143.443866: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
ksoftirqd/5-41    [005]   143.444134: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 1 error 0 ret 4096
      a.out-2078  [007]   146.716833: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 0
      a.out-2078  [007]   146.717639: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 0 error 0 ret 4096
      a.out-2079  [006]   148.972605: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 0
      a.out-2079  [006]   148.973099: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 0 error 0 ret 4096

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c |  7 +++-
 fs/iomap/trace.c     |  1 +
 fs/iomap/trace.h     | 78 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36ab1152dbea..019cc87d0fb3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	if (ret > 0)
 		ret += dio->done_before;
 
+	trace_iomap_dio_complete(iocb, dio->error, ret);
 	kfree(dio);
 
 	return ret;
@@ -493,6 +494,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
+	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
+
 	if (!iomi.len)
 		return NULL;
 
@@ -650,8 +653,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	dio->wait_for_completion = wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!wait_for_completion)
+		if (!wait_for_completion) {
+			trace_iomap_dio_rw_queued(inode, iomi.pos, iomi.len);
 			return ERR_PTR(-EIOCBQUEUED);
+		}
 
 		for (;;) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
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
index f6ea9540d082..448b82d16c0b 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -83,6 +83,7 @@ DEFINE_RANGE_EVENT(iomap_writepage);
 DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
+DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
@@ -107,6 +108,11 @@ DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
 	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
 
+#define IOMAP_DIO_STRINGS \
+	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
+	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
+	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }
+
 DECLARE_EVENT_CLASS(iomap_class,
 	TP_PROTO(struct inode *inode, struct iomap *iomap),
 	TP_ARGS(inode, iomap),
@@ -183,6 +189,78 @@ TRACE_EVENT(iomap_iter,
 		   (void *)__entry->caller)
 );
 
+TRACE_EVENT(iomap_dio_rw_begin,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
+		 unsigned int dio_flags, size_t done_before),
+	TP_ARGS(iocb, iter, dio_flags, done_before),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(size_t,	count)
+		__field(size_t,	done_before)
+		__field(int,	ki_flags)
+		__field(unsigned int,	dio_flags)
+		__field(bool,	aio)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->isize = file_inode(iocb->ki_filp)->i_size;
+		__entry->pos = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
+		__entry->done_before = done_before;
+		__entry->ki_flags = iocb->ki_flags;
+		__entry->dio_flags = dio_flags;
+		__entry->aio = !is_sync_kiocb(iocb);
+	),
+	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx length 0x%zx done_before 0x%zx flags %s dio_flags %s aio %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->isize,
+		  __entry->pos,
+		  __entry->count,
+		  __entry->done_before,
+		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
+		  __print_flags(__entry->dio_flags, "|", IOMAP_DIO_STRINGS),
+		  __entry->aio)
+);
+
+TRACE_EVENT(iomap_dio_complete,
+	TP_PROTO(struct kiocb *iocb, int error, ssize_t ret),
+	TP_ARGS(iocb, error, ret),
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, isize)
+		__field(loff_t, pos)
+		__field(int,	ki_flags)
+		__field(bool,	aio)
+		__field(int,	error)
+		__field(ssize_t, ret)
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
+	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx flags %s aio %d error %d ret %zd",
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

