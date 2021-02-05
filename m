Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34203113A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 22:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBEVfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 16:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBEVev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:34:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3266C06178B
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 13:33:58 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m9so6955141qka.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=w382r+buQ4Tx8FdN/ryZgjV6D4PrxeZkE7hCNPLCCTk=;
        b=Do3cLKKgATj9Sj1wczzer7FsQYo2BGJLV+dlolkVMaamGTbvNtGFsx8B9cjDusaoJ6
         PH//GMgsuQfTvFJGb504gwHqFYmglx5t8ajCSi0wjHfPg87LkbKyWXkwy6n6pjLVT7L6
         obdgNsN/V1Pbj2Yfog3ATINTeISlKX2QmY91sGRAEa+7Ut5frVD33da8olSv64KKgmTY
         1hfq4LWBjd1MWAK9SODnWt6hywEnmqIQ9gB8knT+0X0lqaJGvPZa3hK48Wot+TTQB7uC
         NQhQRopKwh3fC+Dq4ymwIfzENFP3dBEcffQ9JT2loQ6otxhuzTDLJkfWRqu59R79ZTtA
         e7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=w382r+buQ4Tx8FdN/ryZgjV6D4PrxeZkE7hCNPLCCTk=;
        b=Nci/mUdIZdFNQ8tzRcC6eHHqTAhUWubQSJK52/dqrdZUh85Eo6a9pPSPXGsrD0odEB
         BKRlUXa6FaGeDB8u3D7NnltJqpj+xjs2mhwmEYdJ4noELnugjORGOM6ftQhh1s72cfPo
         XIkiMpFq/xZjRh5195+xcnjAtfd19yRFkqQ46FeNkL5jGL0YUmI1f+QrGw7DA1UXXUdm
         XADxRv6Z3aZOk88JfV59hPQlrlPqgtALKrGVB00KLzHQF9zwoNyTYoZ5fztc6h1Xt1Bl
         HCxPmRegM+/vnCmR0h+InlFL5Z7MUn3QGo0PR6n7kwXgXZ3sIJQz9Q8agKVQ43vvSViR
         Og6A==
X-Gm-Message-State: AOAM532ubtE9jRHzqhcA1s+ZqMswr8QI62jtroVgJ4IFyWMwT6JoZFf0
        dc7d3WJP6r6dF2Rrc/M7P/M+FsQO9d4xUueU6A==
X-Google-Smtp-Source: ABdhPJwJT6nr2aaCz5tonDuWMfRWbCDh0aV8dUQFJumYEjyZC6Qyyu+a1DDqD8I8jK3xt7QsBX2BA6k1mXXISmy/sA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:8365:: with SMTP id
 j92mr6362202qva.19.1612560837960; Fri, 05 Feb 2021 13:33:57 -0800 (PST)
Date:   Fri,  5 Feb 2021 21:33:43 +0000
Message-Id: <20210205213353.669122-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
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

