Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183C3C16B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhGHP7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGHP7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:59:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35EC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jul 2021 08:57:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p63-20020a25d8420000b029055bc6fd5e5bso7455088ybg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=27c25yrooHjh+TTXqzDDAJzddaCf990UPSULOb6WFAI=;
        b=aDve9Zer0+oH4LFmsjzSJjy2qJ6ydRcQ4yQsIy3WlRU1bl7Dmud2tM1BJ1Roiz1yG5
         MRwy5WjkhamTgnta59/CF/rpz9FqUnMiMsx0Kal3nVzvPQB82HyD7sy+7CsnlR0bouiD
         c6LHwPfuy3ub4AhJWEntApfWGyn8plc0X0dXsEHEUGNnHc5Mv2HTE9OHzVoGJsklAhuP
         OhKTiZYaq8ap1CzW5ckGAJEV6sbIhVoXogJjAIBB8u5NGAhl+baC5pWqq8fb2MNhJLff
         zIfBuQnrl1GveetW406kcZxik0zn+tT2kRnNYSqDk10TCrpApsbgL/M68IuegAnY/2WW
         XE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=27c25yrooHjh+TTXqzDDAJzddaCf990UPSULOb6WFAI=;
        b=Ys3y4av+neuewI48Tk1NlgHMikBDE4dVrU/X9vFSrbA9FhsVI/ZY4gMNiBKaAWM0WK
         qj7RTBPona/i37NERnJGC7uSkJntFxBe5H5fbPLgl18ANEywxyAeluc6EZNHueC86Gt0
         kSmAFdQJqPjr3edmNauLKWhl4/g392Das7QLQ1ds7O07TS8gEK0GtakEWRh5RN4Gw5oo
         RbQLdLmVaUeBNgn8Doy4kIgsfowcMXkXhD1xjhHW3ZczuQb0r7SbRwtZYkw57BMMm8vY
         fss4+HxP8DOWS6qCjxuece99D2Ov2ABUzeJJ9zNwP9zXt3G4x/3a6SBnuB0ZhwECoIy0
         FCGw==
X-Gm-Message-State: AOAM532EhTXFnS2XbbDox1YKgWAOV75ahvwBN4rdSEvN5cAthKqwdq91
        scXMP/o3kz4F5PV2jFNt5vzY55TW48bIU5T60g==
X-Google-Smtp-Source: ABdhPJwJm8LFQbdn+sWTcjBTOAiLQyJG59Q9gRIYORRT7i6i0bKT6kb92g60GNPehB0rrnSxorNHWRR+6SETm68Gsg==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:da84:: with SMTP id
 n126mr41966629ybf.412.1625759827786; Thu, 08 Jul 2021 08:57:07 -0700 (PDT)
Date:   Thu,  8 Jul 2021 15:56:43 +0000
Message-Id: <20210708155647.44208-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] procfs: Prevent unpriveleged processes accessing fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, christian.brauner@ubuntu.com,
        christian.koenig@amd.com, surenb@google.com, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file permissions on the fdinfo dir from were changed from
S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
added for opening the fdinfo files [1]. However, the ptrace permission
check was not added to the directory, allowing anyone to get the open FD
numbers by reading the fdinfo directory.

Add the missing ptrace permission check for opening the fdinfo directory.
The check is also added for readdir, lseek in the case that
an unprivileged process inherits an open FD to the fdinfo dir after an
exec.

For the same reason, similar checks are added for fdinfo files which
previously only checked the ptrace permission in open.

[1] https://lkml.kernel.org/r/20210308170651.919148-1-kaleshsingh@google.com

Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 fs/proc/fd.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 172c86270b31..aea59e243bae 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -72,7 +72,7 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
+static int proc_fdinfo_access_allowed(struct inode *inode)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -86,13 +86,44 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 	if (!allowed)
 		return -EACCES;
 
+	return 0;
+}
+
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
 	return single_open(file, seq_show, inode);
 }
 
+static ssize_t seq_fdinfo_read(struct file *file, char __user *buf, size_t size,
+		loff_t *ppos)
+{
+	int ret = proc_fdinfo_access_allowed(file_inode(file));
+
+	if (ret)
+		return ret;
+
+	return seq_read(file, buf, size, ppos);
+}
+
+static loff_t seq_fdinfo_lseek(struct file *file, loff_t offset, int whence)
+{
+	int ret = proc_fdinfo_access_allowed(file_inode(file));
+
+	if (ret)
+		return ret;
+
+	return seq_lseek(file, offset, whence);
+}
+
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= seq_fdinfo_read,
+	.llseek		= seq_fdinfo_lseek,
 	.release	= single_release,
 };
 
@@ -344,17 +375,43 @@ proc_lookupfdinfo(struct inode *dir, struct dentry *dentry, unsigned int flags)
 
 static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 {
+	int ret = proc_fdinfo_access_allowed(file_inode(file));
+
+	if (ret)
+		return ret;
+
 	return proc_readfd_common(file, ctx,
 				  proc_fdinfo_instantiate);
 }
 
+static loff_t proc_llseek_fdinfo(struct file *file, loff_t offset, int whence)
+{
+	int ret = proc_fdinfo_access_allowed(file_inode(file));
+
+	if (ret)
+		return ret;
+
+	return generic_file_llseek(file, offset, whence);
+}
+
+static int proc_open_fdinfo(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
+	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
-	.llseek		= generic_file_llseek,
+	.llseek		= proc_llseek_fdinfo,
 };

base-commit: e9f1cbc0c4114880090c7a578117d3b9cf184ad4
-- 
2.32.0.93.g670b81a890-goog

