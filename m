Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1767AE07F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjIYU4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYUz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:55:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64F180;
        Mon, 25 Sep 2023 13:55:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf3f59905so886609266b.3;
        Mon, 25 Sep 2023 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695675351; x=1696280151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqCt6JwiCOkZZaJC5IQZARnFIIp0VwWgUE64FLRm04k=;
        b=XEkjk89iabc0nmDNqhNuf5ZDIxTEEcBbsJpiDrh7TSdlbh/aqxHs7WjyioxqLIkB9i
         s4XxPMhf48YEzuYcn/5vYqhlthxBemyPlBqGspOlT6RHs9EHHIC8V1x1NPwytc/UpCUV
         n59Hu1/GrRCxgD+d84N7T0Z9IJ3E3GPx8SkC5eRjaisy5F0Egu4YNdCKkv9sWCmEqaIo
         s9K6y+qCGG6PNGsrFWKGz60M1KBzkuLjMrIERhWcvqCf2PtqxYTbztYcrCnXntuiqb3l
         KzTaWxtSl3kiTfp2rICt3e2MC6nojCQ6aX1I256jOViSfMdfAE2+gRmOi2SG8BIztZxc
         43bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675351; x=1696280151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqCt6JwiCOkZZaJC5IQZARnFIIp0VwWgUE64FLRm04k=;
        b=swD4Iy0Ax1jRacWG/2FcJD/yPw2lf8zssN2xLiNpIKc5a13rD2q71YocIsSbyVVBZP
         /C/bK9l+L1jDvNNYpBGnOcC1LyKDcMSsEDsT3zaycyg10h/ON2m+AdpcM1Y0WYKh2PXF
         +QI+/BAu6RBwGfqOKvfdJFHFXu+FxJGmj+oaJXJnJSHAHfFfjLz1qA8cKLHOm+B5+dJb
         y23beLRhGZjZXQnhYPPDpSfB5FIJPggnCbxkZLDK4985ZKLE1toUEBnIvTiipYlzC9K8
         X5E3+5iL4Ui3axVrIadKQKxmKi9tooxuSZ2Pjp6TXKFtjS4uY95bKWY0446LNcndcCC5
         j0Pw==
X-Gm-Message-State: AOJu0Yw+/8tQ3hA+whIxrqOroRfu5sejHg+evJIX/H2dAAOftDLixEj1
        x7JFZVFLpwheNWC5l3zJRas=
X-Google-Smtp-Source: AGHT+IExNVYjC7Q5VDEbkKf7d89D/MJHrDMgaWYvjkGbyT78VB1cYYWG570TN6Ye7Trfv2C2hrjkLg==
X-Received: by 2002:a17:906:23ea:b0:9ae:65fc:be7 with SMTP id j10-20020a17090623ea00b009ae65fc0be7mr6896502ejg.17.1695675351020;
        Mon, 25 Sep 2023 13:55:51 -0700 (PDT)
Received: from f.. (cst-prg-24-34.cust.vodafone.cz. [46.135.24.34])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm6769302ejc.84.2023.09.25.13.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 13:55:50 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: shave work on failed file open
Date:   Mon, 25 Sep 2023 22:55:45 +0200
Message-Id: <20230925205545.4135472-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Failed opens (mostly ENOENT) legitimately happen a lot, for example here
are stats from stracing kernel build for few seconds (strace -fc make):

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ------------------
    0.76    0.076233           5     15040      3688 openat

(this is tons of header files tried in different paths)

Apart from a rare corner case where the file object is fully constructed
and we need to abort, there is a lot of overhead which can be avoided.

Most notably delegation of freeing to task_work, which comes with an
enormous cost (see 021a160abf62 ("fs: use __fput_sync in close(2)" for
an example).

Benched with will-it-scale with a custom testcase based on
tests/open1.c:
[snip]
        while (1) {
                int fd = open("/tmp/nonexistent", O_RDONLY);
                assert(fd == -1);

                (*iterations)++;
        }
[/snip]

Sapphire Rapids, one worker in single-threaded case (ops/s):
before:	1950013
after:	2914973 (+49%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file_table.c      | 39 +++++++++++++++++++++++++++++++++++++++
 fs/namei.c           |  2 +-
 include/linux/file.h |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3da9d08..320dc1f9aa0e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -82,6 +82,16 @@ static inline void file_free(struct file *f)
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 
+static inline void file_free_badopen(struct file *f)
+{
+	BUG_ON(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
+	security_file_free(f);
+	put_cred(f->f_cred);
+	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
+		percpu_counter_dec(&nr_files);
+	kmem_cache_free(filp_cachep, f);
+}
+
 /*
  * Return the total number of open files in the system
  */
@@ -468,6 +478,35 @@ void __fput_sync(struct file *file)
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
+/*
+ * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
+ *
+ * This represents opportunities to shave on work in the common case compared
+ * to the usual fput:
+ * 1. vast majority of the time FMODE_OPENED is not set, meaning there is no
+ *    need to delegate to task_work
+ * 2. if the above holds then we are guaranteed we have the only reference with
+ *    nobody else seeing the file, thus no need to use atomics to release it
+ * 3. then there is no need to delegate freeing to RCU
+ */
+void fput_badopen(struct file *file)
+{
+	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
+		fput(file);
+		return;
+	}
+
+	if (WARN_ON(atomic_long_read(&file->f_count) != 1)) {
+		fput(file);
+		return;
+	}
+
+	/* zero out the ref count to appease possible asserts */
+	atomic_long_set(&file->f_count, 0);
+	file_free_badopen(file);
+}
+EXPORT_SYMBOL(fput_badopen);
+
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..67579fe30b28 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3802,7 +3802,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	fput(file);
+	fput_badopen(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;
diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d29343..96300e27d9a8 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -15,6 +15,7 @@
 struct file;
 
 extern void fput(struct file *);
+extern void fput_badopen(struct file *);
 
 struct file_operations;
 struct task_struct;
-- 
2.39.2

