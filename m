Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2742F3100BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 00:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBDXaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 18:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhBDXaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:30:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC3C061793
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 15:29:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l10so4958791ybt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=DDQzxO36o6mrG/7K72IGYqFtZmZCZagcSZoIJct7BXY=;
        b=lKA+G8wZwzc3KJjfEbk4USd/5AVvIdDVeMqb73oE9zBHWMZoft6gFKDOCePms0HPGp
         IpnAmcQPaJqYzhqs4VxxZC2o6/RZ/j5MJHU506eq+wz0Kr/o5Bqyr8NtakeP4tNzVayK
         i4uqXx2mJwpp7gFTlPgCqkmcAAnU1hJ5Od8hNOtrD2rvM4Bv5eQodRsQ3Nbv41EYSlj6
         QIkP+5XgiBOggGll6NMhjXYbeQvpSVtgbaWyekgEHyE8uT0kDLBHzAO8Q2g0J/qrcZqc
         4I6ra63n/sjej0sFgwE/GkqMywm97NzAFEwHafPA+4J8xTPVBMHAUXrR3IlMDzqYSjeR
         6m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=DDQzxO36o6mrG/7K72IGYqFtZmZCZagcSZoIJct7BXY=;
        b=MFCFewvP4XIVggDvh7Mk3KYkgQrrrsAmJF7oe3+ImXp1SCk40TY8G5DuVzYuKyVES2
         II5x05CNRIXJXsrD0KQSs2Xs1XBmFhi4dWxXq92HP9OkQKPtpt/7XDp7OXpS4J54AZGR
         mbYvBhuRYNp/9VTPRbnjjBZ1Np1jCgcNLmiKv5cwiRSjYiJpWO4GjbL+SqmA4F/hBPg4
         lBRsPolI1MTlsSa61IV2VfyL1SVaBhmC0fekyPqamv6mhRlVuDBEhiN5NRCWt7/LDRFo
         +c7cmsmssvyEb8go/UIiPqoiVr65kCXMFOX2s8R+tLgPvNSVjzn92mj7YFSo0uPk4s2e
         gwMg==
X-Gm-Message-State: AOAM531A9acTUarzeHU8IT2YO6mmkgE8slem+c8RP+AwJ25+/2wAfeQH
        lASVSMUHh8mBLsMk+X9Ctje3xBjMBOiVC5a7EA==
X-Google-Smtp-Source: ABdhPJxuX5H3dPiFCh9g9xC89BwbDPdhdkk9a69MMrBZXYzdZFIf3f0iRjx/t1FkfEnOk7GPoDaKkXJi/cFoZs5jWQ==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:450:: with SMTP id
 77mr162814ybe.39.1612481398666; Thu, 04 Feb 2021 15:29:58 -0800 (PST)
Date:   Thu,  4 Feb 2021 23:28:49 +0000
Message-Id: <20210204232854.451676-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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
  - Update patch desciption

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
2.30.0.365.g02bc693789-goog

