Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8E21A6D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGIS06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgGIS04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C74C08E8AB
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so1487152pjt.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9EvYkpK8m2+eOZfx9Q9uzmaDoSgXM6/WboltFVCshE=;
        b=fOSIJ+Sgip42jp27tz4InB+igGqj6wu3SRAzdjCsack3vu0Qh5VUr694HYRBKAK8DA
         vO2bI0cKp0b0Uo8qLGwo12xSeFZZFLL5h6rfdt9IdzIpqDwqImYiW33UIiz4mhSZ1Bi8
         uMB8wurGC4s9lzvPZpZLUfsEVT6tzdAJFlg7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9EvYkpK8m2+eOZfx9Q9uzmaDoSgXM6/WboltFVCshE=;
        b=NrnpKLIKMmcMqpdJ81ajQ1o2LkHSQD4QeAz+HZjz+5CWYkqB2MnG3I56kAJL5FSbrZ
         OMryI3EENfuLn/7yJFb1z7ukGgozhTDoMOfMN336mNRbvjS4vugtjDPDNwPqBJGecQnm
         rZDvFuFw+zFYfspO7HJK8bI+9mSVXCdKMOuu5PKAK+fCSbv2YUZNImWcc/VQB57tmXwR
         vSmjGULw4Im5Hc06fPfH9DGVw8xWR1+DEy3qYr15RyrjdCVL8zExS8zEgrYcY48jyEWX
         GYuAVpaucF20zkwsfeG7jZCenZEAAkpP8Q2mD0JGh2thyWMfSOttbm7KvtzbVO2+8l8N
         Ftdw==
X-Gm-Message-State: AOAM530i8ucDE+xbnOvSsXrzp+GqEMfTnRHwB3nnNS2DqCUJER97wLq1
        ExJ+EBLkcDuXVFkZN9lwGF1/xA==
X-Google-Smtp-Source: ABdhPJzOiJdo9XUhfFmzsLtKE9Q4WqODbec7Lh1dEoOnSgjn1Ka/VvFiaw9y4DfHmmNv9NU8D+hzRg==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr1512547pjt.35.1594319214617;
        Thu, 09 Jul 2020 11:26:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm3364322pji.2.2020.07.09.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 7/9] fs: Expand __receive_fd() to accept existing fd
Date:   Thu,  9 Jul 2020 11:26:40 -0700
Message-Id: <20200709182642.1773477-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709182642.1773477-1-keescook@chromium.org>
References: <20200709182642.1773477-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expand __receive_fd() with support for replace_fd() for the coming seccomp
"addfd" ioctl(). Add new wrapper receive_fd_replace() for the new behavior
and update existing wrappers to retain old behavior.

Thanks to Colin Ian King <colin.king@canonical.com> for pointing out an
uninitialized variable exposure in an earlier version of this patch.

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 25 +++++++++++++++++++------
 include/linux/file.h | 10 +++++++---
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 87954bab9306..feebdc17bf46 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -935,6 +935,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 /**
  * __receive_fd() - Install received file into file descriptor table
  *
+ * @fd: fd to install into (if negative, a new fd will be allocated)
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -948,7 +949,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flags)
 {
 	int new_fd;
 	int error;
@@ -957,21 +958,33 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	if (fd < 0) {
+		new_fd = get_unused_fd_flags(o_flags);
+		if (new_fd < 0)
+			return new_fd;
+	} else {
+		new_fd = fd;
+	}
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
 		if (error) {
-			put_unused_fd(new_fd);
+			if (fd < 0)
+				put_unused_fd(new_fd);
 			return error;
 		}
 	}
 
+	if (fd < 0) {
+		fd_install(new_fd, get_file(file));
+	} else {
+		error = replace_fd(new_fd, file, o_flags);
+		if (error)
+			return error;
+	}
+
 	/* Bump the sock usage counts, if any. */
 	__receive_sock(file);
-	fd_install(new_fd, get_file(file));
 	return new_fd;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index d9fee9f5c8da..225982792fa2 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,18 +92,22 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __receive_fd(struct file *file, int __user *ufd,
+extern int __receive_fd(int fd, struct file *file, int __user *ufd,
 			unsigned int o_flags);
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
 	if (ufd == NULL)
 		return -EFAULT;
-	return __receive_fd(file, ufd, o_flags);
+	return __receive_fd(-1, file, ufd, o_flags);
 }
 static inline int receive_fd(struct file *file, unsigned int o_flags)
 {
-	return __receive_fd(file, NULL, o_flags);
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(fd, file, NULL, o_flags);
 }
 
 extern void flush_delayed_fput(void);
-- 
2.25.1

