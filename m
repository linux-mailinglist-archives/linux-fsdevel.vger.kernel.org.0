Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992B71EFD25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgFEQAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgFEQAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:00:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F83C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 09:00:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so3800163plr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0tj7ZRQcqs9EAMR7yZ0YohYSJEyPMdy0UQUKUwvaMk=;
        b=etJv22UiizXcOPPR3QeA8jUp00pOEYSdiCq8cCt5HTmL1jQ4/toR6XXIwLOa79kL3X
         ICYfwWpUBHiMGKWBUKSWBezDpOO4mZgjtt+2LNCWQVvfWZzVGgRi7Rqn16a04nTuBkAI
         o/xXMJAQurA2tye7S7Hf4piSybDvjCjQxO2l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0tj7ZRQcqs9EAMR7yZ0YohYSJEyPMdy0UQUKUwvaMk=;
        b=rZ5SAa1F7E8aVibJ1xr9FkSYkacE47ZUH7ihUPFDjnH7lb8IPM6OL7NrlXx6c2TeZO
         RW3OVtKWfGKRMVi075e2rRifCIJAJw7dQeHtEK8G7WLkxOe1NkvB8VAxU170x6oPgbvm
         qhTJ2F0ssaK9lmJj45CDn/OhnBMhOQnU+kVjwivnkmguei4im8fVqUpnf6gtM+FI4d8Q
         tyz4x4Ukic+9KxeOJJxjyUVtB+lvVOz8ybEdGjKmOpvq6fIqL7PS5stz/45adkLApcwU
         xgFO014R/7Mtmq4/HFKRlx0t2XKbemYUSXTZfavhBqzW3i/cMutX0rP2Zb0Yg+muI9bi
         IwJQ==
X-Gm-Message-State: AOAM530lwUvXckv57Pj8e4wdaGoPNCrAKZVhSXH6m5OrPASxIgmHF2HV
        wCNlKgtV6/J/vysQnR1LIa/oCQ==
X-Google-Smtp-Source: ABdhPJw47pfX2wU4KqgnZEv6dlZXrppX08ucCGrHpYKRci0esfbebI7oZ/Y+rv79S512gq1xF0XpNg==
X-Received: by 2002:a17:90a:a405:: with SMTP id y5mr3778701pjp.15.1591372818957;
        Fri, 05 Jun 2020 09:00:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm56993pgl.12.2020.06.05.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:00:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] exec: Move S_ISREG() check earlier
Date:   Fri,  5 Jun 2020 09:00:12 -0700
Message-Id: <20200605160013.3954297-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605160013.3954297-1-keescook@chromium.org>
References: <20200605160013.3954297-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The execve(2)/uselib(2) syscalls have always rejected non-regular
files. Recently, it was noticed that a deadlock was introduced when trying
to execute pipes, as the S_ISREG() test was happening too late. This was
fixed in commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
during execve()"), but it was added after inode_permission() had already
run, which meant LSMs could see bogus attempts to execute non-regular
files.

Move the test into the other inode type checks (which already look
for other pathological conditions[1]). Since there is no need to use
FMODE_EXEC while we still have access to "acc_mode", also switch the
test to MAY_EXEC.

Also include a comment with the redundant S_ISREG() checks at the end of
execve(2)/uselib(2) to note that they are present to avoid any mistakes.

My notes on the call path, and related arguments, checks, etc:

do_open_execat()
    struct open_flags open_exec_flags = {
        .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
        .acc_mode = MAY_EXEC,
        ...
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
                may_open(path, acc_mode, open_flag)
		    /* new location of MAY_EXEC vs S_ISREG() test */
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        /* old location of FMODE_EXEC vs S_ISREG() test */
                        security_file_open(f)
                        open()

[1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c  | 14 ++++++++++++--
 fs/namei.c |  6 ++++--
 fs/open.c  |  6 ------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 30735ce1dc0e..2b708629dcd6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -139,8 +139,13 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * may_open() has already checked for this, so it should be
+	 * impossible to trip now. But we need to be extra cautious
+	 * and check again at the very end too.
+	 */
 	error = -EACCES;
-	if (!S_ISREG(file_inode(file)->i_mode))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		goto exit;
 
 	if (path_noexec(&file->f_path))
@@ -860,8 +865,13 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * may_open() has already checked for this, so it should be
+	 * impossible to trip now. But we need to be extra cautious
+	 * and check again at the very end too.
+	 */
 	err = -EACCES;
-	if (!S_ISREG(file_inode(file)->i_mode))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		goto exit;
 
 	if (path_noexec(&file->f_path))
diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..0a759b68d66e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2835,16 +2835,18 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	case S_IFLNK:
 		return -ELOOP;
 	case S_IFDIR:
-		if (acc_mode & MAY_WRITE)
+		if (acc_mode & (MAY_WRITE | MAY_EXEC))
 			return -EISDIR;
 		break;
 	case S_IFBLK:
 	case S_IFCHR:
 		if (!may_open_dev(path))
 			return -EACCES;
-		/*FALLTHRU*/
+		fallthrough;
 	case S_IFIFO:
 	case S_IFSOCK:
+		if (acc_mode & MAY_EXEC)
+			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;
 	}
diff --git a/fs/open.c b/fs/open.c
index 719b320ede52..bb16e4e3cd57 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -753,12 +753,6 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
-	/* Any file opened for execve()/uselib() has to be a regular file. */
-	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
-		error = -EACCES;
-		goto cleanup_file;
-	}
-
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
-- 
2.25.1

