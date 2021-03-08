Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F97331427
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 18:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCHRHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 12:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCHRHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:07:16 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC1C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 09:07:16 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id dz17so8128831qvb.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 09:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=7mCRpmhv1OM36vNlkAtqHtWEhlUKPQI2C+wk9QTsT80=;
        b=miOOpv1RLxFINJF7EYHrzJzD3khYSf16V5pPLLmhxznHshwiurgylwUbtsXLx/GoPJ
         E4qC1svZwWEj/bXdNmvg5CGJzUHhR5Y9P9OWIatPV1Ja2AyN/hzWec0bxrfow92fYY3I
         EpUzhabEWV2Kblsu3IglcUnYAOLa0xlESIWPOBFI4z3hnpejjSlW5DbJGEI7VwZB5XmI
         5VcR6tW/GZjaU5fOBzMzt8dod0HiT/b0wdReP0Pq7fe19dWJm7pOfW5ZKGdY5EV9lGTm
         fi0JUcAaB3pzkbmBwgyZAkRBDTIsAFXVLxwO8LLHSY8lp0UhE7gIQP2x5JvqDYEj/6IS
         cJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=7mCRpmhv1OM36vNlkAtqHtWEhlUKPQI2C+wk9QTsT80=;
        b=s+LhJeCP5vEp4oivFTnlq53Q6ud4R4dXV+tbmXAW8hoMgS80FTzvX9+oAVYdKoPnd7
         7mexqdqhCNB/c//Uv94iLPItcPRhWZjz0oaePzS/aZsalLa+KiA0QtLauUFNxhLHa2WQ
         zn8kRWGOURjRJq4IzvMSvGR23PU5mZ6yoZ/6pCqX+6DmFymuIvQqLFeaGIFcEa6nSbi6
         cY/abut69sxSFFprLnXoU3XTm/y8k6eBuktH3qM2v5tnuPzfzBbypYU/cOQ1wnscjKmx
         qL4xJuULIIWq7q739QUogELkvx+Oujt/pE7iLD3+D3AEUKzaxprtlzBZfjnVXxa0vbvV
         d+QA==
X-Gm-Message-State: AOAM5313jChFhRmrQLVpOYN51kpsT2EVdAW0rWmu/bNR5O27sotcCzy/
        P2xHDF6UerjzUc6YHoTqiVkn/pnOZxilAiAkTw==
X-Google-Smtp-Source: ABdhPJx9+q+MEXXOho3t/3yQ+LqETPemrMlYxWkhxLoiKwMhnO2xsjvoochQa6vlE3++weFzUkrdxqvsxq+Dbq6zpA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:b526:: with SMTP id
 d38mr21324197qve.7.1615223235257; Mon, 08 Mar 2021 09:07:15 -0800 (PST)
Date:   Mon,  8 Mar 2021 17:06:40 +0000
Message-Id: <20210308170651.919148-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RESEND PATCH v6 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Android captures per-process system memory state when certain low memory
events (e.g a foreground app kill) occur, to identify potential memory
hoggers. In order to measure how much memory a process actually consumes,
it is necessary to include the DMA buffer sizes for that process in the
memory accounting. Since the handle to DMA buffers are raw FDs, it is
important to be able to identify which processes have FD references to
a DMA buffer.

Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
/proc/<pid>/fdinfo -- both are only readable by the process owner,
as follows:
  1. Do a readlink on each FD.
  2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
  3. stat the file to get the dmabuf inode number.
  4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.

Accessing other processes' fdinfo requires root privileges. This limits
the use of the interface to debugging environments and is not suitable
for production builds.  Granting root privileges even to a system process
increases the attack surface and is highly undesirable.

Since fdinfo doesn't permit reading process memory and manipulating
process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Hi everyone,

The initial posting of this patch can be found at [1].
I didn't receive any feedback last time, so resending here.
Would really appreciate any constructive comments/suggestions.

Thanks,
Kalesh

[1] https://lore.kernel.org/r/20210208155315.1367371-1-kaleshsingh@google.com/

Changes in v2:
  - Update patch description
 fs/proc/base.c |  4 ++--
 fs/proc/fd.c   | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfcdba56..fd46d8dd0cf4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3159,7 +3159,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
-	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
 	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
@@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
  */
 static const struct pid_entry tid_base_stuff[] = {
 	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
-	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 07fc4fad2602..6a80b40fd2fe 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -6,6 +6,7 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/pid.h>
+#include <linux/ptrace.h>
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
@@ -72,6 +73,18 @@ static int seq_show(struct seq_file *m, void *v)
 
 static int seq_fdinfo_open(struct inode *inode, struct file *file)
 {
+	bool allowed = false;
+	struct task_struct *task = get_proc_task(inode);
+
+	if (!task)
+		return -ESRCH;
+
+	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+	put_task_struct(task);
+
+	if (!allowed)
+		return -EACCES;
+
 	return single_open(file, seq_show, inode);
 }
 
@@ -308,7 +321,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

