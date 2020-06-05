Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBB1EFD24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgFEQAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFEQAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:00:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E02C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 09:00:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so5318111pgn.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOHx3JtZHl4XxOR183MPHxc1YyQEXr9//zjD6wPWK5c=;
        b=AYM1SME2Yfp8Xp3XxiCuKbsb/mxLno+9x6Tvnx0AKRTBFR+Vyg+D0jJsDdO6B008gJ
         j5cR/0Kki2xB3IEr7YyNhWdFsN1hYKuv0eVUgkVN7P1iFoWJU4m2y+AVWl/YWwRjCuX0
         L63p9QE40scOglygoynUT1EFudt2cy5+UMbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOHx3JtZHl4XxOR183MPHxc1YyQEXr9//zjD6wPWK5c=;
        b=d+vyJE6QQeKzjwcFSqaQ3fyjq042XsQqhrPDlQwagNTSz6mv+/cePt/x6RcAiEeXJd
         8iBOKlNZbozw5kdMUtvV4nAjpQFR0gpVtbx+c1NJg7kSRxuazz8dzZPF+EM1T3SaX94E
         /1SrenDK7z5qqRP3A5XZKvKxRRvp7yP6TfcA3Z1GlbWms/VCyyniZrejCWyP5ekck6CP
         v/XgTSUFuLm/jwVp3uX8psOO4aakfPJZneMFvu3GaXLModQR0NlFpvfPptLpJxSH8a4F
         53jGWfG310fWy6oOxs/QJYTdxDKxAFvH1P1cqA1mKKlW8hEBbgyiT2vEgJxoSh0QIJsJ
         qVyg==
X-Gm-Message-State: AOAM532EdgWJ8EouM4RE4NT0lCcCXX+4bghtDzdGc7ryUb2f5EL1sS8K
        7dW5XI5PLu1cknlNad1F0MTPQQ==
X-Google-Smtp-Source: ABdhPJyVjuUcteaqY/mcT8ScT3S6QTSiJYt9wnTPuDWOo6anaUmiM00CCJIUs5IvLlBc1Bo5bes43g==
X-Received: by 2002:a63:f14a:: with SMTP id o10mr10411918pgk.216.1591372819568;
        Fri, 05 Jun 2020 09:00:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm68354pfn.6.2020.06.05.09.00.17
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
Subject: [PATCH v2 3/3] exec: Move path_noexec() check earlier
Date:   Fri,  5 Jun 2020 09:00:13 -0700
Message-Id: <20200605160013.3954297-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605160013.3954297-1-keescook@chromium.org>
References: <20200605160013.3954297-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The path_noexec() check, like the regular file check, was happening too
late, letting LSMs see impossible execve()s. Check it earlier as well
in may_open() and collect the redundant fs/exec.c path_noexec() test
under the same robustness comment as the S_ISREG() check.

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
                    /* new location of MAY_EXEC vs path_noexec() test */
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        security_file_open(f)
                        open()
    /* old location of path_noexec() test */

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c  | 12 ++++--------
 fs/namei.c |  4 ++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2b708629dcd6..7ac50a260df3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -145,10 +145,8 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	 * and check again at the very end too.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
-		goto exit;
-
-	if (path_noexec(&file->f_path))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+			 path_noexec(&file->f_path)))
 		goto exit;
 
 	fsnotify_open(file);
@@ -871,10 +869,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	 * and check again at the very end too.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
-		goto exit;
-
-	if (path_noexec(&file->f_path))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+			 path_noexec(&file->f_path)))
 		goto exit;
 
 	err = deny_write_access(file);
diff --git a/fs/namei.c b/fs/namei.c
index 0a759b68d66e..41e6fed8ce69 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2849,6 +2849,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;
+	case S_IFREG:
+		if ((acc_mode & MAY_EXEC) && path_noexec(path))
+			return -EACCES;
+		break;
 	}
 
 	error = inode_permission(inode, MAY_OPEN | acc_mode);
-- 
2.25.1

