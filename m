Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8936E2F91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDOHpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDOHpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:45:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB483DF;
        Sat, 15 Apr 2023 00:45:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2467729fbc4so1604308a91.1;
        Sat, 15 Apr 2023 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544704; x=1684136704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC4njAHIv2ukYsLLd4EVfdpnd2WOl/cSebcSSE8kz+4=;
        b=lUixrBJ6NdQUMytPXZ1OazICdL3ZRQqtjpnREVHTxuvO+3cwaNTOQi8JlPH7ziJXjw
         gAixEj58woVhDJHLY79ZPgViDM7l01zPpreIu6KwkybqjD24w9ERRB3lNOdQyddxBAcR
         P1sd6ptO2vGx4RBdI5VzIQc3Q5gf1knAHSehK6vW548clSgiNLCdVl3ahQSsxtYKp/F0
         zEFR/OI1kkBdDnDhE/b32LaZshT1rWcMHvI4c7hyZOX8PiEoWVwWiwoAqlTf5rNA7IK1
         pwsx8IsCkH4RXCaJwsQ8xFMJP9CNzrZ2lNGISc+r5XJPzLDcDxPvB/nqntF2QjzurXdx
         rGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544704; x=1684136704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC4njAHIv2ukYsLLd4EVfdpnd2WOl/cSebcSSE8kz+4=;
        b=Ea4QQWCCvJD5wDnkExBPDmiJJhpudWT+eQg2+A54lQ/cpqdXgk00EPawpMAdTeK3dD
         1s2AEra/1Ea/OUUVWlLaezZvYRHqr/eeTszf8OYbDIws0ntvPYELU6vSjmOspKxfp27z
         63YzxXoumoDl822oWGmh/pZzdmIZGOmpxfjDLZBB3OEbjwH4ntFPdaD0/Raw2uCi+3kP
         LfgoSl7jAuAaOA7tR2Mua//+H38xEA3V2OWlkrMdOJjIbWBxeayc2OwZr1k7f6X/7vp9
         gE6S4SCIaWeVGw1GR+HRVFb8P7vPipNvjoj3L/CNrBMDXbY+C+A6YZe7+2HwIeU6en/T
         HgwQ==
X-Gm-Message-State: AAQBX9d7/P+2DguGggExKV1JPmSKhMn3bLVr3jwh9B3eqKb+yBy3h7Qz
        SKTxbGHjiaBbExMHQzpkEiPs6aWKtFw=
X-Google-Smtp-Source: AKy350a3c4CsjCT+f51TqgC33BAfCBQ9QK0BFS6LLRgHszkgORkmXFaHt14gCkqYwE+6cBvppFffmQ==
X-Received: by 2002:a05:6a00:1a09:b0:636:e52f:631e with SMTP id g9-20020a056a001a0900b00636e52f631emr11473833pfv.1.1681544703770;
        Sat, 15 Apr 2023 00:45:03 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:45:03 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 9/9] iomap: Add couple of DIO tracepoints
Date:   Sat, 15 Apr 2023 13:14:30 +0530
Message-Id: <793d0cc2d49ef472038fca2cbe638e18be40cb0c.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
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

Add iomap_dio_rw_queued and iomap_dio_complete tracepoint.
iomap_dio_rw_queued is mostly only to know that the request was queued
and -EIOCBQUEUED was returned. It is mostly iomap_dio_complete which has
all the details.

<output log>
           a.out-1827  [004]   707.806763: iomap_dio_rw_queued:  dev 7:7 ino 0xd size 0x1000 offset 0x1000 length 0x0
     ksoftirqd/3-31    [003]   707.806968: iomap_dio_complete:   dev 7:7 ino 0xd size 0x1000 offset 0x1000 flags DIRECT aio 1 error 0 ret 4096

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c |  5 ++++-
 fs/iomap/trace.c     |  1 +
 fs/iomap/trace.h     | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36ab1152dbea..cef28cfd77b7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	if (ret > 0)
 		ret += dio->done_before;
 
+	trace_iomap_dio_complete(iocb, dio->error, ret);
 	kfree(dio);
 
 	return ret;
@@ -650,8 +651,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
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
index f6ea9540d082..9c017af93302 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -83,6 +83,7 @@ DEFINE_RANGE_EVENT(iomap_writepage);
 DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
+DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
@@ -183,6 +184,40 @@ TRACE_EVENT(iomap_iter,
 		   (void *)__entry->caller)
 );
 
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

