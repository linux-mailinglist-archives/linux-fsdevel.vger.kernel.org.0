Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4D116757
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 08:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLIHGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 02:06:15 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39171 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfLIHGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:06:15 -0500
Received: by mail-il1-f196.google.com with SMTP id a7so11801225ild.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2019 23:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8Hi0NAqaq4yKaz2cZXCzyXUQt+Qgg5vxTIhLWeRkvII=;
        b=XlxvMoil8iFkye99hWCb3hagvwkUuuTyC5CcVqEfiGimGwgOT5I2XfhVXg5JvBoO3M
         BTX5Ty6OR6ldJ8hLR6bTFqOExX+whlZdxpH6ewqzXig+QMhRL3F6eAB1f4vwf+BTfaFP
         dDAi2d7HGAKK0pOOsdA+XGCWfiBcw5+GzGPYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8Hi0NAqaq4yKaz2cZXCzyXUQt+Qgg5vxTIhLWeRkvII=;
        b=Atf9zql9KLihmZAUZ71alloGD5TCLFaEGe1UdPv6WNXXMn1Hoa/WK68yS2MmbG++Ew
         ZSPIC/LqUZ5hOoMtOyERfiFyx6nMm+JefmGQmxnkiBcauNWM4ZlsXHofKb14lyVsbPRQ
         /+EPb/rz4W32b1SFOUCkGdi8HQs6rZHG71SGADhv5pREgEOWrXcclSM3hXzsQPpSD0Z0
         Casso9wfpBWE3+ehge8ujBuhqniZOhsIk64NT0H/aGPcs2eExRKj2EJBL1mRhpVnw0Nc
         jq3zokLwEQjxKG0d/YAXfhuCVdifqI9CFLlvUBHjHS8ZtzGDsIVe/QP8w6DLW4CK9Dya
         6uRg==
X-Gm-Message-State: APjAAAXsIQjErnW337E0qWG60XQuPWeZ0rzmgOcyYcSPNVULYLSlQpmm
        vH4JllYmkmGdiotqRboKL1UlkQ==
X-Google-Smtp-Source: APXvYqyOqXX1bhUMR582tDO+WsTTun/QGCfWJIczZ0NFlZLLlmYhs1rETYjTNDkO85Yx7I6fCcmqhQ==
X-Received: by 2002:a92:b00f:: with SMTP id x15mr25026596ilh.248.1575875174527;
        Sun, 08 Dec 2019 23:06:14 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id v10sm163147iot.12.2019.12.08.23.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:06:13 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:06:12 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 1/4] vfs, fdtable: Add get_task_file helper
Message-ID: <20191209070609.GA32438@ircssh-2.c.rugged-nimbus-611.internal>
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
 fs/file.c               | 19 +++++++++++++++++++
 include/linux/fdtable.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..98601a503a0f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1015,3 +1015,22 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+struct file *get_task_file(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	rcu_read_lock();
+
+	if (task->files) {
+		file = fcheck_files(task->files, fd);
+		if (file && !get_file_rcu(file))
+			file = NULL;
+	}
+
+	rcu_read_unlock();
+	task_unlock(task);
+
+	return file;
+}
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..eacb1a56df44 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -115,6 +115,16 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
+/*
+ * get_task_file - get a reference to a file from another task
+ * @task: the task to get the file descriptor from
+ * @fd: the file descriptor number to fetch
+ *
+ * returns NULL on failure, or pointer to the file on success, with a reference
+ * It requires that the task is pinned prior to calling it.
+ */
+struct file *get_task_file(struct task_struct *task, unsigned int fd);
+
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
 extern void __fd_install(struct files_struct *files,
-- 
2.20.1

