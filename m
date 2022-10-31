Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF92613F70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJaVEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaVEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:04:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF6B13CC8;
        Mon, 31 Oct 2022 14:04:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p141so10822577iod.6;
        Mon, 31 Oct 2022 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2u3HH9X6jArAne4XCHoahMbgnFI791yesXDV0bQF3Q=;
        b=aS0Y2giETo0mdCcBmDNriGV57NyXCrcYK8sOrX0V/qt5vPlt+CsT7bgPSBc958dVEt
         /jaYM+zEptpvh45flN2dBavhmHqMiAraomTIOqoqP3qRkCfUzuf+BoSxDtb0PWBBsZWH
         h1jLJgFj6WUqVbLtp/k0w/8jlkx8OakraqckXyiu987olPlSO/sK7wHv6y4lJPqE94hl
         c59AYY/yTUOjicOxVfWSuVDxROaQFz+X1rQgZ0Jghc8XKzw/mCvRprKhovoTPRdVk1+Y
         U5YYhkP3Rj0inAWo44W/TK5YwKoIhve663C1WD2TzC8lrroYQYMpz0pXbzb/9w3noLLU
         mAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2u3HH9X6jArAne4XCHoahMbgnFI791yesXDV0bQF3Q=;
        b=UtWQV1A2xIKE0+sOu0nN0UyH0CIRZmyozXMguCIAH2ddCtDIdHi1V0ly8M+tagE44N
         RImtI+K76iXSTw84aY+24KaNqO9cSC30WykjVbn/4L/b9hecrgKZb/9MTmPDfbkOqTvn
         29J96mhBahqhPxaDHGspzPLpc4q8lo1AFlRrPEzr6lbgNXqFdMCn/kEfcCnoJZzs6w1Y
         tDYCr1T3Wq3rBXckaSpDPdwEt1qHya0hhyfshKNC0j4CZ79e0nAPUsNByLa1Q5egM77k
         5xTvPHaH5b8gUqE/KnmqXIlBv2BiovI3eF6ZHxYw1KjwQLUpBLtw4FDT2RWRfkPtDZTH
         lBcw==
X-Gm-Message-State: ACrzQf1zDcDl4wjUqtdXmomKVX6RVZJYQ0U4jg6avC+71ljMhel8tjlO
        RIKz6QlR8kIB4p4X4o7AbFdyWljOyQ==
X-Google-Smtp-Source: AMsMyM6iZKsIEdImZsWQqTuUUT4HsfDVdEVZmOUS/W5hp1duyu3cPETgJBnT5Go9Txm/PBlXfnNjVQ==
X-Received: by 2002:a02:662a:0:b0:36e:6349:17c0 with SMTP id k42-20020a02662a000000b0036e634917c0mr8786980jac.183.1667250244006;
        Mon, 31 Oct 2022 14:04:04 -0700 (PDT)
Received: from bytedance.bytedance.net ([74.199.177.246])
        by smtp.gmail.com with ESMTPSA id u11-20020a02c94b000000b0037556012c63sm1843627jao.132.2022.10.31.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:04:03 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v2] coredump: Use vmsplice_to_pipe() for pipes in dump_emit_page()
Date:   Mon, 31 Oct 2022 14:03:49 -0700
Message-Id: <20221031210349.3346-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029005147.2553-1-yepeilin.cs@gmail.com>
References: <20221029005147.2553-1-yepeilin.cs@gmail.com>
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
change in v2:
  - fix warning in net/tls/tls_sw.c (kernel test robot)

 fs/coredump.c          | 7 ++++++-
 fs/splice.c            | 4 ++--
 include/linux/splice.h | 3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index da0e9525c4e8..c0a8713d9971 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/splice.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -862,7 +863,11 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
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
index a55179fd60fc..38b3560a318b 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/uio.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -81,6 +82,8 @@ extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 extern long do_splice(struct file *in, loff_t *off_in,
 		      struct file *out, loff_t *off_out,
 		      size_t len, unsigned int flags);
+extern long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+			     unsigned int flags);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
-- 
2.20.1

