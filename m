Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D15122135
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 02:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLQBBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 20:01:25 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44437 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfLQBBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:01:24 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so9094602iof.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=toA0jzwuketdr2e1YvJhPtQZTwWvbzIQDMih6NbAho0=;
        b=Vux6gcbDzir2dvv72u14dZyT7A+Xu//TUpa4d8Q262GwSxLJmt+V15Z/jfeB+txgJc
         qIZ6FQoD4QleBDoeLZJZoFaSx1gkf+MFzeqkjO3RomC124M8P/QEyG0SszkbAv6uiLBR
         R36L6QmDCO0E5jbRr/S0Y+Bt1snK25AU0uPqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=toA0jzwuketdr2e1YvJhPtQZTwWvbzIQDMih6NbAho0=;
        b=P7CYBgzNm94hYWAtVcSguzqJ6Itp3Q2cJPMpJ1aJ37zMhT61pqJL2QOKLgKd545ZuZ
         My2N8GX0qthx/4PMFlJrVeCfKX710qtL3bh4NFye7+1lledwunAf2K46p/9al9BS9iGJ
         ByOjpDrU1ZBoaLUUeMsT8SKMsLyhclqn7ebLGF5fewE63lXBjYiE2gMcQ8mZmBlCUhyH
         wqb7z7ueA341Mb5JYYNnPfD707l4jq0g6iCCROWkLs/JfK44xHTRnCZFd/gCZhK2HB2Q
         nR4lSgbnmSAcTk2MgktqzDxP5YAxGnSOUQbLWJhc1VUXwfJYq92URyoDCj8NBxry4VHg
         32RQ==
X-Gm-Message-State: APjAAAV4XHy9vp0JxeKCQQRe/XqWlXz94Nk2LJiM5LoD+TLafVNja/hQ
        VqzB4GiajYU2dLAd6m97sl0xFw==
X-Google-Smtp-Source: APXvYqw7XFCaDfOkRDKO1vqm5NO1I4w3iLozscNNT7OpT7LMGnda1O0Xl6WJYAMAUltY1ohkkANcug==
X-Received: by 2002:a5d:9046:: with SMTP id v6mr1727984ioq.302.1576544483409;
        Mon, 16 Dec 2019 17:01:23 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t203sm4684121iod.15.2019.12.16.17.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 17:01:23 -0800 (PST)
Date:   Tue, 17 Dec 2019 01:01:21 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com
Subject: [PATCH v3 1/4] vfs, fdtable: Add get_task_file helper
Message-ID: <20191217010119.GA14488@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces a function which can be used to fetch a file, given an
arbitrary task. As long as the user holds a reference (refcnt) to the
task_struct it is safe to call, and will either return NULL on failure,
or a pointer to the file, with a refcnt.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/file.c            | 22 ++++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..63272d15be61 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -706,9 +706,9 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+static struct file *__fget_files(struct files_struct *files, unsigned int fd,
+				 fmode_t mask, unsigned int refs)
 {
-	struct files_struct *files = current->files;
 	struct file *file;
 
 	rcu_read_lock();
@@ -729,6 +729,11 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 	return file;
 }
 
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +751,19 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
+
+	task_unlock(task);
+
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/file.h b/include/linux/file.h
index 3fcddff56bc4..c6c7b24ea9f7 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -16,6 +16,7 @@ extern void fput(struct file *);
 extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
+struct task_struct;
 struct vfsmount;
 struct dentry;
 struct inode;
@@ -47,6 +48,7 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
+extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
 extern unsigned long __fdget_pos(unsigned int fd);
-- 
2.20.1

