Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12CB1D7097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 07:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgERFzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 01:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgERFzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 01:55:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D4C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 22:55:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so4329159pfk.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 22:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Q1i6oRikNLeZklgvYSkpM1EVlw/CTM/4XamXlqlvKw=;
        b=PmmADXwv4NMqpXwbOWvucRxbEW9uHuZYDIxA2TsDvioy03mFxkJduyC+qs3bYF9f9P
         RvWd0e5uTz+r6q0dgzc030QSXDeIb2IuAljXkzaNUw6EKUgZTTBgPxbOHwMbML23cg7F
         sB4mfaMCVqy2DoEsEuRAteyVH/1UNqIKq13s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Q1i6oRikNLeZklgvYSkpM1EVlw/CTM/4XamXlqlvKw=;
        b=s7CMADLv0zXMADf2WZLIlI9KQdxZXJ1jMZUL2ovFoqK1cZWRMPQZTAPoj7hFrCMx99
         LhxggPdDaVgh/5eVZ0dZlnEuyXwHSDmkaho+XFDnchl1y6Dh9fhmdJ68wqcGbt99ux01
         3BnYPcGHvnPAVpDMAUbPcpJTcsFuh03MCioQjbr2yWS+Jl9NH9R9FejAvLnb8LS9wysn
         9B1THh4diVbvj6InCWr/v+ft8SompY+TnlDzgHGwP1E4ErEAnXKVvnoS8SP0qQ5TU29l
         ejj5z5PMo7Tb7WCtaOBm0i7hO8gd8ccs1Gk+AGa8QGSqQkSfF3SzucCzPyxXH/12fSA0
         p1Vg==
X-Gm-Message-State: AOAM533B4u2anL7nE+6wgK2c/5Btf9GlnYpvCi0blXscL2n8uTYN3b09
        gfeS2gl0GIhQuvE2NgXXJZBXvg==
X-Google-Smtp-Source: ABdhPJwH6ud9V9wj2fVaRFrgEB2v7VP/Tc4l2Vb30aDG6ICq9TytrkA9z9Q8L1Shdn9DcbSlyL70DQ==
X-Received: by 2002:a63:3c53:: with SMTP id i19mr13366855pgn.147.1589781306926;
        Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm4143998pgo.7.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] exec: Relocate S_ISREG() check
Date:   Sun, 17 May 2020 22:54:55 -0700
Message-Id: <20200518055457.12302-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org>
References: <20200518055457.12302-1-keescook@chromium.org>
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
files. Move the test earlier.

Also include a comment with the redundant S_ISREG() checks at the end of
execve(2)/uselib(2) to note that they are present to avoid any mistakes.

Finally, instead of dereferencing the inode, use dcache for S_ISREG()
test.

My notes on the call path, and related arguments, checks, etc:

do_open_execat()
    struct open_flags open_exec_flags = {
        .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC, ...
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            /* f_mode populated from open_flags in alloc_empty_file() */
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
		/* new location of FMODE_EXEC vs S_ISREG() test */
                may_open(path, acc_mode, open_flag)
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        /* old location of FMODE_EXEC vs S_ISREG() test */
                        security_file_open(f)
                        open()

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c  | 8 ++++++++
 fs/namei.c | 4 ++++
 fs/open.c  | 6 ------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 30735ce1dc0e..f0c80a8b9ccd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -139,6 +139,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * do_open() has already checked for this, but we can be extra
+	 * cautious and check again at the very end too.
+	 */
 	error = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
@@ -860,6 +864,10 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * do_open() has already checked for this, but we can be extra
+	 * cautious and check again at the very end too.
+	 */
 	err = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..b9408aacaaa4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3212,6 +3212,10 @@ static int do_open(struct nameidata *nd,
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
+	/* Any file opened for execution has to be a regular file. */
+	if ((file->f_flags & FMODE_EXEC) && !d_is_reg(nd->path.dentry))
+		return -EACCES;
+
 	do_truncate = false;
 	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
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
2.20.1

