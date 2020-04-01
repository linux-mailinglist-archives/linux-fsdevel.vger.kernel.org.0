Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2C19B7CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbgDAVj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 17:39:26 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44877 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbgDAVjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:39:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so896146pfb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DdrdrRerOMvkv7vzgvI3ttukeUZ2OpdhnLu+un2eV2s=;
        b=FeWGGGhwmXwPYJI7fgk1nXVyU38RCP6BF6eOwbkfauA5Lh/S0K7Nc0SIi0FDfzLZf/
         bBZtA01Z+mycAmiPQF6sdgjk5IWYb+EIHKaBqeFr9fpHlHKvNDviHMxgwnRIyxJ2QR+m
         FhGsIQS2Qu6FM71Bw7dEx5OsIbtQDambyY4fI9IepQU+Cs0Psa6YkBsLcX8FD8WIcBtp
         vBLKQP3cpYILo3x9L44bcB2+wn09ds8LLHXl7JYuY3kZHmAMRAlkc7Jl2jKOzPh1N4mo
         qnZvGI1i19BxSMYD89r0zKAZ5tBFZPiVCrcqrSEvreR+Eu5kKl7jbxfQkEj6DqoueZO0
         AaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DdrdrRerOMvkv7vzgvI3ttukeUZ2OpdhnLu+un2eV2s=;
        b=KL1xDtLdowroOfPFCz2PSbg0tJkGL1ahnLS1Eh7NZa2oamm/D0DmUinjzJRG8ZS2fn
         Wzprjvg4pG2brzYSvTcCDL3GNOCBpG98xlJkXRP6bjy9e8GnCS1PjJ635RFdfRphokNw
         LC9TbpHCV3k108sC5Jv4FG+So6PntdO0NHdZL2gR9x05HF5zLZaW6Bwaz7us5y7KH6YM
         0Pz6Gs07cBHWJoc2RBvrlsaWYgmNeAZRNVAunUk4Yz51sY53bNv9aLKIBcqdQM1y75W4
         osLpI4NJcuWy3NHAeW9WrVZAOnhznr2q3u0xLJnOPCYrhs5Xozc4A3UkcjEK8FVoyKnz
         gfuQ==
X-Gm-Message-State: AGi0PuY52kYdIP0xUF7Y276L8PYOtdnf5WTe8CIeZ2I4aVUHPi16xjVU
        HKti9lrY9Mj1bqsBzokp+LravSXvS/8=
X-Google-Smtp-Source: APiQypJjIzb/5kmrh3RqCS3HOgTi/GT8cY+ji3kV8XKRQ+4eFtBDnifNrAYKZFtkDdm/KNfMZ+0y3mX+CAA=
X-Received: by 2002:a17:90a:2147:: with SMTP id a65mr41318pje.176.1585777160964;
 Wed, 01 Apr 2020 14:39:20 -0700 (PDT)
Date:   Wed,  1 Apr 2020 14:39:03 -0700
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
Message-Id: <20200401213903.182112-4-dancol@google.com>
Mime-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v5 3/3] Wire UFFD up to SELinux
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
2.26.0.rc2.310.g2932bb562d-goog

