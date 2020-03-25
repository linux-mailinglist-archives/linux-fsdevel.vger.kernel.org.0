Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D685119342B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCYXEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 19:04:05 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:38127 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgCYXEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:04:04 -0400
Received: by mail-ua1-f74.google.com with SMTP id t10so1569599uaj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REBj1fgB1itW3afNpdBeCKHTfmMER4muP4nMI9CXCW4=;
        b=i7ZOUHjbFgVx+s0UVSJIf8vLWEPboaP6kvpQJDJL8TGrAnhcez44af9mv/98ocfWvE
         GYIilsL5kfd5pBocqpSxRvgmC6d4prkhqUf6/hAq0fzS9gyQBoAqZDnaDyj6BDqkos5n
         WMn3smxCXwJBxZUygM0ar+EiLI8WqAA2U3mNbN/HevW0K9j2aMdlG7sgml+Z1FphTgG5
         Q5go7scoS9bb5Ql8ljMb2itbIVAq8j5ALe6yGzKx49cTmyrknkkLRIwiDaCfmn9uk5Ce
         ZepD2ALjcmb8yILx8yJS8mqMhxVHW2hUWj6XhS7YPWe15bEY6nCH1QAZ9aJIdW5/dKDh
         2WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REBj1fgB1itW3afNpdBeCKHTfmMER4muP4nMI9CXCW4=;
        b=m3PYsclndsacdGge16tvJGtVqB0xbkLXVVrTATuKw1U1Fb3aYIWr9FqHVAt1xCy4bu
         TnIN/aULvz8RRxozWGEGCb2WEaj//gfd48cPYRihxLYwOZcM7fMRPMkBNva1A4Cvf51q
         SC1l+/em1100Rh3ds26r4Tlj5nhFS4zQsE/RKuafTIo+X0sfX6cxDlVU9mgZ8aBNMGgy
         GRh6guNNTENGfvpRHQ/X5X7HXiSYUkbSNK0eTfIn5YPrxqOIw1CejdudEL1YWFSIEoUO
         U9foHEl6qYqHJ3puMxaXfoIyWvLRMk/L1Gt8m7ittOZts/0Z79F/1XwlPAeZ60lsG5+r
         AbIg==
X-Gm-Message-State: ANhLgQ0I1OQ8X9x797qYX6BkD5BW+tzPUkarPEg6fZh2vQsdFg7uRzHC
        yTBEf54rqU3Bwvq+CzhD5bIDKBnAUGg=
X-Google-Smtp-Source: ADFU+vs7IQhEMaKxtqnr+moo0vZvstvYbRtR5UCcCU4RfI+0ZcWfHjbWDnDHCtb/iWz2nYKBCZvXwQ28Ff8=
X-Received: by 2002:a1f:f884:: with SMTP id w126mr4386443vkh.41.1585177443359;
 Wed, 25 Mar 2020 16:04:03 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:02:49 -0700
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200325230245.184786-4-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 3/3] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
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

