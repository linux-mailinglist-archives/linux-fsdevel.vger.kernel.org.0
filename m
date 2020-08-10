Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597EA2407FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHJO7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHJO7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:59:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143DC061756;
        Mon, 10 Aug 2020 07:59:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so5017922plt.3;
        Mon, 10 Aug 2020 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mohYvyGqdhdUaTelDr5Bm7RODAztwYPL8ky3MmUdo6g=;
        b=j3KbZZ4BingQsFCXMk5nGnvSkIpexZjaYk2vDTTBIHorD3ZuRPRDk+5YIGZOZlgQJH
         mctbqxAIBIek42A1SaD9ynsEkBWAkbAg4jjpN3wto2XOIbPMDVhvrWDT8DhornUy7H/H
         77Qkcq3fnZoil5OC030vPd0RJNVuER9q98cySp0nYSBynRbcGERA9b0vaevX8tMgU9C4
         orvWobPzWWZUrMl+/Cg32316tXzVzx2k4pyZfy2BpRtfmNUwheUohsLKCpx3pSyuak6j
         FZ5N1AIDSYgEPzLMBbhM//on68/85xIJG3Fkyr9Qq+nkVNAljP3Zc482BL4a3MRTmb8r
         7fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mohYvyGqdhdUaTelDr5Bm7RODAztwYPL8ky3MmUdo6g=;
        b=mb+0fkVKN1envlHeqpICsWxw7j7p+bXZoSFJq06fPMQHJ63CMeyn2fmRRZswpKsd64
         zTG1VuA3YQsK/8F79K2AqNtiVN9Ek2zlMJ8CdptUfe9zttwnybLPzdULLxRwIahXt/uK
         1JV51noSwDB5BfBm/P+ToOntLhlJpJic3+CH4MjjgT78NbF/7/9j5xYM2vOZOvV+Nr0j
         2mJGAr5ZwcLyItYqRTkYb1CUiYEzP+xq+qA8c8yH4JK3o7BIBMvrXAu52bLl9xm5szs2
         iCM2Nf4YtXjOEh6hHTYa2cJSaxDriZ/Mk2HnDRn0fU4tSF1yHl4GWc1LCRdndu6HtEv8
         IEJQ==
X-Gm-Message-State: AOAM5328MGaa0XKBk5hHsd1aPpnUWwFRiB4IG+MOoOPQMDvvcnxXwp9l
        Vwp7PMMBPgh6/wiqplxYE59xiAmdf7o=
X-Google-Smtp-Source: ABdhPJz/3SBRupBnRklHemhZL8pm4C4o6GGJm4brAYu21wDssPYcDqXsINlVVqSj2Miay979RXJfMg==
X-Received: by 2002:a17:90b:788:: with SMTP id l8mr26453088pjz.25.1597071541097;
        Mon, 10 Aug 2020 07:59:01 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:59:00 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 1/5] fs/proc: Introduce /proc/all/stat
Date:   Tue, 11 Aug 2020 00:58:48 +1000
Message-Id: <20200810145852.9330-2-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Returns stat lines for all visible processes in the existing format,
aiming to substantially reduce the number of syscalls that are needed 
for this common task.

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/internal.h |  1 +
 fs/proc/root.c     |  1 +
 3 files changed, 100 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a333caeca291..e0f60a1528b7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3811,3 +3811,101 @@ void __init set_proc_pid_nlink(void)
 	nlink_tid = pid_entry_nlink(tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
 	nlink_tgid = pid_entry_nlink(tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
+
+
+/*
+ * /proc/all/
+ */
+
+struct all_iter {
+	struct tgid_iter tgid_iter;
+	struct proc_fs_info *fs_info;
+	struct pid_namespace *ns;
+};
+
+static void *proc_all_start(struct seq_file *m, loff_t *pos)
+{
+	struct all_iter *iter = kmalloc(sizeof(struct all_iter), GFP_KERNEL);
+
+	iter->fs_info = proc_sb_info(file_inode(m->file)->i_sb);
+	iter->ns = proc_pid_ns(file_inode(m->file)->i_sb);
+
+	iter->tgid_iter.tgid = *pos;
+	iter->tgid_iter.task = NULL;
+	iter->tgid_iter = next_tgid(iter->ns, iter->tgid_iter);
+
+	if (!iter->tgid_iter.task) {
+		kfree(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+static void *proc_all_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+	struct proc_fs_info *fs_info = iter->fs_info;
+	struct tgid_iter *tgid_iter = &iter->tgid_iter;
+
+	do {
+		tgid_iter->tgid += 1;
+		*tgid_iter = next_tgid(iter->ns, *tgid_iter);
+	} while (tgid_iter->task &&
+				!has_pid_permissions(fs_info, tgid_iter->task, HIDEPID_INVISIBLE));
+
+	*pos = tgid_iter->tgid;
+
+	if (!tgid_iter->task) {
+		kfree(v);
+		return NULL;
+	}
+
+	return iter;
+}
+
+static void proc_all_stop(struct seq_file *m, void *v)
+{
+	if (v) {
+		struct all_iter *iter = (struct all_iter *) v;
+		struct task_struct *task = iter->tgid_iter.task;
+
+		if (task)
+			put_task_struct(task);
+
+	  kfree(v);
+	}
+}
+
+static int proc_all_stat(struct seq_file *m, void *v)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+
+	return proc_tgid_stat(m, iter->ns, iter->tgid_iter.task->thread_pid, iter->tgid_iter.task);
+}
+
+
+#define PROC_ALL_OPS(NAME) static const struct seq_operations proc_all_##NAME##_ops = { \
+	.start	= proc_all_start, \
+	.next	= proc_all_next, \
+	.stop	= proc_all_stop, \
+	.show	= proc_all_##NAME \
+}
+
+PROC_ALL_OPS(stat);
+
+#define PROC_ALL_CREATE(NAME) \
+	do { \
+		if (!proc_create_seq(#NAME, 0, all_dir, &proc_all_##NAME##_ops)) \
+			return; \
+	} while (0)
+
+void __init proc_all_init(void)
+{
+	struct proc_dir_entry *all_dir = proc_mkdir("all", NULL);
+
+	if (!all_dir)
+		return;
+
+	PROC_ALL_CREATE(stat);
+}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..b22d9cb619bf 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -171,6 +171,7 @@ extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
 struct dentry *proc_pid_lookup(struct dentry *, unsigned int);
 extern loff_t mem_lseek(struct file *, loff_t, int);
+extern void proc_all_init(void);
 
 /* Lookups */
 typedef struct dentry *instantiate_t(struct dentry *,
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5e444d4f9717..4b5cfd2cdc0a 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -291,6 +291,7 @@ void __init proc_root_init(void)
 	set_proc_pid_nlink();
 	proc_self_init();
 	proc_thread_self_init();
+	proc_all_init();
 	proc_symlink("mounts", NULL, "self/mounts");
 
 	proc_net_init();
-- 
2.25.1

