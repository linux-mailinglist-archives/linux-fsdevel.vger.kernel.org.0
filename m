Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B66128583
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 00:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLTX2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 18:28:04 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43731 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfLTX2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:28:03 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so9469451ioo.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=uK3AhW1cGSB2r++u32XTz9HtiQf9DqoAJjZTRWoiXrjhVWY6c5A2GADwJdSXWsp2/X
         FsGsLqdPVE3e+/7ZjXCDprcZpUcC7yZ4UWf6Jr6Czg9nUCF0j6YtxlOzYegNvAokHGMa
         IvrQIWpnkjoATVBm197EtU7IuXBoy83PBzK4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=jip96FGr52inF9vbWMBzq+GPMCpXhINwVtZCsRcp1/2Q8L0ZDOiRFYyXBqGNZyKIPg
         jI/S0Zp1Aor+BhxqOYFLqHsM8hywXPFK8ZxvDlA3BPPMI4mpfHZwzMZ25I5FtTQ5Gxqc
         AVJT1VRIDHpB3kSibTsCdxdpLmHAX6qOy0WYanpOh0WFof6YbGQ94nZmYQXzjcqjlKeN
         36a2S99nc4fxAKKcIn4ovdLSJdxeL21z5cV7AWhyJ+GeXlfe5MZ7CiV2nYPf/9spj9Df
         yiJYzX1SXr/2WOt/gG/sUC+g8Dmke8DSwExKO72e0qgywpqxyI1QGPJ8JCVy5fmd7F4z
         KEMw==
X-Gm-Message-State: APjAAAWo6uE1pBQ0hB1kf80hEhqR5vlO+glCd/so3y/KN75n5eELlpv+
        +f98VSgxB5m9g+zu5WYabJoKGw==
X-Google-Smtp-Source: APXvYqxsP0bwleRoHecpmcs1c/KtuGVrDwDug1CwLOoHCIMnBUjjBhwWd5nxifsPFV+UuKhkDPnVNg==
X-Received: by 2002:a5e:924c:: with SMTP id z12mr12049921iop.296.1576884482976;
        Fri, 20 Dec 2019 15:28:02 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id a12sm3941787ion.73.2019.12.20.15.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:28:02 -0800 (PST)
Date:   Fri, 20 Dec 2019 23:28:01 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v5 1/3] vfs, fdtable: Add get_task_file helper
Message-ID: <20191220232758.GA20224@ircssh-2.c.rugged-nimbus-611.internal>
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
index 2f4fcf985079..0ceeb046f4f3 100644
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

