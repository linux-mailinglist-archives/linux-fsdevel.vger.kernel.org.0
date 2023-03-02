Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458956A887B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCBSWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCBSWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:22:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCA1027F;
        Thu,  2 Mar 2023 10:22:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso3696304pju.0;
        Thu, 02 Mar 2023 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677781339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvc0PRlJ5Xp7yvzrzYQ0CExEDOrkp/x741jkOjWR6+4=;
        b=pIeLXxngYBGW10/XDl+UI1pbJVYjCM9srPBmxkGqLI+xcOL2a4eZ4ZQg60PMe/CXbE
         70DnVdquQ6S8hMI63l5mBenu2ebLK7FQYVDY5xk1wtWNHYWnLUi5B9nMGB33rLiNILh9
         1mfauFoFQDZjb6EA5KxW7l2ilq1hn1dGPigXd6vW+NcYiTSSj+siFRVXKie/NQ/9qHRm
         Bh5j/ure/irBl71zkte/+nBgpbDuESclaux0hmiLmDu5hX6EfAdk0qkA2QOzw6AdzP3Z
         4LimEuBVxUPzTbmDmOrr7ualewCnFDkaNtjUGIrbGWNfrjnLSvISXF4f/9Z3yqPIGpJl
         ujDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvc0PRlJ5Xp7yvzrzYQ0CExEDOrkp/x741jkOjWR6+4=;
        b=eycTjCcyBH2jrncIQUV8VESix+WKQ6be5vq3RkNrWcOkPMnr4iyzQRH4S7RjVil1vT
         bhDFkvVBNCA7KJPdo+PiUB+pEk1WAzosq5CrCuqyafiZy8hL4HpsL8x8Wzbu5ckZOHcI
         vDnVSz01+c/lYotHQrPUkr3Z+yR6lH0icPLreFTpLNn7Q5JnkA+/V15OQCcZXN3D5V7c
         VO3V0qXDgT9tMzs5X7Xn8fUbP2vypX+hlIT5pOP/s6ima8JjqyFOfKfE3lKgwlx8goZq
         L150mr8wxy6esq6VOOsh9Uod24oFa7kqgeUB3ER20hCHoeXyrZjaOYenfpH9lIovu9tZ
         qH1Q==
X-Gm-Message-State: AO0yUKXB+uNFNGsMWZZl3ElxZcENDANPzNQrkMEgM+4IhMnzniXU7s4K
        X1JkG3ICuHecqp//Y5YWE2U=
X-Google-Smtp-Source: AK7set/owxcndwSE406Lnqs2pfo4Lth6j//sOEwy8kIvrbG1MPZlPMprtSPMK6Crnd8wFm8daySaIg==
X-Received: by 2002:a17:90a:2e8b:b0:234:117e:b122 with SMTP id r11-20020a17090a2e8b00b00234117eb122mr11574375pjd.0.1677781339225;
        Thu, 02 Mar 2023 10:22:19 -0800 (PST)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090adc8600b00234b785af1dsm89908pjv.26.2023.03.02.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:22:18 -0800 (PST)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC 2/3] file: allow callers to free the old file descriptor after dup2
Date:   Thu,  2 Mar 2023 18:22:06 +0000
Message-Id: <20230302182207.456311-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302182207.456311-1-aloktiagi@gmail.com>
References: <20230302182207.456311-1-aloktiagi@gmail.com>
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

Allow callers of do_dup2 to free the old file descriptor in case they need to
make additional operations on it.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
 fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4b2346b8a5ee..04c8775d337a 100644
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
@@ -1120,7 +1120,7 @@ __releases(&files->file_lock)
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
-		filp_close(tofree, files);
+		*fdfile = tofree;
 
 	return fd;
 
@@ -1132,6 +1132,7 @@ __releases(&files->file_lock)
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
+	struct file *fdfile = NULL;
 	struct files_struct *files = current->files;
 
 	if (!file)
@@ -1144,7 +1145,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
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
@@ -1216,6 +1220,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
 	struct file *file;
+	struct file *fdfile = NULL;
 	struct files_struct *files = current->files;
 
 	if ((flags & ~O_CLOEXEC) != 0)
@@ -1237,7 +1242,10 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 			goto Ebadf;
 		goto out_unlock;
 	}
-	return do_dup2(files, file, newfd, flags);
+	err = do_dup2(files, file, newfd, &fdfile, flags);
+	if (fdfile)
+		filp_close(fdfile, files);
+	return err;
 
 Ebadf:
 	err = -EBADF;
-- 
2.34.1

