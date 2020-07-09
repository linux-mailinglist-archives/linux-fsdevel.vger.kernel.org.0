Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395521A6F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGIS1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGIS0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B659C08E763
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k5so1153743plk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJiYhzlIZzEVYK6ZIPlChwBtenxUvsJSo/O6e2yKdEg=;
        b=Cx2Oix2p8lYtvtwbt6hUmNXSklM7Bve2iSMhcDMwSm7vQ354HNcuQcv1LsonNpXSZZ
         Q460I5MNIv0nRGKb5dqsv0fM3U0D8IIAlyiZPEu9nE9PIGNbZeCliGjnStF44qlphmJw
         1PL16qOYSqVrx1DzWUfUdQgnSRhC/vlDMXUEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJiYhzlIZzEVYK6ZIPlChwBtenxUvsJSo/O6e2yKdEg=;
        b=DQKQEqsOykyyllDiVwvfCxHaxvK+7dWx7LQRo9O553KK250KkaIZPD3EuCzhuoHI1Q
         lGaf3SkKdJE2MFNBm6PXreLOCWkU6rgdjvToPtoXbKn260k7A5v3VUqJYp0WyWPfhvYp
         /iEkk6kP8qUVgas1UroYOTpbsPsowVPhOTYCt2qgnDj5GpfCzL7pm9i91YQloASV8n/Y
         ksaBWU2FNoCYXLQgfQbAlwQTxXS964g5wOHVD/owOMbt8siKKejxoTONBy4quCMKZn8M
         WIcuBiBpiW+2TbPsv9YxvGALNPpcSnyc2Nc86kd6AHkHPde+WTPSvVF+vSzT6REP+xo8
         vRiQ==
X-Gm-Message-State: AOAM531CfYFq1Qm237bR/3lt4s4LBLjFttqU5yMn1zYIKFQAzDHDpYUL
        KBy6YfUtT7H/WWG9fCMXaO5cNw==
X-Google-Smtp-Source: ABdhPJxNls+NIWDSc1+phCZhIALivoZiFP/ZdCF/nMQBpVXcZPPnXShTI3OD7JsB8Psv6X1tuDBHKw==
X-Received: by 2002:a17:902:b284:: with SMTP id u4mr24325375plr.199.1594319211780;
        Thu, 09 Jul 2020 11:26:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k189sm3573115pfd.175.2020.07.09.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:47 -0700 (PDT)
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
Subject: [PATCH v7 4/9] fs: Move __scm_install_fd() to __receive_fd()
Date:   Thu,  9 Jul 2020 11:26:37 -0700
Message-Id: <20200709182642.1773477-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709182642.1773477-1-keescook@chromium.org>
References: <20200709182642.1773477-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for users of the "install a received file" logic outside
of net/ (pidfd and seccomp), relocate and rename __scm_install_fd() from
net/core/scm.c to __receive_fd() in fs/file.c, and provide a wrapper
named receive_fd_user(), as future patches will change the interface
to __receive_fd().

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/file.h |  8 ++++++++
 include/net/scm.h    |  1 -
 net/compat.c         |  2 +-
 net/core/scm.c       | 27 +--------------------------
 5 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index abb8b7081d7a..6220bf440809 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <net/sock.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -931,6 +932,46 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
+/**
+ * __receive_fd() - Install received file into file descriptor table
+ *
+ * @file: struct file that was received from another process
+ * @ufd: __user pointer to write new fd number to
+ * @o_flags: the O_* flags to apply to the new fd entry
+ *
+ * Installs a received file into the file descriptor table, with appropriate
+ * checks and count updates. Writes the fd number to userspace.
+ *
+ * This helper handles its own reference counting of the incoming
+ * struct file.
+ *
+ * Returns -ve on error.
+ */
+int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+{
+	int new_fd;
+	int error;
+
+	error = security_file_receive(file);
+	if (error)
+		return error;
+
+	new_fd = get_unused_fd_flags(o_flags);
+	if (new_fd < 0)
+		return new_fd;
+
+	error = put_user(new_fd, ufd);
+	if (error) {
+		put_unused_fd(new_fd);
+		return error;
+	}
+
+	/* Bump the sock usage counts, if any. */
+	__receive_sock(file);
+	fd_install(new_fd, get_file(file));
+	return 0;
+}
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 122f80084a3e..b14ff2ffd0bd 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -91,6 +91,14 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
+extern int __receive_fd(struct file *file, int __user *ufd,
+			unsigned int o_flags);
+static inline int receive_fd_user(struct file *file, int __user *ufd,
+				  unsigned int o_flags)
+{
+	return __receive_fd(file, ufd, o_flags);
+}
+
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
diff --git a/include/net/scm.h b/include/net/scm.h
index 581a94d6c613..1ce365f4c256 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -37,7 +37,6 @@ struct scm_cookie {
 #endif
 };
 
-int __scm_install_fd(struct file *file, int __user *ufd, unsigned int o_flags);
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
 void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
diff --git a/net/compat.c b/net/compat.c
index 27d477fdcaa0..e74cd3dae8b0 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -298,7 +298,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
 		if (err)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index 44f03213dcab..67c166a7820d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -280,31 +280,6 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
 }
 EXPORT_SYMBOL(put_cmsg_scm_timestamping);
 
-int __scm_install_fd(struct file *file, int __user *ufd, unsigned int o_flags)
-{
-	int new_fd;
-	int error;
-
-	error = security_file_receive(file);
-	if (error)
-		return error;
-
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
-
-	error = put_user(new_fd, ufd);
-	if (error) {
-		put_unused_fd(new_fd);
-		return error;
-	}
-
-	/* Bump the sock usage counts, if any. */
-	__receive_sock(file);
-	fd_install(new_fd, get_file(file));
-	return 0;
-}
-
 static int scm_max_fds(struct msghdr *msg)
 {
 	if (msg->msg_controllen <= sizeof(struct cmsghdr))
@@ -331,7 +306,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
 		if (err)
 			break;
 	}
-- 
2.25.1

