Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E62611ECC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 02:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ2AwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 20:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ2AwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:52:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B2D0185;
        Fri, 28 Oct 2022 17:52:00 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay12so3878314qtb.12;
        Fri, 28 Oct 2022 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5RiV+Px8WS2ShlcDdYeA2/trOi8fP9YvmZ25k/CKak=;
        b=g02qEJsW4N4aEjtM2laW+nJCEU2K+n+vd3qaVpXcdBqYfi35cSrb3J3RhQhtftmcpj
         7Sw42lNEJuQJl4x0yoJ3nc+1xtoXk9y2NWCHBbEPGN1jUPz82/lddDcLogq7H/pYt6Wd
         7jR21fg86kFw6FI99VHNURki10cISy3GEFpKpdAZUa+7le46Nz6rRd/d0SviYF7hthIi
         6ryQBP76Vsa2qA+AVxLu4pxRbhA+sXdDp3CLlCB3M9FsgEYO567PpOyr2TQRho8cesCu
         RwfDRjeABE64l5SRnc6xmdEJw62+9Crx31nLjWi+PZSnoMU6bq95n3O/xhrk8mn3giY8
         ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5RiV+Px8WS2ShlcDdYeA2/trOi8fP9YvmZ25k/CKak=;
        b=VFxa9D0TF4M1N/jWArU1nOxlr27Tt3fTildtXBVmlxN65krywv9oSGcBsjKPIG3Jue
         lYTpW5gSTF3m1tgy9ssKV4RsVCuH5w79DV+qlCHsSDwpZeCJH4YEnuDQo131CxPKakUc
         px6PH5UyUOIq/7AoF/g4x6p+jzDSasXKk9HOEuOxdU2RIywdso6oyZe+FLeu1W11tKgV
         RRMb/TfvENxAhCKaW2vluLRUIMvIINvz9Yafw9bNqWlNQ3IrqEilYPP0aZbPubpkqaOi
         tZcvQoE3QVjaTlCgpfJTSq9w6BfSwwO47CBmIR7HV/HmpOzR/R4uB1kxJ7+mTgutKZTy
         ymIA==
X-Gm-Message-State: ACrzQf1oVGvDGTKAd07WEE98jLK6coak6Zujoizlyr01OrLScn0YphBD
        qPoTWicpuaiZ2whK+iV8TQ==
X-Google-Smtp-Source: AMsMyM5eeaDRtJt9jT3X61qvR4FC2q4BQYVIJ7LYQY71VUdG/c1hXQ/tivkJUa6sYYPqh/O4ISgQZw==
X-Received: by 2002:a05:622a:198e:b0:39c:e98c:d3e1 with SMTP id u14-20020a05622a198e00b0039ce98cd3e1mr1934014qtc.378.1667004719888;
        Fri, 28 Oct 2022 17:51:59 -0700 (PDT)
Received: from bytedance.attlocal.net ([130.44.212.155])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006b61b2cb1d2sm133935qkb.46.2022.10.28.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 17:51:59 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v1] coredump: Use vmsplice_to_pipe() for pipes in dump_emit_page()
Date:   Fri, 28 Oct 2022 17:51:47 -0700
Message-Id: <20221029005147.2553-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Peilin Ye <peilin.ye@bytedance.com>

Currently, there is a copy for each page when dumping VMAs to pipe
handlers using dump_emit_page().  For example:

  fs/binfmt_elf.c:elf_core_dump()
      fs/coredump.c:dump_user_range()
                     :dump_emit_page()
        fs/read_write.c:__kernel_write_iter()
                fs/pipe.c:pipe_write()
             lib/iov_iter.c:copy_page_from_iter()

Use vmsplice_to_pipe() instead of __kernel_write_iter() to avoid this
copy for pipe handlers.

Tested by dumping a 40-GByte core into a simple handler that splice()s
from stdin to disk in a loop, PIPE_DEF_BUFFERS (16) pages at a time.

                              Before           After   Improved by
  Time to Completion   52.04 seconds   46.30 seconds        11.03%
  CPU Usage                   89.43%          84.90%         5.07%

Suggested-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
 fs/coredump.c          | 7 ++++++-
 fs/splice.c            | 4 ++--
 include/linux/splice.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..a6ef406dee43 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/splice.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -854,7 +855,11 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return 0;
 	pos = file->f_pos;
 	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
-	n = __kernel_write_iter(cprm->file, &iter, &pos);
+
+	n = vmsplice_to_pipe(file, &iter, 0);
+	if (n == -EBADF)
+		n = __kernel_write_iter(cprm->file, &iter, &pos);
+
 	if (n != PAGE_SIZE)
 		return 0;
 	file->f_pos = pos;
diff --git a/fs/splice.c b/fs/splice.c
index 0878b852b355..2051700cda79 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1234,8 +1234,8 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
  * as splice-from-memory, where the regular splice is splice-from-file (or
  * to file). In both cases the output is a pipe, naturally.
  */
-static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+		      unsigned int flags)
 {
 	struct pipe_inode_info *pipe;
 	long ret = 0;
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a55179fd60fc..0cd955cf5ee2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -81,6 +81,8 @@ extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 extern long do_splice(struct file *in, loff_t *off_in,
 		      struct file *out, loff_t *off_out,
 		      size_t len, unsigned int flags);
+extern long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+			     unsigned int flags);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
-- 
2.20.1

