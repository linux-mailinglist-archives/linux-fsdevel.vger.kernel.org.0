Return-Path: <linux-fsdevel+bounces-18390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754A8B83D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 02:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44171C22A53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCC54A33;
	Wed,  1 May 2024 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="b1HtNJ/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXc5Mihb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424A3C2D;
	Wed,  1 May 2024 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525058; cv=none; b=NHemKu0TYm3ZvV9jYimARadpiJGVMzkLhRsKH2AmYOibe1E7+YP5Wln5niW5X19R1O31jvMK0MeRkWbCtPg1W5wPy9jDZemujjZ7DNb3Yza+vn4xBSQ4lQZZujsh7IjuL1zORTzv4rKjnYhh1hcWcCHLyj1uVZHy8jUQwptZTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525058; c=relaxed/simple;
	bh=reEeNmziMfu5rQF5xy2fSjx78vbueVeqXA3WI2UJX5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cDLa9VJomSD72pDxcOQ3RTVKhuAz6Dz2vPH+ddCgHLIBePlBdZDJc/9DWHGuMvubn/cban/HIu2aToz9rRd5PTkNVeRsYTgqE6WeZT8SXkGXoi9cwKx3BiUS8EFvAP5zPsggXRBo0YciaOQ63ojTJOh+nTOBjGm6wQ96cMrKX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=b1HtNJ/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXc5Mihb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0C3DD138036F;
	Tue, 30 Apr 2024 20:57:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Apr 2024 20:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1714525055; x=1714611455; bh=gf
	4sMwiU3gI4LNCj1Fws8B0WP2UU7j8pjYnr1OUUkow=; b=b1HtNJ/lvIB/EZi54i
	7nj/QfPgzJZnhUc/ZdA2Gs356edAl0Uvr3LS1coj8BP90T/fRuuzQr/KdxDPVmNR
	wbpVkWrZPImraJoyaU1ECPYOo7B+GvyOMQR9pl99alDD+VIEY5MdnK6TbbY3lDin
	yzSbUR07ts4zh7WIGYFPW02TUzj3So/yqxTPQIJPelVFS4fZskhK/PQpQVtl5SfO
	gMhHGjYh+oxmobGJhVUMU5lNR3FxYVehLhl8cVaME4u7+EY9B8zDXqkl7+jX+u3W
	1lUBPxQUfTlMyQPd1RtD2z7zhoQ4iukoM+/hw9hOFiVAOUhxKk2/TEXveqDDufAP
	bsZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714525055; x=1714611455; bh=gf4sMwiU3gI4L
	NCj1Fws8B0WP2UU7j8pjYnr1OUUkow=; b=JXc5MihbiWYIWrMqumtjJp93bxcaG
	CS3cttR4C4Bxqi4Wb4oMlTgcZeFMoT8CAMKU4pUc4AtPUmJIRDbFfRYCEzrHAwu4
	S7XfCCmzWTNRVX+/LQtdp0Co7W48YzD2wHF9m6aWn4NFyiDkhC2exrOMp8kchmPJ
	2hVbwht/Y6NDxzWxvGrjCARm3wM8l5F1TlVdj/5wTHMpeYWlM9n5bjlom8qcT6nz
	Hcx/BkYTzbC0sMR00OsDFBvtUzBaZY9Dnin3spc2PpOLfUn7Qsq2i1m2ZOl4feqg
	A/aZnUseYNPJkRrs4nlZ+tHvbHqzurPjdnN03EipXvrAT/t4QySDQWKjA==
X-ME-Sender: <xms:fpMxZhd0nxmxwdEs8_3Qc0TfDuSbv6ka7bLGDSkg7qjmg_a-SxbH5g>
    <xme:fpMxZvMzW2pnmM_0cyunQ6x0KMKW81vYLoa1TgyDvuXA35So9i0wNJOvBAd_4akWN
    j88n7cyIDJqESTqgs4>
X-ME-Received: <xmr:fpMxZqjI5c7LWsgCkeRuakfs3l-fGmC0zmuJ5jXN9g73mKUqNsJkS97Jlz4PQIdo3v6hhRm6etYG35Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpedtkeffhedvuddtueevieejfffghedvvdeuleefgfduudetteegheekueejffejjeen
    ucffohhmrghinhepsghrohhkvgdrnhgvthdpfhhigigvugdrnhgvthdpghhithhhuhgsrd
    gtohhmpdhsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:fpMxZq_L4HljRVyjXdZiJKYceFMNpUwwk3N89aJLPsiyioowYr65WQ>
    <xmx:fpMxZtu3TZ9ZB11v8cNMsLQAq5jD9yazD_XQOuELpbLkicXDWMURkg>
    <xmx:fpMxZpGmEJBkQf7QhhIUs-T8vKva6rvP5AlDjA379-tZRVcjUzgUog>
    <xmx:fpMxZkPDBgs4FtSb3BPMtFmQDE-nbFIcJKE_Ilc5KE42CRxYG5ckXA>
    <xmx:fpMxZpF_0c0Uc3yahTQwsag52yUYM36qefpTjUJ4cN2GLg1OsbsC54Fu>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 20:57:33 -0400 (EDT)
From: Tyler Hicks <code@tyhicks.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	Kevin Parsons <parsonskev@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH] proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation
Date: Tue, 30 Apr 2024 19:56:46 -0500
Message-Id: <20240501005646.745089-1-code@tyhicks.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>

The following commits loosened the permissions of /proc/<PID>/fdinfo/
directory, as well as the files within it, from 0500 to 0555 while also
introducing a PTRACE_MODE_READ check between the current task and
<PID>'s task:

 - commit 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
 - commit 1927e498aee1 ("procfs: prevent unprivileged processes accessing fdinfo dir")

Before those changes, inode based system calls like inotify_add_watch(2)
would fail when the current task didn't have sufficient read permissions:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0500, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

This matches the documented behavior in the inotify_add_watch(2) man
page:

 ERRORS
       EACCES Read access to the given file is not permitted.

After those changes, inotify_add_watch(2) started succeeding despite the
current task not having PTRACE_MODE_READ privileges on the target task:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = 1757
 openat(AT_FDCWD, "/proc/1/task/1/fdinfo",
	O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = -1 EACCES (Permission denied)
 [...]

This change in behavior broke .NET prior to v7. See the github link
below for the v7 commit that inadvertently/quietly (?) fixed .NET after
the kernel changes mentioned above.

Return to the old behavior by moving the PTRACE_MODE_READ check out of
the file .open operation and into the inode .permission operation:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

Reported-by: Kevin Parsons (Microsoft) <parsonskev@gmail.com>
Link: https://github.com/dotnet/runtime/commit/89e5469ac591b82d38510fe7de98346cce74ad4f
Link: https://stackoverflow.com/questions/75379065/start-self-contained-net6-build-exe-as-service-on-raspbian-system-unauthorizeda
Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Cc: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Hardik Garg <hargar@linux.microsoft.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Signed-off-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
---
 fs/proc/fd.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6e72e5ad42bc..f4b1c8b42a51 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -74,7 +74,18 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int proc_fdinfo_access_allowed(struct inode *inode)
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, seq_show, inode);
+}
+
+/**
+ * Shared /proc/pid/fdinfo and /proc/pid/fdinfo/fd permission helper to ensure
+ * that the current task has PTRACE_MODE_READ in addition to the normal
+ * POSIX-like checks.
+ */
+static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
+				  int mask)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -88,18 +99,13 @@ static int proc_fdinfo_access_allowed(struct inode *inode)
 	if (!allowed)
 		return -EACCES;
 
-	return 0;
+	return generic_permission(idmap, inode, mask);
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return single_open(file, seq_show, inode);
-}
+static const struct inode_operations proc_fdinfo_file_inode_operations = {
+	.permission	= proc_fdinfo_permission,
+	.setattr	= proc_setattr,
+};
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
@@ -388,6 +394,8 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	ei = PROC_I(inode);
 	ei->fd = data->fd;
 
+	inode->i_op = &proc_fdinfo_file_inode_operations;
+
 	inode->i_fop = &proc_fdinfo_file_operations;
 	tid_fd_update_inode(task, inode, 0);
 
@@ -407,23 +415,13 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 				  proc_fdinfo_instantiate);
 }
 
-static int proc_open_fdinfo(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
+	.permission	= proc_fdinfo_permission,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
-	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,
-- 
2.34.1


