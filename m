Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECA630850
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiKSBUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiKSBTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:19:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56CB7035;
        Fri, 18 Nov 2022 16:17:56 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 8so4609944qka.1;
        Fri, 18 Nov 2022 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya/HZho/hYNS3aLaSnNK+OWu7yXKQvRmTWMTtCIGZCs=;
        b=F8XLLukwWdeSfpJFx5dfa4W8KDFebDhg3tPacc8OuiBvRe1fKVh0t9XveWdsqxUm42
         TKWCYUBtrP1ZLwU5EYR6bmjolzEVs11VCfg49bOLLV/kZbyQFYb9mtsEqRBEFPb+6Kfa
         a2tzsmyZkg6QBD0XKoMfEKrBHgICpi7UBsSVA4wvcku4fYLn1Ca1mO4Q0c8yKDhM1Y55
         7btDhYaMJ1ycnUCD1mAcRAwmpPgguDDvU6KtnNBNBknq5RFQDMNWfORXN46KnySrtHgG
         0FgACME+IZ+o9TDsFN3KgUDFmTFazdgIzdhiKdZGOtL68rQLvmAlykcGNhzD2szdXnh/
         DNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya/HZho/hYNS3aLaSnNK+OWu7yXKQvRmTWMTtCIGZCs=;
        b=r6MnErTEHeB2l2CnUr5iQ2EtiNk7uNYU/xZkEtv4xLbdHgQdRTF7tdfsD++heaslNc
         4LOh3iQqaFQ777Jj4NuNlJqjjFJO0d2W0cyG+GtgzR8+gcbcmfQ1j6t5YgY5h1OyHB0L
         o0zVzUWlMYf5AxwRrJnTnAu73WksACH/7ubv86ao/0v0XZ08XaFyJWLzXMFi6iKSdHqH
         5cE0NAju+g0yVVQSZXgFqqYP49/knXvVCJQaCITIs5MUm6fQZT/AUBs3yoYYcFyDUCam
         w7djMJ600HNpooiE7qTORHxwtPQduY8eD1BS+gXlCKbT/2WHKKWGSLs9vx4qk1vObcrI
         rnJw==
X-Gm-Message-State: ANoB5plU9VJQdfSwV6TNLyYvevZDWvmxm4gzaV6EhpgALNGbTDD2F469
        E77lvI+P2Usf2Bd91Wfldg==
X-Google-Smtp-Source: AA0mqf51LuhTtLwDUfXEMujj1VMD27U6ac1gRcZdNryNCTAlMjCIfYXlall2BYxNC+PE66PmPBY4Gg==
X-Received: by 2002:a37:b746:0:b0:6fa:1d5c:ba00 with SMTP id h67-20020a37b746000000b006fa1d5cba00mr7766196qkf.202.1668817075926;
        Fri, 18 Nov 2022 16:17:55 -0800 (PST)
Received: from bytedance.attlocal.net ([130.44.212.155])
        by smtp.gmail.com with ESMTPSA id bs10-20020ac86f0a000000b003992448029esm2835719qtb.19.2022.11.18.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:17:55 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v2 RESEND] coredump: Use vmsplice_to_pipe() for pipes in dump_emit_page()
Date:   Fri, 18 Nov 2022 16:17:40 -0800
Message-Id: <20221119001740.2642-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031210349.3346-1-yepeilin.cs@gmail.com>
References: <20221031210349.3346-1-yepeilin.cs@gmail.com>
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
Hi all,

Resending this after 2+ weeks.  Any suggestions, testing would be much
appreciated, thanks!

change in v2:
  - fix warning in net/tls/tls_sw.c (kernel test robot)

Peilin Ye

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

