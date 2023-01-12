Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5234668726
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbjALWn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjALWny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:43:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6D3DBC2;
        Thu, 12 Jan 2023 14:43:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso25199809pjt.0;
        Thu, 12 Jan 2023 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw03+QWOKRs5sCIZHDkI6ng52h14rinsKVdsXX7MOE0=;
        b=VUSO9U0avN2C9zrYqZycMn20bQgDBqJ0OkwRw+sF7oasMIDt1X3TenHo9zLdsUM83e
         345NSb+OfxemkLUUomhODLETazsqN0cOwSSXJhxrvN4ASvKOzLhNHg8v6CZ/yRN7Dj0n
         Tn+SUddbLdJsoHW+sIkTNk5KVugn9+/vjGOET8VldnzFSfj6eEZhe8gVkYXHbnLOxWyE
         0xlNazV+k0Sw+jfwih6f2RH42JWIEzci2kXCI9lnur4rby2nNQPFuGy68CtD1ca0JywS
         Gil233o5h4Rx5aCaWsqXhytVPYmdR/eUSQqAiPVg2YzaQaqCDwChE9MdXUa0MBEwa2rx
         T4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw03+QWOKRs5sCIZHDkI6ng52h14rinsKVdsXX7MOE0=;
        b=Orw1IuHMYx6DRSzDEkF0dyibwHBxHZ4pT1biZ5mT+Et99UdZ97NfbFw6CBiRwHEa2z
         GratuUGsZBCoAoXUR4LGAVKpqQTXRKvZ/sIpsPS6TJSO3VAOxcTJWs8NuvkXxMUG/NZm
         x1vR9gvL7nFH9N9ovqAr4RKqiwdHcGVbIf8bBY6yPpxvg5tlOESpw2YHP7owCR8J0D73
         EL0JFFEobXtNG+d9QxF9nTVvseWoD0tNXQ3XgrZXaI5tNGSj1EOD+Dbho1awv0Gg4pKr
         ut4eBQHw6iVX8z5XLpQP2gVdzAr9Xaz6nKiRAC7ZUTIW3c74pqyR4+cRk8/KKQFLOlez
         cy7w==
X-Gm-Message-State: AFqh2kpTR7m8QDLzWUfweMUOfvxog+IAZbipJBsskS/0jq6iLGqMXxEU
        1GeFiqVCY8oEqfVjJL4kPA==
X-Google-Smtp-Source: AMrXdXuJtMthutqaEcYVXnrlFry7Ymu5h+0BS2OgMY12EJIfyL4UV60alEmdc42O5D5KaGQpz2a7OQ==
X-Received: by 2002:a05:6a21:32a7:b0:ad:f2bf:bc50 with SMTP id yt39-20020a056a2132a700b000adf2bfbc50mr123221975pzb.13.1673563432062;
        Thu, 12 Jan 2023 14:43:52 -0800 (PST)
Received: from bytedance.bytedance.net ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id i11-20020aa796eb000000b00576df4543d4sm12311265pfq.166.2023.01.12.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:43:51 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3 RESEND] coredump: Use vmsplice_to_pipe() for pipes in dump_emit_page()
Date:   Thu, 12 Jan 2023 14:43:48 -0800
Message-Id: <20230112224348.5384-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130053734.2811-1-yepeilin.cs@gmail.com>
References: <20221130053734.2811-1-yepeilin.cs@gmail.com>
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

Tested by dumping a 32-GByte core into a simple handler that splice()s
from stdin to disk in a loop, PIPE_DEF_BUFFERS (16) pages at a time.

                              Before           After   Improved by
  Time to Completion   40.77 seconds   35.49 seconds        12.95%
  CPU Usage                   92.27%          86.40%         6.36%

Suggested-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
 fs/coredump.c            | 10 +++++++++-
 fs/splice.c              |  4 ++--
 include/linux/coredump.h |  3 +++
 include/linux/splice.h   |  3 +++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f27d734f3102..4078069ede88 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/splice.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -586,6 +587,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto fail_unlock;
 		}
 
+		set_bit(COREDUMP_USE_PIPE, &cprm.flags);
+
 		if (cprm.limit == 1) {
 			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
 			 *
@@ -861,7 +864,12 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return 0;
 	pos = file->f_pos;
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	n = __kernel_write_iter(cprm->file, &iter, &pos);
+
+	if (test_bit(COREDUMP_USE_PIPE, &cprm->flags))
+		n = vmsplice_to_pipe(file, &iter, 0);
+	else
+		n = __kernel_write_iter(cprm->file, &iter, &pos);
+
 	if (n != PAGE_SIZE)
 		return 0;
 	file->f_pos = pos;
diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..c9be20f4115e 100644
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
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..3e34009487bf 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,8 +28,11 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	unsigned long flags;
 };
 
+#define COREDUMP_USE_PIPE	0
+
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
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

