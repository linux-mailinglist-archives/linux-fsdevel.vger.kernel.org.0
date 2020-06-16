Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63C1FA6B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 05:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFPDZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 23:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgFPDZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:25:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D9C08C5C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so7761544plt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOXpbwk+FYeg+wu5gfCMVFIRednwchEzSw3IN7NhShA=;
        b=Jegoy+ImIb22KyoXp2Lgme0ClHmOz9Blu6VsgODhiFeLlvX/BNBHxqFy1TJ1k+IXSY
         6JRHYPeSzrhzHZdeYziEblivMKh7b2Pf5h6pQwiMOm0Mkd0PHmLQOF3cSaJbex8DWg6M
         TM92HMSoujeVyauo9K44w0jWRKWz1xCKbKhAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOXpbwk+FYeg+wu5gfCMVFIRednwchEzSw3IN7NhShA=;
        b=EJKgz1+Sue0q2xWImUGrBFsatNsaqZSIz3LrRhvUsxog2f4oearXjxjl4RE1FfytfV
         I/26fxBYGQnlK1PQsa29+eZ9u4Pv2dTpxw48wiWtrvlwlgN8fuZi85ObzyPT08AjrT59
         5T4e/ho5m0X4Fi96TGVJr4eH8RdpTHqsjyEbuAyJ8j7iRCkA8aguDLElZrc0GINeKqwU
         q60DU53Qh3kY0fNNE19ogwlzY2khuoCppADltbBrdLMKdKgNlj0vEye3e2KFYWDqDwOU
         b425ot6G9IS3yNTDiobYC8/wrxAicMTZRkA66r+AnGFgGe2774TpQm1Iqo+uye+dvxNQ
         /f7A==
X-Gm-Message-State: AOAM530sLC6wFvcGCx8rRL9WwvSNpZEWw9twdifk2O7k8/GMQOsYlZZM
        zHfz7xjHNlco2h90+Yt7TYYp2w==
X-Google-Smtp-Source: ABdhPJwThdt6mE/aeL5PuxLl4Ur5r0/2jL7+3w7ytzuC9KloSLkl6RxwicPdEa4MwtjmwhcgzDbZhA==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr796521pjy.127.1592277929895;
        Mon, 15 Jun 2020 20:25:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm796010pjy.21.2020.06.15.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
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
Subject: [PATCH v4 03/11] fs: Add fd_install_received() wrapper for __fd_install_received()
Date:   Mon, 15 Jun 2020 20:25:16 -0700
Message-Id: <20200616032524.460144-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032524.460144-1-keescook@chromium.org>
References: <20200616032524.460144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For both pidfd and seccomp, the __user pointer is not used. Update
__fd_install_received() to make writing to ufd optional. (ufd
itself cannot checked for NULL because this changes the SCM_RIGHTS
interface behavior.) In these cases, the new fd needs to be returned
on success.  Update the existing callers to handle it. Add new wrapper
fd_install_received() for pidfd and seccomp that does not use the ufd
argument.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 26 +++++++++++++++++---------
 include/linux/file.h | 10 +++++++---
 net/compat.c         |  2 +-
 net/core/scm.c       |  2 +-
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index fcfddae0d252..14a8ef74efb2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -944,11 +944,14 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  * @o_flags: the O_* flags to apply to the new fd entry
  *
  * Installs a received file into the file descriptor table, with appropriate
- * checks and count updates. Optionally writes the fd number to userspace.
+ * checks and count updates. Optionally writes the fd number to userspace, if
+ * @ufd_required is true (@ufd cannot just be tested for NULL because NULL may
+ * actually get passed into SCM_RIGHTS).
  *
- * Returns -ve on error.
+ * Returns newly install fd or -ve on error.
  */
-int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_flags)
+int __fd_install_received(struct file *file, bool ufd_required, int __user *ufd,
+			  unsigned int o_flags)
 {
 	struct socket *sock;
 	int new_fd;
@@ -962,20 +965,25 @@ int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_fla
 	if (new_fd < 0)
 		return new_fd;
 
-	error = put_user(new_fd, ufd);
-	if (error) {
-		put_unused_fd(new_fd);
-		return error;
+	if (ufd_required) {
+		error = put_user(new_fd, ufd);
+		if (error) {
+			put_unused_fd(new_fd);
+			return error;
+		}
 	}
 
-	/* Bump the usage count and install the file. */
+	/* Bump the usage count and install the file. The resulting value of
+	 * "error" is ignored here since we only need to take action when
+	 * the file is a socket and testing "sock" for NULL is sufficient.
+	 */
 	sock = sock_from_file(file, &error);
 	if (sock) {
 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
 	fd_install(new_fd, get_file(file));
-	return 0;
+	return new_fd;
 }
 
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
diff --git a/include/linux/file.h b/include/linux/file.h
index fe18a1a0d555..999a2c56db07 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -91,12 +91,16 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __fd_install_received(struct file *file, int __user *ufd,
-				 unsigned int o_flags);
+extern int __fd_install_received(struct file *file, bool ufd_required,
+				 int __user *ufd, unsigned int o_flags);
 static inline int fd_install_received_user(struct file *file, int __user *ufd,
 					   unsigned int o_flags)
 {
-	return __fd_install_received(file, ufd, o_flags);
+	return __fd_install_received(file, true, ufd, o_flags);
+}
+static inline int fd_install_received(struct file *file, unsigned int o_flags)
+{
+	return __fd_install_received(file, false, NULL, o_flags);
 }
 
 extern void flush_delayed_fput(void);
diff --git a/net/compat.c b/net/compat.c
index 94f288e8dac5..71494337cca7 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -299,7 +299,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 
 	for (i = 0; i < fdmax; i++) {
 		err = fd_install_received_user(scm->fp->fp[i], cmsg_data + i, o_flags);
-		if (err)
+		if (err < 0)
 			break;
 	}
 
diff --git a/net/core/scm.c b/net/core/scm.c
index df190f1fdd28..b9a0442ebd26 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -307,7 +307,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 
 	for (i = 0; i < fdmax; i++) {
 		err = fd_install_received_user(scm->fp->fp[i], cmsg_data + i, o_flags);
-		if (err)
+		if (err < 0)
 			break;
 	}
 
-- 
2.25.1

