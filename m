Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FD19485B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgCZUG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:06:58 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44936 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgCZUGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:06:54 -0400
Received: by mail-vk1-f202.google.com with SMTP id k67so2092600vka.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y8Q8F3IH8c2hotjV+QMJ3kSw7Jeojd38t24yU7GezVM=;
        b=lPpmx9yPrL/MYyExIQJGT42ZfXmoCaxGEUrGYFUYgtzqZErnqz25tEHuBVs6UbKG03
         cbq05kXjAStd0QUwzzsPx/m4hLKByFqoRBu0ZMko8DOGfpMbfqphPTAc1n4aoSx+jUiD
         GUkRqspDcIHkNyB21E+AmXM76aByOoFTLmj5Z68AhLoDMFd2yhNWF9wo2X0u1uuBOqyP
         yWaZ/1SYoC2exZSC6kN0hyxiU7LLLW36qCYgUEFeqhpAMNQye8oOAMZk5AE/478eAua1
         38w9tfa8n6lzqlf4LQ8lmPqLhDyBDGb2agpgeh/LtUoaVTpE4nt/fnX+IkzbBesH8+78
         Azyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y8Q8F3IH8c2hotjV+QMJ3kSw7Jeojd38t24yU7GezVM=;
        b=pVQoFbGJr1t2uEZAk0w9POFIUbVSzFgF9DCo+C1zz8uwrhCa8vlcPRf5+ObylCKSN6
         Kz0LngcRYV7fQlyOxmma2xSn7EBTpHbwsh2ZSFlnuhPXj6deI4lzNSYJwTdXYEgI8plq
         ZJW08PzFbcNA9oLkYAAJR+SufeP1o0LvxcyL5HvST7CGpzSuDMPM0+ZHHqiL7fZh3hg0
         dvmLEgYhsmOiJRAyp0xdV7Lfh/Ru7W7QecA8FW9WbEGtqkElwLZs61NPLUiGJB177OU9
         mJrC6IghnkQhw6nKTbR8Pq+gE6G6aTnViPGeplqmfIG3Im/rLkhVri10ZIk35osSGdaJ
         WUPg==
X-Gm-Message-State: ANhLgQ2quqVuYndeo3WPoCrv7ImF4psbPDQyrq8SS5kz83UZNlfNHc7W
        E7NsBziLSXAgVoqakSSccMu4lNGnRo4=
X-Google-Smtp-Source: ADFU+vusyX36d2CY3Mx/oaqEexC02/Z3H/IlNDB9bKUbWp7T4L1OJf34Zf2nIPvcXbTAxx7+cBlBgkr2U4g=
X-Received: by 2002:ab0:424:: with SMTP id 33mr8765913uav.143.1585253213293;
 Thu, 26 Mar 2020 13:06:53 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:06:34 -0700
In-Reply-To: <20200326200634.222009-1-dancol@google.com>
Message-Id: <20200326200634.222009-4-dancol@google.com>
Mime-Version: 1.0
References: <20200326181456.132742-1-dancol@google.com> <20200326200634.222009-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4 3/3] Wire UFFD up to SELinux
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
 fs/userfaultfd.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..78ff5d898733 100644
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
@@ -1022,8 +1024,10 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
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
 
@@ -1945,6 +1949,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	struct file *file;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1974,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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

