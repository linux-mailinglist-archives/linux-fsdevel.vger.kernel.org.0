Return-Path: <linux-fsdevel+bounces-36087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE859DB7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FEA163C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7C1A38F9;
	Thu, 28 Nov 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg8Ui2vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559A1A0BFB;
	Thu, 28 Nov 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797243; cv=none; b=gp966veJe0ayjXDWZMrmiouSN54GokTz7jyqmAbEckN9fQKebEq1ZK2hbLJSML3TLDl7kivKJX5QAUEOtPbJmHcvgJDKlo7IU0SzYNDqSl6BLBkOkD8gwYQb+Se0/bCJPSSgmouR9MoRllNQAipZ4KWekSG0omgxy8K//eCDTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797243; c=relaxed/simple;
	bh=HAYaEoVjvWbntGUR0s2suQ4eX4W+jvLGqpIIHjucj7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbEa3s4+2IFd61bnVJHzLpN43dKjWE0ASuxnUVAelzv030KJEc/nxvaQONZFIENxcw5KGEQ/s5kBMUFK7/NP7TtwGlEpFFevMl5Ih5Qd6TRqfdCkSbuwbfpDTdCtVno58rt1VGmuuFfEJRiaeHp70D7KTJ2UvciDifihATABnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg8Ui2vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6477C4CED8;
	Thu, 28 Nov 2024 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797243;
	bh=HAYaEoVjvWbntGUR0s2suQ4eX4W+jvLGqpIIHjucj7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dg8Ui2vvECnyUNPY0Zedq62r4EWwAto31b5E4cvXwJFrTGSWSRI/Jkk5/paHBTl7d
	 EyYp7VnpTEHmLpCBZ/hlHe8QwpWXikst2iYrd/CqdNw3C0N+LMBBugCcr2Drc4q9gP
	 0Sk4ZDEEzQfKfsRC0kuBe4aUmLm7FwYF6YvrHJtAi3eAT+MA8sqkBQGCxTee/3iHJb
	 Kzr4HDL38KK93kTMxRJ1CGbtlrGpuaMs4lo+ZscfbNjpr68kFILnwHZsd2O7nQlcn5
	 n80o1YZMr35qSJ96BdlJx4x3mT9HA7eSzFywZnwtODFBu1GSBjvdINJ/CJ+gvGLwg/
	 AyilFiHDKSC/g==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/2] pidfs: rework inode number allocation
Date: Thu, 28 Nov 2024 13:33:37 +0100
Message-ID: <20241128-work-pidfs-v1-1-80f267639d98@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
References: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6059; i=brauner@kernel.org; h=from:subject:message-id; bh=HAYaEoVjvWbntGUR0s2suQ4eX4W+jvLGqpIIHjucj7c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7JKvMkXmnvMOxqap849FXtzNnrmFcEDrTJfn6O6tbr UpV2ZeXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk7haGfwbfOA+HutmxFRps j57NHHE7Lq9TYMnkgx/3eT66ZhSR9p3hf6zQ01+Cwkp6aSKh7zYvPzBZ6lnxEdG85KauDg/Vsh5 edgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Recently we received a patchset that aims to enable file handle encoding
and decoding via name_to_handle_at(2) and open_by_handle_at(2).

A crucical step in the patch series is how to go from inode number to
struct pid without leaking information into unprivileged contexts. The
issue is that in order to find a struct pid the pid number in the
initial pid namespace must be encoded into the file handle via
name_to_handle_at(2). This can be used by containers using a separate
pid namespace to learn what the pid number of a given process in the
initial pid namespace is. While this is a weak information leak it could
be used in various exploits and in general is an ugly wart in the design.

To solve this problem a new way is needed to lookup a struct pid based
on the inode number allocated for that struct pid. The other part is to
remove the custom inode number allocation on 32bit systems that is also
an ugly wart that should go away.

So, a new scheme is used that I was discusssing with Tejun some time
back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
are used for the generation number. This gives a 64 bit inode number
that is unique on both 32 bit and 64 bit. The lower 32 bit number is
recycled slowly and can be used to lookup struct pids.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c            | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h |  2 ++
 kernel/pid.c          | 11 +++---
 3 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 618abb1fa1b84cf31282c922374e28d60cd49d00..09a0c8ac805301927a94758b3f7d1e513826daf9 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -23,6 +23,88 @@
 #include "internal.h"
 #include "mount.h"
 
+static u32 pidfs_ino_highbits;
+static u32 pidfs_ino_last_ino_lowbits;
+
+static DEFINE_IDR(pidfs_ino_idr);
+
+static inline ino_t pidfs_ino(u64 ino)
+{
+	/* On 32 bit low 32 bits are the inode. */
+	if (sizeof(ino_t) < sizeof(u64))
+		return (u32)ino;
+
+	/* On 64 bit simply return ino. */
+	return ino;
+}
+
+static inline u32 pidfs_gen(u64 ino)
+{
+	/* On 32 bit the generation number are the upper 32 bits. */
+	if (sizeof(ino_t) < sizeof(u64))
+		return ino >> 32;
+
+	/* On 64 bit the generation number is 1. */
+	return 1;
+}
+
+/*
+ * Construct an inode number for struct pid in a way that we can use the
+ * lower 32bit to lookup struct pid independent of any pid numbers that
+ * could be leaked into userspace (e.g., via file handle encoding).
+ */
+int pidfs_add_pid(struct pid *pid)
+{
+	u32 ino_highbits;
+	int ret;
+
+	ret = idr_alloc_cyclic(&pidfs_ino_idr, pid, 1, 0, GFP_ATOMIC);
+	if (ret >= 0 && ret < pidfs_ino_last_ino_lowbits)
+		pidfs_ino_highbits++;
+	ino_highbits = pidfs_ino_highbits;
+	pidfs_ino_last_ino_lowbits = ret;
+	if (ret < 0)
+		return ret;
+
+	pid->ino = (u64)ino_highbits << 32 | ret;
+	pid->stashed = NULL;
+	return 0;
+}
+
+void pidfs_remove_pid(struct pid *pid)
+{
+	idr_remove(&pidfs_ino_idr, (u32)pidfs_ino(pid->ino));
+}
+
+/* Find a struct pid based on the inode number. */
+static __maybe_unused struct pid *pidfs_ino_get_pid(u64 ino)
+{
+	ino_t pid_ino = pidfs_ino(ino);
+	u32 gen = pidfs_gen(ino);
+	struct pid *pid;
+
+	guard(rcu)();
+
+	/* Handle @pid lookup carefully so there's no risk of UAF. */
+	pid = idr_find(&pidfs_ino_idr, (u32)ino);
+	if (!pid)
+		return NULL;
+
+	if (sizeof(ino_t) < sizeof(u64)) {
+		if (gen && pidfs_gen(pid->ino) != gen)
+			pid = NULL;
+	} else {
+		if (pidfs_ino(pid->ino) != pid_ino)
+			pid = NULL;
+	}
+
+	/* Within our pid namespace hierarchy? */
+	if (pid_vnr(pid) == 0)
+		pid = NULL;
+
+	return get_pid(pid);
+}
+
 #ifdef CONFIG_PROC_FS
 /**
  * pidfd_show_fdinfo - print information about a pidfd
@@ -491,6 +573,16 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 
 void __init pidfs_init(void)
 {
+	/*
+	 * On 32 bit systems the lower 32 bits are the inode number and
+	 * the higher 32 bits are the generation number. The starting
+	 * value for the inode number and the generation number is one.
+	 */
+	if (sizeof(ino_t) < sizeof(u64))
+		pidfs_ino_highbits = 1;
+	else
+		pidfs_ino_highbits = 0;
+
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 75bdf9807802a5d1a9699c99aa42648c2bd34170..2958652bb108b8a2e02128e17317be4545b40a01 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -4,5 +4,7 @@
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
+int pidfs_add_pid(struct pid *pid);
+void pidfs_remove_pid(struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 115448e89c3e9e664d0d51c8d853e8167ba0540c..9f321c6456d24af705c28f0256ca4de771f5e681 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -64,11 +64,6 @@ int pid_max = PID_MAX_DEFAULT;
 
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
-/*
- * Pseudo filesystems start inode numbering after one. We use Reserved
- * PIDs as a natural offset.
- */
-static u64 pidfs_ino = RESERVED_PIDS;
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -157,6 +152,7 @@ void free_pid(struct pid *pid)
 		}
 
 		idr_remove(&ns->idr, upid->nr);
+		pidfs_remove_pid(pid);
 	}
 	spin_unlock_irqrestore(&pidmap_lock, flags);
 
@@ -276,8 +272,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
-	pid->stashed = NULL;
-	pid->ino = ++pidfs_ino;
+	retval = pidfs_add_pid(pid);
+	if (retval)
+		goto out_unlock;
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);

-- 
2.45.2


