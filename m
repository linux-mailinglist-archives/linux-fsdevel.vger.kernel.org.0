Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CD194652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgCZSP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 14:15:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38414 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgCZSP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:15:28 -0400
Received: by mail-pl1-f201.google.com with SMTP id r16so4903318pls.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REBj1fgB1itW3afNpdBeCKHTfmMER4muP4nMI9CXCW4=;
        b=De+vdbSmZ4eV+CJ+UxFZBhShe8zH/Qk26KK8CRGODde3/2Qi8B5S/N2lYhGdR9yD2U
         hPM6WHzB1LTjWX/roz7FcosVAFpwn9uha+5en/xMUBaugZcCu/YIBgBvQGtBUpZUwWZQ
         Yi7CBHzjA1yN9GVu/Z7i9C+4Xry+g5D46J3/OZB/pkaasGKOwmkWPkmFiuWRffJrTY8Z
         kTsCbX7z3IaVClheuxQ8416BFeCjQSRbWgs1GcEoe6K1yA68Zeue9kMNA9Id9SjEM81w
         iXBmQJlFNC0CXF/4xW50ke/+f3lnOzc0rz+264IkbICCJIlYAFn96I220W+S6izkKbst
         kpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REBj1fgB1itW3afNpdBeCKHTfmMER4muP4nMI9CXCW4=;
        b=kNfl+5HqzViHz0D8t/lskLa4qPp7htrXDGJ82/uKpEX9BfiqYmnjnbv4iIQRFPbPoS
         /AT3eUesW+auHfqGw1m372Bel3pNzw9wMB7AscHPk2WC/qlAzltj9I2X/zvjNuCZOQLn
         E4j1ir4/Ks7bQP7CAt5GsdrRyS+SLQA6Vu8hTiwgwf8B84eohGo3qyiiYaXhXL9ombE9
         9n5QXeAT45V+e81N44TIdO0NlJUxTv2q/pV39Py8frZMFJSlmm+tuj6J0Rr7IHPKSCQk
         0pXD+uNC1FeWYIy1vPEbtQbtOMpH6MX6WIBwB05Dn4iSsyTuAXYAPrMF5zCYd2aDXjij
         6hZg==
X-Gm-Message-State: ANhLgQ2UMkxG6d3iS64CKhFT9Iu8asmTCGgDkD7mOzz5lULK7nDzVAMq
        daVzEI0aG5DcaSldMPkFuOcXU/tZTOQ=
X-Google-Smtp-Source: ADFU+vuC4qedai97AsQzom+MPyQbpmPdnQ6oRFaE8QGT9W4/tlMA0F0FEEUIYjLnEYqJfkFHHc97xMWVyOA=
X-Received: by 2002:a63:ff53:: with SMTP id s19mr9927452pgk.247.1585246525869;
 Thu, 26 Mar 2020 11:15:25 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:14:56 -0700
In-Reply-To: <20200326181456.132742-1-dancol@google.com>
Message-Id: <20200326181456.132742-4-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com> <20200326181456.132742-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 3/3] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07b0f6e03849..78ff5d898733 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -76,6 +76,8 @@ struct userfaultfd_ctx {
 	bool mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
 	struct mm_struct *mm;
+	/* The inode that owns this context --- not a strong reference.  */
+	const struct inode *owner;
 };
 
 struct userfaultfd_fork_ctx {
@@ -1014,14 +1016,18 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	}
 }
 
+static const struct file_operations userfaultfd_fops;
+
 static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 				  struct userfaultfd_ctx *new,
 				  struct uffd_msg *msg)
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure(
+		"[userfaultfd]", &userfaultfd_fops, new,
+		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
+		ctx->owner);
 	if (fd < 0)
 		return fd;
 
@@ -1918,7 +1924,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-const struct file_operations userfaultfd_fops = {
+static const struct file_operations userfaultfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= userfaultfd_show_fdinfo,
 #endif
@@ -1943,6 +1949,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	struct file *file;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1972,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	file = anon_inode_getfile_secure(
+		"[userfaultfd]", &userfaultfd_fops, ctx,
+		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+		NULL);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		goto out;
+	}
+
+	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		fput(file);
+		goto out;
+	}
+
+	ctx->owner = file_inode(file);
+	fd_install(fd, file);
+
+out:
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.25.1.696.g5e7596f4ac-goog

