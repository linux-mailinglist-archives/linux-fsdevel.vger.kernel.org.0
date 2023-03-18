Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A06BF834
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 07:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCRGDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCRGDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:03:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A33B878;
        Fri, 17 Mar 2023 23:02:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso7391183pjb.2;
        Fri, 17 Mar 2023 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679119379; x=1681711379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQGPf/wxZw5dZB9k3t/6PRKbx/yttZTmKCb/1ksWzl0=;
        b=Z35ZUvlZ5GeJUsAQD4IQqQQiVcVACwNs7dZMeGw+vG0OpRyfHPTvtJyrp8mZp97dzB
         2yqx++ckHXZ9sk7duOuEGrbC8LLoa877ipblfevdpIlUpcS/RQFd/zzv64ezgCcsdoGD
         Lg8jck7hPhy4BaxOjXufeTNZlC7gPQys2HcFtCiAQ6bpqZt+0HZRNK1jNfkKnXBnnXsA
         dWfgnFF3AFpXbxdS2O5DpSYAFduFIhLM085TZUlZSvgqMpiS8TqH8C289RPufZVrQCh2
         YMWLA4j8BVIha+JUPnyV2zB87VJjH5pgtzQv1P1No/iK1OHNeX2Zhwc24xHQO7RTndX4
         /XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119379; x=1681711379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQGPf/wxZw5dZB9k3t/6PRKbx/yttZTmKCb/1ksWzl0=;
        b=nKib8N7io/kRcxI2xR1cGpGU+jqyDdI+OoBX7xLlOrUkb8rFYJCCG4ETUTkAVX9cl8
         irLHmVKtoCAGu+R8tL2NkMHibtiEOSz4AB0/u+nTODIeSxYxYbfkGER+7lQFxq9kgjeF
         kjgN0dwcPCvNhUXc8uK2kMpDqkUCXvFW0Qd+l1XBzQ0MaZE6nG0/eGriut1c02wLzAkr
         8pcYhv6TlEDQIRKcGrYw+QsjrppD0BTrDWkDQUPKEqQGMe8oD6qs/jQHbjDjLRkJ3Jjx
         jEn2sLAIe04GzdAm8EbREtjtjw3RgRRbZbJJx1ast/ZJZMikQ/iYIPf//O15GG/UgX5h
         8goQ==
X-Gm-Message-State: AO0yUKXXyf4pn7coY2oHrsnSj8NDj2U467FMw9NIQtDTZ1py9icO5caw
        dulz/45McuocsCgW32U3dK4=
X-Google-Smtp-Source: AK7set+tdHiiUdX0wnxu8PiTwutiRoBGi/ZDUUQ1eKMhs6/K7XuEtobqw/H7MDQxRbGyTHKlErDMOA==
X-Received: by 2002:a17:90a:7182:b0:236:7144:669f with SMTP id i2-20020a17090a718200b002367144669fmr11439043pjk.2.1679119378840;
        Fri, 17 Mar 2023 23:02:58 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a15d700b00233b5d6b4b5sm5775920pjd.16.2023.03.17.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 23:02:58 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, David.Laight@ACULAB.COM,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC v2 2/3] file: allow callers to free the old file descriptor after dup2
Date:   Sat, 18 Mar 2023 06:02:47 +0000
Message-Id: <20230318060248.848099-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318060248.848099-1-aloktiagi@gmail.com>
References: <20230318060248.848099-1-aloktiagi@gmail.com>
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

Allow callers of do_dup2 to get a reference to the file pointer being dup'ed
over. The callers can then replace the file with the new file in the eventpoll
interface or the file table before freeing it.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.
  - Address review comment to make the interface cleaner so that the caller cannot
    forget to initialize the fdfile.
---
 fs/file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4b2346b8a5ee..1716f07103d8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1086,7 +1086,7 @@ bool get_close_on_exec(unsigned int fd)
 }
 
 static int do_dup2(struct files_struct *files,
-	struct file *file, unsigned fd, unsigned flags)
+	struct file *file, unsigned fd, struct file **fdfile, unsigned flags)
 __releases(&files->file_lock)
 {
 	struct file *tofree;
@@ -1119,8 +1119,12 @@ __releases(&files->file_lock)
 		__clear_close_on_exec(fd, fdt);
 	spin_unlock(&files->file_lock);
 
-	if (tofree)
-		filp_close(tofree, files);
+	if (fdfile) {
+		*fdfile = tofree;
+	} else {
+		if (tofree)
+			filp_close(tofree, files);
+	}
 
 	return fd;
 
@@ -1132,6 +1136,7 @@ __releases(&files->file_lock)
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
+	struct file *fdfile = NULL;
 	struct files_struct *files = current->files;
 
 	if (!file)
@@ -1144,7 +1149,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	err = do_dup2(files, file, fd, &fdfile, flags);
+	if (fdfile)
+		filp_close(fdfile, files);
+	return err;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
@@ -1237,7 +1245,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 			goto Ebadf;
 		goto out_unlock;
 	}
-	return do_dup2(files, file, newfd, flags);
+	return do_dup2(files, file, newfd, NULL, flags);
 
 Ebadf:
 	err = -EBADF;
-- 
2.34.1

