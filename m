Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6F3102BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 03:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBECYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 21:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhBECYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:24:17 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645DC061786
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 18:23:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id q37so3778017qvf.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 18:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=w382r+buQ4Tx8FdN/ryZgjV6D4PrxeZkE7hCNPLCCTk=;
        b=NPnaeEsHxHi/piRE30L1x8OZG9uQMUa5w0+x+UsNeCLDh53QMbkeU5Lgv6AyU09LNL
         DvZlEMtUnBsxCDBL3yrqJy92tZ8kFjhjM6bzzE7sIcdxQ7PurT0Y5gjLSEt88GT81AYX
         WXWOItSdEv/zp5NuWxav6asdBkP2pAw/kOD1AnK0PBVvEtmZ5Vwefg6MQI3tsn4OPMdQ
         plwXe0QwouLzjvGwfsA8yTvslcXQXLi9bh5ko/UbSEtwbYpopaH0W1YUG2ZFACQHPL7l
         aActAi6eUrI0CpI9j3fYhDfEmO/xw1jFkDq687flA8YUAwa0Ql6pjLhJOgq6C4n0nFdi
         HETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=w382r+buQ4Tx8FdN/ryZgjV6D4PrxeZkE7hCNPLCCTk=;
        b=QWwqNckNtLkmUe4g518NJptcRFU+7AVqgVbjqjri0gxRgEaRYhM8ZtWvyFtGFQWMjI
         12g3bfUIM0wOkdn7RMFSw1GiDgIrYWnyJTOTv0B5Y2GW+m2tcwZyzp3mDyhnMCBRY70H
         L3crAgZDcTr8EnLD/prmlihzF4QTe+iCR73QlCiORs8KgTA0Kjxm1tX9BV329PHaoYTg
         cIH2DP8xioBEi0MM95bl6DY3I7lqMLMwiQ9H0qJj/wuxkjRMEjozB52yarEPisofnLHe
         CIdC5LLo0YsR6VRXbfaTkkKG1lamz5vlwH1GJJ1O4CU9Zcf8wi1CF9wr7tH+bSpCgNdD
         Ad4w==
X-Gm-Message-State: AOAM531SuGO6ZN/UbFbjBCqJILZBovd17IPpCQfQvnRayhRo4gi7rZIy
        TrxWMTc+Eu/cMuXYYvpXddseh+HVr4uorntrUA==
X-Google-Smtp-Source: ABdhPJyxJEHoxHNUAnY+G03oBvTfa0zSu7hUtgPrQ8bfbdtGtODePabYUrPF86ehavcU7ZNb7W60emHq1FCLFEcRNw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:446:: with SMTP id
 cc6mr2447707qvb.31.1612491816769; Thu, 04 Feb 2021 18:23:36 -0800 (PST)
Date:   Fri,  5 Feb 2021 02:23:19 +0000
Message-Id: <20210205022328.481524-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anand K Mistry <amistry@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Accessing other processes=E2=80=99 fdinfo requires root privileges. This li=
mits
the use of the interface to debugging environments and is not suitable
for production builds.  Granting root privileges even to a system process
increases the attack surface and is highly undesirable.

Since fdinfo doesn't permit reading process memory and manipulating
process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v2:
  - Update patch description

 fs/proc/base.c |  4 ++--
 fs/proc/fd.c   | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..a37f9de7103f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3160,7 +3160,7 @@ static const struct pid_entry tgid_base_stuff[] =3D {
 	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_=
operations),
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_oper=
ations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_=
map_files_operations),
-	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdi=
nfo_operations),
+	DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdi=
nfo_operations),
 	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_op=
erations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_op=
erations),
@@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_comm_in=
ode_operations =3D {
  */
 static const struct pid_entry tid_base_stuff[] =3D {
 	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_opera=
tions),
-	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdin=
fo_operations),
+	DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdin=
fo_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_ope=
rations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_op=
erations),
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index cb51763ed554..585e213301f9 100644
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
=20
 static int seq_fdinfo_open(struct inode *inode, struct file *file)
 {
+	bool allowed =3D false;
+	struct task_struct *task =3D get_proc_task(inode);
+
+	if (!task)
+		return -ESRCH;
+
+	allowed =3D ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+	put_task_struct(task);
+
+	if (!allowed)
+		return -EACCES;
+
 	return single_open(file, seq_show, inode);
 }
=20
@@ -307,7 +320,7 @@ static struct dentry *proc_fdinfo_instantiate(struct de=
ntry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
=20
-	inode =3D proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
+	inode =3D proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
=20
--=20
2.30.0.478.g8a0d178c01-goog

