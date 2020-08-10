Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9D240808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHJO7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHJO7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:59:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5DC061756;
        Mon, 10 Aug 2020 07:59:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so5527252pfn.0;
        Mon, 10 Aug 2020 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cha7rnpRi4xpgmDPF7CsOih8am/jsjcB9lLAioEKTb0=;
        b=m+7zEMrCxnOsC5MPGuxT74CMpXZuPQWPmkQVqiLheycGqhlGH8oQga5z7vS2SaU7QY
         D2Qzuensekq1rbTUBI7WmvlC+dLL4OX8/n6Lhq0VqhbtWRY6Pl2pxA5tX+n2DxRlHrjT
         xV6nDFcRP1+ilSfclFpZ+tPtMyUuNfDTn0f9P0qqXi7eEf+Tby/kxmwU3JGZZV9uLV57
         a6LdKyDmMULgOCJ8vzozktQjUkdI8sboYmAMWUob2V4s+QZW8qNqVbsvpiyBuxLJt6K9
         KQjsEefcu1Rlr6rKIt5V8TzmVKTJU+ybrBrJonjr62hTdWWWhi04OMLswn6jdotS3u2h
         Eibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cha7rnpRi4xpgmDPF7CsOih8am/jsjcB9lLAioEKTb0=;
        b=dduVOj3i+0XQOyenoGNV9pUmpBqIu+0dhBuJ8axCrEugHaxds3l0VXK2ylZIw4xjOF
         W7QxDtN6X6IoncP8+hlNlxthuX7hsf+tCukzEQ9b0wmtT7RfaKifkuWR46EVtnCFa+lD
         CLDz6GpxXKGx6scbfGHcMBcS5zD/78ekpg5jk0pfw1vQtMoSRgG/7dJnsgAtAwWp8J11
         DRKbfmzGOVfOVac28/iczzxPd+uWKoEraDVRwQPXs6y+0BdyLDoMXntKQn+EUZEFN5Q1
         2DuoaZ1mIEQpMKDsnF6P7y6K6033W5Iuv65SzrD+V3PFEN2yMhrFyxMSXFeC+na9ExD4
         uEqg==
X-Gm-Message-State: AOAM533YVl63Vuc1/ETVZcfQtvLdvQfgNtvqUtWeEbVgmd3j7XS6EOyn
        qtGDHVlWiiZg0SJ2Kpu/c2XfTXu8uUk=
X-Google-Smtp-Source: ABdhPJwyxBHCJCppYNb7kqBboZFk0vxRlQinVRMMd6rHHY87o7D0qdVNYm/yv98gngKpHYLG2Y7IYA==
X-Received: by 2002:a63:4c5f:: with SMTP id m31mr18445720pgl.403.1597071549666;
        Mon, 10 Aug 2020 07:59:09 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:59:09 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 4/5] fs/proc: Introduce /proc/all/io
Date:   Tue, 11 Aug 2020 00:58:51 +1000
Message-Id: <20200810145852.9330-5-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Returns io info for all visible processes.

The data is the same as /proc/[pid]/io but formatted as a series
of numbers on a single line. A PID column is also prepended.

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5982fd43dd21..03d48225b6d1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2910,9 +2910,8 @@ static const struct file_operations proc_coredump_filter_operations = {
 #endif
 
 #ifdef CONFIG_TASK_IO_ACCOUNTING
-static int do_io_accounting(struct task_struct *task, struct seq_file *m, int whole)
+static int calc_io_accounting(struct task_struct *task, struct task_io_accounting *acct, int whole)
 {
-	struct task_io_accounting acct = task->ioac;
 	unsigned long flags;
 	int result;
 
@@ -2928,12 +2927,27 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 	if (whole && lock_task_sighand(task, &flags)) {
 		struct task_struct *t = task;
 
-		task_io_accounting_add(&acct, &task->signal->ioac);
+		task_io_accounting_add(acct, &task->signal->ioac);
 		while_each_thread(task, t)
-			task_io_accounting_add(&acct, &t->ioac);
+			task_io_accounting_add(acct, &t->ioac);
 
 		unlock_task_sighand(task, &flags);
 	}
+	result = 0;
+
+out_unlock:
+	mutex_unlock(&task->signal->exec_update_mutex);
+	return result;
+}
+static int do_io_accounting(struct task_struct *task, struct seq_file *m, int whole)
+{
+	struct task_io_accounting acct = task->ioac;
+	int result;
+
+	result = calc_io_accounting(task, &acct, whole);
+	if (result)
+		return result;
+
 	seq_printf(m,
 		   "rchar: %llu\n"
 		   "wchar: %llu\n"
@@ -2949,10 +2963,7 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 		   (unsigned long long)acct.read_bytes,
 		   (unsigned long long)acct.write_bytes,
 		   (unsigned long long)acct.cancelled_write_bytes);
-	result = 0;
 
-out_unlock:
-	mutex_unlock(&task->signal->exec_update_mutex);
 	return result;
 }
 
@@ -3896,7 +3907,42 @@ static int proc_all_statm(struct seq_file *m, void *v)
 	return proc_pid_statm(m, ns, pid, task);
 }
 
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+static int proc_all_io_print_one(struct seq_file *m, struct task_struct *task)
+{
+	struct task_io_accounting acct = task->ioac;
+	int result;
 
+	result = calc_io_accounting(task, &acct, 1);
+	if (result)
+		return result;
+
+	seq_printf(m,
+		   "%llu %llu %llu %llu %llu %llu %llu\n",
+		   (unsigned long long)acct.rchar,
+		   (unsigned long long)acct.wchar,
+		   (unsigned long long)acct.syscr,
+		   (unsigned long long)acct.syscw,
+		   (unsigned long long)acct.read_bytes,
+		   (unsigned long long)acct.write_bytes,
+		   (unsigned long long)acct.cancelled_write_bytes);
+
+	return result;
+}
+
+static int proc_all_io(struct seq_file *m, void *v)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+	struct pid_namespace *ns = iter->ns;
+	struct task_struct *task = iter->tgid_iter.task;
+	struct pid *pid = task->thread_pid;
+
+	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
+	seq_puts(m, " ");
+
+	return proc_all_io_print_one(m, task);
+}
+#endif
 
 static int proc_all_status(struct seq_file *m, void *v)
 {
@@ -3915,6 +3961,9 @@ static int proc_all_status(struct seq_file *m, void *v)
 PROC_ALL_OPS(stat);
 PROC_ALL_OPS(statm);
 PROC_ALL_OPS(status);
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+	PROC_ALL_OPS(io);
+#endif
 
 #define PROC_ALL_CREATE(NAME) \
 	do { \
@@ -3932,4 +3981,7 @@ void __init proc_all_init(void)
 	PROC_ALL_CREATE(stat);
 	PROC_ALL_CREATE(statm);
 	PROC_ALL_CREATE(status);
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+	PROC_ALL_CREATE(io);
+#endif
 }
-- 
2.25.1

