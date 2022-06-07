Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE580540276
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbiFGPcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbiFGPcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:32:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A6F551C;
        Tue,  7 Jun 2022 08:31:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v25so23515011eda.6;
        Tue, 07 Jun 2022 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0Hdg77AgoPG+P9TsvX0MGr6YMoh94u++wV7R/8mG6Q=;
        b=UrlZfICkRAZGfTAxgXamkUF1euwIXz/dlpvevt15u/GXuGmNhmXjx+8+VHEyd1fe8z
         Weg+hLtYIdvErfuTKGZe9T861PjQQqTb5yTkMVKRy2mRPzGshG+AtZSIJjfwnG8Hn7NF
         0t7ik+wYMi689h3lZ70iLHInepJesqv/anMj7Nze/F7nNvBynY0INZ61KE008DZagKul
         VtQ0A8MdGAjp/YefQZiN6B0tvOBfKQEgEwczSwGPRe3hhwXHFq4J1M+xIlrdmIPMyL5I
         zoYW8xs+KCy0qqsfPUO6lRVGof3loBpEaijhmdt86A39468D5vZIz/HW+vAldcF9cjwe
         JX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0Hdg77AgoPG+P9TsvX0MGr6YMoh94u++wV7R/8mG6Q=;
        b=lAOSNdcFH0mdIO35+CBZO3bWJ8cR/cWl1DEVQvmBO/F7ol9GiSZOx2Kj7NDi/HI2Zp
         Jtn/LG7kJOul1/Beuwe+5G0ZwNL1WGA+nVEfGM5BedNicYWwlSR0ByHaTu9sG78suATO
         ypH7kGJMIwJDFYZeC4iwCE+tmHLfMFT2XnO75yJvsCpXfAn1Pg3yBn2uXPk8NkTgvcCN
         ZtNy3IgOFdQFiPnSqV51vQgifdc+RPwotz/NXy3YNsIXVfHw5VIukltWJ4qKx1OvTiRg
         b4l0eequIe1H1jL19uawr4NaObpRHMvOIKOjhviru7F1j+KqY0hu5ThYUvEpeD1VVjMO
         /jyQ==
X-Gm-Message-State: AOAM5304QAxzT4OROE68R7YorXXOy+a9ZoDiV9ETelW7GeUbDHlzlW9s
        t+vXyhVt7fh29fiMTly1+cxhd/SsgQ8=
X-Google-Smtp-Source: ABdhPJw5O8Mix5sJdiw5XuZUUJ6C5dUvQIiC5WMe0/YwVvV1sO2SkEmWjUN8DtVmS9GesJcUxvlSug==
X-Received: by 2002:a05:6402:1341:b0:42a:f7cb:44dc with SMTP id y1-20020a056402134100b0042af7cb44dcmr34808302edw.165.1654615915837;
        Tue, 07 Jun 2022 08:31:55 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00701eb600df8sm8143445ejc.169.2022.06.07.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:31:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] f*xattr: allow O_PATH descriptors
Date:   Tue,  7 Jun 2022 17:31:39 +0200
Message-Id: <20220607153139.35588-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Miklos Szeredi <mszeredi@redhat.com>

Support file descriptors obtained via O_PATH for extended attribute
operations.

Extended attributes are for example used by SELinux for the security
context of file objects. To avoid time-of-check-time-of-use issues while
setting those contexts it is advisable to pin the file in question and
operate on a file descriptor instead of the path name. This can be
emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
which might not be mounted e.g. inside of chroots, see[2].

[1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f647376a7233d2ac2d12ca50
[2]: https://github.com/SELinuxProject/selinux/commit/de285252a1801397306032e070793889c9466845

Original patch by Miklos Szeredi <mszeredi@redhat.com>
https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915.11275-6-mszeredi@redhat.com/

> While this carries a minute risk of someone relying on the property of
> xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
> introducing another set of syscalls.
>
> Only file->f_path and file->f_inode are accessed in these functions.
>
> Current versions return EBADF, hence easy to detect the presense of
> this feature and fall back in case it's missing.

CC: linux-api@vger.kernel.org
CC: linux-man@vger.kernel.org
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/xattr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..16360ac4eb1b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -656,7 +656,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
@@ -768,7 +768,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -844,7 +844,7 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -910,7 +910,7 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
-- 
2.36.1

