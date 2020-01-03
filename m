Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0C12FA5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgACQ3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 11:29:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40466 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgACQ3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:29:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so4910024pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eB+H+wKtr9wg6rNJfWFUAgXbI+ShVm182xgfnmGZIDU=;
        b=f85XQOnziddmbXWnevVH8tqyCb+Bv2paNJFQ//lYFR8+YL/nNkZiibCRRb/B/qs1mE
         /2m5HAW5x50jSsqxUBv2+MTVdX0fGsBR5uGv0xqc1dRr+LZyZvmxrUm35nMNmgfgi3T1
         +12bJ0bbhU+M/ssVM8JzR0SYVBMvPfhwBxz1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eB+H+wKtr9wg6rNJfWFUAgXbI+ShVm182xgfnmGZIDU=;
        b=I2h4JT9WjqJZJ2lcb9bKtGH+mDctP0Z5e1xOE1YngZObt/KZlVP2+NXhn1HxxdAfRc
         keCP4hMz6kGJuZOTksJgTDH+hzMSei+0teEl3bo3RWV+H/ugMxI35K1Rbjc2WG2/1aY1
         prF0j+ZRV2SwC8/XLwdGruVhh93qFsiB6M0ziQEhzPdH3DbXUPPAonJatSfP7dvCQF56
         Bob+N2Etw7oYSx1kNCPQPURJG5MPgT9zGWI//VBhloE4RfUIFSciUmbOd38drUyAi+ze
         ioHX1F35weUyQHoNWJV/58pLJcZoqOHQZSCrOl/MellCM2ZV++UZc7qEx8VIJccBKSyS
         IjEQ==
X-Gm-Message-State: APjAAAUAWzQlTBMQ0JYQTUcc6UpoyywCzHje+5KFc26SVZJnvOmsGH3n
        C5/9oLW/GbpTvpmj1nNA0Mcl1g==
X-Google-Smtp-Source: APXvYqx/aYa2Y6i8oTaUCVkfAVeD6NjjHFZIg7AlXcxwqpbWJJLefsfNYKOrzG5kmpQhT3iO3w80cw==
X-Received: by 2002:a17:90a:fc82:: with SMTP id ci2mr27417376pjb.13.1578068985365;
        Fri, 03 Jan 2020 08:29:45 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m22sm67373970pgn.8.2020.01.03.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:29:44 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v8 1/3] vfs, fdtable: Add get_task_file helper
Date:   Fri,  3 Jan 2020 08:29:26 -0800
Message-Id: <20200103162928.5271-2-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103162928.5271-1-sargun@sargun.me>
References: <20200103162928.5271-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces a function which can be used to fetch a file, given an
arbitrary task. As long as the user holds a reference (refcnt) to the
task_struct it is safe to call, and will either return NULL on failure,
or a pointer to the file, with a refcnt.

This patch is based on Oleg Nesterov's (cf. [1]) patch from September
2018.

[1]: Link: https://lore.kernel.org/r/20180915160423.GA31461@redhat.com

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c            | 22 ++++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..2fc5eeef54a4 100644
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
@@ -729,6 +729,12 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 	return file;
 }
 
+static inline struct file *__fget(unsigned int fd, fmode_t mask,
+				  unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +752,18 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
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

