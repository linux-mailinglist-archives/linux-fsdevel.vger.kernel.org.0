Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371B6C76E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCXFPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCXFPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:15:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C85BA9;
        Thu, 23 Mar 2023 22:15:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-503e7129074so22340a12.0;
        Thu, 23 Mar 2023 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679634931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=dhKJYEY9brx8I5GN2so7PnXwGyEcq+T5oHCHsHYvXyNZpgvUlsKNQMlhPsexZ2Nr3G
         DRw9RmWZ+0ivmrE92AjSxqN3M7rk+5YYNoX15AqRMQ5UajlA1uZfRjdGSR6PUe1l6Jmh
         fXFRPAYuPbkCWRESBsOtXg+/blsPE9pX2t+RCIgUr3l4xd3KQf5pKvFP0AqoKWnJ/eCz
         K17VsdCP6gBCv2vyC6RpXWoeq/QhUGvvjFEOdJLQQb6Lt08C2ARm1XgqUI0NX/r8MSx/
         sDuEbMiTwRXllSFkyNdGmFWdM2XUZXy3a+Dvk/RmxRQuZVF0HevUZ/Z+01hSOT0xbeWB
         0k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679634931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=U/z9dC+ez83LRfCPoC0cSyKq7LhkF08LLdIHayAAWlfhaUWCEYUD+nRpYx4cKCMhLK
         ggfQ6LjvapTduRszZ77bkSA+Z2Knc8weSht814dBJr5Sd2mErtNMNrtNcPVlqGXrdUPN
         F561kkZS+JPN1e+CP5Rn/Gz9DelhNlZWV6RK9hag43LN1NvXE8O3S0IZFEeK92YomDQj
         KZwsX4u63KGCr3v2bk3lXPpezpm9/f2qeG0o6gtgPPNpB+NeUuWC0fRR3fW8GUmeg6F4
         8JyPdc6823a51I/pCrqbYWpsf4OZCq1mfL2/yuowJAtWKLdEjiicUZpAkDG/+Uaw3Yiy
         5bCw==
X-Gm-Message-State: AAQBX9eyVD6XdZGukTZNsdgyi5SMtscphGpLys1hY01rMmpiUwrLqnaW
        XNRsKYcwsUqS+fAQuj2K+64=
X-Google-Smtp-Source: AKy350YVdEmezbhKMbMk7ffRndPgKYnOEZuYloz1fKT/J/XeyPlY6ebwk0Zw8AjgCyfLpxiw6FTHrg==
X-Received: by 2002:a17:903:22ce:b0:19c:f005:92de with SMTP id y14-20020a17090322ce00b0019cf00592demr353804plg.4.1679634930675;
        Thu, 23 Mar 2023 22:15:30 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019b9a075f1fsm13246133plb.80.2023.03.23.22.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:15:30 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC v3 1/3] file: Introduce iterate_fd_locked
Date:   Fri, 24 Mar 2023 05:15:24 +0000
Message-Id: <20230324051526.963702-1-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Callers holding the files->file_lock lock can call iterate_fd_locked instead of
iterate_fd

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 fs/file.c               | 21 +++++++++++++++------
 include/linux/fdtable.h |  3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index c942c89ca4cd..4b2346b8a5ee 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1295,15 +1295,12 @@ int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 	return err;
 }
 
-int iterate_fd(struct files_struct *files, unsigned n,
-		int (*f)(const void *, struct file *, unsigned),
-		const void *p)
+int iterate_fd_locked(struct files_struct *files, unsigned n,
+                int (*f)(const void *, struct file *, unsigned),
+                const void *p)
 {
 	struct fdtable *fdt;
 	int res = 0;
-	if (!files)
-		return 0;
-	spin_lock(&files->file_lock);
 	for (fdt = files_fdtable(files); n < fdt->max_fds; n++) {
 		struct file *file;
 		file = rcu_dereference_check_fdtable(files, fdt->fd[n]);
@@ -1313,6 +1310,18 @@ int iterate_fd(struct files_struct *files, unsigned n,
 		if (res)
 			break;
 	}
+	return res;
+}
+
+int iterate_fd(struct files_struct *files, unsigned n,
+		int (*f)(const void *, struct file *, unsigned),
+		const void *p)
+{
+	int res = 0;
+	if (!files)
+		return 0;
+	spin_lock(&files->file_lock);
+	res = iterate_fd_locked(files, n, f, p);
 	spin_unlock(&files->file_lock);
 	return res;
 }
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..14882520d1fe 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -122,6 +122,9 @@ void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
+int iterate_fd_locked(struct files_struct *, unsigned,
+			int (*)(const void *, struct file *, unsigned),
+			const void *);
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.34.1

